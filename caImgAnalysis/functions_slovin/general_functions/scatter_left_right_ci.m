




%0501c 10 degrees
a=mean(cond2n_dt_bl_right,3)-1;
b=mean(cond2n_dt_bl_left,3)-1;

time=43:48;
roi1=roi_circle3;
roi2=roi_bg_out2;


figure;
scatter(mean(b(roi1,time),2),mean(a(roi1,time),2))
xlim([0e-3 2e-3]);ylim([0e-3 2e-3])
axis square
hold on
plot(0:0.0001:2e-3,0:0.0001:2e-3,'k')
ranksum(mean(b(roi1,time),2),mean(a(roi1,time),2))


figure;
scatter(mean(b(roi2,time),2),mean(a(roi2,time),2))
xlim([0e-3 2e-3]);ylim([0e-3 2e-3])
axis square
hold on
plot(0:0.0001:2e-3,0:0.0001:2e-3,'k')
ranksum(mean(b(roi2,time),2),mean(a(roi2,time),2))





%2511d 15 degrees
a=mean(cond4n_dt_bl_right,3)-1;
b=mean(cond4n_dt_bl_left,3)-1;

time=43:53;
roi1=roi_circ_fig5;
roi2=roi_bg_in_fig5;


figure;
scatter(mean(b(roi1,time),2),mean(a(roi1,time),2))
xlim([0e-3 2e-3]);ylim([0e-3 2e-3])
axis square
hold on
plot(0:0.0001:2e-3,0:0.0001:2e-3,'k')
ranksum(mean(b(roi1,time),2),mean(a(roi1,time),2))


figure;
scatter(mean(b(roi2,time),2),mean(a(roi2,time),2))
xlim([0e-3 2e-3]);ylim([0e-3 2e-3])
axis square
hold on
plot(0:0.0001:2e-3,0:0.0001:2e-3,'k')
ranksum(mean(b(roi2,time),2),mean(a(roi2,time),2))







%1811c 15 degrees
a=mean(cond4n_dt_bl_right,3)-1;
b=mean(cond4n_dt_bl_left,3)-1;

time=43:48;
roi1=roi_contour;
roi2=roi_bg_in;


figure;
scatter(mean(b(roi1,time),2),mean(a(roi1,time),2))
xlim([0e-3 2e-3]);ylim([0e-3 2e-3])
axis square
hold on
plot(0:0.0001:2e-3,0:0.0001:2e-3,'k')
ranksum(mean(b(roi1,time),2),mean(a(roi1,time),2))


figure;
scatter(mean(b(roi2,time),2),mean(a(roi2,time),2))
xlim([0e-3 2e-3]);ylim([0e-3 2e-3])
axis square
hold on
plot(0:0.0001:2e-3,0:0.0001:2e-3,'k')
ranksum(mean(b(roi2,time),2),mean(a(roi2,time),2))





%1203d 15 degrees
a=mean(cond2n_dt_bl_right,3)-1;
b=mean(cond2n_dt_bl_left,3)-1;

time=43:53;
roi1=roi_contour;
roi2=roi_bg_in;


figure;
scatter(mean(b(roi1,time),2),mean(a(roi1,time),2))
xlim([0e-3 2e-3]);ylim([0e-3 2e-3])
axis square
hold on
plot(0:0.0001:2e-3,0:0.0001:2e-3,'k')
ranksum(mean(b(roi1,time),2),mean(a(roi1,time),2))


figure;
scatter(mean(b(roi2,time),2),mean(a(roi2,time),2))
xlim([0e-3 2e-3]);ylim([0e-3 2e-3])
axis square
hold on
plot(0:0.0001:2e-3,0:0.0001:2e-3,'k')
ranksum(mean(b(roi2,time),2),mean(a(roi2,time),2))









