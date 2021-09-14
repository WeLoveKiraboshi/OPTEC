function [Center, Radius]=check_circle_pos(A,B,C,R, Rect, type, cfg)
Center = [];
Radius = [];
n_circles = size(C, 1); % number of obstacle circles
n_walls = size(Rect, 1); % number of obstacle circles
n_discretization = cfg.n_discretization; % number of discritization used in distance_segment_circl()

P1 = A %left bottom
P2 = [B(1) A(2)];
P3 = B;
P4 = [A(1) B(2)];

if strcmp(type, 'inrect')
    for k=1:n_circles
        f = 1;
        %check if the circle's center is within the rectangle
        if (min(A(1), B(1))<=C(k, 1)) && (C(k, 1)<=max(A(1), B(1))) && (min(A(2), B(2))<=C(k, 2)) && (C(k, 2)<=max(A(2), B(2)))
            %this circle have to be preserved
            f = 1;
        else
            % check if the circle cross the rectangle
            f1 = (R(k) - distance_segment_circle(P1,P2,C(k, :),n_discretization, false) >= 0);
            f2 = (R(k) - distance_segment_circle(P2,P3,C(k, :),n_discretization, false) >= 0);
            f3 = (R(k) - distance_segment_circle(P3,P4,C(k, :),n_discretization, false) >= 0);
            f4 = (R(k) - distance_segment_circle(P4,P1,C(k, :),n_discretization, false) >= 0);
            if f1 || f2 || f3 || f4
                f = 1;
            else
                f = 0;
            end
        end

        %if f == True : preserve the point (the circle is within the rectangle)
        % else discard the circle.
        if f == 1
            Center = cat(1, Center, C(k, :));
            Radius = cat(1, Radius, R(k));
        end
    end % end of for loop
            
elseif strcmp(type, 'online')

    for k=1:n_circles
        f = 1;
        %check if the circle's center is within the rectangle
        f = (R(k) - distance_segment_circle(A,B,C(k, :),n_discretization, false) >= 0);
        %if f == True : preserve the point (the circle is within the rectangle)
        % else discard the circle.
        if f == 1
            Center = cat(1, Center, C(k, :));
            Radius = cat(1, Radius, R(k));
        end
    end % end of for loop

elseif strcmp(type, 'none')
        
    Center = C;
    Radius = R;
    
else
    
    disp(['type: ' type ' does not exists in check_circle_pos.m']);
    stop;
    
end



end %end of function