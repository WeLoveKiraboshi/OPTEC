function [C, R]=rand_circle_generator(n, A, B, min_rad, max_rad)

% n : num of circles
%


C = zeros(n, 2);
R = zeros(1, n);
for i=1:n
    while(1)
        center = (10-0).*rand(1,2) + 0;
        r = (max_rad-min_rad).*rand() + min_rad;
        if(check_obstacle_pos(center, r, C, R, A, B))
            C(i, :) = center;
            R(1, i) = r;
            break;
        end
    end
end


end