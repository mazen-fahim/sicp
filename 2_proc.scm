#lang sicp

; spells -> procedures + expression
; they direct the process that was intended by the programmer

; You need to understand the relationship between the things you write
; and the processes you are trying to control

; particular pattern of procedures -> particular patterns of execution of processes

; SUM OF THE SQUARE OF TWO NUMBERS

(define (sos x y)
  (define (sq x)
  (* x x))
  (+ (sq x)
     (sq y)))

(sos 3 4)

; substitution model (uderstand how procedures yield processes)
; this is not really how the machine work but it's an approximate
; idealised model that help us understand the relation between the two

; KINDS OF EXPRESSIONS
; 1. numbers -> evaluates to itself
; 2. symbols
;------------------------
; these are special forms
; 3. *lambda expressions
; 4. *definitions
; 5. *conditionals
; ----------------------
; 6. combinations -> (these are evaluated like the substitution model)


; How to evaluate a program (substitution model (Mechanical model))
; 1. evaluate the operator you will get a procedures
; 2. evaluate the operands to get arguments
; 3. apply the procedure to the arguments
;    - copy the body of the procedure.
;    - substitute the argument supplied with the formal parameter of the procedures
;    - evaluate the resulting body


; Very direct substitution.
; (sos 3 4)
; (+ (sq 3) (sq 4))
; (+ (sq 3) (* 4 4))
; (+ (sq 3) 16)
; (+ (* 3 3) 16)
; (+ 9 16)
; 25
; This is not a perfect description of what the computer does.

;(define (+ x y)
  ; these operators 1+ -1+ are defined in terms of -a to
  ; avoid looping infinetly
;  (define (1+ a) (- a -1))
;  (define (-1+ a) (- a 1))
;  (if (= x 0)
;      y
;      (+ (-1+ x) (1+ y))))


; what makes a process recursive or iterative is not that
; the definition of the procedures that make this process
; are recursive. that doesn't have to be the case. for example
; add(3, 4) = add(2, 5) -> when I use these procedures to descibe the process
; of addition results in a linear iterative process
; add(3, 4)
; add(2, 5)
; add(1, 6)
; add(0, 7)
; Time: O(N), Space: O(1)

; on the other hand if I write my procedure to compute the sum as follows
; I get a process that's recursive in nature.
; add(3, 4) = 1 + add(2, 4)

; -----------------
; |t|add(3, 4)
; | |1 + add(2, 4)
; |i|1 + 1 + add(1, 4)
; | |1 + 1 + 1 + add(0, 4)
; |m|1 + 1 + 1 + 4
; | |1 + 1 + 5
; |e|1 + 6
; | |7
;---------->>>>>>>> space complexity

; as you can see what makes a process recursive in nature
; is not that the procedures/problem definition used was recursive
; it's about how the resulting process evolves
; does it need to defer operations later till reach the base case
; then do them (it has to store this defered pending information about
; the information somewhere) this is what makes a recursive process
; take Time: O(N), Space: O(N)

; You can't just jump in the middle of a recursive process and see
; what state it's currently on and figure out the solution starting
; at that point... there are additional operations that were defered
; and waiting to be applied. if you lose them you get a wrong answer.

; BUT you can jump in the middle of an iterative process and continue
; where you left off by simply progressing further to the next iteration
; you are going to do what you always did in every previous iteration. There was 
; no hidden/deferred operations that will be applied later.
; If i finish an iteration that's it. older iterations are not waiting for me
; somehow to apply additional operations that they deferred like what they
; did in the case of a recursive process.

; simply implement the recurrence relation.
(define (feb n)
  (if (< n 3)
      n
      (+ (feb (- n 1)) (feb (- n 2)))))

(feb 5)
; feb(5) = feb(4) + feb(3)
; (feb 5)
; (+ (feb 4) (feb 3))
; (+ (feb 4) (+ (feb 2) (feb 1)))
; (+ (feb 4) (+ 2 1))
; (+ (feb 4) 3)
; (+ (+ (feb 3) (feb 2)) 3)
; (+ (+ (feb 3) 2) 3)
; (+ (+ (+ (feb 2) (feb 1)) 2) 3)
; (+ (+ (+ 2 1) 2) 3)
; (+ (+ 3 2) 3)
; (+ 5 3)
; 8
; Look at that chaotic process we have created by simply
; implementing the recurrence relation of a feb sequence.
; You can easily see that the nature of this process is recursive
; since it needs to remember to add things (the overhead) that's why
; you see the process getting wider then smaller and so on.
; it consume Space: O(N) and Time(2^n)
; Another proof that it's recursive in nature is that if I jump
; in the middle of the process and try to continue I won't be
; able to remember the previous nodes that are waiting for answers from
; the sub-problems to add them

; each local instance needs to remember to add

; There is a subtle difference between optimized memoized
; recursive process for example feb sequence and an iterative
; solution to the feb sequence.
; even tho using dp is an optimization for the recursive process
; it's STILL recursive. It uses stack, each frame has its own
; local state waiting to do some deferred operations.

; but if you implement it iteratively, at any moment or step
; during the execution of the process you can pause it and look
; and see the complete explicit state the process is currently in.
; YOU HAVE THE STATE IN EXPLICIT VARIABLE NOT HIDDEN IN SOME FRAME ON THE STACK
; + IF A STEP IS FINISHED IT WILL NEVER EXECUTE AGAIN. IT FINISHED ITS WORK AND
; HANDED IT TO THE NEXT STEP/ITERATION


; so to summarize, you can arrive at a problem solutions by
; expressing processes in terms of procedures. but be careful
; how you right these procedures because you can have different
; process behaviors for each specific way (some behaviors may be chaotic)







