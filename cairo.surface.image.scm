(module cairo.surface.image
*
(import scheme)
(import chicken.base)
(import chicken.foreign)

(foreign-declare "#include \"cairo.h\"")

(include "types.scm")

(defs
  (surface image-surface-create format int int)
  (surface image-surface-create-for-data c-pointer format int int int)
  (surface image-surface-create-from-png c-string)
  (c-pointer image-surface-get-data surface)
  (format image-surface-get-format surface)
  (int image-surface-get-width surface)
  (int image-surface-get-height surface)
  (int image-surface-get-stride surface))
)
