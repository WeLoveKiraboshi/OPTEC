function f=check_result(A, B, Center, R, Rect, x, cfg)

n_discretization = cfg.n_discretization;
f = true;
n = size(x, 1); % number of intermidiate points
n_circles = size(Center, 1); % number of obstacle circles
n_walls = size(Rect, 1); % number of obstacle circles


if cfg.avoid_circles
for k=0:n_circles-1
    for i=0:n
        if i==0
            f = f * ((R(k+1) - distance_segment_circle(A, x(1, :),Center(k+1, :), n_discretization, false)) < 0);
        elseif i == n
            f = f * ((R(k+1) - distance_segment_circle(B, x(n, :),Center(k+1, :), n_discretization, false)) < 0);
        else
            f = f * ((R(k+1) - distance_segment_circle(x(i, :), x(i+1, :),Center(k+1, :), n_discretization, false)) < 0);
        end
    end
    %disp([string(i), '  :  ', f])
end
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
                f = f * 1;
            else
                f = f * 0;
            end
        elseif i == n
            [min_dist, is_out] = distance_segment_wall(x(n, :),B, P1, P2, P3, P4,n_discretization, false);
            if is_out
                f = f * 1;
            else
                f = f * 0;
            end
        else
            [min_dist, is_out] = distance_segment_wall(x(i, :),x(i+1, :), P1, P2, P3, P4,n_discretization, false);
            if is_out
                f = f * 1;
            else
                f = f * 0;
            end
        end
    end
end
end





end %end of function