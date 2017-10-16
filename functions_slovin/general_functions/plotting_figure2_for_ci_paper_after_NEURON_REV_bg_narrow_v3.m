cd F:\Data\VSDI\Contour_integration\legolas\right_hemisphere\psychophysics\2008_12_03\d\correct_and_incorrect_together
load time_rois_for_fig2_ci_NEURON_revision


% x=(20:10:1120)-280;
% 
% figure
% errorbar(x(20:60),mean(con_circ(20:60,:),2)-1,std(con_circ(20:60,:),0,2)/sqrt(size(con_circ(:,:),2)))
% hold on
% errorbar(x(20:60),mean(non_circ(20:60,:),2)-1,std(non_circ(20:60,:),0,2)/sqrt(size(non_circ(:,:),2)),'r')
% errorbar(x(20:60),mean(bl_circ(20:60,1:2:end),2)-1,std(bl_circ(20:60,:),0,2)/sqrt(size(bl_circ(:,:),2)),'g')
% xlim([-50 300])
% ylim([-.3e-3 1.6e-3])
% 
% figure
% errorbar(x(20:60),mean(con_bg(20:60,:),2)-1,std(con_bg(20:60,:),0,2)/sqrt(size(con_bg,2)))
% hold on
% errorbar(x(20:60),mean(non_bg(20:60,:),2)-1,std(non_bg(20:60,:),0,2)/sqrt(size(non_bg,2)),'r')
% errorbar(x(20:60),mean(bl_bg(20:60,1:2:end),2)-1,std(bl_bg(20:60,:),0,2)/sqrt(size(bl_bg,2)),'g')
% xlim([-50 300])
% ylim([-.3e-3 1.6e-3])

roi1=roi_contour3;
roi2=roi_bg_in3;

time=20:23;
diff_circ=mean(con(roi1,time),2)-mean(non(roi1,time),2);
top_circ = prctile(diff_circ,97);
bottom_circ = prctile(diff_circ,3);
diff_bg=mean(con(roi2,time),2)-mean(non(roi2,time),2);
top_bg = prctile(diff_bg,97);
bottom_bg = prctile(diff_bg,3);


%load pixels_to_remove
%load myrois
h=zeros(10000,1);
h(roi1)=1;
h(roi2)=1;

time1=55:58;
y=mfilt2(mean(con(:,time1),2)-1,100,100,1,'lm');
y(pixels_to_remove)=10;
figure
mimg(y,100,100,0.3e-3,1.1e-3);colormap(mapgeog)
hold on
contour(reshape(h,100,100)')
hold on
line([6 94],[33 44],'Marker','.','LineStyle','-','LineWidth',3,'Color','k')
line([10 92],[25 31],'Marker','.','LineStyle','-','LineWidth',3,'Color','k')
text(100,46,'V1','FontSize',16)
text(100,35,'V2','FontSize',16)
text(96,22,'V4','FontSize',16)

y=mfilt2(mean(non(:,time1),2)-1,100,100,1,'lm');
y(pixels_to_remove)=10;
figure
mimg(y,100,100,0.3e-3,1.1e-3);colormap(mapgeog)
hold on
contour(reshape(h,100,100)')
hold on
line([6 94],[33 44],'Marker','.','LineStyle','-','LineWidth',3,'Color','k')
line([10 92],[25 31],'Marker','.','LineStyle','-','LineWidth',3,'Color','k')
text(100,46,'V1','FontSize',16)
text(100,35,'V2','FontSize',16)
text(96,22,'V4','FontSize',16)


figure;
scatter(mean(non(roi1,time1),2)-1,mean(con(roi1,time1),2)-1)
hold on
plot(0:0.0001:3e-3,0:0.0001:3e-3,'k')
plot((0:0.0001:3e-3),(0:0.0001:3e-3)+top_circ,'r')
plot((0:0.0001:3e-3),(0:0.0001:3e-3)+bottom_circ,'r')
xlim([-0.1e-3 1.6e-3]);ylim([-0.1e-3 1.6e-3])
axis square
ranksum(mean(non(roi1,time1),2)-1,mean(con(roi1,time1),2)-1)

figure;
scatter(mean(non(roi2,time1),2)-1,mean(con(roi2,time1),2)-1)
hold on
plot(0:0.0001:3e-3,0:0.0001:3e-3,'k')
plot((0:0.0001:3e-3),(0:0.0001:3e-3)+top_bg,'r')
plot((0:0.0001:3e-3),(0:0.0001:3e-3)+bottom_bg,'r')
xlim([-0.1e-3 1.6e-3]);ylim([-0.1e-3 1.6e-3])
axis square
ranksum(mean(non(roi2,time1),2)-1,mean(con(roi2,time1),2)-1)
diff_circ=mean(con(roi1,time1),2)-mean(non(roi1,time1),2);
sum(diff_circ>top_circ)/size(diff_circ,1)
sum(diff_circ<bottom_circ)/size(diff_circ,1)
diff_bg=mean(con(roi2,time1),2)-mean(non(roi2,time1),2);
sum(diff_bg>top_bg)/size(diff_bg,1)
sum(diff_bg<bottom_bg)/size(diff_bg,1)


time=34:35;
y=mfilt2(mean(con_early(:,time),2)-1,100,100,1,'lm');
y(pixels_to_remove)=10;
figure
mimg(y,100,100,.2e-3,1e-3);colormap(mapgeog)
hold on
contour(reshape(h,100,100)')
hold on
line([6 94],[33 44],'Marker','.','LineStyle','-','LineWidth',3,'Color','k')
line([10 92],[25 31],'Marker','.','LineStyle','-','LineWidth',3,'Color','k')
text(100,46,'V1','FontSize',16)
text(100,35,'V2','FontSize',16)
text(96,22,'V4','FontSize',16)

y=mfilt2(mean(non(:,time),2)-1,100,100,1,'lm');
y(pixels_to_remove)=10;
figure
mimg(y,100,100,.2e-3,1e-3);colormap(mapgeog)
hold on
contour(reshape(h,100,100)')
hold on
line([6 94],[33 44],'Marker','.','LineStyle','-','LineWidth',3,'Color','k')
line([10 92],[25 31],'Marker','.','LineStyle','-','LineWidth',3,'Color','k')
text(100,46,'V1','FontSize',16)
text(100,35,'V2','FontSize',16)
text(96,22,'V4','FontSize',16)


figure;
scatter(mean(non(roi1,time),2)-1,mean(con_early(roi1,time),2)-1)
hold on
plot(0:0.0001:3e-3,0:0.0001:3e-3,'k')
plot((0:0.0001:3e-3),(0:0.0001:3e-3)+top_circ,'r')
plot((0:0.0001:3e-3),(0:0.0001:3e-3)+bottom_circ,'r')
xlim([-0.1e-3 1.6e-3]);ylim([-0.1e-3 1.6e-3])
axis square
ranksum(mean(non(roi1,time),2)-1,mean(con_early(roi1,time),2)-1)

figure;
scatter(mean(non(roi2,time),2)-1,mean(con_early(roi2,time),2)-1)
hold on
plot(0:0.0001:3e-3,0:0.0001:3e-3,'k')
plot((0:0.0001:3e-3),(0:0.0001:3e-3)+top_bg,'r')
plot((0:0.0001:3e-3),(0:0.0001:3e-3)+bottom_bg,'r')
xlim([-0.1e-3 1.6e-3]);ylim([-0.1e-3 1.6e-3])
axis square
ranksum(mean(non(roi2,time),2)-1,mean(con_early(roi2,time),2)-1)
diff_circ=mean(con_early(roi1,time),2)-mean(non(roi1,time),2);
sum(diff_circ>top_circ)/size(diff_circ,1)
sum(diff_circ<bottom_circ)/size(diff_circ,1)
diff_bg=mean(con_early(roi2,time),2)-mean(non(roi2,time),2);
sum(diff_bg>top_bg)/size(diff_bg,1)
sum(diff_bg<bottom_bg)/size(diff_bg,1)



