(module cairo.surface.svg
*
(import scheme)
(import chicken.base)
(import chicken.foreign)

(foreign-declare "#include \"cairo.h\"")
(foreign-declare "#include \"cairo-svg.h\"")

(include "types.scm")

(defs
  (surface svg-surface-create c-string double double))
)
