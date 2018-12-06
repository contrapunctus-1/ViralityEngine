(in-package :fl.mfiano)

;;;; This code is all a rough sketch about how to do your shader method and
;;;; implement a sprite sheet. This component is very inefficient cause shared
;;;; storage needs some more work--each instance has a vao/vbo, etc,
;;;; etc. Animations are specified clunkily, but are servicable.

(defclass sprite-sheet-animations ()
  ((%animvec :reader animvec
             :initarg :animvec
             :initform nil)
   (%elapsed-time :accessor elapsed-time
                  :initarg :elapsed-time
                  :initform 0.0)
   (%cell-time :accessor cell-time
               :initarg :cell-time)
   (%current-cell :accessor current-cell
                  :initarg :current-cell)
   (%current-animation :accessor current-animation
                       :initarg :current-animation)))

(defun make-sprite-sheet-animations (current-animation current-cell animation-vector)
  (let ((cell-time (/ (aref (aref animation-vector current-animation) 0)
                      (1- (length (aref animation-vector current-animation))))))
    (make-instance 'sprite-sheet-animations
                   :animvec animation-vector
                   :current-animation current-animation
                   :cell-time cell-time
                   :current-cell current-cell)))

(define-component sprite-sheet ()
  (;; Where this will be drawn, gotten from the actor on which this component is placed.
   (transform :default nil)
   ;; The description where things are in the sprite sheet.
   (spec-resource-id :default nil)
   ;; The actual specification form from the above file.
   (spec :default nil)
   ;; material describing the specific sprite sheet I want.
   (material :default nil
             :annotation (fl.annotations:material))
   ;; The ssbo buffer reference (possibly shared between instances).
   (ssbo-buffer :default nil)
   ;; The empty vao we create and draw
   (vao-id :default nil)
   ;; The integral location of the sprite suitable for the shader to draw it.
   (sprite :default nil)
   ;; mapping from sprite names to integral locations "ship33" -> 373 (actual
   ;; number may be different)
   (sprites :default (au:dict #'equalp))
   ;; DB of animations and the cells involved in them.
   (animations :default nil))

  ;; Shared storage definitions.
  (;; Key: spec-resource-id location tuple,
   ;; Value: buffer-name of created buffer to hold it
   (:ssbo/specification-data equal)
   ))

(defun make-sprite-sheet-buffer (sprite-sheet context)
  ;; 1. I know the block-alias I need is:
  ;; 'fl.mfiano.materials:ssbo/specification-data
  ;; since I wrote it in the material definition.
  ;; The material itself performed the creation of the above alias.

  ;; 2. create a buffer which must be unique for all buffers of the same spec.
  (with-shared-storage
      (context context)
      ((ssbo/spec-data ssbo-presentp
                       ;; Which type storage to look at
                       ('sprite-sheet
                        ;; which shared-storage namespace
                        :ssbo/specification-data
                        ;; the key(s) to look up.
                        (spec-resource-id sprite-sheet))

                       ;; If not present insert result of this
                       ;; form at that above key into shared storage.
                       (shadow:create-buffer
                        (gensym
                         (symbol-name :sprite-sheet-buffer))
                        'fl.mfiano.materials:ssbo/specification-data)))

    ;; Store a reference to the (possibly shared) buffer.
    (setf (ssbo-buffer sprite-sheet) ssbo/spec-data)

    ;; When ssbo-presentp is NIL, it means the cache was ust populated by the
    ;; required buffer, so we need to initialize it.
    (unless ssbo-presentp
      ;; 3. only a single instance should fill the GPU buffer appropriately the
      ;; first time it is created.
      (loop :with length = (length (spec sprite-sheet))
            :with xs = (make-array length :element-type 'single-float)
            :with ys = (make-array length :element-type 'single-float)
            :with ws = (make-array length :element-type 'single-float)
            :with hs = (make-array length :element-type 'single-float)
            :for sprite :in (spec sprite-sheet)
            :for i :from 0
            :do (destructuring-bind (&key id x y w h) sprite
                  (when (and id x y w h)
                    (setf (aref xs i) x
                          (aref ys i) y
                          (aref ws i) w
                          (aref hs i) h)))
            :finally
               (shadow:write-buffer-path
                (shadow:buffer-name ssbo/spec-data) :x xs)
               (shadow:write-buffer-path
                (shadow:buffer-name ssbo/spec-data) :y ys)
               (shadow:write-buffer-path
                (shadow:buffer-name ssbo/spec-data) :w ws)
               (shadow:write-buffer-path
                (shadow:buffer-name ssbo/spec-data) :h hs)))


    ;; Initialize the ids, we do this for each sprite-sheet instance we make
    ;; I could put this into a shared storage thing, but meh.
    ;; TODO: I should jam this into the shared storage too, since it is copied
    ;; for all sprite-sheets that use the same spec-resource-id.
    (loop :for sprite :in (spec sprite-sheet)
          :for i :from 0
          :do (destructuring-bind (&key id x y w h) sprite
                (when (and id x y w h)
                  (setf (au:href (sprites sprite-sheet) id) i))))


    ;; TODO: I hacked a 9 in here as the binding point. Needs FL support
    ;; to be auto allocated.
    (shadow:bind-block 'fl.mfiano.materials:ssbo/specification-data 9)))


(defun convert-current-sprite (sprite-sheet)
  "Convert the current-animation and current-cell into an integer and store it in the sprite sheet
for later use with the shaders."
  (with-slots (%animvec %current-animation %current-cell) (animations sprite-sheet)
    (setf (sprite sprite-sheet)
          (au:href (sprites sprite-sheet)
                   (aref (aref %animvec %current-animation) (1+ %current-cell))))))

(defmethod initialize-component ((sprite-sheet sprite-sheet) (context context))
  (with-slots (%spec-resource-id %spec %material %transform %vao-id) sprite-sheet
    (let ((path (find-resource context %spec-resource-id)))
      (setf %spec (au:safe-read-file-form path)
            %transform (actor-component-by-type (actor sprite-sheet) 'transform)
            %vao-id (gl:gen-vertex-array))
      (make-sprite-sheet-buffer sprite-sheet context)
      (convert-current-sprite sprite-sheet))))

(defun maybe-update-current-animation-cell (sprite-sheet frame-time)
  (with-slots (%elapsed-time %cell-time %current-animation %current-cell %animvec)
      (animations sprite-sheet)
    ;; NOTE: I didn't look too closely at my thinking for this algorithm, so the
    ;; time calculations could be a little off.

    ;; Add how much time went by in the frame.
    (incf %elapsed-time frame-time)
    ;; Then, see if we're past the cell-time
    (when (>= %elapsed-time %cell-time)
      ;; go to the next cell until we consume all of the elapsed time.
      (loop :until (< %elapsed-time %cell-time)
            :do (setf %current-cell
                      (mod (1+ %current-cell)
                           (1- (length (aref %animvec %current-animation)))))
                (decf %elapsed-time %cell-time)
                (when (zerop %elapsed-time)
                  (setf %elapsed-time 0)))
      ;; fixup the current cell to show.
      (convert-current-sprite sprite-sheet))))

(defmethod update-component ((sprite-sheet sprite-sheet) (context context))
  (maybe-update-current-animation-cell sprite-sheet (frame-time context)))

(defmethod render-component ((sprite-sheet sprite-sheet) (context context))
  (with-slots (%transform %material %sprite %vao-id) sprite-sheet
    (au:when-let ((camera (active-camera context)))

      ;; Bind the appropriate buffer associated with this specific sprite-sheet
      ;; to the shader block.
      (let ((ssbo/spec-data
              (ss-href context 'sprite-sheet :ssbo/specification-data
                       (spec-resource-id sprite-sheet))))
        (shadow:bind-buffer (shadow:buffer-name ssbo/spec-data) 9))

      (using-material %material
          (:model (fl.comp:model %transform)
           :view (fl.comp:view camera)
           :proj (fl.comp:projection camera)
           :tex.sprite %sprite)
        (gl:bind-vertex-array %vao-id)
        (gl:draw-arrays :points 0 1)))))
