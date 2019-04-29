(import scheme
        (chicken base)
        (chicken random)
        miscmacros
        cairo
        cairo.surface.svg)

(import (chicken process-context))

(define *rotation* 0)
(define *delta* 2.7)
(define *width* 18)
(define *height* 26)
(define *box-size* 15)

(define s (cairo-svg-surface-create "schotter.svg" 842 1190))
(define c (cairo-create s))

;; use millimeters as units from here on
(cairo-scale c (/ 72 25.4) (/ 72 25.4))
(cairo-set-source-rgba c 1 0 0 1)

(dotimes (y *height*)
  (dotimes (x *width*)
    (cairo-save c)
    (cairo-set-line-width c .3)
    (cairo-translate c (+ 12 (* x *box-size*)) (+ 16 (* y *box-size*)))
    (cairo-rotate c (* (if (> 1 ( pseudo-random-integer 2)) -1 1)
                       (/ cairo-pi 180)
                       (* *rotation*  (pseudo-random-real))))
    (cairo-rectangle c 0 0 *box-size* *box-size*)
    (cairo-set-source-rgba c 0 0 0 1)
    (cairo-stroke c)
    (cairo-restore c))
  (set! *rotation* (+ *rotation* *delta*)))

(cairo-surface-show-page s)
(cairo-destroy c)
(cairo-surface-finish s)
(cairo-surface-destroy s)
