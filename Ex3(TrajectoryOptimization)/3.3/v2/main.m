tic
% params x: 2 intermidiate points
% x = (2×2) matrix
%rows mean number of intermidiate points and colums means coordinates(x, y) 
n = 11;

%lb = [0, 0; 0, 0;];  % lower bounds of params
%ub = [10, 10; 10, 10;];  % upper bounds of params
lb = zeros(n,2);
ub = 10*ones(n,2);

%position of obstacles (circles)
A = [1, 1];  % point of A
B = [9, 9];  % point of B
%circle position
min_rad = 0.5;
max_rad = 2;
[C0, R0] = rand_circle_generator(16, A, B, min_rad, max_rad);
%C0 = [[3, 3]; [6.5, 5.8]; [8, 4]; [3, 6.5];] %[8.7, 1.5];]; % center of the circle
%R0 = [1.5 1.2 1 1.3] % 1.2]; % radisu of circles
C = C0;
R = R0;
disp(size(C0))
disp(size(R0))



%search in the rectangle defined by A, B and check if all circles are
%within this rectangle. if not, delete them and simplify the optimization problem

%[C, R] = check_circle_pos(A, B, C0, R0);


%random initialization of all intermidiate points (params M(x, y))
% 1. initialize with zeros
% 2. initialize with ones
% 3. initialize with intermidiate point between A and B
x = zeros(n,2);
if false
    x0 = 10*rand(n, 2);
    %x0 = 10*ones(n, 2); %zeros(n,2);
else    
    x0 = A+(1/n)*(B-A);
    for i=1:n-1
        M = A+(1/n)*(B-A) + (i/n)*(B-A)*(n-1)/n;
        x0 = cat(1, x0, M);
    end
end



options = optimset('Display', 'Iter', 'Tolx', 1e-10,'Tolfun', 1e-10,'MaxFunEvals', 5000,'MaxIter', 100000);
A_ = [];
b_ = [];
Aeq_ = [];
beq_ = [];
x = fmincon(@(x)objective(x, A, B), x0, A_, b_, Aeq_, beq_, lb, ub, @(x)constraints(x, A, B, C, R), options);
disp('optimized parameters:')
disp(x);

disp_optim_path(A, B, C0, R0, x, x0, lb, ub);

toc



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
