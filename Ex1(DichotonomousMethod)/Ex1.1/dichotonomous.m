function optimal = dichotonomous(f, xmin, xmax, n, epsilon)
%xmin = 0;
%xmax = 100;
%n = 100; % num of trials
%epsilon = 1;

%stop criteria
%*1: if the nuymber of Iteration is over n
%*2: absolite error is less than epsilon

disp('Iteration     xmin      xmax       x1         x2      f(xmin)     f(xmax)')
disp('=========================================================================')
for i = 1:n
   x1 = (xmin + xmax - epsilon) / 2;
   x2 = (xmin + xmax + epsilon) / 2;
   if f(x1) < f(x2)
       xmin = xmin;
       xmax = x2;
   else
       xmin = x1;
       xmax = xmax;
   end
   fprintf('%4d', i)
   fprintf('   ')
   fprintf('%11.4f', xmin);
   fprintf('%11.4f', xmax);
   fprintf('%11.4f', x1);
   fprintf('%11.4f', x2);
   fprintf('%11.4f', f(x1));
   fprintf('%11.4f', f(x2));
   fprintf('   ')
   disp('¥n');
   if abs(xmin-xmax) <= epsilon
       break
   end

optimal = min(xmin, xmax);
   
    
end