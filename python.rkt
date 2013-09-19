#lang slideshow

(require slideshow/play
         slideshow/code
         slideshow/latex
         (for-syntax syntax/stx)
         "slideshow-macros.rkt")

(title-slide
 (scale (bitmap "python-logo.gif") 4)
 (colorize (medium-text "Leif Andersen") "blue")
 (colorize (t "University of Utah") "red"))

(pretty->flip-slide
 (massive-text "What is Python?"))

(flip->pretty-slide
 (large-text "An interpreted, interactive,")
 (large-text "object-oriented")
 (large-text "programming language."))

(pretty-slide
 (medium-text "Reasons to use Python"))

(insert-slide
 #:append 'center-h
 #:left (medium-text "Reasons to ")
 #:right (medium-text "use Python")
 #:insert (medium-text "NOT "))

(pretty-slide
 (massive-text "Questions?"))
