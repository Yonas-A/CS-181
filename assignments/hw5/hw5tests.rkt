#lang racket

(require "hw5.rkt")

; This file uses Racket's unit-testing framework, which is convenient but not required of you.

; Note we have provided [only] 3 tests, but you can't run them until do some of the assignment.
; You will want more tests.

(define racketlist->mupllist-test (racketlist->mupllist (list 1 2 3 4) ))

(define mupllist->racketlist-test 
  (mupllist->racketlist (apair 1 (apair 2 (apair 3 (apair 4 (munit))))) ))

(require rackunit)

(define tests
  (test-suite
   "Homework 5 Tests"

    ; problem 1 tests
    (check-equal? (racketlist->mupllist (list (int 1) (int 2))) (apair (int 1) (apair (int 2) munit)) "racketlist->mupllist test")

    (check-equal? (mupllist->racketlist (apair (int 1) (apair (int 2) (munit)))) (list (int 1) (int 2)) "racketlist->mupllist test")

    ; problem 2 tests
    (check-equal? (eval-exp (add (int 2) (int 2))) (int 4) "add simple test")

    (check-equal? (eval-exp (isgreater (int 3) (int 4))) (int 0) "isgreater test")

    (check-equal? (eval-exp (isgreater (int 4) (int 3))) (int 1) "isgreater test")

    (check-equal? (eval-exp (ifnz (int 1) (int 2) (int 3))) (int 2) "ifnz test")

    (check-equal? (eval-exp (ifnz (add (int 0) (int 0)) (int 2) (int 3))) (int 3) "ifnz test")

    (check-equal? (eval-exp (ifnz (add (mlet "v" (int 5) (var "v")) (int -5)) (int 2) (int 3))) (int 3) "ifnz test")


    (check-equal? (eval-exp (call (closure '() (fun #f "x" (add (var "x") (int 7)))) (int 1))) (int 8) "call test")

    (check-equal? (eval-exp (call (closure '() (fun #t "x" (isgreater (var "x") (var "x")))) (int 1))) (int 0) "call test")

    (check-equal? (eval-exp (call (closure '() (fun #t "x" (ifnz (add (mlet "v" (int 5) (var "v")) (int -5)) (int 2) (int 3)))) (munit))) (int 3) "call test")


    (check-equal? (eval-exp (mlet "v" (int 1) (add (var "v") (int 10)))) (int 11) "mlet test")

    (check-equal? (eval-exp (apair (int 1) (int 20))) (apair (int 1) (int 20))  "apair test")

    (check-equal? (eval-exp (first (apair (int 1) (apair (int 1) (int 2))))) (int 1) "first test")
    
    (check-equal? (eval-exp (first (apair (int 1) (int 2)))) (int 1) "first test")
   
    (check-equal? (eval-exp (second (apair (int 1) (int 2)))) (int 2) "second test")

    (check-equal? (eval-exp (second (apair (int 1) (apair (int 1) (int 2))))) (apair (int 1) (int 2)) "second test")

    (check-equal? (eval-exp (ismunit (munit))) (int 1) "ismunit test")
    
    (check-equal? (eval-exp (ismunit (closure '() (fun #t "test" (add (var "x") (int 2)))))) (int 0) "ismunit test")
    
    (check-equal? (eval-exp (munit))  (munit) "munit test")


    ; problem 3 tests
    (check-equal? (eval-exp (ifmunit (int 1) (int 2) (int 3))) (int 3) "ifmunit test")

    (check-equal? (eval-exp (ifeq (int 1) (int 1) (int 3) (int 4))) (int 3) "ifeq test")

    (check-equal? (eval-exp (ifeq (int 1) (int 2) (int 3) (add (int 4) (int 5)))) (int 9) "ifeq test")
        

    (check-exn (lambda (x) (string=? (exn-message x) "MUPL addition applied to non-number"))
                (lambda () (eval-exp (add (int 2) (munit))))
                "add bad argument")

    ;;; (check-equal? (mupllist->racketlist
    ;;;                 (eval-exp (call (call mupl-all-gt (int 9))
    ;;;                                 (racketlist->mupllist 
    ;;;                                 (list (int 10) (int 9) (int 15))))))
    ;;;               (list (int 10) (int 15))
    ;;;               "provided combined test using problems 1, 2, and 4")
  ))

(require rackunit/text-ui)
;; runs the test
(run-tests tests)
