
#lang racket

(provide (all-defined-out)) ;; so we can put tests in a second file

;; put your code below

; 1
(define (sequence spacing low high)
  (if (> low high )
    null
    (cons low (sequence spacing (+ low spacing) high ))))

; 2
(define (string-append-map xs suffix)
  (map ( lambda (str) (string-append str suffix)) xs ) )

; 3
(define (list-nth-mod xs n)
  (cond [(< n 0) (display "error \"list-nth-mod: negative number\"")]
        [(null? xs) (display "error \"list-nth-mod: empty list\"")]
        [#t (list-ref xs (remainder n (length xs)))]))

;5
(define funny-number-stream
  (letrec ([f (lambda (x) 
                (cons (if (= 0 (modulo x 6)) (- 0 x) x) 
                  (lambda () (f (+ (if (< x 0) (- 0 x) x) 1)))))])
    (lambda () (f 1)))) 


; 6
(define manu-then-dog
  (letrec ([f (lambda (x) 
                (cons x (lambda () (f (if (string=? x "dog.jpg") "manu.jpg" "dog.jpg")))))])
    (lambda () (f "manu.jpg"))))

; 7
(define (stream-add-one s)
  (letrec ([f (lambda (x)
                (lambda () (cons (cons 1 (car (x))) (f (cdr (x))))))])
    (f s)))

; 8
(define (cycle-lists xs ys)
	(letrec([f (lambda (x) 
              (lambda () (cons (cons (list-nth-mod xs x) 
                    (list-nth-mod ys x)) (f (+ x 1)) )))])
  	(f 0)))