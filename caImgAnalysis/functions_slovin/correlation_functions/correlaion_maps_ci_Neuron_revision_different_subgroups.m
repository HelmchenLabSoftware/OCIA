

cd F:\Data\VSDI\Contour_integration\legolas\right_hemisphere\11_11_2008
load corr_contour2_1111cd_different_sub_rois
time1=33;

y=mfilt2(mean(cont_contour2(:,time1),2)-mean(non_contour2(:,time1,:),2),100,100,1.5,'lm');
y(pixels_to_remove)=10;
figure;mimg(y,100,100,-0.03,0.055);colormap(mapgeog)
hold on
line([11 97],[29 40],'Marker','.','LineStyle','-','LineWidth',3,'Color','k')
line([16 94],[21 29],'Marker','.','LineStyle','-','LineWidth',3,'Color','k')
text(100,46,'V1','FontSize',16)
text(100,35,'V2','FontSize',16)
text(96,22,'V4','FontSize',16)
h=zeros(10000,1);
h(roi_contour2)=1;
contour(reshape(h,100,100)','Color','k')


y=mfilt2(mean(cont_tar(:,time1),2)-mean(non_tar(:,time1,:),2),100,100,1.5,'lm');
y(pixels_to_remove)=10;
figure;mimg(y,100,100,-0.03,0.055);colormap(mapgeog)
hold on
line([11 97],[29 40],'Marker','.','LineStyle','-','LineWidth',3,'Color','k')
line([16 94],[21 29],'Marker','.','LineStyle','-','LineWidth',3,'Color','k')
text(100,46,'V1','FontSize',16)
text(100,35,'V2','FontSize',16)
text(96,22,'V4','FontSize',16)
h=zeros(10000,1);
h(roi_tar)=1;
contour(reshape(h,100,100)','Color','k')

y=mfilt2(mean(cont_f1late(:,time1),2)-mean(non_f1late(:,time1,:),2),100,100,1.5,'lm');
y(pixels_to_remove)=10;
figure;mimg(y,100,100,-0.03,0.055);colormap(mapgeog)
hold on
line([11 97],[29 40],'Marker','.','LineStyle','-','LineWidth',3,'Color','k')
line([16 94],[21 29],'Marker','.','LineStyle','-','LineWidth',3,'Color','k')
text(100,46,'V1','FontSize',16)
text(100,35,'V2','FontSize',16)
text(96,22,'V4','FontSize',16)
h=zeros(10000,1);
h(roi_f1late)=1;
contour(reshape(h,100,100)','Color','k')

y=mfilt2(mean(cont_f2(:,time1),2)-mean(non_f2(:,time1,:),2),100,100,1.5,'lm');
y(pixels_to_remove)=10;
figure;mimg(y,100,100,-0.03,0.055);colormap(mapgeog)
hold on
line([11 97],[29 40],'Marker','.','LineStyle','-','LineWidth',3,'Color','k')
line([16 94],[21 29],'Marker','.','LineStyle','-','LineWidth',3,'Color','k')
text(100,46,'V1','FontSize',16)
text(100,35,'V2','FontSize',16)
text(96,22,'V4','FontSize',16)
h=zeros(10000,1);
h(roi_f2)=1;
contour(reshape(h,100,100)','Color','k')


figure;plot(x,mean(cont_contour2(roi_contour2,:)-non_contour2(roi_contour2,:),1))
hold on
plot(x,mean(cont_f2(roi_contour2,:)-non_f2(roi_contour2,:),1),'c')
plot(x,mean(cont_tar(roi_contour2,:)-non_tar(roi_contour2,:),1),'g')
plot(x,mean(cont_f1late(roi_contour2,:)-non_f1late(roi_contour2,:),1),'r')
xlim([-100 250])

figure;bar([mean(mean(cont_contour2(roi_contour2,time1)-non_contour2(roi_contour2,time1),1)) ...
    mean(mean(cont_f2(roi_contour2,time1)-non_f2(roi_contour2,time1),1)) ...
    mean(mean(cont_tar(roi_contour2,time1)-non_tar(roi_contour2,time1),1)) ...
    mean(mean(cont_f1late(roi_contour2,time1)-non_f1late(roi_contour2,time1),1))])
ylim([-0.06 .06])

%% 2511
cd F:\Data\VSDI\Contour_integration\legolas\right_hemisphere\psychophysics\2008_11_25\d\correct_and_incorrect_together
load corr_bg_in_2511d_different_sub_rois

time1=28:33;

y=mfilt2(mean(cont_bg_in(:,time1),2)-mean(non_bg_in(:,time1,:),2),100,100,1.5,'lm');
y(pixels_to_remove)=10;
figure;mimg(y,100,100,-0.04,0.07);colormap(mapgeog)
hold on
line([14 92],[19 31],'Marker','.','LineStyle','-','LineWidth',3,'Color','k')
line([7 96],[31 46],'Marker','.','LineStyle','-','LineWidth',3,'Color','k')
text(100,46,'V1','FontSize',16)
text(100,35,'V2','FontSize',16)
text(96,22,'V4','FontSize',16)
h=zeros(10000,1);
h(roi_bg_in_fig5)=1;
contour(reshape(h,100,100)','Color','k')


y=mfilt2(mean(cont_f3(:,time1),2)-mean(non_f3(:,time1,:),2),100,100,1.5,'lm');
y(pixels_to_remove)=10;
figure;mimg(y,100,100,-0.04,0.07);colormap(mapgeog)
hold on
line([14 92],[19 31],'Marker','.','LineStyle','-','LineWidth',3,'Color','k')
line([7 96],[31 46],'Marker','.','LineStyle','-','LineWidth',3,'Color','k')
text(100,46,'V1','FontSize',16)
text(100,35,'V2','FontSize',16)
text(96,22,'V4','FontSize',16)
h=zeros(10000,1);
h(roi_f3)=1;
contour(reshape(h,100,100)','Color','k')

y=mfilt2(mean(cont_f4(:,time1),2)-mean(non_f4(:,time1,:),2),100,100,1.5,'lm');
y(pixels_to_remove)=10;
figure;mimg(y,100,100,-0.04,0.07);colormap(mapgeog)
hold on
line([14 92],[19 31],'Marker','.','LineStyle','-','LineWidth',3,'Color','k')
line([7 96],[31 46],'Marker','.','LineStyle','-','LineWidth',3,'Color','k')
text(100,46,'V1','FontSize',16)
text(100,35,'V2','FontSize',16)
text(96,22,'V4','FontSize',16)
h=zeros(10000,1);
h(roi_f4)=1;
contour(reshape(h,100,100)','Color','k')

y=mfilt2(mean(cont_f5(:,time1),2)-mean(non_f5(:,time1,:),2),100,100,1.5,'lm');
y(pixels_to_remove)=10;
figure;mimg(y,100,100,-0.04,0.07);colormap(mapgeog)
hold on
line([14 92],[19 31],'Marker','.','LineStyle','-','LineWidth',3,'Color','k')
line([7 96],[31 46],'Marker','.','LineStyle','-','LineWidth',3,'Color','k')
text(100,46,'V1','FontSize',16)
text(100,35,'V2','FontSize',16)
text(96,22,'V4','FontSize',16)
h=zeros(10000,1);
h(roi_f5)=1;
contour(reshape(h,100,100)','Color','k')


figure;plot(x,mean(cont_bg_in(roi_bg_in_fig5,:)-non_bg_in(roi_bg_in_fig5,:),1))
hold on
plot(x,mean(cont_f4(roi_bg_in_fig5,:)-non_f4(roi_bg_in_fig5,:),1),'c')
plot(x,mean(cont_f3(roi_bg_in_fig5,:)-non_f3(roi_bg_in_fig5,:),1),'g')
plot(x,mean(cont_f5(roi_bg_in_fig5,:)-non_f5(roi_bg_in_fig5,:),1),'r')
xlim([-100 250])

figure;bar([mean(mean(cont_bg_in(roi_bg_in_fig5,time1)-non_bg_in(roi_bg_in_fig5,time1),1)) ...
    mean(mean(cont_f4(roi_bg_in_fig5,time1)-non_f4(roi_bg_in_fig5,time1),1)) ...
    mean(mean(cont_f3(roi_bg_in_fig5,time1)-non_f3(roi_bg_in_fig5,time1),1)) ...
    mean(mean(cont_f5(roi_bg_in_fig5,time1)-non_f5(roi_bg_in_fig5,time1),1))])
ylim([-0.06 .06])

%% SMEAGOL 2912c

cd F:\Data\VSDI\Contour_integration\Smeagol\29Dec2010\c
load corr_different_sub_regions_circle
time1=26:27;

y=mfilt2(mean(cont_circ_left(:,time1),2)-mean(non_circ_left(:,time1,:),2),100,100,1.5,'lm');
y(pixels_to_remove)=10;
figure;mimg(y,100,100,-0.01,0.04);colormap(mapgeog)
hold on
hold on
line([1 72],[40 41],'Marker','.','LineStyle','-','LineWidth',3,'Color','w')
line([72 94],[41 30],'Marker','.','LineStyle','-','LineWidth',3,'Color','w')
line([1 65],[50 52],'Marker','.','LineStyle','-','LineWidth',3,'Color','w')
line([65 96],[52 43],'Marker','.','LineStyle','-','LineWidth',3,'Color','w')   
text(100,46,'V1','FontSize',16)
text(100,35,'V2','FontSize',16)
text(96,22,'V4','FontSize',16)
h=zeros(10000,1);
h(roi_circle2)=1;
contour(reshape(h,100,100)','Color','k')


y=mfilt2(mean(cont_circle(:,time1),2)-mean(non_circle(:,time1,:),2),100,100,1.5,'lm');
y(pixels_to_remove)=10;
figure;mimg(y,100,100,-0.01,0.04);colormap(mapgeog)
hold on
hold on
line([1 72],[40 41],'Marker','.','LineStyle','-','LineWidth',3,'Color','w')
line([72 94],[41 30],'Marker','.','LineStyle','-','LineWidth',3,'Color','w')
line([1 65],[50 52],'Marker','.','LineStyle','-','LineWidth',3,'Color','w')
line([65 96],[52 43],'Marker','.','LineStyle','-','LineWidth',3,'Color','w')   
text(100,46,'V1','FontSize',16)
text(100,35,'V2','FontSize',16)
text(96,22,'V4','FontSize',16)
h=zeros(10000,1);
h(roi_left_clean)=1;
contour(reshape(h,100,100)','Color','k')



y=mfilt2(mean(cont_circ_middle(:,time1),2)-mean(non_circ_middle(:,time1,:),2),100,100,1.5,'lm');
y(pixels_to_remove)=10;
figure;mimg(y,100,100,-0.01,0.04);colormap(mapgeog)
hold on
hold on
line([1 72],[40 41],'Marker','.','LineStyle','-','LineWidth',3,'Color','w')
line([72 94],[41 30],'Marker','.','LineStyle','-','LineWidth',3,'Color','w')
line([1 65],[50 52],'Marker','.','LineStyle','-','LineWidth',3,'Color','w')
line([65 96],[52 43],'Marker','.','LineStyle','-','LineWidth',3,'Color','w')   
text(100,46,'V1','FontSize',16)
text(100,35,'V2','FontSize',16)
text(96,22,'V4','FontSize',16)
h=zeros(10000,1);
h(roi_middle_clean)=1;
contour(reshape(h,100,100)','Color','k')


figure;plot(x,mean(cont_circle(roi_circle2,:)-non_circle(roi_circle2,:),1))
hold on
plot(x,mean(cont_circ_left(roi_circle2,:)-non_circ_left(roi_circle2,:),1),'c')
plot(x,mean(cont_circ_middle(roi_circle2,:)-non_circ_middle(roi_circle2,:),1),'g')
xlim([-100 250])

figure;bar([mean(mean(cont_circle(roi_circle2,time1)-non_circle(roi_circle2,time1),1)) ...
    mean(mean(cont_circ_left(roi_circle2,time1)-non_circ_left(roi_circle2,time1),1)) ...
    mean(mean(cont_circ_middle(roi_circle2,time1)-non_circ_middle(roi_circle2,time1),1))])
ylim([-0.06 .06])

%% SMEAGOL 2912e

cd F:\Data\VSDI\Contour_integration\Smeagol\29Dec2010\e
load corr_different_sub_regions_bg
time1=34:36;

y=mfilt2(mean(cont_bg_out(:,time1),2)-mean(non_bg_out(:,time1,:),2),100,100,1.5,'lm');
y(pixels_to_remove)=10;
figure;mimg(y,100,100,-0.04,0.04);colormap(mapgeog)
hold on
hold on
line([1 72],[40 41],'Marker','.','LineStyle','-','LineWidth',3,'Color','w')
line([72 94],[41 30],'Marker','.','LineStyle','-','LineWidth',3,'Color','w')
line([1 65],[50 52],'Marker','.','LineStyle','-','LineWidth',3,'Color','w')
line([65 96],[52 43],'Marker','.','LineStyle','-','LineWidth',3,'Color','w')   
text(100,46,'V1','FontSize',16)
text(100,35,'V2','FontSize',16)
text(96,22,'V4','FontSize',16)
h=zeros(10000,1);
h(roi_bg_out_fig5)=1;
contour(reshape(h,100,100)','Color','k')


y=mfilt2(mean(cont_bg_left(:,time1),2)-mean(non_bg_left(:,time1,:),2),100,100,1.5,'lm');
y(pixels_to_remove)=10;
figure;mimg(y,100,100,-0.04,0.04);colormap(mapgeog)
hold on
hold on
line([1 72],[40 41],'Marker','.','LineStyle','-','LineWidth',3,'Color','w')
line([72 94],[41 30],'Marker','.','LineStyle','-','LineWidth',3,'Color','w')
line([1 65],[50 52],'Marker','.','LineStyle','-','LineWidth',3,'Color','w')
line([65 96],[52 43],'Marker','.','LineStyle','-','LineWidth',3,'Color','w')   
text(100,46,'V1','FontSize',16)
text(100,35,'V2','FontSize',16)
text(96,22,'V4','FontSize',16)
h=zeros(10000,1);
h(roi_bg_left)=1;
contour(reshape(h,100,100)','Color','k')



y=mfilt2(mean(cont_bg_middle(:,time1),2)-mean(non_bg_middle(:,time1,:),2),100,100,1.5,'lm');
y(pixels_to_remove)=10;
figure;mimg(y,100,100,-0.04,0.04);colormap(mapgeog)
hold on
hold on
line([1 72],[40 41],'Marker','.','LineStyle','-','LineWidth',3,'Color','w')
line([72 94],[41 30],'Marker','.','LineStyle','-','LineWidth',3,'Color','w')
line([1 65],[50 52],'Marker','.','LineStyle','-','LineWidth',3,'Color','w')
line([65 96],[52 43],'Marker','.','LineStyle','-','LineWidth',3,'Color','w')   
text(100,46,'V1','FontSize',16)
text(100,35,'V2','FontSize',16)
text(96,22,'V4','FontSize',16)
h=zeros(10000,1);
h(roi_bg_middle)=1;
contour(reshape(h,100,100)','Color','k')

time1=33:34;
y=mfilt2(mean(cont_bg_right(:,time1),2)-mean(non_bg_right(:,time1,:),2),100,100,1.5,'lm');
y(pixels_to_remove)=10;
figure;mimg(y,100,100,-0.04,0.04);colormap(mapgeog)
hold on
hold on
line([1 72],[40 41],'Marker','.','LineStyle','-','LineWidth',3,'Color','w')
line([72 94],[41 30],'Marker','.','LineStyle','-','LineWidth',3,'Color','w')
line([1 65],[50 52],'Marker','.','LineStyle','-','LineWidth',3,'Color','w')
line([65 96],[52 43],'Marker','.','LineStyle','-','LineWidth',3,'Color','w')   
text(100,46,'V1','FontSize',16)
text(100,35,'V2','FontSize',16)
text(96,22,'V4','FontSize',16)
h=zeros(10000,1);
h(roi_bg_right)=1;
contour(reshape(h,100,100)','Color','k')

figure;plot(x,mean(cont_bg_out(roi_bg_out_fig5,:)-non_bg_out(roi_bg_out_fig5,:),1))
hold on
plot(x,mean(cont_bg_left(roi_bg_out_fig5,:)-non_bg_left(roi_bg_out_fig5,:),1),'c')
plot(x,mean(cont_bg_middle(roi_bg_out_fig5,:)-non_bg_middle(roi_bg_out_fig5,:),1),'g')
plot(x,mean(cont_bg_right(roi_bg_out_fig5,:)-non_bg_right(roi_bg_out_fig5,:),1),'r')
xlim([-100 250])

figure;bar([mean(mean(cont_bg_out(roi_bg_out_fig5,time1)-non_bg_out(roi_bg_out_fig5,time1),1)) ...
    mean(mean(cont_bg_left(roi_bg_out_fig5,time1)-non_bg_left(roi_bg_out_fig5,time1),1)) ...
    mean(mean(cont_bg_middle(roi_bg_out_fig5,time1)-non_bg_middle(roi_bg_out_fig5,time1),1)) ...
    mean(mean(cont_bg_right(roi_bg_out_fig5,33:34)-non_bg_right(roi_bg_out_fig5,33:34),1))])
ylim([-0.06 .06])
