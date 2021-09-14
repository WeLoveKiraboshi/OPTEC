function f=objective(x, A, B)
%input argument:
%A = [xA, yA] coordinate of pointA
%B = [xB, yB] coordinate of pointB
%x = n×[x, y]  intermidiate point to avoid the circle.
%C = [5, 5]; % center of the circle
n = size(x, 1); % number of intermidiate points
f = 0;
for i=0:n
    if i==0
        f = f + norm(x(1, :)-A);
    elseif i == n
        f = f + norm(x(n, :)-B);
    else
        f = f + norm(x(i, :)-x(i+1, :));
    end
end
    