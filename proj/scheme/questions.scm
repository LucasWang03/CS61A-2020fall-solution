(define (caar x) (car (car x)))

(define (cadr x) (car (cdr x)))

(define (cdar x) (cdr (car x)))

(define (cddr x) (cdr (cdr x)))

; Some utility functions that you may find useful to implement
(define (zip pairs)
  (if (null? pairs)
      (list nil nil)
      (begin (define lsts (zip (cdr pairs)))
             (list (cons (car (car pairs)) (car lsts))
                   (cons (car (cdr (car pairs))) (car (cdr lsts)))
             )
      )
  )
)

; ; Problem 15
; ; Returns a list of two-element lists
(define (enumerate s)
  ; BEGIN PROBLEM 15
  (define (solve i s)
    (if (null? s)
        nil
        (cons (list i (car s)) (solve (+ i 1) (cdr s)))
    )
  )
  (solve 0 s)
)

; END PROBLEM 15
; ; Problem 16
; ; Merge two lists LIST1 and LIST2 according to COMP and return
; ; the merged lists.
(define (merge comp list1 list2)
  ; BEGIN PROBLEM 16
  (cond 
    ((null? list1)
     list2
    )
    ((null? list2)
     list1
    )
    ((comp (car list1) (car list2))
     (cons (car list1) (merge comp (cdr list1) list2))
    )
    (else
     (cons (car list2) (merge comp list1 (cdr list2)))
    )
  )
)

; END PROBLEM 16
(merge < '(1 5 7 9) '(4 8 10))

; expect (1 4 5 7 8 9 10)
(merge > '(9 7 5 1) '(10 8 4 3))

; expect (10 9 8 7 5 4 3 1)
; ; Problem 17
(define (nondecreaselist s)
  ; BEGIN PROBLEM 17
  (if (null? s)
      nil
      (begin (define lsts (nondecreaselist (cdr s)))
             (if (or (null? lsts) (> (car s) (car (car lsts))))
                 (cons (cons (car s) nil) lsts)
                 (cons (cons (car s) (car lsts)) (cdr lsts))
             )
      )
  )
)

; END PROBLEM 17
; ; Problem EC
; ; Returns a function that checks if an expression is the special form FORM
(define (check-special form)
  (lambda (expr) (equal? form (car expr)))
)

(define lambda? (check-special 'lambda))

(define define? (check-special 'define))

(define quoted? (check-special 'quote))

(define let? (check-special 'let))

; ; Converts all let special forms in EXPR into equivalent forms using lambda
(define (let-to-lambda expr)
  (cond 
    ((atom? expr)
     ; BEGIN PROBLEM EC
     expr
     ; END PROBLEM EC
    )
    ((quoted? expr)
     ; BEGIN PROBLEM EC
     expr
     ; END PROBLEM EC
    )
    ((or (lambda? expr) (define? expr))
     (let ((form (car expr))
           (params (cadr expr))
           (body (cddr expr))
          )
       ; BEGIN PROBLEM EC
       (append (list form params) (map let-to-lambda body))
       ; END PROBLEM EC
     )
    )
    ((let? expr)
     (let ((values (cadr expr))
           (body (cddr expr))
          )
       ; BEGIN PROBLEM EC
       (define params (car (zip values)))
       (define args (map let-to-lambda (cadr (zip values))))
       (cons (append (list 'lambda params) (map let-to-lambda body)) args)
       ; END PROBLEM EC
     )
    )
    (else
     ; BEGIN PROBLEM EC
     (map let-to-lambda expr)
     ; END PROBLEM EC
    )
  )
)
