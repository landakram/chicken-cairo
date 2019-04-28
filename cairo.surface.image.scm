(module cairo.surface.image
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

(defs
  (surface image-surface-create format int int)
  (surface image-surface-create-for-data c-pointer format int int int)
  (c-pointer image-surface-get-data surface)
  (format image-surface-get-format surface)
  (int image-surface-get-width surface)
  (int image-surface-get-height surface)
  (int image-surface-get-stride surface))

)
