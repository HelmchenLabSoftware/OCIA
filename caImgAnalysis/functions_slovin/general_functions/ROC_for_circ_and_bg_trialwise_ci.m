%% 1811
%c
circ_c1c=squeeze(mean(mean(cond1n_dt_bl(roi_contour,43:53,:),3),2))-1;
bg_c1c=squeeze(mean(mean(cond1n_dt_bl(roi_bg_in,43:53,:),3),2))-1;
circ_5=squeeze(mean(mean(cond2n_dt_bl(roi_contour,43:53,:),3),2))-1;
bg_5=squeeze(mean(mean(cond2n_dt_bl(roi_bg_in,43:53,:),3),2))-1;
circ_15=squeeze(mean(mean(cond4n_dt_bl(roi_contour,43:53,:),3),2))-1;
bg_15=squeeze(mean(mean(cond4n_dt_bl(roi_bg_in,43:53,:),3),2))-1;
circ_c5c=squeeze(mean(mean(cond5n_dt_bl(roi_contour,43:53,:),3),2))-1;
bg_c5c=squeeze(mean(mean(cond5n_dt_bl(roi_bg_in,43:53,:),3),2))-1;

%d
circ_c1d=squeeze(mean(mean(cond1n_dt_bl(roi_contour,43:53,:),3),2))-1;
bg_c1d=squeeze(mean(mean(cond1n_dt_bl(roi_bg_in,43:53,:),3),2))-1;
circ_10=squeeze(mean(mean(cond2n_dt_bl(roi_contour,43:53,:),3),2))-1;
bg_10=squeeze(mean(mean(cond2n_dt_bl(roi_bg_in,43:53,:),3),2))-1;
circ_20=squeeze(mean(mean(cond4n_dt_bl(roi_contour,43:53,:),3),2))-1;
bg_20=squeeze(mean(mean(cond4n_dt_bl(roi_bg_in,43:53,:),3),2))-1;
circ_c5d=squeeze(mean(mean(cond5n_dt_bl(roi_contour,43:53,:),3),2))-1;
bg_c5d=squeeze(mean(mean(cond5n_dt_bl(roi_bg_in,43:53,:),3),2))-1;

%e
circ_c1e=squeeze(mean(mean(cond1n_dt_bl(roi_contour,43:53,:),3),2))-1;
bg_c1e=squeeze(mean(mean(cond1n_dt_bl(roi_bg_in,43:53,:),3),2))-1;
circ_17=squeeze(mean(mean(cond2n_dt_bl(roi_contour,43:53,:),3),2))-1;
bg_17=squeeze(mean(mean(cond2n_dt_bl(roi_bg_in,43:53,:),3),2))-1;
circ_25=squeeze(mean(mean(cond4n_dt_bl(roi_contour,43:53,:),3),2))-1;
bg_25=squeeze(mean(mean(cond4n_dt_bl(roi_bg_in,43:53,:),3),2))-1;
circ_c5e=squeeze(mean(mean(cond5n_dt_bl(roi_contour,43:53,:),3),2))-1;
bg_c5e=squeeze(mean(mean(cond5n_dt_bl(roi_bg_in,43:53,:),3),2))-1;

%c
[n1 x1]=hist(circ_c1c,0e-3:.5e-4:2e-3);
[n2 x2]=hist(bg_c1c,0e-3:.5e-4:2e-3);
figure;bar(x1,[n1;n2]')
legend('circle','background')

[n1 x1]=hist(circ_5,0e-3:.5e-4:2e-3);
[n2 x2]=hist(bg_5,0e-3:.5e-4:2e-3);
figure;bar(x1,[n1;n2]')
legend('circle','background')

[n1 x1]=hist(circ_15,0e-3:.5e-4:2e-3);
[n2 x2]=hist(bg_15,0e-3:.5e-4:2e-3);
figure;bar(x1,[n1;n2]')
legend('circle','background')

[n1 x1]=hist(circ_c5c,0e-3:.5e-4:2e-3);
[n2 x2]=hist(bg_c5c,0e-3:.5e-4:2e-3);
figure;bar(x1,[n1;n2]')
legend('circle','background')




%d

[n1 x1]=hist(circ_c1d,0e-3:.5e-4:2e-3);
[n2 x2]=hist(bg_c1d,0e-3:.5e-4:2e-3);
figure;bar(x1,[n1;n2]')
legend('circle','background')

[n1 x1]=hist(circ_10,0e-3:.5e-4:2e-3);
[n2 x2]=hist(bg_10,0e-3:.5e-4:2e-3);
figure;bar(x1,[n1;n2]')
legend('circle','background')

[n1 x1]=hist(circ_20,0e-3:.5e-4:2e-3);
[n2 x2]=hist(bg_20,0e-3:.5e-4:2e-3);
figure;bar(x1,[n1;n2]')
legend('circle','background')

[n1 x1]=hist(circ_c5d,0e-3:.5e-4:2e-3);
[n2 x2]=hist(bg_c5d,0e-3:.5e-4:2e-3);
figure;bar(x1,[n1;n2]')
legend('circle','background')


%e

[n1 x1]=hist(circ_c1e,0e-3:.5e-4:2e-3);
[n2 x2]=hist(bg_c1e,0e-3:.5e-4:2e-3);
figure;bar(x1,[n1;n2]')
legend('circle','background')

[n1 x1]=hist(circ_17,0e-3:.5e-4:2e-3);
[n2 x2]=hist(bg_17,0e-3:.5e-4:2e-3);
figure;bar(x1,[n1;n2]')
legend('circle','background')

[n1 x1]=hist(circ_25,0e-3:.5e-4:2e-3);
[n2 x2]=hist(bg_25,0e-3:.5e-4:2e-3);
figure;bar(x1,[n1;n2]')
legend('circle','background')

[n1 x1]=hist(circ_c5e,0e-3:.5e-4:2e-3);
[n2 x2]=hist(bg_c5e,0e-3:.5e-4:2e-3);
figure;bar(x1,[n1;n2]')
legend('circle','background')



%AUC
scores=[circ_c1c;bg_c1c]';
labels=ones(1,size(scores,2));
labels(size(circ_c1c,1)+1:end)=0;
[X_c1c,Y_c1c,THRE,AUC_c1c,OPTROCPT,SUBY,SUBYNAMES] = perfcurve(labels,scores,1);

scores=[circ_5;bg_5]';
labels=ones(1,size(scores,2));
labels(size(circ_5,1)+1:end)=0;
[X_5,Y_5,THRE,AUC_5,OPTROCPT,SUBY,SUBYNAMES] = perfcurve(labels,scores,1);

scores=[circ_15;bg_15]';
labels=ones(1,size(scores,2));
labels(size(circ_15,1)+1:end)=0;
[X_15,Y_15,THRE,AUC_15,OPTROCPT,SUBY,SUBYNAMES] = perfcurve(labels,scores,1);

scores=[circ_c5c;bg_c5c]';
labels=ones(1,size(scores,2));
labels(size(circ_c5c,1)+1:end)=0;
[X_c5c,Y_c5c,THRE,AUC_c5c,OPTROCPT,SUBY,SUBYNAMES] = perfcurve(labels,scores,1);

scores=[circ_c1d;bg_c1d]';
labels=ones(1,size(scores,2));
labels(size(circ_c1d,1)+1:end)=0;
[X_c1d,Y_c1d,THRE,AUC_c1d,OPTROCPT,SUBY,SUBYNAMES] = perfcurve(labels,scores,1);

scores=[circ_10;bg_10]';
labels=ones(1,size(scores,2));
labels(size(circ_10,1)+1:end)=0;
[X_10,Y_10,THRE,AUC_10,OPTROCPT,SUBY,SUBYNAMES] = perfcurve(labels,scores,1);

scores=[circ_20;bg_20]';
labels=ones(1,size(scores,2));
labels(size(circ_20,1)+1:end)=0;
[X_20,Y_20,THRE,AUC_20,OPTROCPT,SUBY,SUBYNAMES] = perfcurve(labels,scores,1);

scores=[circ_c5d;bg_c5d]';
labels=ones(1,size(scores,2));
labels(size(circ_c5d,1)+1:end)=0;
[X_c5d,Y_c5d,THRE,AUC_c5d,OPTROCPT,SUBY,SUBYNAMES] = perfcurve(labels,scores,1);


scores=[circ_c1e;bg_c1e]';
labels=ones(1,size(scores,2));
labels(size(circ_c1e,1)+1:end)=0;
[X_c1e,Y_c1e,THRE,AUC_c1e,OPTROCPT,SUBY,SUBYNAMES] = perfcurve(labels,scores,1);

scores=[circ_17;bg_17]';
labels=ones(1,size(scores,2));
labels(size(circ_17,1)+1:end)=0;
[X_17,Y_17,THRE,AUC_17,OPTROCPT,SUBY,SUBYNAMES] = perfcurve(labels,scores,1);

scores=[circ_25;bg_25]';
labels=ones(1,size(scores,2));
labels(size(circ_25,1)+1:end)=0;
[X_25,Y_25,THRE,AUC_25,OPTROCPT,SUBY,SUBYNAMES] = perfcurve(labels,scores,1);

scores=[circ_c5e;bg_c5e]';
labels=ones(1,size(scores,2));
labels(size(circ_c5e,1)+1:end)=0;
[X_c5e,Y_c5e,THRE,AUC_c5e,OPTROCPT,SUBY,SUBYNAMES] = perfcurve(labels,scores,1);


figure;plot(X_c1c,Y_c1c)
hold on
plot(X_5,Y_5,'c')
plot(X_15,Y_15,'g')
plot(X_c5c,Y_c5c,'r')
legend('contour','5deg','15deg','non-contour')


figure;plot(X_c1d,Y_c1d)
hold on
plot(X_10,Y_10,'c')
plot(X_20,Y_20,'g')
plot(X_c5d,Y_c5d,'r')
legend('contour','10deg','20deg','non-contour')


figure;plot(X_c1e,Y_c1e)
hold on
plot(X_17,Y_17,'c')
plot(X_25,Y_25,'g')
plot(X_c5e,Y_c5e,'r')
legend('contour','17deg','25deg','non-contour')



figure;plot(mean([X_c1c X_c1d X_c1e],2),mean([Y_c1c Y_c1d Y_c1e],2),'k')
hold on
plot(X_5,Y_5,'b')
plot(X_10,Y_10,'--')
plot(X_15,Y_15,'c')
plot(X_17,Y_17,'g')
plot(X_20,Y_20,'y')
plot(X_25,Y_25,'m')
plot(mean([X_c5c X_c5d X_c5e],2),mean([Y_c5c Y_c5d Y_c5e],2),'r')
legend('contour','5deg','10deg','15deg','17deg','20deg','25deg','non-contour')


AUC_curve(1)=mean([AUC_c1c AUC_c1d AUC_c1e]);
AUC_curve(2)=AUC_5;
AUC_curve(3)=AUC_10;
AUC_curve(4)=AUC_15;
AUC_curve(5)=AUC_17;
AUC_curve(6)=AUC_20;
AUC_curve(7)=AUC_25;
AUC_curve(8)=mean([AUC_c5c AUC_c5d AUC_c5e]);

figure;plot([0 5 10 15 17 20 25 45],AUC_curve)



%% 2511
%d
circ_c1d=squeeze(mean(mean(cond1n_dt_bl(roi_contour,53:58,:),3),2))-1;
bg_c1d=squeeze(mean(mean(cond1n_dt_bl(roi_bg_in,53:58,:),3),2))-1;
circ_10=squeeze(mean(mean(cond2n_dt_bl(roi_contour,53:58,:),3),2))-1;
bg_10=squeeze(mean(mean(cond2n_dt_bl(roi_bg_in,53:58,:),3),2))-1;
circ_15=squeeze(mean(mean(cond4n_dt_bl(roi_contour,53:58,:),3),2))-1;
bg_15=squeeze(mean(mean(cond4n_dt_bl(roi_bg_in,53:58,:),3),2))-1;
circ_c5d=squeeze(mean(mean(cond5n_dt_bl(roi_contour,53:58,:),3),2))-1;
bg_c5d=squeeze(mean(mean(cond5n_dt_bl(roi_bg_in,53:58,:),3),2))-1;

circ_c1e=squeeze(mean(mean(cond1n_dt_bl(roi_contour,53:58,:),3),2))-1;
bg_c1e=squeeze(mean(mean(cond1n_dt_bl(roi_bg_in,53:58,:),3),2))-1;
circ_17=squeeze(mean(mean(cond2n_dt_bl(roi_contour,53:58,:),3),2))-1;
bg_17=squeeze(mean(mean(cond2n_dt_bl(roi_bg_in,53:58,:),3),2))-1;
circ_20=squeeze(mean(mean(cond4n_dt_bl(roi_contour,53:58,:),3),2))-1;
bg_20=squeeze(mean(mean(cond4n_dt_bl(roi_bg_in,53:58,:),3),2))-1;
circ_c5e=squeeze(mean(mean(cond5n_dt_bl(roi_contour,53:58,:),3),2))-1;
bg_c5e=squeeze(mean(mean(cond5n_dt_bl(roi_bg_in,53:58,:),3),2))-1;


circ_c1f=squeeze(mean(mean(cond1n_dt_bl(roi_contour,53:58,:),3),2))-1;
bg_c1f=squeeze(mean(mean(cond1n_dt_bl(roi_bg_in,53:58,:),3),2))-1;
circ_5=squeeze(mean(mean(cond2n_dt_bl(roi_contour,53:58,:),3),2))-1;
bg_5=squeeze(mean(mean(cond2n_dt_bl(roi_bg_in,53:58,:),3),2))-1;
circ_25=squeeze(mean(mean(cond4n_dt_bl(roi_contour,53:58,:),3),2))-1;
bg_25=squeeze(mean(mean(cond4n_dt_bl(roi_bg_in,53:58,:),3),2))-1;
circ_c5f=squeeze(mean(mean(cond5n_dt_bl(roi_contour,53:58,:),3),2))-1;
bg_c5f=squeeze(mean(mean(cond5n_dt_bl(roi_bg_in,53:58,:),3),2))-1;

%d
[n1 x1]=hist(circ_c1d,0e-3:.5e-4:2e-3);
[n2 x2]=hist(bg_c1d,0e-3:.5e-4:2e-3);
figure;bar(x1,[n1;n2]')
legend('circle','background')

[n1 x1]=hist(circ_10,0e-3:.5e-4:2e-3);
[n2 x2]=hist(bg_10,0e-3:.5e-4:2e-3);
figure;bar(x1,[n1;n2]')
legend('circle','background')

[n1 x1]=hist(circ_15,0e-3:.5e-4:2e-3);
[n2 x2]=hist(bg_15,0e-3:.5e-4:2e-3);
figure;bar(x1,[n1;n2]')
legend('circle','background')

[n1 x1]=hist(circ_c5d,0e-3:.5e-4:2e-3);
[n2 x2]=hist(bg_c5d,0e-3:.5e-4:2e-3);
figure;bar(x1,[n1;n2]')
legend('circle','background')



%e

[n1 x1]=hist(circ_c1e,0e-3:.5e-4:2e-3);
[n2 x2]=hist(bg_c1e,0e-3:.5e-4:2e-3);
figure;bar(x1,[n1;n2]')
legend('circle','background')

[n1 x1]=hist(circ_17,0e-3:.5e-4:2e-3);
[n2 x2]=hist(bg_17,0e-3:.5e-4:2e-3);
figure;bar(x1,[n1;n2]')
legend('circle','background')

[n1 x1]=hist(circ_20,0e-3:.5e-4:2e-3);
[n2 x2]=hist(bg_20,0e-3:.5e-4:2e-3);
figure;bar(x1,[n1;n2]')
legend('circle','background')

[n1 x1]=hist(circ_c5e,0e-3:.5e-4:2e-3);
[n2 x2]=hist(bg_c5e,0e-3:.5e-4:2e-3);
figure;bar(x1,[n1;n2]')
legend('circle','background')




%f

[n1 x1]=hist(circ_c1f,0e-3:.5e-4:2e-3);
[n2 x2]=hist(bg_c1f,0e-3:.5e-4:2e-3);
figure;bar(x1,[n1;n2]')
legend('circle','background')

[n1 x1]=hist(circ_5,0e-3:.5e-4:2e-3);
[n2 x2]=hist(bg_5,0e-3:.5e-4:2e-3);
figure;bar(x1,[n1;n2]')
legend('circle','background')

[n1 x1]=hist(circ_25,0e-3:.5e-4:2e-3);
[n2 x2]=hist(bg_25,0e-3:.5e-4:2e-3);
figure;bar(x1,[n1;n2]')
legend('circle','background')

[n1 x1]=hist(circ_c5f,0e-3:.5e-4:2e-3);
[n2 x2]=hist(bg_c5f,0e-3:.5e-4:2e-3);
figure;bar(x1,[n1;n2]')
legend('circle','background')




%AUC
scores=[circ_c1f;bg_c1f]';
labels=ones(1,size(scores,2));
labels(size(circ_c1f,1)+1:end)=0;
[X_c1f,Y_c1f,THRE,AUC_c1f,OPTROCPT,SUBY,SUBYNAMES] = perfcurve(labels,scores,1);

scores=[circ_5;bg_5]';
labels=ones(1,size(scores,2));
labels(size(circ_5,1)+1:end)=0;
[X_5,Y_5,THRE,AUC_5,OPTROCPT,SUBY,SUBYNAMES] = perfcurve(labels,scores,1);

scores=[circ_15;bg_15]';
labels=ones(1,size(scores,2));
labels(size(circ_15,1)+1:end)=0;
[X_15,Y_15,THRE,AUC_15,OPTROCPT,SUBY,SUBYNAMES] = perfcurve(labels,scores,1);

scores=[circ_c5f;bg_c5f]';
labels=ones(1,size(scores,2));
labels(size(circ_c5f,1)+1:end)=0;
[X_c5f,Y_c5f,THRE,AUC_c5f,OPTROCPT,SUBY,SUBYNAMES] = perfcurve(labels,scores,1);

scores=[circ_c1d;bg_c1d]';
labels=ones(1,size(scores,2));
labels(size(circ_c1d,1)+1:end)=0;
[X_c1d,Y_c1d,THRE,AUC_c1d,OPTROCPT,SUBY,SUBYNAMES] = perfcurve(labels,scores,1);

scores=[circ_10;bg_10]';
labels=ones(1,size(scores,2));
labels(size(circ_10,1)+1:end)=0;
[X_10,Y_10,THRE,AUC_10,OPTROCPT,SUBY,SUBYNAMES] = perfcurve(labels,scores,1);

scores=[circ_20;bg_20]';
labels=ones(1,size(scores,2));
labels(size(circ_20,1)+1:end)=0;
[X_20,Y_20,THRE,AUC_20,OPTROCPT,SUBY,SUBYNAMES] = perfcurve(labels,scores,1);

scores=[circ_c5d;bg_c5d]';
labels=ones(1,size(scores,2));
labels(size(circ_c5d,1)+1:end)=0;
[X_c5d,Y_c5d,THRE,AUC_c5d,OPTROCPT,SUBY,SUBYNAMES] = perfcurve(labels,scores,1);


scores=[circ_c1e;bg_c1e]';
labels=ones(1,size(scores,2));
labels(size(circ_c1e,1)+1:end)=0;
[X_c1e,Y_c1e,THRE,AUC_c1e,OPTROCPT,SUBY,SUBYNAMES] = perfcurve(labels,scores,1);

scores=[circ_17;bg_17]';
labels=ones(1,size(scores,2));
labels(size(circ_17,1)+1:end)=0;
[X_17,Y_17,THRE,AUC_17,OPTROCPT,SUBY,SUBYNAMES] = perfcurve(labels,scores,1);

scores=[circ_25;bg_25]';
labels=ones(1,size(scores,2));
labels(size(circ_25,1)+1:end)=0;
[X_25,Y_25,THRE,AUC_25,OPTROCPT,SUBY,SUBYNAMES] = perfcurve(labels,scores,1);

scores=[circ_c5e;bg_c5e]';
labels=ones(1,size(scores,2));
labels(size(circ_c5e,1)+1:end)=0;
[X_c5e,Y_c5e,THRE,AUC_c5e,OPTROCPT,SUBY,SUBYNAMES] = perfcurve(labels,scores,1);




figure;plot(X_c1d,Y_c1d)
hold on
plot(X_10,Y_10,'c')
plot(X_15,Y_15,'g')
plot(X_c5d,Y_c5d,'r')
legend('contour','10deg','15deg','non-contour')

figure;plot(X_c1e,Y_c1e)
hold on
plot(X_17,Y_17,'c')
plot(X_20,Y_20,'g')
plot(X_c5e,Y_c5e,'r')
legend('contour','17deg','20deg','non-contour')

figure;plot(X_c1f,Y_c1f)
hold on
plot(X_5,Y_5,'c')
plot(X_25,Y_25,'g')
plot(X_c5f,Y_c5f,'r')
legend('contour','5deg','25deg','non-contour')


figure;plot(mean([X_c1d X_c1e X_c1f],2),mean([Y_c1d Y_c1e Y_c1f],2),'k')
hold on
plot(X_5,Y_5,'b')
plot(X_10,Y_10,'--')
plot(X_15,Y_15,'c')
plot(X_17,Y_17,'g')
plot(X_20,Y_20,'y')
plot(X_25,Y_25,'m')
plot(mean([X_c5d X_c5e X_c5f],2),mean([Y_c5d Y_c5e Y_c5f],2),'r')
legend('contour','5deg','10deg','15deg','17deg','20deg','25deg','non-contour')


AUC_curve(1)=mean([AUC_c1f AUC_c1d AUC_c1e]);
AUC_curve(2)=AUC_5;
AUC_curve(3)=AUC_10;
AUC_curve(4)=AUC_15;
AUC_curve(5)=AUC_17;
AUC_curve(6)=AUC_20;
AUC_curve(7)=AUC_25;
AUC_curve(8)=mean([AUC_c5f AUC_c5d AUC_c5e]);

figure;plot([0 5 10 15 17 20 25 45],AUC_curve)



%% 1203
%d
circ_c1d=squeeze(mean(mean(cond1n_dt_bl(roi_contour,43:53,:),3),2))-1;
bg_c1d=squeeze(mean(mean(cond1n_dt_bl(roi_bg_in,43:53,:),3),2))-1;
circ_15=squeeze(mean(mean(cond2n_dt_bl(roi_contour,43:53,:),3),2))-1;
bg_15=squeeze(mean(mean(cond2n_dt_bl(roi_bg_in,43:53,:),3),2))-1;
circ_20=squeeze(mean(mean(cond4n_dt_bl(roi_contour,43:53,:),3),2))-1;
bg_20=squeeze(mean(mean(cond4n_dt_bl(roi_bg_in,43:53,:),3),2))-1;
circ_c5d=squeeze(mean(mean(cond5n_dt_bl(roi_contour,43:53,:),3),2))-1;
bg_c5d=squeeze(mean(mean(cond5n_dt_bl(roi_bg_in,43:53,:),3),2))-1;
%e
circ_c1e=squeeze(mean(mean(cond1n_dt_bl(roi_contour,43:53,:),3),2))-1;
bg_c1e=squeeze(mean(mean(cond1n_dt_bl(roi_bg_in,43:53,:),3),2))-1;
circ_5=squeeze(mean(mean(cond2n_dt_bl(roi_contour,43:53,:),3),2))-1;
bg_5=squeeze(mean(mean(cond2n_dt_bl(roi_bg_in,43:53,:),3),2))-1;
circ_10=squeeze(mean(mean(cond4n_dt_bl(roi_contour,43:53,:),3),2))-1;
bg_10=squeeze(mean(mean(cond4n_dt_bl(roi_bg_in,43:53,:),3),2))-1;
circ_c5e=squeeze(mean(mean(cond5n_dt_bl(roi_contour,43:53,:),3),2))-1;
bg_c5e=squeeze(mean(mean(cond5n_dt_bl(roi_bg_in,43:53,:),3),2))-1;
%f
circ_c1f=squeeze(mean(mean(cond1n_dt_bl(roi_contour,43:53,:),3),2))-1;
bg_c1f=squeeze(mean(mean(cond1n_dt_bl(roi_bg_in,43:53,:),3),2))-1;
circ_25=squeeze(mean(mean(cond2n_dt_bl(roi_contour,43:53,:),3),2))-1;
bg_25=squeeze(mean(mean(cond2n_dt_bl(roi_bg_in,43:53,:),3),2))-1;
circ_30=squeeze(mean(mean(cond4n_dt_bl(roi_contour,43:53,:),3),2))-1;
bg_30=squeeze(mean(mean(cond4n_dt_bl(roi_bg_in,43:53,:),3),2))-1;
circ_c5f=squeeze(mean(mean(cond5n_dt_bl(roi_contour,43:53,:),3),2))-1;
bg_c5f=squeeze(mean(mean(cond5n_dt_bl(roi_bg_in,43:53,:),3),2))-1;



%d
[n1 x1]=hist(circ_c1d,0e-3:.5e-4:2e-3);
[n2 x2]=hist(bg_c1d,0e-3:.5e-4:2e-3);
figure;bar(x1,[n1;n2]')
legend('circle','background')

[n1 x1]=hist(circ_15,0e-3:.5e-4:2e-3);
[n2 x2]=hist(bg_15,0e-3:.5e-4:2e-3);
figure;bar(x1,[n1;n2]')
legend('circle','background')

[n1 x1]=hist(circ_20,0e-3:.5e-4:2e-3);
[n2 x2]=hist(bg_20,0e-3:.5e-4:2e-3);
figure;bar(x1,[n1;n2]')
legend('circle','background')

[n1 x1]=hist(circ_c5d,0e-3:.5e-4:2e-3);
[n2 x2]=hist(bg_c5d,0e-3:.5e-4:2e-3);
figure;bar(x1,[n1;n2]')
legend('circle','background')


%e
[n1 x1]=hist(circ_c1e,0e-3:.5e-4:2e-3);
[n2 x2]=hist(bg_c1e,0e-3:.5e-4:2e-3);
figure;bar(x1,[n1;n2]')
legend('circle','background')

[n1 x1]=hist(circ_5,0e-3:.5e-4:2e-3);
[n2 x2]=hist(bg_5,0e-3:.5e-4:2e-3);
figure;bar(x1,[n1;n2]')
legend('circle','background')

[n1 x1]=hist(circ_10,0e-3:.5e-4:2e-3);
[n2 x2]=hist(bg_10,0e-3:.5e-4:2e-3);
figure;bar(x1,[n1;n2]')
legend('circle','background')

[n1 x1]=hist(circ_c5e,0e-3:.5e-4:2e-3);
[n2 x2]=hist(bg_c5e,0e-3:.5e-4:2e-3);
figure;bar(x1,[n1;n2]')
legend('circle','background')



%f
[n1 x1]=hist(circ_c1f,0e-3:.5e-4:2e-3);
[n2 x2]=hist(bg_c1f,0e-3:.5e-4:2e-3);
figure;bar(x1,[n1;n2]')
legend('circle','background')

[n1 x1]=hist(circ_25,0e-3:.5e-4:2e-3);
[n2 x2]=hist(bg_25,0e-3:.5e-4:2e-3);
figure;bar(x1,[n1;n2]')
legend('circle','background')

[n1 x1]=hist(circ_30,0e-3:.5e-4:2e-3);
[n2 x2]=hist(bg_30,0e-3:.5e-4:2e-3);
figure;bar(x1,[n1;n2]')
legend('circle','background')

[n1 x1]=hist(circ_c5f,0e-3:.5e-4:2e-3);
[n2 x2]=hist(bg_c5f,0e-3:.5e-4:2e-3);
figure;bar(x1,[n1;n2]')
legend('circle','background')



%AUC
scores=[circ_c1f;bg_c1f]';
labels=ones(1,size(scores,2));
labels(size(circ_c1f,1)+1:end)=0;
[X_c1f,Y_c1f,THRE,AUC_c1f,OPTROCPT,SUBY,SUBYNAMES] = perfcurve(labels,scores,1);

scores=[circ_5;bg_5]';
labels=ones(1,size(scores,2));
labels(size(circ_5,1)+1:end)=0;
[X_5,Y_5,THRE,AUC_5,OPTROCPT,SUBY,SUBYNAMES] = perfcurve(labels,scores,1);

scores=[circ_15;bg_15]';
labels=ones(1,size(scores,2));
labels(size(circ_15,1)+1:end)=0;
[X_15,Y_15,THRE,AUC_15,OPTROCPT,SUBY,SUBYNAMES] = perfcurve(labels,scores,1);

scores=[circ_c5f;bg_c5f]';
labels=ones(1,size(scores,2));
labels(size(circ_c5f,1)+1:end)=0;
[X_c5f,Y_c5f,THRE,AUC_c5f,OPTROCPT,SUBY,SUBYNAMES] = perfcurve(labels,scores,1);

scores=[circ_c1d;bg_c1d]';
labels=ones(1,size(scores,2));
labels(size(circ_c1d,1)+1:end)=0;
[X_c1d,Y_c1d,THRE,AUC_c1d,OPTROCPT,SUBY,SUBYNAMES] = perfcurve(labels,scores,1);

scores=[circ_10;bg_10]';
labels=ones(1,size(scores,2));
labels(size(circ_10,1)+1:end)=0;
[X_10,Y_10,THRE,AUC_10,OPTROCPT,SUBY,SUBYNAMES] = perfcurve(labels,scores,1);

scores=[circ_20;bg_20]';
labels=ones(1,size(scores,2));
labels(size(circ_20,1)+1:end)=0;
[X_20,Y_20,THRE,AUC_20,OPTROCPT,SUBY,SUBYNAMES] = perfcurve(labels,scores,1);

scores=[circ_c5d;bg_c5d]';
labels=ones(1,size(scores,2));
labels(size(circ_c5d,1)+1:end)=0;
[X_c5d,Y_c5d,THRE,AUC_c5d,OPTROCPT,SUBY,SUBYNAMES] = perfcurve(labels,scores,1);


scores=[circ_c1e;bg_c1e]';
labels=ones(1,size(scores,2));
labels(size(circ_c1e,1)+1:end)=0;
[X_c1e,Y_c1e,THRE,AUC_c1e,OPTROCPT,SUBY,SUBYNAMES] = perfcurve(labels,scores,1);

scores=[circ_30;bg_30]';
labels=ones(1,size(scores,2));
labels(size(circ_30,1)+1:end)=0;
[X_30,Y_30,THRE,AUC_30,OPTROCPT,SUBY,SUBYNAMES] = perfcurve(labels,scores,1);

scores=[circ_25;bg_25]';
labels=ones(1,size(scores,2));
labels(size(circ_25,1)+1:end)=0;
[X_25,Y_25,THRE,AUC_25,OPTROCPT,SUBY,SUBYNAMES] = perfcurve(labels,scores,1);

scores=[circ_c5e;bg_c5e]';
labels=ones(1,size(scores,2));
labels(size(circ_c5e,1)+1:end)=0;
[X_c5e,Y_c5e,THRE,AUC_c5e,OPTROCPT,SUBY,SUBYNAMES] = perfcurve(labels,scores,1);




figure;plot(X_c1d,Y_c1d)
hold on
plot(X_15,Y_15,'c')
plot(X_20,Y_20,'g')
plot(X_c5d,Y_c5d,'r')
legend('contour','15deg','20deg','non-contour')

figure;plot(X_c1e,Y_c1e)
hold on
plot(X_5,Y_5,'c')
plot(X_10,Y_10,'g')
plot(X_c5e,Y_c5e,'r')
legend('contour','5deg','10deg','non-contour')

figure;plot(X_c1f,Y_c1f)
hold on
plot(X_25,Y_25,'c')
plot(X_30,Y_30,'g')
plot(X_c5f,Y_c5f,'r')
legend('contour','25deg','30deg','non-contour')


figure;plot(mean([X_c1d X_c1e X_c1f],2),mean([Y_c1d Y_c1e Y_c1f],2),'k')
hold on
plot(X_5,Y_5,'b')
plot(X_10,Y_10,'--')
plot(X_15,Y_15,'c')
plot(X_20,Y_20,'g')
plot(X_25,Y_25,'y')
plot(X_30,Y_30,'m')
plot(mean([X_c5d X_c5e X_c5f],2),mean([Y_c5d Y_c5e Y_c5f],2),'r')
legend('contour','5deg','10deg','15deg','20deg','25deg','30deg','non-contour')


AUC_curve(1)=mean([AUC_c1f AUC_c1d AUC_c1e]);
AUC_curve(2)=AUC_5;
AUC_curve(3)=AUC_10;
AUC_curve(4)=AUC_15;
AUC_curve(5)=AUC_20;
AUC_curve(6)=AUC_25;
AUC_curve(7)=AUC_30;
AUC_curve(8)=mean([AUC_c5f AUC_c5d AUC_c5e]);

figure;plot([0 5 10 15 20 25 30 45],AUC_curve)




%% LEGOLAS TOTAL


AUC_curve(1)=mean([AUC_curve_1811(1) AUC_curve_2511(1) AUC_curve_1203(1)]);
AUC_curve(2)=mean([AUC_curve_1811(2) AUC_curve_2511(2) AUC_curve_1203(2)]);
AUC_curve(3)=mean([AUC_curve_1811(3) AUC_curve_2511(3) AUC_curve_1203(3)]);
AUC_curve(4)=mean([AUC_curve_1811(4) AUC_curve_2511(4) AUC_curve_1203(4)]);
AUC_curve(5)=mean([AUC_curve_1811(5) AUC_curve_2511(5)]);
AUC_curve(6)=mean([AUC_curve_1811(6) AUC_curve_2511(6) AUC_curve_1203(5)]);
AUC_curve(7)=mean([AUC_curve_1811(7) AUC_curve_2511(7) AUC_curve_1203(6)]);
AUC_curve(8)=AUC_curve_1203(7);
AUC_curve(9)=mean([AUC_curve_1811(8) AUC_curve_2511(8) AUC_curve_1203(8)]);


[r,m,b] = regression([0 5 10 15 17 20 25 30 45],AUC_curve);
xx=0:0.25:45;
figure;plot([0 5 10 15 17 20 25 30 45],AUC_curve)
hold on
plot(xx,m*xx+b)





%% 0501
%c
circ_c1c=squeeze(mean(mean(cond1n_dt_bl(roi_circle,48:58,:),3),2))-1;
bg_c1c=squeeze(mean(mean(cond1n_dt_bl(roi_bg_out,48:58,:),3),2))-1;
circ_10=squeeze(mean(mean(cond2n_dt_bl(roi_circle,48:58,:),3),2))-1;
bg_10=squeeze(mean(mean(cond2n_dt_bl(roi_bg_out,48:58,:),3),2))-1;
circ_20=squeeze(mean(mean(cond4n_dt_bl(roi_circle,48:58,:),3),2))-1;
bg_20=squeeze(mean(mean(cond4n_dt_bl(roi_bg_out,48:58,:),3),2))-1;
circ_c5c=squeeze(mean(mean(cond5n_dt_bl(roi_circle,48:58,:),3),2))-1;
bg_c5c=squeeze(mean(mean(cond5n_dt_bl(roi_bg_out,48:58,:),3),2))-1;

%d
circ_c1d=squeeze(mean(mean(cond1n_dt_bl(roi_circle,48:58,:),3),2))-1;
bg_c1d=squeeze(mean(mean(cond1n_dt_bl(roi_bg_out,48:58,:),3),2))-1;
circ_5=squeeze(mean(mean(cond2n_dt_bl(roi_circle,48:58,:),3),2))-1;
bg_5=squeeze(mean(mean(cond2n_dt_bl(roi_bg_out,48:58,:),3),2))-1;
circ_15=squeeze(mean(mean(cond4n_dt_bl(roi_circle,48:58,:),3),2))-1;
bg_15=squeeze(mean(mean(cond4n_dt_bl(roi_bg_out,48:58,:),3),2))-1;
circ_c5d=squeeze(mean(mean(cond5n_dt_bl(roi_circle,48:58,:),3),2))-1;
bg_c5d=squeeze(mean(mean(cond5n_dt_bl(roi_bg_out,48:58,:),3),2))-1;


%c
[n1 x1]=hist(circ_c1c,0e-3:.5e-4:2e-3);
[n2 x2]=hist(bg_c1c,0e-3:.5e-4:2e-3);
figure;bar(x1,[n1;n2]')
legend('circle','background')

[n1 x1]=hist(circ_10,0e-3:.5e-4:2e-3);
[n2 x2]=hist(bg_10,0e-3:.5e-4:2e-3);
figure;bar(x1,[n1;n2]')
legend('circle','background')

[n1 x1]=hist(circ_20,0e-3:.5e-4:2e-3);
[n2 x2]=hist(bg_20,0e-3:.5e-4:2e-3);
figure;bar(x1,[n1;n2]')
legend('circle','background')

[n1 x1]=hist(circ_c5c,0e-3:.5e-4:2e-3);
[n2 x2]=hist(bg_c5c,0e-3:.5e-4:2e-3);
figure;bar(x1,[n1;n2]')
legend('circle','background')



%d
[n1 x1]=hist(circ_c1d,0e-3:.5e-4:2e-3);
[n2 x2]=hist(bg_c1d,0e-3:.5e-4:2e-3);
figure;bar(x1,[n1;n2]')
legend('circle','background')

[n1 x1]=hist(circ_5,0e-3:.5e-4:2e-3);
[n2 x2]=hist(bg_5,0e-3:.5e-4:2e-3);
figure;bar(x1,[n1;n2]')
legend('circle','background')

[n1 x1]=hist(circ_15,0e-3:.5e-4:2e-3);
[n2 x2]=hist(bg_15,0e-3:.5e-4:2e-3);
figure;bar(x1,[n1;n2]')
legend('circle','background')

[n1 x1]=hist(circ_c5d,0e-3:.5e-4:2e-3);
[n2 x2]=hist(bg_c5d,0e-3:.5e-4:2e-3);
figure;bar(x1,[n1;n2]')
legend('circle','background')




%AUC

scores=[circ_5;bg_5]';
labels=ones(1,size(scores,2));
labels(size(circ_5,1)+1:end)=0;
[X_5,Y_5,THRE,AUC_5,OPTROCPT,SUBY,SUBYNAMES] = perfcurve(labels,scores,1);

scores=[circ_15;bg_15]';
labels=ones(1,size(scores,2));
labels(size(circ_15,1)+1:end)=0;
[X_15,Y_15,THRE,AUC_15,OPTROCPT,SUBY,SUBYNAMES] = perfcurve(labels,scores,1);


scores=[circ_c1d;bg_c1d]';
labels=ones(1,size(scores,2));
labels(size(circ_c1d,1)+1:end)=0;
[X_c1d,Y_c1d,THRE,AUC_c1d,OPTROCPT,SUBY,SUBYNAMES] = perfcurve(labels,scores,1);

scores=[circ_10;bg_10]';
labels=ones(1,size(scores,2));
labels(size(circ_10,1)+1:end)=0;
[X_10,Y_10,THRE,AUC_10,OPTROCPT,SUBY,SUBYNAMES] = perfcurve(labels,scores,1);

scores=[circ_20;bg_20]';
labels=ones(1,size(scores,2));
labels(size(circ_20,1)+1:end)=0;
[X_20,Y_20,THRE,AUC_20,OPTROCPT,SUBY,SUBYNAMES] = perfcurve(labels,scores,1);

scores=[circ_c5d;bg_c5d]';
labels=ones(1,size(scores,2));
labels(size(circ_c5d,1)+1:end)=0;
[X_c5d,Y_c5d,THRE,AUC_c5d,OPTROCPT,SUBY,SUBYNAMES] = perfcurve(labels,scores,1);


scores=[circ_c1c;bg_c1c]';
labels=ones(1,size(scores,2));
labels(size(circ_c1c,1)+1:end)=0;
[X_c1c,Y_c1c,THRE,AUC_c1c,OPTROCPT,SUBY,SUBYNAMES] = perfcurve(labels,scores,1);


scores=[circ_c5c;bg_c5c]';
labels=ones(1,size(scores,2));
labels(size(circ_c5c,1)+1:end)=0;
[X_c5c,Y_c5c,THRE,AUC_c5c,OPTROCPT,SUBY,SUBYNAMES] = perfcurve(labels,scores,1);




figure;plot(X_c1c,Y_c1c)
hold on
plot(X_10,Y_10,'c')
plot(X_20,Y_20,'g')
plot(X_c5c,Y_c5c,'r')
legend('contour','10deg','20deg','non-contour')

figure;plot(X_c1d,Y_c1d)
hold on
plot(X_5,Y_5,'c')
plot(X_15,Y_15,'g')
plot(X_c5d,Y_c5d,'r')
legend('contour','5deg','15deg','non-contour')


figure;plot(mean([X_c1c X_c1d],2),mean([Y_c1c Y_c1d],2),'k')
hold on
plot(X_5,Y_5,'b')
plot(X_10,Y_10,'--')
plot(X_15,Y_15,'c')
plot(X_20,Y_20,'g')
plot(mean([X_c5c X_c5d],2),mean([Y_c5c Y_c5d],2),'r')
legend('contour','5deg','10deg','15deg','20deg','non-contour')


AUC_curve(1)=mean([AUC_c1c AUC_c1d]);
AUC_curve(2)=AUC_5;
AUC_curve(3)=AUC_10;
AUC_curve(4)=AUC_15;
AUC_curve(5)=AUC_20;
AUC_curve(6)=mean([AUC_c5c AUC_c5d]);

figure;plot([0 5 10 15 20 45],AUC_curve)





%% 2212
%c
circ_c1c=squeeze(mean(mean(cond1n_dt_bl(roi_circle,48:58,:),3),2))-1;
bg_c1c=squeeze(mean(mean(cond1n_dt_bl(roi_bg_in,48:58,:),3),2))-1;
circ_5=squeeze(mean(mean(cond2n_dt_bl(roi_circle,48:58,:),3),2))-1;
bg_5=squeeze(mean(mean(cond2n_dt_bl(roi_bg_in,48:58,:),3),2))-1;
circ_20=squeeze(mean(mean(cond4n_dt_bl(roi_circle,48:58,:),3),2))-1;
bg_20=squeeze(mean(mean(cond4n_dt_bl(roi_bg_in,48:58,:),3),2))-1;
circ_c5c=squeeze(mean(mean(cond5n_dt_bl(roi_circle,48:58,:),3),2))-1;
bg_c5c=squeeze(mean(mean(cond5n_dt_bl(roi_bg_in,48:58,:),3),2))-1;


%d
circ_c1d=squeeze(mean(mean(cond1n_dt_bl(roi_circle,48:58,:),3),2))-1;
bg_c1d=squeeze(mean(mean(cond1n_dt_bl(roi_bg_in,48:58,:),3),2))-1;
circ_10=squeeze(mean(mean(cond2n_dt_bl(roi_circle,48:58,:),3),2))-1;
bg_10=squeeze(mean(mean(cond2n_dt_bl(roi_bg_in,48:58,:),3),2))-1;
circ_17=squeeze(mean(mean(cond4n_dt_bl(roi_circle,48:58,:),3),2))-1;
bg_17=squeeze(mean(mean(cond4n_dt_bl(roi_bg_in,48:58,:),3),2))-1;
circ_c5d=squeeze(mean(mean(cond5n_dt_bl(roi_circle,48:58,:),3),2))-1;
bg_c5d=squeeze(mean(mean(cond5n_dt_bl(roi_bg_in,48:58,:),3),2))-1;


%c
[n1 x1]=hist(circ_c1c,0e-3:.5e-4:2e-3);
[n2 x2]=hist(bg_c1c,0e-3:.5e-4:2e-3);
figure;bar(x1,[n1;n2]')
legend('circle','background')

[n1 x1]=hist(circ_5,0e-3:.5e-4:2e-3);
[n2 x2]=hist(bg_5,0e-3:.5e-4:2e-3);
figure;bar(x1,[n1;n2]')
legend('circle','background')

[n1 x1]=hist(circ_20,0e-3:.5e-4:2e-3);
[n2 x2]=hist(bg_20,0e-3:.5e-4:2e-3);
figure;bar(x1,[n1;n2]')
legend('circle','background')

[n1 x1]=hist(circ_c5c,0e-3:.5e-4:2e-3);
[n2 x2]=hist(bg_c5c,0e-3:.5e-4:2e-3);
figure;bar(x1,[n1;n2]')
legend('circle','background')




%c
[n1 x1]=hist(circ_c1d,0e-3:.5e-4:2e-3);
[n2 x2]=hist(bg_c1d,0e-3:.5e-4:2e-3);
figure;bar(x1,[n1;n2]')
legend('circle','background')

[n1 x1]=hist(circ_10,0e-3:.5e-4:2e-3);
[n2 x2]=hist(bg_10,0e-3:.5e-4:2e-3);
figure;bar(x1,[n1;n2]')
legend('circle','background')

[n1 x1]=hist(circ_17,0e-3:.5e-4:2e-3);
[n2 x2]=hist(bg_17,0e-3:.5e-4:2e-3);
figure;bar(x1,[n1;n2]')
legend('circle','background')

[n1 x1]=hist(circ_c5d,0e-3:.5e-4:2e-3);
[n2 x2]=hist(bg_c5d,0e-3:.5e-4:2e-3);
figure;bar(x1,[n1;n2]')
legend('circle','background')




%AUC

scores=[circ_5;bg_5]';
labels=ones(1,size(scores,2));
labels(size(circ_5,1)+1:end)=0;
[X_5,Y_5,THRE,AUC_5,OPTROCPT,SUBY,SUBYNAMES] = perfcurve(labels,scores,1);

scores=[circ_17;bg_17]';
labels=ones(1,size(scores,2));
labels(size(circ_17,1)+1:end)=0;
[X_17,Y_17,THRE,AUC_17,OPTROCPT,SUBY,SUBYNAMES] = perfcurve(labels,scores,1);


scores=[circ_c1d;bg_c1d]';
labels=ones(1,size(scores,2));
labels(size(circ_c1d,1)+1:end)=0;
[X_c1d,Y_c1d,THRE,AUC_c1d,OPTROCPT,SUBY,SUBYNAMES] = perfcurve(labels,scores,1);

scores=[circ_10;bg_10]';
labels=ones(1,size(scores,2));
labels(size(circ_10,1)+1:end)=0;
[X_10,Y_10,THRE,AUC_10,OPTROCPT,SUBY,SUBYNAMES] = perfcurve(labels,scores,1);

scores=[circ_20;bg_20]';
labels=ones(1,size(scores,2));
labels(size(circ_20,1)+1:end)=0;
[X_20,Y_20,THRE,AUC_20,OPTROCPT,SUBY,SUBYNAMES] = perfcurve(labels,scores,1);

scores=[circ_c5d;bg_c5d]';
labels=ones(1,size(scores,2));
labels(size(circ_c5d,1)+1:end)=0;
[X_c5d,Y_c5d,THRE,AUC_c5d,OPTROCPT,SUBY,SUBYNAMES] = perfcurve(labels,scores,1);


scores=[circ_c1c;bg_c1c]';
labels=ones(1,size(scores,2));
labels(size(circ_c1c,1)+1:end)=0;
[X_c1c,Y_c1c,THRE,AUC_c1c,OPTROCPT,SUBY,SUBYNAMES] = perfcurve(labels,scores,1);


scores=[circ_c5c;bg_c5c]';
labels=ones(1,size(scores,2));
labels(size(circ_c5c,1)+1:end)=0;
[X_c5c,Y_c5c,THRE,AUC_c5c,OPTROCPT,SUBY,SUBYNAMES] = perfcurve(labels,scores,1);




figure;plot(X_c1c,Y_c1c)
hold on
plot(X_5,Y_5,'c')
plot(X_20,Y_20,'g')
plot(X_c5c,Y_c5c,'r')
legend('contour','5deg','20deg','non-contour')

figure;plot(X_c1d,Y_c1d)
hold on
plot(X_10,Y_10,'c')
plot(X_17,Y_17,'g')
plot(X_c5d,Y_c5d,'r')
legend('contour','10deg','17deg','non-contour')


figure;plot(mean([X_c1c X_c1d],2),mean([Y_c1c Y_c1d],2),'k')
hold on
plot(X_5,Y_5,'b')
plot(X_10,Y_10,'--')
plot(X_17,Y_17,'c')
plot(X_20,Y_20,'g')
plot(mean([X_c5c X_c5d],2),mean([Y_c5c Y_c5d],2),'r')
legend('contour','5deg','10deg','17deg','20deg','non-contour')


AUC_curve(1)=mean([AUC_c1c AUC_c1d]);
AUC_curve(2)=AUC_5;
AUC_curve(3)=AUC_10;
AUC_curve(4)=AUC_17;
AUC_curve(5)=AUC_20;
AUC_curve(6)=mean([AUC_c5c AUC_c5d]);

figure;plot([0 5 10 17 20 45],AUC_curve)



%% SMEAGOL

AUC_curve(1)=mean([AUC_curve_2212(1) AUC_curve_0501(1)]);
AUC_curve(2)=mean([AUC_curve_2212(2) AUC_curve_0501(2)]);
AUC_curve(3)=mean([AUC_curve_2212(3) AUC_curve_0501(3)]);
AUC_curve(4)=AUC_curve_0501(4);
AUC_curve(5)=AUC_curve_2212(4);
AUC_curve(6)=mean([AUC_curve_2212(5) AUC_curve_0501(5)]);
AUC_curve(7)=mean([AUC_curve_2212(6) AUC_curve_0501(6)]);

figure;plot([0 5 10 15 17 20 45],AUC_curve)

figure;plot([0 5 10 15 20 45],AUC_curve_0501)
figure;plot([0 5 10 17 20 45],AUC_curve_2212)


[r,m,b] = regression([0 5 10 15 17 20 45],AUC_curve);
xx=0:0.25:45;
figure;plot([0 5 10 15 17 20 45],AUC_curve)
hold on
plot(xx,m*xx+b)





