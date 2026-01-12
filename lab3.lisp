(defun bubble-pass (lst)
  (cond
    ((or (null lst) (null (cdr lst))) lst)
    ((<= (car lst) (cadr lst))
     (cons (car lst)
           (bubble-pass (cdr lst))))
    (t
     (cons (cadr lst)
           (bubble-pass (cons (car lst) (cddr lst)))))))

(defun bubble-sort-functional-helper (lst n)
  (if (<= n 1)
      lst
      (bubble-sort-functional-helper
       (bubble-pass lst)
       (- n 1))))

(defun bubble-sort-functional (lst)
  (bubble-sort-functional-helper lst (length lst)))

  
(defun bubble-sort-imperative (lst)
  (let* ((working-list (copy-list lst))
         (n (length working-list)))
    (dotimes (i (- n 1))
      (dotimes (j (- n 1))
        (when (> (nth j working-list)
                 (nth (+ j 1) working-list))
          (rotatef (nth j working-list)
                   (nth (+ j 1) working-list)))))
    working-list))



(defun assert-equal (expected actual test-name)
  (if (equal expected actual)
      (format t "PASSED: ~a~%" test-name)
      (format t "FAILED: ~a~%  expected: ~a~%  actual:   ~a~%"
              test-name expected actual)))


(defun test-bubble-sort-functional ()
  (assert-equal '(1 2 3 4 5)
                (bubble-sort-functional '(5 4 3 2 1))
                "functional: reverse list")

  (assert-equal '(1 2 2 3)
                (bubble-sort-functional '(2 1 3 2))
                "functional: duplicates")

  (assert-equal '()
                (bubble-sort-functional '())
                "functional: empty list")

  (assert-equal '(1)
                (bubble-sort-functional '(1))
                "functional: single element"))

(test-bubble-sort-functional)

(defun test-bubble-sort-imperative ()
  (assert-equal '(1 2 3 4 5)
                (bubble-sort-imperative '(5 4 3 2 1))
                "imperative: reverse list")

  (assert-equal '(1 2 2 3)
                (bubble-sort-imperative '(2 1 3 2))
                "imperative: duplicates")

  (assert-equal '()
                (bubble-sort-imperative '())
                "imperative: empty list")

  (assert-equal '(1)
                (bubble-sort-imperative '(1))
                "imperative: single element"))
(test-bubble-sort-imperative)