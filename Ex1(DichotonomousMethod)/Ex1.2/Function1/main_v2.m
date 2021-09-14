clc; 
clear all
close all
vis=false;

%setting vectors to search 
X0 = [-8, -8]; % d.x must be pos
n_trials = 1000;
dy_max = 5;
dy_min = -5;
dy_step = (dy_max - dy_min)/n_trials;

%settings for each optim config
xmin = 0;
xmax = 15;
max_iter = 10; % num of trials
epsilon = 0.01;


%display 2D contour graph
figure(1)
X = [-30:0.5:50];
Y = [-30:0.5:50];
[X1, Y1] = meshgrid(X, Y);
Z = (3*X1+2*Y1-1).^2+(X1-Y1+1).^2;
contour(X1, Y1, Z,'LevelStep',200);

fnmin(Z)
stop
    
history = [];
minf = 100;
for i=1:n_trials
    %d = [1, 0.5];
    d = [1, dy_min+dy_step*i]
    
    answer = dichotonomous_multi(X0, d, xmin, xmax, max_iter, epsilon, false);
    Xmax = [X0(1)+d(1)*xmax, X0(2)+d(2)*xmax];
    result = struct('answer', answer, 'X0', X0, 'Xmax', Xmax, 'd', d);
    history = cat(1, history, result);
    localmin = objective(answer);
    if minf > localmin
        minf = localmin;
    end
    %plot(answer(1), answer(2), 'g+')
    %text(answer(1), answer(2),'\leftarrow minimum')
    %plot(X0(1), X0(2),'m*')
    %text(X0(1), X0(2),'\leftarrow X0')
    %text(Xmax(1), Xmax(2),'\leftarrow Xmax')
    hold on;
end %end of for loop

disp(['local min f = ' + string(minf)])

colorbar;
visualize_history(history,n_trials);

    

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
    
