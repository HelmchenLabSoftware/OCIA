%% 1111

%% 1111c cond1
cd F:\Data\VSDI\Contour_integration\legolas\right_hemisphere\11_11_2008\c\elhanan_new
load pixels_to_remove
load cond1n_dt_bl
load rois_for_figure6_v2
roi1=roi_contour5;
roi2=roi_maskin5;
tr=19;
time=45:50;
y=mfilt2(mean(cond1n_dt_bl(:,time,tr),2)-1,100,100,1.5,'lm');
y(pixels_to_remove)=100;
figure;mimg(y,100,100,.0e-3,1.4e-3);colormap(mapgeog)
hold on
h=zeros(10000,1);
h(roi1)=1;
contour(reshape(h,100,100)')
h=zeros(10000,1);
h(roi2)=1;
contour(reshape(h,100,100)')
line([11 97],[29 40],'Marker','.','LineStyle','-','LineWidth',3,'Color','k')
line([16 94],[21 29],'Marker','.','LineStyle','-','LineWidth',3,'Color','k')
text(100,46,'V1','FontSize',16)
text(100,35,'V2','FontSize',16)
text(96,22,'V4','FontSize',16)
[n1 x1]=hist(mean(cond1n_dt_bl(roi1,time,tr),2)-1,-1.5e-3:3.5e-4:3e-3);
[n2 x2]=hist(mean(cond1n_dt_bl(roi2,time,tr),2)-1,-1.5e-3:3.5e-4:3e-3);
figure;bar(x1,[n1/size(roi1,1);n2/size(roi2,1)]')
xlim([-1.5e-3 2.5e-3]);
legend('circle','background')
scores=[mean(cond1n_dt_bl(roi1,time,tr),2)-1;mean(cond1n_dt_bl(roi2,time,tr),2)-1]';
labels=ones(1,size(scores,2));
labels(size(mean(cond1n_dt_bl(roi1,time,tr),2)-1,1)+1:end)=0;
[X_tr14,Y_tr14,THRE,AUC_tr14,OPTROCPT,SUBY,SUBYNAMES] = perfcurve(labels,scores,1);
figure;plot(X_tr14,Y_tr14)
ranksum(mean(cond1n_dt_bl(roi1,time,14),2)-1,mean(cond1n_dt_bl(roi2,time,14),2)-1)


%% 1111c cond2 
cd F:\Data\VSDI\Contour_integration\legolas\right_hemisphere\11_11_2008\c\elhanan_new
load pixels_to_remove
load cond2n_dt_bl
load rois_for_figure6_v2
roi1=roi_contour5;
roi2=roi_maskin5;

y=mfilt2(mean(cond2n_dt_bl(:,48:50,11),2)-1,100,100,1.5,'lm');
y(pixels_to_remove)=100;
figure;mimg(y,100,100,0e-3,1.2e-3);colormap(mapgeog)
hold on
h=zeros(10000,1);
h(roi1)=1;
contour(reshape(h,100,100)')
h=zeros(10000,1);
h(roi2)=1;
contour(reshape(h,100,100)')
line([11 97],[29 40],'Marker','.','LineStyle','-','LineWidth',3,'Color','k')
line([16 94],[21 29],'Marker','.','LineStyle','-','LineWidth',3,'Color','k')
text(100,46,'V1','FontSize',16)
text(100,35,'V2','FontSize',16)
text(96,22,'V4','FontSize',16)
[n1 x1]=hist(mean(cond2n_dt_bl(roi1,48:50,11),2)-1,-1.5e-3:2.5e-4:2.5e-3);
[n2 x2]=hist(mean(cond2n_dt_bl(roi2,48:50,11),2)-1,-1.5e-3:2.5e-4:2.5e-3);
figure;bar(x1,[n1/size(roi1,1);n2/size(roi2,1)]')
ylim([0 0.3])
%legend('circle','background')
scores=[mean(cond2n_dt_bl(roi1,48:50,11),2)-1;mean(cond2n_dt_bl(roi2,48:50,11),2)-1]';
labels=ones(1,size(scores,2));
labels(size(mean(cond2n_dt_bl(roi1,48:50,11),2)-1,1)+1:end)=0;
[X_tr11,Y_tr11,THRE,AUC_tr11,OPTROCPT,SUBY,SUBYNAMES] = perfcurve(labels,scores,1);
figure;plot(X_tr11,Y_tr11)
ranksum(mean(cond2n_dt_bl(roi1,48:50,11),2)-1,mean(cond2n_dt_bl(roi2,48:50,11),2)-1)

 
%% 1111d cond5
cd F:\Data\VSDI\Contour_integration\legolas\right_hemisphere\11_11_2008\d\elhanan_new
load pixels_to_remove
load cond5n_dt_bl
load rois_for_figure6
roi1=roi_contour7;
roi2=roi_maskin5;
tr=17;
y=mfilt2(mean(cond5n_dt_bl(:,43:53,tr),2)-1,100,100,1.5,'lm');
y(pixels_to_remove)=100;
figure;mimg(y,100,100,.0e-3,1.7e-3);colormap(mapgeog)
hold on
h=zeros(10000,1);
h(roi1)=1;
contour(reshape(h,100,100)')
h=zeros(10000,1);
h(roi2)=1;
contour(reshape(h,100,100)')
line([11 97],[29 40],'Marker','.','LineStyle','-','LineWidth',3,'Color','k')
line([16 94],[21 29],'Marker','.','LineStyle','-','LineWidth',3,'Color','k')
text(100,46,'V1','FontSize',16)
text(100,35,'V2','FontSize',16)
text(96,22,'V4','FontSize',16)
[n1 x1]=hist(mean(cond5n_dt_bl(roi1,43:53,tr),2)-1,-1.5e-3:2.5e-4:3e-3);
[n2 x2]=hist(mean(cond5n_dt_bl(roi2,43:53,tr),2)-1,-1.5e-3:2.5e-4:3e-3);
figure;bar(x1,[n1/size(roi1,1);n2/size(roi2,1)]')
xlim([-0.5e-3 3e-3]);
legend('circle','background')
scores=[mean(cond5n_dt_bl(roi1,43:53,tr),2)-1;mean(cond5n_dt_bl(roi2,43:53,tr),2)-1]';
labels=ones(1,size(scores,2));
labels(size(mean(cond5n_dt_bl(roi1,43:53,tr),2)-1,1)+1:end)=0;
[Xn_tr11,Yn_tr11,THRE,AUCn_tr11,OPTROCPT,SUBY,SUBYNAMES] = perfcurve(labels,scores,1);
figure;plot(Xn_tr11,Yn_tr11)




%% 1111c cond4
cd F:\Data\VSDI\Contour_integration\legolas\right_hemisphere\11_11_2008\c\elhanan_new
load pixels_to_remove
load cond4n_dt_bl
load rois_for_figure6
roi1=roi_contour7;
roi2=roi_maskin5;
tr=11;
y=mfilt2(mean(cond4n_dt_bl(:,43:53,tr),2)-1,100,100,1.5,'lm');
y(pixels_to_remove)=100;
figure;mimg(y,100,100,.0e-3,1.5e-3);colormap(mapgeog)
hold on
h=zeros(10000,1);
h(roi1)=1;
contour(reshape(h,100,100)')
h=zeros(10000,1);
h(roi2)=1;
contour(reshape(h,100,100)')
line([11 97],[29 40],'Marker','.','LineStyle','-','LineWidth',3,'Color','k')
line([16 94],[21 29],'Marker','.','LineStyle','-','LineWidth',3,'Color','k')
text(100,46,'V1','FontSize',16)
text(100,35,'V2','FontSize',16)
text(96,22,'V4','FontSize',16)
[n1 x1]=hist(mean(cond4n_dt_bl(roi1,43:53,tr),2)-1,-1.5e-3:2.5e-4:3e-3);
[n2 x2]=hist(mean(cond4n_dt_bl(roi2,43:53,tr),2)-1,-1.5e-3:2.5e-4:3e-3);
figure;bar(x1,[n1/size(roi1,1);n2/size(roi2,1)]')
xlim([-.5e-3 3e-3]);
legend('circle','background')
scores=[mean(cond4n_dt_bl(roi1,43:53,tr),2)-1;mean(cond4n_dt_bl(roi2,43:53,tr),2)-1]';
labels=ones(1,size(scores,2));
labels(size(mean(cond4n_dt_bl(roi1,43:53,tr),2)-1,1)+1:end)=0;
[Xn_tr11,Yn_tr11,THRE,AUCn_tr11,OPTROCPT,SUBY,SUBYNAMES] = perfcurve(labels,scores,1);
figure;plot(Xn_tr11,Yn_tr11)





