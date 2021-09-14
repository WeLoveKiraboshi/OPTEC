function [x, x0,lb, ub, n, f, hist_x] = execute(cfg)

% params x: 2 intermidiate points
% x = (2×2) matrix

lb = zeros(cfg.n,2);
ub = 10*ones(cfg.n,2);

%random initialization of all intermidiate points (params M(x, y))
% 1. initialize with zeros
% 2. initialize with ones
% 3. initialize with intermidiate point between A and B
x = zeros(cfg.n,2);
x0 = cfg.A+(1/cfg.n)*(cfg.B-cfg.A);
for i=1:cfg.n-1
    M = cfg.A+(1/cfg.n)*(cfg.B-cfg.A) + (i/cfg.n)*(cfg.B-cfg.A)*(cfg.n-1)/cfg.n;
    x0 = cat(1, x0, M);
end
% x0 = (A+B)/2
% for i=1:n-1
%      x0 = cat(1, x0, (A+B)/2);
% end
%x0 = 10*ones(n, 2); %zeros(n,2);
%x0 = 10*rand(n, 2);
history = [];
options = optimset('Display', cfg.disp_type, 'Tolx', cfg.error_tr,'Tolfun', cfg.error_tr,'MaxFunEvals', 5000,'MaxIter', 200000 ,'FunValCheck','on', 'OutputFcn', @myoutput);
function stop = myoutput(x,optimvalues,state);
    stop = false;
    if isequal(state, 'iter')
        history = cat(1, history, reshape(x,[1,cfg.n,2]));
    end
end 
A_ = [];
b_ = [];
Aeq_ = [];
beq_ = [];
x = fmincon(@(x)objective(x, cfg.A, cfg.B), x0, A_, b_, Aeq_, beq_, lb, ub, @(x)constraints(x, cfg.A, cfg.B, cfg.C, cfg.R, cfg.Rect, cfg), options);


%check result
if check_result(cfg.A, cfg.B, cfg.C, cfg.R, cfg.Rect, x, cfg) % succeed
    n = cfg.n;
else % failed
    n = -1;
end

% save the otpimized path length
f = objective(x, cfg.A, cfg.B);

% save the history of params in fmincon steps
hist_x = history;

end % end of function
