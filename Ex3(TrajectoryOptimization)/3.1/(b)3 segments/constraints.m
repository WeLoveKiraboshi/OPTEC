function [C, Ceq]=constraints(x, A, B, Center, R)
%input argument:
%A = [xA, yA] coordinate of pointA
%B = [xB, yB] coordinate of pointB

n_discretization = 10; % number of discritization used in distance_segment_circl()
n = size(x, 1); % number of intermidiate points

f = 0;
for i=0:n
    if i==0
        C(i+1) = R - distance_segment_circle(A,x(1, :),Center,n_discretization, false);
    elseif i == n
        C(i+1) = R - distance_segment_circle(x(n, :),B,Center,n_discretization, false);
    else
        C(i+1) = R - distance_segment_circle(x(i, :),x(i+1, :),Center,n_discretization, false);
    end
end



%C(3) = R^2 - ((x(1)-C(1))^2+(x(2)-C(2))^2);
Ceq = [];
