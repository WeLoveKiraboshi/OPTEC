%params = (x1, x2)
lb = [-2.e1, -2.e1];  % lower bounds of params
ub = [2.e1, 2.e1];  % upper bounds of params
x0 = [1, 1];
options = optimset('Display', 'Iter', 'Tolx', 1e-20,'Tolfun', 1e-20,'MaxFunEvals', 500,'MaxIter', 50);
A = [];
b = [];
Aeq = []
beq = []
x = fmincon('objective', x0,A,b,Aeq,beq,lb,ub,'constraints',options);
disp(x)


%{
step_x1 = 0.5;
step_x2 = 0.5;
x = lb(1):step_x1:ub(1);
y = lb(2):step_x2:ub(2);
[X, Y] = meshgrid(x, y);
F = objective_visualize(X, Y)
figure(1); clf;
surf(X, Y, F);

figure(2); clf;
contourf(X, Y, F);

figure(3); clf;
contourf(X, Y, F);
hold on
contour(X, Y, F, [0, 16], 'r');
%}

%figure(4); clf;
%[c, h] = contour(X, Y, F, [5 10 10 5 0 12 12 0]);
