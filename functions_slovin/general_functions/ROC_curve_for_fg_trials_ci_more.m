%% 1111
%c
fg_c1c=squeeze(mean(mean(cond1n_dt_bl(roi_contour2,43:53,:),1),2))-squeeze(mean(mean(cond1n_dt_bl(roi_maskin,43:53,:),1),2));
fg_c2c=squeeze(mean(mean(cond2n_dt_bl(roi_contour2,43:53,:),1),2))-squeeze(mean(mean(cond2n_dt_bl(roi_maskin,43:53,:),1),2));
fg_c4c=squeeze(mean(mean(cond4n_dt_bl(roi_contour2,43:53,:),1),2))-squeeze(mean(mean(cond4n_dt_bl(roi_maskin,43:53,:),1),2));
fg_c5c=squeeze(mean(mean(cond5n_dt_bl(roi_contour2,43:53,:),1),2))-squeeze(mean(mean(cond5n_dt_bl(roi_maskin,43:53,:),1),2));
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
fg_c1d=squeeze(mean(mean(cond1n_dt_bl(roi_contour2,43:53,:),1),2))-squeeze(mean(mean(cond1n_dt_bl(roi_maskin,43:53,:),1),2));
fg_c2d=squeeze(mean(mean(cond2n_dt_bl(roi_contour2,43:53,:),1),2))-squeeze(mean(mean(cond2n_dt_bl(roi_maskin,43:53,:),1),2));
fg_c4d=squeeze(mean(mean(cond4n_dt_bl(roi_contour2,43:53,:),1),2))-squeeze(mean(mean(cond4n_dt_bl(roi_maskin,43:53,:),1),2));
fg_c5d=squeeze(mean(mean(cond5n_dt_bl(roi_contour2,43:53,:),1),2))-squeeze(mean(mean(cond5n_dt_bl(roi_maskin,43:53,:),1),2));
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

[n1 x1]=hist(fg_cont,-1.5e-3:1e-4:3e-3);
[n2 x2]=hist(fg_non,-1.5e-3:1e-4:3e-3);
figure;bar(x1,[n1/size(fg_cont,1);n2/size(fg_non,1)]')
xlim([-1e-3 1e-3]);

ranksum(fg_cont,fg_non)


%h
fg_c1h=squeeze(mean(mean(cond1n_dt_bl(roi_contour,43:53,:),1),2))-squeeze(mean(mean(cond1n_dt_bl(roi_maskin,43:53,:),1),2));
fg_c2h=squeeze(mean(mean(cond2n_dt_bl(roi_contour,43:53,:),1),2))-squeeze(mean(mean(cond2n_dt_bl(roi_maskin,43:53,:),1),2));
fg_c4h=squeeze(mean(mean(cond4n_dt_bl(roi_contour,43:53,:),1),2))-squeeze(mean(mean(cond4n_dt_bl(roi_maskin,43:53,:),1),2));
fg_c5h=squeeze(mean(mean(cond5n_dt_bl(roi_contour,43:53,:),1),2))-squeeze(mean(mean(cond5n_dt_bl(roi_maskin,43:53,:),1),2));
[n1 x1]=hist(fg_c1h,-1e-3:1e-4:1e-3);
[n2 x2]=hist(fg_c2h,-1e-3:1e-4:1e-3);
[n3 x3]=hist(fg_c4h,-1e-3:1e-4:1e-3);
[n4 x4]=hist(fg_c5h,-1e-3:1e-4:1e-3);
figure;bar(x1,[n1;n2;n3;n4]')
legend('contour','contour','non-contour','non-contour')

scores=[fg_c1h;fg_c4h]';
labels=ones(1,size(scores,2));
labels(size(fg_c1h,1)+1:end)=0;
[X_1111h14,Y_1111h14,THRE,AUC_1111h14,OPTROCPT,SUBY,SUBYNAMES] = perfcurve(labels,scores,1);
figure;plot(X_1111h14,Y_1111h14)

scores=[fg_c2h;fg_c5h]';
labels=ones(1,size(scores,2));
labels(size(fg_c2h,1)+1:end)=0;
[X_1111h25,Y_1111h25,THRE,AUC_1111h25,OPTROCPT,SUBY,SUBYNAMES] = perfcurve(labels,scores,1);
figure;plot(X_1111h25,Y_1111h25)




%% 0610
%e
fg_c1e=squeeze(mean(mean(cond1n_dt_bl(roi_contour,43:53,:),1),2))-squeeze(mean(mean(cond1n_dt_bl(roi_bg_in,43:53,:),1),2));
fg_c2e=squeeze(mean(mean(cond2n_dt_bl(roi_contour,43:53,:),1),2))-squeeze(mean(mean(cond2n_dt_bl(roi_bg_in,43:53,:),1),2));
fg_c4e=squeeze(mean(mean(cond4n_dt_bl(roi_contour,43:53,:),1),2))-squeeze(mean(mean(cond4n_dt_bl(roi_bg_in,43:53,:),1),2));
fg_c5e=squeeze(mean(mean(cond5n_dt_bl(roi_contour,43:53,:),1),2))-squeeze(mean(mean(cond5n_dt_bl(roi_bg_in,43:53,:),1),2));
[n1 x1]=hist(fg_c1e,-1e-3:1e-4:1e-3);
[n2 x2]=hist(fg_c2e,-1e-3:1e-4:1e-3);
[n3 x3]=hist(fg_c4e,-1e-3:1e-4:1e-3);
[n4 x4]=hist(fg_c5e,-1e-3:1e-4:1e-3);
figure;bar(x1,[n1;n2;n3;n4]')
legend('contour','contour','non-contour','non-contour')

scores=[fg_c1e;fg_c4e]';
labels=ones(1,size(scores,2));
labels(size(fg_c1e,1)+1:end)=0;
[X_0610e14,Y_0610e14,THRE,AUC_0610e14,OPTROCPT,SUBY,SUBYNAMES] = perfcurve(labels,scores,1);
figure;plot(X_0610e14,Y_0610e14)

scores=[fg_c2e;fg_c5e]';
labels=ones(1,size(scores,2));
labels(size(fg_c2e,1)+1:end)=0;
[X_0610e25,Y_0610e25,THRE,AUC_0610e25,OPTROCPT,SUBY,SUBYNAMES] = perfcurve(labels,scores,1);
figure;plot(X_0610e25,Y_0610e25)


%f
fg_c1f=squeeze(mean(mean(cond1n_dt_bl(roi_contour,43:53,:),1),2))-squeeze(mean(mean(cond1n_dt_bl(roi_bg_in,43:53,:),1),2));
fg_c2f=squeeze(mean(mean(cond2n_dt_bl(roi_contour,43:53,:),1),2))-squeeze(mean(mean(cond2n_dt_bl(roi_bg_in,43:53,:),1),2));
fg_c4f=squeeze(mean(mean(cond4n_dt_bl(roi_contour,43:53,:),1),2))-squeeze(mean(mean(cond4n_dt_bl(roi_bg_in,43:53,:),1),2));
fg_c5f=squeeze(mean(mean(cond5n_dt_bl(roi_contour,43:53,:),1),2))-squeeze(mean(mean(cond5n_dt_bl(roi_bg_in,43:53,:),1),2));
[n1 x1]=hist(fg_c1f,-1e-3:1e-4:1e-3);
[n2 x2]=hist(fg_c2f,-1e-3:1e-4:1e-3);
[n3 x3]=hist(fg_c4f,-1e-3:1e-4:1e-3);
[n4 x4]=hist(fg_c5f,-1e-3:1e-4:1e-3);
figure;bar(x1,[n1;n2;n3;n4]')
legend('contour','contour','non-contour','non-contour')

scores=[fg_c1f;fg_c4f]';
labels=ones(1,size(scores,2));
labels(size(fg_c1f,1)+1:end)=0;
[X_0610f14,Y_0610f14,THRE,AUC_0610f14,OPTROCPT,SUBY,SUBYNAMES] = perfcurve(labels,scores,1);
figure;plot(X_0610f14,Y_0610f14)

scores=[fg_c2f;fg_c5f]';
labels=ones(1,size(scores,2));
labels(size(fg_c2f,1)+1:end)=0;
[X_0610f25,Y_0610f25,THRE,AUC_0610f25,OPTROCPT,SUBY,SUBYNAMES] = perfcurve(labels,scores,1);
figure;plot(X_0610f25,Y_0610f25)



%% 2210
%d
fg_c1d=squeeze(mean(mean(cond1n_dt_bl(roi_contour,43:53,:),1),2))-squeeze(mean(mean(cond1n_dt_bl(roi_bg_in,43:53,:),1),2));
fg_c2d=squeeze(mean(mean(cond2n_dt_bl(roi_contour,43:53,:),1),2))-squeeze(mean(mean(cond2n_dt_bl(roi_bg_in,43:53,:),1),2));
fg_c4d=squeeze(mean(mean(cond4n_dt_bl(roi_contour,43:53,:),1),2))-squeeze(mean(mean(cond4n_dt_bl(roi_bg_in,43:53,:),1),2));
fg_c5d=squeeze(mean(mean(cond5n_dt_bl(roi_contour,43:53,:),1),2))-squeeze(mean(mean(cond5n_dt_bl(roi_bg_in,43:53,:),1),2));
[n1 x1]=hist(fg_c1d,-1e-3:1e-4:1e-3);
[n2 x2]=hist(fg_c2d,-1e-3:1e-4:1e-3);
[n3 x3]=hist(fg_c4d,-1e-3:1e-4:1e-3);
[n4 x4]=hist(fg_c5d,-1e-3:1e-4:1e-3);
figure;bar(x1,[n1;n2;n3;n4]')
legend('contour','contour','non-contour','non-contour')

scores=[fg_c1d;fg_c4d]';
labels=ones(1,size(scores,2));
labels(size(fg_c1d,1)+1:end)=0;
[X_2210d14,Y_2210d14,THRE,AUC_2210d14,OPTROCPT,SUBY,SUBYNAMES] = perfcurve(labels,scores,1);
figure;plot(X_2210d14,Y_2210d14)

scores=[fg_c2d;fg_c5d]';
labels=ones(1,size(scores,2));
labels(size(fg_c2d,1)+1:end)=0;
[X_2210d25,Y_2210d25,THRE,AUC_2210d25,OPTROCPT,SUBY,SUBYNAMES] = perfcurve(labels,scores,1);
figure;plot(X_2210d25,Y_2210d25)




%e
fg_c1e=squeeze(mean(mean(cond1n_dt_bl(roi_contour,43:53,:),1),2))-squeeze(mean(mean(cond1n_dt_bl(roi_bg_in,43:53,:),1),2));
fg_c2e=squeeze(mean(mean(cond2n_dt_bl(roi_contour,43:53,:),1),2))-squeeze(mean(mean(cond2n_dt_bl(roi_bg_in,43:53,:),1),2));
fg_c4e=squeeze(mean(mean(cond4n_dt_bl(roi_contour,43:53,:),1),2))-squeeze(mean(mean(cond4n_dt_bl(roi_bg_in,43:53,:),1),2));
fg_c5e=squeeze(mean(mean(cond5n_dt_bl(roi_contour,43:53,:),1),2))-squeeze(mean(mean(cond5n_dt_bl(roi_bg_in,43:53,:),1),2));
[n1 x1]=hist(fg_c1e,-1e-3:1e-4:1e-3);
[n2 x2]=hist(fg_c2e,-1e-3:1e-4:1e-3);
[n3 x3]=hist(fg_c4e,-1e-3:1e-4:1e-3);
[n4 x4]=hist(fg_c5e,-1e-3:1e-4:1e-3);
figure;bar(x1,[n1;n2;n3;n4]')
legend('contour','contour','non-contour','non-contour')

scores=[fg_c1e;fg_c4e]';
labels=ones(1,size(scores,2));
labels(size(fg_c1e,1)+1:end)=0;
[X_2210e14,Y_2210e14,THRE,AUC_2210e14,OPTROCPT,SUBY,SUBYNAMES] = perfcurve(labels,scores,1);
figure;plot(X_2210e14,Y_2210e14)

scores=[fg_c2e;fg_c5e]';
labels=ones(1,size(scores,2));
labels(size(fg_c2e,1)+1:end)=0;
[X_2210e25,Y_2210e25,THRE,AUC_2210e25,OPTROCPT,SUBY,SUBYNAMES] = perfcurve(labels,scores,1);
figure;plot(X_2210e25,Y_2210e25)


%% 1811


scores=[fg_c1c;fg_c5c]';
labels=ones(1,size(scores,2));
labels(size(fg_c1c,1)+1:end)=0;
[X_1811c15,Y_1811c15,THRE,AUC_1811c15,OPTROCPT,SUBY,SUBYNAMES] = perfcurve(labels,scores,1);
figure;plot(X_1811c15,Y_1811c15)


scores=[fg_c1d;fg_c5d]';
labels=ones(1,size(scores,2));
labels(size(fg_c1d,1)+1:end)=0;
[X_1811d15,Y_1811d15,THRE,AUC_1811d15,OPTROCPT,SUBY,SUBYNAMES] = perfcurve(labels,scores,1);
figure;plot(X_1811d15,Y_1811d15)


scores=[fg_c1e;fg_c5e]';
labels=ones(1,size(scores,2));
labels(size(fg_c1e,1)+1:end)=0;
[X_1811e15,Y_1811e15,THRE,AUC_1811e15,OPTROCPT,SUBY,SUBYNAMES] = perfcurve(labels,scores,1);
figure;plot(X_1811e15,Y_1811e15)


%% 2511
scores=[fg_c1d;fg_c5d]';
labels=ones(1,size(scores,2));
labels(size(fg_c1d,1)+1:end)=0;
[X_2511d15,Y_2511d15,THRE,AUC_2511d15,OPTROCPT,SUBY,SUBYNAMES] = perfcurve(labels,scores,1);
figure;plot(X_2511d15,Y_2511d15)


scores=[fg_c1e;fg_c5e]';
labels=ones(1,size(scores,2));
labels(size(fg_c1e,1)+1:end)=0;
[X_2511e15,Y_2511e15,THRE,AUC_2511e15,OPTROCPT,SUBY,SUBYNAMES] = perfcurve(labels,scores,1);
figure;plot(X_2511e15,Y_2511e15)

scores=[fg_c1f;fg_c5f]';
labels=ones(1,size(scores,2));
labels(size(fg_c1f,1)+1:end)=0;
[X_2511f15,Y_2511f15,THRE,AUC_2511f15,OPTROCPT,SUBY,SUBYNAMES] = perfcurve(labels,scores,1);
figure;plot(X_2511f15,Y_2511f15)


%% 1203


scores=[fg_c1d;fg_c5d]';
labels=ones(1,size(scores,2));
labels(size(fg_c1d,1)+1:end)=0;
[X_1203d15,Y_1203d15,THRE,AUC_1203d15,OPTROCPT,SUBY,SUBYNAMES] = perfcurve(labels,scores,1);
figure;plot(X_1203d15,Y_1203d15)


scores=[fg_c1e;fg_c5e]';
labels=ones(1,size(scores,2));
labels(size(fg_c1e,1)+1:end)=0;
[X_1203e15,Y_1203e15,THRE,AUC_1203e15,OPTROCPT,SUBY,SUBYNAMES] = perfcurve(labels,scores,1);
figure;plot(X_1203e15,Y_1203e15)

scores=[fg_c1f;fg_c5f]';
labels=ones(1,size(scores,2));
labels(size(fg_c1f,1)+1:end)=0;
[X_1203f15,Y_1203f15,THRE,AUC_1203f15,OPTROCPT,SUBY,SUBYNAMES] = perfcurve(labels,scores,1);
figure;plot(X_1203f15,Y_1203f15)




%%

AUC_leg=[AUC_1111c14 AUC_1111c25 AUC_1111d14 AUC_1111d25 AUC_1111h14 AUC_1111h25 ...
    AUC_1811c15 AUC_1811d15 AUC_1811e15 AUC_2511d15 AUC_2511e15 AUC_2511f15 ...
    AUC_1203d15 AUC_1203e15 AUC_1203f15 AUC_0610e14 AUC_0610e25 AUC_0610f14 ...
    AUC_0610f25 AUC_2210d14 AUC_2210d25 AUC_2210e14 AUC_2210e25];



%% 2912

%c
fg_c1c=squeeze(mean(mean(cond1n_dt_bl(roi_circle,48:58,:),1),2))-squeeze(mean(mean(cond1n_dt_bl(roi_bg_out,48:58,:),1),2));
fg_c2c=squeeze(mean(mean(cond2n_dt_bl(roi_circle,48:58,:),1),2))-squeeze(mean(mean(cond2n_dt_bl(roi_bg_out,48:58,:),1),2));
fg_c4c=squeeze(mean(mean(cond4n_dt_bl(roi_circle,48:58,:),1),2))-squeeze(mean(mean(cond4n_dt_bl(roi_bg_out,48:58,:),1),2));
fg_c5c=squeeze(mean(mean(cond5n_dt_bl(roi_circle,48:58,:),1),2))-squeeze(mean(mean(cond5n_dt_bl(roi_bg_out,48:58,:),1),2));
[n1 x1]=hist(fg_c1c,-1e-3:1e-4:1e-3);
[n2 x2]=hist(fg_c2c,-1e-3:1e-4:1e-3);
[n3 x3]=hist(fg_c4c,-1e-3:1e-4:1e-3);
[n4 x4]=hist(fg_c5c,-1e-3:1e-4:1e-3);
figure;bar(x1,[n1;n2;n3;n4]')
legend('contour','contour','non-contour','non-contour')

scores=[fg_c1c;fg_c4c]';
labels=ones(1,size(scores,2));
labels(size(fg_c1c,1)+1:end)=0;
[X_2912c14,Y_2912c14,THRE,AUC_2912c14,OPTROCPT,SUBY,SUBYNAMES] = perfcurve(labels,scores,1);
figure;plot(X_2912c14,Y_2912c14)

scores=[fg_c2c;fg_c5c]';
labels=ones(1,size(scores,2));
labels(size(fg_c2c,1)+1:end)=0;
[X_2912c25,Y_2912c25,THRE,AUC_2912c25,OPTROCPT,SUBY,SUBYNAMES] = perfcurve(labels,scores,1);
figure;plot(X_2912c25,Y_2912c25)



%e
fg_c1e=squeeze(mean(mean(cond1n_dt_bl(roi_circle,48:58,:),1),2))-squeeze(mean(mean(cond1n_dt_bl(roi_bg_out,48:58,:),1),2));
fg_c2e=squeeze(mean(mean(cond2n_dt_bl(roi_circle,48:58,:),1),2))-squeeze(mean(mean(cond2n_dt_bl(roi_bg_out,48:58,:),1),2));
fg_c4e=squeeze(mean(mean(cond4n_dt_bl(roi_circle,48:58,:),1),2))-squeeze(mean(mean(cond4n_dt_bl(roi_bg_out,48:58,:),1),2));
fg_c5e=squeeze(mean(mean(cond5n_dt_bl(roi_circle,48:58,:),1),2))-squeeze(mean(mean(cond5n_dt_bl(roi_bg_out,48:58,:),1),2));
[n1 x1]=hist(fg_c1e,-1e-3:1e-4:1e-3);
[n2 x2]=hist(fg_c2e,-1e-3:1e-4:1e-3);
[n3 x3]=hist(fg_c4e,-1e-3:1e-4:1e-3);
[n4 x4]=hist(fg_c5e,-1e-3:1e-4:1e-3);
figure;bar(x1,[n1;n2;n3;n4]')
legend('contour','contour','non-contour','non-contour')

scores=[fg_c1e;fg_c4e]';
labels=ones(1,size(scores,2));
labels(size(fg_c1e,1)+1:end)=0;
[X_2912e14,Y_2912e14,THRE,AUC_2912e14,OPTROCPT,SUBY,SUBYNAMES] = perfcurve(labels,scores,1);
figure;plot(X_2912e14,Y_2912e14)

scores=[fg_c2e;fg_c5e]';
labels=ones(1,size(scores,2));
labels(size(fg_c2e,1)+1:end)=0;
[X_2912e25,Y_2912e25,THRE,AUC_2912e25,OPTROCPT,SUBY,SUBYNAMES] = perfcurve(labels,scores,1);
figure;plot(X_2912e25,Y_2912e25)





%k
fg_c1k=squeeze(mean(mean(cond1n_dt_bl(roi_circle,48:58,:),1),2))-squeeze(mean(mean(cond1n_dt_bl(roi_bg_out,48:58,:),1),2));
fg_c2k=squeeze(mean(mean(cond2n_dt_bl(roi_circle,48:58,:),1),2))-squeeze(mean(mean(cond2n_dt_bl(roi_bg_out,48:58,:),1),2));
fg_c4k=squeeze(mean(mean(cond4n_dt_bl(roi_circle,48:58,:),1),2))-squeeze(mean(mean(cond4n_dt_bl(roi_bg_out,48:58,:),1),2));
fg_c5k=squeeze(mean(mean(cond5n_dt_bl(roi_circle,48:58,:),1),2))-squeeze(mean(mean(cond5n_dt_bl(roi_bg_out,48:58,:),1),2));
[n1 x1]=hist(fg_c1k,-1e-3:1e-4:1e-3);
[n2 x2]=hist(fg_c2k,-1e-3:1e-4:1e-3);
[n3 x3]=hist(fg_c4k,-1e-3:1e-4:1e-3);
[n4 x4]=hist(fg_c5k,-1e-3:1e-4:1e-3);
figure;bar(x1,[n1;n2;n3;n4]')
legend('contour','contour','non-contour','non-contour')

scores=[fg_c1k;fg_c4k]';
labels=ones(1,size(scores,2));
labels(size(fg_c1k,1)+1:end)=0;
[X_2912k14,Y_2912k14,THRE,AUC_2912k14,OPTROCPT,SUBY,SUBYNAMES] = perfcurve(labels,scores,1);
figure;plot(X_2912k14,Y_2912k14)

scores=[fg_c2k;fg_c5k]';
labels=ones(1,size(scores,2));
labels(size(fg_c2k,1)+1:end)=0;
[X_2912k25,Y_2912k25,THRE,AUC_2912k25,OPTROCPT,SUBY,SUBYNAMES] = perfcurve(labels,scores,1);
figure;plot(X_2912k25,Y_2912k25)





%b
fg_c1b=squeeze(mean(mean(cond1n_dt_bl(roi_circle,48:58,:),1),2))-squeeze(mean(mean(cond1n_dt_bl(roi_bg_out,48:58,:),1),2));
fg_c2b=squeeze(mean(mean(cond2n_dt_bl(roi_circle,48:58,:),1),2))-squeeze(mean(mean(cond2n_dt_bl(roi_bg_out,48:58,:),1),2));
fg_c4b=squeeze(mean(mean(cond4n_dt_bl(roi_circle,48:58,:),1),2))-squeeze(mean(mean(cond4n_dt_bl(roi_bg_out,48:58,:),1),2));
fg_c5b=squeeze(mean(mean(cond5n_dt_bl(roi_circle,48:58,:),1),2))-squeeze(mean(mean(cond5n_dt_bl(roi_bg_out,48:58,:),1),2));
[n1 x1]=hist(fg_c1b,-1e-3:1e-4:1e-3);
[n2 x2]=hist(fg_c2b,-1e-3:1e-4:1e-3);
[n3 x3]=hist(fg_c4b,-1e-3:1e-4:1e-3);
[n4 x4]=hist(fg_c5b,-1e-3:1e-4:1e-3);
figure;bar(x1,[n1;n2;n3;n4]')
legend('contour','contour','non-contour','non-contour')

scores=[fg_c1b;fg_c4b]';
labels=ones(1,size(scores,2));
labels(size(fg_c1b,1)+1:end)=0;
[X_0501b14,Y_0501b14,THRE,AUC_0501b14,OPTROCPT,SUBY,SUBYNAMES] = perfcurve(labels,scores,1);
figure;plot(X_0501b14,Y_0501b14)

scores=[fg_c2b;fg_c5b]';
labels=ones(1,size(scores,2));
labels(size(fg_c2b,1)+1:end)=0;
[X_0501b25,Y_0501b25,THRE,AUC_0501b25,OPTROCPT,SUBY,SUBYNAMES] = perfcurve(labels,scores,1);
figure;plot(X_0501b25,Y_0501b25)


%b
fg_c1e=squeeze(mean(mean(cond1n_dt_bl(roi_circle,48:58,:),1),2))-squeeze(mean(mean(cond1n_dt_bl(roi_bg_in,48:58,:),1),2));
fg_c2e=squeeze(mean(mean(cond2n_dt_bl(roi_circle,48:58,:),1),2))-squeeze(mean(mean(cond2n_dt_bl(roi_bg_in,48:58,:),1),2));
fg_c4e=squeeze(mean(mean(cond4n_dt_bl(roi_circle,48:58,:),1),2))-squeeze(mean(mean(cond4n_dt_bl(roi_bg_in,48:58,:),1),2));
fg_c5e=squeeze(mean(mean(cond5n_dt_bl(roi_circle,48:58,:),1),2))-squeeze(mean(mean(cond5n_dt_bl(roi_bg_in,48:58,:),1),2));
[n1 x1]=hist(fg_c1e,-1e-3:1e-4:1e-3);
[n2 x2]=hist(fg_c2e,-1e-3:1e-4:1e-3);
[n3 x3]=hist(fg_c4e,-1e-3:1e-4:1e-3);
[n4 x4]=hist(fg_c5e,-1e-3:1e-4:1e-3);
figure;bar(x1,[n1;n2;n3;n4]')
legend('contour','contour','non-contour','non-contour')

scores=[fg_c1e;fg_c4e]';
labels=ones(1,size(scores,2));
labels(size(fg_c1e,1)+1:end)=0;
[X_0501e14,Y_0501e14,THRE,AUC_0501e14,OPTROCPT,SUBY,SUBYNAMES] = perfcurve(labels,scores,1);
figure;plot(X_0501e14,Y_0501e14)

scores=[fg_c2e;fg_c5e]';
labels=ones(1,size(scores,2));
labels(size(fg_c2e,1)+1:end)=0;
[X_0501e25,Y_0501e25,THRE,AUC_0501e25,OPTROCPT,SUBY,SUBYNAMES] = perfcurve(labels,scores,1);
figure;plot(X_0501e25,Y_0501e25)




%% 0501cd


scores=[fg_c1c;fg_c5c]';
labels=ones(1,size(scores,2));
labels(size(fg_c1c,1)+1:end)=0;
[X_0501c15,Y_0501c15,THRE,AUC_0501c15,OPTROCPT,SUBY,SUBYNAMES] = perfcurve(labels,scores,1);
figure;plot(X_0501c15,Y_0501c15)

scores=[fg_c1d;fg_c5d]';
labels=ones(1,size(scores,2));
labels(size(fg_c1d,1)+1:end)=0;
[X_0501d15,Y_0501d15,THRE,AUC_0501d15,OPTROCPT,SUBY,SUBYNAMES] = perfcurve(labels,scores,1);
figure;plot(X_0501d15,Y_0501d15)

%%
AUC_smeg=[AUC_2912c14 AUC_2912c25 AUC_2912e14 AUC_2912e25 AUC_2912k14 AUC_2912k25...
    AUC_0501b14 AUC_0501b25 AUC_0501c15 AUC_0501d15];



%% both total


figure;bar([mean(AUC_leg) mean(AUC_smeg)])
hold on
errorbar([mean(AUC_leg) mean(AUC_smeg)],[std(AUC_leg)/sqrt(23) std(AUC_smeg)/sqrt(10)])
ylim([0.5 1])

ranksum(AUC_leg,0.5*ones(1,23))
ranksum(AUC_smeg,0.5*ones(1,23))











