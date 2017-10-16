cd F:\Data\VSDI\Contour_integration\Smeagol\29Dec2010
load linear_summation

linear_sum=(bg3+2*f1f2+tar);
figure;plot(-50:10:200,mean(non(roi_circ_middle,23:48)-1,1))
hold on
plot(-50:10:200,mean(linear_sum(roi_circ_middle,:),1),'r')
xlim([-20 200])


cd F:\Data\VSDI\Contour_integration\legolas\right_hemisphere\11_11_2008
load linear_summation
linear_sum=(tar+bg1+bg2+bg3+2*f1f2);
figure;plot(-50:10:200,mean(non(roi_tar,23:48)-1,1))
hold on
plot(-50:10:200,mean(linear_sum(roi_tar,23:48),1),'r')
xlim([-20 200])
% plot(-50:10:200,mean(bg1(roi_tar,23:48),1),'y')
% plot(-50:10:200,mean(bg2(roi_tar,23:48),1),'k')
% plot(-50:10:200,mean(bg3(roi_tar,23:48),1),'m')
% plot(-50:10:200,mean(f1f2(roi_tar,23:48),1),'g')
% plot(-50:10:200,mean(tar(roi_tar,23:48),1),'r')




