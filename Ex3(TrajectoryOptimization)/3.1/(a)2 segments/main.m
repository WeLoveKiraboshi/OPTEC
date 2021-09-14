lb = [0, 0];  % lower bounds of params
ub = [10, 10];  % upper bounds of params
x_init = 5;
y_init = 9;
x0 = [x_init, y_init];
x = [x_init, y_init]; %params : intermidiate point = M(x, y)

options = optimset('Display', 'Iter', 'Tolx', 1e-10,'Tolfun', 1e-10,'MaxFunEvals', 5000,'MaxIter', 100000);
A_ = [];
b_ = [];
Aeq_ = [];
beq_ = [];
A = [1, 5]; % point of A
B = [9, 5]; % point of B
C = [5, 5]; % center of the circle
R = 3; % radius of the circle
x = fmincon(@(x)objective(x, A, B), x0, A_, b_, Aeq_, beq_, lb, ub, @(x)constraints(x, A, B, C, R), options);
disp('optimized parameters:')
disp('Mx')
disp(x(1))
disp('My')
disp(x(2))

disp_optim_path(A, B, C, R, x, lb, ub);




%*****************************************************************************************
%All implementation comes to Yuki Saito (M1 JEMARO). 2021/5/1
%IF any, please contact below
%Yuki Saito
%TEL : (+81)80-2161-0882
%MAIL: yusa19971015@keio.jp
%website: http://www.hvrl.ics.keio.ac.jp/saito_y/site/
%ADDRESS: 5-29-4 Ima-ju hiyoshi #104, Hiyoshi, Yokohama, Yokohama city, 
%                        Kohoku Ward, Kanagawa Prefecture, 223-0061, Japan
%Keio University , School of Science for Open and Environment Systems,
%the department of information and computer science 
%****************************************************************************************