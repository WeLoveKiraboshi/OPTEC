function optimal = dichotonomous_multi(X0, d, xmin, xmax, n, epsilon, display)
%stop criteria
%*1: if the nuymber of Iteration is over n
%*2: absolite error is less than epsilon
L = xmax + xmin; % = 15-0
X1 = [0, 0];
X2 = [0, 0];
xfinal = [0, 0];
    
disp('Iteration        x1                 x2            f(Xmin)       f(Xmax)')
disp('==========================================================================================================')
for i = 1:n
    alpha1 = (L - epsilon)/2;
    alpha2 = (L + epsilon)/2;
        
    X1 = X0 + (alpha1 * d);
    X2 = X0 + (alpha2 * d);
    if objective(X1) < objective(X2)
        xmax = alpha2;
    else
        xmin = alpha1;    
    end
    %X1 = X0 + (alpha1 * d(1));
    %X2 = X0 + (alpha2 * d(2));
    xfinal(1) = (X1(1) + X2(1))/2;
    xfinal(2) = (X1(2) + X2(2))/2;
    f = objective(xfinal);
    y=[X1 X2];
    L = xmax + xmin; 
    if display
        hold on;
        plot(X1(:,1), X1(:,2),'r*')
        plot(X2(:,1), X2(:,2),'y*')
    end
    
    %check residual error to break loops
    if L <= 2*epsilon
        break
    end
    
    fprintf('%4d', i)
    fprintf('   ')
    fprintf('  (%5.4f, %5.4f)', X1(1), X1(2));
    fprintf('  (%5.4f, %5.4f)', X2(1), X2(2));
    fprintf('%11.4f', objective(X1));
    fprintf('%11.4f', objective(X2));
    fprintf('   ')
    disp('¥n');
        
end
disp(['optimized x = ('+string(xfinal(1))+', '+string(xfinal(2))+')']);
optimal = xfinal;
disp(['min f(x) '+string(objective(xfinal))]);
    
end