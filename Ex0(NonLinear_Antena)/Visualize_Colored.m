X = -30:0.5:30;
Y = X;
[X1, Y1] = meshgrid(X, Y);
Z = (3*X1-3).^2 + (4*Y1-2).^2 + X1.*Y1;
figure(1);
clf; surf(X1, Y1, Z);
figure(2);
clf; contour(X1, Y1, Z);
figure(3);
clf; contourf(X1, Y1, Z);
figure(4);
clf; [c, h] = contour(X, Y, Z, [0, 1.e4, 2.e4]);