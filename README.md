<p align="center"><b>МОНУ НТУУ КПІ ім. Ігоря Сікорського ФПМ СПіСКС</b></p>
<p align="center">
<b>Звіт з лабораторної роботи 3</b><br/>
"Конструктивний і деструктивний підходи до роботи зі списками"<br/>
дисципліни "Вступ до функціонального програмування"
</p>
<p align="right"><b>Студент(-ка)</b>: Кузнецов Дмитро Сергійович КВ-21</p>
<p align="right"><b>Рік</b>: 2025</p>

## Загальне завдання
 Реалізуйте алгоритм сортування чисел у списку двома способами: функціонально і
імперативно.
1. Функціональний варіант реалізації має базуватись на використанні рекурсії і
конструюванні нових списків щоразу, коли необхідно виконати зміну вхідного
списку. Не допускається використання: псевдо-функцій, деструктивних операцій,
циклів . Також реалізована функція не має бути функціоналом (тобто приймати на
вхід функції в якості аргументів).

2. Імперативний варіант реалізації має базуватись на використанні циклів і
деструктивних функцій (псевдофункцій). Не допускається використання функцій
вищого порядку або функцій для роботи зі списками/послідовностями, що
використовуються як функції вищого порядку. Тим не менш, оригінальний список
цей варіант реалізації також не має змінювати, тому перед виконанням
деструктивних змін варто застосувати функцію copy-list (в разі необхідності).
Також реалізована функція не має бути функціоналом (тобто приймати на вхід
функції в якості аргументів).
## Варіант 7 (2)
Алгоритм сортування обміном No1 (без оптимізацій) за незменшенням.
## Лістинг функції з використанням конструктивного підходу
```lisp
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
```
### Тестові набори та утиліти
```lisp
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
```
### Тестування
```lisp
(test-bubble-sort-functional)

PASSED: functional: reverse list
PASSED: functional: duplicates
PASSED: functional: empty list
PASSED: functional: single element
```


## Лістинг функції з використанням деструктивного підходу
```lisp
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
```
### Тестові набори та утиліти
```lisp
(defun assert-equal (expected actual test-name)
  (if (equal expected actual)
      (format t "PASSED: ~a~%" test-name)
      (format t "FAILED: ~a~%  expected: ~a~%  actual:   ~a~%"
              test-name expected actual)))

(defun test-bubble-sort-imperative ()
  (assert-equal '(1 2 3 4 5)
                (bubble-sort-imperative '(5 4 3 2 1))
                "imperative: reverse list")

  (assert-equal '(1 2 2 3)
                (bubble-sort-imperative '(2 1 3 2))
                "imperative: duplicates")

  (assert-equal '()
                (bubble-sort-imperative '())
                "imperative: empty list")(assert-equal '(1)
                (bubble-sort-imperative '(1))
                "imperative: single element"))
```

### Тестування
```lisp
(test-bubble-sort-imperative)

PASSED: imperative: reverse list
PASSED: imperative: duplicates
PASSED: imperative: empty list
PASSED: imperative: single element
```
