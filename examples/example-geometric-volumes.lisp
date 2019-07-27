(in-package #:first-light.example)

;;; Prefabs

(fl:define-prefab "geometric-volumes" (:library examples)
  (("camera" :copy "/cameras/perspective"))
  (("plane" :copy "/mesh")
   (fl.comp:transform :rotate/inc (q:orient :local (v3:one) pi)
                      :scale (v3:make 6 6 6)))
  (("cube" :copy "/mesh")
   (fl.comp:transform :translate (v3:make 0 30 0)
                      :rotate/inc (q:orient :local (v3:one) pi)
                      :scale (v3:make 6 6 6))
   (fl.comp:static-mesh :location '((:core :mesh) "cube.glb")))
  (("sphere" :copy "/mesh")
   (fl.comp:transform :translate (v3:make 0 -30 0)
                      :rotate/inc (q:orient :local (v3:one) pi)
                      :scale (v3:make 6 6 6))
   (fl.comp:static-mesh :location '((:core :mesh) "sphere.glb")))
  (("torus" :copy "/mesh")
   (fl.comp:transform :translate (v3:make 30 0 0)
                      :rotate/inc (q:orient :local (v3:one) pi)
                      :scale (v3:make 6 6 6))
   (fl.comp:static-mesh :location '((:core :mesh) "torus.glb")))
  (("cone" :copy "/mesh")
   (fl.comp:transform :translate (v3:make -30 0 0)
                      :rotate/inc (q:orient :local (v3:one) pi)
                      :scale (v3:make 6 6 6))
   (fl.comp:static-mesh :location '((:core :mesh) "cone.glb"))
   (fl.comp:render :material 'fl.materials:unlit-texture-decal-bright)))

;;; Prefab descriptors

(fl:define-prefab-descriptor geometric-volumes ()
  ("geometric-volumes" fl.example:examples))
