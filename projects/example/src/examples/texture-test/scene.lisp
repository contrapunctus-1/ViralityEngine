(in-package :first-light.example)

(fl:define-scene texture-test ()
  (@camera
   ((fl.comp:transform :translation/current (flm:vec3 0 0 6))
    (fl.comp:camera :activep t :mode :perspective :fovy (* 90 (/ pi 180)))))

  (@plane/1d-texture
   ((fl.comp:transform :translation/current (flm:vec3 -4 3 0)
                       :rotation/incremental (flm:vec3)
                       :scale/current (flm:vec3 1))
    (fl.comp:mesh :location '((:core :mesh) "plane.glb"))
    (fl.comp:mesh-renderer :material 'texture-test/1d-gradient)))

  (@plane/2d-texture
   ((fl.comp:transform :translation/current (flm:vec3 -2 3 0)
                       :rotation/current (flm:vec3)
                       :scale/current (flm:vec3 1))
    (fl.comp:mesh :location '((:core :mesh) "plane.glb"))
    (fl.comp:mesh-renderer :material 'texture-test/2d-wood)))

  (@plane/3d-texture
   ((fl.comp:transform :translation/current (flm:vec3 -0 3 0)
                       :rotation/current (flm:vec3)
                       :scale/current (flm:vec3 1))
    (fl.comp:mesh :location '((:core :mesh) "plane.glb"))
    (fl.comp:mesh-renderer :material 'texture-test/3d-testpat)))

  (@plane/1d-array-texture
   ((fl.comp:transform :translation/current (flm:vec3 2 3 0)
                       :rotation/current (flm:vec3)
                       :scale/current (flm:vec3 1))
    (fl.comp:mesh :location '((:core :mesh) "plane.glb"))
    (fl.comp:mesh-renderer :material 'texture-test/1d-array-testpat)))

  (@plane/2d-array-texture
   ((fl.comp:transform :translation/current (flm:vec3 4 3 0)
                       :rotation/current (flm:vec3)
                       :scale/current (flm:vec3 1))
    (fl.comp:mesh :location '((:core :mesh) "plane.glb"))
    (fl.comp:mesh-renderer :material 'texture-test/2d-array-testarray)))

  (@plane/swept-input
   ((fl.comp:transform :translation/current (flm:vec3 -4 1 0)
                       :rotation/current (flm:vec3)
                       :scale/current (flm:vec3 1))
    (fl.comp:mesh :location '((:core :mesh) "plane.glb"))
    (fl.comp:mesh-renderer :material 'texture-test/2d-sweep-input)
    (shader-sweep)))

  (@cube/cube-map
   ((fl.comp:transform :translation/current (flm:vec3 0 -1 0)
                       :rotation/current (flm:vec3 0.5 0.5 0.5)
                       :scale/current (flm:vec3 1))
    (fl.comp:mesh :location '((:core :mesh) "cube.glb"))
    (fl.comp:mesh-renderer :material 'texture-test/testcubemap)))

  (@cube/cube-map-array
   ((fl.comp:transform :translation/current (flm:vec3 3 -1 0)
                       :rotation/incremental (flm:vec3 0.5 0.5 0.5)
                       :scale/current (flm:vec3 1))
    (fl.comp:mesh :location '((:core :mesh) "cube.glb"))
    (fl.comp:mesh-renderer :material 'texture-test/testcubemaparray))))
