
cd F:\Data\VSDI\Contour_integration\legolas\right_hemisphere\11_11_2008\c\elhanan_new\no_stim
load crv_contour_cond1
load crv_contour_cond2
load crv_contour_cond4
load crv_contour_cond5
crv_cont_circ=mean(crv_cond1,1)';
crv_cont_circ=cat(2,crv_cont_circ,mean(crv_cond2,1)');
crv_non_circ=mean(crv_cond4,1)';
crv_non_circ=cat(2,crv_non_circ,mean(crv_cond5,1)');
clear crv_cond1
clear crv_cond2
clear crv_cond4
clear crv_cond5

load crv_maskin_cond1
load crv_maskin_cond2
load crv_maskin_cond4
load crv_maskin_cond5
crv_cont_bg=mean(crv_cond1,1)';
crv_cont_bg=cat(2,crv_cont_bg,mean(crv_cond2,1)');
crv_non_bg=mean(crv_cond4,1)';
crv_non_bg=cat(2,crv_non_bg,mean(crv_cond5,1)');
clear crv_cond1
clear crv_cond2
clear crv_cond4
clear crv_cond5


cd F:\Data\VSDI\Contour_integration\legolas\right_hemisphere\11_11_2008\d\elhanan_new\no_stim
load crv_contour_cond1
load crv_contour_cond2
load crv_contour_cond4
load crv_contour_cond5
crv_cont_circ=cat(2,crv_cont_circ,mean(crv_cond1,1)');
crv_cont_circ=cat(2,crv_cont_circ,mean(crv_cond2,1)');
crv_non_circ=cat(2,crv_non_circ,mean(crv_cond4,1)');
crv_non_circ=cat(2,crv_non_circ,mean(crv_cond5,1)');
clear crv_cond1
clear crv_cond2
clear crv_cond4
clear crv_cond5

load crv_maskin_cond1
load crv_maskin_cond2
load crv_maskin_cond4
load crv_maskin_cond5
crv_cont_bg=cat(2,crv_cont_bg,mean(crv_cond1,1)');
crv_cont_bg=cat(2,crv_cont_bg,mean(crv_cond2,1)');
crv_non_bg=cat(2,crv_non_bg,mean(crv_cond4,1)');
crv_non_bg=cat(2,crv_non_bg,mean(crv_cond5,1)');
clear crv_cond1
clear crv_cond2
clear crv_cond4
clear crv_cond5



cd F:\Data\VSDI\Contour_integration\legolas\right_hemisphere\psychophysics\2008_11_18\c\correct_and_incorrect_together\no_stim
load crv_contour_cond1
load crv_contour_cond5
crv_cont_circ=cat(2,crv_cont_circ,mean(crv_cond1,1)');
crv_non_circ=cat(2,crv_non_circ,mean(crv_cond5,1)');
clear crv_cond1
clear crv_cond5

load crv_bg_in_cond1
load crv_bg_in_cond5
crv_cont_bg=cat(2,crv_cont_bg,mean(crv_cond1,1)');
crv_non_bg=cat(2,crv_non_bg,mean(crv_cond5,1)');
clear crv_cond1
clear crv_cond5


cd F:\Data\VSDI\Contour_integration\legolas\right_hemisphere\psychophysics\2008_11_18\d\correct_and_incorrect_together\no_stim
load crv_contour_cond1
load crv_contour_cond5
crv_cont_circ=cat(2,crv_cont_circ,mean(crv_cond1,1)');
crv_non_circ=cat(2,crv_non_circ,mean(crv_cond5,1)');
clear crv_cond1
clear crv_cond5

load crv_bg_in_cond1
load crv_bg_in_cond5
crv_cont_bg=cat(2,crv_cont_bg,mean(crv_cond1,1)');
crv_non_bg=cat(2,crv_non_bg,mean(crv_cond5,1)');
clear crv_cond1
clear crv_cond5

cd F:\Data\VSDI\Contour_integration\legolas\right_hemisphere\psychophysics\2008_11_18\e\correct_and_incorrect_together\no_stim
load crv_contour_cond1
load crv_contour_cond5
crv_cont_circ=cat(2,crv_cont_circ,mean(crv_cond1,1)');
crv_non_circ=cat(2,crv_non_circ,mean(crv_cond5,1)');
clear crv_cond1
clear crv_cond5

load crv_bg_in_cond1
load crv_bg_in_cond5
crv_cont_bg=cat(2,crv_cont_bg,mean(crv_cond1,1)');
crv_non_bg=cat(2,crv_non_bg,mean(crv_cond5,1)');
clear crv_cond1
clear crv_cond5



cd F:\Data\VSDI\Contour_integration\legolas\right_hemisphere\psychophysics\2008_11_25\d\correct_and_incorrect_together\no_stim
load crv_contour_cond1
load crv_contour_cond5
crv_cont_circ=cat(2,crv_cont_circ,mean(crv_cond1,1)');
crv_non_circ=cat(2,crv_non_circ,mean(crv_cond5,1)');
clear crv_cond1
clear crv_cond5

load crv_bg_in_cond1
load crv_bg_in_cond5
crv_cont_bg=cat(2,crv_cont_bg,mean(crv_cond1,1)');
crv_non_bg=cat(2,crv_non_bg,mean(crv_cond5,1)');
clear crv_cond1
clear crv_cond5

cd F:\Data\VSDI\Contour_integration\legolas\right_hemisphere\psychophysics\2008_11_25\e\correct_and_incorrect_together\no_stim

load crv_contour_cond1
load crv_contour_cond5
crv_cont_circ=cat(2,crv_cont_circ,mean(crv_cond1,1)');
crv_non_circ=cat(2,crv_non_circ,mean(crv_cond5,1)');
clear crv_cond1
clear crv_cond5

load crv_bg_in_cond1
load crv_bg_in_cond5
crv_cont_bg=cat(2,crv_cont_bg,mean(crv_cond1,1)');
crv_non_bg=cat(2,crv_non_bg,mean(crv_cond5,1)');
clear crv_cond1
clear crv_cond5

cd F:\Data\VSDI\Contour_integration\legolas\right_hemisphere\psychophysics\2008_11_25\f\correct_and_incorrect_together\no_stim

load crv_contour_cond1
load crv_contour_cond5
crv_cont_circ=cat(2,crv_cont_circ,mean(crv_cond1,1)');
crv_non_circ=cat(2,crv_non_circ,mean(crv_cond5,1)');
clear crv_cond1
clear crv_cond5

load crv_bg_in_cond1
load crv_bg_in_cond5
crv_cont_bg=cat(2,crv_cont_bg,mean(crv_cond1,1)');
crv_non_bg=cat(2,crv_non_bg,mean(crv_cond5,1)');
clear crv_cond1
clear crv_cond5



cd F:\Data\VSDI\Contour_integration\legolas\right_hemisphere\psychophysics\2008_12_03\d\correct_and_incorrect_together\no_stim

load crv_contour_cond1
load crv_contour_cond5
crv_cont_circ=cat(2,crv_cont_circ,mean(crv_cond1,1)');
crv_non_circ=cat(2,crv_non_circ,mean(crv_cond5,1)');
clear crv_cond1
clear crv_cond5

load crv_bg_in_cond1
load crv_bg_in_cond5
crv_cont_bg=cat(2,crv_cont_bg,mean(crv_cond1,1)');
crv_non_bg=cat(2,crv_non_bg,mean(crv_cond5,1)');
clear crv_cond1
clear crv_cond5

cd F:\Data\VSDI\Contour_integration\legolas\right_hemisphere\psychophysics\2008_12_03\e\correct_and_incorrect_together\no_stim

load crv_contour_cond1
load crv_contour_cond5
crv_cont_circ=cat(2,crv_cont_circ,mean(crv_cond1,1)');
crv_non_circ=cat(2,crv_non_circ,mean(crv_cond5,1)');
clear crv_cond1
clear crv_cond5

load crv_bg_in_cond1
load crv_bg_in_cond5
crv_cont_bg=cat(2,crv_cont_bg,mean(crv_cond1,1)');
crv_non_bg=cat(2,crv_non_bg,mean(crv_cond5,1)');
clear crv_cond1
clear crv_cond5

cd F:\Data\VSDI\Contour_integration\legolas\right_hemisphere\psychophysics\2008_12_03\f\correct_and_incorrect_together\no_stim

load crv_contour_cond1
load crv_contour_cond5
crv_cont_circ=cat(2,crv_cont_circ,mean(crv_cond1,1)');
crv_non_circ=cat(2,crv_non_circ,mean(crv_cond5,1)');
clear crv_cond1
clear crv_cond5

load crv_bg_in_cond1
load crv_bg_in_cond5
crv_cont_bg=cat(2,crv_cont_bg,mean(crv_cond1,1)');
crv_non_bg=cat(2,crv_non_bg,mean(crv_cond5,1)');
clear crv_cond1
clear crv_cond5



cd F:\Data\VSDI\Contour_integration\legolas\right_hemisphere\11_11_2008\h\no_stim
load crv_contour_cond1
load crv_contour_cond2
load crv_contour_cond4
load crv_contour_cond5
crv_cont_circ=cat(2,crv_cont_circ,mean(crv_cond1,1)');
crv_cont_circ=cat(2,crv_cont_circ,mean(crv_cond2,1)');
crv_non_circ=cat(2,crv_non_circ,mean(crv_cond4,1)');
crv_non_circ=cat(2,crv_non_circ,mean(crv_cond5,1)');
clear crv_cond1
clear crv_cond2
clear crv_cond4
clear crv_cond5

load crv_maskin_cond1
load crv_maskin_cond2
load crv_maskin_cond4
load crv_maskin_cond5
crv_cont_bg=cat(2,crv_cont_bg,mean(crv_cond1,1)');
crv_cont_bg=cat(2,crv_cont_bg,mean(crv_cond2,1)');
crv_non_bg=cat(2,crv_non_bg,mean(crv_cond4,1)');
crv_non_bg=cat(2,crv_non_bg,mean(crv_cond5,1)');
clear crv_cond1
clear crv_cond2
clear crv_cond4
clear crv_cond5




cd F:\Data\VSDI\Contour_integration\legolas\right_hemisphere\06_10_2008\e\no_stim
load crv_contour_cond1
load crv_contour_cond2
load crv_contour_cond4
load crv_contour_cond5
crv_cont_circ=cat(2,crv_cont_circ,mean(crv_cond1,1)');
crv_cont_circ=cat(2,crv_cont_circ,mean(crv_cond2,1)');
crv_non_circ=cat(2,crv_non_circ,mean(crv_cond4,1)');
crv_non_circ=cat(2,crv_non_circ,mean(crv_cond5,1)');
clear crv_cond1
clear crv_cond2
clear crv_cond4
clear crv_cond5

load crv_bg_in_cond1
load crv_bg_in_cond2
load crv_bg_in_cond4
load crv_bg_in_cond5
crv_cont_bg=cat(2,crv_cont_bg,mean(crv_cond1,1)');
crv_cont_bg=cat(2,crv_cont_bg,mean(crv_cond2,1)');
crv_non_bg=cat(2,crv_non_bg,mean(crv_cond4,1)');
crv_non_bg=cat(2,crv_non_bg,mean(crv_cond5,1)');
clear crv_cond1
clear crv_cond2
clear crv_cond4
clear crv_cond5


cd F:\Data\VSDI\Contour_integration\legolas\right_hemisphere\06_10_2008\f\no_stim
load crv_contour_cond1
load crv_contour_cond2
load crv_contour_cond4
load crv_contour_cond5
crv_cont_circ=cat(2,crv_cont_circ,mean(crv_cond1,1)');
crv_cont_circ=cat(2,crv_cont_circ,mean(crv_cond2,1)');
crv_non_circ=cat(2,crv_non_circ,mean(crv_cond4,1)');
crv_non_circ=cat(2,crv_non_circ,mean(crv_cond5,1)');
clear crv_cond1
clear crv_cond2
clear crv_cond4
clear crv_cond5

load crv_bg_in_cond1
load crv_bg_in_cond2
load crv_bg_in_cond4
load crv_bg_in_cond5
crv_cont_bg=cat(2,crv_cont_bg,mean(crv_cond1,1)');
crv_cont_bg=cat(2,crv_cont_bg,mean(crv_cond2,1)');
crv_non_bg=cat(2,crv_non_bg,mean(crv_cond4,1)');
crv_non_bg=cat(2,crv_non_bg,mean(crv_cond5,1)');
clear crv_cond1
clear crv_cond2
clear crv_cond4
clear crv_cond5


cd F:\Data\VSDI\Contour_integration\legolas\right_hemisphere\22_10_2008\d\no_stim
load crv_contour_cond1
load crv_contour_cond2
load crv_contour_cond4
load crv_contour_cond5
crv_cont_circ=cat(2,crv_cont_circ,mean(crv_cond1,1)');
crv_cont_circ=cat(2,crv_cont_circ,mean(crv_cond2,1)');
crv_non_circ=cat(2,crv_non_circ,mean(crv_cond4,1)');
crv_non_circ=cat(2,crv_non_circ,mean(crv_cond5,1)');
clear crv_cond1
clear crv_cond2
clear crv_cond4
clear crv_cond5

load crv_bg_in_cond1
load crv_bg_in_cond2
load crv_bg_in_cond4
load crv_bg_in_cond5
crv_cont_bg=cat(2,crv_cont_bg,mean(crv_cond1,1)');
crv_cont_bg=cat(2,crv_cont_bg,mean(crv_cond2,1)');
crv_non_bg=cat(2,crv_non_bg,mean(crv_cond4,1)');
crv_non_bg=cat(2,crv_non_bg,mean(crv_cond5,1)');
clear crv_cond1
clear crv_cond2
clear crv_cond4
clear crv_cond5


cd F:\Data\VSDI\Contour_integration\legolas\right_hemisphere\22_10_2008\e\no_stim
load crv_contour_cond1
load crv_contour_cond2
load crv_contour_cond4
load crv_contour_cond5
crv_cont_circ=cat(2,crv_cont_circ,mean(crv_cond1,1)');
crv_cont_circ=cat(2,crv_cont_circ,mean(crv_cond2,1)');
crv_non_circ=cat(2,crv_non_circ,mean(crv_cond4,1)');
crv_non_circ=cat(2,crv_non_circ,mean(crv_cond5,1)');
clear crv_cond1
clear crv_cond2
clear crv_cond4
clear crv_cond5

load crv_bg_in_cond1
load crv_bg_in_cond2
load crv_bg_in_cond4
load crv_bg_in_cond5
crv_cont_bg=cat(2,crv_cont_bg,mean(crv_cond1,1)');
crv_cont_bg=cat(2,crv_cont_bg,mean(crv_cond2,1)');
crv_non_bg=cat(2,crv_non_bg,mean(crv_cond4,1)');
crv_non_bg=cat(2,crv_non_bg,mean(crv_cond5,1)');
clear crv_cond1
clear crv_cond2
clear crv_cond4
clear crv_cond5

%%
t=-150:10:150;
figure;plot(t,mean(crv_cont_circ,2))
hold on
plot(t,mean(crv_non_circ,2),'r')
xlim([-150 150])
ylim([-.3 .6])

t=-150:10:150;
figure;plot(t,mean(crv_cont_bg,2))
hold on
plot(t,mean(crv_non_bg,2),'r')
xlim([-150 150])
ylim([-.3 .6])

diff_circ=crv_cont_circ-crv_non_circ;
diff_bg=crv_cont_bg-crv_non_bg;
t=-150:10:150;
figure;errorbar(t,mean(diff_circ,2),std(diff_circ,0,2)/sqrt(size(diff_circ,2)))
hold on
errorbar(t,mean(diff_bg,2),std(diff_bg,0,2)/sqrt(size(diff_bg,2)),'r')
plot(t,zeros(1,31),'k')
xlim([-150 150])
ylim([-.04 .03])


signrank(mean(diff_circ(13:18,:),1))
signrank(mean(diff_bg(13:18,:),1))

signrank(mean(diff_circ(3:8,:),1))
signrank(mean(diff_bg(3:8,:),1))

signrank(mean(diff_circ(25:29,:),1))
signrank(mean(diff_bg(25:29,:),1))

diff=diff_circ-diff_bg;
figure;errorbar(t,mean(diff,2),std(diff,0,2)/sqrt(size(diff,2)))
hold on
plot(t,zeros(1,31),'k')
xlim([-150 150])

signrank(mean(diff(13:18,:),1))
signrank(mean(diff(3:8,:),1))
signrank(mean(diff(25:29,:),1))




%% SMEAGOL 28:43


cd F:\Data\VSDI\Contour_integration\Smeagol\17Nov2010\b
load crv_circle_cond1
load crv_circle_cond2
load crv_circle_cond4
load crv_circle_cond5
crv_cont_circ=mean(crv_cond1,1)';
crv_cont_circ=cat(2,crv_cont_circ,mean(crv_cond2,1)');
crv_non_circ=mean(crv_cond4,1)';
crv_non_circ=cat(2,crv_non_circ,mean(crv_cond5,1)');
clear crv_cond1
clear crv_cond2
clear crv_cond4
clear crv_cond5

load crv_bg_in_cond1
load crv_bg_in_cond2
load crv_bg_in_cond4
load crv_bg_in_cond5
crv_cont_bg=mean(crv_cond1,1)';
crv_cont_bg=cat(2,crv_cont_bg,mean(crv_cond2,1)');
crv_non_bg=mean(crv_cond4,1)';
crv_non_bg=cat(2,crv_non_bg,mean(crv_cond5,1)');
clear crv_cond1
clear crv_cond2
clear crv_cond4
clear crv_cond5



cd F:\Data\VSDI\Contour_integration\Smeagol\17Nov2010\c
load crv_circle_cond1
load crv_circle_cond2
load crv_circle_cond4
load crv_circle_cond5
crv_cont_circ=cat(2,crv_cont_circ,mean(crv_cond1,1)');
crv_cont_circ=cat(2,crv_cont_circ,mean(crv_cond2,1)');
crv_non_circ=cat(2,crv_non_circ,mean(crv_cond4,1)');
crv_non_circ=cat(2,crv_non_circ,mean(crv_cond5,1)');
clear crv_cond1
clear crv_cond2
clear crv_cond4
clear crv_cond5

load crv_bg_in_cond1
load crv_bg_in_cond2
load crv_bg_in_cond4
load crv_bg_in_cond5
crv_cont_bg=cat(2,crv_cont_bg,mean(crv_cond1,1)');
crv_cont_bg=cat(2,crv_cont_bg,mean(crv_cond2,1)');
crv_non_bg=cat(2,crv_non_bg,mean(crv_cond4,1)');
crv_non_bg=cat(2,crv_non_bg,mean(crv_cond5,1)');
clear crv_cond1
clear crv_cond2
clear crv_cond4
clear crv_cond5


cd F:\Data\VSDI\Contour_integration\Smeagol\17Nov2010\g
load crv_circle_cond1
load crv_circle_cond2
load crv_circle_cond4
load crv_circle_cond5
crv_cont_circ=cat(2,crv_cont_circ,mean(crv_cond1,1)');
crv_cont_circ=cat(2,crv_cont_circ,mean(crv_cond2,1)');
crv_non_circ=cat(2,crv_non_circ,mean(crv_cond4,1)');
crv_non_circ=cat(2,crv_non_circ,mean(crv_cond5,1)');
clear crv_cond1
clear crv_cond2
clear crv_cond4
clear crv_cond5

load crv_bg_in_cond1
load crv_bg_in_cond2
load crv_bg_in_cond4
load crv_bg_in_cond5
crv_cont_bg=cat(2,crv_cont_bg,mean(crv_cond1,1)');
crv_cont_bg=cat(2,crv_cont_bg,mean(crv_cond2,1)');
crv_non_bg=cat(2,crv_non_bg,mean(crv_cond4,1)');
crv_non_bg=cat(2,crv_non_bg,mean(crv_cond5,1)');
clear crv_cond1
clear crv_cond2
clear crv_cond4
clear crv_cond5



cd F:\Data\VSDI\Contour_integration\Smeagol\24Nov2010\b
load crv_circle_cond1
load crv_circle_cond2
load crv_circle_cond4
load crv_circle_cond5
crv_cont_circ=cat(2,crv_cont_circ,mean(crv_cond1,1)');
crv_cont_circ=cat(2,crv_cont_circ,mean(crv_cond2,1)');
crv_non_circ=cat(2,crv_non_circ,mean(crv_cond4,1)');
crv_non_circ=cat(2,crv_non_circ,mean(crv_cond5,1)');
clear crv_cond1
clear crv_cond2
clear crv_cond4
clear crv_cond5

load crv_bg_in_cond1
load crv_bg_in_cond2
load crv_bg_in_cond4
load crv_bg_in_cond5
crv_cont_bg=cat(2,crv_cont_bg,mean(crv_cond1,1)');
crv_cont_bg=cat(2,crv_cont_bg,mean(crv_cond2,1)');
crv_non_bg=cat(2,crv_non_bg,mean(crv_cond4,1)');
crv_non_bg=cat(2,crv_non_bg,mean(crv_cond5,1)');
clear crv_cond1
clear crv_cond2
clear crv_cond4
clear crv_cond5


cd F:\Data\VSDI\Contour_integration\Smeagol\24Nov2010\d
load crv_circle_cond1
load crv_circle_cond2
load crv_circle_cond4
load crv_circle_cond5
crv_cont_circ=cat(2,crv_cont_circ,mean(crv_cond1,1)');
crv_cont_circ=cat(2,crv_cont_circ,mean(crv_cond2,1)');
crv_non_circ=cat(2,crv_non_circ,mean(crv_cond4,1)');
crv_non_circ=cat(2,crv_non_circ,mean(crv_cond5,1)');
clear crv_cond1
clear crv_cond2
clear crv_cond4
clear crv_cond5

load crv_bg_in_cond1
load crv_bg_in_cond2
load crv_bg_in_cond4
load crv_bg_in_cond5
crv_cont_bg=cat(2,crv_cont_bg,mean(crv_cond1,1)');
crv_cont_bg=cat(2,crv_cont_bg,mean(crv_cond2,1)');
crv_non_bg=cat(2,crv_non_bg,mean(crv_cond4,1)');
crv_non_bg=cat(2,crv_non_bg,mean(crv_cond5,1)');
clear crv_cond1
clear crv_cond2
clear crv_cond4
clear crv_cond5


cd F:\Data\VSDI\Contour_integration\Smeagol\24Nov2010\f
load crv_circle_cond1
load crv_circle_cond2
load crv_circle_cond4
load crv_circle_cond5
crv_cont_circ=cat(2,crv_cont_circ,mean(crv_cond1,1)');
crv_cont_circ=cat(2,crv_cont_circ,mean(crv_cond2,1)');
crv_non_circ=cat(2,crv_non_circ,mean(crv_cond4,1)');
crv_non_circ=cat(2,crv_non_circ,mean(crv_cond5,1)');
clear crv_cond1
clear crv_cond2
clear crv_cond4
clear crv_cond5

load crv_bg_in_cond1
load crv_bg_in_cond2
load crv_bg_in_cond4
load crv_bg_in_cond5
crv_cont_bg=cat(2,crv_cont_bg,mean(crv_cond1,1)');
crv_cont_bg=cat(2,crv_cont_bg,mean(crv_cond2,1)');
crv_non_bg=cat(2,crv_non_bg,mean(crv_cond4,1)');
crv_non_bg=cat(2,crv_non_bg,mean(crv_cond5,1)');
clear crv_cond1
clear crv_cond2
clear crv_cond4
clear crv_cond5

cd F:\Data\VSDI\Contour_integration\Smeagol\14Dec2010\b
load crv_circle_cond1
load crv_circle_cond2
load crv_circle_cond4
load crv_circle_cond5
crv_cont_circ=cat(2,crv_cont_circ,mean(crv_cond1,1)');
crv_cont_circ=cat(2,crv_cont_circ,mean(crv_cond2,1)');
crv_non_circ=cat(2,crv_non_circ,mean(crv_cond4,1)');
crv_non_circ=cat(2,crv_non_circ,mean(crv_cond5,1)');
clear crv_cond1
clear crv_cond2
clear crv_cond4
clear crv_cond5

load crv_bg_in_cond1
load crv_bg_in_cond2
load crv_bg_in_cond4
load crv_bg_in_cond5
crv_cont_bg=cat(2,crv_cont_bg,mean(crv_cond1,1)');
crv_cont_bg=cat(2,crv_cont_bg,mean(crv_cond2,1)');
crv_non_bg=cat(2,crv_non_bg,mean(crv_cond4,1)');
crv_non_bg=cat(2,crv_non_bg,mean(crv_cond5,1)');
clear crv_cond1
clear crv_cond2
clear crv_cond4
clear crv_cond5


cd F:\Data\VSDI\Contour_integration\Smeagol\14Dec2010\c
load crv_circle_cond1
load crv_circle_cond5
crv_cont_circ=cat(2,crv_cont_circ,mean(crv_cond1,1)');
crv_non_circ=cat(2,crv_non_circ,mean(crv_cond5,1)');
clear crv_cond1
clear crv_cond5

load crv_bg_in_cond1
load crv_bg_in_cond5
crv_cont_bg=cat(2,crv_cont_bg,mean(crv_cond1,1)');
crv_non_bg=cat(2,crv_non_bg,mean(crv_cond5,1)');
clear crv_cond1
clear crv_cond5



cd F:\Data\VSDI\Contour_integration\Smeagol\14Dec2010\d
load crv_circle_cond1
load crv_circle_cond5
crv_cont_circ=cat(2,crv_cont_circ,mean(crv_cond1,1)');
crv_non_circ=cat(2,crv_non_circ,mean(crv_cond5,1)');
clear crv_cond1
clear crv_cond5

load crv_bg_in_cond1
load crv_bg_in_cond5
crv_cont_bg=cat(2,crv_cont_bg,mean(crv_cond1,1)');
crv_non_bg=cat(2,crv_non_bg,mean(crv_cond5,1)');
clear crv_cond1
clear crv_cond5


cd F:\Data\VSDI\Contour_integration\Smeagol\14Dec2010\e
load crv_circle_cond1
load crv_circle_cond5
crv_cont_circ=cat(2,crv_cont_circ,mean(crv_cond1,1)');
crv_non_circ=cat(2,crv_non_circ,mean(crv_cond5,1)');
clear crv_cond1
clear crv_cond5

load crv_bg_in_cond1
load crv_bg_in_cond5
crv_cont_bg=cat(2,crv_cont_bg,mean(crv_cond1,1)');
crv_non_bg=cat(2,crv_non_bg,mean(crv_cond5,1)');
clear crv_cond1
clear crv_cond5



cd F:\Data\VSDI\Contour_integration\Smeagol\22Dec2010\b
load crv_circle_cond1
load crv_circle_cond2
load crv_circle_cond4
load crv_circle_cond5
crv_cont_circ=cat(2,crv_cont_circ,mean(crv_cond1,1)');
crv_cont_circ=cat(2,crv_cont_circ,mean(crv_cond2,1)');
crv_non_circ=cat(2,crv_non_circ,mean(crv_cond4,1)');
crv_non_circ=cat(2,crv_non_circ,mean(crv_cond5,1)');
clear crv_cond1
clear crv_cond2
clear crv_cond4
clear crv_cond5

load crv_bg_in_cond1
load crv_bg_in_cond2
load crv_bg_in_cond4
load crv_bg_in_cond5
crv_cont_bg=cat(2,crv_cont_bg,mean(crv_cond1,1)');
crv_cont_bg=cat(2,crv_cont_bg,mean(crv_cond2,1)');
crv_non_bg=cat(2,crv_non_bg,mean(crv_cond4,1)');
crv_non_bg=cat(2,crv_non_bg,mean(crv_cond5,1)');
clear crv_cond1
clear crv_cond2
clear crv_cond4
clear crv_cond5


cd F:\Data\VSDI\Contour_integration\Smeagol\22Dec2010\c
load crv_circle_cond1
load crv_circle_cond5
crv_cont_circ=cat(2,crv_cont_circ,mean(crv_cond1,1)');
crv_non_circ=cat(2,crv_non_circ,mean(crv_cond5,1)');
clear crv_cond1
clear crv_cond5

load crv_bg_in_cond1
load crv_bg_in_cond5
crv_cont_bg=cat(2,crv_cont_bg,mean(crv_cond1,1)');
crv_non_bg=cat(2,crv_non_bg,mean(crv_cond5,1)');
clear crv_cond1
clear crv_cond5



cd F:\Data\VSDI\Contour_integration\Smeagol\22Dec2010\d
load crv_circle_cond1
load crv_circle_cond5
crv_cont_circ=cat(2,crv_cont_circ,mean(crv_cond1,1)');
crv_non_circ=cat(2,crv_non_circ,mean(crv_cond5,1)');
clear crv_cond1
clear crv_cond5

load crv_bg_in_cond1
load crv_bg_in_cond5
crv_cont_bg=cat(2,crv_cont_bg,mean(crv_cond1,1)');
crv_non_bg=cat(2,crv_non_bg,mean(crv_cond5,1)');
clear crv_cond1
clear crv_cond5




cd F:\Data\VSDI\Contour_integration\Smeagol\29Dec2010\b
load crv_circle_cond1
load crv_circle_cond2
load crv_circle_cond4
load crv_circle_cond5
crv_cont_circ=cat(2,crv_cont_circ,mean(crv_cond1,1)');
crv_cont_circ=cat(2,crv_cont_circ,mean(crv_cond2,1)');
crv_non_circ=cat(2,crv_non_circ,mean(crv_cond4,1)');
crv_non_circ=cat(2,crv_non_circ,mean(crv_cond5,1)');
clear crv_cond1
clear crv_cond2
clear crv_cond4
clear crv_cond5

load crv_bg_in_cond1
load crv_bg_in_cond2
load crv_bg_in_cond4
load crv_bg_in_cond5
crv_cont_bg=cat(2,crv_cont_bg,mean(crv_cond1,1)');
crv_cont_bg=cat(2,crv_cont_bg,mean(crv_cond2,1)');
crv_non_bg=cat(2,crv_non_bg,mean(crv_cond4,1)');
crv_non_bg=cat(2,crv_non_bg,mean(crv_cond5,1)');
clear crv_cond1
clear crv_cond2
clear crv_cond4
clear crv_cond5



cd F:\Data\VSDI\Contour_integration\Smeagol\29Dec2010\c
load crv_circle_cond1
load crv_circle_cond2
load crv_circle_cond4
load crv_circle_cond5
crv_cont_circ=cat(2,crv_cont_circ,mean(crv_cond1,1)');
crv_cont_circ=cat(2,crv_cont_circ,mean(crv_cond2,1)');
crv_non_circ=cat(2,crv_non_circ,mean(crv_cond4,1)');
crv_non_circ=cat(2,crv_non_circ,mean(crv_cond5,1)');
clear crv_cond1
clear crv_cond2
clear crv_cond4
clear crv_cond5

load crv_bg_out_cond1
load crv_bg_out_cond2
load crv_bg_out_cond4
load crv_bg_out_cond5
crv_cont_bg=cat(2,crv_cont_bg,mean(crv_cond1,1)');
crv_cont_bg=cat(2,crv_cont_bg,mean(crv_cond2,1)');
crv_non_bg=cat(2,crv_non_bg,mean(crv_cond4,1)');
crv_non_bg=cat(2,crv_non_bg,mean(crv_cond5,1)');
clear crv_cond1
clear crv_cond2
clear crv_cond4
clear crv_cond5


cd F:\Data\VSDI\Contour_integration\Smeagol\29Dec2010\d
load crv_circle_cond1
load crv_circle_cond2
load crv_circle_cond4
load crv_circle_cond5
crv_cont_circ=cat(2,crv_cont_circ,mean(crv_cond1,1)');
crv_cont_circ=cat(2,crv_cont_circ,mean(crv_cond2,1)');
crv_non_circ=cat(2,crv_non_circ,mean(crv_cond4,1)');
crv_non_circ=cat(2,crv_non_circ,mean(crv_cond5,1)');
clear crv_cond1
clear crv_cond2
clear crv_cond4
clear crv_cond5

load crv_bg_in_cond1
load crv_bg_in_cond2
load crv_bg_in_cond4
load crv_bg_in_cond5
crv_cont_bg=cat(2,crv_cont_bg,mean(crv_cond1,1)');
crv_cont_bg=cat(2,crv_cont_bg,mean(crv_cond2,1)');
crv_non_bg=cat(2,crv_non_bg,mean(crv_cond4,1)');
crv_non_bg=cat(2,crv_non_bg,mean(crv_cond5,1)');
clear crv_cond1
clear crv_cond2
clear crv_cond4
clear crv_cond5


cd F:\Data\VSDI\Contour_integration\Smeagol\29Dec2010\e
load crv_circle_cond1
load crv_circle_cond2
load crv_circle_cond4
load crv_circle_cond5
crv_cont_circ=cat(2,crv_cont_circ,mean(crv_cond1,1)');
crv_cont_circ=cat(2,crv_cont_circ,mean(crv_cond2,1)');
crv_non_circ=cat(2,crv_non_circ,mean(crv_cond4,1)');
crv_non_circ=cat(2,crv_non_circ,mean(crv_cond5,1)');
clear crv_cond1
clear crv_cond2
clear crv_cond4
clear crv_cond5

load crv_bg_out_cond1
load crv_bg_out_cond2
load crv_bg_out_cond4
load crv_bg_out_cond5
crv_cont_bg=cat(2,crv_cont_bg,mean(crv_cond1,1)');
crv_cont_bg=cat(2,crv_cont_bg,mean(crv_cond2,1)');
crv_non_bg=cat(2,crv_non_bg,mean(crv_cond4,1)');
crv_non_bg=cat(2,crv_non_bg,mean(crv_cond5,1)');
clear crv_cond1
clear crv_cond2
clear crv_cond4
clear crv_cond5


cd F:\Data\VSDI\Contour_integration\Smeagol\29Dec2010\k
load crv_circle_cond1
load crv_circle_cond2
load crv_circle_cond4
load crv_circle_cond5
crv_cont_circ=cat(2,crv_cont_circ,mean(crv_cond1,1)');
crv_cont_circ=cat(2,crv_cont_circ,mean(crv_cond2,1)');
crv_non_circ=cat(2,crv_non_circ,mean(crv_cond4,1)');
crv_non_circ=cat(2,crv_non_circ,mean(crv_cond5,1)');
clear crv_cond1
clear crv_cond2
clear crv_cond4
clear crv_cond5

load crv_bg_out_cond1
load crv_bg_out_cond2
load crv_bg_out_cond4
load crv_bg_out_cond5
crv_cont_bg=cat(2,crv_cont_bg,mean(crv_cond1,1)');
crv_cont_bg=cat(2,crv_cont_bg,mean(crv_cond2,1)');
crv_non_bg=cat(2,crv_non_bg,mean(crv_cond4,1)');
crv_non_bg=cat(2,crv_non_bg,mean(crv_cond5,1)');
clear crv_cond1
clear crv_cond2
clear crv_cond4
clear crv_cond5


cd F:\Data\VSDI\Contour_integration\Smeagol\05Jan2011\b
load crv_circle_cond1
load crv_circle_cond2
load crv_circle_cond4
load crv_circle_cond5
crv_cont_circ=cat(2,crv_cont_circ,mean(crv_cond1,1)');
crv_cont_circ=cat(2,crv_cont_circ,mean(crv_cond2,1)');
crv_non_circ=cat(2,crv_non_circ,mean(crv_cond4,1)');
crv_non_circ=cat(2,crv_non_circ,mean(crv_cond5,1)');
clear crv_cond1
clear crv_cond2
clear crv_cond4
clear crv_cond5

load crv_bg_out_cond1
load crv_bg_out_cond2
load crv_bg_out_cond4
load crv_bg_out_cond5
crv_cont_bg=cat(2,crv_cont_bg,mean(crv_cond1,1)');
crv_cont_bg=cat(2,crv_cont_bg,mean(crv_cond2,1)');
crv_non_bg=cat(2,crv_non_bg,mean(crv_cond4,1)');
crv_non_bg=cat(2,crv_non_bg,mean(crv_cond5,1)');
clear crv_cond1
clear crv_cond2
clear crv_cond4
clear crv_cond5


cd F:\Data\VSDI\Contour_integration\Smeagol\05Jan2011\c
load crv_circle_cond1
load crv_circle_cond5
crv_cont_circ=cat(2,crv_cont_circ,mean(crv_cond1,1)');
crv_non_circ=cat(2,crv_non_circ,mean(crv_cond5,1)');
clear crv_cond1
clear crv_cond5

load crv_bg_out_cond1
load crv_bg_out_cond5
crv_cont_bg=cat(2,crv_cont_bg,mean(crv_cond1,1)');
crv_non_bg=cat(2,crv_non_bg,mean(crv_cond5,1)');
clear crv_cond1
clear crv_cond5


cd F:\Data\VSDI\Contour_integration\Smeagol\05Jan2011\d
load crv_circle_cond1
load crv_circle_cond5
crv_cont_circ=cat(2,crv_cont_circ,mean(crv_cond1,1)');
crv_non_circ=cat(2,crv_non_circ,mean(crv_cond5,1)');
clear crv_cond1
clear crv_cond5

load crv_bg_out_cond1
load crv_bg_out_cond5
crv_cont_bg=cat(2,crv_cont_bg,mean(crv_cond1,1)');
crv_non_bg=cat(2,crv_non_bg,mean(crv_cond5,1)');
clear crv_cond1
clear crv_cond5



cd F:\Data\VSDI\Contour_integration\Smeagol\05Jan2011\e
load crv_circle_cond1
load crv_circle_cond2
load crv_circle_cond4
load crv_circle_cond5
crv_cont_circ=cat(2,crv_cont_circ,mean(crv_cond1,1)');
crv_cont_circ=cat(2,crv_cont_circ,mean(crv_cond2,1)');
crv_non_circ=cat(2,crv_non_circ,mean(crv_cond4,1)');
crv_non_circ=cat(2,crv_non_circ,mean(crv_cond5,1)');
clear crv_cond1
clear crv_cond2
clear crv_cond4
clear crv_cond5

load crv_bg_in_cond1
load crv_bg_in_cond2
load crv_bg_in_cond4
load crv_bg_in_cond5
crv_cont_bg=cat(2,crv_cont_bg,mean(crv_cond1,1)');
crv_cont_bg=cat(2,crv_cont_bg,mean(crv_cond2,1)');
crv_non_bg=cat(2,crv_non_bg,mean(crv_cond4,1)');
crv_non_bg=cat(2,crv_non_bg,mean(crv_cond5,1)');
clear crv_cond1
clear crv_cond2
clear crv_cond4
clear crv_cond5


%%
t=-150:10:150;
figure;errorbar(t,mean(crv_cont_circ(:,ses1_smeg),2),std(crv_cont_circ(:,ses1_smeg),0,2)/sqrt(size(crv_cont_circ(:,ses1_smeg),2)))
hold on
errorbar(t,mean(crv_non_circ(:,ses1_smeg),2),std(crv_non_circ(:,ses1_smeg),0,2)/sqrt(size(crv_non_circ(:,ses1_smeg),2)),'r')

t=-150:10:150;
figure;errorbar(t,mean(crv_cont_bg(:,ses1_smeg),2),std(crv_cont_bg(:,ses1_smeg),0,2)/sqrt(size(crv_cont_bg(:,ses1_smeg),2)))
hold on
errorbar(t,mean(crv_non_bg(:,ses1_smeg),2),std(crv_non_bg(:,ses1_smeg),0,2)/sqrt(size(crv_non_bg(:,ses1_smeg),2)),'r')

diff_circ=crv_cont_circ-crv_non_circ;
diff_bg=crv_cont_bg-crv_non_bg;
t=-150:10:150;
figure;errorbar(t,mean(diff_circ(:,ses1_smeg),2),std(diff_circ(:,ses1_smeg),0,2)/sqrt(size(diff_circ(:,ses1_smeg),2)))
hold on
errorbar(t,mean(diff_bg(:,ses1_smeg),2),std(diff_bg(:,ses1_smeg),0,2)/sqrt(size(diff_bg(:,ses1_smeg),2)),'r')
plot(t,zeros(1,31),'k')
xlim([-150 150])

signrank(mean(diff_circ(13:18,ses1_smeg),1))
signrank(mean(diff_bg(13:18,ses1_smeg),1))

signrank(mean(diff_circ(3:8,ses1_smeg),1))
signrank(mean(diff_bg(3:8,ses1_smeg),1))

signrank(mean(diff_circ(25:29,ses1_smeg),1))
signrank(mean(diff_bg(25:29,ses1_smeg),1))


diff=diff_circ-diff_bg;
figure;errorbar(t,mean(diff(:,ses1_smeg),2),std(diff(:,ses1_smeg),0,2)/sqrt(size(diff(:,ses1_smeg),2)))
hold on
plot(t,zeros(1,31),'k')
xlim([-150 150])

signrank(mean(diff(13:18,ses1_smeg),1))
signrank(mean(diff(3:8,ses1_smeg),1))
signrank(mean(diff(25:29,ses1_smeg),1))





