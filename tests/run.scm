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

(define s (svg-surface-create "schotter.svg" 842 1190))
(define c (create s))

;; use millimeters as units from here on
(scale! c (/ 72 25.4) (/ 72 25.4))
(set-source-rgba! c 1 0 0 1)

(dotimes (y *height*)
  (dotimes (x *width*)
    (save! c)
    (set-line-width! c .3)
    (translate! c (+ 12 (* x *box-size*)) (+ 16 (* y *box-size*)))
    (rotate! c (* (if (> 1 (pseudo-random-integer 2)) -1 1)
                       (/ pi 180)
                       (* *rotation*  (pseudo-random-real))))
    (rectangle! c 0 0 *box-size* *box-size*)
    (set-source-rgba! c 0 0 0 1)
    (stroke! c)
    (restore! c))
  (set! *rotation* (+ *rotation* *delta*)))

(surface-show-page! s)
(destroy! c)
(surface-finish! s)
(surface-destroy! s)
