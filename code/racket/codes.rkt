#lang racket

;Part 1
;1
(define (greater-by-one-list xs)
  (map (lambda (x) (+ 1 x)) xs))

(define (greater-by-one-list xs) 
 (if (null? xs)
      xs
      (cons (+ 1 (car xs)) (greater-by-one-list (cdr xs)))))

;2
(define (increase-by-one xs)
  (cond [(null? xs) null]
        [#t (begin (increase-by-one (mcdr xs))
                   (set-mcar! xs (+ (mcar xs) 1)))]))


;3
(define silly-previous
  (let ([prev 0])
    (lambda (x) (let ([res prev])
                  (begin (set! prev x) res)))))


;4
(define silly-only-unique
  (let ([prev null])
    (lambda (x)
      (if (member x prev)
          (error "silly-only-unique: value used previously")
          (begin (set! prev (cons x prev)) x)))))


;Part Two
(define factorial
  (letrec ([memo (list (cons 0 1))]
           [f (lambda (x)
                (let ([ans (assoc x memo)])
                  (if ans
                      (cdr ans)
                      (let ([new-ans (* x (f (- x 1)))])
                        (begin
                          (set! memo (cons (cons x new-ans) memo))
                          new-ans)))))])
    f))


; Part Three
;1
(define powers-of-two
  (letrec ([next-thunk (lambda (x)
                         (cons x (lambda () (next-thunk (* x 2)))))])
    (lambda () (next-thunk 1))))

;2
(define (zero-through-n n)
  (letrec ([next-thunk (lambda (x)
                         (cons (modulo x (+ n 1))
                               (lambda () (next-thunk (+ x 1)))))])
    (lambda () (next-thunk 0))))

;3
(define (get-ith s i)
  (if (= i 0)
      (car (s))
      (get-ith (cdr (s)) (- i 1))))

;4
(define (stream-maker init fn)
  (letrec ([next-thunk (lambda (x)
                         (cons x (lambda () (next-thunk (fn x)))))])
    (lambda () (next-thunk init))))

;5
(define powers-of-two2 (stream-maker 1 (lambda (x) (* x 2))))

