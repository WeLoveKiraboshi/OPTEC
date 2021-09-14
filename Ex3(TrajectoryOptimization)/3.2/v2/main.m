% params x: 2 intermidiate points
% x = (2×2) matrix
%rows mean number of intermidiate points and colums means coordinates(x, y) 
n = 2;

%lb = [0, 0; 0, 0;];  % lower bounds of params
%ub = [10, 10; 10, 10;];  % upper bounds of params
lb = zeros(n,2);
ub = 10*ones(n,2);

%position of obstacles (circles)
A = [1, 5];  % point of A
B = [9, 5];  % point of B
C1 = [6, 5.5]; % center of the circle1
R1 = 1.2;      % radius of the circle1
C2 = [3, 5]; % center of the circle2
R2 = 1.5;      % radius of the circle2

%random initialization of all intermidiate points (params M(x, y))
% 1. initialize with zeros
% 2. initialize with ones
% 3. initialize with intermidiate point between A and B
x = zeros(n,2);

%x0 = 10*ones(n, 2); 
%zeros(n,2);
x0 = 10*rand(n, 2);
% x0 = A+(1/n)*(B-A);
% for i=1:n-1
%     M = A+(1/n)*(B-A) + (i/n)*(B-A)*(n-1)/n;
%     x0 = cat(1, x0, M);
% end



options = optimset('Display', 'Iter', 'Tolx', 1e-15,'Tolfun', 1e-15,'MaxFunEvals', 5000,'MaxIter', 100000);
A_ = [];
b_ = [];
Aeq_ = [];
beq_ = [];
x = fmincon(@(x)objective(x, A, B), x0, A_, b_, Aeq_, beq_, lb, ub, @(x)constraints(x, A, B, C1, R1, C2, R2), options);
disp('optimized parameters:')
disp(x);

disp_optim_path(A, B, C1, R1, C2, R2, x, x0, lb, ub);



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