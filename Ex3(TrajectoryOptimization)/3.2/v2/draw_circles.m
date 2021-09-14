colors = {'b','r','g','y','k'};
X = rand(5,1);
Y = rand(5,1);
radii = 0.1*rand(5,1);
figure
for kk = 1:5
  xCorner = X(kk) - radii(kk);
  yCorner = Y(kk) - radii(kk);
  rectangle(...
    'Position', [xCorner, yCorner, radii(kk)*2, radii(kk)*2],...
    'Curvature',[1 1],...
    'FaceColor',colors{kk})
end
axis equal
box on