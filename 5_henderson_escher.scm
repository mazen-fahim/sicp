#lang sicp

; cons can be used to glue together many things
; not just pairs

; closure is the thing that allowed us to grow in complexity
; and not be trapped in pairs

; the set of data object in lisp is closed under the operation
; of forming pairs

; there are many ways to glue pairs together to make a bigger
; data type so we need a convention to set which way we should
; use.

; linked list
(cons 1
      (cons 2
            (cons 3
                  (cons 4 nil))))

; list opeartion
(define 1-to-4 (list 1 2 3 4))

(car (cdr 1-to-4))
(car (cdr (cdr 1-to-4)))
1-to-4
(* (car 1-to-4) 10)
(cdr 1-to-4)
(cdr (cdr 1-to-4))








; map is the higher order procedure
; this is the general pattern and scaling by 10 was a single
; instance of the more general problem of applying a transfomation
; to each element.

; this particular implementation evolves recursive process.
(define (map p l)
  (if (null? l)
      nil
      (cons (p (car l))
            (map p (cdr l)))))

(map (lambda (x) (* x 20)) 1-to-4)

(define (scale-list s l)
  (map (lambda (item) (* item s))
       l))
(scale-list 10 1-to-4) ; (10, 20, 30, 40)

; stop thinking of control structures and start thinking
; in termns of operations on agregates.

; iterative process
(define (for-each proc list)
  (cond ((null? list) "done")
        (else (proc (car list))
              (for-each proc (cdr list)))))
(for-each (lambda (x) (write x)) 1-to-4)

; map gives you another list after applying the transformation
; foe-each simply applies the procedure for each item in the list,
; it doesn't construct a new list.


; CAPTURING COMMANALITY WITH HIGHER ORDER PROCEDURES (I like this)
; and by commanlity I mean common patterns

; escher language

; 1. Primitives -> picture, empty
; 2. means of combination.
; rotate, flip, beside, above

; if you put a picture beside a picture you get a picture
; this is the closure property!! this is the thing that helps us
; build more complex objects from smaller more simpler ones.
; I mean closure property describes the behavior of combining
; pictures to get picture ... it's not really describing the notion
; of combining data 



; means of combination (in terms of procedures)
; is the idea that you can combine simpler expressions
; to get more complex ones
; (+ 1 2)
; (* 3 4)
; (sqrt 16)
; (+ (* 2 3) (/ 10 2))

; means of combination (in terms of data)
; is the idea of combining data objects to get another data object
; (cons (cons 1 2) (cons 3 4))
; note how the combination of the two pairs (1, 2) and (3, 4)
; resulted in another pair (Maybe a bit more complex but it's still
; a pair) this is what's referred to as closure.
; simply put pairs make pairs. crabs make crabs. cats make cats.



; the world of pictures is CLOSED UNDER THE MEANS OF COMBINATION meaning that you would never
; get a random object by combining to pictures! you will always get a picture that you
; can go on and continue using it or even combining it again and again. you will
; always get a picture. you can never escape.


; similarly in C
; if you ask what are the means of combinations (data)
; we have structs and arrays
; so in the C world all the data objects you will have are either going
; to be structs or arrays. 

; if I constuct array of structs?? is this still closure? I put a
; struct and struct together and got an array at the end! maybe not?

;A set is closed under an operation if applying the operation to members of the set always yields a member of the same set.


; When faced with a complex problem, the typical approach is to decompose it into smaller tasks.
; While this is essential, SICP teaches us a more powerful method: metalinguistic abstraction.
; Instead of just solving the problem, we create a language tailored to expressing its solution.
;
; Solving a problem means building a system that performs the desired functionality.
; A powerful strategy is to design a language in which the solution is easy to express —
; ideally declarative and aligned with the domain.
;
; If our base language lacks the expressive power we need, we can extend it — or build a new one.
; For example, if we work with signals, we should build a language where signals are primitives,
; and combinations yield new signals.
;
; Every language has:
; 1. Primitives — the simplest building blocks (e.g., numbers, signals)
; 2. Means of combination — ways to combine primitives into complex structures (e.g., lists, functions)
; 3. Means of abstraction — tools to give names to complex ideas (e.g., define, higher-order functions, macros)
;
; Lisp empowers us not only to use abstraction, but to redefine what abstraction means,
; through macros and interpreters.
; Thus, we can create entire languages — ones that speak our problem domain fluently.


; a henderson pict primitive is simply a closure proecedure (behavior + state)
; you can map it easily to oop and classes where you model your primitives as classes
; that has datamembers (-> closure state) and methods (-> closure proceudre)

; you should think of it like this it's not really about implementing a program
; that does the thing you want, it's more about building a language you can
; use to express the thing you want at different levels.
; you can use fancy words that does a lot of things abstracted from you
; or you can use simple words that does simple things at a lower level.
; this is the different way of thinking about design instead of tasks and sub tasks.


















