function [] = visualize(hist, n_trials)  %X0, Xmax, d, answer

%visualize 3D graph

figure(2);
X = [-10:0.5:18];
Y = [-10:0.5:18];
[X1, Y1] = meshgrid(X, Y);
Z = (3*X1+2*Y1-1).^2+(X1-Y1+1).^2;
clf; surf(X1, Y1, Z);
hold on;
xlabel('x');
ylabel('y');
zlabel('z');
for i=1:n_trials
    X0 = hist(i).X0;
    d = hist(i).d;
    x = X0(1)+d(1)*X;
    y = X0(2)+d(2)*X;
    z = (3*x+2*y-1).^2+(x-y+1).^2;
    plot3(x, y, z,'-r.'); %line (X0+x*d)
    hold on;
end



t0 = text(-8,-8,objective([-8, -8]),'\leftarrow X0');
tmax = text(7,-0.5,objective([7, -0.5]),'\leftarrow Xmax');
t0(1).Color = 'red';
t0(1).FontSize = 14;
tmax(1).Color = 'red';
tmax(1).FontSize = 14;




% %visualize contour 
% figure(3);
% clf; contour(X1, Y1, Z,'LevelStep',100); 
% colorbar;
% xlabel('x');
% ylabel('y');
% xlim([-10 18]);
% ylim([-10 18]);
% for i=1:1
%     X0 = hist(i).X0;
%     Xmax = hist(i).Xmax;
%     answer = hist(i).answer;
%     d = hist(i).d;
%     x = X0(1)+d(1)*X;
%     y = X0(2)+d(2)*X;
%     plot(x,y, '-r.') % line (X0+x*d) projected on 2D plane
%     hold on;
%     %text(X0(1),X0(2),'\leftarrow X0')
%     %text(Xmax(1),Xmax(2),'\leftarrow Xmax')
%     %text(answer(1),answer(2),'\leftarrow minimum')
% end



end
