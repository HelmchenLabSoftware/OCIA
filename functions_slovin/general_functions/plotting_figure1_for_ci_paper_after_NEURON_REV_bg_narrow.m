
cd F:\Data\VSDI\Contour_integration\legolas\right_hemisphere\11_11_2008
load time_rois_for_fig1_ci_after_cleanning_BETTER
h=zeros(10000,1);
%h(roi_contour5)=1;
h(roi_maskin6)=1;

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


%%

load time_rois_for_fig1_ci_after_cleanning_BETTER
h=zeros(10000,1);
h(roi_maskin_narrow2)=1;

time=34:36;
y=mfilt2(mean(con(:,time),2)-1,100,100,1,'lm');
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


%%

load time_rois_for_fig1_ci_after_cleanning_BETTER
h=zeros(10000,1);
h(roi_maskin)=1;

time=34:36;
y=mfilt2(mean(con(:,time),2)-1,100,100,1,'lm');
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

