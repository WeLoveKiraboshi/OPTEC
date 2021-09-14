function [min_dist, is_out] = distance_segment_wall(Q1, Q2, P1, P2, P3, P4, n, show)

% d1 = det([Q1-Q2;P1-Q1])/norm(Q1-Q2); %+norm(Q1-P1)+norm(Q2-P1);
% d2 = det([Q1-Q2;P2-Q1])/norm(Q1-Q2); %+norm(Q1-P2)+norm(Q2-P2);
% d3 = det([Q1-Q2;P3-Q1])/norm(Q1-Q2); %+norm(Q1-P3)+norm(Q2-P3);
% d4 = det([Q1-Q2;P4-Q1])/norm(Q1-Q2); %+norm(Q1-P4)+norm(Q2-P4);
% d = [d1 d2 d3 d4];

corner_array = [];

if P1(1) ~= 0 && P1(2) ~= 0 && P1(1) ~= 10 && P1(2) ~= 10
    corner_array = cat(1,corner_array,P1);
end
if P2(1) ~= 0 && P2(2) ~= 0 && P2(1) ~= 10 && P2(2) ~= 10
    corner_array = cat(1,corner_array,P2);
end
if P3(1) ~= 0 && P3(2) ~= 0 && P3(1) ~= 10 && P3(2) ~= 10
    corner_array = cat(1,corner_array,P3);
end
if P4(1) ~= 0 && P4(2) ~= 0 && P4(1) ~= 10 && P4(2) ~= 10
    corner_array = cat(1,corner_array,P4);
end
corner_array_length = size(corner_array,1);
norm_list = zeros(corner_array_length,1);

corner_thr = 0.01;
is_out = 1;
for i=0:n
    M = Q2 + (i/n)*(Q1-Q2);
    is_out = is_out * ~check_inside_triangle(M, P1, P2, P3, P4);
    
    %P1, P2, P3, P4 : corner points of a rect
    %check each points whether it is attached to the configuration space or
    %not.
    % Ex1) if P1 & P2 is attached to the  bottom side of config
    % space,  d(i+1) = min(norm(P3-M), norm(P4-M));
    % Ex2) if P3 & P4 is attached to the  bottom side of config
    % space,  d(i+1) = min(norm(P1-M), norm(P2-M));
    % Ex3) if 4 points aren't attached to the 4 side of config
    % space,  d(i+1) = min(norm(P1-M), norm(P2-M), norm(P3-M), norm(P4-M));
    
    for j=1:corner_array_length
        norm_list(j) = norm(corner_array(j, :)-M);
    end
    if sum(norm_list < corner_thr) >= 1 
        % if M is located close to the corner point of either P1,P2,P3,P4 too much,
        % we discard the d(i+1) from candidate.
        %disp("M=(" + M(1) + ","+M(2) + ") distance=" + min(norm_list)) 
        d(i+1) = 1;
    else
        d(i+1) = min(norm_list);
    end
    
    if show
        mess = "M=(" + M(1) + ","+M(2) + ") distance=" + d(i+1);
        disp(mess);
    end
end


min_dist = min(d);



% d1 = det([Q1-Q2;P1-Q1])/norm(Q1-Q2); %+norm(Q1-P1)+norm(Q2-P1);
% d2 = det([Q1-Q2;P2-Q1])/norm(Q1-Q2); %+norm(Q1-P2)+norm(Q2-P2);
% d3 = det([Q1-Q2;P3-Q1])/norm(Q1-Q2); %+norm(Q1-P3)+norm(Q2-P3);
% d4 = det([Q1-Q2;P4-Q1])/norm(Q1-Q2); %+norm(Q1-P4)+norm(Q2-P4);
% d = [d1 d2 d3 d4];
% when all points are over or under the line  -> retur minimum 1 point
% distance
% if size(find(d>= 0),2) == 4 || size(find(d<= 0),2) == 4
%     min_dist = min(abs(d)); 
% when 1 point is only over or under the line  -> return 2nd longest
% distance
% elseif size(find(d>= 0),2) == 1 || size(find(d<= 0),2) == 1
%     Que = sort(abs(d),'descend'); 
%     min_dist = Que(1, 2);
% else 
%     positive_list = find(d>= 0);
%     d_positive_sum = 0;
%     for i=1:size(positive_list, 2)
%         d_positive_sum = d_positive_sum + abs(d(positive_list(i)));
%     end
%     negative_list = find(d<= 0);
%     d_negative_sum = 0;
%     for i=1:size(negative_list, 2)
%         d_negative_sum = d_negative_sum + abs(d(negative_list(i)));
%     end
%     min_dist = min(d_positive_sum, d_negative_sum);
% end






end %end of function