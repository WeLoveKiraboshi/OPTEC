function disp_optim_path(A, B, C, R, x, lb, ub)

% Clear the axes.
cla
 
% Fix the axis limits.
xlim([lb(1) ub(1)])
ylim([lb(2) ub(2)])
 
% Set the axis aspect ratio to 1:1.
axis square
 
t = title(['4.1(b) optimized path for 2 segments'])
t.FontSize = 16;
 
% Display the circles.
%colors = {'b','r','g','y','k'}
viscircles(C,R,'Color','b');

n = size(x, 1); % number of intermidiate points
for i=0:n
    if i==0
        segment1 = line([x(1, 1), A(1)],[x(1, 2), A(2)]); %line segment1
    elseif i == n
        segmentn = line([x(n, 1), B(1)],[x(n, 2), B(2)]); %line segment2
    else
        line([x(i, 1), x(i+1, 1)],[x(i, 2), x(i+1, 2)]); %line segment between intermidiate points
    end
end



text(C(1), C(2), "\leftarrow Center ("+C(1)+","+C(2)+")");
text(A(1), A(2), "\leftarrow A ("+A(1)+","+A(2)+")");
text(B(1), B(2), "\leftarrow B ("+B(1)+","+B(2)+")");
for i=1:n
    M = x(i, :);
    text(M(1), M(2), "\leftarrow M"+i+" ("+M(1)+","+M(2)+")");
end

end %end of function