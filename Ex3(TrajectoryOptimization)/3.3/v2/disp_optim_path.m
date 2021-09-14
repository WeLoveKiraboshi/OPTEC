function disp_optim_path(A, B, C0, R0, x, x0, lb, ub)

% Clear the axes.
cla
%figure

% number of intermidiate points
n = size(x, 1); % number of intermidiate points
n_circles = size(C0, 1); % number of obstacle circles

% Fix the axis limits.
xlim([lb(1,1) ub(1,1)])
ylim([lb(1,2) ub(1,2)])
 
% Set the axis aspect ratio to 1:1.
axis square


if check_result(A, B, C0, R0, x)
    result = "Acceptable";
else
    result = "Not Acceptable";
end

%add title 
t = title(["4.3 optimized path avoiding "+string(n_circles)+" circles with " + string(n+1) + " segments"], result,'Color','blue')
t.FontSize = 16;

optimized_lenth = objective(x, A, B);
disp(["optimized length : " , string(optimized_lenth)])

%add comment on the corrdinates of deduced intermidiate points
dim = [0.25 .5 .4 .4]; %position for the legend (x, y)
str = "";
for i=1:n
    str = str+"M"+i+"("+round(x(i, 1),2)+ ", "+round(x(i, 2),2)+")";
    if i ~= n
        str = str + newline;
    end
end
annotation('textbox',dim,'String',str,'FitBoxToText','on');


%display intermidiate n line segments (estimated path)
for i=0:n
    if i==0
        segment1 = line([x(1, 1), A(1)],[x(1, 2), A(2)]); %line segment1
    elseif i == n
        segmentn = line([x(n, 1), B(1)],[x(n, 2), B(2)]); %line segment2
    else
        line([x(i, 1), x(i+1, 1)],[x(i, 2), x(i+1, 2)]); %line segment between intermidiate points
    end
end


%display initial intermidiate line segments (before optimization)
for i=0:n
    if i==0
        segment1 = line([x0(1, 1), A(1)],[x0(1, 2), A(2)],'Color','red','LineStyle','--'); %line segment1
    elseif i == n
        segmentn = line([x0(n, 1), B(1)],[x0(n, 2), B(2)],'Color','red','LineStyle','--'); %line segment2
    else
        line([x0(i, 1), x0(i+1, 1)],[x0(i, 2), x0(i+1, 2)],'Color','red','LineStyle','--'); %line segment between intermidiate points
    end
end




text(A(1), A(2), "  A");
viscircles(A,0.1,'Color','b');
text(B(1), B(2), "  B");
viscircles(B,0.1,'Color','b');

% Display intermidiate points by small circles.
% To make it simple to visalize the path
%  we displayed 10 points at maximum.
if n <= 12
    for i=1:n
        M = x(i, :);
        text(M(1), M(2), "  M"+i);
        viscircles(M,0.1,'Color','b');

        M0 = x0(i, :);
        text(M0(1), M0(2), "  M"+i);
        viscircles(M0,0.1,'Color','r');
    end
end


% Display the circles.
%colors = {'b','r','g','y','k'}
%viscircles(C,R,'Color','b');
% 1st circle

t = linspace(0,2*pi,100);
% show all; the circles
for k=1:n_circles
    viscircles(C0(k, :),R0(k),'Color','k'); %'LineStyle','--'
end
% rectangle(...
%     'Position', [C(k, 1)-R(k), C(k, 2)-R(k), R(k)*2, R(k)*2],...
%     'Curvature',[1 1],...
%     'FaceColor','r')


end %end of function