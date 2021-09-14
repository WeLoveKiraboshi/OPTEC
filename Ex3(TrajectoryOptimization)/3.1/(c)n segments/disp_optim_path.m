function disp_optim_path(A, B, C, R, x, lb, ub)

% Clear the axes.
cla

% number of intermidiate points
n = size(x, 1); 

% Fix the axis limits.
xlim([lb(1,1) ub(1,1)])
ylim([lb(1,2) ub(1,2)])
 
% Set the axis aspect ratio to 1:1.
axis square

 
t = title(["4.1(c) optimized path for " + string(n) + " segments"])
t.FontSize = 16;

optimized_lenth = objective(x, A, B);
disp(["optimized length : " , string(optimized_lenth)])

 
for i=0:n
    if i==0
        segment1 = line([x(1, 1), A(1)],[x(1, 2), A(2)]); %line segment1
    elseif i == n
        segmentn = line([x(n, 1), B(1)],[x(n, 2), B(2)]); %line segment2
    else
        line([x(i, 1), x(i+1, 1)],[x(i, 2), x(i+1, 2)]); %line segment between intermidiate points
    end
end



text(C(1), C(2), " C");
text(A(1), A(2), "  A");
viscircles(A,0.1,'Color','b');
text(B(1), B(2), "  B");
viscircles(B,0.1,'Color','b');

if n < 10
    for i=1:n
        M = x(i, :);
        text(M(1), M(2), "  M"+i);
        viscircles(M,0.1,'Color','b');
    end
end



% Display the circles.
%colors = {'b','r','g','y','k'}
%viscircles(C,R,'Color','b');
% rectangle(...
%     'Position', [C(1)-R, C(2)-R, R*2, R*2],...
%     'Curvature',[1 1],...
%     'FaceColor','r')
viscircles(C,R,'Color','k');

end %end of function