

load time_rois_for_fig1_ci_after_cleanning_BETTER
h=zeros(10000,1);
h(roi_contour3)=1;
h(roi_maskin_narrow2)=1;

time=34:36;
y=mfilt2(mean(con(:,time),2)-1,100,100,1,'lm');
y(pixels_to_remove)=10;
figure(100)
mimg(y,100,100,-.2e-3,1.2e-3);colormap(mapgeog)
hold on
contour(reshape(h,100,100)')
hold on
line([11 97],[29 40],'Marker','.','LineStyle','-','LineWidth',3,'Color','k')
line([16 94],[21 29],'Marker','.','LineStyle','-','LineWidth',3,'Color','k')
text(100,46,'V1','FontSize',16)
text(100,35,'V2','FontSize',16)
text(96,22,'V4','FontSize',16)





%% Figure 2















load time_rois_for_fig2_ci_after_cleanning_BETTER


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


con=(a+b)/2;
non=(c+d)/2;


%load pixels_to_remove
%load myrois
h=zeros(10000,1);
h(roi_contour2)=1;
h(roi_maskin_narrow2)=1;

y=mfilt2(mean(con(:,49:51),2)-1,100,100,1,'lm');
y(pixels_to_remove)=10;
figure
mimg(y,100,100,0.7e-3,1.4e-3);colormap(mapgeog)
hold on
contour(reshape(h,100,100)')
hold on
line([11 97],[29 40],'Marker','.','LineStyle','-','LineWidth',3,'Color','k')
line([16 94],[21 29],'Marker','.','LineStyle','-','LineWidth',3,'Color','k')
text(100,46,'V1','FontSize',16)
text(100,35,'V2','FontSize',16)
text(96,22,'V4','FontSize',16)

y=mfilt2(mean(non(:,49:51),2)-1,100,100,1,'lm');
y(pixels_to_remove)=10;
figure
mimg(y,100,100,0.7e-3,1.4e-3);colormap(mapgeog)
hold on
contour(reshape(h,100,100)')
hold on
line([11 97],[29 40],'Marker','.','LineStyle','-','LineWidth',3,'Color','k')
line([16 94],[21 29],'Marker','.','LineStyle','-','LineWidth',3,'Color','k')
text(100,46,'V1','FontSize',16)
text(100,35,'V2','FontSize',16)
text(96,22,'V4','FontSize',16)


figure;
scatter(mean(non(roi_contour2,49:51),2)-1,mean(con(roi_contour2,49:51),2)-1)
hold on
plot(0:0.0001:3e-3,0:0.0001:3e-3,'k')
plot((0:0.0001:3e-3),(0:0.0001:3e-3)+top_circ,'r')
plot((0:0.0001:3e-3),(0:0.0001:3e-3)+bottom_circ,'r')
xlim([0 2e-3]);ylim([0 2e-3])
axis square
ranksum(mean(non(roi_contour2,49:51),2)-1,mean(con(roi_contour2,49:51),2)-1)

figure;
scatter(mean(non(roi_maskin_narrow2,49:51),2)-1,mean(con(roi_maskin_narrow2,49:51),2)-1)
hold on
plot(0:0.0001:3e-3,0:0.0001:3e-3,'k')
plot((0:0.0001:3e-3),(0:0.0001:3e-3)+top_bg,'r')
plot((0:0.0001:3e-3),(0:0.0001:3e-3)+bottom_bg,'r')
xlim([0 2e-3]);ylim([0 2e-3])
axis square
ranksum(mean(non(roi_maskin_narrow2,49:51),2)-1,mean(con(roi_maskin_narrow2,49:51),2)-1)



time=34:36;
y=mfilt2(mean(con(:,time),2)-1,100,100,1,'lm');
y(pixels_to_remove)=10;
figure(100)
mimg(y,100,100,-.2e-3,1.2e-3);colormap(mapgeog)
hold on
contour(reshape(h,100,100)')
hold on
line([11 97],[29 40],'Marker','.','LineStyle','-','LineWidth',3,'Color','k')
line([16 94],[21 29],'Marker','.','LineStyle','-','LineWidth',3,'Color','k')
text(100,46,'V1','FontSize',16)
text(100,35,'V2','FontSize',16)
text(96,22,'V4','FontSize',16)

y=mfilt2(mean(non(:,time),2)-1,100,100,1,'lm');
y(pixels_to_remove)=10;
figure
mimg(y,100,100,-.2e-3,1.2e-3);colormap(mapgeog)
hold on
contour(reshape(h,100,100)')
hold on
line([11 97],[29 40],'Marker','.','LineStyle','-','LineWidth',3,'Color','k')
line([16 94],[21 29],'Marker','.','LineStyle','-','LineWidth',3,'Color','k')
text(100,46,'V1','FontSize',16)
text(100,35,'V2','FontSize',16)
text(96,22,'V4','FontSize',16)


figure;
scatter(mean(non(roi_contour2,time),2)-1,mean(con(roi_contour2,time),2)-1)
hold on
plot(0:0.0001:3e-3,0:0.0001:3e-3,'k')
plot((0:0.0001:3e-3),(0:0.0001:3e-3)+top_circ,'r')
plot((0:0.0001:3e-3),(0:0.0001:3e-3)+bottom_circ,'r')
xlim([0 2e-3]);ylim([0 2e-3])
axis square
ranksum(mean(non(roi_contour2,time),2)-1,mean(con(roi_contour2,time),2)-1)

figure;
scatter(mean(non(roi_maskin_narrow2,time),2)-1,mean(con(roi_maskin_narrow2,time),2)-1)
hold on
plot(0:0.0001:3e-3,0:0.0001:3e-3,'k')
plot((0:0.0001:3e-3),(0:0.0001:3e-3)+top_bg,'r')
plot((0:0.0001:3e-3),(0:0.0001:3e-3)+bottom_bg,'r')
xlim([0 2e-3]);ylim([0 2e-3])
axis square
ranksum(mean(non(roi_maskin_narrow2,time),2)-1,mean(con(roi_maskin_narrow2,time),2)-1)






