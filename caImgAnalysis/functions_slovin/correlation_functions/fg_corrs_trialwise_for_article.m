%% 1111cd
circ1=squeeze(mean(a(roi_contour2,:,:),1));
circ2=squeeze(mean(b(roi_contour2,:,:),1));
circ4=squeeze(mean(c(roi_contour2,:,:),1));
circ5=squeeze(mean(d(roi_contour2,:,:),1));

bg1=squeeze(mean(a(roi_maskin,:,:),1));
bg2=squeeze(mean(b(roi_maskin,:,:),1));
bg4=squeeze(mean(c(roi_maskin,:,:),1));
bg5=squeeze(mean(d(roi_maskin,:,:),1));

fg1c=circ1-bg1;
fg2c=circ2-bg2;
fg4c=circ4-bg4;
fg5c=circ5-bg5;


figure;plot(mean(fg1c,2))
hold on
plot(mean(fg2c,2),'c')
plot(mean(fg4c,2),'m')
plot(mean(fg5c,2),'r')

time=31:34;

[n1 x1]=hist(mean(fg1d(time,:),1),-0.3:0.025:0.3);
[n2 x2]=hist(mean(fg2d(time,:),1),-0.3:0.025:0.3);
[n4 x4]=hist(mean(fg4d(time,:),1),-0.3:0.025:0.3);
[n5 x5]=hist(mean(fg5d(time,:),1),-0.3:0.025:0.3);

figure;bar(x1,[n1;n4]')
figure;bar(x2,[n2;n5]')


fg_cont=cat(2,fg1c,fg2c,fg1d,fg2d);
fg_non=cat(2,fg4c,fg5c,fg4d,fg5d);
[n1 x1]=hist(mean(fg_cont(time,:),1),-0.3:0.035:0.3);
[n2 x2]=hist(mean(fg_non(time,:),1),-0.3:0.035:0.3);
figure;bar(x1,[n1;n2]')
xlim([-.2 .3])
ranksum(mean(fg_cont(time,:),1),mean(fg_non(time,:),1))

scores=[mean(fg_cont(time,:),1) mean(fg_non(time,:),1)];
labels=ones(1,size(scores,2));
labels(size(fg_cont,2)+1:end)=0;
[X,Y,THRE,AUC,OPTROCPT,SUBY,SUBYNAMES] = perfcurve(labels,scores,1);
figure;plot(X,Y)

scores=[mean(fg1c(time,:),1) mean(fg4c(time,:),1)];
labels=ones(1,size(scores,2));
labels(size(fg1c,2)+1:end)=0;
[X,Y,THRE,AUCc14,OPTROCPT,SUBY,SUBYNAMES] = perfcurve(labels,scores,1);
figure;plot(X,Y)

scores=[mean(fg2c(time,:),1) mean(fg5c(time,:),1)];
labels=ones(1,size(scores,2));
labels(size(fg2c,2)+1:end)=0;
[X,Y,THRE,AUCc25,OPTROCPT,SUBY,SUBYNAMES] = perfcurve(labels,scores,1);
figure;plot(X,Y)

scores=[mean(fg1d(time,:),1) mean(fg4d(time,:),1)];
labels=ones(1,size(scores,2));
labels(size(fg1d,2)+1:end)=0;
[X,Y,THRE,AUCd14,OPTROCPT,SUBY,SUBYNAMES] = perfcurve(labels,scores,1);
figure;plot(X,Y)


scores=[mean(fg2d(time,:),1) mean(fg5d(time,:),1)];
labels=ones(1,size(scores,2));
labels(size(fg2d,2)+1:end)=0;
[X,Y,THRE,AUCd25,OPTROCPT,SUBY,SUBYNAMES] = perfcurve(labels,scores,1);
figure;plot(X,Y)






%% 1111h
time=31:33;

[n1 x1]=hist(mean(fg1h(time,:),1),-0.3:0.025:0.3);
[n2 x2]=hist(mean(fg2h(time,:),1),-0.3:0.025:0.3);
[n4 x4]=hist(mean(fg4h(time,:),1),-0.3:0.025:0.3);
[n5 x5]=hist(mean(fg5h(time,:),1),-0.3:0.025:0.3);

figure;bar(x1,[n1;n4]')
figure;bar(x2,[n2;n5]')

scores=[mean(fg1h(time,:),1) mean(fg4h(time,:),1)];
labels=ones(1,size(scores,2));
labels(size(fg1h,2)+1:end)=0;
[X,Y,THRE,AUCh14,OPTROCPT,SUBY,SUBYNAMES] = perfcurve(labels,scores,1);
figure;plot(X,Y)


scores=[mean(fg2h(time,:),1) mean(fg5h(time,:),1)];
labels=ones(1,size(scores,2));
labels(size(fg2h,2)+1:end)=0;
[X,Y,THRE,AUCh25,OPTROCPT,SUBY,SUBYNAMES] = perfcurve(labels,scores,1);
figure;plot(X,Y)



%% 2511
%d
circ1=squeeze(mean(a(roi_circle_diff,:,:),1));
circ5=squeeze(mean(b(roi_circle_diff,:,:),1));
bg1=squeeze(mean(a(roi_bg_in,:,:),1));
bg5=squeeze(mean(b(roi_bg_in,:,:),1));
fg1d=circ1-bg1;
fg5d=circ5-bg5;
figure;plot(mean(fg1d,2))
hold on
plot(mean(fg5d,2),'r')

time=34:37;
[n1 x1]=hist(mean(fg1d(time,:),1),-0.3:0.025:0.3);
[n5 x5]=hist(mean(fg5d(time,:),1),-0.3:0.025:0.3);
figure;bar(x1,[n1;n5]')

scores=[mean(fg1d(time,:),1) mean(fg5d(time,:),1)];
labels=ones(1,size(scores,2));
labels(size(fg1d,2)+1:end)=0;
[X,Y,THRE,AUCd15,OPTROCPT,SUBY,SUBYNAMES] = perfcurve(labels,scores,1);
figure;plot(X,Y)


%e
circ1=squeeze(mean(a(roi_circle_diff,:,:),1));
circ5=squeeze(mean(b(roi_circle_diff,:,:),1));
bg1=squeeze(mean(a(roi_bg_in,:,:),1));
bg5=squeeze(mean(b(roi_bg_in,:,:),1));
fg1e=circ1-bg1;
fg5e=circ5-bg5;
figure;plot(mean(fg1e,2))
hold on
plot(mean(fg5e,2),'r')

time=33:37;

[n1 x1]=hist(mean(fg1e(time,:),1),-0.3:0.025:0.3);
[n5 x5]=hist(mean(fg5e(time,:),1),-0.3:0.025:0.3);
figure;bar(x1,[n1;n5]')

scores=[mean(fg1e(time,:),1) mean(fg5e(time,:),1)];
labels=ones(1,size(scores,2));
labels(size(fg1e,2)+1:end)=0;
[X,Y,THRE,AUCe15,OPTROCPT,SUBY,SUBYNAMES] = perfcurve(labels,scores,1);
figure;plot(X,Y)



%e
circ1=squeeze(mean(a(roi_circle_diff,:,:),1));
circ5=squeeze(mean(b(roi_circle_diff,:,:),1));
bg1=squeeze(mean(a(roi_bg_in,:,:),1));
bg5=squeeze(mean(b(roi_bg_in,:,:),1));
fg1f=circ1-bg1;
fg5f=circ5-bg5;
figure;plot(mean(fg1f,2))
hold on
plot(mean(fg5f,2),'r')

time=33:37;

[n1 x1]=hist(mean(fg1f(time,:),1),-0.3:0.025:0.3);
[n5 x5]=hist(mean(fg5f(time,:),1),-0.3:0.025:0.3);
figure;bar(x1,[n1;n5]')

scores=[mean(fg1f(time,:),1) mean(fg5f(time,:),1)];
labels=ones(1,size(scores,2));
labels(size(fg1f,2)+1:end)=0;
[X,Y,THRE,AUCf15,OPTROCPT,SUBY,SUBYNAMES] = perfcurve(labels,scores,1);
figure;plot(X,Y)




%% 1811
%c
circ1=squeeze(mean(a(roi_circle_diff,:,:),1));
circ5=squeeze(mean(b(roi_circle_diff,:,:),1));
bg1=squeeze(mean(a(roi_bg_in,:,:),1));
bg5=squeeze(mean(b(roi_bg_in,:,:),1));
fg1c=circ1-bg1;
fg5c=circ5-bg5;
figure;plot(mean(fg1c,2))
hold on
plot(mean(fg5c,2),'r')


time=33:34;
[n1 x1]=hist(mean(fg1c(time,:),1),-0.3:0.025:0.3);
[n5 x5]=hist(mean(fg5c(time,:),1),-0.3:0.025:0.3);
figure;bar(x1,[n1;n5]')


scores=[mean(fg1c(time,:),1) mean(fg5c(time,:),1)];
labels=ones(1,size(scores,2));
labels(size(fg1c,2)+1:end)=0;
[X,Y,THRE,AUCc15,OPTROCPT,SUBY,SUBYNAMES] = perfcurve(labels,scores,1);
figure;plot(X,Y)




%d
circ1=squeeze(mean(a(roi_circle_diff,:,:),1));
circ5=squeeze(mean(b(roi_circle_diff,:,:),1));
bg1=squeeze(mean(a(roi_bg_in,:,:),1));
bg5=squeeze(mean(b(roi_bg_in,:,:),1));
fg1d=circ1-bg1;
fg5d=circ5-bg5;
figure;plot(mean(fg1d,2))
hold on
plot(mean(fg5d,2),'r')


time=31:34;
[n1 x1]=hist(mean(fg1d(time,:),1),-0.3:0.025:0.3);
[n5 x5]=hist(mean(fg5d(time,:),1),-0.3:0.025:0.3);
figure;bar(x1,[n1;n5]')


scores=[mean(fg1d(time,:),1) mean(fg5d(time,:),1)];
labels=ones(1,size(scores,2));
labels(size(fg1d,2)+1:end)=0;
[X,Y,THRE,AUCd15,OPTROCPT,SUBY,SUBYNAMES] = perfcurve(labels,scores,1);
figure;plot(X,Y)





%e
circ1=squeeze(mean(a(roi_circle_diff,:,:),1));
circ5=squeeze(mean(b(roi_circle_diff,:,:),1));
bg1=squeeze(mean(a(roi_bg_in,:,:),1));
bg5=squeeze(mean(b(roi_bg_in,:,:),1));
fg1e=circ1-bg1;
fg5e=circ5-bg5;
figure;plot(mean(fg1e,2))
hold on
plot(mean(fg5e,2),'r')


time=34:35;
[n1 x1]=hist(mean(fg1e(time,:),1),-0.3:0.025:0.3);
[n5 x5]=hist(mean(fg5e(time,:),1),-0.3:0.025:0.3);
figure;bar(x1,[n1;n5]')


scores=[mean(fg1e(time,:),1) mean(fg5e(time,:),1)];
labels=ones(1,size(scores,2));
labels(size(fg1e,2)+1:end)=0;
[X,Y,THRE,AUCe15,OPTROCPT,SUBY,SUBYNAMES] = perfcurve(labels,scores,1);
figure;plot(X,Y)



%% 1203
%d
circ1=squeeze(mean(a(roi_circle_diff,:,:),1));
circ5=squeeze(mean(b(roi_circle_diff,:,:),1));
bg1=squeeze(mean(a(roi_bg_in,:,:),1));
bg5=squeeze(mean(b(roi_bg_in,:,:),1));
fg1d=circ1-bg1;
fg5d=circ5-bg5;
figure;plot(mean(fg1d,2))
hold on
plot(mean(fg5d,2),'r')

time=31:34;
[n1 x1]=hist(mean(fg1d(time,:),1),-0.3:0.025:0.3);
[n5 x5]=hist(mean(fg5d(time,:),1),-0.3:0.025:0.3);
figure;bar(x1,[n1;n5]')

scores=[mean(fg1d(time,:),1) mean(fg5d(time,:),1)];
labels=ones(1,size(scores,2));
labels(size(fg1d,2)+1:end)=0;
[X,Y,THRE,AUCd15,OPTROCPT,SUBY,SUBYNAMES] = perfcurve(labels,scores,1);
figure;plot(X,Y)


%e
circ1=squeeze(mean(a(roi_circle_diff,:,:),1));
circ5=squeeze(mean(b(roi_circle_diff,:,:),1));
bg1=squeeze(mean(a(roi_bg_in,:,:),1));
bg5=squeeze(mean(b(roi_bg_in,:,:),1));
fg1e=circ1-bg1;
fg5e=circ5-bg5;
figure;plot(mean(fg1e,2))
hold on
plot(mean(fg5e,2),'r')

time=31:34;

[n1 x1]=hist(mean(fg1e(time,:),1),-0.3:0.025:0.3);
[n5 x5]=hist(mean(fg5e(time,:),1),-0.3:0.025:0.3);
figure;bar(x1,[n1;n5]')

scores=[mean(fg1e(time,:),1) mean(fg5e(time,:),1)];
labels=ones(1,size(scores,2));
labels(size(fg1e,2)+1:end)=0;
[X,Y,THRE,AUCe15,OPTROCPT,SUBY,SUBYNAMES] = perfcurve(labels,scores,1);
figure;plot(X,Y)



%f
circ1=squeeze(mean(a(roi_circle_diff,:,:),1));
circ5=squeeze(mean(b(roi_circle_diff,:,:),1));
bg1=squeeze(mean(a(roi_bg_in,:,:),1));
bg5=squeeze(mean(b(roi_bg_in,:,:),1));
fg1f=circ1-bg1;
fg5f=circ5-bg5;
figure;plot(mean(fg1f,2))
hold on
plot(mean(fg5f,2),'r')

time=33;

[n1 x1]=hist(mean(fg1f(time,:),1),-0.3:0.025:0.3);
[n5 x5]=hist(mean(fg5f(time,:),1),-0.3:0.025:0.3);
figure;bar(x1,[n1;n5]')

scores=[mean(fg1f(time,:),1) mean(fg5f(time,:),1)];
labels=ones(1,size(scores,2));
labels(size(fg1f,2)+1:end)=0;
[X,Y,THRE,AUCf15,OPTROCPT,SUBY,SUBYNAMES] = perfcurve(labels,scores,1);
figure;plot(X,Y)


%% 0610

%e
circ1=squeeze(mean(a(roi_circle_diff,:,:),1));
circ2=squeeze(mean(b(roi_circle_diff,:,:),1));
circ4=squeeze(mean(c(roi_circle_diff,:,:),1));
circ5=squeeze(mean(d(roi_circle_diff,:,:),1));

bg1=squeeze(mean(a(roi_bg_in,:,:),1));
bg2=squeeze(mean(b(roi_bg_in,:,:),1));
bg4=squeeze(mean(c(roi_bg_in,:,:),1));
bg5=squeeze(mean(d(roi_bg_in,:,:),1));

fg1e=circ1-bg1;
fg2e=circ2-bg2;
fg4e=circ4-bg4;
fg5e=circ5-bg5;

figure;plot(mean(fg1e,2))
hold on
plot(mean(fg2e,2),'c')
plot(mean(fg4e,2),'m')
plot(mean(fg5e,2),'r')

time=28:29;

[n1 x1]=hist(mean(fg1e(time,:),1),-0.3:0.025:0.3);
[n2 x2]=hist(mean(fg2e(time,:),1),-0.3:0.025:0.3);
[n4 x4]=hist(mean(fg4e(time,:),1),-0.3:0.025:0.3);
[n5 x5]=hist(mean(fg5e(time,:),1),-0.3:0.025:0.3);

figure;bar(x1,[n1;n4]')
figure;bar(x2,[n2;n5]')

scores=[mean(fg1e(time,:),1) mean(fg4e(time,:),1)];
labels=ones(1,size(scores,2));
labels(size(fg1e,2)+1:end)=0;
[X,Y,THRE,AUCe14,OPTROCPT,SUBY,SUBYNAMES] = perfcurve(labels,scores,1);
figure;plot(X,Y)

scores=[mean(fg2e(time,:),1) mean(fg5e(time,:),1)];
labels=ones(1,size(scores,2));
labels(size(fg2e,2)+1:end)=0;
[X,Y,THRE,AUCe25,OPTROCPT,SUBY,SUBYNAMES] = perfcurve(labels,scores,1);
figure;plot(X,Y)



%f
circ1=squeeze(mean(a(roi_circle_diff,:,:),1));
circ2=squeeze(mean(b(roi_circle_diff,:,:),1));
circ4=squeeze(mean(c(roi_circle_diff,:,:),1));
circ5=squeeze(mean(d(roi_circle_diff,:,:),1));

bg1=squeeze(mean(a(roi_bg_in,:,:),1));
bg2=squeeze(mean(b(roi_bg_in,:,:),1));
bg4=squeeze(mean(c(roi_bg_in,:,:),1));
bg5=squeeze(mean(d(roi_bg_in,:,:),1));

fg1f=circ1-bg1;
fg2f=circ2-bg2;
fg4f=circ4-bg4;
fg5f=circ5-bg5;

figure;plot(mean(fg1f,2))
hold on
plot(mean(fg2f,2),'c')
plot(mean(fg4f,2),'m')
plot(mean(fg5f,2),'r')

time=32:35;

[n1 x1]=hist(mean(fg1f(time,:),1),-0.3:0.025:0.3);
[n2 x2]=hist(mean(fg2f(time,:),1),-0.3:0.025:0.3);
[n4 x4]=hist(mean(fg4f(time,:),1),-0.3:0.025:0.3);
[n5 x5]=hist(mean(fg5f(time,:),1),-0.3:0.025:0.3);

figure;bar(x1,[n1;n4]')
figure;bar(x2,[n2;n5]')

scores=[mean(fg1f(time,:),1) mean(fg4f(time,:),1)];
labels=ones(1,size(scores,2));
labels(size(fg1f,2)+1:end)=0;
[X,Y,THRE,AUCf14,OPTROCPT,SUBY,SUBYNAMES] = perfcurve(labels,scores,1);
figure;plot(X,Y)

scores=[mean(fg2f(time,:),1) mean(fg5f(time,:),1)];
labels=ones(1,size(scores,2));
labels(size(fg2f,2)+1:end)=0;
[X,Y,THRE,AUCf25,OPTROCPT,SUBY,SUBYNAMES] = perfcurve(labels,scores,1);
figure;plot(X,Y)




%% 2210

%d
circ1=squeeze(mean(a(roi_circle_diff,:,:),1));
circ2=squeeze(mean(b(roi_circle_diff,:,:),1));
circ4=squeeze(mean(c(roi_circle_diff,:,:),1));
circ5=squeeze(mean(d(roi_circle_diff,:,:),1));

bg1=squeeze(mean(a(roi_bg_in,:,:),1));
bg2=squeeze(mean(b(roi_bg_in,:,:),1));
bg4=squeeze(mean(c(roi_bg_in,:,:),1));
bg5=squeeze(mean(d(roi_bg_in,:,:),1));

fg1d=circ1-bg1;
fg2d=circ2-bg2;
fg4d=circ4-bg4;
fg5d=circ5-bg5;

figure;plot(mean(fg1d,2))
hold on
plot(mean(fg2d,2),'c')
plot(mean(fg4d,2),'m')
plot(mean(fg5d,2),'r')

time=30:31;

[n1 x1]=hist(mean(fg1d(time,:),1),-0.3:0.025:0.3);
[n2 x2]=hist(mean(fg2d(time,:),1),-0.3:0.025:0.3);
[n4 x4]=hist(mean(fg4d(time,:),1),-0.3:0.025:0.3);
[n5 x5]=hist(mean(fg5d(time,:),1),-0.3:0.025:0.3);

figure;bar(x1,[n1;n4]')
figure;bar(x2,[n2;n5]')

scores=[mean(fg1d(time,:),1) mean(fg4d(time,:),1)];
labels=ones(1,size(scores,2));
labels(size(fg1d,2)+1:end)=0;
[X,Y,THRE,AUCd14,OPTROCPT,SUBY,SUBYNAMES] = perfcurve(labels,scores,1);
figure;plot(X,Y)

scores=[mean(fg2d(time,:),1) mean(fg5d(time,:),1)];
labels=ones(1,size(scores,2));
labels(size(fg2d,2)+1:end)=0;
[X,Y,THRE,AUCd25,OPTROCPT,SUBY,SUBYNAMES] = perfcurve(labels,scores,1);
figure;plot(X,Y)



%e
circ1=squeeze(mean(a(roi_circle_diff,:,:),1));
circ2=squeeze(mean(b(roi_circle_diff,:,:),1));
circ4=squeeze(mean(c(roi_circle_diff,:,:),1));
circ5=squeeze(mean(d(roi_circle_diff,:,:),1));

bg1=squeeze(mean(a(roi_bg_in,:,:),1));
bg2=squeeze(mean(b(roi_bg_in,:,:),1));
bg4=squeeze(mean(c(roi_bg_in,:,:),1));
bg5=squeeze(mean(d(roi_bg_in,:,:),1));

fg1e=circ1-bg1;
fg2e=circ2-bg2;
fg4e=circ4-bg4;
fg5e=circ5-bg5;

figure;plot(mean(fg1e,2))
hold on
plot(mean(fg2e,2),'c')
plot(mean(fg4e,2),'m')
plot(mean(fg5e,2),'r')

time=31:34;

[n1 x1]=hist(mean(fg1e(time,:),1),-0.3:0.025:0.3);
[n2 x2]=hist(mean(fg2e(time,:),1),-0.3:0.025:0.3);
[n4 x4]=hist(mean(fg4e(time,:),1),-0.3:0.025:0.3);
[n5 x5]=hist(mean(fg5e(time,:),1),-0.3:0.025:0.3);

figure;bar(x1,[n1;n4]')
figure;bar(x2,[n2;n5]')

scores=[mean(fg1e(time,:),1) mean(fg4e(time,:),1)];
labels=ones(1,size(scores,2));
labels(size(fg1e,2)+1:end)=0;
[X,Y,THRE,AUCe14,OPTROCPT,SUBY,SUBYNAMES] = perfcurve(labels,scores,1);
figure;plot(X,Y)

scores=[mean(fg2e(time,:),1) mean(fg5e(time,:),1)];
labels=ones(1,size(scores,2));
labels(size(fg2e,2)+1:end)=0;
[X,Y,THRE,AUCe25,OPTROCPT,SUBY,SUBYNAMES] = perfcurve(labels,scores,1);
figure;plot(X,Y)




%%

AUC_leg=[AUC_1111c14 AUC_1111c25 AUC_1111d14 AUC_1111d25 AUC_1111h14 AUC_1111h25 ...
    AUC_1811c15 AUC_1811d15 AUC_1811e15 AUC_2511d15 AUC_2511e15 AUC_2511f15 ...
    AUC_1203d15 AUC_1203e15 AUC_1203f15 AUC_0610e14 AUC_0610e25 AUC_0610f14 ...
    AUC_0610f25 AUC_2210d14 AUC_2210d25 AUC_2210e14 AUC_2210e25];




%% SMEAGOL
%% 2912

%c
circ1=squeeze(mean(a(roi_circle,:,:),1));
circ2=squeeze(mean(b(roi_circle,:,:),1));
circ4=squeeze(mean(c(roi_circle,:,:),1));
circ5=squeeze(mean(d(roi_circle,:,:),1));

bg1=squeeze(mean(a(roi_bg_out,:,:),1));
bg2=squeeze(mean(b(roi_bg_out,:,:),1));
bg4=squeeze(mean(c(roi_bg_out,:,:),1));
bg5=squeeze(mean(d(roi_bg_out,:,:),1));

fg1c=circ1-bg1;
fg2c=circ2-bg2;
fg4c=circ4-bg4;
fg5c=circ5-bg5;

figure;plot(mean(fg1c,2))
hold on
plot(mean(fg2c,2),'c')
plot(mean(fg4c,2),'m')
plot(mean(fg5c,2),'r')

time=27:29;

[n1 x1]=hist(mean(fg1c(time,:),1),-0.3:0.025:0.3);
[n2 x2]=hist(mean(fg2c(time,:),1),-0.3:0.025:0.3);
[n4 x4]=hist(mean(fg4c(time,:),1),-0.3:0.025:0.3);
[n5 x5]=hist(mean(fg5c(time,:),1),-0.3:0.025:0.3);

figure;bar(x1,[n1;n4]')
figure;bar(x2,[n2;n5]')

scores=[mean(fg1c(time,:),1) mean(fg4c(time,:),1)];
labels=ones(1,size(scores,2));
labels(size(fg1c,2)+1:end)=0;
[X,Y,THRE,AUC_2912c14,OPTROCPT,SUBY,SUBYNAMES] = perfcurve(labels,scores,1);
figure;plot(X,Y)

scores=[mean(fg2c(time,:),1) mean(fg5c(time,:),1)];
labels=ones(1,size(scores,2));
labels(size(fg2c,2)+1:end)=0;
[X,Y,THRE,AUC_2912c25,OPTROCPT,SUBY,SUBYNAMES] = perfcurve(labels,scores,1);
figure;plot(X,Y)



%e
circ1=squeeze(mean(a(roi_circle,:,:),1));
circ2=squeeze(mean(b(roi_circle,:,:),1));
circ4=squeeze(mean(c(roi_circle,:,:),1));
circ5=squeeze(mean(d(roi_circle,:,:),1));

bg1=squeeze(mean(a(roi_bg_out,:,:),1));
bg2=squeeze(mean(b(roi_bg_out,:,:),1));
bg4=squeeze(mean(c(roi_bg_out,:,:),1));
bg5=squeeze(mean(d(roi_bg_out,:,:),1));

fg1e=circ1-bg1;
fg2e=circ2-bg2;
fg4e=circ4-bg4;
fg5e=circ5-bg5;

figure;plot(mean(fg1e,2))
hold on
plot(mean(fg2e,2),'c')
plot(mean(fg4e,2),'m')
plot(mean(fg5e,2),'r')

time=28:30;

[n1 x1]=hist(mean(fg1e(time,:),1),-0.3:0.025:0.3);
[n2 x2]=hist(mean(fg2e(time,:),1),-0.3:0.025:0.3);
[n4 x4]=hist(mean(fg4e(time,:),1),-0.3:0.025:0.3);
[n5 x5]=hist(mean(fg5e(time,:),1),-0.3:0.025:0.3);

figure;bar(x1,[n1;n4]')
figure;bar(x2,[n2;n5]')

scores=[mean(fg1e(time,:),1) mean(fg4e(time,:),1)];
labels=ones(1,size(scores,2));
labels(size(fg1e,2)+1:end)=0;
[X,Y,THRE,AUC_2912e14,OPTROCPT,SUBY,SUBYNAMES] = perfcurve(labels,scores,1);
figure;plot(X,Y)

scores=[mean(fg2e(time,:),1) mean(fg5e(time,:),1)];
labels=ones(1,size(scores,2));
labels(size(fg2e,2)+1:end)=0;
[X,Y,THRE,AUC_2912e25,OPTROCPT,SUBY,SUBYNAMES] = perfcurve(labels,scores,1);
figure;plot(X,Y)





%k
circ1=squeeze(mean(a(roi_circle,:,:),1));
circ2=squeeze(mean(b(roi_circle,:,:),1));
circ4=squeeze(mean(c(roi_circle,:,:),1));
circ5=squeeze(mean(d(roi_circle,:,:),1));

bg1=squeeze(mean(a(roi_bg_out,:,:),1));
bg2=squeeze(mean(b(roi_bg_out,:,:),1));
bg4=squeeze(mean(c(roi_bg_out,:,:),1));
bg5=squeeze(mean(d(roi_bg_out,:,:),1));

fg1k=circ1-bg1;
fg2k=circ2-bg2;
fg4k=circ4-bg4;
fg5k=circ5-bg5;

figure;plot(mean(fg1k,2))
hold on
plot(mean(fg2k,2),'c')
plot(mean(fg4k,2),'m')
plot(mean(fg5k,2),'r')

time=31:34;

[n1 x1]=hist(mean(fg1k(time,:),1),-0.3:0.025:0.3);
[n2 x2]=hist(mean(fg2k(time,:),1),-0.3:0.025:0.3);
[n4 x4]=hist(mean(fg4k(time,:),1),-0.3:0.025:0.3);
[n5 x5]=hist(mean(fg5k(time,:),1),-0.3:0.025:0.3);

figure;bar(x1,[n1;n4]')
figure;bar(x2,[n2;n5]')

scores=[mean(fg1k(time,:),1) mean(fg4k(time,:),1)];
labels=ones(1,size(scores,2));
labels(size(fg1k,2)+1:end)=0;
[X,Y,THRE,AUC_2912k14,OPTROCPT,SUBY,SUBYNAMES] = perfcurve(labels,scores,1);
figure;plot(X,Y)

scores=[mean(fg2k(time,:),1) mean(fg5k(time,:),1)];
labels=ones(1,size(scores,2));
labels(size(fg2k,2)+1:end)=0;
[X,Y,THRE,AUC_2912k25,OPTROCPT,SUBY,SUBYNAMES] = perfcurve(labels,scores,1);
figure;plot(X,Y)



%% 0501
%b
circ1=squeeze(mean(a(roi_circle,:,:),1));
circ2=squeeze(mean(b(roi_circle,:,:),1));
circ4=squeeze(mean(c(roi_circle,:,:),1));
circ5=squeeze(mean(d(roi_circle,:,:),1));

bg1=squeeze(mean(a(roi_bg_out,:,:),1));
bg2=squeeze(mean(b(roi_bg_out,:,:),1));
bg4=squeeze(mean(c(roi_bg_out,:,:),1));
bg5=squeeze(mean(d(roi_bg_out,:,:),1));

fg1b=circ1-bg1;
fg2b=circ2-bg2;
fg4b=circ4-bg4;
fg5b=circ5-bg5;

figure;plot(mean(fg1b,2))
hold on
plot(mean(fg2b,2),'c')
plot(mean(fg4b,2),'m')
plot(mean(fg5b,2),'r')

time=31:34;

[n1 x1]=hist(mean(fg1b(time,:),1),-0.3:0.025:0.3);
[n2 x2]=hist(mean(fg2b(time,:),1),-0.3:0.025:0.3);
[n4 x4]=hist(mean(fg4b(time,:),1),-0.3:0.025:0.3);
[n5 x5]=hist(mean(fg5b(time,:),1),-0.3:0.025:0.3);

figure;bar(x1,[n1;n4]')
figure;bar(x2,[n2;n5]')

scores=[mean(fg1b(time,:),1) mean(fg4b(time,:),1)];
labels=ones(1,size(scores,2));
labels(size(fg1b,2)+1:end)=0;
[X,Y,THRE,AUC_0501b14,OPTROCPT,SUBY,SUBYNAMES] = perfcurve(labels,scores,1);
figure;plot(X,Y)

scores=[mean(fg2b(time,:),1) mean(fg5b(time,:),1)];
labels=ones(1,size(scores,2));
labels(size(fg2b,2)+1:end)=0;
[X,Y,THRE,AUC_0501b25,OPTROCPT,SUBY,SUBYNAMES] = perfcurve(labels,scores,1);
figure;plot(X,Y)





%c
circ1=squeeze(mean(a(roi_circle,:,:),1));
circ5=squeeze(mean(b(roi_circle,:,:),1));
bg1=squeeze(mean(a(roi_bg_out,:,:),1));
bg5=squeeze(mean(b(roi_bg_out,:,:),1));

fg1c=circ1-bg1;
fg5c=circ5-bg5;

figure;plot(mean(fg1c,2))
hold on
plot(mean(fg5c,2),'r')

time=28:29;

[n1 x1]=hist(mean(fg1c(time,:),1),-0.3:0.025:0.3);
[n5 x5]=hist(mean(fg5c(time,:),1),-0.3:0.025:0.3);

figure;bar(x1,[n1;n5]')

scores=[mean(fg1c(time,:),1) mean(fg5c(time,:),1)];
labels=ones(1,size(scores,2));
labels(size(fg1c,2)+1:end)=0;
[X,Y,THRE,AUC_0501c15,OPTROCPT,SUBY,SUBYNAMES] = perfcurve(labels,scores,1);
figure;plot(X,Y)



%d
circ1=squeeze(mean(a(roi_circle,:,:),1));
circ5=squeeze(mean(b(roi_circle,:,:),1));
bg1=squeeze(mean(a(roi_bg_out,:,:),1));
bg5=squeeze(mean(b(roi_bg_out,:,:),1));

fg1d=circ1-bg1;
fg5d=circ5-bg5;
figure;plot(mean(fg1d,2))
hold on
plot(mean(fg5d,2),'r')

time=27:28;

[n1 x1]=hist(mean(fg1d(time,:),1),-0.3:0.025:0.3);
[n5 x5]=hist(mean(fg5d(time,:),1),-0.3:0.025:0.3);
figure;bar(x1,[n1;n5]')

scores=[mean(fg1d(time,:),1) mean(fg5d(time,:),1)];
labels=ones(1,size(scores,2));
labels(size(fg1d,2)+1:end)=0;
[X,Y,THRE,AUC_0501d15,OPTROCPT,SUBY,SUBYNAMES] = perfcurve(labels,scores,1);
figure;plot(X,Y)

%%
AUC_smeg=[AUC_2912c14 AUC_2912c25 AUC_2912e14 AUC_2912e25 AUC_2912k14 AUC_2912k25...
    AUC_0501b14 AUC_0501b25 AUC_0501c15 AUC_0501d15];


%%
figure;bar([mean(AUC_leg(unnoisy_sessions)) mean(AUC_smeg)])
hold on
errorbar([mean(AUC_leg(unnoisy_sessions)) mean(AUC_smeg)],[std(AUC_leg(unnoisy_sessions))/sqrt(18) std(AUC_smeg)/sqrt(10)])
ylim([0.5 1])




