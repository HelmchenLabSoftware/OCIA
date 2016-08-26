
roi1=roi_maskin;
roi2=roi_contour2;
time1=34:36;
time2=49:51;


figure
scatter(mean(b(roi1,time1),2)-1,mean(a(roi1,time1),2)-1)
hold on
xlim([0 2e-3]);ylim([0 2e-3])
plot(0:0.0001:2e-3,0:0.0001:2e-3)
ranksum(mean(b(roi1,time1),2)-1,mean(a(roi1,time1),2)-1)
title('Circle stage 1')


figure
scatter(mean(b(roi2,time1),2)-1,mean(a(roi2,time1),2)-1)
hold on
xlim([0 2e-3]);ylim([0 2e-3])
plot(0:0.0001:2e-3,0:0.0001:2e-3)
ranksum(mean(b(roi2,time1),2)-1,mean(a(roi2,time1),2)-1)
title('bg stage 1')


figure
scatter(mean(b(roi1,time2),2)-1,mean(a(roi1,time2),2)-1)
hold on
xlim([0 2e-3]);ylim([0 2e-3])
plot(0:0.0001:2e-3,0:0.0001:2e-3)
ranksum(mean(b(roi1,time2),2)-1,mean(a(roi1,time2),2)-1)
title('Circle stage 2')


figure
scatter(mean(b(roi2,time2),2)-1,mean(a(roi2,time2),2)-1)
hold on
xlim([0 2e-3]);ylim([0 2e-3])
plot(0:0.0001:2e-3,0:0.0001:2e-3)
ranksum(mean(b(roi2,time2),2)-1,mean(a(roi2,time2),2)-1)
title('bg stage 2')



