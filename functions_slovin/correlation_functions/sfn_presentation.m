

x=(10:10:1120)-230;
subplot(4,1,1)
plot(x,mean(a(roi_maskout,2:112),1));
hold on
plot(x,mean(b(roi_maskout,2:112),1),'r');
plot(x,mean(c(roi_maskout,2:112),1),'g');

xlim([-100 400])
ylabel('Correlation of coefficient')
ylim([-.1 .4])

load time_final
x=(10:10:1110)-270;

subplot(4,1,4)
plot(x,mean(a(roi_maskin,2:112),1)-1);
hold on
plot(x,mean(b(roi_maskin,2:112),1)-1,'r');
xlim([-100 400])
ylim([-0.1e-3 1e-3])


subplot(4,1,3)
plot(x,mean(a(roi_f2,2:112),1)-1);
hold on
plot(x,mean(b(roi_f2,2:112),1)-1,'r');
xlim([-100 400])
ylabel('\DeltaF/F')
ylim([-0.1e-3 0.8e-3])
xlabel('Time (ms)')

subplot(4,1,2)
plot(x,mean(a(roi_maskout,2:112),1)-1);
hold on
plot(x,mean(b(roi_maskout,2:112),1)-1,'r');
xlim([-100 800])

legend('Contour','Non-contour','Blank')
ylim([-0.1e-3 1e-3])




figure;
scatter(mean(b(roi_contour2,42:45),2),mean(a(roi_contour2,42:45),2),16);
hold on
plot(-.15:0.01:0.9,-.15:0.01:0.9,'k')
xlim([-.15 0.8]);ylim([-.15 0.8]);


figure;
scatter(mean(b(roi_maskin,42:45),2),mean(a(roi_maskin,42:45),2),16);
hold on
plot(-0.15:0.01:0.9,-0.15:0.01:0.9,'k')
xlim([-0.15 0.3]);ylim([-0.15 0.3]);

figure;
scatter(mean(b(roi_contour,42:45),2),mean(a(roi_contour,42:45),2),16);
hold on
plot(-0.15:0.01:0.9,-0.15:0.01:0.9,'k')
xlim([-0.15 0.8]);ylim([-0.15 0.8]);

figure;
scatter(mean(b(roi_V2,42:45),2),mean(a(roi_V2,42:45),2),16);
hold on
plot(-0.1:0.01:0.9,-0.1:0.01:0.9,'k')
xlim([-0.1 0.8]);ylim([-0.1 0.8]);


figure;
scatter(mean(b(roi_f1late,50:57),2),mean(a(roi_f1late,50:57),2),16);
hold on
plot(-0.1:0.01:0.9,-0.1:0.01:0.9,'k')
xlim([-0.1 0.25]);ylim([-0.1 0.25]);

[n]=hist(mean(a(roi_contour2,50:57),2),0:0.03:0.3);
[m]=hist(mean(b(roi_contour2,50:57),2),0:0.03:0.3);
bar(0:0.03:0.3,[n;m]')

[n]=hist(mean(a(roi_maskin,50:57),2),0:0.03:0.3);
[m]=hist(mean(b(roi_maskin,50:57),2),0:0.03:0.3);
bar(0:0.03:0.3,[n;m]')

con_gabor=zeros(18,1);
con_con=zeros(18,1);
con_bgin=zeros(18,1);
con_bgout=zeros(18,1);


bgin_gabor=zeros(16,1);
bgin_con=zeros(16,1);
bgin_bgin=zeros(16,1);
bgin_bgout=zeros(16,1);



con_gabor(1)=cc1111c(1,1);
con_gabor(2)=cc1111d(1,1);
con_gabor(3)=cc1111h(1,1);
con_gabor(4)=cc0610e(1,1);
con_gabor(5)=cc0610f(1,1);
con_gabor(6)=cc2210d(1,1);
con_gabor(7)=cc2210e(1,1);
con_gabor(8)=cc1811c(1,1);
con_gabor(9)=cc1811d(1,1);
con_gabor(10)=cc1811e(1,1);
con_gabor(11)=cc2511d(1,1);
con_gabor(12)=cc2511e(1,1);
con_gabor(13)=cc2511f(1,1);
con_gabor(14)=cc1203d(1,1);
con_gabor(15)=cc1203e(1,1);
con_gabor(16)=cc1203f(1,1);
con_gabor(17)=cc0601e(1,1);
con_gabor(18)=cc0601fg(1,1);


con_con(1)=cc1111c(1,2);
con_con(2)=cc1111d(1,2);
con_con(3)=cc1111h(1,2);
con_con(4)=cc0610e(1,2);
con_con(5)=cc0610f(1,2);
con_con(6)=cc2210d(1,2);
con_con(7)=cc2210e(1,2);
con_con(8)=cc1811c(1,2);
con_con(9)=cc1811d(1,2);
con_con(10)=cc1811e(1,2);
con_con(11)=cc2511d(1,2);
con_con(12)=cc2511e(1,2);
con_con(13)=cc2511f(1,2);
con_con(14)=cc1203d(1,2);
con_con(15)=cc1203e(1,2);
con_con(16)=cc1203f(1,2);
con_con(17)=cc0601e(1,2);
con_con(18)=cc0601fg(1,2);



con_bgin(1)=cc1111c(1,3);
con_bgin(2)=cc1111d(1,3);
con_bgin(3)=cc1111h(1,3);
con_bgin(4)=cc0610e(1,3);
con_bgin(5)=cc0610f(1,3);
con_bgin(6)=cc2210d(1,3);
con_bgin(7)=cc2210e(1,3);
con_bgin(8)=cc1811c(1,3);
con_bgin(9)=cc1811d(1,3);
con_bgin(10)=cc1811e(1,3);
con_bgin(11)=cc2511d(1,3);
con_bgin(12)=cc2511e(1,3);
con_bgin(13)=cc2511f(1,3);
con_bgin(14)=cc1203d(1,3);
con_bgin(15)=cc1203e(1,3);
con_bgin(16)=cc1203f(1,3);
con_bgin(17)=cc0601e(1,3);
con_bgin(18)=cc0601fg(1,3);


con_bgout(1)=cc1111c(1,4);
con_bgout(2)=cc1111d(1,4);
con_bgout(3)=cc1111h(1,4);
con_bgout(4)=cc0610e(1,4);
con_bgout(5)=cc0610f(1,4);
con_bgout(6)=cc2210d(1,4);
con_bgout(7)=cc2210e(1,4);
con_bgout(8)=cc1811c(1,4);
con_bgout(9)=cc1811d(1,4);
con_bgout(10)=cc1811e(1,4);
con_bgout(11)=cc2511d(1,4);
con_bgout(12)=cc2511e(1,4);
con_bgout(13)=cc2511f(1,4);
con_bgout(14)=cc1203d(1,4);
con_bgout(15)=cc1203e(1,4);
con_bgout(16)=cc1203f(1,4);
con_bgout(17)=cc0601e(1,4);
con_bgout(18)=cc0601fg(1,4);



bgin_gabor(1)=cc1111c(2,1);
bgin_gabor(2)=cc1111d(2,1);
bgin_gabor(3)=cc1111h(2,1);
bgin_gabor(4)=cc0610e(2,1);
bgin_gabor(5)=cc0610f(2,1);
bgin_gabor(6)=cc2210d(2,1);
bgin_gabor(7)=cc2210e(2,1);
bgin_gabor(8)=cc1811c(2,1);
bgin_gabor(9)=cc1811d(2,1);
bgin_gabor(10)=cc1811e(2,1);
bgin_gabor(11)=cc2511d(2,1);
bgin_gabor(12)=cc2511e(2,1);
bgin_gabor(13)=cc2511f(2,1);
bgin_gabor(14)=cc1203d(2,1);
bgin_gabor(15)=cc1203e(2,1);
bgin_gabor(16)=cc1203f(2,1);
bgin_gabor(17)=cc0601e(2,1);
bgin_gabor(18)=cc0601fg(2,1);





bgin_con(1)=cc1111c(2,2);
bgin_con(2)=cc1111d(2,2);
bgin_con(3)=cc1111h(2,2);
bgin_con(4)=cc0610e(2,2);
bgin_con(5)=cc0610f(2,2);
bgin_con(6)=cc2210d(2,2);
bgin_con(7)=cc2210e(2,2);
bgin_con(8)=cc1811c(2,2);
bgin_con(9)=cc1811d(2,2);
bgin_con(10)=cc1811e(2,2);
bgin_con(11)=cc2511d(2,2);
bgin_con(12)=cc2511e(2,2);
bgin_con(13)=cc2511f(2,2);
bgin_con(14)=cc1203d(2,2);
bgin_con(15)=cc1203e(2,2);
bgin_con(16)=cc1203f(2,2);
bgin_con(17)=cc0601e(2,2);
bgin_con(18)=cc0601fg(2,2);



bgin_bgin(1)=cc1111c(2,3);
bgin_bgin(2)=cc1111d(2,3);
bgin_bgin(3)=cc1111h(2,3);
bgin_bgin(4)=cc0610e(2,3);
bgin_bgin(5)=cc0610f(2,3);
bgin_bgin(6)=cc2210d(2,3);
bgin_bgin(7)=cc2210e(2,3);
bgin_bgin(8)=cc1811c(2,3);
bgin_bgin(9)=cc1811d(2,3);
bgin_bgin(10)=cc1811e(2,3);
bgin_bgin(11)=cc2511d(2,3);
bgin_bgin(12)=cc2511e(2,3);
bgin_bgin(13)=cc2511f(2,3);
bgin_bgin(14)=cc1203d(2,3);
bgin_bgin(15)=cc1203e(2,3);
bgin_bgin(16)=cc1203f(2,3);
bgin_bgin(17)=cc0601e(2,3);
bgin_bgin(18)=cc0601fg(2,3);



bgin_bgout(1)=cc1111c(2,4);
bgin_bgout(2)=cc1111d(2,4);
bgin_bgout(3)=cc1111h(2,4);
bgin_bgout(4)=cc0610e(2,4);
bgin_bgout(5)=cc0610f(2,4);
bgin_bgout(6)=cc2210d(2,4);
bgin_bgout(7)=cc2210e(2,4);
bgin_bgout(8)=cc1811c(2,4);
bgin_bgout(9)=cc1811d(2,4);
bgin_bgout(10)=cc1811e(2,4);
bgin_bgout(11)=cc2511d(2,4);
bgin_bgout(12)=cc2511e(2,4);
bgin_bgout(13)=cc2511f(2,4);
bgin_bgout(14)=cc1203d(2,4);
bgin_bgout(15)=cc1203e(2,4);
bgin_bgout(16)=cc1203f(2,4);
bgin_bgout(17)=cc0601e(2,4);
bgin_bgout(18)=cc0601fg(2,4);


cc=[con_gabor con_con con_bgin con_bgout bgin_gabor bgin_con bgin_bgin bgin_bgout];


