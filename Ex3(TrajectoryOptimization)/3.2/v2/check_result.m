function f=check_result(A, B, C1, R1, C2, R2, x, n)

n_discretization = 10;
f = true;
for i=0:n
    if i==0
        f = f * ((R1 - distance_segment_circle(A, x(1, :),C1, n_discretization, false)) <= 0);
        f = f * ((R2 - distance_segment_circle(A, x(1, :),C2, n_discretization, false)) <= 0);
    elseif i == n
        f = f * ((R1 - distance_segment_circle(B, x(n, :),C1, n_discretization, false)) <= 0);
        f = f * ((R2 - distance_segment_circle(B, x(n, :),C2, n_discretization, false)) <= 0);
    else
        f = f * ((R1 - distance_segment_circle(x(i, :), x(i+1, :),C1, n_discretization, false)) <= 0);
        f = f * ((R2 - distance_segment_circle(x(i, :), x(i+1, :),C2, n_discretization, false)) <= 0);
    end
end

end %end of function