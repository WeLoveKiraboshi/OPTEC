function is_inside = check_inside_triangle(Q, P1, P2, P3, P4)
    x_min = P1(1);
    x_max = P2(1);
    y_min = P1(2);
    y_max = P3(2);
    % if point is on a edge -> it's outside of triangle
    if (x_min < Q(1) && Q(1) < x_max) && (y_min < Q(2) && Q(2) < y_max)
        is_inside = 1;
    else
        is_inside=0;
    end
end