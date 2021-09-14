function f=objective(x, A, B)
%input argument:
%A = [xA, yA] coordinate of pointA
%B = [xB, yB] coordinate of pointB
%x = [x, y]  intermidiate point to avoid the circle.
C = [5, 5]; % center of the circle
f = norm(x-A)+norm(x-B);