function [] = visualize(X0, Xmax, d, answer) 

%visualize 3D graph
%X = -10:0.3:16;
%Y = X;
%figure(2)
X = [-10:0.5:18];
Y = [-10:0.5:18];
[X1, Y1] = meshgrid(X, Y);
Z = (3*X1+2*Y1-1).^2+(X1-Y1+1).^2;
clf; surf(X1, Y1, Z);
hold on
x = X0(1)+d(1)*X;
y = X0(2)+d(2)*X;
z = (3*x+2*y-1).^2+(x-y+1).^2;
plot3(x, y, z,'-r.') %line (X0+x*d)
xlabel('x')
ylabel('y')
zlabel('z')
t0 = text(-8,-8,objective([-8, -8]),'\leftarrow X0')
tmax = text(7,-0.5,objective([7, -0.5]),'\leftarrow Xmax')
t0(1).Color = 'red';
t0(1).FontSize = 14;
tmax(1).Color = 'red';
tmax(1).FontSize = 14;




%visualize contour 
figure(3);
clf; contour(X1, Y1, Z,'LevelStep',100); 
colorbar
hold on
plot(x,y, '-r.') % line (X0+x*d) projected on 2D plane
xlabel('x')
ylabel('y')
text(X0(1),X0(2),'\leftarrow X0')
text(Xmax(1),Xmax(2),'\leftarrow Xmax')
text(answer(1),answer(2),'\leftarrow minimum')

end
