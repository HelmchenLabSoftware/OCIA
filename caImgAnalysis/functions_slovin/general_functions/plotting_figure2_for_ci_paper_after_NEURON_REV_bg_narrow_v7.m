

%% Figure 2
cd F:\Data\VSDI\Contour_integration\legolas\right_hemisphere\11_11_2008
load time_rois_for_fig2_ci_after_cleanning_BETTER_wo_drifts

roi1=roi_contour5;
roi2=roi_maskin5;

time=20:23;
diff_circ=mean(con2(roi1,time),2)-mean(non(roi1,time),2);
top_circ = prctile(diff_circ,99.9);
bottom_circ = prctile(diff_circ,.1);
diff_bg=mean(con2(roi2,time),2)-mean(non(roi2,time),2);
top_bg = prctile(diff_bg,99.9);
bottom_bg = prctile(diff_bg,.1);

%load pixels_to_remove
%load myrois
h=zeros(10000,1);
h(roi1)=1;
h(roi2)=1;

time1=50:58;
y=mfilt2(mean(con(:,time1),2)-1,100,100,1,'lm');
y(pixels_to_remove)=10;
figure
mimg(y,100,100,0.7e-3,1.5e-3);colormap(mapgeog)
hold on
contour(reshape(h,100,100)')
hold on
line([11 97],[29 40],'Marker','.','LineStyle','-','LineWidth',3,'Color','k')
line([16 94],[21 29],'Marker','.','LineStyle','-','LineWidth',3,'Color','k')
text(100,46,'V1','FontSize',16)
text(100,35,'V2','FontSize',16)
y=mfilt2(mean(non(:,time1),2)-1,100,100,1,'lm');
y(pixels_to_remove)=10;
figure
mimg(y,100,100,0.7e-3,1.5e-3);colormap(mapgeog)
hold on
contour(reshape(h,100,100)')
hold on
line([11 97],[29 40],'Marker','.','LineStyle','-','LineWidth',3,'Color','k')
line([16 94],[21 29],'Marker','.','LineStyle','-','LineWidth',3,'Color','k')
text(100,46,'V1','FontSize',16)
text(100,35,'V2','FontSize',16)

figure;
scatter(mean(non(roi1,time1),2)-1,mean(con(roi1,time1),2)-1)
hold on
plot(0:0.0001:3e-3,0:0.0001:3e-3,'k')
plot((0:0.0001:3e-3),(0:0.0001:3e-3)+top_circ,'r')
plot((0:0.0001:3e-3),(0:0.0001:3e-3)+bottom_circ,'r')
xlim([0 2e-3]);ylim([0 2e-3])
axis square

figure;
scatter(mean(non(roi2,time1),2)-1,mean(con(roi2,time1),2)-1)
hold on
plot(0:0.0001:3e-3,0:0.0001:3e-3,'k')
plot((0:0.0001:3e-3),(0:0.0001:3e-3)+top_bg,'r')
plot((0:0.0001:3e-3),(0:0.0001:3e-3)+bottom_bg,'r')
xlim([0 2e-3]);ylim([0 2e-3])
axis square


diff_circ=mean(con(roi1,time1),2)-mean(non(roi1,time1),2);
diff_bg=mean(con(roi2,time1),2)-mean(non(roi2,time1),2);
sum(diff_circ>top_circ)/size(diff_circ,1)
sum(diff_circ<bottom_circ)/size(diff_circ,1)
sum(diff_bg>top_bg)/size(diff_bg,1)
sum(diff_bg<bottom_bg)/size(diff_bg,1)

[n1 x1]=hist(diff_circ,-1.5e-3:0.75e-4:1.5e-3);
[n2 x2]=hist(diff_bg,-1.5e-3:0.75e-4:1.5e-3);
figure;bar(x1,[n1/size(diff_circ,1)]')
xlim([-1.2e-3 1e-3])
ylim([0 0.25])
figure;bar(x1,[n2/size(diff_bg,1)]')
xlim([-1.2e-3 1e-3])
ylim([0 0.25])


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


figure;
scatter(mean(non(roi1,time),2)-1,mean(con(roi1,time),2)-1)
hold on
plot(0:0.0001:3e-3,0:0.0001:3e-3,'k')
plot((0:0.0001:3e-3),(0:0.0001:3e-3)+top_circ,'r')
plot((0:0.0001:3e-3),(0:0.0001:3e-3)+bottom_circ,'r')
xlim([0 2e-3]);ylim([0 2e-3])
axis square
figure;
scatter(mean(non(roi2,time),2)-1,mean(con(roi2,time),2)-1)
hold on
plot(0:0.0001:3e-3,0:0.0001:3e-3,'k')
plot((0:0.0001:3e-3),(0:0.0001:3e-3)+top_bg,'r')
plot((0:0.0001:3e-3),(0:0.0001:3e-3)+bottom_bg,'r')
xlim([0 2e-3]);ylim([0 2e-3])
axis square

diff_circ=mean(con(roi1,time),2)-mean(non(roi1,time),2);
diff_bg=mean(con(roi2,time),2)-mean(non(roi2,time),2);
sum(diff_circ>top_circ)/size(diff_circ,1)
sum(diff_circ<bottom_circ)/size(diff_circ,1)
sum(diff_bg>top_bg)/size(diff_bg,1)
sum(diff_bg<bottom_bg)/size(diff_bg,1)


[n1 x1]=hist(diff_circ,-1.5e-3:0.75e-4:1.5e-3);
[n2 x2]=hist(diff_bg,-1.5e-3:0.75e-4:1.5e-3);
figure;bar(x1,[n1/size(diff_circ,1)]')
xlim([-1.2e-3 1e-3])
ylim([0 0.25])
figure;bar(x1,[n2/size(diff_bg,1)]')
xlim([-1.2e-3 1e-3])
ylim([0 0.25])



