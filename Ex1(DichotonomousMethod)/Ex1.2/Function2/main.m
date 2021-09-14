clc; 
clear all
close all
X0 = [-10, -10];
d = [1, 0.5];
xmin = 0;
xmax = 15;
Xmax = [X0(1)+d(1)*xmax, X0(2)+d(2)*xmax];
n = 100; % num of trials
epsilon = 0.1;
figure(1)

X = [-10:0.5:18];
Y = [-10:0.5:18];
[X1, Y1] = meshgrid(X, Y);
Z = X1.^2+(X1+Y1).^2;
contour(X1, Y1, Z,'LevelStep',200); 
hold on;
answer = dichotonomous_multi(X0, d, xmin, xmax, n, epsilon);
plot(answer(1), answer(2), 'g+')
text(answer(1), answer(2),'\leftarrow minimum')
plot(X0(1), X0(2),'m*')
text(X0(1), X0(2),'\leftarrow X0')
text(Xmax(1), Xmax(2),'\leftarrow Xmax')
colorbar



if (1)
    visualize(X0, Xmax, d, answer)
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
