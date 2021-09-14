function make_gif_animation(A, B, C, R, Rect, hist_x, lb, ub, cfg)

n = size(hist_x, 2); % number of intermidiate points
n_circles = size(C, 1); % number of obstacle circles
n_walls = size(Rect, 1); % number of rectangle walls
hight = 800; % プロットするfigureの縦幅
width = 800; % プロットするfigureの横幅
sizen= 512;


delaytime = 0.5; %frame rate
%h = figure; %('Position',[0 0 width hight]);

filename = 'testAnimated.gif'; % 
disp(['Writing gif files..... file_path = ./'+string(filename)]);

for hist_step = 1:size(hist_x, 1)
    x = reshape(hist_x(hist_step, :, :), [n,2]);
    
    f = figure('visible','off');
    % Fix the axis limits.
    xlim([lb(1,1) ub(1,1)]);
    ylim([lb(1,2) ub(1,2)]);

    % Set the axis aspect ratio to 1:1.
    axis square;
    %axis tight manual % this ensures that getframe() returns a consistent size
    
    text(1, 5, " steps="+string(hist_step));

    %show walls with Rectangles
    for k=1:n_walls
        rectangle('Position',Rect(k, :),'FaceColor',[0 .5 .5],'EdgeColor','k','LineWidth',1);
    end

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
    text(A(1), A(2), "  A");
    viscircles(A,0.1,'Color','r');
    text(B(1), B(2), "  B");
    viscircles(B,0.1,'Color','r');
    for i=1:n
        M = x(i, :);
        text(M(1), M(2), "  M"+i);
        viscircles(M,0.1,'Color','b');
    end

    for k=1:n_circles
        viscircles(C(k, :),R(k),'Color','k');
    end


    drawnow; % figureを更新する
    % Capture the plot as an image
    frame = getframe(gca);
    im = frame2im(frame);
    [imind,cm] = rgb2ind(im,256);
    %imwrite(frame.cdata, 'myfilename.png')
    % Write to the GIF File
    if hist_step == 1
        imwrite(imind,cm,filename,'gif', 'Loopcount',inf,'DelayTime',delaytime);
    else
        imwrite(imind,cm,filename,'gif','WriteMode','append','DelayTime',delaytime);
    end
end

disp(['saved gif file -> ./'+string(filename)]);


end