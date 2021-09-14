xmin = 1;
xmax = 4;

vis = true;
n = 10; % num of trials
epsilon = 0.001;
f = @(x) x(1)^3/3 - 2*x(1)^2 + 3*x(1) + 1 % function to optimize
answer = dichotonomous(f, xmin, xmax, n, epsilon);

x = -1:0.05:5;
y = x.^3/3 - 2*x.^2 + 3*x + 1; % f'(x) = 0   x = 1, 3

disp(['x = ' + string(answer) + ' f = ' + string(f(answer))]);
if vis
    plot(x, y);
    yline(1);
end


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