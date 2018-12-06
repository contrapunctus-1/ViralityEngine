(in-package :defpackage+-user-1)

(defpackage+ #:%first-light
  (:nicknames #:%fl)
  (:use #:cl)
  ;; common
  (:export #:cameras
           #:cfg
           #:core-state
           #:define-settings
           #:display
           #:find-resource
           #:id
           #:rcache
           #:rcache-construct
           #:rcache-dispose
           #:rcache-lookup
           #:rcache-remove
           #:shared-storage
           #:start-engine
           #:stop-engine
           #:user-package
           #:window
           #:with-cfg
           #:with-shared-storage)
  ;; resources
  (:export #:define-resources)
  ;; extensions
  (:export #:extension-file-type
           #:prepare-extension)
  ;; context
  (:export #:active-camera
           #:context
           #:project-data
           #:delta
           #:epilogue
           #:frame-time
           #:prologue
           #:settings
           #:shared-storage-table
           #:ss-href
           #:total-time)
  ;; textures
  (:export #:define-texture
           #:define-texture-profile
           #:general-data-format-descriptor
           #:load-texture)
  ;; materials
  (:export #:bind-material
           #:copy-material
           #:define-material
           #:define-material-profile
           #:lookup-material
           #:mat-computed-uniform-ref
           #:mat-uniform-ref
           #:shader
           #:using-material)
  ;; shaders
  (:export #:define-shader)
  ;; input
  (:export #:get-gamepad-analog
           #:get-gamepad-name
           #:get-mouse-position
           #:get-mouse-scroll
           #:input-enabled-p
           #:input-enter-p
           #:input-exit-p)
  ;; transform-state
  (:export #:make-transform-state
           #:transform-state-scalar
           #:transform-state-vector
           #:transform-state-quaternion
           #:current
           #:incremental
           #:incremental-delta
           #:previous
           #:interpolated
           #:interpolate-state)
  ;; scene
  (:export #:define-scene)
  ;; actor
  (:export #:actor
           #:attach-component
           #:attach-multiple-components
           #:detach-component
           #:make-actor
           #:spawn-actor)
  ;; components
  (:export #:actor-component-by-type
           #:actor-components-by-type
           #:component
           #:define-component
           #:destroy-component
           #:initialize-component
           #:make-component
           #:physics-update-component
           #:render-component
           #:shared-storage-metadata
           #:state
           #:update-component)
  ;; annotation API
  (:export #:define-annotation)
  ;; deploying binaries
  (:export #:deploy-binary))

(defpackage+ #:fl.assets
  (:use #:cl #:%fl)
  (:export-only #:load-mesh
                #:draw-func))

(defpackage+ #:fl.shaders
  (:use #:%fl)
  (:inherit #:shadow.vari)
  (:export-only #:unlit-color
                #:unlit-color-decal
                #:unlit-texture
                #:unlit-texture-decal))

(defpackage+ #:fl.materials
  (:use #:cl #:%fl)
  ;; helper functions
  (:export #:total-time/uniform)
  ;; profiles
  (:export #:u-model
           #:u-mvp
           #:u-mvpt
           #:u-proj
           #:u-time
           #:u-view
           #:u-vp
           #:u-vpt)
  ;; materials
  (:export #:missing-material
           #:unlit-color
           #:unlit-color-decal
           #:unlit-texture
           #:unlit-texture-decal
           #:unlit-texture-decal-bright))

(defpackage+ #:fl.textures
  (:use #:cl #:%fl)
  ;; profiles
  (:export #:default-profile
           #:clamp-all-edges
           ;; TODO: exploratory framebuffer support
           #:framebuffer)
  ;; textures
  (:export #:debug-texture
           #:missing-texture
           ;; TODO: Exploratory framebuffer support
           #:framebuffer-color
           #:framebuffer-depth
           #:framebuffer-stencil
           #:framebuffer-depth/stencil
           ))

(defpackage+ #:fl.annotations
  (:use #:cl #:%fl)
  (:export-only #:material))
