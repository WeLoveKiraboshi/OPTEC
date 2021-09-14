function f=check_result(A, B, Center, R, x)

n_discretization = 10;
f = true;
n = size(x, 1); % number of intermidiate points
n_circles = size(Center, 1); % number of obstacle circles


for k=0:n_circles-1
    for i=0:n
        if i==0
            f = f * ((R(k+1) - distance_segment_circle(A, x(1, :),Center(k+1, :), n_discretization, false)) <= 0);
        elseif i == n
            f = f * ((R(k+1) - distance_segment_circle(B, x(n, :),Center(k+1, :), n_discretization, false)) <= 0);
        else
            f = f * ((R(k+1) - distance_segment_circle(x(i, :), x(i+1, :),Center(k+1, :), n_discretization, false)) <= 0);
        end
    end
end

end %end of function