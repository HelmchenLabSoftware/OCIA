load myrois
load pixels_to_remove

mat=zeros(10000,1);
%mat(roi_tar)=1;
%mat(roi_f1late)=1;
%mat(roi_f2)=1;
%mat(roi_f3)=1;
%mat(roi_f4)=1;
%mat(roi_f5)=1;
% mat(roi_f6)=1;
mat(roi_circ_left)=1;
mat(roi_circ_right)=1;
mat(roi_circ_middle)=1;
mat(roi_bg_left)=1;
mat(roi_bg_right)=1;
mat(roi_bg_middle)=1;
mat(pixels_to_remove)=10;
figure;
mimg(mat,100,100,0,1);

hold on
xy = [];
n = 0;
% Loop, picking up the points.
but = 1;
while but == 1
    [xi,yi,but] = ginput(1);
    plot(xi,yi,'ro')
    n = n+1;
    xy(:,n) = [xi;yi];
end

% Interpolate with a spline curve and finer spacing.
t = 1:n;
ts = 1:0.1:n;
xys = spline(t,xy,ts);

% Plot the interpolated curve.
%figure
%plot(xys(1,:),xys(2,:));
pixels_circ = unique(round(xys)','rows');

for i = 1:length(pixels_circ)
    pixel_circ_index(i) = xy2ind(pixels_circ(i,1),pixels_circ(i,2),100);
end


%for regular data 1111c,d,h etc.
bar_circ=repmat(pixels_circ,[1 1 5]);
bar_circ(:,2,1)=pixels_circ(:,2)-2;
bar_circ(:,2,2)=pixels_circ(:,2)-1;
bar_circ(:,2,3)=pixels_circ(:,2)+0;
bar_circ(:,2,4)=pixels_circ(:,2)+1;
bar_circ(:,2,5)=pixels_circ(:,2)+2;

%for irregular data: when there is circle 2511 1811 1203 etc
%  bar_circ=repmat(pixels_circ,[1 1 5]);
%  bar_circ(:,2,1)=pixels_circ(:,2)-2;
%  bar_circ(:,2,2)=pixels_circ(:,2)-3;
%  bar_circ(:,2,3)=pixels_circ(:,2)-4;
%  bar_circ(:,2,4)=pixels_circ(:,2)-5;
%  bar_circ(:,2,5)=pixels_circ(:,2)-6;



k=0;
for j=1:5
    for i = 1:length(pixels_circ)
        k=k+1;
        bar_circ_index(k) = xy2ind(bar_circ(i,1,j),bar_circ(i,2,j),100);
    end
end 


%%

hold on
xy = [];
n = 0;
% Loop, picking up the points.
but = 1;
while but == 1
    [xi,yi,but] = ginput(1);
    plot(xi,yi,'ro')
    n = n+1;
    xy(:,n) = [xi;yi];
end

% Interpolate with a spline curve and finer spacing.
t = 1:n;
ts = 1:0.1:n;
xys = spline(t,xy,ts);

% Plot the interpolated curve.
%figure
%plot(xys(1,:),xys(2,:));
pixels_bg = unique(round(xys)','rows');

for i = 1:length(pixels_bg)
    pixel_bg_index(i) = xy2ind(pixels_bg(i,1),pixels_bg(i,2),100);
end


bar_bg=repmat(pixels_bg,[1 1 5]);
bar_bg(:,2,1)=pixels_bg(:,2)-2;
bar_bg(:,2,2)=pixels_bg(:,2)-1;
bar_bg(:,2,4)=pixels_bg(:,2)+1;
bar_bg(:,2,5)=pixels_bg(:,2)+2;



k=0;
for j=1:5
    for i = 1:length(pixels_bg)
        k=k+1;
        bar_bg_index(k) = xy2ind(bar_bg(i,1,j),bar_bg(i,2,j),100);
    end
end 









