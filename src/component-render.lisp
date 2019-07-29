(in-package #:first-light.components)

(define-component render ()
  ((%mode :reader mode
          :initarg :mode
          :initform :mesh)
   (%draw-method :reader draw-method
                 :initform (constantly nil))
   (%transform :reader transform)
   (%material :accessor material
              :initarg :material
              :annotation (fl.annotations:material))))

(defun set-draw-method (render)
  (with-slots (%draw-method) render
    (let ((instances (instances (material render))))
      (setf %draw-method
            (ecase (mode render)
              (:mesh
               (lambda ()
                 (draw-mesh
                  (actor-component-by-type (actor render) 'mesh)
                  instances)))
              (:sprite
               (lambda ()
                 (draw-sprite
                  (actor-component-by-type (actor render) 'sprite)
                  instances))))))))

(defmethod on-component-initialize ((self render))
  (with-slots (%transform) self
    (setf %transform (actor-component-by-type (actor self) 'transform))
    (set-draw-method self)))

(defmethod on-component-render ((self render))
  (a:when-let ((camera (active-camera (context self))))
    (using-material (material self)
        (:model (fl.comp:model (transform self))
         :view (fl.comp:view camera)
         :proj (fl.comp:projection camera))
      (funcall (draw-method self)))))