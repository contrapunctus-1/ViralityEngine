(in-package #:virality-examples)

;;; Textures

(v:define-texture 1d-gradient
    (:texture-1d x/tex:clamp-all-edges)
  (:data #((:texture-example "texture-gradient-1d.png"))))

(v:define-texture 2d-wood
    (:texture-2d x/tex:clamp-all-edges)
  (:data #((:texture-example "wood.png"))))

(v:define-texture 3d
    (:texture-3d x/tex:clamp-all-edges)
  ;; TODO: Currently, these are the only valid origin and slices values. They
  ;; directly match the default of opengl.
  (:layout `((:origin :left-back-bottom)
             (:shape (:slices :back-to-front))))
  ;; TODO: Maybe I shuld implement pattern specification of mipmaps.
  (:data #(#((:3d "slice_0-mip_0.png")
             (:3d "slice_1-mip_0.png")
             (:3d "slice_2-mip_0.png")
             (:3d "slice_3-mip_0.png")
             (:3d "slice_4-mip_0.png")
             (:3d "slice_5-mip_0.png")
             (:3d "slice_6-mip_0.png")
             (:3d "slice_7-mip_0.png"))
           #((:3d "slice_0-mip_1.png")
             (:3d "slice_1-mip_1.png")
             (:3d "slice_2-mip_1.png")
             (:3d "slice_3-mip_1.png"))
           #((:3d "slice_0-mip_2.png")
             (:3d "slice_1-mip_2.png"))
           #((:3d "slice_0-mip_3.png")))))

(v:define-texture 1d-array
    (:texture-1d-array x/tex:clamp-all-edges)
  ;; If there are multiple images in each list, they are mipmaps. Since this is
  ;; a test, each mip_0 image is 8 width x 1 height
  (:data #(#((:1da "redline-mip_0.png")
             (:1da "redline-mip_1.png")
             (:1da "redline-mip_2.png")
             (:1da "redline-mip_3.png"))
           #((:1da "greenline-mip_0.png")
             (:1da "greenline-mip_1.png")
             (:1da "greenline-mip_2.png")
             (:1da "greenline-mip_3.png"))
           #((:1da "blueline-mip_0.png")
             (:1da "blueline-mip_1.png")
             (:1da "blueline-mip_2.png")
             (:1da "blueline-mip_3.png"))
           #((:1da "whiteline-mip_0.png")
             (:1da "whiteline-mip_1.png")
             (:1da "whiteline-mip_2.png")
             (:1da "whiteline-mip_3.png")))))

(v:define-texture 2d-array
    (:texture-2d-array x/tex:clamp-all-edges)
  ;; Since this is a test, each mip_0 image is 1024x1024 and has 11 mipmaps.
  (:data #(#((:2da "bluefur-mip_0.png")
             (:2da "bluefur-mip_1.png")
             (:2da "bluefur-mip_2.png")
             (:2da "bluefur-mip_3.png")
             (:2da "bluefur-mip_4.png")
             (:2da "bluefur-mip_5.png")
             (:2da "bluefur-mip_6.png")
             (:2da "bluefur-mip_7.png")
             (:2da "bluefur-mip_8.png")
             (:2da "bluefur-mip_9.png")
             (:2da "bluefur-mip_10.png"))
           #((:2da "bark-mip_0.png")
             (:2da "bark-mip_1.png")
             (:2da "bark-mip_2.png")
             (:2da "bark-mip_3.png")
             (:2da "bark-mip_4.png")
             (:2da "bark-mip_5.png")
             (:2da "bark-mip_6.png")
             (:2da "bark-mip_7.png")
             (:2da "bark-mip_8.png")
             (:2da "bark-mip_9.png")
             (:2da "bark-mip_10.png"))
           #((:2da "rock-mip_0.png")
             (:2da "rock-mip_1.png")
             (:2da "rock-mip_2.png")
             (:2da "rock-mip_3.png")
             (:2da "rock-mip_4.png")
             (:2da "rock-mip_5.png")
             (:2da "rock-mip_6.png")
             (:2da "rock-mip_7.png")
             (:2da "rock-mip_8.png")
             (:2da "rock-mip_9.png")
             (:2da "rock-mip_10.png"))
           #((:2da "wiggles-mip_0.png")
             (:2da "wiggles-mip_1.png")
             (:2da "wiggles-mip_2.png")
             (:2da "wiggles-mip_3.png")
             (:2da "wiggles-mip_4.png")
             (:2da "wiggles-mip_5.png")
             (:2da "wiggles-mip_6.png")
             (:2da "wiggles-mip_7.png")
             (:2da "wiggles-mip_8.png")
             (:2da "wiggles-mip_9.png")
             (:2da "wiggles-mip_10.png")))))

(v:define-texture cubemap (:texture-cube-map)
  (:data
   ;; TODO: Only :six (individual images) is supported currently.
   #(((:layout :six) ;; :equirectangular, :skybox, etc, etc.
      #((:+x #((:cubemap "right-mip_0.png")))
        (:-x #((:cubemap "left-mip_0.png")))
        (:+y #((:cubemap "top-mip_0.png")))
        (:-y #((:cubemap "bottom-mip_0.png")))
        (:+z #((:cubemap "back-mip_0.png")))
        (:-z #((:cubemap "front-mip_0.png"))))))))

(v:define-texture cubemaparray (:texture-cube-map-array)
  (:data
   #(((:layout :six)
      #((:+x #((:cubemaparray "right-mip_0.png")))
        (:-x #((:cubemaparray "left-mip_0.png")))
        (:+y #((:cubemaparray "top-mip_0.png")))
        (:-y #((:cubemaparray "bottom-mip_0.png")))
        (:+z #((:cubemaparray "back-mip_0.png")))
        (:-z #((:cubemaparray "front-mip_0.png")))))
     ((:layout :six)
      #((:+x #((:cubemaparray "right-mip_0.png")))
        (:-x #((:cubemaparray "left-mip_0.png")))
        (:+y #((:cubemaparray "top-mip_0.png")))
        (:-y #((:cubemaparray "bottom-mip_0.png")))
        (:+z #((:cubemaparray "back-mip_0.png")))
        (:-z #((:cubemaparray "front-mip_0.png"))))))))

;;; Materials

(v:define-material 1d-gradient
  (:shader ex/shd:unlit-texture-1d
   :profiles (x/mat:u-mvp)
   :uniforms
   ((:tex.sampler1 '1d-gradient)
    (:mix-color (v4:vec 1)))))

(v:define-material 2d-wood
  (:shader shd/tex:unlit-texture
   :profiles (x/mat:u-mvp)
   :uniforms
   ((:tex.sampler1 '2d-wood)
    (:mix-color (v4:vec 1)))))

(v:define-material 3d
  (:shader ex/shd:unlit-texture-3d
   :profiles (x/mat:u-mvp)
   :uniforms
   ((:tex.sampler1 '3d)
    (:mix-color (v4:vec 1))
    (:uv-z (lambda (context material)
             (declare (ignore material))
             ;; make sin in the range of 0 to 1 for texture coord.
             (float (/ (1+ (sin (* (v:total-time context) 1.5))) 2.0) 1f0))))))

(v:define-material 1d-array
  (:shader ex/shd:unlit-texture-1d-array
   :profiles (x/mat:u-mvpt)
   :uniforms
   ((:tex.sampler1 '1d-array)
    (:mix-color (v4:vec 1))
    (:num-layers 4))))

(v:define-material 2d-array
  (:shader ex/shd:unlit-texture-2d-array
   :profiles (x/mat:u-mvpt)
   :uniforms
   ((:tex.sampler1 '2d-array)
    (:mix-color (v4:vec 1))
    (:uv-z (lambda (context material)
             (declare (ignore material))
             ;; make sin in the range of 0 to 1 for texture coord.
             (float (/ (1+ (sin (* (v:total-time context) 1.5))) 2.0) 1f0)))
    (:num-layers 4))))

(v:define-material 2d-sweep-input
  (:shader ex/shd:noise-2d/sweep-input
   :profiles (x/mat:u-mvp)
   :uniforms
   ;; any old 2d texture here will do since we overwrite it with noise.
   ((:tex.sampler1 '2d-wood)
    (:tex.channel0 (v2:vec))
    (:mix-color (v4:vec 1)))))

(v:define-material cubemap
  (:shader ex/shd:unlit-texture-cube-map
   :profiles (x/mat:u-mvp)
   :uniforms
   ((:tex.sampler1 'cubemap)
    (:mix-color (v4:vec 1)))))

(v:define-material cubemaparray
  (:shader ex/shd:unlit-texture-cube-map-array
   :profiles (x/mat:u-mvp)
   :uniforms
   ((:tex.sampler1 'cubemaparray)
    (:mix-color (v4:vec 1))
    (:cube-layer
     (lambda (context material)
       (declare (ignore material))
       ;; make sin in the range of 0 to 1 for texture coord.
       (float (/ (1+ (sin (* (v:total-time context) 1.5))) 2.0) 1f0)))
    (:num-layers 2))))

;;; Components

(v:define-component shader-sweep ()
  ((%renderer :reader renderer)
   (%material :reader material)
   (%material-retrieved-p :reader material-retrieved-p
                          :initform nil)
   (%channel0 :reader channel0
              :initform (v2:vec))))

(defmethod v:on-component-initialize ((self shader-sweep))
  (with-slots (%renderer) self
    (setf %renderer (v:component-by-type (v:actor self) 'comp:render))))

(defmethod v:on-component-update ((self shader-sweep))
  (with-slots (%material %material-retrieved-p) self
    (unless %material-retrieved-p
      (setf %material (comp:material (renderer self))
            %material-retrieved-p t))
    (u:mvlet* ((context (v:context self))
               (x y (v:get-mouse-position context)))
      (when (null x) (setf x (/ v:=window-width= 2f0)))
      (when (null y) (setf y (/ v:=window-height= 2f0)))
      (v2:with-components ((c (channel0 self)))
        ;; crappy, but good enough.
        (setf cx (float (/ x v:=window-width=) 1f0)
              cy (float (/ y v:=window-height=) 1f0)))
      ;; get a reference to the material itself (TODO: use MOP stuff to get
      ;; this right so I don't always have to get it here)
      (setf (v:uniform-ref %material :tex.channel0) (channel0 self)))))

;;; Prefabs

(v:define-prefab "texture" (:library examples :policy :new-type)
  (("camera" :copy "/cameras/perspective")
   (comp:camera (:policy :new-args) :zoom 6f0))
  (("1d-texture" :copy "/mesh")
   (comp:transform :translate (v3:vec -4f0 3f0 0f0))
   (comp:render :material '1d-gradient))
  (("2d-texture" :copy "/mesh")
   (comp:transform :translate (v3:vec -2f0 3f0 0f0))
   (comp:render :material '2d-wood))
  (("3d-texture" :copy "/mesh")
   (comp:transform :translate (v3:vec 0f0 3f0 0f0))
   (comp:render :material '3d))
  (("1d-array-texture" :copy "/mesh")
   (comp:transform :translate (v3:vec 2f0 3f0 0f0))
   (comp:render :material '1d-array))
  (("2d-array-texture" :copy "/mesh")
   (comp:transform :translate (v3:vec 4f0 3f0 0f0))
   (comp:render :material '2d-array))
  (("swept-input" :copy "/mesh")
   (comp:transform :translate (v3:vec -4f0 1f0 0f0))
   (comp:render :material '2d-sweep-input)
   (shader-sweep))
  (("cube-map" :copy "/mesh")
   (comp:transform :translate (v3:vec 0f0 -1f0 0f0)
                   :rotate (q:orient :world
                                     :x (float (asin (/ (sqrt 2))) 1f0)
                                     :z o:pi/4))
   (comp:mesh :asset '(:virality/mesh "primitives.glb")
              :name "cube")
   (comp:render :material 'cubemap))
  (("cube-map-array" :copy "/mesh")
   (comp:transform :translate (v3:vec 3f0 -1f0 0f0)
                   :rotate/velocity (o:make-velocity (v3:vec 1) o:pi))
   (comp:mesh :asset '(:virality/mesh "primitives.glb")
              :name "cube")
   (comp:render :material 'cubemaparray)))