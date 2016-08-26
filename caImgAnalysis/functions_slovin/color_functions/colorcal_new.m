
%% from rgb to candella
rgb=[120 57 57];

rf = 255^2.2/16.552; rx = 0.621; ry = 0.344;
gf = 255^2.2/49.351; gx = 0.277; gy = 0.619;
bf = 255^2.2/8.052;  bx = 0.150; by = 0.069;

rY = (rgb(1).^2.2)./rf; %Luminance for red values
gY = (rgb(2).^2.2)./gf; %Luminance for red values
bY = (rgb(3).^2.2)./bf; %Luminance for red values

Y = (rY+gY+bY) %luminance in candella
YN = (rY+gY+bY)*74/100; %normalized luminance

%% from candella to rgb for red, green and blue

can=2;

r=(can*rf).^(1/2.2)
g=(can*gf).^(1/2.2)
b=(can*bf).^(1/2.2)


%% from candella to gray




