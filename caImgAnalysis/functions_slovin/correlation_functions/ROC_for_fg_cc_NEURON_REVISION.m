%% 1111c
cd F:\Data\VSDI\Contour_integration\legolas\right_hemisphere\11_11_2008
load('figure_ground_trialwise_for_correlation_1111cd.mat')
time1=32:34;
time2=42:45;

scores=[mean(fg1c(time1,:),1) mean(fg4c(time1,:),1)];
labels=ones(1,size(scores,2));
labels(size(fg1c,2)+1:end)=0;
[X,Y,THRE,AUC14_early,OPTROCPT,SUBY,SUBYNAMES] = perfcurve(labels,scores,1);
figure;plot(X,Y)
scores=[mean(fg2c(time1,:),1) mean(fg5c(time1,:),1)];
labels=ones(1,size(scores,2));
labels(size(fg2c,2)+1:end)=0;
[X,Y,THRE,AUC25_early,OPTROCPT,SUBY,SUBYNAMES] = perfcurve(labels,scores,1);
figure;plot(X,Y)

scores=[mean(fg1c(time2,:),1) mean(fg4c(time2,:),1)];
labels=ones(1,size(scores,2));
labels(size(fg1c,2)+1:end)=0;
[X,Y,THRE,AUC14_late,OPTROCPT,SUBY,SUBYNAMES] = perfcurve(labels,scores,1);
figure;plot(X,Y)
scores=[mean(fg2c(time2,:),1) mean(fg5c(time2,:),1)];
labels=ones(1,size(scores,2));
labels(size(fg2c,2)+1:end)=0;
[X,Y,THRE,AUC25_late,OPTROCPT,SUBY,SUBYNAMES] = perfcurve(labels,scores,1);
figure;plot(X,Y)
AUC14_late=1-AUC14_late;
AUC25_late=1-AUC25_late;
cd F:\Data\VSDI\Contour_integration\legolas\right_hemisphere\11_11_2008\c\elhanan_new
save AUC_cc_fg_early_late AUC14_late AUC25_late AUC14_early AUC25_early


%% 1111d
cd F:\Data\VSDI\Contour_integration\legolas\right_hemisphere\11_11_2008
load('figure_ground_trialwise_for_correlation_1111cd.mat')
time1=32:34;
time2=40:43;

scores=[mean(fg1d(time1,:),1) mean(fg4d(time1,:),1)];
labels=ones(1,size(scores,2));
labels(size(fg1d,2)+1:end)=0;
[X,Y,THRE,AUC14_early,OPTROCPT,SUBY,SUBYNAMES] = perfcurve(labels,scores,1);
figure;plot(X,Y)
scores=[mean(fg2d(time1,:),1) mean(fg5d(time1,:),1)];
labels=ones(1,size(scores,2));
labels(size(fg2d,2)+1:end)=0;
[X,Y,THRE,AUC25_early,OPTROCPT,SUBY,SUBYNAMES] = perfcurve(labels,scores,1);
figure;plot(X,Y)

scores=[mean(fg1d(time2,:),1) mean(fg4d(time2,:),1)];
labels=ones(1,size(scores,2));
labels(size(fg1d,2)+1:end)=0;
[X,Y,THRE,AUC14_late,OPTROCPT,SUBY,SUBYNAMES] = perfcurve(labels,scores,1);
figure;plot(X,Y)
scores=[mean(fg2d(time2,:),1) mean(fg5d(time2,:),1)];
labels=ones(1,size(scores,2));
labels(size(fg2d,2)+1:end)=0;
[X,Y,THRE,AUC25_late,OPTROCPT,SUBY,SUBYNAMES] = perfcurve(labels,scores,1);
figure;plot(X,Y)
AUC14_late=1-AUC14_late;
AUC25_late=1-AUC25_late;
cd F:\Data\VSDI\Contour_integration\legolas\right_hemisphere\11_11_2008\d\elhanan_new
save AUC_cc_fg_early_late AUC14_late AUC25_late AUC14_early AUC25_early


%% 1111h
cd F:\Data\VSDI\Contour_integration\legolas\right_hemisphere\11_11_2008\h
load('figure_ground_trialwise_for_correlation_1111h.mat')
time1=32:34;
time2=40:45;

scores=[mean(fg1h(time1,:),1) mean(fg4h(time1,:),1)];
labels=ones(1,size(scores,2));
labels(size(fg1h,2)+1:end)=0;
[X,Y,THRE,AUC14_early,OPTROCPT,SUBY,SUBYNAMES] = perfcurve(labels,scores,1);
figure;plot(X,Y)
scores=[mean(fg2h(time1,:),1) mean(fg5h(time1,:),1)];
labels=ones(1,size(scores,2));
labels(size(fg2h,2)+1:end)=0;
[X,Y,THRE,AUC25_early,OPTROCPT,SUBY,SUBYNAMES] = perfcurve(labels,scores,1);
figure;plot(X,Y)

scores=[mean(fg1h(time2,:),1) mean(fg4h(time2,:),1)];
labels=ones(1,size(scores,2));
labels(size(fg1h,2)+1:end)=0;
[X,Y,THRE,AUC14_late,OPTROCPT,SUBY,SUBYNAMES] = perfcurve(labels,scores,1);
figure;plot(X,Y)
scores=[mean(fg2h(time2,:),1) mean(fg5h(time2,:),1)];
labels=ones(1,size(scores,2));
labels(size(fg2h,2)+1:end)=0;
[X,Y,THRE,AUC25_late,OPTROCPT,SUBY,SUBYNAMES] = perfcurve(labels,scores,1);
figure;plot(X,Y)
AUC14_late=1-AUC14_late;
AUC25_late=1-AUC25_late;
save AUC_cc_fg_early_late AUC14_late AUC25_late AUC14_early AUC25_early

%% 1811c
cd F:\Data\VSDI\Contour_integration\legolas\right_hemisphere\psychophysics\2008_11_18\c\correct_and_incorrect_together
load('figure_ground_for_correlations_trial_wise')
time1=32:34;
time2=44;

scores=[mean(fg1c(time1,:),1) mean(fg5c(time1,:),1)];
labels=ones(1,size(scores,2));
labels(size(fg1c,2)+1:end)=0;
[X,Y,THRE,AUC15_early,OPTROCPT,SUBY,SUBYNAMES] = perfcurve(labels,scores,1);
figure;plot(X,Y)

scores=[mean(fg1c(time2,:),1) mean(fg5c(time2,:),1)];
labels=ones(1,size(scores,2));
labels(size(fg1c,2)+1:end)=0;
[X,Y,THRE,AUC15_late,OPTROCPT,SUBY,SUBYNAMES] = perfcurve(labels,scores,1);
figure;plot(X,Y)

AUC15_late=1-AUC15_late;

save AUC_cc_fg_early_late AUC15_early AUC15_late

%% 1811d
cd F:\Data\VSDI\Contour_integration\legolas\right_hemisphere\psychophysics\2008_11_18\d\correct_and_incorrect_together
load('figure_ground_for_correlations_trial_wise')
time1=30:34;
time2=41:43;

scores=[mean(fg1d(time1,:),1) mean(fg5d(time1,:),1)];
labels=ones(1,size(scores,2));
labels(size(fg1d,2)+1:end)=0;
[X,Y,THRE,AUC15_early,OPTROCPT,SUBY,SUBYNAMES] = perfcurve(labels,scores,1);
figure;plot(X,Y)

scores=[mean(fg1d(time2,:),1) mean(fg5d(time2,:),1)];
labels=ones(1,size(scores,2));
labels(size(fg1d,2)+1:end)=0;
[X,Y,THRE,AUC15_late,OPTROCPT,SUBY,SUBYNAMES] = perfcurve(labels,scores,1);
figure;plot(X,Y)

AUC15_late=1-AUC15_late;

save AUC_cc_fg_early_late AUC15_early AUC15_late

%% 1811e
cd F:\Data\VSDI\Contour_integration\legolas\right_hemisphere\psychophysics\2008_11_18\e\correct_and_incorrect_together
load('figure_ground_for_correlations_trial_wise')
time1=34:35;
time2=43:46;

scores=[mean(fg1e(time1,:),1) mean(fg5e(time1,:),1)];
labels=ones(1,size(scores,2));
labels(size(fg1e,2)+1:end)=0;
[X,Y,THRE,AUC15_early,OPTROCPT,SUBY,SUBYNAMES] = perfcurve(labels,scores,1);
figure;plot(X,Y)

scores=[mean(fg1e(time2,:),1) mean(fg5e(time2,:),1)];
labels=ones(1,size(scores,2));
labels(size(fg1e,2)+1:end)=0;
[X,Y,THRE,AUC15_late,OPTROCPT,SUBY,SUBYNAMES] = perfcurve(labels,scores,1);
figure;plot(X,Y)

AUC15_late=1-AUC15_late;

save AUC_cc_fg_early_late AUC15_early AUC15_late


%% 2511d
cd F:\Data\VSDI\Contour_integration\legolas\right_hemisphere\psychophysics\2008_11_25\d\correct_and_incorrect_together
load('figure_ground_for_correelations_trial_wise')
time1=32:34;
time2=47:50;

scores=[mean(fg1d(time1,:),1) mean(fg5d(time1,:),1)];
labels=ones(1,size(scores,2));
labels(size(fg1d,2)+1:end)=0;
[X,Y,THRE,AUC15_early,OPTROCPT,SUBY,SUBYNAMES] = perfcurve(labels,scores,1);
figure;plot(X,Y)

scores=[mean(fg1d(time2,:),1) mean(fg5d(time2,:),1)];
labels=ones(1,size(scores,2));
labels(size(fg1d,2)+1:end)=0;
[X,Y,THRE,AUC15_late,OPTROCPT,SUBY,SUBYNAMES] = perfcurve(labels,scores,1);
figure;plot(X,Y)

AUC15_late=1-AUC15_late;

save AUC_cc_fg_early_late AUC15_early AUC15_late

%% 2511e
cd F:\Data\VSDI\Contour_integration\legolas\right_hemisphere\psychophysics\2008_11_25\e\correct_and_incorrect_together
load('figure_ground_for_correelations_trial_wise')
time1=34:37;
time2=44:48;

scores=[mean(fg1e(time1,:),1) mean(fg5e(time1,:),1)];
labels=ones(1,size(scores,2));
labels(size(fg1e,2)+1:end)=0;
[X,Y,THRE,AUC15_early,OPTROCPT,SUBY,SUBYNAMES] = perfcurve(labels,scores,1);
figure;plot(X,Y)

scores=[mean(fg1e(time2,:),1) mean(fg5e(time2,:),1)];
labels=ones(1,size(scores,2));
labels(size(fg1e,2)+1:end)=0;
[X,Y,THRE,AUC15_late,OPTROCPT,SUBY,SUBYNAMES] = perfcurve(labels,scores,1);
figure;plot(X,Y)

AUC15_late=1-AUC15_late;

save AUC_cc_fg_early_late AUC15_early AUC15_late


%% 2511f
cd F:\Data\VSDI\Contour_integration\legolas\right_hemisphere\psychophysics\2008_11_25\f\correct_and_incorrect_together
load('figure_ground_for_correelations_trial_wise')
time1=35:36;
time2=44:45;

scores=[mean(fg1f(time1,:),1) mean(fg5f(time1,:),1)];
labels=ones(1,size(scores,2));
labels(size(fg1f,2)+1:end)=0;
[X,Y,THRE,AUC15_early,OPTROCPT,SUBY,SUBYNAMES] = perfcurve(labels,scores,1);
figure;plot(X,Y)

scores=[mean(fg1f(time2,:),1) mean(fg5f(time2,:),1)];
labels=ones(1,size(scores,2));
labels(size(fg1f,2)+1:end)=0;
[X,Y,THRE,AUC15_late,OPTROCPT,SUBY,SUBYNAMES] = perfcurve(labels,scores,1);
figure;plot(X,Y)

AUC15_late=1-AUC15_late;

save AUC_cc_fg_early_late AUC15_early AUC15_late

%% 1203d
cd F:\Data\VSDI\Contour_integration\legolas\right_hemisphere\psychophysics\2008_12_03\d\correct_and_incorrect_together
load('figure_ground_for_correlations_trial_wise')
time1=32:34;
time2=42:45;

scores=[mean(fg1d(time1,:),1) mean(fg5d(time1,:),1)];
labels=ones(1,size(scores,2));
labels(size(fg1d,2)+1:end)=0;
[X,Y,THRE,AUC15_early,OPTROCPT,SUBY,SUBYNAMES] = perfcurve(labels,scores,1);
figure;plot(X,Y)

scores=[mean(fg1d(time2,:),1) mean(fg5d(time2,:),1)];
labels=ones(1,size(scores,2));
labels(size(fg1d,2)+1:end)=0;
[X,Y,THRE,AUC15_late,OPTROCPT,SUBY,SUBYNAMES] = perfcurve(labels,scores,1);
figure;plot(X,Y)

AUC15_late=1-AUC15_late;

save AUC_cc_fg_early_late AUC15_early AUC15_late

%% 1203e
cd F:\Data\VSDI\Contour_integration\legolas\right_hemisphere\psychophysics\2008_12_03\e\correct_and_incorrect_together
load('figure_ground_for_correlations_trial_wise')
time1=32:34;
time2=45:49;

scores=[mean(fg1e(time1,:),1) mean(fg5e(time1,:),1)];
labels=ones(1,size(scores,2));
labels(size(fg1e,2)+1:end)=0;
[X,Y,THRE,AUC15_early,OPTROCPT,SUBY,SUBYNAMES] = perfcurve(labels,scores,1);
figure;plot(X,Y)

scores=[mean(fg1e(time2,:),1) mean(fg5e(time2,:),1)];
labels=ones(1,size(scores,2));
labels(size(fg1e,2)+1:end)=0;
[X,Y,THRE,AUC15_late,OPTROCPT,SUBY,SUBYNAMES] = perfcurve(labels,scores,1);
figure;plot(X,Y)

AUC15_late=1-AUC15_late;

save AUC_cc_fg_early_late AUC15_early AUC15_late


%% 1203f
cd F:\Data\VSDI\Contour_integration\legolas\right_hemisphere\psychophysics\2008_12_03\f\correct_and_incorrect_together
load('figure_ground_for_correlations_trial_wise')
time1=30:34;
time2=42:45;

scores=[mean(fg1f(time1,:),1) mean(fg5f(time1,:),1)];
labels=ones(1,size(scores,2));
labels(size(fg1f,2)+1:end)=0;
[X,Y,THRE,AUC15_early,OPTROCPT,SUBY,SUBYNAMES] = perfcurve(labels,scores,1);
figure;plot(X,Y)

scores=[mean(fg1f(time2,:),1) mean(fg5f(time2,:),1)];
labels=ones(1,size(scores,2));
labels(size(fg1f,2)+1:end)=0;
[X,Y,THRE,AUC15_late,OPTROCPT,SUBY,SUBYNAMES] = perfcurve(labels,scores,1);
figure;plot(X,Y)

AUC15_late=1-AUC15_late;

save AUC_cc_fg_early_late AUC15_early AUC15_late

%% 0610e
cd F:\Data\VSDI\Contour_integration\legolas\right_hemisphere\06_10_2008\e
load('figure_ground_for_correlations_trialwise')
time1=26:30;
time2=41:44;

scores=[mean(fg1e(time1,:),1) mean(fg4e(time1,:),1)];
labels=ones(1,size(scores,2));
labels(size(fg1e,2)+1:end)=0;
[X,Y,THRE,AUC14_early,OPTROCPT,SUBY,SUBYNAMES] = perfcurve(labels,scores,1);
figure;plot(X,Y)
scores=[mean(fg2e(time1,:),1) mean(fg5e(time1,:),1)];
labels=ones(1,size(scores,2));
labels(size(fg2e,2)+1:end)=0;
[X,Y,THRE,AUC25_early,OPTROCPT,SUBY,SUBYNAMES] = perfcurve(labels,scores,1);
figure;plot(X,Y)

scores=[mean(fg1e(time2,:),1) mean(fg4e(time2,:),1)];
labels=ones(1,size(scores,2));
labels(size(fg1e,2)+1:end)=0;
[X,Y,THRE,AUC14_late,OPTROCPT,SUBY,SUBYNAMES] = perfcurve(labels,scores,1);
figure;plot(X,Y)
scores=[mean(fg2e(time2,:),1) mean(fg5e(time2,:),1)];
labels=ones(1,size(scores,2));
labels(size(fg2e,2)+1:end)=0;
[X,Y,THRE,AUC25_late,OPTROCPT,SUBY,SUBYNAMES] = perfcurve(labels,scores,1);
figure;plot(X,Y)
AUC14_late=1-AUC14_late;
AUC25_late=1-AUC25_late;
save AUC_cc_fg_early_late AUC14_late AUC25_late AUC14_early AUC25_early

%% 0610f
cd F:\Data\VSDI\Contour_integration\legolas\right_hemisphere\06_10_2008\f
load('figure_ground_for_correlations_trialwise')
time1=34:36;
time2=42:48;

scores=[mean(fg1f(time1,:),1) mean(fg4f(time1,:),1)];
labels=ones(1,size(scores,2));
labels(size(fg1f,2)+1:end)=0;
[X,Y,THRE,AUC14_early,OPTROCPT,SUBY,SUBYNAMES] = perfcurve(labels,scores,1);
figure;plot(X,Y)
time1=32:34;
scores=[mean(fg2f(time1,:),1) mean(fg5f(time1,:),1)];
labels=ones(1,size(scores,2));
labels(size(fg2f,2)+1:end)=0;
[X,Y,THRE,AUC25_early,OPTROCPT,SUBY,SUBYNAMES] = perfcurve(labels,scores,1);
figure;plot(X,Y)

scores=[mean(fg1f(time2,:),1) mean(fg4f(time2,:),1)];
labels=ones(1,size(scores,2));
labels(size(fg1f,2)+1:end)=0;
[X,Y,THRE,AUC14_late,OPTROCPT,SUBY,SUBYNAMES] = perfcurve(labels,scores,1);
figure;plot(X,Y)

scores=[mean(fg2f(time2,:),1) mean(fg5f(time2,:),1)];
labels=ones(1,size(scores,2));
labels(size(fg2f,2)+1:end)=0;
[X,Y,THRE,AUC25_late,OPTROCPT,SUBY,SUBYNAMES] = perfcurve(labels,scores,1);
figure;plot(X,Y)
AUC14_late=1-AUC14_late;
AUC25_late=1-AUC25_late;
save AUC_cc_fg_early_late AUC14_late AUC25_late AUC14_early AUC25_early

%% 2210d
cd F:\Data\VSDI\Contour_integration\legolas\right_hemisphere\22_10_2008\d
load('fg_for_correlations_trialwise')
time1=32:34;
time2=46:49;

scores=[mean(fg1d(time1,:),1) mean(fg4d(time1,:),1)];
labels=ones(1,size(scores,2));
labels(size(fg1d,2)+1:end)=0;
[X,Y,THRE,AUC14_early,OPTROCPT,SUBY,SUBYNAMES] = perfcurve(labels,scores,1);
figure;plot(X,Y)
time1=28:31;

scores=[mean(fg2d(time1,:),1) mean(fg5d(time1,:),1)];
labels=ones(1,size(scores,2));
labels(size(fg2d,2)+1:end)=0;
[X,Y,THRE,AUC25_early,OPTROCPT,SUBY,SUBYNAMES] = perfcurve(labels,scores,1);
figure;plot(X,Y)

scores=[mean(fg1d(time2,:),1) mean(fg4d(time2,:),1)];
labels=ones(1,size(scores,2));
labels(size(fg1d,2)+1:end)=0;
[X,Y,THRE,AUC14_late,OPTROCPT,SUBY,SUBYNAMES] = perfcurve(labels,scores,1);
figure;plot(X,Y)
scores=[mean(fg2d(time2,:),1) mean(fg5d(time2,:),1)];
labels=ones(1,size(scores,2));
labels(size(fg2d,2)+1:end)=0;
[X,Y,THRE,AUC25_late,OPTROCPT,SUBY,SUBYNAMES] = perfcurve(labels,scores,1);
figure;plot(X,Y)
AUC14_late=1-AUC14_late;
AUC25_late=1-AUC25_late;
save AUC_cc_fg_early_late AUC14_late AUC25_late AUC14_early AUC25_early

%% 2210e
cd F:\Data\VSDI\Contour_integration\legolas\right_hemisphere\22_10_2008\e
load('fg_for_correlations_trialwise')
time1=30:32;
time2=45:46;

scores=[mean(fg1e(time1,:),1) mean(fg4e(time1,:),1)];
labels=ones(1,size(scores,2));
labels(size(fg1e,2)+1:end)=0;
[X,Y,THRE,AUC14_early,OPTROCPT,SUBY,SUBYNAMES] = perfcurve(labels,scores,1);
figure;plot(X,Y)
time1=32:34;
scores=[mean(fg2e(time1,:),1) mean(fg5e(time1,:),1)];
labels=ones(1,size(scores,2));
labels(size(fg2e,2)+1:end)=0;
[X,Y,THRE,AUC25_early,OPTROCPT,SUBY,SUBYNAMES] = perfcurve(labels,scores,1);
figure;plot(X,Y)

scores=[mean(fg1e(time2,:),1) mean(fg4e(time2,:),1)];
labels=ones(1,size(scores,2));
labels(size(fg1e,2)+1:end)=0;
[X,Y,THRE,AUC14_late,OPTROCPT,SUBY,SUBYNAMES] = perfcurve(labels,scores,1);
figure;plot(X,Y)
time2=39:42;
scores=[mean(fg2e(time2,:),1) mean(fg5e(time2,:),1)];
labels=ones(1,size(scores,2));
labels(size(fg2e,2)+1:end)=0;
[X,Y,THRE,AUC25_late,OPTROCPT,SUBY,SUBYNAMES] = perfcurve(labels,scores,1);
figure;plot(X,Y)
AUC14_late=1-AUC14_late;
AUC25_late=1-AUC25_late;
save AUC_cc_fg_early_late AUC14_late AUC25_late AUC14_early AUC25_early

%% SMEAGOL
%% 2912c
cd F:\Data\VSDI\Contour_integration\Smeagol\29Dec2010\c
load('fg_for_correlations_trialwise.mat')

time1=27:29;
time2=40:41;

scores=[mean(fg1c(time1,:),1) mean(fg4c(time1,:),1)];
labels=ones(1,size(scores,2));
labels(size(fg1c,2)+1:end)=0;
[X,Y,THRE,AUC14_early,OPTROCPT,SUBY,SUBYNAMES] = perfcurve(labels,scores,1);
figure;plot(X,Y)
scores=[mean(fg2c(time1,:),1) mean(fg5c(time1,:),1)];
labels=ones(1,size(scores,2));
labels(size(fg2c,2)+1:end)=0;
[X,Y,THRE,AUC25_early,OPTROCPT,SUBY,SUBYNAMES] = perfcurve(labels,scores,1);
figure;plot(X,Y)

scores=[mean(fg1c(time2,:),1) mean(fg4c(time2,:),1)];
labels=ones(1,size(scores,2));
labels(size(fg1c,2)+1:end)=0;
[X,Y,THRE,AUC14_late,OPTROCPT,SUBY,SUBYNAMES] = perfcurve(labels,scores,1);
figure;plot(X,Y)
scores=[mean(fg2c(time2,:),1) mean(fg5c(time2,:),1)];
labels=ones(1,size(scores,2));
labels(size(fg2c,2)+1:end)=0;
[X,Y,THRE,AUC25_late,OPTROCPT,SUBY,SUBYNAMES] = perfcurve(labels,scores,1);
figure;plot(X,Y)

save AUC_cc_fg_early_late AUC14_late AUC25_late AUC14_early AUC25_early

%% 2912e
cd F:\Data\VSDI\Contour_integration\Smeagol\29Dec2010\e
load('fg_for_correlation_trialwise.mat')

time1=27:30;
time2=39:44;

scores=[mean(fg1e(time1,:),1) mean(fg4e(time1,:),1)];
labels=ones(1,size(scores,2));
labels(size(fg1e,2)+1:end)=0;
[X,Y,THRE,AUC14_early,OPTROCPT,SUBY,SUBYNAMES] = perfcurve(labels,scores,1);
figure;plot(X,Y)
scores=[mean(fg2e(time1,:),1) mean(fg5e(time1,:),1)];
labels=ones(1,size(scores,2));
labels(size(fg2e,2)+1:end)=0;
[X,Y,THRE,AUC25_early,OPTROCPT,SUBY,SUBYNAMES] = perfcurve(labels,scores,1);
figure;plot(X,Y)

scores=[mean(fg1e(time2,:),1) mean(fg4e(time2,:),1)];
labels=ones(1,size(scores,2));
labels(size(fg1e,2)+1:end)=0;
[X,Y,THRE,AUC14_late,OPTROCPT,SUBY,SUBYNAMES] = perfcurve(labels,scores,1);
figure;plot(X,Y)
scores=[mean(fg2e(time2,:),1) mean(fg5e(time2,:),1)];
labels=ones(1,size(scores,2));
labels(size(fg2e,2)+1:end)=0;
[X,Y,THRE,AUC25_late,OPTROCPT,SUBY,SUBYNAMES] = perfcurve(labels,scores,1);
figure;plot(X,Y)

save AUC_cc_fg_early_late AUC14_late AUC25_late AUC14_early AUC25_early

%% 2912k
cd F:\Data\VSDI\Contour_integration\Smeagol\29Dec2010\k
load('fg_for_correlation_trialwise.mat')

time1=30:33;
time2=41:43;

scores=[mean(fg1k(time1,:),1) mean(fg4k(time1,:),1)];
labels=ones(1,size(scores,2));
labels(size(fg1k,2)+1:end)=0;
[X,Y,THRE,AUC14_early,OPTROCPT,SUBY,SUBYNAMES] = perfcurve(labels,scores,1);
figure;plot(X,Y)
scores=[mean(fg2k(time1,:),1) mean(fg5k(time1,:),1)];
labels=ones(1,size(scores,2));
labels(size(fg2k,2)+1:end)=0;
[X,Y,THRE,AUC25_early,OPTROCPT,SUBY,SUBYNAMES] = perfcurve(labels,scores,1);
figure;plot(X,Y)

scores=[mean(fg1k(time2,:),1) mean(fg4k(time2,:),1)];
labels=ones(1,size(scores,2));
labels(size(fg1k,2)+1:end)=0;
[X,Y,THRE,AUC14_late,OPTROCPT,SUBY,SUBYNAMES] = perfcurve(labels,scores,1);
figure;plot(X,Y)
scores=[mean(fg2k(time2,:),1) mean(fg5k(time2,:),1)];
labels=ones(1,size(scores,2));
labels(size(fg2k,2)+1:end)=0;
[X,Y,THRE,AUC25_late,OPTROCPT,SUBY,SUBYNAMES] = perfcurve(labels,scores,1);
figure;plot(X,Y)

save AUC_cc_fg_early_late AUC14_late AUC25_late AUC14_early AUC25_early

%% 0501b
cd F:\Data\VSDI\Contour_integration\Smeagol\05Jan2011\b
load('fg_for_correlation_trialwise.mat')

time1=31:34;
time2=42:45;

scores=[mean(fg1b(time1,:),1) mean(fg4b(time1,:),1)];
labels=ones(1,size(scores,2));
labels(size(fg1b,2)+1:end)=0;
[X,Y,THRE,AUC14_early,OPTROCPT,SUBY,SUBYNAMES] = perfcurve(labels,scores,1);
figure;plot(X,Y)
time1=27:29;

scores=[mean(fg2b(time1,:),1) mean(fg5b(time1,:),1)];
labels=ones(1,size(scores,2));
labels(size(fg2b,2)+1:end)=0;
[X,Y,THRE,AUC25_early,OPTROCPT,SUBY,SUBYNAMES] = perfcurve(labels,scores,1);
figure;plot(X,Y)

scores=[mean(fg1b(time2,:),1) mean(fg4b(time2,:),1)];
labels=ones(1,size(scores,2));
labels(size(fg1b,2)+1:end)=0;
[X,Y,THRE,AUC14_late,OPTROCPT,SUBY,SUBYNAMES] = perfcurve(labels,scores,1);
figure;plot(X,Y)
time2=39:41;
scores=[mean(fg2b(time2,:),1) mean(fg5b(time2,:),1)];
labels=ones(1,size(scores,2));
labels(size(fg2b,2)+1:end)=0;
[X,Y,THRE,AUC25_late,OPTROCPT,SUBY,SUBYNAMES] = perfcurve(labels,scores,1);
figure;plot(X,Y)

save AUC_cc_fg_early_late AUC14_late AUC25_late AUC14_early AUC25_early


%% 0501c
cd F:\Data\VSDI\Contour_integration\Smeagol\05Jan2011\c
load('figure_ground_for_correlations_trial_wise')

time1=27:30;
time2=43:46;

scores=[mean(fg1c(time1,:),1) mean(fg5c(time1,:),1)];
labels=ones(1,size(scores,2));
labels(size(fg1c,2)+1:end)=0;
[X,Y,THRE,AUC15_early,OPTROCPT,SUBY,SUBYNAMES] = perfcurve(labels,scores,1);
figure;plot(X,Y)

scores=[mean(fg1c(time2,:),1) mean(fg5c(time2,:),1)];
labels=ones(1,size(scores,2));
labels(size(fg1c,2)+1:end)=0;
[X,Y,THRE,AUC15_late,OPTROCPT,SUBY,SUBYNAMES] = perfcurve(labels,scores,1);
figure;plot(X,Y)

save AUC_cc_fg_early_late AUC15_late AUC15_early

%% 0501d
cd F:\Data\VSDI\Contour_integration\Smeagol\05Jan2011\d
load('figure_ground_for_correlations_trial_wise')

time1=27:28;
time2=42:43;

scores=[mean(fg1d(time1,:),1) mean(fg5d(time1,:),1)];
labels=ones(1,size(scores,2));
labels(size(fg1d,2)+1:end)=0;
[X,Y,THRE,AUC15_early,OPTROCPT,SUBY,SUBYNAMES] = perfcurve(labels,scores,1);
figure;plot(X,Y)

scores=[mean(fg1d(time2,:),1) mean(fg5d(time2,:),1)];
labels=ones(1,size(scores,2));
labels(size(fg1d,2)+1:end)=0;
[X,Y,THRE,AUC15_late,OPTROCPT,SUBY,SUBYNAMES] = perfcurve(labels,scores,1);
figure;plot(X,Y)

save AUC_cc_fg_early_late AUC15_late AUC15_early
%%
AUC_smeg=[AUC_2912c14 AUC_2912c25 AUC_2912e14 AUC_2912e25 AUC_2912k14 AUC_2912k25...
    AUC_0501b14 AUC_0501b25 AUC_0501c15 AUC_0501d15];


%%
figure;bar([mean(AUC_leg(unnoisy_sessions)) mean(AUC_smeg)])
hold on
errorbar([mean(AUC_leg(unnoisy_sessions)) mean(AUC_smeg)],[std(AUC_leg(unnoisy_sessions))/sqrt(18) std(AUC_smeg)/sqrt(10)])
ylim([0.5 1])




