(in-package :defpackage+-user-1)

(defpackage+ #:first-light.shaders
  (:nicknames #:fl.shaders)
  (:use #:%first-light)
  (:inherit #:fl.shaderlib.vari)
  (:export-only #:unlit-color
                #:unlit-color-decal
                #:unlit-texture
                #:unlit-texture-decal))
