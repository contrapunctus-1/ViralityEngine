(in-package #:virality.component)

(v:define-component sprite ()
  ((%name :accessor name
          :initarg :name
          :initform nil)
   (%spec :reader spec
          :initarg :spec
          :initform nil)
   (%spritesheet :reader spritesheet)
   (%index :reader index)
   (%initial-index :reader initial-index)
   (%frames :accessor frames
            :initarg :frames
            :initform 1)
   (%duration :reader duration
              :initarg :duration
              :initform 1)
   (%repeat :reader repeat
            :initarg :repeat
            :initform t)
   (%elapsed :reader elapsed
             :initform 0f0)
   (%pause :reader pause
           :initform nil))
  ((:cached-spritesheet-data equalp)))

(defmethod v:on-component-initialize ((self sprite))
  (with-slots (%name %spec %spritesheet %index %initial-index) self
    (let ((context (v:context self))
          (spec (a:ensure-list %spec)))
      (unless %name
        (error "A sprite component must have a name."))
      (unless spec
        (error "A sprite component must have a spritesheet spec specified."))
      (setf %spritesheet (v:make-spritesheet context %spec)
            %index (v:find-sprite %spritesheet %name)
            %initial-index %index))))

(defmethod v:on-component-update ((self sprite))
  (with-slots (%frames %index %initial-index %duration %repeat %elapsed %pause)
      self
    (unless %pause
      (incf %elapsed (v:frame-time (v:context self)))
      (if (>= %elapsed %duration)
          (setf %elapsed 0
                %index %initial-index
                %pause (unless %repeat t))
          (let* ((step (/ %elapsed %duration))
                 (min %initial-index)
                 (max (1- (+ min %frames)))
                 (index (floor (a:clamp (a:lerp step min (1+ max)) min max))))
            (setf %index index))))))

;; TODO: Fix after slave render system is in place.
(defun draw-sprite (sprite &optional count)
  (with-slots (%index %spritesheet) sprite
    (shadow:uniform-int 'umbra.sprite:sprite :sprite.index %index)
    (gl:bind-vertex-array (v::geometry %spritesheet))
    (gl:draw-arrays-instanced :triangle-strip 0 4 count)
    (gl:bind-vertex-array 0)))
#++(defmethod v:on-component-slave-render ((renderer render) (self sprite))
     (with-slots (%index %spritesheet) self
       (with-slots (%geometry) %spritesheet
         (shadow:uniform-int 'umbra.sprite:sprite :sprite.index %index)
         (gl:bind-vertex-array %geometry)
         (gl:draw-arrays-instanced :triangle-strip 0 4 count)
         (gl:bind-vertex-array 0))))
