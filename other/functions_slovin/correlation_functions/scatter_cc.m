
%% 1111cd1245 contour2 corr map
roi1=roi_contour2;
roi2=roi_maskin;
time1=32:34;
figure;mimg(mfilt2(mean(mean(a1(:,time1,:),2),3)-mean(mean(b1(:,time1,:),2),3),100,100,1.5,'lm'),100,100,-0.02,0.06);colormap(mapgeog)

figure
scatter(mean(b1(roi1,time1),2),mean(a1(roi1,time1),2))
hold on
xlim([0 .7]);ylim([0 .7])
plot(0:0.0001:.8,0:0.0001:.8)
axis square
ranksum(mean(b1(roi1,time1),2),mean(a1(roi1,time1),2))


figure
scatter(mean(b1(roi2,time1),2),mean(a1(roi2,time1),2))
hold on
xlim([0 0.7]);ylim([0 .7])
plot(0:0.0001:.8,0:0.0001:.8)
axis square
ranksum(mean(b1(roi2,time1),2),mean(a1(roi2,time1),2))



%% 2511d15
roi1=roi_circ_fig5;
roi2=roi_bg_in_fig5;
time1=28:33;
figure;mimg(mfilt2(mean(mean(a2(:,time1,:),2),3)-mean(mean(b2(:,time1,:),2),3),100,100,1.5,'lm'),100,100,-0.04,0.07);colormap(mapgeog)

figure
scatter(mean(b2(roi1,time1),2),mean(a2(roi1,time1),2))
hold on
xlim([0 .4]);ylim([0 .4])
plot(0:0.0001:.8,0:0.0001:.8)
axis square
ranksum(mean(b2(roi1,time1),2),mean(a2(roi1,time1),2))


figure
scatter(mean(b2(roi2,time1),2),mean(a2(roi2,time1),2))
hold on
xlim([0 0.4]);ylim([0 .4])
plot(0:0.0001:.8,0:0.0001:.8)
axis square
ranksum(mean(b2(roi2,time1),2),mean(a2(roi2,time1),2))




%% 2912c1245
roi1=roi_circle2;
roi2=roi_bg_out2;
time1=26:27;
figure;mimg(mfilt2(mean(a3(:,time1),2)-mean(b3(:,time1),2),100,100,1.5,'lm'),100,100,-0.01,0.045);colormap(mapgeog)

time1=26:28; %yes. one frame difference

figure
scatter(mean(b3(roi1,time1),2),mean(a3(roi1,time1),2))
hold on
xlim([-.1 .5]);ylim([-.1 .5])
plot(-.1:0.0001:.8,-.1:0.0001:.8)
axis square
ranksum(mean(b3(roi1,time1),2),mean(a3(roi1,time1),2))


figure
scatter(mean(b3(roi2,time1),2),mean(a3(roi2,time1),2))
hold on
xlim([-.1 0.5]);ylim([-.1 .5])
plot(-.1:0.0001:.8,-.1:0.0001:.8)
axis square
ranksum(mean(b3(roi2,time1),2),mean(a3(roi2,time1),2))




%% 2912e1245
roi1=roi_circle_fig5_2;
roi2=roi_bg_out_fig5_2;
time1=34:36;
figure;mimg(mfilt2(mean(a4(:,time1),2)-mean(b4(:,time1),2),100,100,1.5,'lm'),100,100,-0.04,0.04);colormap(mapgeog)

figure
scatter(mean(b4(roi1,time1),2),mean(a4(roi1,time1),2))
hold on
xlim([-.1 .3]);ylim([-.1 .3])
plot(-.1:0.0001:.8,-.1:0.0001:.8)
axis square
ranksum(mean(b4(roi1,time1),2),mean(a4(roi1,time1),2))


figure
scatter(mean(b4(roi2,time1),2),mean(a4(roi2,time1),2))
hold on
xlim([-.1 0.3]);ylim([-.1 .3])
plot(-.1:0.0001:.8,-.1:0.0001:.8)
axis square
ranksum(mean(b4(roi2,time1),2),mean(a4(roi2,time1),2))




