

cd E:\Ariel_Gilad\Matlab_analysis\experiments\mask\legolas\right_hemisphere
load time_rois_bg_narrow_and_bg_ave
figure;errorbar(x(1:68),mean(diff_bg_in(1:68,:),2),std(diff_bg_in(1:68,:),0,2)/sqrt(size(diff_bg_in,2)))
hold on
errorbar(x(1:68),mean(diff_bg_in_narrow(1:68,:),2),std(diff_bg_in_narrow(1:68,:),0,2)/sqrt(size(diff_bg_in_narrow,2)),'r')
plot(x,zeros(1,111),'k')
xlim([-50 300])
shg


cd E:\Ariel_Gilad\Matlab_analysis\experiments\mask\Smeagol
load time_rois_bg_narrow_and_bg_ave
figure;errorbar(x(1:68),mean(diff_bg_out(1:68,:),2),std(diff_bg_out(1:68,:),0,2)/sqrt(size(diff_bg_out,2)))
hold on
errorbar(x(1:68),mean(diff_bg_out_narrow(1:68,:),2),std(diff_bg_out_narrow(1:68,:),0,2)/sqrt(size(diff_bg_out_narrow,2)),'r')
plot(x,zeros(1,111),'k')
xlim([-50 300])
shg


%% 
cd C:\contour_integration\11_11_2008\
load time_rois_for_fig2_ci_after_cleanning_BETTER

con=(a+b)/2;
non=(c+d)/2;
g=zeros(10000,1);
g(roi_f3)=1;
g(roi_f4)=1;
g(roi_f5)=1;

h=zeros(10000,1);
h(roi_maskin)=1;
time=34:36;
y=mfilt2(mean(con(:,time),2)-1,100,100,1,'lm');
y(pixels_to_remove)=10;
figure
mimg(y,100,100,-.2e-3,1.2e-3);colormap(mapgeog)
hold on
contour(reshape(h,100,100)')
contour(reshape(g,100,100)')
line([11 97],[29 40],'Marker','.','LineStyle','-','LineWidth',3,'Color','k')
line([16 94],[21 29],'Marker','.','LineStyle','-','LineWidth',3,'Color','k')
text(100,46,'V1','FontSize',16)
text(100,35,'V2','FontSize',16)
text(96,22,'V4','FontSize',16)


h=zeros(10000,1);
h(roi_maskin_narrow)=1;
time=34:36;
y=mfilt2(mean(con(:,time),2)-1,100,100,1,'lm');
y(pixels_to_remove)=10;
figure
mimg(y,100,100,-.2e-3,1.2e-3);colormap(mapgeog)
hold on
contour(reshape(h,100,100)')
contour(reshape(g,100,100)')
line([11 97],[29 40],'Marker','.','LineStyle','-','LineWidth',3,'Color','k')
line([16 94],[21 29],'Marker','.','LineStyle','-','LineWidth',3,'Color','k')
text(100,46,'V1','FontSize',16)
text(100,35,'V2','FontSize',16)
text(96,22,'V4','FontSize',16)


figure;plot(x(1:68),mean(con(roi_maskin,2:69)-1,1))
hold on
plot(x(1:68),mean(con(roi_maskin_narrow,2:69)-1,1),'r')
plot(x,zeros(1,111),'k')
xlim([-50 300])
shg

