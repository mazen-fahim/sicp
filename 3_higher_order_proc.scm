#lang sicp

; Sum a bunch of integers

(define (sum-int a b)
  (if (> a b)
      0
      (+ a (sum-int (+ a 1) b))))

; sum of squares
(define (sq a)
  (* a a))

(define (sum-sq a b)
  (if (> a b)
      0
      (+ (sq a) (sum-sq (+ a 1) b))))

; The previous two procedures are almost identical
; They only differ in a and (sq a)
; And The name (It doesn't really matter matter)

; Liebniz formula for finding pi / 8 which is also
; simply a series of addition.

; They all take this form
; (define (<name> a b)
;   (if (> a b)
;      0
;      ( + (<term> a)
;        (<name> (<next> a) b))))
; General definition of what a sigma is.
(define (sum term a next b)
  (if (> a b)
      0
      (+ (term a) (sum term
                       (next a)
                       next
                       b))))

; sum of a bunch of integers as an instance of a more general procedure definition
(define (sum-int-2 a b)
  (define (identity i)
    i)
  (define (next i)
    (+ i 1))
  (sum identity a next b))

(define (sum-sq-2 a b)
  (define (sq i)
    (* i i))
  (define (next i)
    (+ i 1))
  (sum sq a next b))

; note how we didn't really need to name the internal
; procedures needed by procedure sum. we don't have
; to name something that we won't referrence.
; I care about sum-pi the outter black box. I don't care
; about the mini boxex inside of it so I don't need to
; name them, I simply use lambda notation to define them.
(define (sum-pi a b)
  (sum (lambda i (/ i (* i (+ i 2))))
       a
       (lambda i (+ i 4))
       b))

; so in general procedures are used as arguments being passed
; around when you try to make a specific procedure instance from
; a more general one. (Think of it like this, the general one
; needs more information to make a more specific one.

; iterative implementation of sum
(define (sum-iter term a next b)
  (define (iter i s)
    (if (> i b)
        s
        (iter (next i) (+ (term i) s))))
  (iter a 0))

; when you are implementing a recursive procedure as iterative
; you need to bend your way of thinking a bit.

; 1. You need to define a complete explicit state that holds
;    all the information about the problem.
; 2. To do so we can't defer any operations later.
; 3. To do so also, you need to start from a state you know
;    the answer to, and start building your solution from there. don't
;    start from a bigger problem that you still don't know the answer
;    to and divide into smaller sub-problems until you hit the base
;    case like you do in recursion, but start from the base case
;    and build up the solution to the bigger problem.


; the procedures can be named, so they can be passed around. they
; are simply variables holding procedure objects.

;(define (sqrt x)
  (fixed-point (lambda y (average (/ x y) y))
               1))

(define (fiexed-point f start)
  (define (iter old new)
    (if (close-enough? old new)
        new
        (iter new (f new))))
  (iter start (f start)))

; To find the square root of x you can do so by finding
; the fixed point to f(y) = x / y. This function f has
; a fixed point y0 that's equal to sqrt(x)
; okay the question now is how do we find the fixed point of a
; function?
; we keep applying the output of the function to its input until
; it the output doesn't change anymore.
; okay now the problem of applying this algorithm to this
; function f(y) = x /y is that it keeps oscillating! There
; is a fixed point between the two points of oscillation
; but we can never reach it... What is the solution then?
; damp the oscillation. how?
; take the average between the two points of oscillation
; what are the two points of oscillation?
; y and x / y. 
(define (sqrt-2 x)
  (fiexed-point (average-damp (lambda y (/ x y)))
                1))

; average-damp is a special procedure
; input is a procedure (A procedure that computes the function we want to damp)
; output is a procedure (A procedure that computes the damped function)

; high-order procedures
; input: a procedure (makes it more specific)
; output: a procedure (what it simply does, the output!)
(define average-damp
  (lambda (f)
    (lambda (x) (average (f x) x))))


; Here is what is happening
; Finding the sqrt of something is a specific instance
; of the genral problem of finding a fixed point to
; a function
; so we define the general form of what it means to find
; the fixed point of any function by making fixed-point
; procedure accepts other procedures as input. (Going
; from general to speicif)
; and the sqrt procedure also depends on the more general
; procedure of average damping that takes any function
; and computes the damped version of it ... note that
; the average damping procedure took a procedure as input
; (as expected... it's a general notion or idea, if you want
; to make it more specific you will have to pass it a
; procedure to make it specific to your problem)
; but other than that it RETURNED A PROCEDURE!!!
; this really doesn't have to do with the concept of
; generalization, this is simply the return value the
; average damping procedure happens to return...
; it's in its definition that it produces a damped version
; of the function ... that's what it does. same as
; what fixed point does, it simply returns the fixed point
; at the end as its return value. (you can think of the
; return value as what this balckbox or thing doing or
; why is it useful.




; Don't mix procedures with functions
; Think of it like this: procedures are the way to compute functions









