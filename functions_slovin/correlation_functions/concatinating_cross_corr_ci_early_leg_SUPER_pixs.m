
cd F:\Data\VSDI\Contour_integration\legolas\right_hemisphere\11_11_2008\c\elhanan_new
load crv_contour2_cond1_superpix_w4
load crv_contour2_cond2_superpix_w4
load crv_contour2_cond4_superpix_w4
load crv_contour2_cond5_superpix_w4
crv_cont_circ=mean(crv_cond1,1)';
crv_cont_circ=cat(2,crv_cont_circ,mean(crv_cond2,1)');
crv_non_circ=mean(crv_cond4,1)';
crv_non_circ=cat(2,crv_non_circ,mean(crv_cond5,1)');
clear crv_cond1
clear crv_cond2
clear crv_cond4
clear crv_cond5

load crv_roi_maskin_cond1_superpix_w4
load crv_roi_maskin_cond2_superpix_w4
load crv_roi_maskin_cond4_superpix_w4
load crv_roi_maskin_cond5_superpix_w4
crv_cont_bg=mean(crv_cond1,1)';
crv_cont_bg=cat(2,crv_cont_bg,mean(crv_cond2,1)');
crv_non_bg=mean(crv_cond4,1)';
crv_non_bg=cat(2,crv_non_bg,mean(crv_cond5,1)');
clear crv_cond1
clear crv_cond2
clear crv_cond4
clear crv_cond5


cd F:\Data\VSDI\Contour_integration\legolas\right_hemisphere\11_11_2008\d\elhanan_new
load crv_contour2_cond1_superpix_w4
load crv_contour2_cond2_superpix_w4
load crv_contour2_cond4_superpix_w4
load crv_contour2_cond5_superpix_w4
crv_cont_circ=cat(2,crv_cont_circ,mean(crv_cond1,1)');
crv_cont_circ=cat(2,crv_cont_circ,mean(crv_cond2,1)');
crv_non_circ=cat(2,crv_non_circ,mean(crv_cond4,1)');
crv_non_circ=cat(2,crv_non_circ,mean(crv_cond5,1)');
clear crv_cond1
clear crv_cond2
clear crv_cond4
clear crv_cond5

load crv_roi_maskin_cond1_superpix_w4
load crv_roi_maskin_cond2_superpix_w4
load crv_roi_maskin_cond4_superpix_w4
load crv_roi_maskin_cond5_superpix_w4
crv_cont_bg=cat(2,crv_cont_bg,mean(crv_cond1,1)');
crv_cont_bg=cat(2,crv_cont_bg,mean(crv_cond2,1)');
crv_non_bg=cat(2,crv_non_bg,mean(crv_cond4,1)');
crv_non_bg=cat(2,crv_non_bg,mean(crv_cond5,1)');
clear crv_cond1
clear crv_cond2
clear crv_cond4
clear crv_cond5



cd F:\Data\VSDI\Contour_integration\legolas\right_hemisphere\psychophysics\2008_11_18\c\correct_and_incorrect_together
load crv_circle_diff_cond1_superpix_w4
load crv_circle_diff_cond5_superpix_w4
crv_cont_circ=cat(2,crv_cont_circ,mean(crv_cond1,1)');
crv_non_circ=cat(2,crv_non_circ,mean(crv_cond5,1)');
clear crv_cond1
clear crv_cond5

load crv_roi_bg_in_cond1_superpix_w4
load crv_roi_bg_in_cond5_superpix_w4
crv_cont_bg=cat(2,crv_cont_bg,mean(crv_cond1,1)');
crv_non_bg=cat(2,crv_non_bg,mean(crv_cond5,1)');
clear crv_cond1
clear crv_cond5


cd F:\Data\VSDI\Contour_integration\legolas\right_hemisphere\psychophysics\2008_11_18\d\correct_and_incorrect_together
load crv_circle_diff_cond1_superpix_w4
load crv_circle_diff_cond5_superpix_w4
crv_cont_circ=cat(2,crv_cont_circ,mean(crv_cond1,1)');
crv_non_circ=cat(2,crv_non_circ,mean(crv_cond5,1)');
clear crv_cond1
clear crv_cond5

load crv_roi_bg_in_narrow_cond1_superpix_w4
load crv_roi_bg_in_narrow_cond5_superpix_w4
crv_cont_bg=cat(2,crv_cont_bg,mean(crv_cond1,1)');
crv_non_bg=cat(2,crv_non_bg,mean(crv_cond5,1)');
clear crv_cond1
clear crv_cond5

cd F:\Data\VSDI\Contour_integration\legolas\right_hemisphere\psychophysics\2008_11_18\e\correct_and_incorrect_together
load crv_circle_diff_cond1_superpix_w4
load crv_circle_diff_cond5_superpix_w4
crv_cont_circ=cat(2,crv_cont_circ,mean(crv_cond1,1)');
crv_non_circ=cat(2,crv_non_circ,mean(crv_cond5,1)');
clear crv_cond1
clear crv_cond5

load crv_roi_bg_in_narrow_cond1_superpix_w4
load crv_roi_bg_in_narrow_cond5_superpix_w4
crv_cont_bg=cat(2,crv_cont_bg,mean(crv_cond1,1)');
crv_non_bg=cat(2,crv_non_bg,mean(crv_cond5,1)');
clear crv_cond1
clear crv_cond5



cd F:\Data\VSDI\Contour_integration\legolas\right_hemisphere\psychophysics\2008_11_25\d\correct_and_incorrect_together
load crv_circle_diff_cond1_superpix_w4
load crv_circle_diff_cond5_superpix_w4
crv_cont_circ=cat(2,crv_cont_circ,mean(crv_cond1,1)');
crv_non_circ=cat(2,crv_non_circ,mean(crv_cond5,1)');
clear crv_cond1
clear crv_cond5

load crv_roi_bg_in_narrow_cond1_superpix_w4
load crv_roi_bg_in_narrow_cond5_superpix_w4
crv_cont_bg=cat(2,crv_cont_bg,mean(crv_cond1,1)');
crv_non_bg=cat(2,crv_non_bg,mean(crv_cond5,1)');
clear crv_cond1
clear crv_cond5

cd F:\Data\VSDI\Contour_integration\legolas\right_hemisphere\psychophysics\2008_11_25\e\correct_and_incorrect_together

load crv_circle_diff_cond1_superpix_w4
load crv_circle_diff_cond5_superpix_w4
crv_cont_circ=cat(2,crv_cont_circ,mean(crv_cond1,1)');
crv_non_circ=cat(2,crv_non_circ,mean(crv_cond5,1)');
clear crv_cond1
clear crv_cond5

load crv_roi_bg_in_narrow_cond1_superpix_w4
load crv_roi_bg_in_narrow_cond5_superpix_w4
crv_cont_bg=cat(2,crv_cont_bg,mean(crv_cond1,1)');
crv_non_bg=cat(2,crv_non_bg,mean(crv_cond5,1)');
clear crv_cond1
clear crv_cond5

cd F:\Data\VSDI\Contour_integration\legolas\right_hemisphere\psychophysics\2008_11_25\f\correct_and_incorrect_together

load crv_circle_diff_cond1_superpix_w4
load crv_circle_diff_cond5_superpix_w4
crv_cont_circ=cat(2,crv_cont_circ,mean(crv_cond1,1)');
crv_non_circ=cat(2,crv_non_circ,mean(crv_cond5,1)');
clear crv_cond1
clear crv_cond5

load crv_roi_bg_in_narrow_cond1_superpix_w4
load crv_roi_bg_in_narrow_cond5_superpix_w4
crv_cont_bg=cat(2,crv_cont_bg,mean(crv_cond1,1)');
crv_non_bg=cat(2,crv_non_bg,mean(crv_cond5,1)');
clear crv_cond1
clear crv_cond5



cd F:\Data\VSDI\Contour_integration\legolas\right_hemisphere\psychophysics\2008_12_03\d\correct_and_incorrect_together

load crv_circle_diff_cond1_superpix_w4
load crv_circle_diff_cond5_superpix_w4
crv_cont_circ=cat(2,crv_cont_circ,mean(crv_cond1,1)');
crv_non_circ=cat(2,crv_non_circ,mean(crv_cond5,1)');
clear crv_cond1
clear crv_cond5

load crv_roi_bg_in_narrow_cond1_superpix_w4
load crv_roi_bg_in_narrow_cond5_superpix_w4
crv_cont_bg=cat(2,crv_cont_bg,mean(crv_cond1,1)');
crv_non_bg=cat(2,crv_non_bg,mean(crv_cond5,1)');
clear crv_cond1
clear crv_cond5

cd F:\Data\VSDI\Contour_integration\legolas\right_hemisphere\psychophysics\2008_12_03\e\correct_and_incorrect_together

load crv_circle_diff_cond1_superpix_w4
load crv_circle_diff_cond5_superpix_w4
crv_cont_circ=cat(2,crv_cont_circ,mean(crv_cond1,1)');
crv_non_circ=cat(2,crv_non_circ,mean(crv_cond5,1)');
clear crv_cond1
clear crv_cond5

load crv_roi_bg_in_narrow_cond1_superpix_w4
load crv_roi_bg_in_narrow_cond5_superpix_w4
crv_cont_bg=cat(2,crv_cont_bg,mean(crv_cond1,1)');
crv_non_bg=cat(2,crv_non_bg,mean(crv_cond5,1)');
clear crv_cond1
clear crv_cond5

cd F:\Data\VSDI\Contour_integration\legolas\right_hemisphere\psychophysics\2008_12_03\f\correct_and_incorrect_together

load crv_circle_diff_cond1_superpix_w4
load crv_circle_diff_cond5_superpix_w4
crv_cont_circ=cat(2,crv_cont_circ,mean(crv_cond1,1)');
crv_non_circ=cat(2,crv_non_circ,mean(crv_cond5,1)');
clear crv_cond1
clear crv_cond5

load crv_roi_bg_in_narrow_cond1_superpix_w4
load crv_roi_bg_in_narrow_cond5_superpix_w4
crv_cont_bg=cat(2,crv_cont_bg,mean(crv_cond1,1)');
crv_non_bg=cat(2,crv_non_bg,mean(crv_cond5,1)');
clear crv_cond1
clear crv_cond5



cd F:\Data\VSDI\Contour_integration\legolas\right_hemisphere\11_11_2008\h
load crv_contour_cond1_superpix_w4
load crv_contour_cond2_superpix_w4
load crv_contour_cond4_superpix_w4
load crv_contour_cond5_superpix_w4
crv_cont_circ=cat(2,crv_cont_circ,mean(crv_cond1,1)');
crv_cont_circ=cat(2,crv_cont_circ,mean(crv_cond2,1)');
crv_non_circ=cat(2,crv_non_circ,mean(crv_cond4,1)');
crv_non_circ=cat(2,crv_non_circ,mean(crv_cond5,1)');
clear crv_cond1
clear crv_cond2
clear crv_cond4
clear crv_cond5

load crv_roi_maskin_cond1_superpix_w4
load crv_roi_maskin_cond2_superpix_w4
load crv_roi_maskin_cond4_superpix_w4
load crv_roi_maskin_cond5_superpix_w4
crv_cont_bg=cat(2,crv_cont_bg,mean(crv_cond1,1)');
crv_cont_bg=cat(2,crv_cont_bg,mean(crv_cond2,1)');
crv_non_bg=cat(2,crv_non_bg,mean(crv_cond4,1)');
crv_non_bg=cat(2,crv_non_bg,mean(crv_cond5,1)');
clear crv_cond1
clear crv_cond2
clear crv_cond4
clear crv_cond5




cd F:\Data\VSDI\Contour_integration\legolas\right_hemisphere\06_10_2008\e
load crv_circle_diff_cond1_superpix_w4
load crv_circle_diff_cond2_superpix_w4
load crv_circle_diff_cond4_superpix_w4
load crv_circle_diff_cond5_superpix_w4
crv_cont_circ=cat(2,crv_cont_circ,mean(crv_cond1,1)');
crv_cont_circ=cat(2,crv_cont_circ,mean(crv_cond2,1)');
crv_non_circ=cat(2,crv_non_circ,mean(crv_cond4,1)');
crv_non_circ=cat(2,crv_non_circ,mean(crv_cond5,1)');
clear crv_cond1
clear crv_cond2
clear crv_cond4
clear crv_cond5

load crv_roi_bg_in_narrow_cond1_superpix_w4
load crv_roi_bg_in_narrow_cond2_superpix_w4
load crv_roi_bg_in_narrow_cond4_superpix_w4
load crv_roi_bg_in_narrow_cond5_superpix_w4
crv_cont_bg=cat(2,crv_cont_bg,mean(crv_cond1,1)');
crv_cont_bg=cat(2,crv_cont_bg,mean(crv_cond2,1)');
crv_non_bg=cat(2,crv_non_bg,mean(crv_cond4,1)');
crv_non_bg=cat(2,crv_non_bg,mean(crv_cond5,1)');
clear crv_cond1
clear crv_cond2
clear crv_cond4
clear crv_cond5


cd F:\Data\VSDI\Contour_integration\legolas\right_hemisphere\06_10_2008\f
load crv_circle_diff_cond1_superpix_w4
load crv_circle_diff_cond2_superpix_w4
load crv_circle_diff_cond4_superpix_w4
load crv_circle_diff_cond5_superpix_w4
crv_cont_circ=cat(2,crv_cont_circ,mean(crv_cond1,1)');
crv_cont_circ=cat(2,crv_cont_circ,mean(crv_cond2,1)');
crv_non_circ=cat(2,crv_non_circ,mean(crv_cond4,1)');
crv_non_circ=cat(2,crv_non_circ,mean(crv_cond5,1)');
clear crv_cond1
clear crv_cond2
clear crv_cond4
clear crv_cond5

load crv_roi_bg_in_narrow_cond1_superpix_w4
load crv_roi_bg_in_narrow_cond2_superpix_w4
load crv_roi_bg_in_narrow_cond4_superpix_w4
load crv_roi_bg_in_narrow_cond5_superpix_w4
crv_cont_bg=cat(2,crv_cont_bg,mean(crv_cond1,1)');
crv_cont_bg=cat(2,crv_cont_bg,mean(crv_cond2,1)');
crv_non_bg=cat(2,crv_non_bg,mean(crv_cond4,1)');
crv_non_bg=cat(2,crv_non_bg,mean(crv_cond5,1)');
clear crv_cond1
clear crv_cond2
clear crv_cond4
clear crv_cond5


cd F:\Data\VSDI\Contour_integration\legolas\right_hemisphere\22_10_2008\d
load crv_circle_diff_cond1_superpix_w4
load crv_circle_diff_cond2_superpix_w4
load crv_circle_diff_cond4_superpix_w4
load crv_circle_diff_cond5_superpix_w4
crv_cont_circ=cat(2,crv_cont_circ,mean(crv_cond1,1)');
crv_cont_circ=cat(2,crv_cont_circ,mean(crv_cond2,1)');
crv_non_circ=cat(2,crv_non_circ,mean(crv_cond4,1)');
crv_non_circ=cat(2,crv_non_circ,mean(crv_cond5,1)');
clear crv_cond1
clear crv_cond2
clear crv_cond4
clear crv_cond5

load crv_roi_bg_in_narrow_cond1_superpix_w4
load crv_roi_bg_in_narrow_cond2_superpix_w4
load crv_roi_bg_in_narrow_cond4_superpix_w4
load crv_roi_bg_in_narrow_cond5_superpix_w4
crv_cont_bg=cat(2,crv_cont_bg,mean(crv_cond1,1)');
crv_cont_bg=cat(2,crv_cont_bg,mean(crv_cond2,1)');
crv_non_bg=cat(2,crv_non_bg,mean(crv_cond4,1)');
crv_non_bg=cat(2,crv_non_bg,mean(crv_cond5,1)');
clear crv_cond1
clear crv_cond2
clear crv_cond4
clear crv_cond5


cd F:\Data\VSDI\Contour_integration\legolas\right_hemisphere\22_10_2008\e
load crv_circle_diff_cond1_superpix_w4
load crv_circle_diff_cond2_superpix_w4
load crv_circle_diff_cond4_superpix_w4
load crv_circle_diff_cond5_superpix_w4
crv_cont_circ=cat(2,crv_cont_circ,mean(crv_cond1,1)');
crv_cont_circ=cat(2,crv_cont_circ,mean(crv_cond2,1)');
crv_non_circ=cat(2,crv_non_circ,mean(crv_cond4,1)');
crv_non_circ=cat(2,crv_non_circ,mean(crv_cond5,1)');
clear crv_cond1
clear crv_cond2
clear crv_cond4
clear crv_cond5

load crv_roi_bg_in_narrow_cond1_superpix_w4
load crv_roi_bg_in_narrow_cond2_superpix_w4
load crv_roi_bg_in_narrow_cond4_superpix_w4
load crv_roi_bg_in_narrow_cond5_superpix_w4
crv_cont_bg=cat(2,crv_cont_bg,mean(crv_cond1,1)');
crv_cont_bg=cat(2,crv_cont_bg,mean(crv_cond2,1)');
crv_non_bg=cat(2,crv_non_bg,mean(crv_cond4,1)');
crv_non_bg=cat(2,crv_non_bg,mean(crv_cond5,1)');
clear crv_cond1
clear crv_cond2
clear crv_cond4
clear crv_cond5

%%
t=-110:10:110;
figure;plot(t,mean(crv_cont_circ,2))
hold on
plot(t,mean(crv_non_circ,2),'r')
xlim([-110 110])
ylim([-.3 .5])


figure;plot(t,mean(crv_cont_bg,2))
hold on
plot(t,mean(crv_non_bg,2),'r')
xlim([-110 110])
ylim([-.3 .5])

diff_circ=crv_cont_circ-crv_non_circ;
diff_bg=crv_cont_bg-crv_non_bg;

figure;errorbar(t,mean(diff_circ,2),std(diff_circ,0,2)/sqrt(size(diff_circ,2)))
hold on
errorbar(t,mean(diff_bg,2),std(diff_bg,0,2)/sqrt(size(diff_bg,2)),'r')
plot(t,zeros(1,23),'k')
xlim([-110 110])
ylim([-.04 .03])


signrank(mean(diff_circ(10:14,:),1))
signrank(mean(diff_bg(10:14,:),1))

signrank(mean(diff_circ(1:3,:),1))
signrank(mean(diff_bg(1:3,:),1))

signrank(mean(diff_circ(20:23,:),1))
signrank(mean(diff_bg(20:23,:),1))

diff=diff_circ-diff_bg;
figure;errorbar(t,mean(diff,2),std(diff,0,2)/sqrt(size(diff,2)))
hold on
plot(t,zeros(1,23),'k')
xlim([-110 110])

signrank(mean(diff(13:18,:),1))
signrank(mean(diff(3:8,:),1))
signrank(mean(diff(25:29,:),1))







