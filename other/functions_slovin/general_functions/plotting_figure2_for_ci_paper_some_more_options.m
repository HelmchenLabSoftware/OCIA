
x=(20:10:1120)-280;

figure
errorbar(x(20:60),mean(con_circ(20:60,:),2)-1,std(con_circ(20:60,:),0,2)/sqrt(size(con_circ(:,:),2)))
hold on
errorbar(x(20:60),mean(non_circ(20:60,:),2)-1,std(non_circ(20:60,:),0,2)/sqrt(size(non_circ(:,:),2)),'r')
errorbar(x(20:60),mean(bl_circ(20:60,1:2:end),2)-1,std(bl_circ(20:60,:),0,2)/sqrt(size(bl_circ(:,:),2)),'g')
xlim([-50 300])
ylim([-.3e-3 1.4e-3])

figure
errorbar(x(20:60),mean(con_bg(20:60,:),2)-1,std(con_bg(20:60,:),0,2)/sqrt(size(con_bg,2)))
hold on
errorbar(x(20:60),mean(non_bg(20:60,:),2)-1,std(non_bg(20:60,:),0,2)/sqrt(size(non_bg,2)),'r')
errorbar(x(20:60),mean(bl_bg(20:60,1:2:end),2)-1,std(bl_bg(20:60,:),0,2)/sqrt(size(bl_bg,2)),'g')
xlim([-50 300])
ylim([-.3e-3 1.4e-3])


con=c1;
non=c5;
time1=34:35;
time2=56:57;
roi1=roi_contour;
roi2=roi_bg_in;


h=zeros(10000,1);
h(roi1)=1;
h(roi2)=1;

y=mfilt2(mean(con(:,time2),2)-1,100,100,1,'lm');
y(pixels_to_remove)=10;
figure
mimg(y,100,100,0.3e-3,1e-3);colormap(mapgeog)
hold on
contour(reshape(h,100,100)')


y=mfilt2(mean(non(:,time2),2)-1,100,100,1,'lm');
y(pixels_to_remove)=10;
figure
mimg(y,100,100,0.3e-3,1e-3);colormap(mapgeog)
hold on
contour(reshape(h,100,100)')


figure;
scatter(mean(non(roi1,time2),2)-1,mean(con(roi1,time2),2)-1)
hold on
plot(0:0.0001:3e-3,0:0.0001:3e-3,'k')
%plot((0:0.0001:3e-3),(0:0.0001:3e-3)+top_circ,'r')
%plot((0:0.0001:3e-3),(0:0.0001:3e-3)+bottom_circ,'r')
xlim([0 2e-3]);ylim([0 2e-3])
ranksum(mean(non(roi1,time2),2)-1,mean(con(roi1,time2),2)-1)

figure;
scatter(mean(non(roi2,time2),2)-1,mean(con(roi2,time2),2)-1)
hold on
plot(0:0.0001:3e-3,0:0.0001:3e-3,'k')
%plot((0:0.0001:3e-3),(0:0.0001:3e-3)+top_bg,'r')
%plot((0:0.0001:3e-3),(0:0.0001:3e-3)+bottom_bg,'r')
xlim([0 2e-3]);ylim([0 2e-3])
ranksum(mean(non(roi2,time2),2)-1,mean(con(roi2,time2),2)-1)




y=mfilt2(mean(con(:,time1),2)-1,100,100,1,'lm');
y(pixels_to_remove)=10;
figure
mimg(y,100,100,.2e-3,1.2e-3);colormap(mapgeog)
hold on
contour(reshape(h,100,100)')
hold on

y=mfilt2(mean(non(:,time1),2)-1,100,100,1,'lm');
y(pixels_to_remove)=10;
figure
mimg(y,100,100,.2e-3,1.2e-3);colormap(mapgeog)
hold on
contour(reshape(h,100,100)')
hold on
   


figure;
scatter(mean(non(roi1,time1),2)-1,mean(con(roi1,time1),2)-1)
hold on
plot(0:0.0001:3e-3,0:0.0001:3e-3,'k')
%plot((0:0.0001:3e-3),(0:0.0001:3e-3)+top_circ,'r')
%plot((0:0.0001:3e-3),(0:0.0001:3e-3)+bottom_circ,'r')
xlim([0 2e-3]);ylim([0 2e-3])
ranksum(mean(non(roi1,time1),2)-1,mean(con(roi1,time1),2)-1)

figure;
scatter(mean(non(roi2,time1),2)-1,mean(con(roi2,time1),2)-1)
hold on
plot(0:0.0001:3e-3,0:0.0001:3e-3,'k')
%plot((0:0.0001:3e-3),(0:0.0001:3e-3)+top_bg,'r')
%plot((0:0.0001:3e-3),(0:0.0001:3e-3)+bottom_bg,'r')
xlim([0 2e-3]);ylim([0 2e-3])
ranksum(mean(non(roi2,time1),2)-1,mean(con(roi2,time1),2)-1)





