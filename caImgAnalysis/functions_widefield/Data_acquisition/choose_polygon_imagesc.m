function roi = choose_polygon_imagesc(pixels)
% choose polygon (open an image first on figure 100)
% The function returns a vector of all the pixels indices in a chosen polygon

figure(100);

count=1;
[Xsp,Ysp,cc] = ginput(1);
hold on
plot_sp = plot(Xsp(1),Ysp(1),'b','linewidth',1);

while cc~=3
    count=count+1;
    [Xsp(count),Ysp(count),cc]=ginput(1);
    set(plot_sp,'xdata',Xsp,'ydata',Ysp);
end

Xind = ones(pixels,1)*(1:pixels);
Yind = (1:pixels)'*ones(1,pixels);
in_pol = inpolygon(Xind,Yind,Xsp,Ysp);
%in_pol = in_pol';
vec = double(in_pol);
vec = reshape(vec,pixels^2,1);
roi = find(vec==1);

%% Check
% mat = zeros(100);
% mat(roi) = 1;
% mat = reshape(mat,10000,1);
% figure;mimg(mat,100,100);

