function f = objective(x) 
    f= -x(1).*sin(sqrt(abs(x(1))))-x(2).*sin(sqrt(abs(x(2))));
end