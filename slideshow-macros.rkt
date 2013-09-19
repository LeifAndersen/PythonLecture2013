#lang slideshow

(require slideshow/play
         slideshow/code
         slideshow/latex
         (for-syntax syntax/stx))

(provide (all-defined-out))

; Library
(define (medium-text txt)
  (text txt (current-main-font) 50))

(define (large-text txt)
  (text txt (current-main-font) 62))

(define (massive-text txt)
  (text txt (current-main-font) 120))

(define (double-massive-text txt)
  (text txt (current-main-font) 240))

(define (medium-$$ txt)
  (scale ($$ txt) 1.5))

(define (large-$$ txt)
  (scale ($$ txt) 2))

(define (massive-$$ txt)
  (scale ($$ txt) 3))

(define (title-slide . data)
  (play-n
   #:skip-last? #t
   (animate-slide
    'next
    'alts
    `(,data ()))))

(define (pretty-slide #:title [title ""] . data)
  (play-n
   #:skip-first? #t
   #:skip-last? #t
   #:title title
   (animate-slide
    'next
    'alts
    `(,data ()))))

(define (flip-slide #:title [title ""]
                    #:flip-in [flip-in #t] #:flip-out [flip-out #t]
                    #:distance [distance 0] . data)
  (play-n
   #:skip-first? #t
   #:skip-last? #t
   #:title title
   (λ (n1 n2)
      (scale
       (apply vc-append `(,distance ,@data))
       (max 0.001 (* n1 (- 1 n2))) 1))))

(define (pretty->flip-slide #:title [title ""]
                            #:fade-in [fade-in #t] #:flip-out [flip-out #t]
                            #:distance [distance 0] . data)
  (play-n
   #:skip-first? #t
   #:skip-last? #t
   (λ (n1 n2)
      (fade-pict
       (if fade-in n1 1)
       (t "")
       (scale
        (apply vc-append `(,distance ,@data))
        (max 0.001 (- 1 n2)) 1)))))

(define (flip->pretty-slide #:title [title ""]
                            #:flip-in [flip-in #t] #:fade-out [fade-out #t]
                            #:distance [distance 0] . data)
  (play-n
   #:skip-first? #t
   #:skip-last? #t
   (λ (n1 n2)
      (fade-pict
       (if fade-out n2 1)
       (scale
        (apply vc-append `(,distance ,@data))
        (max 0.001 n1) 1)
       (t "")))))

(define (start-pretty-slide #:title [title ""] . data)
  (play-n
   #:skip-first? #t
   #:skip-last? #f
   #:title title
   (apply animate-slide `(next ,@data))))

(define (header-slide #:title [title ""] #:reversed [reversed #f]
                      #:append [append 'top] #:distance [distance 0]
                      #:fade-in [fade-in #t] #:fade-out [fade-out #t]
                      #:left [left ""] #:right [right ""]
                      #:header [header ""] . data)
  (play-n
   #:title title
   #:skip-first? #t
   #:skip-last? #t
   (λ (n1 n2 n3)
     (fade-pict
      (if fade-out n3 0)
      (fade-pict
          (if fade-in n1 1)
          (t "")
          (fade-around-pict
           (if reversed
               (- 1 n2)
               n2)
           header (λ (x)
                       (match append
                         ['top      (apply vc-append `(,distance ,x ,@data))]
                         ['bottom   (apply vc-append `(,distance ,@data ,x))]
                         ['left     (apply hc-append `(,distance ,x ,@data))]
                         ['right    (apply hc-append `(,distance ,@data ,x))]
                         ['center-h (apply hc-append `(,distance ,left ,x ,right))]
                         ['center-v (apply vc-append `(,distance ,left ,x ,right))]
                         [else      (apply vc-append `(,distance ,x ,@data))]))))
      (t "")))))

(define (insert-slide #:title [title ""] #:reversed [reversed #f]
                      #:left [left ""] #:right [right ""]
                      #:fade-in [fade-in #t] #:fade-out [fade-out #t]
                      #:append [append 'center-h] #:distance [distance 0]
                      #:insert [insert ""] . data)
  (play-n
   #:title title
   #:skip-first? #t
   #:skip-last? #t
   (λ (n1 n2 n3)
      (fade-pict
       (if fade-out n3 0)
       (fade-pict
        (if fade-in n1 1)
        (t "")
        ((λ (x)
            (match append
              ['top      (apply vc-append `(,distance ,x ,@data))]
              ['bottom   (apply vc-append `(,distance ,@data ,x))]
              ['left     (apply hc-append `(,distance ,x ,@data))]
              ['right    (apply hc-append `(,distance ,@data ,x))]
              ['center-h (apply hc-append `(,distance ,left ,x ,right))]
              ['center-v (apply vc-append `(,distance ,left ,x ,right))]
              [else      (apply vc-append `(,distance ,x ,@data))]))
         (if reversed
             (scale insert (max 0.001 (- 1 n2)) 1)
             (scale insert (max 0.001 n2) 1))))
       (t "")))))

(define (transition-slide #:title [title ""] #:reversed [reversed #f]
                      #:append [append 'top] #:distance [distance 0]
                      #:header [header ""] . data)
  (play-n
   #:title title
   #:skip-first? #t
   #:skip-last? #t
   (λ (n)
      (fade-around-pict
       (if reversed
           (- 1 n)
           n)
       header (λ (x)
                 (match append
                   ['top    (apply vc-append `(,distance ,x ,@data))]
                   ['bottom (apply vc-append `(,distance ,@data ,x))]
                   ['left   (apply hc-append `(,distance ,x ,@data))]
                   ['right  (apply hc-append `(,distance ,@data ,x))]
                   [else     (apply vc-append `(,distance ,x ,@data))]))))))

(define-syntax (picture-slide stx)
  (syntax-case stx ()
    [(k #:title title first-pic pic ...)
     ; =>
     #'(picture-slide* title first-pic pic ...)]

    [(k first-pic pic ...)
     ; =>
     #'(picture-slide* "" first-pic pic ...)]))

(define-syntax (picture-slide* stx)
  (define (build-transitions pic id acc)
    (cond [(stx-null? pic) acc]
          [(stx-null? (stx-cdr pic))
           ; =>
           #`(fade-pict #,(stx-car id) #,acc
                        (scale #,(stx-car pic) #,(stx-car id)))]

          [else
           ; =>
           (build-transitions (stx-cdr pic) (stx-cdr id)
                              #`(fade-pict #,(stx-car id) #,acc
                                           (scale #,(stx-car pic) (+ #,(stx-car id) #,(stx-car (stx-cdr id))))))]))
  (syntax-case stx ()
    [(k title first-pic pic ...)
     ; =>
     (with-syntax ([(first-id) (generate-temporaries #'(first-pic))]
                   [(id ...) (generate-temporaries #'(pic ...))]
                   [(last-id) (generate-temporaries #'(1))])
       (with-syntax ([body (build-transitions #'(pic ...) #'(id ...)
                                              #`(cellophane (scale first-pic (+ 1 #,(stx-car #'(id ...))))
                                                            first-id))])
         #'(play-n
            #:skip-first? #t
            #:skip-last? #t
            #:title title
            (λ (first-id id ... last-id)
              (cellophane body (- 1 last-id))))))]))

(define-syntax (section stx)
  (syntax-case stx ()
    [(k #:title section-title slides ...)
     ; =>
     (with-syntax ([pretty-slide (datum->syntax #'k 'pretty-slide)]
                   [start-pretty-slide (datum->syntax #'k 'start-pretty-slide)]
                   [header-slide (datum->syntax #'k 'header-slide)]
                   [picture-slide (datum->syntax #'k 'picture-slide)])
       #'(let ([pretty-slide* pretty-slide]
               [flip-slide* flip-slide]
               [pretty->flip-slide* pretty->flip-slide]
               [flip->pretty-slide* flip->pretty-slide]
               [start-pretty-slide* start-pretty-slide]
               [header-slide* header-slide]
               [insert-slide* insert-slide]
               [transition-slide* transition-slide])

           (define (pretty-slide #:title [title #f] . data)
             (unless title (set! title section-title))
             (pretty-slide* #:title title . data))

           (define (flip-slide #:title [title #f]
                               #:flip-in [flip-in #t] #:flip-out [flip-out #t]
                               #:distance [distance 0] . data)
             (unless title (set! title section-title))
             (flip-slide* #:title title #:flip-in flip-in #:flip-out flip-out
                          #:distance distance . data))

           (define (pretty->flip-slide #:title [title #f]
                                       #:fade-in [fade-in #t] #:flip-out [flip-out #t]
                                       #:distance [distance 0] . data)
             (unless title (set! title section-title))
             (pretty->flip-slide* #:title title #:flip-in flip-in #:flip-out flip-out
                                  #:distance distance . data))

           (define (flip->pretty-slide #:title [title #f]
                                       #:flip-in [flip-in #t] #:fade-out [fade-out #t]
                                       #:distance [distance 0] . data)
             (unless title (set! title section-title))
             (flip->pretty-slide* #:title title #:flip-in flip-in #:flip-out flip-out
                                  #:distance distance . data))

           (define (start-pretty-slide #:title [title #f] . data)
             (unless title (set! title section-title))
             (start-pretty-slide* #:title title . data))

           (define (header-slide #:title [title #f] #:reversed [reversed #f]
                                 #:append [append 'top] #:distance [distance 0]
                                 #:fade-in [fade-in #t] #:fade-out [fade-out #t]
                                 #:left [left ""] #:right [right ""]
                                 #:header [header ""] . data)
             (unless title (set! title section-title))
             (header-slide* #:title title #:reversed reversed #:append append
                            #:distance distance #:fade-in fade-in
                            #:fade-out fade-out #:left left #:right right
                            #:header header . data))

           (define (insert-slide #:title [title ""] #:reversed [reversed #f]
                                 #:left [left ""] #:right [right ""]
                                 #:fade-in [fade-in #t] #:fade-out [fade-out #t]
                                 #:append [append 'center-h] #:distance [distance 0]
                                 #:insert [insert ""] . data)
             (unless title (set! title section-title))
             (insert-slide* #:title title #:reversed reversed
                            #:left left #:right right
                            #:fade-in fade-in #:fade-out #:fade-out
                            #:append append #:distance distance
                            #:insert insert .data))

           (define (transition-slide #:title [title #f] #:reversed [reversed #f]
                                     #:append [append 'top] #:distance [distance 0]
                                     #:header [header ""] . data)
             (unless title (set! title section-title))
             (transition-slide* #:title title #:reversed reversed #:append append
                                #:distance distance #:header header . data))

           (define-syntax (picture-slide stx)
             (syntax-case stx ()
               [(k #:title title first-pic pic (... ...))
                ; =>
                #'(picture-slide* title first-pic pic (... ...))]

               [(k first-pic pic (... ...))
                ; =>
                #'(picture-slide* section-title first-pic pic (... ...))]))

           slides ...))]))
