function [Center, Radius]=check_circle_pos(A,B,C,R)
Center = [];
Radius = [];
n_circles = size(C, 1); % number of obstacle circles
n_discretization = 20; % number of discritization used in distance_segment_circl()

P1 = []; %left bottom
P2 = [B(1) A(2)];
P3 = B;
P4 = [A(1) B(2)];


for k=1:n_circles
    f = 1;
    %check if the circle's center is within the rectangle
    f = (R(k) - distance_segment_circle(A,B,C(k, :),n_discretization, false) >= 0);
    %if f == True : preserve the point (the circle is within the rectangle)
    % else discard the circle.
    if f == 1
        Center = cat(1, Center, C(k, :));
        Radius = cat(1, Radius, R(k));
    end
end % end of for loop




end %end of function