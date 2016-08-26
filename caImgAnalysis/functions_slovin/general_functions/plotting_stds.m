

figure;plot(std(a(roi_contour2,2:112),0,1))
hold on
plot(std(b(roi_contour2,2:112),0,1),'r')


figure;plot(std(a(roi_maskin,2:112),0,1))
hold on
plot(std(b(roi_maskin,2:112),0,1),'r')

diff=a-b;

figure;plot(std(diff(roi_contour2,2:112),0,1))
hold on
plot(std(diff(roi_maskin,2:112),0,1),'r')


figure;plot(std(a(bar_circ_index,2:112),0,1))
hold on
plot(std(b(bar_circ_index,2:112),0,1),'r')

figure;plot(std(a(bar_bg_index,2:112),0,1))
hold on
plot(std(b(bar_bg_index,2:112),0,1),'r')


