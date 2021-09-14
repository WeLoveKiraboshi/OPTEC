function disp_optim_path(A, B, C, R, x, lb, ub)

% Clear the axes.
cla
 
% Fix the axis limits.
xlim([lb(1) ub(1)])
ylim([lb(2) ub(2)])
 
% Set the axis aspect ratio to 1:1.
axis square
 
t = title(['4.1(a) optimized path for 2 segments'])
t.FontSize = 16;
 
% Display the circles.
%colors = {'b','r','g','y','k'}
viscircles(C,R,'Color','b');
segment1 = line([x(1), A(1)],[x(2), A(2)]); %line segment1
segment2 = line([x(1), B(1)],[x(2), B(2)]); %line segment2
text(A(1), A(2), "A("+A(1)+","+A(2)+")")
text(B(1), B(2), "B("+B(1)+","+B(2)+")")
text(x(1), x(2), "M("+x(1)+","+x(2)+")")
end