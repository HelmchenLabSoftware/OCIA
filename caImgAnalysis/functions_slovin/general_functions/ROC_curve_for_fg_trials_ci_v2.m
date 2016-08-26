%% 1111
%c
cd F:\Data\VSDI\Contour_integration\legolas\right_hemisphere\11_11_2008\c\elhanan_new
load cond1n_dt_bl
load cond2n_dt_bl
load cond4n_dt_bl
load cond5n_dt_bl
load rois_for_figure6
roi1=roi_contour7;
roi2=roi_maskin5;
time=43:53;

fg_c1c=squeeze(mean(mean(cond1n_dt_bl(roi1,time,:),1),2))-squeeze(mean(mean(cond1n_dt_bl(roi2,time,:),1),2));
fg_c2c=squeeze(mean(mean(cond2n_dt_bl(roi1,time,:),1),2))-squeeze(mean(mean(cond2n_dt_bl(roi2,time,:),1),2));
fg_c4c=squeeze(mean(mean(cond4n_dt_bl(roi1,time,:),1),2))-squeeze(mean(mean(cond4n_dt_bl(roi2,time,:),1),2));
fg_c5c=squeeze(mean(mean(cond5n_dt_bl(roi1,time,:),1),2))-squeeze(mean(mean(cond5n_dt_bl(roi2,time,:),1),2));
[n1 x1]=hist(fg_c1c,-1e-3:1e-4:1e-3);
[n2 x2]=hist(fg_c2c,-1e-3:1e-4:1e-3);
[n3 x3]=hist(fg_c4c,-1e-3:1e-4:1e-3);
[n4 x4]=hist(fg_c5c,-1e-3:1e-4:1e-3);
figure;bar(x1,[n1;n2;n3;n4]')
legend('contour','contour','non-contour','non-contour')

scores=[fg_c1c;fg_c4c]';
labels=ones(1,size(scores,2));
labels(size(fg_c1c,1)+1:end)=0;
[X_1111c14,Y_1111c14,THRE,AUC_1111c14,OPTROCPT,SUBY,SUBYNAMES] = perfcurve(labels,scores,1);
figure;plot(X_1111c14,Y_1111c14)

scores=[fg_c2c;fg_c5c]';
labels=ones(1,size(scores,2));
labels(size(fg_c2c,1)+1:end)=0;
[X_1111c25,Y_1111c25,THRE,AUC_1111c25,OPTROCPT,SUBY,SUBYNAMES] = perfcurve(labels,scores,1);
figure;plot(X_1111c25,Y_1111c25)




%d
cd F:\Data\VSDI\Contour_integration\legolas\right_hemisphere\11_11_2008\d\elhanan_new
load cond1n_dt_bl
load cond2n_dt_bl
load cond4n_dt_bl
load cond5n_dt_bl

fg_c1d=squeeze(mean(mean(cond1n_dt_bl(roi1,time,:),1),2))-squeeze(mean(mean(cond1n_dt_bl(roi2,time,:),1),2));
fg_c2d=squeeze(mean(mean(cond2n_dt_bl(roi1,time,:),1),2))-squeeze(mean(mean(cond2n_dt_bl(roi2,time,:),1),2));
fg_c4d=squeeze(mean(mean(cond4n_dt_bl(roi1,time,:),1),2))-squeeze(mean(mean(cond4n_dt_bl(roi2,time,:),1),2));
fg_c5d=squeeze(mean(mean(cond5n_dt_bl(roi1,time,:),1),2))-squeeze(mean(mean(cond5n_dt_bl(roi2,time,:),1),2));
[n1 x1]=hist(fg_c1d,-1e-3:1e-4:1e-3);
[n2 x2]=hist(fg_c2d,-1e-3:1e-4:1e-3);
[n3 x3]=hist(fg_c4d,-1e-3:1e-4:1e-3);
[n4 x4]=hist(fg_c5d,-1e-3:1e-4:1e-3);
figure;bar(x1,[n1;n2;n3;n4]')
legend('contour','contour','non-contour','non-contour')

scores=[fg_c1d;fg_c4d]';
labels=ones(1,size(scores,2));
labels(size(fg_c1d,1)+1:end)=0;
[X_1111d14,Y_1111d14,THRE,AUC_1111d14,OPTROCPT,SUBY,SUBYNAMES] = perfcurve(labels,scores,1);
figure;plot(X_1111d14,Y_1111d14)

scores=[fg_c2d;fg_c5d]';
labels=ones(1,size(scores,2));
labels(size(fg_c2d,1)+1:end)=0;
[X_1111d25,Y_1111d25,THRE,AUC_1111d25,OPTROCPT,SUBY,SUBYNAMES] = perfcurve(labels,scores,1);
figure;plot(X_1111d25,Y_1111d25)


figure;plot(X_1111c14,Y_1111c14)
hold on
plot(X_1111c25,Y_1111c25)
plot(X_1111d14,Y_1111d14)
plot(X_1111d25,Y_1111d25)



fg_cont=cat(1,fg_c1c,fg_c2c,fg_c1d,fg_c2d);
fg_non=cat(1,fg_c4c,fg_c5c,fg_c4d,fg_c5d);

scores=[fg_cont;fg_non]';
labels=ones(1,size(scores,2));
labels(size(fg_cont,1)+1:end)=0;
[X,Y,THRE,AUC,OPTROCPT,SUBY,SUBYNAMES] = perfcurve(labels,scores,1);
figure;plot(X,Y)
axis square

[n1 x1]=hist(fg_cont,-1.5e-3:1e-4:3e-3);
[n2 x2]=hist(fg_non,-1.5e-3:1e-4:3e-3);
figure;bar(x1,[n1/size(fg_cont,1);n2/size(fg_non,1)]')
xlim([-.8e-3 1.2e-3]);
ylim([0 0.3]);

ranksum(fg_cont,fg_non)

