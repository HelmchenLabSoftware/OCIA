%% 1111
%c
cd F:\Data\VSDI\Contour_integration\legolas\right_hemisphere\11_11_2008\c\elhanan_new
load cond1n_dt_bl
load cond2n_dt_bl
load cond4n_dt_bl
load cond5n_dt_bl
load('myrois.mat', 'roi_contour2', 'roi_maskin_narrow')
fg_c1c=squeeze(mean(mean(cond1n_dt_bl(roi_contour2,43:53,:),1),2))-squeeze(mean(mean(cond1n_dt_bl(roi_maskin_narrow,43:53,:),1),2));
fg_c2c=squeeze(mean(mean(cond2n_dt_bl(roi_contour2,43:53,:),1),2))-squeeze(mean(mean(cond2n_dt_bl(roi_maskin_narrow,43:53,:),1),2));
fg_c4c=squeeze(mean(mean(cond4n_dt_bl(roi_contour2,43:53,:),1),2))-squeeze(mean(mean(cond4n_dt_bl(roi_maskin_narrow,43:53,:),1),2));
fg_c5c=squeeze(mean(mean(cond5n_dt_bl(roi_contour2,43:53,:),1),2))-squeeze(mean(mean(cond5n_dt_bl(roi_maskin_narrow,43:53,:),1),2));
clear cond1n_dt_bl
clear cond2n_dt_bl
clear cond4n_dt_bl
clear cond5n_dt_bl
scores=[fg_c1c;fg_c4c]';
labels=ones(1,size(scores,2));
labels(size(fg_c1c,1)+1:end)=0;
[X_1111c14,Y_1111c14,THRE,AUC_1111c14,OPTROCPT,SUBY,SUBYNAMES] = perfcurve(labels,scores,1);
scores=[fg_c2c;fg_c5c]';
labels=ones(1,size(scores,2));
labels(size(fg_c2c,1)+1:end)=0;
[X_1111c25,Y_1111c25,THRE,AUC_1111c25,OPTROCPT,SUBY,SUBYNAMES] = perfcurve(labels,scores,1);




%d
cd F:\Data\VSDI\Contour_integration\legolas\right_hemisphere\11_11_2008\c\elhanan_new
load cond1n_dt_bl
load cond2n_dt_bl
load cond4n_dt_bl
load cond5n_dt_bl
load('myrois.mat', 'roi_contour2', 'roi_maskin_narrow')
fg_c1d=squeeze(mean(mean(cond1n_dt_bl(roi_contour2,43:53,:),1),2))-squeeze(mean(mean(cond1n_dt_bl(roi_maskin_narrow,43:53,:),1),2));
fg_c2d=squeeze(mean(mean(cond2n_dt_bl(roi_contour2,43:53,:),1),2))-squeeze(mean(mean(cond2n_dt_bl(roi_maskin_narrow,43:53,:),1),2));
fg_c4d=squeeze(mean(mean(cond4n_dt_bl(roi_contour2,43:53,:),1),2))-squeeze(mean(mean(cond4n_dt_bl(roi_maskin_narrow,43:53,:),1),2));
fg_c5d=squeeze(mean(mean(cond5n_dt_bl(roi_contour2,43:53,:),1),2))-squeeze(mean(mean(cond5n_dt_bl(roi_maskin_narrow,43:53,:),1),2));
clear cond1n_dt_bl
clear cond2n_dt_bl
clear cond4n_dt_bl
clear cond5n_dt_bl

scores=[fg_c1d;fg_c4d]';
labels=ones(1,size(scores,2));
labels(size(fg_c1d,1)+1:end)=0;
[X_1111d14,Y_1111d14,THRE,AUC_1111d14,OPTROCPT,SUBY,SUBYNAMES] = perfcurve(labels,scores,1);
scores=[fg_c2d;fg_c5d]';
labels=ones(1,size(scores,2));
labels(size(fg_c2d,1)+1:end)=0;
[X_1111d25,Y_1111d25,THRE,AUC_1111d25,OPTROCPT,SUBY,SUBYNAMES] = perfcurve(labels,scores,1);


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
xlim([-.6e-3 1e-3]);
ylim([0 .3])
ranksum(fg_cont,fg_non)


%h
cd F:\Data\VSDI\Contour_integration\legolas\right_hemisphere\11_11_2008\c\elhanan_new
load cond1n_dt_bl
load cond2n_dt_bl
load cond4n_dt_bl
load cond5n_dt_bl
load('myrois.mat', 'roi_contour', 'roi_maskin_narrow')
fg_c1h=squeeze(mean(mean(cond1n_dt_bl(roi_contour,43:53,:),1),2))-squeeze(mean(mean(cond1n_dt_bl(roi_maskin_narrow,43:53,:),1),2));
fg_c2h=squeeze(mean(mean(cond2n_dt_bl(roi_contour,43:53,:),1),2))-squeeze(mean(mean(cond2n_dt_bl(roi_maskin_narrow,43:53,:),1),2));
fg_c4h=squeeze(mean(mean(cond4n_dt_bl(roi_contour,43:53,:),1),2))-squeeze(mean(mean(cond4n_dt_bl(roi_maskin_narrow,43:53,:),1),2));
fg_c5h=squeeze(mean(mean(cond5n_dt_bl(roi_contour,43:53,:),1),2))-squeeze(mean(mean(cond5n_dt_bl(roi_maskin_narrow,43:53,:),1),2));
clear cond1n_dt_bl
clear cond2n_dt_bl
clear cond4n_dt_bl
clear cond5n_dt_bl
scores=[fg_c1h;fg_c4h]';
labels=ones(1,size(scores,2));
labels(size(fg_c1h,1)+1:end)=0;
[X_1111h14,Y_1111h14,THRE,AUC_1111h14,OPTROCPT,SUBY,SUBYNAMES] = perfcurve(labels,scores,1);
scores=[fg_c2h;fg_c5h]';
labels=ones(1,size(scores,2));
labels(size(fg_c2h,1)+1:end)=0;
[X_1111h25,Y_1111h25,THRE,AUC_1111h25,OPTROCPT,SUBY,SUBYNAMES] = perfcurve(labels,scores,1);




%% 0610
%e
time=time;
cd F:\Data\VSDI\Contour_integration\legolas\right_hemisphere\06_10_2008\e
load cond1n_dt_bl
load cond2n_dt_bl
load cond4n_dt_bl
load cond5n_dt_bl
load('myrois.mat', 'roi_circle_diff', 'roi_bg_in_narrow')
fg_c1e=squeeze(mean(mean(cond1n_dt_bl(roi_circle_diff,time,:),1),2))-squeeze(mean(mean(cond1n_dt_bl(roi_bg_in_narrow,time,:),1),2));
fg_c2e=squeeze(mean(mean(cond2n_dt_bl(roi_circle_diff,time,:),1),2))-squeeze(mean(mean(cond2n_dt_bl(roi_bg_in_narrow,time,:),1),2));
fg_c4e=squeeze(mean(mean(cond4n_dt_bl(roi_circle_diff,time,:),1),2))-squeeze(mean(mean(cond4n_dt_bl(roi_bg_in_narrow,time,:),1),2));
fg_c5e=squeeze(mean(mean(cond5n_dt_bl(roi_circle_diff,time,:),1),2))-squeeze(mean(mean(cond5n_dt_bl(roi_bg_in_narrow,time,:),1),2));
clear cond1n_dt_bl
clear cond2n_dt_bl
clear cond4n_dt_bl
clear cond5n_dt_bl
scores=[fg_c1e;fg_c4e]';
labels=ones(1,size(scores,2));
labels(size(fg_c1e,1)+1:end)=0;
[X_0610e14,Y_0610e14,THRE,AUC_0610e14,OPTROCPT,SUBY,SUBYNAMES] = perfcurve(labels,scores,1);
scores=[fg_c2e;fg_c5e]';
labels=ones(1,size(scores,2));
labels(size(fg_c2e,1)+1:end)=0;
[X_0610e25,Y_0610e25,THRE,AUC_0610e25,OPTROCPT,SUBY,SUBYNAMES] = perfcurve(labels,scores,1);


%f
cd F:\Data\VSDI\Contour_integration\legolas\right_hemisphere\06_10_2008\f
load cond1n_dt_bl
load cond2n_dt_bl
load cond4n_dt_bl
load cond5n_dt_bl
load('myrois.mat', 'roi_circle_diff', 'roi_bg_in_narrow')
fg_c1f=squeeze(mean(mean(cond1n_dt_bl(roi_circle_diff,time,:),1),2))-squeeze(mean(mean(cond1n_dt_bl(roi_bg_in_narrow,time,:),1),2));
fg_c2f=squeeze(mean(mean(cond2n_dt_bl(roi_circle_diff,time,:),1),2))-squeeze(mean(mean(cond2n_dt_bl(roi_bg_in_narrow,time,:),1),2));
fg_c4f=squeeze(mean(mean(cond4n_dt_bl(roi_circle_diff,time,:),1),2))-squeeze(mean(mean(cond4n_dt_bl(roi_bg_in_narrow,time,:),1),2));
fg_c5f=squeeze(mean(mean(cond5n_dt_bl(roi_circle_diff,time,:),1),2))-squeeze(mean(mean(cond5n_dt_bl(roi_bg_in_narrow,time,:),1),2));
clear cond1n_dt_bl
clear cond2n_dt_bl
clear cond4n_dt_bl
clear cond5n_dt_bl
scores=[fg_c1f;fg_c4f]';
labels=ones(1,size(scores,2));
labels(size(fg_c1f,1)+1:end)=0;
[X_0610f14,Y_0610f14,THRE,AUC_0610f14,OPTROCPT,SUBY,SUBYNAMES] = perfcurve(labels,scores,1);
scores=[fg_c2f;fg_c5f]';
labels=ones(1,size(scores,2));
labels(size(fg_c2f,1)+1:end)=0;
[X_0610f25,Y_0610f25,THRE,AUC_0610f25,OPTROCPT,SUBY,SUBYNAMES] = perfcurve(labels,scores,1);



%% 2210
%d
time=time;
cd F:\Data\VSDI\Contour_integration\legolas\right_hemisphere\22_10_2008\d
load cond1n_dt_bl
load cond2n_dt_bl
load cond4n_dt_bl
load cond5n_dt_bl
load('myrois.mat', 'roi_circle_diff', 'roi_bg_in_narrow')
fg_c1d=squeeze(mean(mean(cond1n_dt_bl(roi_circle_diff,time,:),1),2))-squeeze(mean(mean(cond1n_dt_bl(roi_bg_in_narrow,time,:),1),2));
fg_c2d=squeeze(mean(mean(cond2n_dt_bl(roi_circle_diff,time,:),1),2))-squeeze(mean(mean(cond2n_dt_bl(roi_bg_in_narrow,time,:),1),2));
fg_c4d=squeeze(mean(mean(cond4n_dt_bl(roi_circle_diff,time,:),1),2))-squeeze(mean(mean(cond4n_dt_bl(roi_bg_in_narrow,time,:),1),2));
fg_c5d=squeeze(mean(mean(cond5n_dt_bl(roi_circle_diff,time,:),1),2))-squeeze(mean(mean(cond5n_dt_bl(roi_bg_in_narrow,time,:),1),2));
clear cond1n_dt_bl
clear cond2n_dt_bl
clear cond4n_dt_bl
clear cond5n_dt_bl
scores=[fg_c1d;fg_c4d]';
labels=ones(1,size(scores,2));
labels(size(fg_c1d,1)+1:end)=0;
[X_2210d14,Y_2210d14,THRE,AUC_2210d14,OPTROCPT,SUBY,SUBYNAMES] = perfcurve(labels,scores,1);
scores=[fg_c2d;fg_c5d]';
labels=ones(1,size(scores,2));
labels(size(fg_c2d,1)+1:end)=0;
[X_2210d25,Y_2210d25,THRE,AUC_2210d25,OPTROCPT,SUBY,SUBYNAMES] = perfcurve(labels,scores,1);


%e
cd F:\Data\VSDI\Contour_integration\legolas\right_hemisphere\22_10_2008\e
load cond1n_dt_bl
load cond2n_dt_bl
load cond4n_dt_bl
load cond5n_dt_bl
load('myrois.mat', 'roi_circle_diff', 'roi_bg_in_narrow')
fg_c1e=squeeze(mean(mean(cond1n_dt_bl(roi_circle_diff,time,:),1),2))-squeeze(mean(mean(cond1n_dt_bl(roi_bg_in_narrow,time,:),1),2));
fg_c2e=squeeze(mean(mean(cond2n_dt_bl(roi_circle_diff,time,:),1),2))-squeeze(mean(mean(cond2n_dt_bl(roi_bg_in_narrow,time,:),1),2));
fg_c4e=squeeze(mean(mean(cond4n_dt_bl(roi_circle_diff,time,:),1),2))-squeeze(mean(mean(cond4n_dt_bl(roi_bg_in_narrow,time,:),1),2));
fg_c5e=squeeze(mean(mean(cond5n_dt_bl(roi_circle_diff,time,:),1),2))-squeeze(mean(mean(cond5n_dt_bl(roi_bg_in_narrow,time,:),1),2));
clear cond1n_dt_bl
clear cond2n_dt_bl
clear cond4n_dt_bl
clear cond5n_dt_bl
scores=[fg_c1e;fg_c4e]';
labels=ones(1,size(scores,2));
labels(size(fg_c1e,1)+1:end)=0;
[X_2210e14,Y_2210e14,THRE,AUC_2210e14,OPTROCPT,SUBY,SUBYNAMES] = perfcurve(labels,scores,1);
scores=[fg_c2e;fg_c5e]';
labels=ones(1,size(scores,2));
labels(size(fg_c2e,1)+1:end)=0;
[X_2210e25,Y_2210e25,THRE,AUC_2210e25,OPTROCPT,SUBY,SUBYNAMES] = perfcurve(labels,scores,1);


%% 1811
%c
time=50:57;
cd F:\Data\VSDI\Contour_integration\legolas\right_hemisphere\psychophysics\2008_11_18\c\correct_and_incorrect_together
load cond1n_dt_bl
load cond5n_dt_bl
load('myrois.mat', 'roi_circle_diff', 'roi_bg_in_narrow')
fg_c1c=squeeze(mean(mean(cond1n_dt_bl(roi_circle_diff,time,:),1),2))-squeeze(mean(mean(cond1n_dt_bl(roi_bg_in_narrow,time,:),1),2));
fg_c5c=squeeze(mean(mean(cond5n_dt_bl(roi_circle_diff,time,:),1),2))-squeeze(mean(mean(cond5n_dt_bl(roi_bg_in_narrow,time,:),1),2));
clear cond1n_dt_bl
clear cond5n_dt_bl

%d
cd F:\Data\VSDI\Contour_integration\legolas\right_hemisphere\psychophysics\2008_11_18\d\correct_and_incorrect_together
load cond1n_dt_bl
load cond5n_dt_bl
load('myrois.mat', 'roi_circle_diff', 'roi_bg_in_narrow')
fg_c1d=squeeze(mean(mean(cond1n_dt_bl(roi_circle_diff,time,:),1),2))-squeeze(mean(mean(cond1n_dt_bl(roi_bg_in_narrow,time,:),1),2));
fg_c5d=squeeze(mean(mean(cond5n_dt_bl(roi_circle_diff,time,:),1),2))-squeeze(mean(mean(cond5n_dt_bl(roi_bg_in_narrow,time,:),1),2));
clear cond1n_dt_bl
clear cond5n_dt_bl

%e
cd F:\Data\VSDI\Contour_integration\legolas\right_hemisphere\psychophysics\2008_11_18\e\correct_and_incorrect_together
load cond1n_dt_bl
load cond5n_dt_bl
load('myrois.mat', 'roi_circle_diff', 'roi_bg_in_narrow')
fg_c1e=squeeze(mean(mean(cond1n_dt_bl(roi_circle_diff,time,:),1),2))-squeeze(mean(mean(cond1n_dt_bl(roi_bg_in_narrow,time,:),1),2));
fg_c5e=squeeze(mean(mean(cond5n_dt_bl(roi_circle_diff,time,:),1),2))-squeeze(mean(mean(cond5n_dt_bl(roi_bg_in_narrow,time,:),1),2));
clear cond1n_dt_bl
clear cond5n_dt_bl


scores=[fg_c1c;fg_c5c]';
labels=ones(1,size(scores,2));
labels(size(fg_c1c,1)+1:end)=0;
[X_1811c15,Y_1811c15,THRE,AUC_1811c15,OPTROCPT,SUBY,SUBYNAMES] = perfcurve(labels,scores,1);
scores=[fg_c1d;fg_c5d]';
labels=ones(1,size(scores,2));
labels(size(fg_c1d,1)+1:end)=0;
[X_1811d15,Y_1811d15,THRE,AUC_1811d15,OPTROCPT,SUBY,SUBYNAMES] = perfcurve(labels,scores,1);
scores=[fg_c1e;fg_c5e]';
labels=ones(1,size(scores,2));
labels(size(fg_c1e,1)+1:end)=0;
[X_1811e15,Y_1811e15,THRE,AUC_1811e15,OPTROCPT,SUBY,SUBYNAMES] = perfcurve(labels,scores,1);


%% 2511
%d
cd F:\Data\VSDI\Contour_integration\legolas\right_hemisphere\psychophysics\2008_11_25\d\correct_and_incorrect_together
load cond1n_dt_bl
load cond5n_dt_bl
load('myrois.mat', 'roi_circle_diff', 'roi_bg_in_narrow')
fg_c1d=squeeze(mean(mean(cond1n_dt_bl(roi_circle_diff,53:58,:),1),2))-squeeze(mean(mean(cond1n_dt_bl(roi_bg_in_narrow,53:58,:),1),2));
fg_c5d=squeeze(mean(mean(cond5n_dt_bl(roi_circle_diff,53:58,:),1),2))-squeeze(mean(mean(cond5n_dt_bl(roi_bg_in_narrow,53:58,:),1),2));
clear cond1n_dt_bl
clear cond5n_dt_bl
%e
cd F:\Data\VSDI\Contour_integration\legolas\right_hemisphere\psychophysics\2008_11_25\e\correct_and_incorrect_together
load cond1n_dt_bl
load cond5n_dt_bl
load('myrois.mat', 'roi_circle_diff', 'roi_bg_in_narrow')
fg_c1e=squeeze(mean(mean(cond1n_dt_bl(roi_circle_diff,53:58,:),1),2))-squeeze(mean(mean(cond1n_dt_bl(roi_bg_in_narrow,53:58,:),1),2));
fg_c5e=squeeze(mean(mean(cond5n_dt_bl(roi_circle_diff,53:58,:),1),2))-squeeze(mean(mean(cond5n_dt_bl(roi_bg_in_narrow,53:58,:),1),2));
clear cond1n_dt_bl
clear cond5n_dt_bl
%f
cd F:\Data\VSDI\Contour_integration\legolas\right_hemisphere\psychophysics\2008_11_25\f\correct_and_incorrect_together
load cond1n_dt_bl
load cond5n_dt_bl
load('myrois.mat', 'roi_circle_diff', 'roi_bg_in_narrow')
fg_c1f=squeeze(mean(mean(cond1n_dt_bl(roi_circle_diff,53:58,:),1),2))-squeeze(mean(mean(cond1n_dt_bl(roi_bg_in_narrow,53:58,:),1),2));
fg_c5f=squeeze(mean(mean(cond5n_dt_bl(roi_circle_diff,53:58,:),1),2))-squeeze(mean(mean(cond5n_dt_bl(roi_bg_in_narrow,53:58,:),1),2));
clear cond1n_dt_bl
clear cond5n_dt_bl

scores=[fg_c1d;fg_c5d]';
labels=ones(1,size(scores,2));
labels(size(fg_c1d,1)+1:end)=0;
[X_2511d15,Y_2511d15,THRE,AUC_2511d15,OPTROCPT,SUBY,SUBYNAMES] = perfcurve(labels,scores,1);
scores=[fg_c1e;fg_c5e]';
labels=ones(1,size(scores,2));
labels(size(fg_c1e,1)+1:end)=0;
[X_2511e15,Y_2511e15,THRE,AUC_2511e15,OPTROCPT,SUBY,SUBYNAMES] = perfcurve(labels,scores,1);
scores=[fg_c1f;fg_c5f]';
labels=ones(1,size(scores,2));
labels(size(fg_c1f,1)+1:end)=0;
[X_2511f15,Y_2511f15,THRE,AUC_2511f15,OPTROCPT,SUBY,SUBYNAMES] = perfcurve(labels,scores,1);


%% 1203

%d
time=50:58;
cd F:\Data\VSDI\Contour_integration\legolas\right_hemisphere\psychophysics\2008_12_03\d\correct_and_incorrect_together
load cond1n_dt_bl
load cond5n_dt_bl
load('myrois.mat', 'roi_circle_diff', 'roi_bg_in_narrow')
fg_c1d=squeeze(mean(mean(cond1n_dt_bl(roi_circle_diff,time,:),1),2))-squeeze(mean(mean(cond1n_dt_bl(roi_bg_in_narrow,time,:),1),2));
fg_c5d=squeeze(mean(mean(cond5n_dt_bl(roi_circle_diff,time,:),1),2))-squeeze(mean(mean(cond5n_dt_bl(roi_bg_in_narrow,time,:),1),2));
clear cond1n_dt_bl
clear cond5n_dt_bl

%e
cd F:\Data\VSDI\Contour_integration\legolas\right_hemisphere\psychophysics\2008_12_03\e\correct_and_incorrect_together
load cond1n_dt_bl
load cond5n_dt_bl
load('myrois.mat', 'roi_circle_diff', 'roi_bg_in_narrow')
fg_c1e=squeeze(mean(mean(cond1n_dt_bl(roi_circle_diff,time,:),1),2))-squeeze(mean(mean(cond1n_dt_bl(roi_bg_in_narrow,time,:),1),2));
fg_c5e=squeeze(mean(mean(cond5n_dt_bl(roi_circle_diff,time,:),1),2))-squeeze(mean(mean(cond5n_dt_bl(roi_bg_in_narrow,time,:),1),2));
clear cond1n_dt_bl
clear cond5n_dt_bl

%f
cd F:\Data\VSDI\Contour_integration\legolas\right_hemisphere\psychophysics\2008_12_03\f\correct_and_incorrect_together
load cond1n_dt_bl
load cond5n_dt_bl
load('myrois.mat', 'roi_circle_diff', 'roi_bg_in_narrow')
fg_c1f=squeeze(mean(mean(cond1n_dt_bl(roi_circle_diff,time,:),1),2))-squeeze(mean(mean(cond1n_dt_bl(roi_bg_in_narrow,time,:),1),2));
fg_c5f=squeeze(mean(mean(cond5n_dt_bl(roi_circle_diff,time,:),1),2))-squeeze(mean(mean(cond5n_dt_bl(roi_bg_in_narrow,time,:),1),2));
clear cond1n_dt_bl
clear cond5n_dt_bl

scores=[fg_c1d;fg_c5d]';
labels=ones(1,size(scores,2));
labels(size(fg_c1d,1)+1:end)=0;
[X_1203d15,Y_1203d15,THRE,AUC_1203d15,OPTROCPT,SUBY,SUBYNAMES] = perfcurve(labels,scores,1);
scores=[fg_c1e;fg_c5e]';
labels=ones(1,size(scores,2));
labels(size(fg_c1e,1)+1:end)=0;
[X_1203e15,Y_1203e15,THRE,AUC_1203e15,OPTROCPT,SUBY,SUBYNAMES] = perfcurve(labels,scores,1);
scores=[fg_c1f;fg_c5f]';
labels=ones(1,size(scores,2));
labels(size(fg_c1f,1)+1:end)=0;
[X_1203f15,Y_1203f15,THRE,AUC_1203f15,OPTROCPT,SUBY,SUBYNAMES] = perfcurve(labels,scores,1);




%%

AUC_leg=[AUC_1111c14 AUC_1111c25 AUC_1111d14 AUC_1111d25  ...
    AUC_1811c15 AUC_1811d15 AUC_1811e15 AUC_2511d15 AUC_2511e15 AUC_2511f15 ...
    AUC_1203d15 AUC_1203e15 AUC_1203f15 AUC_1111h14 AUC_1111h25 AUC_0610e14 AUC_0610e25 AUC_0610f14 ...
    AUC_0610f25 AUC_2210d14 AUC_2210d25 AUC_2210e14 AUC_2210e25];



%% 2912

%c
time=48:58;
cd F:\Data\VSDI\Contour_integration\Smeagol\29Dec2010\c
load cond1n_dt_bl
load cond2n_dt_bl
load cond4n_dt_bl
load cond5n_dt_bl
load('myrois.mat', 'roi_circle', 'roi_bg_out_narrow')
fg_c1c=squeeze(mean(mean(cond1n_dt_bl(roi_circle,time,:),1),2))-squeeze(mean(mean(cond1n_dt_bl(roi_bg_out_narrow,time,:),1),2));
fg_c2c=squeeze(mean(mean(cond2n_dt_bl(roi_circle,time,:),1),2))-squeeze(mean(mean(cond2n_dt_bl(roi_bg_out_narrow,time,:),1),2));
fg_c4c=squeeze(mean(mean(cond4n_dt_bl(roi_circle,time,:),1),2))-squeeze(mean(mean(cond4n_dt_bl(roi_bg_out_narrow,time,:),1),2));
fg_c5c=squeeze(mean(mean(cond5n_dt_bl(roi_circle,time,:),1),2))-squeeze(mean(mean(cond5n_dt_bl(roi_bg_out_narrow,time,:),1),2));
clear cond1n_dt_bl
clear cond2n_dt_bl
clear cond4n_dt_bl
clear cond5n_dt_bl
scores=[fg_c1c;fg_c4c]';
labels=ones(1,size(scores,2));
labels(size(fg_c1c,1)+1:end)=0;
[X_2912c14,Y_2912c14,THRE,AUC_2912c14,OPTROCPT,SUBY,SUBYNAMES] = perfcurve(labels,scores,1);
scores=[fg_c2c;fg_c5c]';
labels=ones(1,size(scores,2));
labels(size(fg_c2c,1)+1:end)=0;
[X_2912c25,Y_2912c25,THRE,AUC_2912c25,OPTROCPT,SUBY,SUBYNAMES] = perfcurve(labels,scores,1);

%e
cd F:\Data\VSDI\Contour_integration\Smeagol\29Dec2010\e
load cond1n_dt_bl
load cond2n_dt_bl
load cond4n_dt_bl
load cond5n_dt_bl
load('myrois.mat', 'roi_circle', 'roi_bg_out_narrow')
fg_c1e=squeeze(mean(mean(cond1n_dt_bl(roi_circle,time,:),1),2))-squeeze(mean(mean(cond1n_dt_bl(roi_bg_out_narrow,time,:),1),2));
fg_c2e=squeeze(mean(mean(cond2n_dt_bl(roi_circle,time,:),1),2))-squeeze(mean(mean(cond2n_dt_bl(roi_bg_out_narrow,time,:),1),2));
fg_c4e=squeeze(mean(mean(cond4n_dt_bl(roi_circle,time,:),1),2))-squeeze(mean(mean(cond4n_dt_bl(roi_bg_out_narrow,time,:),1),2));
fg_c5e=squeeze(mean(mean(cond5n_dt_bl(roi_circle,time,:),1),2))-squeeze(mean(mean(cond5n_dt_bl(roi_bg_out_narrow,time,:),1),2));
clear cond1n_dt_bl
clear cond2n_dt_bl
clear cond4n_dt_bl
clear cond5n_dt_bl
scores=[fg_c1e;fg_c4e]';
labels=ones(1,size(scores,2));
labels(size(fg_c1e,1)+1:end)=0;
[X_2912e14,Y_2912e14,THRE,AUC_2912e14,OPTROCPT,SUBY,SUBYNAMES] = perfcurve(labels,scores,1);
scores=[fg_c2e;fg_c5e]';
labels=ones(1,size(scores,2));
labels(size(fg_c2e,1)+1:end)=0;
[X_2912e25,Y_2912e25,THRE,AUC_2912e25,OPTROCPT,SUBY,SUBYNAMES] = perfcurve(labels,scores,1);


%k
time=46;
cd F:\Data\VSDI\Contour_integration\Smeagol\29Dec2010\k
load cond1n_dt_bl
load cond2n_dt_bl
load cond4n_dt_bl
load cond5n_dt_bl
load('myrois.mat', 'roi_circle', 'roi_bg_out_narrow')
fg_c1k=squeeze(mean(mean(cond1n_dt_bl(roi_circle,time,:),1),2))-squeeze(mean(mean(cond1n_dt_bl(roi_bg_out_narrow,time,:),1),2));
fg_c2k=squeeze(mean(mean(cond2n_dt_bl(roi_circle,time,:),1),2))-squeeze(mean(mean(cond2n_dt_bl(roi_bg_out_narrow,time,:),1),2));
fg_c4k=squeeze(mean(mean(cond4n_dt_bl(roi_circle,time,:),1),2))-squeeze(mean(mean(cond4n_dt_bl(roi_bg_out_narrow,time,:),1),2));
fg_c5k=squeeze(mean(mean(cond5n_dt_bl(roi_circle,time,:),1),2))-squeeze(mean(mean(cond5n_dt_bl(roi_bg_out_narrow,time,:),1),2));
clear cond1n_dt_bl
clear cond2n_dt_bl
clear cond4n_dt_bl
clear cond5n_dt_bl
scores=[fg_c1k;fg_c4k]';
labels=ones(1,size(scores,2));
labels(size(fg_c1k,1)+1:end)=0;
[X_2912k14,Y_2912k14,THRE,AUC_2912k14,OPTROCPT,SUBY,SUBYNAMES] = perfcurve(labels,scores,1);
scores=[fg_c2k;fg_c5k]';
labels=ones(1,size(scores,2));
labels(size(fg_c2k,1)+1:end)=0;
[X_2912k25,Y_2912k25,THRE,AUC_2912k25,OPTROCPT,SUBY,SUBYNAMES] = perfcurve(labels,scores,1);




%% 0501
%b
time=51:58;
cd F:\Data\VSDI\Contour_integration\Smeagol\05Jan2011\b
load cond1n_dt_bl
load cond2n_dt_bl
load cond4n_dt_bl
load cond5n_dt_bl
load('myrois.mat', 'roi_circle', 'roi_bg_out_narrow')
fg_c1b=squeeze(mean(mean(cond1n_dt_bl(roi_circle,time,:),1),2))-squeeze(mean(mean(cond1n_dt_bl(roi_bg_out_narrow,time,:),1),2));
fg_c2b=squeeze(mean(mean(cond2n_dt_bl(roi_circle,time,:),1),2))-squeeze(mean(mean(cond2n_dt_bl(roi_bg_out_narrow,time,:),1),2));
fg_c4b=squeeze(mean(mean(cond4n_dt_bl(roi_circle,time,:),1),2))-squeeze(mean(mean(cond4n_dt_bl(roi_bg_out_narrow,time,:),1),2));
fg_c5b=squeeze(mean(mean(cond5n_dt_bl(roi_circle,time,:),1),2))-squeeze(mean(mean(cond5n_dt_bl(roi_bg_out_narrow,time,:),1),2));
clear cond1n_dt_bl
clear cond2n_dt_bl
clear cond4n_dt_bl
clear cond5n_dt_bl
scores=[fg_c1b;fg_c4b]';
labels=ones(1,size(scores,2));
labels(size(fg_c1b,1)+1:end)=0;
[X_0501b14,Y_0501b14,THRE,AUC_0501b14,OPTROCPT,SUBY,SUBYNAMES] = perfcurve(labels,scores,1);
scores=[fg_c2b;fg_c5b]';
labels=ones(1,size(scores,2));
labels(size(fg_c2b,1)+1:end)=0;
[X_0501b25,Y_0501b25,THRE,AUC_0501b25,OPTROCPT,SUBY,SUBYNAMES] = perfcurve(labels,scores,1);

%c
time=57:60;
cd F:\Data\VSDI\Contour_integration\Smeagol\05Jan2011\c
load cond1n_dt_bl
load cond5n_dt_bl
load('myrois.mat', 'roi_circle', 'roi_bg_out_narrow')
fg_c1c=squeeze(mean(mean(cond1n_dt_bl(roi_circle,time,:),1),2))-squeeze(mean(mean(cond1n_dt_bl(roi_bg_out_narrow,time,:),1),2));
fg_c5c=squeeze(mean(mean(cond5n_dt_bl(roi_circle,time,:),1),2))-squeeze(mean(mean(cond5n_dt_bl(roi_bg_out_narrow,time,:),1),2));
clear cond1n_dt_bl
clear cond5n_dt_bl
scores=[fg_c1c;fg_c5c]';
labels=ones(1,size(scores,2));
labels(size(fg_c1c,1)+1:end)=0;
[X_0501c15,Y_0501c15,THRE,AUC_0501c15,OPTROCPT,SUBY,SUBYNAMES] = perfcurve(labels,scores,1);

%d
time=47:51;
cd F:\Data\VSDI\Contour_integration\Smeagol\05Jan2011\d
load cond1n_dt_bl
load cond5n_dt_bl
load('myrois.mat', 'roi_circle', 'roi_bg_out_narrow')
fg_c1d=squeeze(mean(mean(cond1n_dt_bl(roi_circle,time,:),1),2))-squeeze(mean(mean(cond1n_dt_bl(roi_bg_out_narrow,time,:),1),2));
fg_c5d=squeeze(mean(mean(cond5n_dt_bl(roi_circle,time,:),1),2))-squeeze(mean(mean(cond5n_dt_bl(roi_bg_out_narrow,time,:),1),2));
clear cond1n_dt_bl
clear cond5n_dt_bl
scores=[fg_c1d;fg_c5d]';
labels=ones(1,size(scores,2));
labels(size(fg_c1d,1)+1:end)=0;
[X_0501d15,Y_0501d15,THRE,AUC_0501d15,OPTROCPT,SUBY,SUBYNAMES] = perfcurve(labels,scores,1);

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







