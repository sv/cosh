#!r6rs

;; continuations can be compared using "equal?"

(library

 (cosh continuation)

 (export make-continuation
         continuation:closure-id
         continuation:closure
         continuation:support
         continuation:scores
         continuation?
         continuations-equal?
         call-continuation)

 (import (rnrs)
         (_srfi :1)
         (scheme-tools)
         (scheme-tools deepcopy)
         (scheme-tools object-id))

 (define (make-continuation closure support scores)
   (list 'cont (object->id closure) support scores))
 
 (define continuation:closure-id second)
 
 (define (continuation:closure cont)
   (id->object (second cont)))
 
 (define continuation:support third)
 
 (define continuation:scores fourth)
 
 (define (continuation? obj)
   (tagged-list? obj 'cont))

 (define (continuations-equal? c1 c2)
   (eq? (continuation:closure-id c1)
        (continuation:closure-id c2)))

 (define (call-continuation cont value)
   (let ([clos (deepcopy (continuation:closure cont))])
     ((vector-ref clos 0) clos value)))

 )