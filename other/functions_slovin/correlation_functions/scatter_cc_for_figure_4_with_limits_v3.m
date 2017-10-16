
%% 1111cd1245 contour2 corr map
cd F:\Data\VSDI\Contour_integration\legolas\right_hemisphere\11_11_2008
load corrmaps_for_figure4_ci
roi1=roi_contour5;
roi2=roi_maskin5;
time1=32:34;
figure;mimg(mfilt2(mean(mean(a1(:,time1,:),2),3)-mean(mean(b1(:,time1,:),2),3),100,100,1.5,'lm'),100,100,-0.02,0.06);colormap(mapgeog)

pretime=16:18;
diff_circ=mean(a1(roi1,pretime),2)-mean(b1(roi1,pretime),2);
top_circ = prctile(diff_circ,99);
bottom_circ = prctile(diff_circ,1);
diff_bg=mean(a1(roi2,pretime),2)-mean(b1(roi2,pretime),2);
top_bg = prctile(diff_bg,99);
bottom_bg = prctile(diff_bg,1);


figure
scatter(mean(b1(roi1,time1),2),mean(a1(roi1,time1),2))
hold on
xlim([0 .7]);ylim([0 .7])
plot(0:0.0001:.8,0:0.0001:.8)
axis square
ranksum(mean(b1(roi1,time1),2),mean(a1(roi1,time1),2))
plot((0:0.0001:.8),(0:0.0001:.8)+top_circ,'r')
plot((0:0.0001:.8),(0:0.0001:.8)+bottom_circ,'r')

figure
scatter(mean(b1(roi2,time1),2),mean(a1(roi2,time1),2))
hold on
xlim([0 0.7]);ylim([0 .7])
plot(0:0.0001:.8,0:0.0001:.8)
axis square
ranksum(mean(b1(roi2,time1),2),mean(a1(roi2,time1),2))
plot((0:0.0001:.8),(0:0.0001:.8)+top_bg,'r')
plot((0:0.0001:.8),(0:0.0001:.8)+bottom_bg,'r')


diff_circ=mean(a1(roi1,time1),2)-mean(b1(roi1,time1),2);
diff_bg=mean(a1(roi2,time1),2)-mean(b1(roi2,time1),2);
[n1 x1]=hist(diff_circ,-0.1:0.01:.2);
[n2 x2]=hist(diff_bg,-0.1:0.01:.2);
figure;bar(x1,[n1/size(diff_circ,1)]')
xlim([-0.1 0.15])
ylim([0 0.25])
figure;bar(x1,[n2/size(diff_bg,1)]')
xlim([-0.1 0.15])
ylim([0 0.25])

sum(diff_circ>top_circ)/size(diff_circ,1)
sum(diff_circ<bottom_circ)/size(diff_circ,1)
sum(diff_bg>top_bg)/size(diff_bg,1)
sum(diff_bg<bottom_bg)/size(diff_bg,1)


%% 2511d15
cd F:\Data\VSDI\Contour_integration\legolas\right_hemisphere\psychophysics\2008_11_25\d\correct_and_incorrect_together
load('corr_map_bg_for_figure4_ci_paper.mat')
roi1=roi_circ_fig5;
roi2=roi_bg_in4;
time1=28:33;
figure;mimg(mfilt2(mean(mean(a2(:,time1,:),2),3)-mean(mean(b2(:,time1,:),2),3),100,100,1.5,'lm'),100,100,-0.04,0.07);colormap(mapgeog)

pretime=16:18;
diff_circ=mean(a2(roi1,pretime),2)-mean(b2(roi1,pretime),2);
top_circ = prctile(diff_circ,99);
bottom_circ = prctile(diff_circ,1);
diff_bg=mean(a2(roi2,pretime),2)-mean(b2(roi2,pretime),2);
top_bg = prctile(diff_bg,99);
bottom_bg = prctile(diff_bg,1);



figure
scatter(mean(b2(roi1,time1),2),mean(a2(roi1,time1),2))
hold on
xlim([0 .4]);ylim([0 .4])
plot(0:0.0001:.8,0:0.0001:.8)
axis square
ranksum(mean(b2(roi1,time1),2),mean(a2(roi1,time1),2))
plot((0:0.0001:.8),(0:0.0001:.8)+top_circ,'r')
plot((0:0.0001:.8),(0:0.0001:.8)+bottom_circ,'r')


figure
scatter(mean(b2(roi2,time1),2),mean(a2(roi2,time1),2))
hold on
xlim([0 0.4]);ylim([0 .4])
plot(0:0.0001:.8,0:0.0001:.8)
axis square
ranksum(mean(b2(roi2,time1),2),mean(a2(roi2,time1),2))
plot((0:0.0001:.8),(0:0.0001:.8)+top_bg,'r')
plot((0:0.0001:.8),(0:0.0001:.8)+bottom_bg,'r')


diff_circ=mean(a2(roi1,time1),2)-mean(b2(roi1,time1),2);
diff_bg=mean(a2(roi2,time1),2)-mean(b2(roi2,time1),2);
[n1 x1]=hist(diff_circ,-0.15:0.01:.2);
[n2 x2]=hist(diff_bg,-0.15:0.01:.2);
figure;bar(x1,[n1/size(diff_circ,1)]')
xlim([-0.15 0.1])
ylim([0 0.2])
figure;bar(x1,[n2/size(diff_bg,1)]')
xlim([-0.15 0.1])
ylim([0 0.2])

sum(diff_circ>top_circ)/size(diff_circ,1)
sum(diff_circ<bottom_circ)/size(diff_circ,1)
sum(diff_bg>top_bg)/size(diff_bg,1)
sum(diff_bg<bottom_bg)/size(diff_bg,1)


%% 2912c1245
cd F:\Data\VSDI\Contour_integration\Smeagol\29Dec2010\c
load('circ_corr_maps_for_figure4_ci.mat')
roi1=roi_circle4;
roi2=roi_bg_out4;
time1=26:27;
figure;mimg(mfilt2(mean(a3(:,time1),2)-mean(b3(:,time1),2),100,100,1.5,'lm'),100,100,-0.01,0.045);colormap(mapgeog)

time1=26:28; %yes. one frame difference

pretime=16:18;
diff_circ=mean(a3(roi1,pretime),2)-mean(b3(roi1,pretime),2);
top_circ = prctile(diff_circ,99);
bottom_circ = prctile(diff_circ,1);
diff_bg=mean(a3(roi2,pretime),2)-mean(b3(roi2,pretime),2);
top_bg = prctile(diff_bg,99);
bottom_bg = prctile(diff_bg,1);


figure
scatter(mean(b3(roi1,time1),2),mean(a3(roi1,time1),2))
hold on
xlim([-.1 .5]);ylim([-.1 .5])
plot(-.1:0.0001:.8,-.1:0.0001:.8)
axis square
ranksum(mean(b3(roi1,time1),2),mean(a3(roi1,time1),2))
plot((-.2:0.0001:.8),(-.2:0.0001:.8)+top_circ,'r')
plot((-.2:0.0001:.8),(-.2:0.0001:.8)+bottom_circ,'r')


figure
scatter(mean(b3(roi2,time1),2),mean(a3(roi2,time1),2))
hold on
xlim([-.1 0.5]);ylim([-.1 .5])
plot(-.1:0.0001:.8,-.1:0.0001:.8)
axis square
ranksum(mean(b3(roi2,time1),2),mean(a3(roi2,time1),2))
plot((-.2:0.0001:.8),(-.2:0.0001:.8)+top_bg,'r')
plot((-.2:0.0001:.8),(-.2:0.0001:.8)+bottom_bg,'r')


diff_circ=mean(a3(roi1,time1),2)-mean(b3(roi1,time1),2);
diff_bg=mean(a3(roi2,time1),2)-mean(b3(roi2,time1),2);
[n1 x1]=hist(diff_circ,-0.1:0.01:.2);
[n2 x2]=hist(diff_bg,-0.1:0.01:.2);
figure;bar(x1,[n1/size(diff_circ,1)]')
xlim([-0.1 0.15])
ylim([0 0.2])
figure;bar(x1,[n2/size(diff_bg,1)]')
xlim([-0.1 0.15])
ylim([0 0.2])

sum(diff_circ>top_circ)/size(diff_circ,1)
sum(diff_circ<bottom_circ)/size(diff_circ,1)
sum(diff_bg>top_bg)/size(diff_bg,1)
sum(diff_bg<bottom_bg)/size(diff_bg,1)




%% 2912e1245
cd F:\Data\VSDI\Contour_integration\Smeagol\29Dec2010\e
load bg_corr_map_for_fig4_ci
roi1=roi_circle4;
roi2=roi_bg_out4;
time1=34:36;
figure;mimg(mfilt2(mean(a4(:,time1),2)-mean(b4(:,time1),2),100,100,1.5,'lm'),100,100,-0.04,0.04);colormap(mapgeog)

pretime=16:18;
diff_circ=mean(a4(roi1,pretime),2)-mean(b4(roi1,pretime),2);
top_circ = prctile(diff_circ,99);
bottom_circ = prctile(diff_circ,1);
diff_bg=mean(a4(roi2,pretime),2)-mean(b4(roi2,pretime),2);
top_bg = prctile(diff_bg,99);
bottom_bg = prctile(diff_bg,1);


figure
scatter(mean(b4(roi1,time1),2),mean(a4(roi1,time1),2))
hold on
xlim([-.1 .3]);ylim([-.1 .3])
plot(-.1:0.0001:.8,-.1:0.0001:.8)
axis square
ranksum(mean(b4(roi1,time1),2),mean(a4(roi1,time1),2))
plot((-.2:0.0001:.8),(-.2:0.0001:.8)+top_circ,'r')
plot((-.2:0.0001:.8),(-.2:0.0001:.8)+bottom_circ,'r')


figure
scatter(mean(b4(roi2,time1),2),mean(a4(roi2,time1),2))
hold on
xlim([-.1 0.3]);ylim([-.1 .3])
plot(-.1:0.0001:.8,-.1:0.0001:.8)
axis square
ranksum(mean(b4(roi2,time1),2),mean(a4(roi2,time1),2))
plot((-.2:0.0001:.8),(-.2:0.0001:.8)+top_bg,'r')
plot((-.2:0.0001:.8),(-.2:0.0001:.8)+bottom_bg,'r')


diff_circ=mean(a4(roi1,time1),2)-mean(b4(roi1,time1),2);
diff_bg=mean(a4(roi2,time1),2)-mean(b4(roi2,time1),2);
[n1 x1]=hist(diff_circ,-0.15:0.01:.2);
[n2 x2]=hist(diff_bg,-0.15:0.01:.2);
figure;bar(x1,[n1/size(diff_circ,1)]')
xlim([-0.15 0.1])
ylim([0 0.2])
figure;bar(x1,[n2/size(diff_bg,1)]')
xlim([-0.15 0.1])
ylim([0 0.2])

sum(diff_circ>top_circ)/size(diff_circ,1)
sum(diff_circ<bottom_circ)/size(diff_circ,1)
sum(diff_bg>top_bg)/size(diff_bg,1)
sum(diff_bg<bottom_bg)/size(diff_bg,1)




