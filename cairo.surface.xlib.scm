(module cairo.surface.xlib
 *

(import scheme)
(import chicken.base)
(import chicken.foreign)
(import chicken.memory)
(import chicken.format)
(import srfi-1 srfi-4)

(import chicken.syntax)
(import-for-syntax chicken.string)
(import-for-syntax srfi-1 srfi-13 srfi-14)

(include "types.scm")
(foreign-declare "#include \"cairo.h\"")
(foreign-declare "#include \"cairo-xlib.h\"")

(define-foreign-type display (c-pointer "Display"))
(define-foreign-type drawable unsigned-int32)
(define-foreign-type visual (c-pointer "Visual"))

(defs
  (surface xlib-surface-create display drawable visual int int)
  (void xlib-surface-set-size surface int int)
  (display xlib-surface-get-display surface))

)
