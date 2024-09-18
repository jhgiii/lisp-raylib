(ql:quickload :cl-raylib)

(defpackage :raylib-user
  (:use :cl :raylib))

(in-package :raylib-user)

(defstruct vector2
  x
  y)

(defvar MINRAD 1) 
(defvar WIN_WIDTH 2560)
(defvar WIN_HEIGHT 2000) 

(defun draw-snowflake (center radius num-branches depth)
  "Draws a recursive snowflake at a given center with a certain radius, number of branches, and recursion depth."
  (let* ((angle (/ (* 2 pi) num-branches)))
    (when (> radius MINRAD)
      (dotimes (i num-branches)
        (let* ((x-end (+ (slot-value center 'x) (* radius (cos (* i angle)))))
               (y-end (+ (slot-value center 'y) (* radius (sin (* i angle)))))
               (end-point (make-vector2 :x x-end :y y-end)))
          (draw-line (truncate (slot-value center 'x)) (truncate (slot-value center 'y))
                     (truncate x-end) (truncate y-end)
                     :blue)
          (draw-snowflake end-point (/ radius 3) num-branches (1- depth)))))))

(defun main ()
  (init-window WIN_WIDTH WIN_HEIGHT "Recursive Snowflake Example")
  (set-target-fps 60)
  (loop while (not (window-should-close))
        do
          (begin-drawing)
          (clear-background :black)
          (draw-snowflake (make-vector2 :x (/ WIN_WIDTH 2) :y (/ WIN_HEIGHT 2)) 600 6 10)
          (end-drawing))
  (close-window))

(main)
