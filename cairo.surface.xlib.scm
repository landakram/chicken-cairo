(module cairo.surface.xlib
*
(import scheme)
(import chicken.base)
(import chicken.foreign)

(foreign-declare "#include \"cairo.h\"")
(foreign-declare "#include \"cairo-xlib.h\"")

(include "types.scm")

(define-foreign-type display (c-pointer "Display"))
(define-foreign-type drawable unsigned-int32)
(define-foreign-type visual (c-pointer "Visual"))

(defs
  (surface xlib-surface-create display drawable visual int int)
  (void xlib-surface-set-size surface int int)
  (display xlib-surface-get-display surface))
)
