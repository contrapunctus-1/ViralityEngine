(in-package :fl.core)

(defmethod extension-file-type ((extension-type (eql :shader-stages)))
  "shd")

(defmethod prepare-extension ((extension-type (eql :shader-stages)) owner path)
  (load-extensions extension-type path))

(defmethod extension-file-type ((extension-type (eql :shader-programs)))
  "prog")

(defmethod prepare-extension ((extension-type (eql :shader-programs)) owner path)
  (shadow:reset-program-state)
  (load-extensions extension-type path))

;; NOTE: The returned function is called by the result of doing a C-c, which might be on a different
;; thread due to slynk, or anything else that forced recompilation of shader programs that happened
;; on a different thread. Then in core.flow, in the rendering thread, we dequeue the task and
;; perform the work. This allows us to A) schedule when the recompilation _actually_ happens, and B)
;; not have to worry about different threads making recompilation tasks.
(defun generate-shaders-modified-hook (core-state)
  (lambda (programs-list)
    (when (boundp '*core-state*)
      (simple-logger:emit :shader.programs.to.recompile programs-list)
      (enqueue-recompilation-task core-state
                                  :shader-recompilation
                                  programs-list))))

(defun recompile-shaders (programs-list)
  (shadow:translate-shader-programs programs-list)
  (shadow:build-shader-programs programs-list)
  (when programs-list
    (simple-logger:emit :shader.programs.recompiled programs-list)))

(defun prepare-shader-programs (core-state)
  (setf (shaders core-state) (shadow:build-shader-dictionary))
  (shadow:set-modify-hook (gen-shaders-modified-hook core-state)))

(defmacro define-shader (name (&key (version 330) (primitive :triangles)) &body body)
  `(progn
     (shadow:define-shader ,name (:version ,version :primitive ,primitive)
       ,@body)
     (export ',name)))
