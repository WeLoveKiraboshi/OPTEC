function [value] = Disturb(value,num)
    weight = 0.001; % weightning parameter to produce position nearby 'value'

    for n = 1:num
        p = (2*rand-1); % sample from uniform distribution[-1, 1]
        value(n,1) = value + weight*p;
    end
end