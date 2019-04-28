(module cairo.surface.svg
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

 (foreign-declare "#include \"cairo.h\"")
 (foreign-declare "#include \"cairo-svg.h\"")

 (include "types.scm")

(defs
  (surface svg-surface-create c-string double double))
)
