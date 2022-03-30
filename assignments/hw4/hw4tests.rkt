#lang racket

(require "hw4.rkt") 

;; A simple library for displaying a 2x3 grid of pictures: used
;; for fun in the tests below (look for "Tests Start Here").

(require (lib "graphics.rkt" "graphics"))

(open-graphics)

(define window-name "Programming Languages, Homework 4")
(define window-width 700)
(define window-height 500)
(define border-size 100)

(define approx-pic-width 200)
(define approx-pic-height 200)
(define pic-grid-width 3)
(define pic-grid-height 2)

(define (open-window)
  (open-viewport window-name window-width window-height))

(define (grid-posn-to-posn grid-posn)
  (when (>= grid-posn (* pic-grid-height pic-grid-width))
    (error "picture grid does not have that many positions"))
  (let ([row (quotient grid-posn pic-grid-width)]
        [col (remainder grid-posn pic-grid-width)])
    (make-posn (+ border-size (* approx-pic-width col))
               (+ border-size (* approx-pic-height row)))))

(define (place-picture window filename grid-posn)
  (let ([posn (grid-posn-to-posn grid-posn)])
    ((clear-solid-rectangle window) posn approx-pic-width approx-pic-height)
    ((draw-pixmap window) filename posn)))

(define (place-repeatedly window pause stream n)
  (when (> n 0)
    (let* ([next (stream)]
           [filename (cdar next)]
           [grid-posn (caar next)]
           [stream (cdr next)])
      (place-picture window filename grid-posn)
      (sleep pause)
      (place-repeatedly window pause stream (- n 1)))))

;; Tests Start Here

; These definitions will work only after you do some of the problems
; so you need to comment them out until you are ready.
; Add more tests as appropriate, of course.

(define nums (sequence 1 0 5))
(define sequence-test1 (sequence 2 3 11))
(define sequence-test2 (sequence 2 3 8))
(define sequence-test3 (sequence 1 3 2))

(define files (string-append-map 
               (list "manu" "dog" "curry" "dog2") 
               ".jpg"))

(define string-append-map-test1 (string-append-map '("hi" "bye") "2") )
(define string-append-map-test2 (string-append-map '("hi" "bye") "2") )

(nth-mod (list ) 0)
(list-nth-mod (list ) 0)
(nth-mod (list "e" "f" "1" 2) -2)
(list-nth-mod (list "e" "f" "1" 2 ) -2)
(nth-mod (list "a" "b" "C" "D" "e" "f" "1" 2 3 4 9) 0)
(list-nth-mod (list "a" "b" "C" "D" "e" "f" "1" 2 3 4 9) 0)
(nth-mod (list "h" "i" "j" "k" "l" "m") 7)
(list-nth-mod (list "h" "i" "j" "k" "l" "m") 7)

(define list-nth-mod1 (list-nth-mod '(1 2 3 4 5 6 7 8 ) 3) )
(define list-nth-mod2 (list-nth-mod '("a" "b" "C" "D" "e" "f" "1" 2 3 4) 9))

(define manu-then-dog-test1(car (manu-then-dog)))
(car ((cdr (manu-then-dog))))
(car ((cdr ((cdr (manu-then-dog))))))
(car ((cdr ((cdr ((cdr(manu-then-dog))))))))
(car ((cdr ((cdr ((cdr ((cdr(manu-then-dog))))))))))
(car ((cdr ((cdr ((cdr ((cdr ((cdr(manu-then-dog))))))))))))


;(define funny-test (stream-for-k-steps funny-number-stream 16))

; a zero-argument function: call (one-visual-test) to open the graphics window, etc.
(define (one-visual-test)
 (place-repeatedly (open-window) 0.5 (cycle-lists nums files) 27))

; similar to previous but uses only two files and one position on the grid
(define (visual-one-only)
  (place-repeatedly (open-window) 0.5 (stream-add-one manu-then-dog) 27))

  