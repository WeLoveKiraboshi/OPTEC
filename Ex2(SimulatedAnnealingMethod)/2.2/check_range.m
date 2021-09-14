function f = check_range(value, lb, ub, num) 

logic = 1;
for n = 1:num
    logic_ = (value(n, 1) <= ub(n)) & (value(n, 1) >= lb(n));
    logic = logic & logic_;
end

f = logic;

end
