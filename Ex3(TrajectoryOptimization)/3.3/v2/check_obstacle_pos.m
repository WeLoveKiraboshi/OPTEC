function f = check_obstacle_pos(center, r, C, R, A, B)

% C: n * 2
% R: 1 * n
n = size(C, 1);
f = true;

%check whether the candidate circle is crossed with the exisiting cirlces
for i=1:n
    if norm(C(i, :)-center) < R(i)+r
        %2 circles are crossed
        f = f * false;
        break;
    end
end


%check whether the cadidate circle is within the rectabgle (0,0) - (10,10)
Q1 = [0,0];
Q2 = [0,10];
Q3 = [10, 10];
Q4 = [10, 0];
d1 = abs(det([Q1-Q2; center-Q1])/norm(Q1-Q2))
d2 = abs(det([Q2-Q3; center-Q2])/norm(Q2-Q3))
d3 = abs(det([Q3-Q4; center-Q3])/norm(Q3-Q4))
d4 = abs(det([Q4-Q1; center-Q4])/norm(Q4-Q1))
if (d1 < r) || (d2 < r) || (d3 < r) || (d4 < r)
    f = f * false;
end




%check whether the candidate circle contains A, B
if (norm(A-center) < r) || (norm(B-center) < r)
    f = f * false;
end




end