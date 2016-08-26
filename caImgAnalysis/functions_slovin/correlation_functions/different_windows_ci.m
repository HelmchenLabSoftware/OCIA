

%% 1111cd countour2
figure;plot(x8,mean(cont8(roi_contour2,:)-non8(roi_contour2,:),1),'g')
hold on
plot(x2,mean(cont2(roi_contour2,:)-non2(roi_contour2,:),1),'k')
plot(x4,mean(cont4(roi_contour2,:)-non4(roi_contour2,:),1),'b')
plot(x6,mean(cont6(roi_contour2,:)-non6(roi_contour2,:),1),'c')
plot(x16,mean(cont16(roi_contour2,:)-non16(roi_contour2,:),1),'y')
plot(x20,mean(cont20(roi_contour2,:)-non20(roi_contour2,:),1),'m')
plot(x40,mean(cont40(roi_contour2,:)-non40(roi_contour2,:),1),'r')
xlim([-100 250])
plot(x8,zeros(1,80),'k')
legend('Window 80 ms','Window 20 ms','Window 40 ms','Window 60 ms','Window 160 ms','Window 200 ms','Window 400 ms')
m=[max(mean(cont2(roi_contour2,1:40)-non2(roi_contour2,1:40),1)) max(mean(cont4(roi_contour2,1:40)-non4(roi_contour2,1:40),1)) max(mean(cont6(roi_contour2,1:40)-non6(roi_contour2,1:40),1)) ...
    max(mean(cont8(roi_contour2,1:40)-non8(roi_contour2,1:40),1)) max(mean(cont16(roi_contour2,1:40)-non16(roi_contour2,1:40),1)) ...
    max(mean(cont20(roi_contour2,1:40)-non20(roi_contour2,1:40),1)) max(mean(cont40(roi_contour2,1:40)-non40(roi_contour2,1:40),1))];

figure;plot([2 4 6 8 16 20 40],m)


s=[mean(std(cont2(roi_contour2,1:40)-non2(roi_contour2,1:40),0,1)) mean(std(cont4(roi_contour2,1:40)-non4(roi_contour2,1:40),0,1)) mean(std(cont6(roi_contour2,1:40)-non6(roi_contour2,1:40),0,1)) ...
    mean(std(cont8(roi_contour2,1:40)-non8(roi_contour2,1:40),0,1)) mean(std(cont16(roi_contour2,1:40)-non16(roi_contour2,1:40),0,1)) ...
    mean(std(cont20(roi_contour2,1:40)-non20(roi_contour2,1:40),0,1)) mean(std(cont40(roi_contour2,1:40)-non40(roi_contour2,1:40),0,1))];

figure;plot([2 4 6 8 16 20 40],s)


%% 2511d bg_in
figure;plot(x8,mean(cont8(roi_bg_in,:)-non8(roi_bg_in,:),1),'g')
hold on
plot(x2,mean(cont2(roi_bg_in,:)-non2(roi_bg_in,:),1),'k')
plot(x4,mean(cont4(roi_bg_in,:)-non4(roi_bg_in,:),1),'b')
plot(x6,mean(cont6(roi_bg_in,:)-non6(roi_bg_in,:),1),'c')
plot(x16,mean(cont16(roi_bg_in,:)-non16(roi_bg_in,:),1),'y')
plot(x20,mean(cont20(roi_bg_in,:)-non20(roi_bg_in,:),1),'m')
plot(x40,mean(cont40(roi_bg_in,:)-non40(roi_bg_in,:),1),'r')
xlim([-100 250])
plot(x8,zeros(1,80),'k')
legend('Window 80 ms','Window 20 ms','Window 40 ms','Window 60 ms','Window 160 ms','Window 200 ms','Window 400 ms')


m=[min(mean(cont2(roi_bg_in,1:40)-non2(roi_bg_in,1:40),1)) min(mean(cont4(roi_bg_in,1:40)-non4(roi_bg_in,1:40),1)) min(mean(cont6(roi_bg_in,1:40)-non6(roi_bg_in,1:40),1)) ...
    min(mean(cont8(roi_bg_in,1:40)-non8(roi_bg_in,1:40),1)) min(mean(cont16(roi_bg_in,1:40)-non16(roi_bg_in,1:40),1)) ...
    min(mean(cont20(roi_bg_in,1:40)-non20(roi_bg_in,1:40),1)) min(mean(cont40(roi_bg_in,1:40)-non40(roi_bg_in,1:40),1))];

figure;plot([2 4 6 8 16 20 40],m)


s=[mean(std(cont2(roi_bg_in,1:40)-non2(roi_bg_in,1:40),0,1)) mean(std(cont4(roi_bg_in,1:40)-non4(roi_bg_in,1:40),0,1)) mean(std(cont6(roi_bg_in,1:40)-non6(roi_bg_in,1:40),0,1)) ...
    mean(std(cont8(roi_bg_in,1:40)-non8(roi_bg_in,1:40),0,1)) mean(std(cont16(roi_bg_in,1:40)-non16(roi_bg_in,1:40),0,1)) ...
    mean(std(cont20(roi_bg_in,1:40)-non20(roi_bg_in,1:40),0,1)) mean(std(cont40(roi_bg_in,1:40)-non40(roi_bg_in,1:40),0,1))];

figure;plot([2 4 6 8 16 20 40],s)



%% 2912 circle

figure;plot(x8,mean(cont8(roi_circle,:)-non8(roi_circle,:),1),'g')
hold on
plot(x2,mean(cont2(roi_circle,:)-non2(roi_circle,:),1),'k')
plot(x4,mean(cont4(roi_circle,:)-non4(roi_circle,:),1),'b')
plot(x6,mean(cont6(roi_circle,:)-non6(roi_circle,:),1),'c')
plot(x16,mean(cont16(roi_circle,:)-non16(roi_circle,:),1),'y')
plot(x20,mean(cont20(roi_circle,:)-non20(roi_circle,:),1),'m')
plot(x40,mean(cont40(roi_circle,:)-non40(roi_circle,:),1),'r')
xlim([-100 250])
plot(x8,zeros(1,80),'k')
legend('Window 80 ms','Window 20 ms','Window 40 ms','Window 60 ms','Window 160 ms','Window 200 ms','Window 400 ms')


m=[max(mean(cont2(roi_circle,1:40)-non2(roi_circle,1:40),1)) max(mean(cont4(roi_circle,1:40)-non4(roi_circle,1:40),1)) max(mean(cont6(roi_circle,1:40)-non6(roi_circle,1:40),1)) ...
    max(mean(cont8(roi_circle,1:40)-non8(roi_circle,1:40),1)) max(mean(cont16(roi_circle,1:40)-non16(roi_circle,1:40),1)) ...
    max(mean(cont20(roi_circle,1:40)-non20(roi_circle,1:40),1)) max(mean(cont40(roi_circle,1:40)-non40(roi_circle,1:40),1))];

figure;plot([2 4 6 8 16 20 40],m)


s=[mean(std(cont2(roi_circle,1:40)-non2(roi_circle,1:40),0,1)) mean(std(cont4(roi_circle,1:40)-non4(roi_circle,1:40),0,1)) mean(std(cont6(roi_circle,1:40)-non6(roi_circle,1:40),0,1)) ...
    mean(std(cont8(roi_circle,1:40)-non8(roi_circle,1:40),0,1)) mean(std(cont16(roi_circle,1:40)-non16(roi_circle,1:40),0,1)) ...
    mean(std(cont20(roi_circle,1:40)-non20(roi_circle,1:40),0,1)) mean(std(cont40(roi_circle,1:40)-non40(roi_circle,1:40),0,1))];

figure;plot([2 4 6 8 16 20 40],s)


%% 2912e bg out
figure;plot(x8,mean(cont8(roi_bg_out,:)-non8(roi_bg_out,:),1),'g')
hold on
plot(x2,mean(cont2(roi_bg_out,:)-non2(roi_bg_out,:),1),'k')
plot(x4,mean(cont4(roi_bg_out,:)-non4(roi_bg_out,:),1),'b')
plot(x6,mean(cont6(roi_bg_out,:)-non6(roi_bg_out,:),1),'c')
plot(x16,mean(cont16(roi_bg_out,:)-non16(roi_bg_out,:),1),'y')
plot(x20,mean(cont20(roi_bg_out,:)-non20(roi_bg_out,:),1),'m')
plot(x40,mean(cont40(roi_bg_out,:)-non40(roi_bg_out,:),1),'r')
xlim([-100 250])
plot(x8,zeros(1,80),'k')
legend('Window 80 ms','Window 20 ms','Window 40 ms','Window 60 ms','Window 160 ms','Window 200 ms','Window 400 ms')


m=[min(mean(cont2(roi_bg_out,1:40)-non2(roi_bg_out,1:40),1)) min(mean(cont4(roi_bg_out,1:40)-non4(roi_bg_out,1:40),1)) min(mean(cont6(roi_bg_out,1:40)-non6(roi_bg_out,1:40),1)) ...
    min(mean(cont8(roi_bg_out,1:40)-non8(roi_bg_out,1:40),1)) min(mean(cont16(roi_bg_out,1:40)-non16(roi_bg_out,1:40),1)) ...
    min(mean(cont20(roi_bg_out,1:40)-non20(roi_bg_out,1:40),1)) min(mean(cont40(roi_bg_out,1:40)-non40(roi_bg_out,1:40),1))];

figure;plot([2 4 6 8 16 20 40],m)


s=[mean(std(cont2(roi_bg_out,1:40)-non2(roi_bg_out,1:40),0,1)) mean(std(cont4(roi_bg_out,1:40)-non4(roi_bg_out,1:40),0,1)) mean(std(cont6(roi_bg_out,1:40)-non6(roi_bg_out,1:40),0,1)) ...
    mean(std(cont8(roi_bg_out,1:40)-non8(roi_bg_out,1:40),0,1)) mean(std(cont16(roi_bg_out,1:40)-non16(roi_bg_out,1:40),0,1)) ...
    mean(std(cont20(roi_bg_out,1:40)-non20(roi_bg_out,1:40),0,1)) mean(std(cont40(roi_bg_out,1:40)-non40(roi_bg_out,1:40),0,1))];

figure;plot([2 4 6 8 16 20 40],s)

