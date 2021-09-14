% LOAD CONFIG FILE
yaml_file = './model.yml'
cfg = ReadYaml(yaml_file);
if cfg.n >= 12 || cfg.n < 0
    disp(['number of segments is over max num 12 or under 0'])
    stop;
end

if cfg.random_circle_generate
    cfg.C0 = zeros(cfg.random_circle_num, 2);
    cfg.R0 = zeros(1, cfg.random_circle_num);
    [cfg.C0, cfg.R0] = rand_circle_generator(cfg.random_circle_num, cfg.A, cfg.B, cfg.random_circle_min_rad, cfg.random_circle_max_rad, cfg.Rect, cfg.n_discretization);
end    

%search in the rectangle defined by A, B and check if all circles are
%within this rectangle. if not, delete them and simplify the optimization
%problem
[cfg.C, cfg.R] = check_circle_pos(cfg.A, cfg.B, cfg.C0, cfg.R0, cfg.Rect, cfg.init_config_check_algorithm, cfg);

history = [];
    
if cfg.n_auto_tuning == true
    % set param to speed up the optimization 
    cfg.disp_type = 'off';
    cfg.error_tr = 1.e-10;
    for n_i=12:-1:1  %check the result from n=12 -> 1
        cfg.n = n_i;
        [x, x0,lb, ub, n, objective, hist_x] = execute(cfg);
        if n ~= -1
            disp(['optimized parameters found in n = '+string(cfg.n)]);
            %disp(x);
            result = struct('x', x, 'x0', x0, 'hist_x', hist_x, 'lb', lb,'ub', ub, 'n', n, 'objective', objective);
            history = cat(1, history, result);
        else
            disp(['optimimal path could not be found in n = '+string(cfg.n)]);
            %disp(x);
            %disp_optim_path(cfg.n, cfg.A, cfg.B, cfg.C, cfg.R, cfg.Rect, x, x0, lb, ub, cfg);
            % discard this step
        end
        
        if n_i == 1 
            if size(history, 1) > 0
                %search successful shortest path
                shortest_result = history(size(history, 1));
                for hist_idx=1:size(history, 1)
                    if history(hist_idx).objective < shortest_result.objective
                        %replace results
                        shortest_result = history(hist_idx);
                    end
                end
                disp(['optimized parameters in n = '+string(cfg.n)])
                disp(x);
                disp_optim_path(shortest_result.n, cfg.A, cfg.B, cfg.C, cfg.R, cfg.Rect, shortest_result.x, shortest_result.x0, shortest_result.hist_x, shortest_result.lb, shortest_result.ub, cfg);
                break;
            else
                %display final attempt n=1
                disp_optim_path(cfg.n, cfg.A, cfg.B, cfg.C, cfg.R, cfg.Rect, x, x0, hist_x, lb, ub, cfg);
                break;  
            end 
        else
            %repeat until n_i = 1
            continue;
        end
    end
        
else
    [x, x0,lb, ub, n, objective, hist_x] = execute(cfg);
    if n ~= -1
        disp(['optimized parameters in n = '+string(cfg.n)])
        disp(x);
        disp_optim_path(cfg.n, cfg.A, cfg.B, cfg.C, cfg.R, cfg.Rect, x, x0, hist_x, lb, ub, cfg);
        disp(['objective = '+string(objective)]);
    else
        disp(['optimimal path could not be found in n = '+string(n)])
        disp(x);
        disp_optim_path(cfg.n, cfg.A, cfg.B, cfg.C, cfg.R, cfg.Rect, x, x0, hist_x, lb, ub, cfg);
        disp(['objective = '+string(objective)]);
    end
end



%*****************************************************************************************
%All implementation comes to Yuki Saito (M1 JEMARO). 2021/5/1
%IF any, please contact below
%Yuki Saito
%TEL : (+81)80-2161-0882
%MAIL: yusa19971015@keio.jp
%website: http://www.hvrl.ics.keio.ac.jp/saito_y/site/
%ADDRESS: 5-29-4 Ima-ju hiyoshi #104, Hiyoshi, Yokohama, Yokohama city, 
%                        Kohoku Ward, Kanagawa Prefecture, 223-0061, Japan
%Keio University , School of Science for Open and Environment Systems,
%the department of information and computer science 
%****************************************************************************************
