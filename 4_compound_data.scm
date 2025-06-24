#lang sicp

; divorce the task of building things
; from the task of implementing the parts.

; strategy of wishful thinking
; let's imgine that we have 3 procedures
; (make-rat n d) -> somehow retunrs the new data type
; (numer cloud) -> n
; (denom cloud) -> d
; if we have these then we can define things like the following


(define (+rat x y)
  (make-rat
   (+ (* (numer x) (denom y))
      (* (numer y) (denom x)))
   (* (denom x) (denom y))))

(define (*rat x y)
  (make-rat
   (* (numer x) (numer y))
   (* (denom x) (denom y))))

; (x + y) * (s + t)
;(*rat (+rat x y) (+rat s t))

; List structure are a way to glue things together
; they allow us to make pairs (box pointer notation)

;(cons x y)
;(car p)
;(cdr p)

;(car (cons x y)) is x
;(cdr (cons x y)) is y

(define (make-rat n d)
  (cons n d))

(define (numer x)
  (car x))

(define (denom x)
  (cdr x))

; That's a complete implemenation of rational numbers.

(define a (make-rat 1 2))
(define b (make-rat 1 4))
(define ans (+rat a b))
(numer ans)
(denom ans)

; constructors and the selectors are the layer of abstraction
; that separate +rat *rat from the underlying data structure
; which in this case were pais

; so basically we have separated the use of the data objects from how
; they are represented.


; What is the point of isolating the use from the representation?
; NAMING. we need to name it to control it.
; we need to have in the system something called rational number
; a conceptual entity that I can point at and say this is
; a rational number
; what are the names you may ask
; well, In out system the things that make up this coneptual idea
; or this new data type is
; make-rat, numer, denom
; these three procedures constitute the idea of a rational number
; they are the layer that separates use from representation.
; Note that here we don't have the concept of classes (yet??)
; the constructors and the procedures used on this new data
; type are floating in our system. there is no class that encapsulate
; them. (same as in C)



; The idea of data abstraction is to defer making decision early
; on in your system, and the way you do so is by wishful thinking.

; That's exactly what we have done in the implementation of +rat *rat
; we didn't really care if make-rat denom numer were designed or not!
; we simply named it and defered the work of actually implementing
; this new data structure for later.

; let is a way of doing local variables
(let ((z 10))
  (+ z z))


; we can have pairs of pairs (closure) to construct higher data
; type.  

; Notice how we have built *rat and +rat
; is that we have interfaced with an abstract data type that
; doesn't exist at the moment, and that's what is called an abstract
; data.
; But now let's think about this, let's say we want to go ahead and actually
; implement this abstract datatype (make-rat denom numer), we can't
; just go and get three random procedures and name them make-rat
; denom and numer. We need to have a contract that governs
; the meaning of make-rat denom and numer.
; the contract
; ------------
; if x = (make-rat n d)
; then
;     (numer x) / (denom x) = n / d
; This is what the implementation of these three procedures need to fulfil.
; if it fulfils this contract we don't care how he does it.


;===================================================================
; -> What is really a rational number?
; it's simply a pair
; -> Nah I'm asking what is it REALLY?
; a rational number is the following axiom
; if x = (make-rat n d)
; then
;    (numer x) / (denom x) = n / d
; -> Why do you emphasize this I don't get it?
; Because if you think about it, what make a rational number
; a rational number is that it satisfies the axiom! It's not
; really that it's made on top of pairs! it could've been made
; on top of nothingness (pure abstraction).
; They simply could be built on top of procedures that return
; values that satisfy the axiom.

; 1- Implementation on top of pairs
(define (make-rat-2 n d)
  (cons n d))
(define (numer-2 x)
  (car x))
(define (denom-2 x)
  (cdr x))
; 2- implementation on top of procedures (what I meant by nothingness).
(define (make-rat-3 a b)
  (lambda (pick)
    (cond ((= pick 1) a)
          ((= pick 2) b))))
(define (numer-3 x) (x 1))
(define (denom-3 x) (x 2))
; note that the procedure "pick" has closure on a and b (this
; what enables us to do this, closure) or to be more spicific
; and precise what enables us to so is that we are dealing
; with procedurs as objects that set in memory with a and b
; associated with each one.
; I mean the two numbers that constitute the fractional number
; need to exist in memory somehow (they exist inside the
; procedure object).

; To emphasize the meaning of nothingness is note that in the
; implementation of make-rat-3 which is the constructor
; of rational number, I didn't go on and call another constructor
; make-something that rational numbers are made on top of.

