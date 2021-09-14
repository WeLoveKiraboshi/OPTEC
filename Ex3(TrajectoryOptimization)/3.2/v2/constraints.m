function [C, Ceq]=constraints(x, A, B, Center1, R1, Center2, R2)
%input argument:
%A = [xA, yA] coordinate of pointA
%B = [xB, yB] coordinate of pointB

n_discretization = 10; % number of discritization used in distance_segment_circl()
n = size(x, 1); % number of intermidiate points

f = 0;
for i=0:n
    if i==0
        C(i+1) = R1 - distance_segment_circle(A,x(1, :),Center1,n_discretization, false);
    elseif i == n
        C(i+1) = R1 - distance_segment_circle(x(n, :),B,Center1,n_discretization, false);
    else
        C(i+1) = R1 - distance_segment_circle(x(i, :),x(i+1, :),Center1,n_discretization, false);
    end
    if C(i+1) < 0
        C(i+1) = 0;
    end
    
end

for i=0:n
    if i==0
        C(n+i+1) = R2 - distance_segment_circle(A,x(1, :),Center2,n_discretization, false);
    elseif i == n
        C(n+i+1) = R2 - distance_segment_circle(x(n, :),B,Center2,n_discretization, false);
    else
        C(n+i+1) = R2 - distance_segment_circle(x(i, :),x(i+1, :),Center2,n_discretization, false);
    end
    if C(n+i+1) < 0
        C(n+i+1) = 0;
    end
end


%additional constarints to order the position of intermidiate points 
% %not always necessary, but useful when n becomes large
% for i=0:n
%     if i==0
%         C(2*n+2+i) = A(1) - x(1, 1);
%     elseif i == n
%         C(2*n+2+i) = x(n, 1) - B(1); 
%     else
%         C(2*n+2+i) = x(i, 1) - x(i+1, 1);
%     end
% end

Ceq = [];
