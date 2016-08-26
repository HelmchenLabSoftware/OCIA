cd F:\Data\VSDI\Contour_integration\Smeagol\05Jan2011
load time_rois_for_fig2_ci_cleaned

time1=34:36;
time2=48:58;
roi1=roi_circle5;
roi2=roi_bg_out5;

x=(20:10:1120)-280;

figure
errorbar(x(20:60),mean(con_circ(20:60,:),2)-1,std(con_circ(20:60,:),0,2)/sqrt(size(con_circ(:,:),2)))
hold on
errorbar(x(20:60),mean(non_circ(20:60,:),2)-1,std(non_circ(20:60,:),0,2)/sqrt(size(non_circ(:,:),2)),'r')
errorbar(x(20:60),mean(bl_circ(20:60,1:2:end),2)-1,std(bl_circ(20:60,:),0,2)/sqrt(size(bl_circ(:,:),2)),'g')
xlim([-50 300])
ylim([-.3e-3 1.6e-3])

figure
errorbar(x(20:60),mean(con_bg(20:60,:),2)-1,std(con_bg(20:60,:),0,2)/sqrt(size(con_bg,2)))
hold on
errorbar(x(20:60),mean(non_bg(20:60,:),2)-1,std(non_bg(20:60,:),0,2)/sqrt(size(non_bg,2)),'r')
errorbar(x(20:60),mean(bl_bg(20:60,1:2:end),2)-1,std(bl_bg(20:60,:),0,2)/sqrt(size(bl_bg,2)),'g')
xlim([-50 300])
ylim([-.3e-3 1.6e-3])


h=zeros(10000,1);
h(roi1)=1;
h(roi2)=1;

y=mfilt2(mean(con(:,time2),2)-1,100,100,1,'lm');
y(pixels_to_remove)=10;
figure(100)
mimg(y,100,100,0.3e-3,1.4e-3);colormap(mapgeog)
hold on
contour(reshape(h,100,100)')
hold on
line([3 72],[34 36],'Marker','.','LineStyle','-','LineWidth',3,'Color','r')
line([72 92],[36 26],'Marker','.','LineStyle','-','LineWidth',3,'Color','r')
line([2 70],[45 48],'Marker','.','LineStyle','-','LineWidth',3,'Color','r')
line([70 96],[48 39],'Marker','.','LineStyle','-','LineWidth',3,'Color','r')   
text(100,46,'V1','FontSize',16)
text(100,35,'V2','FontSize',16)
text(96,22,'V4','FontSize',16)
    

y=mfilt2(mean(non(:,time2),2)-1,100,100,1,'lm');
y(pixels_to_remove)=10;
figure
mimg(y,100,100,0.3e-3,1.4e-3);colormap(mapgeog)
hold on
contour(reshape(h,100,100)')
hold on
line([3 72],[34 36],'Marker','.','LineStyle','-','LineWidth',3,'Color','r')
line([72 92],[36 26],'Marker','.','LineStyle','-','LineWidth',3,'Color','r')
line([2 70],[45 48],'Marker','.','LineStyle','-','LineWidth',3,'Color','r')
line([70 96],[48 39],'Marker','.','LineStyle','-','LineWidth',3,'Color','r')   
text(100,46,'V1','FontSize',16)
text(100,35,'V2','FontSize',16)
text(96,22,'V4','FontSize',16)
    


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
mimg(y,100,100,-.2e-3,1.2e-3);colormap(mapgeog)
hold on
contour(reshape(h,100,100)')
hold on
line([3 72],[34 36],'Marker','.','LineStyle','-','LineWidth',3,'Color','r')
line([72 92],[36 26],'Marker','.','LineStyle','-','LineWidth',3,'Color','r')
line([2 70],[45 48],'Marker','.','LineStyle','-','LineWidth',3,'Color','r')
line([70 96],[48 39],'Marker','.','LineStyle','-','LineWidth',3,'Color','r')   
text(100,46,'V1','FontSize',16)
text(100,35,'V2','FontSize',16)
text(96,22,'V4','FontSize',16)
    

y=mfilt2(mean(non(:,time1),2)-1,100,100,1,'lm');
y(pixels_to_remove)=10;
figure
mimg(y,100,100,-.2e-3,1.2e-3);colormap(mapgeog)
hold on
contour(reshape(h,100,100)')
hold on
line([3 72],[34 36],'Marker','.','LineStyle','-','LineWidth',3,'Color','r')
line([72 92],[36 26],'Marker','.','LineStyle','-','LineWidth',3,'Color','r')
line([2 70],[45 48],'Marker','.','LineStyle','-','LineWidth',3,'Color','r')
line([70 96],[48 39],'Marker','.','LineStyle','-','LineWidth',3,'Color','r')   
text(100,46,'V1','FontSize',16)
text(100,35,'V2','FontSize',16)
text(96,22,'V4','FontSize',16)
    


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







y=mfilt2(mean(con(:,time2)-non(:,time2),2),100,100,1,'lm');
y(pixels_to_remove)=10;
figure
mimg(y,100,100,-.2e-3,.2e-3);colormap(mapgeog)
hold on
contour(reshape(h,100,100)')
hold on
line([3 72],[34 36],'Marker','.','LineStyle','-','LineWidth',3,'Color','r')
line([72 92],[36 26],'Marker','.','LineStyle','-','LineWidth',3,'Color','r')
line([2 70],[45 48],'Marker','.','LineStyle','-','LineWidth',3,'Color','r')
line([70 96],[48 39],'Marker','.','LineStyle','-','LineWidth',3,'Color','r')   
text(100,46,'V1','FontSize',16)
text(100,35,'V2','FontSize',16)
text(96,22,'V4','FontSize',16)
    








