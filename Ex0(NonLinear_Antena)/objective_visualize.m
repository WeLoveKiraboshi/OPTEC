function f=fun(X, Y)
%existing antena location
C1= [5, 10];
C2= [10, 5];
C3= [0, 12];
C4= [12, 0];
W1 = 200;
W2 = 150;
W3 = 200;
W4 = 300;
f1 = W1*(power(X-C1(1), 2)+power(Y-C1(2), 2));
f2 = W2*(power(X-C2(1), 2)+power(Y-C2(2), 2));
f3 = W3*(power(X-C3(1), 2)+power(Y-C3(2), 2));
f4 = W4*(power(X-C4(1), 2)+power(Y-C4(2), 2));
f = f1 + f2 + f3 + f4;