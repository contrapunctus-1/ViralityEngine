(in-package :defpackage+-user-1)

(defpackage+ #:fl.psilord
  (:use #:cl
        #:fl.core
        #:fl.comp.mesh-renderer)
  (:export-only #:demo
                #:material-test))

(defpackage+ #:fl.psilord.shaders
  (:use #:cl #:shadow)
  (:inherit #:box.math.vari #:vari)
  (:export-only #:sprite-shader))

(defpackage+ #:fl.psilord.materials
  (:use #:cl #:shadow)
  (:import-from #:fl.core
                #:define-material)
  (:export-only #:sprite))

(defpackage+ #:fl.psilord.textures
  (:use #:cl #:shadow)
  (:import-from #:fl.core
                #:define-texture
                #:general-data-format-descriptor)
  (:export-only #:sprite-sheet-00))
