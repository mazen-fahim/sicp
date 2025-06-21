 #lang sicp
(+ 42
   (* 3 2))
; Define/Name a procedure
;(define (square x)
;  (* x x))
; To be clear that we are naming something
; lmabda is the wat to construct a procedure
(define square (lambda (x) (* x x)))
(define A (* 2 2))
(square A)
; So we have named a procedure square just as
; we have named a combination as A

; All of this (lambda (x) (* x x)) is simply lisp's way
; of expressing the idea of a procedure. It's a syntax
; that expresses a more fundemental idea, the same
; as 3 expresses the idea of the number three
(define (average x y)
  (/ (+ x y) 2))
(define (mean-square x y)
  (average (square x)
           (square y)))

; mean-square is made out of average and square procedures
; so we can combine smaller black boxes to implement bigger
; boxes.

; since we have defined square we can use it simply as
; a primitive. because there is no difference if you think
; about. there is no difference between things already
; builin in the language and things that you define and
; name

; you shouldn't be able to tell things that you have
; already built-in and things that you define.

(define (abs x)
  (cond ((< x 0) (- x)) ; conditional clause
        ((= x 0) 0)
        ((> x 0) x)))
;           ^      ^
;       predicate  action








