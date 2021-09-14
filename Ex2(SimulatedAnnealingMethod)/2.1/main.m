clc; 
clear all
close all

figure(1);
x = [0:pi/20:6*pi];
y = objective(x);
xlabel('x')
ylabel('y')
plot(x,y, '-b')
hold on

x_range = [0, 6*pi]; % range of param x
num = 1; % number of parameters for optimization
temperature = 500;      %initial temperature
max_iter = 500; % num of iteration 

% initial pos, randmmply sample from uniform distribution[-1, 1]
%please note that this alpgorithm strongly depends on initial position of x
value = zeros(num, 1);
for n = 1:num
    value(n, 1) = 6*pi*rand; 
end
text(value(n, 1),objective(value(n, 1)),'\leftarrow x0')



count = 1; % loop counter
enegy = objective(value);
a = 0.9; % cooliong schedule param

while temperature > 0.001       %stop temperature
    for n = 1:max_iter
        enegy1 = objective(value);
        temp_value = Disturb(value,num);
        enegy2 = objective(temp_value);
        
        delta_e = enegy2 - enegy1;
        if delta_e < 0
            %accept pertuabation
            value = temp_value;
        else
            %accept maybe, with probability = exp(-delta_e/KT)
            if exp(-delta_e/temperature) > rand() % uniform distribution [0,1]
                value = temp_value;
            end
        end
    end
    count = count + 1;
    enegy = objective(value);
    plot(value, enegy,'r*')
    hold on
    temperature=temperature*a;
end

disp('optimized solution')
solution = value

fprintf('*Total loop count : %d', count)
disp('   ')
fprintf('*optimized solution(x): %7f', solution)


plot(solution,objective(solution),'g*')
text(solution,objective(solution),'\leftarrow minimum')





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

