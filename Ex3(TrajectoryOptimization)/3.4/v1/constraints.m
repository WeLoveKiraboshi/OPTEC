function [C, Ceq]=constraints(x, A, B, Center, R, Rect, cfg)
%input argument:
%A = [xA, yA] coordinate of pointA
%B = [xB, yB] coordinate of pointB

n_discretization = cfg.n_discretization; % number of discritization used in distance_segment_circl()
n = size(x, 1); % number of intermidiate points
n_circles = size(Center, 1); % number of obstacle circles
n_walls = size(Rect, 1); % number of obstacle circles
n_circle_const = 0;
%min_thr = 3;

%avoid circles
if cfg.avoid_circles
for k=0:n_circles-1
    for i=0:n
        if i==0
            C(k*n+i+1) = R(k+1) - distance_segment_circle(A,x(1, :),Center(k+1, :),n_discretization, false);
        elseif i == n
            C(k*n+i+1) = R(k+1) - distance_segment_circle(x(n, :),B,Center(k+1, :),n_discretization, false);
        else
            C(k*n+i+1) = R(k+1) - distance_segment_circle(x(i, :),x(i+1, :),Center(k+1, :),n_discretization, false);
        end
        
    end
end
n_circle_const = (n_circles-1)*n+n+1;
end

% %avoid walls (rectangle)
if cfg.avoid_walls
for k=0:n_walls-1
    P1 = [Rect(k+1, 1), Rect(k+1, 2)]; %left bottom
    P2 = [Rect(k+1, 1)+Rect(k+1, 3), Rect(k+1, 2)]; %right bottom
    P3 = [Rect(k+1, 1)+Rect(k+1, 3), Rect(k+1, 2)+Rect(k+1, 4)]; %right top
    P4 = [Rect(k+1, 1), Rect(k+1, 2)+Rect(k+1, 4)]; %left top
    for i=0:n
        if i==0
            [min_dist, is_out] = distance_segment_wall(A, x(1, :), P1, P2, P3, P4,n_discretization, false);
            if is_out
                C(n_circle_const+k*n+i+1) = 0; %-min_dist;
            else
                C(n_circle_const+k*n+i+1) = min_dist;
            end
        elseif i == n
            [min_dist, is_out] = distance_segment_wall(x(n, :),B, P1, P2, P3, P4,n_discretization, false);
            if is_out
                C(n_circle_const+k*n+i+1) = 0; %-min_dist;
            else
                C(n_circle_const+k*n+i+1) = min_dist;
            end
        else
            [min_dist, is_out] = distance_segment_wall(x(i, :),x(i+1, :), P1, P2, P3, P4,n_discretization, false);
            if is_out
                C(n_circle_const+k*n+i+1) = 0; %-min_dist;
            else
                C(n_circle_const+k*n+i+1) = min_dist;
            end
        end
    end
end
end



Ceq = [];
