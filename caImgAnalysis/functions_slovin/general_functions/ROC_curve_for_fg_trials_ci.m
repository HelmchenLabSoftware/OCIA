%% 2511
%d
fg_c1d=squeeze(mean(mean(cond1n_dt_bl(roi_circle_diff,53:58,:),1),2))-squeeze(mean(mean(cond1n_dt_bl(roi_bg_in,53:58,:),1),2));
fg_10=squeeze(mean(mean(cond2n_dt_bl(roi_circle_diff,53:58,:),1),2))-squeeze(mean(mean(cond2n_dt_bl(roi_bg_in,53:58,:),1),2));
fg_15=squeeze(mean(mean(cond4n_dt_bl(roi_circle_diff,53:58,:),1),2))-squeeze(mean(mean(cond4n_dt_bl(roi_bg_in,53:58,:),1),2));
fg_c5d=squeeze(mean(mean(cond5n_dt_bl(roi_circle_diff,53:58,:),1),2))-squeeze(mean(mean(cond5n_dt_bl(roi_bg_in,53:58,:),1),2));
[n1 x1]=hist(fg_c1d,-1e-3:1e-4:1e-3);
[n2 x2]=hist(fg_10,-1e-3:1e-4:1e-3);
[n3 x3]=hist(fg_15,-1e-3:1e-4:1e-3);
[n4 x4]=hist(fg_c5d,-1e-3:1e-4:1e-3);
figure;bar(x1,[n1;n2;n3;n4]')
legend('contour','10deg','15deg','non-contour')

%e
fg_c1e=squeeze(mean(mean(cond1n_dt_bl(roi_circle_diff,53:58,:),1),2))-squeeze(mean(mean(cond1n_dt_bl(roi_bg_in,53:58,:),1),2));
fg_17=squeeze(mean(mean(cond2n_dt_bl(roi_circle_diff,53:58,:),1),2))-squeeze(mean(mean(cond2n_dt_bl(roi_bg_in,53:58,:),1),2));
fg_20=squeeze(mean(mean(cond4n_dt_bl(roi_circle_diff,53:58,:),1),2))-squeeze(mean(mean(cond4n_dt_bl(roi_bg_in,53:58,:),1),2));
fg_c5e=squeeze(mean(mean(cond5n_dt_bl(roi_circle_diff,53:58,:),1),2))-squeeze(mean(mean(cond5n_dt_bl(roi_bg_in,53:58,:),1),2));
[n1 x1]=hist(fg_c1e,-1e-3:1e-4:1e-3);
[n2 x2]=hist(fg_17,-1e-3:1e-4:1e-3);
[n3 x3]=hist(fg_20,-1e-3:1e-4:1e-3);
[n4 x4]=hist(fg_c5e,-1e-3:1e-4:1e-3);
figure;bar(x1,[n1;n2;n3;n4]')
legend('contour','17deg','20deg','non-contour')


%e
fg_c1f=squeeze(mean(mean(cond1n_dt_bl(roi_circle_diff,53:58,:),1),2))-squeeze(mean(mean(cond1n_dt_bl(roi_bg_in,53:58,:),1),2));
fg_5=squeeze(mean(mean(cond2n_dt_bl(roi_circle_diff,53:58,:),1),2))-squeeze(mean(mean(cond2n_dt_bl(roi_bg_in,53:58,:),1),2));
fg_25=squeeze(mean(mean(cond4n_dt_bl(roi_circle_diff,53:58,:),1),2))-squeeze(mean(mean(cond4n_dt_bl(roi_bg_in,53:58,:),1),2));
fg_c5f=squeeze(mean(mean(cond5n_dt_bl(roi_circle_diff,53:58,:),1),2))-squeeze(mean(mean(cond5n_dt_bl(roi_bg_in,53:58,:),1),2));
[n1 x1]=hist(fg_c1f,-1e-3:1e-4:1e-3);
[n2 x2]=hist(fg_5,-1e-3:1e-4:1e-3);
[n3 x3]=hist(fg_25,-1e-3:1e-4:1e-3);
[n4 x4]=hist(fg_c5f,-1e-3:1e-4:1e-3);
figure;bar(x1,[n1;n2;n3;n4]')
legend('contour','5deg','25deg','non-contour')

%% ROC for fg
%d
scores=[fg_c1d;fg_c5d]';
labels=ones(1,size(scores,2));
labels(size(fg_c1d,1)+1:end)=0;
[X_c1d,Y_c1d,THRE,AUC_c1d,OPTROCPT,SUBY,SUBYNAMES] = perfcurve(labels,scores,1);

scores=[fg_10;fg_c5d]';
labels=ones(1,size(scores,2));
labels(size(fg_10,1)+1:end)=0;
[X_10,Y_10,THRE,AUC_10,OPTROCPT,SUBY,SUBYNAMES] = perfcurve(labels,scores,1);

scores=[fg_15;fg_c5d]';
labels=ones(1,size(scores,2));
labels(size(fg_15,1)+1:end)=0;
[X_15,Y_15,THRE,AUC_15,OPTROCPT,SUBY,SUBYNAMES] = perfcurve(labels,scores,1);


figure;plot(X_c1d,Y_c1d)
hold on
plot(X_10,Y_10,'r')
plot(X_15,Y_15,'g')

%e
scores=[fg_c1e;fg_c5e]';
labels=ones(1,size(scores,2));
labels(size(fg_c1e,1)+1:end)=0;
[X_c1e,Y_c1e,THRE,AUC_c1e,OPTROCPT,SUBY,SUBYNAMES] = perfcurve(labels,scores,1);

scores=[fg_17;fg_c5e]';
labels=ones(1,size(scores,2));
labels(size(fg_17,1)+1:end)=0;
[X_17,Y_17,THRE,AUC_17,OPTROCPT,SUBY,SUBYNAMES] = perfcurve(labels,scores,1);

scores=[fg_20;fg_c5e]';
labels=ones(1,size(scores,2));
labels(size(fg_20,1)+1:end)=0;
[X_20,Y_20,THRE,AUC_20,OPTROCPT,SUBY,SUBYNAMES] = perfcurve(labels,scores,1);


figure;plot(X_c1e,Y_c1e)
hold on
plot(X_17,Y_17,'r')
plot(X_20,Y_20,'g')



%f
scores=[fg_c1f;fg_c5f]';
labels=ones(1,size(scores,2));
labels(size(fg_c1f,1)+1:end)=0;
[X_c1f,Y_c1f,THRE,AUC_c1f,OPTROCPT,SUBY,SUBYNAMES] = perfcurve(labels,scores,1);

scores=[fg_5;fg_c5f]';
labels=ones(1,size(scores,2));
labels(size(fg_5,1)+1:end)=0;
[X_5,Y_5,THRE,AUC_5,OPTROCPT,SUBY,SUBYNAMES] = perfcurve(labels,scores,1);

scores=[fg_25;fg_c5f]';
labels=ones(1,size(scores,2));
labels(size(fg_25,1)+1:end)=0;
[X_25,Y_25,THRE,AUC_25,OPTROCPT,SUBY,SUBYNAMES] = perfcurve(labels,scores,1);


figure;plot(X_c1f,Y_c1f)
hold on
plot(X_5,Y_5,'r')
plot(X_25,Y_25,'g')



AUC_curve(1)=mean([AUC_c1d AUC_c1e AUC_c1f]);
AUC_curve(2)=AUC_5;
AUC_curve(3)=AUC_10;
AUC_curve(4)=AUC_15;
AUC_curve(5)=AUC_17;
AUC_curve(6)=AUC_20;
AUC_curve(7)=AUC_25;
AUC_curve(8)=0.5;

figure;plot([0 5 10 15 17 20 25 45],AUC_curve)



%maybe normalize
AUC_curve_2511(1)=1;
AUC_curve_2511(2)=AUC_5/AUC_c1f;
AUC_curve_2511(3)=AUC_10/AUC_c1d;
AUC_curve_2511(4)=AUC_15/AUC_c1d;
AUC_curve_2511(5)=AUC_17/AUC_c1e;
AUC_curve_2511(6)=AUC_20/AUC_c1e;
AUC_curve_2511(7)=AUC_25/AUC_c1f;
AUC_curve_2511(8)=0.5;
figure;plot([0 5 10 15 17 20 25 45],AUC_curve_2511)

%% d prime


dp_c1d=(mean(fg_c1d)-mean(fg_c5d))/sqrt((std(fg_c1d)^2+std(fg_c5d)^2)/2);
dp_10=(mean(fg_10)-mean(fg_c5d))/sqrt((std(fg_10)^2+std(fg_c5d)^2)/2);
dp_15=(mean(fg_15)-mean(fg_c5d))/sqrt((std(fg_15)^2+std(fg_c5d)^2)/2);

dp_c1e=(mean(fg_c1e)-mean(fg_c5e))/sqrt((std(fg_c1e)^2+std(fg_c5e)^2)/2);
dp_17=(mean(fg_17)-mean(fg_c5e))/sqrt((std(fg_17)^2+std(fg_c5e)^2)/2);
dp_20=(mean(fg_20)-mean(fg_c5e))/sqrt((std(fg_20)^2+std(fg_c5e)^2)/2);


dp_c1f=(mean(fg_c1f)-mean(fg_c5f))/sqrt((std(fg_c1f)^2+std(fg_c5f)^2)/2);
dp_5=(mean(fg_5)-mean(fg_c5f))/sqrt((std(fg_5)^2+std(fg_c5f)^2)/2);
dp_25=(mean(fg_25)-mean(fg_c5f))/sqrt((std(fg_25)^2+std(fg_c5f)^2)/2);


dprime_curve(1)=mean([dp_c1d dp_c1e dp_c1f]);
dprime_curve(2)=dp_5;
dprime_curve(3)=dp_10;
dprime_curve(4)=dp_15;
dprime_curve(5)=dp_17;
dprime_curve(6)=dp_20;
dprime_curve(7)=dp_25;
dprime_curve(8)=0;

figure;plot([0 5 10 15 17 20 25 45],dprime_curve)






%% 1811
%c
fg_c1c=squeeze(mean(mean(cond1n_dt_bl(roi_circle_diff,42:52,:),1),2))-squeeze(mean(mean(cond1n_dt_bl(roi_bg_in,42:52,:),1),2));
fg_5=squeeze(mean(mean(cond2n_dt_bl(roi_circle_diff,42:52,:),1),2))-squeeze(mean(mean(cond2n_dt_bl(roi_bg_in,42:52,:),1),2));
fg_15=squeeze(mean(mean(cond4n_dt_bl(roi_circle_diff,42:52,:),1),2))-squeeze(mean(mean(cond4n_dt_bl(roi_bg_in,42:52,:),1),2));
fg_c5c=squeeze(mean(mean(cond5n_dt_bl(roi_circle_diff,42:52,:),1),2))-squeeze(mean(mean(cond5n_dt_bl(roi_bg_in,42:52,:),1),2));
[n1 x1]=hist(fg_c1c,-1e-3:1e-4:1e-3);
[n2 x2]=hist(fg_5,-1e-3:1e-4:1e-3);
[n3 x3]=hist(fg_15,-1e-3:1e-4:1e-3);
[n4 x4]=hist(fg_c5c,-1e-3:1e-4:1e-3);
figure;bar(x1,[n1;n2;n3;n4]')
legend('contour','5deg','15deg','non-contour')

%d
fg_c1d=squeeze(mean(mean(cond1n_dt_bl(roi_circle_diff,42:52,:),1),2))-squeeze(mean(mean(cond1n_dt_bl(roi_bg_in,42:52,:),1),2));
fg_10=squeeze(mean(mean(cond2n_dt_bl(roi_circle_diff,42:52,:),1),2))-squeeze(mean(mean(cond2n_dt_bl(roi_bg_in,42:52,:),1),2));
fg_20=squeeze(mean(mean(cond4n_dt_bl(roi_circle_diff,42:52,:),1),2))-squeeze(mean(mean(cond4n_dt_bl(roi_bg_in,42:52,:),1),2));
fg_c5d=squeeze(mean(mean(cond5n_dt_bl(roi_circle_diff,42:52,:),1),2))-squeeze(mean(mean(cond5n_dt_bl(roi_bg_in,42:52,:),1),2));
[n1 x1]=hist(fg_c1d,-1e-3:1e-4:1e-3);
[n2 x2]=hist(fg_10,-1e-3:1e-4:1e-3);
[n3 x3]=hist(fg_20,-1e-3:1e-4:1e-3);
[n4 x4]=hist(fg_c5d,-1e-3:1e-4:1e-3);
figure;bar(x1,[n1;n2;n3;n4]')
legend('contour','10deg','20deg','non-contour')

%e
fg_c1e=squeeze(mean(mean(cond1n_dt_bl(roi_circle_diff,42:52,:),1),2))-squeeze(mean(mean(cond1n_dt_bl(roi_bg_in,42:52,:),1),2));
fg_17=squeeze(mean(mean(cond2n_dt_bl(roi_circle_diff,42:52,:),1),2))-squeeze(mean(mean(cond2n_dt_bl(roi_bg_in,42:52,:),1),2));
fg_25=squeeze(mean(mean(cond4n_dt_bl(roi_circle_diff,42:52,:),1),2))-squeeze(mean(mean(cond4n_dt_bl(roi_bg_in,42:52,:),1),2));
fg_c5e=squeeze(mean(mean(cond5n_dt_bl(roi_circle_diff,42:52,:),1),2))-squeeze(mean(mean(cond5n_dt_bl(roi_bg_in,42:52,:),1),2));
[n1 x1]=hist(fg_c1d,-1e-3:1e-4:1e-3);
[n2 x2]=hist(fg_10,-1e-3:1e-4:1e-3);
[n3 x3]=hist(fg_20,-1e-3:1e-4:1e-3);
[n4 x4]=hist(fg_c5d,-1e-3:1e-4:1e-3);
figure;bar(x1,[n1;n2;n3;n4]')
legend('contour','10deg','20deg','non-contour')





%% ROC for fg
%c
scores=[fg_c1c;fg_c5c]';
labels=ones(1,size(scores,2));
labels(size(fg_c1c,1)+1:end)=0;
[X_c1c,Y_c1c,THRE,AUC_c1c,OPTROCPT,SUBY,SUBYNAMES] = perfcurve(labels,scores,1);

scores=[fg_5;fg_c5c]';
labels=ones(1,size(scores,2));
labels(size(fg_5,1)+1:end)=0;
[X_5,Y_5,THRE,AUC_5,OPTROCPT,SUBY,SUBYNAMES] = perfcurve(labels,scores,1);

scores=[fg_15;fg_c5c]';
labels=ones(1,size(scores,2));
labels(size(fg_15,1)+1:end)=0;
[X_15,Y_15,THRE,AUC_15,OPTROCPT,SUBY,SUBYNAMES] = perfcurve(labels,scores,1);


figure;plot(X_c1c,Y_c1c)
hold on
plot(X_5,Y_5,'r')
plot(X_15,Y_15,'g')


%d
scores=[fg_c1d;fg_c5d]';
labels=ones(1,size(scores,2));
labels(size(fg_c1d,1)+1:end)=0;
[X_c1d,Y_c1d,THRE,AUC_c1d,OPTROCPT,SUBY,SUBYNAMES] = perfcurve(labels,scores,1);

scores=[fg_10;fg_c5d]';
labels=ones(1,size(scores,2));
labels(size(fg_10,1)+1:end)=0;
[X_10,Y_10,THRE,AUC_10,OPTROCPT,SUBY,SUBYNAMES] = perfcurve(labels,scores,1);

scores=[fg_20;fg_c5d]';
labels=ones(1,size(scores,2));
labels(size(fg_20,1)+1:end)=0;
[X_20,Y_20,THRE,AUC_20,OPTROCPT,SUBY,SUBYNAMES] = perfcurve(labels,scores,1);


figure;plot(X_c1d,Y_c1d)
hold on
plot(X_10,Y_10,'r')
plot(X_20,Y_20,'g')



%e
scores=[fg_c1e;fg_c5e]';
labels=ones(1,size(scores,2));
labels(size(fg_c1e,1)+1:end)=0;
[X_c1e,Y_c1e,THRE,AUC_c1e,OPTROCPT,SUBY,SUBYNAMES] = perfcurve(labels,scores,1);

scores=[fg_17;fg_c5e]';
labels=ones(1,size(scores,2));
labels(size(fg_17,1)+1:end)=0;
[X_17,Y_17,THRE,AUC_17,OPTROCPT,SUBY,SUBYNAMES] = perfcurve(labels,scores,1);

scores=[fg_25;fg_c5e]';
labels=ones(1,size(scores,2));
labels(size(fg_25,1)+1:end)=0;
[X_25,Y_25,THRE,AUC_25,OPTROCPT,SUBY,SUBYNAMES] = perfcurve(labels,scores,1);


figure;plot(X_c1e,Y_c1e)
hold on
plot(X_17,Y_17,'r')
plot(X_25,Y_25,'g')



AUC_curve(1)=mean([AUC_c1c AUC_c1d AUC_c1e]);
AUC_curve(2)=AUC_5;
AUC_curve(3)=AUC_10;
AUC_curve(4)=AUC_15;
AUC_curve(5)=AUC_17;
AUC_curve(6)=AUC_20;
AUC_curve(7)=AUC_25;
AUC_curve(8)=0.5;

figure;plot([0 5 10 15 17 20 25 45],AUC_curve)


%maybe normalize
AUC_curve_1811(1)=1;
AUC_curve_1811(2)=AUC_5/AUC_c1c;
AUC_curve_1811(3)=AUC_10/AUC_c1d;
AUC_curve_1811(4)=AUC_15/AUC_c1c;
AUC_curve_1811(5)=AUC_17/AUC_c1e;
AUC_curve_1811(6)=AUC_20/AUC_c1d;
AUC_curve_1811(7)=AUC_25/AUC_c1e;
AUC_curve_1811(8)=0.5;
figure;plot([0 5 10 15 17 20 25 45],AUC_curve_1811)

%% d prime


dp_c1c=(mean(fg_c1c)-mean(fg_c5c))/sqrt((std(fg_c1c)^2+std(fg_c5c)^2)/2);
dp_5=(mean(fg_5)-mean(fg_c5c))/sqrt((std(fg_5)^2+std(fg_c5c)^2)/2);
dp_15=(mean(fg_15)-mean(fg_c5c))/sqrt((std(fg_15)^2+std(fg_c5c)^2)/2);

dp_c1d=(mean(fg_c1d)-mean(fg_c5d))/sqrt((std(fg_c1d)^2+std(fg_c5d)^2)/2);
dp_10=(mean(fg_10)-mean(fg_c5d))/sqrt((std(fg_10)^2+std(fg_c5d)^2)/2);
dp_20=(mean(fg_20)-mean(fg_c5d))/sqrt((std(fg_20)^2+std(fg_c5d)^2)/2);


dp_c1e=(mean(fg_c1e)-mean(fg_c5e))/sqrt((std(fg_c1e)^2+std(fg_c5e)^2)/2);
dp_17=(mean(fg_17)-mean(fg_c5e))/sqrt((std(fg_17)^2+std(fg_c5e)^2)/2);
dp_25=(mean(fg_25)-mean(fg_c5e))/sqrt((std(fg_25)^2+std(fg_c5e)^2)/2);


dprime_curve(1)=mean([dp_c1c dp_c1d dp_c1e]);
dprime_curve(2)=dp_5;
dprime_curve(3)=dp_10;
dprime_curve(4)=dp_15;
dprime_curve(5)=dp_17;
dprime_curve(6)=dp_20;
dprime_curve(7)=dp_25;
dprime_curve(8)=0;

figure;plot([0 5 10 15 17 20 25 45],dprime_curve)



%% 1203

%d
fg_c1d=squeeze(mean(mean(cond1n_dt_bl(roi_contour,42:52,:),1),2))-squeeze(mean(mean(cond1n_dt_bl(roi_bg_in,42:52,:),1),2));
fg_15=squeeze(mean(mean(cond2n_dt_bl(roi_contour,42:52,:),1),2))-squeeze(mean(mean(cond2n_dt_bl(roi_bg_in,42:52,:),1),2));
fg_20=squeeze(mean(mean(cond4n_dt_bl(roi_contour,42:52,:),1),2))-squeeze(mean(mean(cond4n_dt_bl(roi_bg_in,42:52,:),1),2));
fg_c5d=squeeze(mean(mean(cond5n_dt_bl(roi_contour,42:52,:),1),2))-squeeze(mean(mean(cond5n_dt_bl(roi_bg_in,42:52,:),1),2));
[n1 x1]=hist(fg_c1d,-1e-3:1e-4:1e-3);
[n2 x2]=hist(fg_15,-1e-3:1e-4:1e-3);
[n3 x3]=hist(fg_20,-1e-3:1e-4:1e-3);
[n4 x4]=hist(fg_c5d,-1e-3:1e-4:1e-3);
figure;bar(x1,[n1;n2;n3;n4]')
legend('contour','15deg','20deg','non-contour')




%e
fg_c1e=squeeze(mean(mean(cond1n_dt_bl(roi_contour,42:52,:),1),2))-squeeze(mean(mean(cond1n_dt_bl(roi_bg_in,42:52,:),1),2));
fg_5=squeeze(mean(mean(cond2n_dt_bl(roi_contour,42:52,:),1),2))-squeeze(mean(mean(cond2n_dt_bl(roi_bg_in,42:52,:),1),2));
fg_10=squeeze(mean(mean(cond4n_dt_bl(roi_contour,42:52,:),1),2))-squeeze(mean(mean(cond4n_dt_bl(roi_bg_in,42:52,:),1),2));
fg_c5e=squeeze(mean(mean(cond5n_dt_bl(roi_contour,42:52,:),1),2))-squeeze(mean(mean(cond5n_dt_bl(roi_bg_in,42:52,:),1),2));
[n1 x1]=hist(fg_c1e,-1e-3:1e-4:1e-3);
[n2 x2]=hist(fg_5,-1e-3:1e-4:1e-3);
[n3 x3]=hist(fg_10,-1e-3:1e-4:1e-3);
[n4 x4]=hist(fg_c5e,-1e-3:1e-4:1e-3);
figure;bar(x1,[n1;n2;n3;n4]')
legend('contour','5deg','10deg','non-contour')




%f
fg_c1f=squeeze(mean(mean(cond1n_dt_bl(roi_contour,42:52,:),1),2))-squeeze(mean(mean(cond1n_dt_bl(roi_bg_in,42:52,:),1),2));
fg_25=squeeze(mean(mean(cond2n_dt_bl(roi_contour,42:52,:),1),2))-squeeze(mean(mean(cond2n_dt_bl(roi_bg_in,42:52,:),1),2));
fg_30=squeeze(mean(mean(cond4n_dt_bl(roi_contour,42:52,:),1),2))-squeeze(mean(mean(cond4n_dt_bl(roi_bg_in,42:52,:),1),2));
fg_c5f=squeeze(mean(mean(cond5n_dt_bl(roi_contour,42:52,:),1),2))-squeeze(mean(mean(cond5n_dt_bl(roi_bg_in,42:52,:),1),2));
[n1 x1]=hist(fg_c1f,-1e-3:1e-4:1e-3);
[n2 x2]=hist(fg_25,-1e-3:1e-4:1e-3);
[n3 x3]=hist(fg_30,-1e-3:1e-4:1e-3);
[n4 x4]=hist(fg_c5f,-1e-3:1e-4:1e-3);
figure;bar(x1,[n1;n2;n3;n4]')
legend('contour','25deg','30deg','non-contour')





%% ROC for fg
%d
scores=[fg_c1d;fg_c5d]';
labels=ones(1,size(scores,2));
labels(size(fg_c1d,1)+1:end)=0;
[X_c1d,Y_c1d,THRE,AUC_c1d,OPTROCPT,SUBY,SUBYNAMES] = perfcurve(labels,scores,1);

scores=[fg_15;fg_c5d]';
labels=ones(1,size(scores,2));
labels(size(fg_15,1)+1:end)=0;
[X_15,Y_15,THRE,AUC_15,OPTROCPT,SUBY,SUBYNAMES] = perfcurve(labels,scores,1);

scores=[fg_20;fg_c5d]';
labels=ones(1,size(scores,2));
labels(size(fg_20,1)+1:end)=0;
[X_20,Y_20,THRE,AUC_20,OPTROCPT,SUBY,SUBYNAMES] = perfcurve(labels,scores,1);


figure;plot(X_c1d,Y_c1d)
hold on
plot(X_15,Y_15,'r')
plot(X_20,Y_20,'g')

%e
scores=[fg_c1e;fg_c5e]';
labels=ones(1,size(scores,2));
labels(size(fg_c1e,1)+1:end)=0;
[X_c1e,Y_c1e,THRE,AUC_c1e,OPTROCPT,SUBY,SUBYNAMES] = perfcurve(labels,scores,1);

scores=[fg_5;fg_c5e]';
labels=ones(1,size(scores,2));
labels(size(fg_5,1)+1:end)=0;
[X_5,Y_5,THRE,AUC_5,OPTROCPT,SUBY,SUBYNAMES] = perfcurve(labels,scores,1);

scores=[fg_10;fg_c5e]';
labels=ones(1,size(scores,2));
labels(size(fg_10,1)+1:end)=0;
[X_10,Y_10,THRE,AUC_10,OPTROCPT,SUBY,SUBYNAMES] = perfcurve(labels,scores,1);


figure;plot(X_c1e,Y_c1e)
hold on
plot(X_5,Y_5,'r')
plot(X_10,Y_10,'g')



%f
scores=[fg_c1f;fg_c5f]';
labels=ones(1,size(scores,2));
labels(size(fg_c1f,1)+1:end)=0;
[X_c1f,Y_c1f,THRE,AUC_c1f,OPTROCPT,SUBY,SUBYNAMES] = perfcurve(labels,scores,1);

scores=[fg_25;fg_c5f]';
labels=ones(1,size(scores,2));
labels(size(fg_25,1)+1:end)=0;
[X_25,Y_25,THRE,AUC_25,OPTROCPT,SUBY,SUBYNAMES] = perfcurve(labels,scores,1);

scores=[fg_30;fg_c5f]';
labels=ones(1,size(scores,2));
labels(size(fg_30,1)+1:end)=0;
[X_30,Y_30,THRE,AUC_30,OPTROCPT,SUBY,SUBYNAMES] = perfcurve(labels,scores,1);


figure;plot(X_c1f,Y_c1f)
hold on
plot(X_25,Y_25,'r')
plot(X_30,Y_30,'g')



AUC_curve(1)=mean([AUC_c1d AUC_c1e AUC_c1f]);
AUC_curve(2)=AUC_5;
AUC_curve(3)=AUC_10;
AUC_curve(4)=AUC_15;
AUC_curve(5)=AUC_20;
AUC_curve(6)=AUC_25;
AUC_curve(7)=AUC_30;
AUC_curve(8)=0.5;

figure;plot([0 5 10 15 20 25 30 45],AUC_curve)



%maybe normalize
AUC_curve_1203(1)=1;
AUC_curve_1203(2)=AUC_5/AUC_c1e;
AUC_curve_1203(3)=AUC_10/AUC_c1e;
AUC_curve_1203(4)=AUC_15/AUC_c1d;
AUC_curve_1203(5)=AUC_20/AUC_c1d;
AUC_curve_1203(6)=AUC_25/AUC_c1f;
AUC_curve_1203(7)=AUC_30/AUC_c1f;
AUC_curve_1203(8)=0.5;
figure;plot([0 5 10 15 17 20 25 45],AUC_curve_1203)


%% d prime


dp_c1d=(mean(fg_c1d)-mean(fg_c5d))/sqrt((std(fg_c1d)^2+std(fg_c5d)^2)/2);
dp_15=(mean(fg_15)-mean(fg_c5d))/sqrt((std(fg_15)^2+std(fg_c5d)^2)/2);
dp_20=(mean(fg_20)-mean(fg_c5d))/sqrt((std(fg_20)^2+std(fg_c5d)^2)/2);

dp_c1e=(mean(fg_c1e)-mean(fg_c5e))/sqrt((std(fg_c1e)^2+std(fg_c5e)^2)/2);
dp_5=(mean(fg_5)-mean(fg_c5e))/sqrt((std(fg_5)^2+std(fg_c5e)^2)/2);
dp_10=(mean(fg_10)-mean(fg_c5e))/sqrt((std(fg_10)^2+std(fg_c5e)^2)/2);


dp_c1f=(mean(fg_c1f)-mean(fg_c5f))/sqrt((std(fg_c1f)^2+std(fg_c5f)^2)/2);
dp_25=(mean(fg_25)-mean(fg_c5f))/sqrt((std(fg_25)^2+std(fg_c5f)^2)/2);
dp_30=(mean(fg_30)-mean(fg_c5f))/sqrt((std(fg_30)^2+std(fg_c5f)^2)/2);


dprime_curve(1)=mean([dp_c1d dp_c1e dp_c1f]);
dprime_curve(2)=dp_5;
dprime_curve(3)=dp_10;
dprime_curve(4)=dp_15;
dprime_curve(5)=dp_20;
dprime_curve(6)=dp_25;
dprime_curve(7)=dp_30;
dprime_curve(8)=0;

figure;plot([0 5 10 15 20 25 30 45],dprime_curve)



%% LEGOLAS

AUC_curve(1)=mean([AUC_curve_1811(1) AUC_curve_2511(1) AUC_curve_1203(1)]);
AUC_curve(2)=mean([AUC_curve_1811(2) AUC_curve_2511(2) AUC_curve_1203(2)]);
AUC_curve(3)=mean([AUC_curve_1811(3) AUC_curve_2511(3) AUC_curve_1203(3)]);
AUC_curve(4)=mean([AUC_curve_1811(4) AUC_curve_2511(4) AUC_curve_1203(4)]);
AUC_curve(5)=mean([AUC_curve_1811(5) AUC_curve_2511(5)]);
AUC_curve(6)=mean([AUC_curve_1811(6) AUC_curve_2511(6) AUC_curve_1203(5)]);
AUC_curve(7)=mean([AUC_curve_1811(7) AUC_curve_2511(7) AUC_curve_1203(6)]);
AUC_curve(8)=AUC_curve_1203(7);
AUC_curve(9)=mean([AUC_curve_1811(8) AUC_curve_2511(8) AUC_curve_1203(8)]);


dprime_curve(1)=mean([dprime_curve_1811(1) dprime_curve_2511(1) dprime_curve_1203(1)]);
dprime_curve(2)=mean([dprime_curve_1811(2) dprime_curve_2511(2) dprime_curve_1203(2)]);
dprime_curve(3)=mean([dprime_curve_1811(3) dprime_curve_2511(3) dprime_curve_1203(3)]);
dprime_curve(4)=mean([dprime_curve_1811(4) dprime_curve_2511(4) dprime_curve_1203(4)]);
dprime_curve(5)=mean([dprime_curve_1811(5) dprime_curve_2511(5)]);
dprime_curve(6)=mean([dprime_curve_1811(6) dprime_curve_2511(6) dprime_curve_1203(5)]);
dprime_curve(7)=mean([dprime_curve_1811(7) dprime_curve_2511(7) dprime_curve_1203(6)]);
dprime_curve(8)=dprime_curve_1203(7);
dprime_curve(9)=mean([dprime_curve_1811(8) dprime_curve_2511(8) dprime_curve_1203(8)]);


figure;plot([0 5 10 15 17 20 25 30 45],AUC_curve)
figure;plot([0 5 10 15 17 20 25 30 45],dprime_curve)

figure;bar(AUC_curve)

[r,m,b] = regression([0 5 10 15 17 20 25 30 45],AUC_curve);
xx=0:0.25:45;
figure;plot([0 5 10 15 17 20 25 30 45],AUC_curve)
hold on
plot(xx,m*xx+b)

%% 0501
%c
fg_c1c=squeeze(mean(mean(cond1n_dt_bl(roi_circle,48:58,:),1),2))-squeeze(mean(mean(cond1n_dt_bl(roi_bg_out,48:58,:),1),2));
fg_10=squeeze(mean(mean(cond2n_dt_bl(roi_circle,48:58,:),1),2))-squeeze(mean(mean(cond2n_dt_bl(roi_bg_out,48:58,:),1),2));
fg_20=squeeze(mean(mean(cond4n_dt_bl(roi_circle,48:58,:),1),2))-squeeze(mean(mean(cond4n_dt_bl(roi_bg_out,48:58,:),1),2));
fg_c5c=squeeze(mean(mean(cond5n_dt_bl(roi_circle,48:58,:),1),2))-squeeze(mean(mean(cond5n_dt_bl(roi_bg_out,48:58,:),1),2));
[n1 x1]=hist(fg_c1c,-1e-3:1e-4:1e-3);
[n2 x2]=hist(fg_10,-1e-3:1e-4:1e-3);
[n3 x3]=hist(fg_20,-1e-3:1e-4:1e-3);
[n4 x4]=hist(fg_c5c,-1e-3:1e-4:1e-3);
figure;bar(x1,[n1;n2;n3;n4]')
legend('contour','10deg','20deg','non-contour')



%d
fg_c1d=squeeze(mean(mean(cond1n_dt_bl(roi_circle,48:58,:),1),2))-squeeze(mean(mean(cond1n_dt_bl(roi_bg_out,48:58,:),1),2));
fg_5=squeeze(mean(mean(cond2n_dt_bl(roi_circle,48:58,:),1),2))-squeeze(mean(mean(cond2n_dt_bl(roi_bg_out,48:58,:),1),2));
fg_15=squeeze(mean(mean(cond4n_dt_bl(roi_circle,48:58,:),1),2))-squeeze(mean(mean(cond4n_dt_bl(roi_bg_out,48:58,:),1),2));
fg_c5d=squeeze(mean(mean(cond5n_dt_bl(roi_circle,48:58,:),1),2))-squeeze(mean(mean(cond5n_dt_bl(roi_bg_out,48:58,:),1),2));
[n1 x1]=hist(fg_c1d,-1e-3:1e-4:1e-3);
[n2 x2]=hist(fg_5,-1e-3:1e-4:1e-3);
[n3 x3]=hist(fg_15,-1e-3:1e-4:1e-3);
[n4 x4]=hist(fg_c5d,-1e-3:1e-4:1e-3);
figure;bar(x1,[n1;n2;n3;n4]')
legend('contour','5deg','15deg','non-contour')





%% ROC for fg
%c
scores=[fg_c1c;fg_c5c]';
labels=ones(1,size(scores,2));
labels(size(fg_c1c,1)+1:end)=0;
[X_c1c,Y_c1c,THRE,AUC_c1c,OPTROCPT,SUBY,SUBYNAMES] = perfcurve(labels,scores,1);

scores=[fg_10;fg_c5c]';
labels=ones(1,size(scores,2));
labels(size(fg_10,1)+1:end)=0;
[X_10,Y_10,THRE,AUC_10,OPTROCPT,SUBY,SUBYNAMES] = perfcurve(labels,scores,1);

scores=[fg_20;fg_c5c]';
labels=ones(1,size(scores,2));
labels(size(fg_20,1)+1:end)=0;
[X_20,Y_20,THRE,AUC_20,OPTROCPT,SUBY,SUBYNAMES] = perfcurve(labels,scores,1);


figure;plot(X_c1c,Y_c1c)
hold on
plot(X_10,Y_10,'r')
plot(X_20,Y_20,'g')


%d
scores=[fg_c1d;fg_c5d]';
labels=ones(1,size(scores,2));
labels(size(fg_c1d,1)+1:end)=0;
[X_c1d,Y_c1d,THRE,AUC_c1d,OPTROCPT,SUBY,SUBYNAMES] = perfcurve(labels,scores,1);

scores=[fg_5;fg_c5d]';
labels=ones(1,size(scores,2));
labels(size(fg_5,1)+1:end)=0;
[X_5,Y_5,THRE,AUC_5,OPTROCPT,SUBY,SUBYNAMES] = perfcurve(labels,scores,1);

scores=[fg_15;fg_c5d]';
labels=ones(1,size(scores,2));
labels(size(fg_15,1)+1:end)=0;
[X_15,Y_15,THRE,AUC_15,OPTROCPT,SUBY,SUBYNAMES] = perfcurve(labels,scores,1);


figure;plot(X_c1d,Y_c1d)
hold on
plot(X_5,Y_5,'r')
plot(X_15,Y_15,'g')



AUC_curve(1)=mean([AUC_c1c AUC_c1d]);
AUC_curve(2)=AUC_5;
AUC_curve(3)=AUC_10;
AUC_curve(4)=AUC_15;
AUC_curve(5)=AUC_20;
AUC_curve(6)=0.5;

figure;plot([0 5 10 15 20 45],AUC_curve)

%maybe normalize
AUC_curve_0501(1)=1;
AUC_curve_0501(2)=AUC_5/AUC_c1d;
AUC_curve_0501(3)=AUC_10/AUC_c1c;
AUC_curve_0501(4)=AUC_15/AUC_c1d;
AUC_curve_0501(5)=AUC_20/AUC_c1c;
AUC_curve_0501(6)=0.5;

figure;plot([0 5 10 15 20 45],AUC_curve_0501)

%% d prime


dp_c1c=(mean(fg_c1c)-mean(fg_c5c))/sqrt((std(fg_c1c)^2+std(fg_c5c)^2)/2);
dp_5=(mean(fg_10)-mean(fg_c5c))/sqrt((std(fg_10)^2+std(fg_c5c)^2)/2);
dp_15=(mean(fg_20)-mean(fg_c5c))/sqrt((std(fg_20)^2+std(fg_c5c)^2)/2);

dp_c1d=(mean(fg_c1d)-mean(fg_c5d))/sqrt((std(fg_c1d)^2+std(fg_c5d)^2)/2);
dp_10=(mean(fg_5)-mean(fg_c5d))/sqrt((std(fg_5)^2+std(fg_c5d)^2)/2);
dp_20=(mean(fg_15)-mean(fg_c5d))/sqrt((std(fg_15)^2+std(fg_c5d)^2)/2);


dprime_curve(1)=mean([dp_c1c dp_c1d]);
dprime_curve(2)=dp_5;
dprime_curve(3)=dp_10;
dprime_curve(4)=dp_15;
dprime_curve(5)=dp_20;
dprime_curve(6)=0;

figure;plot([0 5 10 15 20 45],dprime_curve)


%% 2212
%c
fg_c1c=squeeze(mean(mean(cond1n_dt_bl(roi_circle,48:58,:),1),2))-squeeze(mean(mean(cond1n_dt_bl(roi_bg_in,48:58,:),1),2));
fg_5=squeeze(mean(mean(cond2n_dt_bl(roi_circle,48:58,:),1),2))-squeeze(mean(mean(cond2n_dt_bl(roi_bg_in,48:58,:),1),2));
fg_20=squeeze(mean(mean(cond4n_dt_bl(roi_circle,48:58,:),1),2))-squeeze(mean(mean(cond4n_dt_bl(roi_bg_in,48:58,:),1),2));
fg_c5c=squeeze(mean(mean(cond5n_dt_bl(roi_circle,48:58,:),1),2))-squeeze(mean(mean(cond5n_dt_bl(roi_bg_in,48:58,:),1),2));
[n1 x1]=hist(fg_c1c,-1e-3:1e-4:1e-3);
[n2 x2]=hist(fg_5,-1e-3:1e-4:1e-3);
[n3 x3]=hist(fg_20,-1e-3:1e-4:1e-3);
[n4 x4]=hist(fg_c5c,-1e-3:1e-4:1e-3);
figure;bar(x1,[n1;n2;n3;n4]')
legend('contour','5deg','20deg','non-contour')



fg_c1d=squeeze(mean(mean(cond1n_dt_bl(roi_circle,48:58,:),1),2))-squeeze(mean(mean(cond1n_dt_bl(roi_bg_in,48:58,:),1),2));
fg_10=squeeze(mean(mean(cond2n_dt_bl(roi_circle,48:58,:),1),2))-squeeze(mean(mean(cond2n_dt_bl(roi_bg_in,48:58,:),1),2));
fg_17=squeeze(mean(mean(cond4n_dt_bl(roi_circle,48:58,:),1),2))-squeeze(mean(mean(cond4n_dt_bl(roi_bg_in,48:58,:),1),2));
fg_c5d=squeeze(mean(mean(cond5n_dt_bl(roi_circle,48:58,:),1),2))-squeeze(mean(mean(cond5n_dt_bl(roi_bg_in,48:58,:),1),2));
[n1 x1]=hist(fg_c1d,-1e-3:1e-4:1e-3);
[n2 x2]=hist(fg_10,-1e-3:1e-4:1e-3);
[n3 x3]=hist(fg_17,-1e-3:1e-4:1e-3);
[n4 x4]=hist(fg_c5d,-1e-3:1e-4:1e-3);
figure;bar(x1,[n1;n2;n3;n4]')
legend('contour','10deg','17deg','non-contour')




%% ROC for fg


%c
scores=[fg_c1c;fg_c5c]';
labels=ones(1,size(scores,2));
labels(size(fg_c1c,1)+1:end)=0;
[X_c1c,Y_c1c,THRE,AUC_c1c,OPTROCPT,SUBY,SUBYNAMES] = perfcurve(labels,scores,1);

scores=[fg_5;fg_c5c]';
labels=ones(1,size(scores,2));
labels(size(fg_5,1)+1:end)=0;
[X_5,Y_5,THRE,AUC_5,OPTROCPT,SUBY,SUBYNAMES] = perfcurve(labels,scores,1);

scores=[fg_20;fg_c5c]';
labels=ones(1,size(scores,2));
labels(size(fg_20,1)+1:end)=0;
[X_20,Y_20,THRE,AUC_20,OPTROCPT,SUBY,SUBYNAMES] = perfcurve(labels,scores,1);


figure;plot(X_c1c,Y_c1c)
hold on
plot(X_5,Y_5,'r')
plot(X_20,Y_20,'g')


%d
scores=[fg_c1d;fg_c5d]';
labels=ones(1,size(scores,2));
labels(size(fg_c1d,1)+1:end)=0;
[X_c1d,Y_c1d,THRE,AUC_c1d,OPTROCPT,SUBY,SUBYNAMES] = perfcurve(labels,scores,1);

scores=[fg_10;fg_c5d]';
labels=ones(1,size(scores,2));
labels(size(fg_10,1)+1:end)=0;
[X_10,Y_10,THRE,AUC_10,OPTROCPT,SUBY,SUBYNAMES] = perfcurve(labels,scores,1);

scores=[fg_17;fg_c5d]';
labels=ones(1,size(scores,2));
labels(size(fg_17,1)+1:end)=0;
[X_17,Y_17,THRE,AUC_17,OPTROCPT,SUBY,SUBYNAMES] = perfcurve(labels,scores,1);


figure;plot(X_c1d,Y_c1d)
hold on
plot(X_10,Y_10,'r')
plot(X_17,Y_17,'g')



AUC_curve(1)=mean([AUC_c1c AUC_c1d]);
AUC_curve(2)=AUC_5;
AUC_curve(3)=AUC_10;
AUC_curve(4)=AUC_17;
AUC_curve(5)=AUC_20;
AUC_curve(6)=0.5;

figure;plot([0 5 10 17 20 45],AUC_curve)



%maybe normalize
AUC_curve_2212(1)=1;
AUC_curve_2212(2)=AUC_5/AUC_c1c;
AUC_curve_2212(3)=AUC_10/AUC_c1d;
AUC_curve_2212(4)=AUC_17/AUC_c1d;
AUC_curve_2212(5)=AUC_20/AUC_c1c;
AUC_curve_2212(6)=0.5;

figure;plot([0 5 10 17 20 45],AUC_curve_2212)

%% d prime


dp_c1c=(mean(fg_c1c)-mean(fg_c5c))/sqrt((std(fg_c1c)^2+std(fg_c5c)^2)/2);
dp_5=(mean(fg_5)-mean(fg_c5c))/sqrt((std(fg_5)^2+std(fg_c5c)^2)/2);
dp_20=(mean(fg_20)-mean(fg_c5c))/sqrt((std(fg_20)^2+std(fg_c5c)^2)/2);

dp_c1d=(mean(fg_c1d)-mean(fg_c5d))/sqrt((std(fg_c1d)^2+std(fg_c5d)^2)/2);
dp_10=(mean(fg_10)-mean(fg_c5d))/sqrt((std(fg_10)^2+std(fg_c5d)^2)/2);
dp_17=(mean(fg_17)-mean(fg_c5d))/sqrt((std(fg_17)^2+std(fg_c5d)^2)/2);


dprime_curve(1)=mean([dp_c1c dp_c1d]);
dprime_curve(2)=dp_5;
dprime_curve(3)=dp_10;
dprime_curve(4)=dp_17;
dprime_curve(5)=dp_20;
dprime_curve(6)=0;

figure;plot([0 5 10 17 20 45],dprime_curve)



%% SMEAGOL

AUC_curve(1)=mean([AUC_curve_2212(1) AUC_curve_0501(1)]);
AUC_curve(2)=mean([AUC_curve_2212(2) AUC_curve_0501(2)]);
AUC_curve(3)=mean([AUC_curve_2212(3) AUC_curve_0501(3)]);
AUC_curve(4)=AUC_curve_0501(4);
AUC_curve(5)=AUC_curve_2212(4);
AUC_curve(6)=mean([AUC_curve_2212(5) AUC_curve_0501(5)]);
AUC_curve(7)=mean([AUC_curve_2212(6) AUC_curve_0501(6)]);

dprime_curve(1)=mean([dprime_curve_2212(1) dprime_curve_0501(1)]);
dprime_curve(2)=mean([dprime_curve_2212(2) dprime_curve_0501(2)]);
dprime_curve(3)=mean([dprime_curve_2212(3) dprime_curve_0501(3)]);
dprime_curve(4)=dprime_curve_0501(4);
dprime_curve(5)=dprime_curve_2212(4);
dprime_curve(6)=mean([dprime_curve_2212(5) dprime_curve_0501(5)]);
dprime_curve(7)=mean([dprime_curve_2212(6) dprime_curve_0501(6)]);


figure;plot([0 5 10 15 17 20 45],AUC_curve)
figure;plot([0 5 10 15 17 20 45],dprime_curve)


[r,m,b] = regression([0 5 10 15 17 20 45],AUC_curve);
xx=0:0.25:45;
figure;plot([0 5 10 15 17 20 45],AUC_curve)
hold on
plot(xx,m*xx+b)










