clc; 
clear all
close all

figure(1);
X = [-512:20:512];
Y = [-512:20:512];
[X, Y] = meshgrid(X, Y);
Z = -X.*sin(sqrt(abs(X)))-Y.*sin(sqrt(abs(Y)));
xlabel('x')
ylabel('y')
ylabel('z')
surf(X, Y, Z);
colorbar
hold on



lb = [-512, -512];
ub = [512, 512];
num = 2; % number of parameters for optimization
temperature = 1000;      %initial temperature
final_temperature = 0.001;
max_iter = 10000; % num of iteration 

% initial pos, randmmply sample from uniform distribution[-1, 1]
%please note that this alpgorithm strongly depends on initial position of x
value = zeros(num, 1);
%for n = 1:num
%    value(n, 1) = (2*rand-1)*512; 
%end
value(1, 1) = 309.372222; 
value(2, 1) = -142.889536;
t0 = text(value(1, 1),value(2, 1),objective(value),'\leftarrow x0');
t0(1).Color = 'red';
t0(1).FontSize = 14;
hold on
fprintf('*initial position (x): (%7f,  %7f)', value(1, 1), value(2, 1))
disp('   ')
pathlist = [value(1, 1), value(2, 1), objective(value)];

count = 1; % loop counter
enegy = objective(value);
a = 0.9; % cooliong schedule param

while temperature > final_temperature       %stop temperature
    for n = 1:max_iter
        enegy1 = objective(value);
        temp_value = Disturb(value,num);
        enegy2 = objective(temp_value);
        
        delta_e = enegy2 - enegy1;
        if delta_e < 0 & check_range(temp_value, lb, ub, num)
            %accept pertuabation
            value = temp_value;
        else
            %accept maybe, with probability = exp(-delta_e/KT)
            % if greater than uniform distribution [0,1]
            if exp(-delta_e/temperature) > rand() & check_range(temp_value, lb, ub, num)
                value = temp_value;
            end
        end
    end
    count = count + 1;
    enegy = objective(value);
    %plot3(value(1), value(2), enegy,'r.');
    pathlist = vertcat(pathlist,[value(1), value(2), enegy]);
    %line([value(1), value(2), enegy], [last_plot(1), last_plot(2), objective(last_plot)]);
    %hold on
    last_plot = value;
    temperature=temperature*a;
end


solution = value;

fprintf('*Total loop count : %d', count)
disp('   ')
fprintf('*optimized solution (x): (%7f %7f)', solution(1), solution(2))
disp('   ')
fprintf('*optimized value f(x): %7f ', objective(solution))

pathlist = vertcat(pathlist,[solution(1), solution(2), objective(solution)]);
plot3(solution(1), solution(2), objective(solution),'g.','MarkerSize',14);
t_optim = text(solution(1),solution(2),objective(solution),'\leftarrow minimum');
t_optim(1).Color = 'green';
t_optim(1).FontSize = 14;


%annotate all path points
for ii = 1:size(pathlist,1)-1
    plot3(pathlist(ii,1),pathlist(ii,2),pathlist(ii,3),'r.');
    %line([pathlist(ii,1),pathlist(ii+1,1)],[pathlist(ii,2),pathlist(ii+1,2)],[pathlist(ii,3),pathlist(ii+1,3)],'Color','black','LineStyle','-','LineWidth',2);
    step_x = (pathlist(ii+1,1) - pathlist(ii,1))/20;
    step_y = (pathlist(ii+1,2) - pathlist(ii,2))/20;
    x = [pathlist(ii,1):step_x:pathlist(ii+1,1)];
    y = [pathlist(ii,2):step_y:pathlist(ii+1,2)];
    z = -x.*sin(sqrt(abs(x)))-y.*sin(sqrt(abs(y)));
    plot3(x, y, z,'-r','LineWidth',1) %line (X0+x*d)
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