;; Cairo vector graphics bindings for Chicken Scheme
;
; Copyright (C) 2004, 2005 Michael Bridgen <mikeb@squaremobius.net>,
;                          Tony Garnock-Jones <tonyg@kcbbs.gen.nz>
;
; This library is free software; you can redistribute it and/or modify
; it under the terms of the GNU Library General Public License as
; published by the Free Software Foundation; either version 2 of the
; License, or (at your option) any later version.
;
; This library is distributed in the hope that it will be useful, but
; WITHOUT ANY WARRANTY; without even the implied warranty of
; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
; Library General Public License for more details.
;
; You should have received a copy of the GNU Library General Public
; License along with this library; if not, write to the Free
; Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307
; USA

; --------------------------------------------------

(module cairo ()


(import scheme
        (chicken base)
        (chicken foreign)
        (chicken blob))

(foreign-declare "#include \"cairo.h\"")

(include "types.scm")


;; Text extents

(export make-text-extents-type)
(export text-extents-x-bearing)
(export text-extents-y-bearing)
(export text-extents-width)
(export text-extents-height)
(export text-extents-x-advance)
(export text-extents-y-advance)

(export text-extents-x-bearing-set!)
(export text-extents-y-bearing-set!)
(export text-extents-width-set!)
(export text-extents-height-set!)
(export text-extents-x-advance-set!)
(export text-extents-y-advance-set!)

(define-foreign-variable sizeof-text-extents int "sizeof(cairo_text_extents_t)")

;; TODO: I think we could use define-foreign-record-type here.
;;
;; We want a garbage-collectable type here; wrap a record type around a byte
;; vector buffer, and make chicken type-pun the buffer to the C struct.
;; We only ever construct these to hand to a function for filling in, so no
;; initialisation needed aside from the buffer.
(define-record text-extents-type buffer)
(let ((maker make-text-extents-type))
  (set! make-text-extents-type
    (lambda () (maker (make-blob sizeof-text-extents)))))

(define-record-printer (text-extents-type te out)
  (for-each (lambda (x) (display x out))
            (list "#<text-extents "
                  (text-extents-x-bearing te)" "
                  (text-extents-y-bearing te)" "
                  (text-extents-width te)" "
                  (text-extents-height te)" "
                  (text-extents-x-advance te)" "
                  (text-extents-y-advance te)">")))

(define-foreign-type text_extents_t scheme-pointer text-extents-type-buffer)

(define text-extents-x-bearing (foreign-lambda* double ((text_extents_t te)) "C_return(((cairo_text_extents_t*)te)->x_bearing);"))
(define text-extents-y-bearing (foreign-lambda* double ((text_extents_t te)) "C_return(((cairo_text_extents_t*)te)->y_bearing);"))
(define text-extents-width (foreign-lambda* double ((text_extents_t te)) "C_return(((cairo_text_extents_t*)te)->width);"))
(define text-extents-height (foreign-lambda* double ((text_extents_t te)) "C_return(((cairo_text_extents_t*)te)->height);"))
(define text-extents-x-advance (foreign-lambda* double ((text_extents_t te)) "C_return(((cairo_text_extents_t*)te)->x_advance);"))
(define text-extents-y-advance (foreign-lambda* double ((text_extents_t te)) "C_return(((cairo_text_extents_t*)te)->y_advance);"))

(define text-extents-x-bearing-set! (foreign-lambda* double ((text_extents_t te) (double v)) "((cairo_text_extents_t*)te)->x_bearing = v;"))
(define text-extents-y-bearing-set! (foreign-lambda* double ((text_extents_t te) (double v)) "((cairo_text_extents_t*)te)->y_bearing = v;"))
(define text-extents-width-set! (foreign-lambda* double ((text_extents_t te) (double v)) "((cairo_text_extents_t*)te)->width = v;"))
(define text-extents-height-set! (foreign-lambda* double ((text_extents_t te) (double v)) "((cairo_text_extents_t*)te)->height = v;"))
(define text-extents-x-advance-set! (foreign-lambda* double ((text_extents_t te) (double v)) "((cairo_text_extents_t*)te)->x_advance = v;"))
(define text-extents-y-advance-set! (foreign-lambda* double ((text_extents_t te) (double v)) "((cairo_text_extents_t*)te)->y_advance = v;"))


;; Font Extents

(export make-font-extents-type)
(export font-extents-ascent)
(export font-extents-descent)
(export font-extents-height)
(export font-extents-max-x-advance)
(export font-extents-max-y-advance)

(export font-extents-ascent-set!)
(export font-extents-descent-set!)
(export font-extents-height-set!)
(export font-extents-max-x-advance-set!)
(export font-extents-max-y-advance-set!)


(define-foreign-variable sizeof-font-extents int "sizeof(cairo_font_extents_t)")

;; TODO: I think we could use define-foreign-record-type here.
(define-record font-extents-type buffer)
(let ((maker make-font-extents-type))
  (set! make-font-extents-type
    (lambda () (maker (make-blob sizeof-font-extents)))))

(define-record-printer (font-extents-type e out)
  (for-each (lambda (x) (display x out))
            (list "#<font-extents "
                  (font-extents-ascent e)" "
                  (font-extents-descent e)" "
                  (font-extents-height e)" "
                  (font-extents-max-x-advance e)" "
                  (font-extents-max-y-advance e)">")))

(define-foreign-type font_extents_t scheme-pointer font-extents-type-buffer)

(define font-extents-ascent (foreign-lambda* double ((font_extents_t e)) "C_return(((cairo_font_extents_t*)e)->ascent);"))
(define font-extents-descent (foreign-lambda* double ((font_extents_t e)) "C_return(((cairo_font_extents_t*)e)->descent);"))
(define font-extents-height (foreign-lambda* double ((font_extents_t e)) "C_return(((cairo_font_extents_t*)e)->height);"))
(define font-extents-max-x-advance (foreign-lambda* double ((font_extents_t e)) "C_return(((cairo_font_extents_t*)e)->max_x_advance);"))
(define font-extents-max-y-advance (foreign-lambda* double ((font_extents_t e)) "C_return(((cairo_font_extents_t*)e)->max_y_advance);"))

(define font-extents-ascent-set! (foreign-lambda* double ((font_extents_t e) (double v)) "((cairo_font_extents_t*)e)->ascent = v;"))
(define font-extents-descent-set! (foreign-lambda* double ((font_extents_t e) (double v)) "((cairo_font_extents_t*)e)->descent = v;"))
(define font-extents-height-set! (foreign-lambda* double ((font_extents_t e) (double v)) "((cairo_font_extents_t*)e)->height = v;"))
(define font-extents-max-x-advance-set! (foreign-lambda* double ((font_extents_t e) (double v)) "((cairo_font_extents_t*)e)->max_x_advance = v;"))
(define font-extents-max-y-advance-set! (foreign-lambda* double ((font_extents_t e) (double v)) "((cairo_font_extents_t*)e)->max_y_advance = v;"))

;; Context procedures
;; -----------------------------------------------

(defs
  (context create surface)
  (void destroy! context)
  (status status context)
  (void save! context)
  (void restore! context)
  (surface get-target context)
  (void push-group! context)
  (void push-group-with-content! context content)
  (pattern pop-group! context)
  (void pop-group-to-source! context)
  (surface get-group-target context)
  (void set-source-rgb! context double double double)
  (void set-source-rgba! context double double double double)
  (void set-source! context pattern)
  (void set-source-surface! context surface double double)
  (pattern get-source context)
  (void set-antialias! context antialias)
  (antialias get-antialias context)
  (void set-dash! context f64vector int double) ;; TODO better
  (int get-dash-count context)
  #; (void get-dash context f64vector (c-pointer double)) ;; TODO multiple return values
  (void set-fill-rule! context fill-rule)
  (fill-rule get-fill-rule context)
  (void set-line-cap! context line-cap)
  (line-cap get-line-cap context)
  (void set-line-join! context line-join)
  (line-join get-line-join context)
  (void set-line-width! context double)
  (double get-line-width context)
  (void set-miter-limit! context double)
  (double get-miter-limit context)
  (void set-operator! context operator)
  (operator get-operator context)
  (void set-tolerance! context double)
  (double get-tolerance context)
  (void clip! context)
  (void clip-preserve! context)
  #;(void clip-extents context double double double double) ;; TODO multiple return values
  (bool in-clip? context double double)
  (void reset-clip! context)
  #;(void rectangle-list-destroy! rectangle-list) ;; TODO rectangle-list
  #;(rectangle-list copy-clip-rectangle-list context) ;; TODO rectangle-list
  (void fill! context)
  (void fill-preserve! context)
  #;(void fill-extents context double double double double) ;; TODO multiple return values
  (bool in-fill? context double double)
  (void mask! context pattern)
  (void mask-surface! context surface double double)
  (void paint! context)
  (void paint-with-alpha! context double)
  (void stroke! context)
  (void stroke-preserve! context)
  #;(void stroke-extents context double double double double) ;; TODO multiple return values
  (bool in-stroke? context double double)
  (void copy-page! context)
  (void show-page! context)
  )


;; Paths procedures
;; -----------------------------------------------

(defs
  (path copy-path context) ;; TODO Path datatype
  (path copy-path-flat context)
  (void path-destroy! path) ;; TODO Path datatype
  (void append-path! context path) ;; TODO Path datatype
  (bool has-current-point? context)
  #;(void get-current-point context double double) ;; TODO multiple return values
  (void new-path! context)
  (void new-sub-path! context)
  (void close-path! context)
  (void arc! context double double double double double)
  (void arc-negative! context double double double double double)
  (void curve-to! context double double double double double double)
  (void line-to! context double double)
  (void move-to! context double double)
  (void rectangle! context double double double double)
  #;(void glyph-path! context glyph int) ;; TODO glyph
  (void text-path! context c-string)
  (void rel-curve-to! context double double double double double double)
  (void rel-line-to! context double double)
  (void rel-move-to! context double double)
  #;(void path-extents context double double double double) ;; TODO multiple return values
  )


;; Surface procedures
;; -----------------------------------------------

(defs
  (surface surface-create-similar surface content int int)
  (surface surface-create-similar-image surface format int int)
  (surface surface-create-for-rectangle surface double double double double)
  (void surface-destroy! surface)
  (status surface-status surface)
  (void surface-finish! surface)
  (void surface-flush! surface)
  (device surface-get-device surface)
  #;(void surface-get-font-options surface font-options) ;; TODO return value
  (content surface-get-content surface)
  (void surface-mark-dirty! surface)
  (void surface-mark-dirty-rectangle! surface int int int int)
  (void surface-set-device-offset! surface double double)
  #;(void surface-get-device-offset surface double double) ;; TODO multiple return values
  #;(void surface-get-device-scale surface double double) ;; TODO multiple return values
  (void surface-set-device-scale! surface double double)
  (void surface-set-fallback-resolution! surface double double)
  #;(void surface-get-fallback-resolution surface double double) ;; TODO multiple return values
  (surface-type surface-get-type surface)
  (void surface-copy-page! surface)
  (void surface-show-page! surface)
  (bool surface-has-show-text-glyphs? surface)
  #;(status surface-set-mime-data! surface c-string blob long …) ;; TODO function pointer
  #;(void surface-get-mime-data surface c-string c-pointer long) ;; TODO multiple return values
  (bool surface-supports-mime-type? surface c-string)
  #;(surface surface-map-to-image! surface rectangle-int) ;; TODO rectangle-int
  (void surface-unmap-image! surface surface)
  )


;; Patterns procedures
;; -----------------------------------------------

(defs
  (pattern pattern-create-radial double double double double double double)
  (pattern pattern-create-mesh)
  (void pattern-destroy! pattern)
  (void pattern-add-color-stop-rgb! pattern double double double double)
  (void pattern-add-color-stop-rgba! pattern double double double double double)
  (void mesh-pattern-begin-patch! pattern)
  (void mesh-pattern-end-patch! pattern)
  (void mesh-pattern-move-to! pattern double double)
  (void mesh-pattern-line-to! pattern double double)
  (void mesh-pattern-curve-to! pattern double double double double double double)
  (void mesh-pattern-set-corner-color-rgb! pattern unsigned-int double double double)
  (void mesh-pattern-set-corner-color-rgba! pattern unsigned-int double double double double)
  (void pattern-set-extend! pattern extend))


;; Transformations procedures
;; -----------------------------------------------

(defs
  (void translate! context double double)
  (void scale! context double double)
  (void rotate! context double)
  (void identity-matrix context)
  
  )


;; Text procedures
;; -----------------------------------------------

(defs
  (void select-font-face! context c-string font-slant font-weight)
  (void set-font-size! context double)
  (void set-font-matrix! context matrix)
  (void show-text! context c-string)
  (void font-extents context font_extents_t)
  (void text-extents context c-string text_extents_t)
  (void set-font-options! context font-options)
  (void font-options-set-antialias! font-options antialias)
  (void font-options-set-hint-style! font-options hint-style)
  (void font-options-set-hint-metrics! font-options hint-metrics))


;; Font face procedures
;; -----------------------------------------------

(defs
  (void font-face-destroy! font-face)
  (status font-face-status font-face)
  (font-type font-face-get-type font-face)
  (font-options font-options-create)
  (font-face get-font-face context)
  
  )

)