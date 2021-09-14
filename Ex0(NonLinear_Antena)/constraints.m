function [C,Ceq] = fun(x)
A1 = [-5, 10];
A2 = [5, 0];
P_A1 = power(x(1)-A1(1), 2)+power(x(2)-A1(2), 2);
P_A2 = power(x(1)-A2(1), 2)+power(x(2)-A2(2), 2);
C(1) = 100 - P_A1;
C(2) = 100 - P_A2;
Ceq = [];