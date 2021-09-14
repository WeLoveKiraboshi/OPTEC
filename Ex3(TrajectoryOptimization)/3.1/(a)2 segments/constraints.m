function [C, Ceq]=constraints(x, A, B, Center, R)
%input argument:
%A = [xA, yA] coordinate of pointA
%B = [xB, yB] coordinate of pointB

n = 10; % number of discritization used in distance_segment_circl()
C(1) = R - distance_segment_circle(A,x,Center,n, false);
C(2) = R - distance_segment_circle(x,B,Center,n, false);

%C(3) = R^2 - ((x(1)-C(1))^2+(x(2)-C(2))^2);
Ceq = [];
