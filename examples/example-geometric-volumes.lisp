(in-package :first-light.example)

;;; Prefabs

(fl:define-prefab "geometric-volumes" (:library examples)
  (("camera" :copy "/cameras/perspective"))
  (("plane" :copy "/mesh")
   (fl.comp:transform :rotate/inc (m:vec3 1)
                      :scale (m:vec3 6)))
  (("cube" :copy "/mesh")
   (fl.comp:transform :translate (m:vec3 0 30 0)
                      :rotate/inc (m:vec3 1)
                      :scale (m:vec3 6))
   (fl.comp:mesh :location '((:core :mesh) "cube.glb")))
  (("sphere" :copy "/mesh")
   (fl.comp:transform :translate (m:vec3 0 -30 0)
                      :rotate/inc (m:vec3 1)
                      :scale (m:vec3 6))
   (fl.comp:mesh :location '((:core :mesh) "sphere.glb")))
  (("torus" :copy "/mesh")
   (fl.comp:transform :translate (m:vec3 30 0 0)
                      :rotate/inc (m:vec3 1)
                      :scale (m:vec3 6))
   (fl.comp:mesh :location '((:core :mesh) "torus.glb")))
  (("cone" :copy "/mesh")
   (fl.comp:transform :translate (m:vec3 -30 0 0)
                      :rotate/inc (m:vec3 1)
                      :scale (m:vec3 6))
   (fl.comp:mesh :location '((:core :mesh) "cone.glb"))
   (fl.comp:render :material 'fl.materials:unlit-texture-decal-bright)))
