(in-package :defpackage+-user-1)

(defpackage+ #:%first-light
  (:nicknames #:%fl)
  (:local-nicknames (#:m #:game-math))
  (:use #:cl)
  (:export
   #:active-camera
   #:actor
   #:actor-component-by-type
   #:actor-components-by-type
   #:attach-component
   #:attach-multiple-components
   #:cameras
   #:component
   #:compute-component-initargs
   #:context
   #:copy-material
   #:core-state
   #:define-annotation
   #:define-component
   #:define-graph
   #:define-material
   #:define-material-profile
   #:define-options
   #:define-resources
   #:define-texture
   #:define-texture-profile
   #:delta
   #:deploy-binary
   #:destroy
   #:detach-component
   #:find-resource
   #:frame-count
   #:frame-manager
   #:frame-time
   #:general-data-format-descriptor
   #:get-computed-component-precedence-list
   #:id
   #:input-data
   #:instances
   #:lookup-material
   #:make-actor
   #:make-component
   #:make-scene-tree
   #:mat-uniform-ref
   #:on-component-attach
   #:on-component-destroy
   #:on-component-detach
   #:on-component-initialize
   #:on-component-physics-update
   #:on-component-render
   #:on-component-update
   #:option
   #:prefab-node
   #:print-all-resources
   #:project-data
   #:scene-tree
   #:shader
   #:shared-storage
   #:spawn-actor
   #:ss-href
   #:start-engine
   #:state
   #:stop-engine
   #:total-time
   #:using-material
   #:with-shared-storage))
