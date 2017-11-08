(in-package :gear)

(defclass display (kit.sdl2:gl-window box.fm:frame-manager)
  ((core-state :reader core-state
               :initarg :core-state)
   (hz :reader hz
       :initarg :hz)))

(defun calculate-refresh-rate ()
  (let ((hz (nth-value 3 (sdl2:get-current-display-mode 0))))
    (if (zerop hz) 60 hz)))

(defgeneric make-display (core-state)
  (:method ((core-state core-state))
    (let ((context (context-table core-state))
          (hz (calculate-refresh-rate)))
      (setf (slot-value core-state '%display)
            (make-instance 'display
                           :core-state core-state
                           :title (cfg context :title)
                           :w (cfg context :width)
                           :h (cfg context :height)
                           :hz hz
                           :delta (cfg context :delta)
                           :period (cfg context :periodic-interval)
                           :debug-interval (cfg context :debug-frames-interval)))
      (slog:emit :display.init
                 (cfg context :width)
                 (cfg context :height)
                 hz))))

(defmethod make-display :before ((core-state core-state))
  (let ((context (context-table core-state)))
    (setf slog:*current-level* (cfg context :log-level))
    (dolist (attr `((:context-major-version ,(cfg context :gl-version-major))
                    (:context-minor-version ,(cfg context :gl-version-minor))
                    (:multisamplebuffers
                     ,(if (zerop (cfg context :anti-alias-level)) 0 1))
                    (:multisamplesamples ,(cfg context :anti-alias-level))))
      (apply #'sdl2:gl-set-attr attr))))

(defmethod make-display :after ((core-state core-state))
  (let ((context (context-table core-state)))
    (setf (kit.sdl2:idle-render (display core-state)) t)
    (apply #'gl:enable (cfg context :gl-capabilities))
    (apply #'gl:blend-func (cfg context :gl-blend-mode))
    (gl:depth-func (cfg context :gl-depth-mode))
    (sdl2:gl-set-swap-interval (if (cfg context :vsync) 1 0))))

(defmethod kit.sdl2:render ((display display))
  (gl:clear :color-buffer :depth-buffer)
  (execute-flow (core-state display)
                :default
                'perform-one-frame
                'entry/perform-one-frame
                :come-from-state-name :ef)
  ;; TODO: render pass
  nil)

(defmethod kit.sdl2:close-window :around ((display display))
  (let* ((context (context-table (core-state display)))
         (width (cfg context :width))
         (height (cfg context :height)))
    (call-next-method)
    (slog:emit :display.stop width height (hz display))))

(defmethod quit-engine ((display display))
  (let* ((context (context-table (core-state display)))
         (title (cfg context :title)))
    (kit.sdl2:close-window display)
    (kit.sdl2:quit)
    (slog:emit :engine.quit title)))