#lang info

(define collection "scribble-cheatsheet")

(define scribblings '(("scribble-cheatsheet.scrbl" () ("Examples"))))

(define build-deps '("at-exp-lib"
                     "racket-doc"
                     "scribble-doc"
                     "scribble-lib"))

(define license '(Apache-2.0 OR MIT))
(define deps '("base"))
