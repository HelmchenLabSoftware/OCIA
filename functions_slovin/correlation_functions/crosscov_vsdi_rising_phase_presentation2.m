
time=48:63;
win=size(time,2);
x=(-win+1)*10:10:(win-1)*10;


crosscov_cont_V2_circ=zeros(win*2-1,13);
crosscov_non_V2_circ=zeros(win*2-1,13);

cd /fat2/Ariel_Gilad/Matlab_analysis/experiments/mask/legolas/right_hemisphere/11_11_2008/c/elhanan_new
load myrois
load cond1n_dt_bl
load cond4n_dt_bl
crosscov_cont_V2_circ(:,1)=xcov(squeeze(mean(mean(cond1n_dt_bl(roi_V2,time,:),1),3)),squeeze(mean(mean(cond1n_dt_bl(roi_contour2,time,:),1),3)),'coeff');
crosscov_non_V2_circ(:,1)=xcov(squeeze(mean(mean(cond4n_dt_bl(roi_V2,time,:),1),3)),squeeze(mean(mean(cond4n_dt_bl(roi_contour2,time,:),1),3)),'coeff');
clear cond1n_dt_bl
clear cond4n_dt_bl
load cond2n_dt_bl
load cond5n_dt_bl
crosscov_cont_V2_circ(:,2)=xcov(squeeze(mean(mean(cond2n_dt_bl(roi_V2,time,:),1),3)),squeeze(mean(mean(cond2n_dt_bl(roi_contour2,time,:),1),3)),'coeff');
crosscov_non_V2_circ(:,2)=xcov(squeeze(mean(mean(cond5n_dt_bl(roi_V2,time,:),1),3)),squeeze(mean(mean(cond5n_dt_bl(roi_contour2,time,:),1),3)),'coeff');
clear cond2n_dt_bl
clear cond5n_dt_bl
cd /fat2/Ariel_Gilad/Matlab_analysis/experiments/mask/legolas/right_hemisphere/11_11_2008/d/elhanan_new
load cond1n_dt_bl
load cond4n_dt_bl
crosscov_cont_V2_circ(:,3)=xcov(squeeze(mean(mean(cond1n_dt_bl(roi_V2,time,:),1),3)),squeeze(mean(mean(cond1n_dt_bl(roi_contour2,time,:),1),3)),'coeff');
crosscov_non_V2_circ(:,3)=xcov(squeeze(mean(mean(cond4n_dt_bl(roi_V2,time,:),1),3)),squeeze(mean(mean(cond4n_dt_bl(roi_contour2,time,:),1),3)),'coeff');
clear cond1n_dt_bl
clear cond4n_dt_bl
load cond2n_dt_bl
load cond5n_dt_bl
crosscov_cont_V2_circ(:,4)=xcov(squeeze(mean(mean(cond2n_dt_bl(roi_V2,time,:),1),3)),squeeze(mean(mean(cond2n_dt_bl(roi_contour2,time,:),1),3)),'coeff');
crosscov_non_V2_circ(:,4)=xcov(squeeze(mean(mean(cond5n_dt_bl(roi_V2,time,:),1),3)),squeeze(mean(mean(cond5n_dt_bl(roi_contour2,time,:),1),3)),'coeff');
clear cond2n_dt_bl
clear cond5n_dt_bl
cd /fat2/Ariel_Gilad/Matlab_analysis/experiments/mask/legolas/right_hemisphere/psychophysics/2008_11_18/c
load myrois
load cond1n_dt_bl
load cond5n_dt_bl
crosscov_cont_V2_circ(:,5)=xcov(squeeze(mean(mean(cond1n_dt_bl(roi_V2,time,:),1),3)),squeeze(mean(mean(cond1n_dt_bl(roi_contour,time,:),1),3)),'coeff');
crosscov_non_V2_circ(:,5)=xcov(squeeze(mean(mean(cond5n_dt_bl(roi_V2,time,:),1),3)),squeeze(mean(mean(cond5n_dt_bl(roi_contour,time,:),1),3)),'coeff');
clear cond1n_dt_bl
clear cond5n_dt_bl
cd /fat2/Ariel_Gilad/Matlab_analysis/experiments/mask/legolas/right_hemisphere/psychophysics/2008_11_18/d
load cond1n_dt_bl
load cond5n_dt_bl
crosscov_cont_V2_circ(:,6)=xcov(squeeze(mean(mean(cond1n_dt_bl(roi_V2,time,:),1),3)),squeeze(mean(mean(cond1n_dt_bl(roi_contour,time,:),1),3)),'coeff');
crosscov_non_V2_circ(:,6)=xcov(squeeze(mean(mean(cond5n_dt_bl(roi_V2,time,:),1),3)),squeeze(mean(mean(cond5n_dt_bl(roi_contour,time,:),1),3)),'coeff');
clear cond1n_dt_bl
clear cond5n_dt_bl
cd /fat2/Ariel_Gilad/Matlab_analysis/experiments/mask/legolas/right_hemisphere/psychophysics/2008_11_18/e
load cond1n_dt_bl
load cond5n_dt_bl
crosscov_cont_V2_circ(:,7)=xcov(squeeze(mean(mean(cond1n_dt_bl(roi_V2,time,:),1),3)),squeeze(mean(mean(cond1n_dt_bl(roi_contour,time,:),1),3)),'coeff');
crosscov_non_V2_circ(:,7)=xcov(squeeze(mean(mean(cond5n_dt_bl(roi_V2,time,:),1),3)),squeeze(mean(mean(cond5n_dt_bl(roi_contour,time,:),1),3)),'coeff');
clear cond1n_dt_bl
clear cond5n_dt_bl
cd /fat2/Ariel_Gilad/Matlab_analysis/experiments/mask/legolas/right_hemisphere/psychophysics/2008_11_25/d
load 2511
load cond1n_dt_bl
load cond5n_dt_bl
crosscov_cont_V2_circ(:,8)=xcov(squeeze(mean(mean(cond1n_dt_bl(roi_V2,time,:),1),3)),squeeze(mean(mean(cond1n_dt_bl(roi_contour,time,:),1),3)),'coeff');
crosscov_non_V2_circ(:,8)=xcov(squeeze(mean(mean(cond5n_dt_bl(roi_V2,time,:),1),3)),squeeze(mean(mean(cond5n_dt_bl(roi_contour,time,:),1),3)),'coeff');
clear cond1n_dt_bl
clear cond5n_dt_bl
cd /fat2/Ariel_Gilad/Matlab_analysis/experiments/mask/legolas/right_hemisphere/psychophysics/2008_11_25/e
load cond1n_dt_bl
load cond5n_dt_bl
crosscov_cont_V2_circ(:,9)=xcov(squeeze(mean(mean(cond1n_dt_bl(roi_V2,time,:),1),3)),squeeze(mean(mean(cond1n_dt_bl(roi_contour,time,:),1),3)),'coeff');
crosscov_non_V2_circ(:,9)=xcov(squeeze(mean(mean(cond5n_dt_bl(roi_V2,time,:),1),3)),squeeze(mean(mean(cond5n_dt_bl(roi_contour,time,:),1),3)),'coeff');
clear cond1n_dt_bl
clear cond5n_dt_bl
cd /fat2/Ariel_Gilad/Matlab_analysis/experiments/mask/legolas/right_hemisphere/psychophysics/2008_11_25/f
load cond1n_dt_bl
load cond5n_dt_bl
crosscov_cont_V2_circ(:,10)=xcov(squeeze(mean(mean(cond1n_dt_bl(roi_V2,time,:),1),3)),squeeze(mean(mean(cond1n_dt_bl(roi_contour,time,:),1),3)),'coeff');
crosscov_non_V2_circ(:,10)=xcov(squeeze(mean(mean(cond5n_dt_bl(roi_V2,time,:),1),3)),squeeze(mean(mean(cond5n_dt_bl(roi_contour,time,:),1),3)),'coeff');
clear cond1n_dt_bl
clear cond5n_dt_bl
cd /fat2/Ariel_Gilad/Matlab_analysis/experiments/mask/legolas/right_hemisphere/psychophysics/2008_12_03/d
load myrois
load cond1n_dt_bl
load cond5n_dt_bl
crosscov_cont_V2_circ(:,11)=xcov(squeeze(mean(mean(cond1n_dt_bl(roi_V2,time,:),1),3)),squeeze(mean(mean(cond1n_dt_bl(roi_contour,time,:),1),3)),'coeff');
crosscov_non_V2_circ(:,11)=xcov(squeeze(mean(mean(cond5n_dt_bl(roi_V2,time,:),1),3)),squeeze(mean(mean(cond5n_dt_bl(roi_contour,time,:),1),3)),'coeff');
clear cond1n_dt_bl
clear cond5n_dt_bl
cd /fat2/Ariel_Gilad/Matlab_analysis/experiments/mask/legolas/right_hemisphere/psychophysics/2008_12_03/e
load cond1n_dt_bl
load cond5n_dt_bl
crosscov_cont_V2_circ(:,12)=xcov(squeeze(mean(mean(cond1n_dt_bl(roi_V2,time,:),1),3)),squeeze(mean(mean(cond1n_dt_bl(roi_contour,time,:),1),3)),'coeff');
crosscov_non_V2_circ(:,12)=xcov(squeeze(mean(mean(cond5n_dt_bl(roi_V2,time,:),1),3)),squeeze(mean(mean(cond5n_dt_bl(roi_contour,time,:),1),3)),'coeff');
clear cond1n_dt_bl
clear cond5n_dt_bl
cd /fat2/Ariel_Gilad/Matlab_analysis/experiments/mask/legolas/right_hemisphere/psychophysics/2008_12_03/f
load cond1n_dt_bl
load cond5n_dt_bl
crosscov_cont_V2_circ(:,13)=xcov(squeeze(mean(mean(cond1n_dt_bl(roi_V2,time,:),1),3)),squeeze(mean(mean(cond1n_dt_bl(roi_contour,time,:),1),3)),'coeff');
crosscov_non_V2_circ(:,13)=xcov(squeeze(mean(mean(cond5n_dt_bl(roi_V2,time,:),1),3)),squeeze(mean(mean(cond5n_dt_bl(roi_contour,time,:),1),3)),'coeff');


figure;plot(x,mean(crosscov_cont_V2_circ,2))
hold on
plot(x,mean(crosscov_non_V2_circ,2),'r')
xlim([-100 100])


figure;errorbar(x,mean(crosscov_cont_V2_circ,2),std(crosscov_cont_V2_circ,0,2)/sqrt(13))
hold on
errorbar(x,mean(crosscov_non_V2_circ,2),std(crosscov_non_V2_circ,0,2)/sqrt(13),'r')
xlim([-100 100])

figure;errorbar(x,mean(crosscov_cont_V2_circ-crosscov_non_V2_circ,2),std(crosscov_cont_V2_circ-crosscov_non_V2_circ,0,2)/sqrt(13))
xlim([-100 100])



%%


crosscov_cont_circ_circ=zeros(win*2-1,13);
crosscov_non_circ_circ=zeros(win*2-1,13);

cd /fat2/Ariel_Gilad/Matlab_analysis/experiments/mask/legolas/right_hemisphere/11_11_2008/c/elhanan_new
load myrois
load cond1n_dt_bl
load cond4n_dt_bl
crosscov_cont_circ_circ(:,1)=xcov(squeeze(mean(mean(cond1n_dt_bl(roi_contour2,time,:),1),3)),squeeze(mean(mean(cond1n_dt_bl(roi_contour2,time,:),1),3)),'coeff');
crosscov_non_circ_circ(:,1)=xcov(squeeze(mean(mean(cond4n_dt_bl(roi_contour2,time,:),1),3)),squeeze(mean(mean(cond4n_dt_bl(roi_contour2,time,:),1),3)),'coeff');
clear cond1n_dt_bl
clear cond4n_dt_bl
load cond2n_dt_bl
load cond5n_dt_bl
crosscov_cont_circ_circ(:,2)=xcov(squeeze(mean(mean(cond2n_dt_bl(roi_contour2,time,:),1),3)),squeeze(mean(mean(cond2n_dt_bl(roi_contour2,time,:),1),3)),'coeff');
crosscov_non_circ_circ(:,2)=xcov(squeeze(mean(mean(cond5n_dt_bl(roi_contour2,time,:),1),3)),squeeze(mean(mean(cond5n_dt_bl(roi_contour2,time,:),1),3)),'coeff');
clear cond2n_dt_bl
clear cond5n_dt_bl
cd /fat2/Ariel_Gilad/Matlab_analysis/experiments/mask/legolas/right_hemisphere/11_11_2008/d/elhanan_new
load cond1n_dt_bl
load cond4n_dt_bl
crosscov_cont_circ_circ(:,3)=xcov(squeeze(mean(mean(cond1n_dt_bl(roi_contour2,time,:),1),3)),squeeze(mean(mean(cond1n_dt_bl(roi_contour2,time,:),1),3)),'coeff');
crosscov_non_circ_circ(:,3)=xcov(squeeze(mean(mean(cond4n_dt_bl(roi_contour2,time,:),1),3)),squeeze(mean(mean(cond4n_dt_bl(roi_contour2,time,:),1),3)),'coeff');
clear cond1n_dt_bl
clear cond4n_dt_bl
load cond2n_dt_bl
load cond5n_dt_bl
crosscov_cont_circ_circ(:,4)=xcov(squeeze(mean(mean(cond2n_dt_bl(roi_contour2,time,:),1),3)),squeeze(mean(mean(cond2n_dt_bl(roi_contour2,time,:),1),3)),'coeff');
crosscov_non_circ_circ(:,4)=xcov(squeeze(mean(mean(cond5n_dt_bl(roi_contour2,time,:),1),3)),squeeze(mean(mean(cond5n_dt_bl(roi_contour2,time,:),1),3)),'coeff');
clear cond2n_dt_bl
clear cond5n_dt_bl
cd /fat2/Ariel_Gilad/Matlab_analysis/experiments/mask/legolas/right_hemisphere/psychophysics/2008_11_18/c
load myrois
load cond1n_dt_bl
load cond5n_dt_bl
crosscov_cont_circ_circ(:,5)=xcov(squeeze(mean(mean(cond1n_dt_bl(roi_contour,time,:),1),3)),squeeze(mean(mean(cond1n_dt_bl(roi_contour,time,:),1),3)),'coeff');
crosscov_non_circ_circ(:,5)=xcov(squeeze(mean(mean(cond5n_dt_bl(roi_contour,time,:),1),3)),squeeze(mean(mean(cond5n_dt_bl(roi_contour,time,:),1),3)),'coeff');
clear cond1n_dt_bl
clear cond5n_dt_bl
cd /fat2/Ariel_Gilad/Matlab_analysis/experiments/mask/legolas/right_hemisphere/psychophysics/2008_11_18/d
load cond1n_dt_bl
load cond5n_dt_bl
crosscov_cont_circ_circ(:,6)=xcov(squeeze(mean(mean(cond1n_dt_bl(roi_contour,time,:),1),3)),squeeze(mean(mean(cond1n_dt_bl(roi_contour,time,:),1),3)),'coeff');
crosscov_non_circ_circ(:,6)=xcov(squeeze(mean(mean(cond5n_dt_bl(roi_contour,time,:),1),3)),squeeze(mean(mean(cond5n_dt_bl(roi_contour,time,:),1),3)),'coeff');
clear cond1n_dt_bl
clear cond5n_dt_bl
cd /fat2/Ariel_Gilad/Matlab_analysis/experiments/mask/legolas/right_hemisphere/psychophysics/2008_11_18/e
load cond1n_dt_bl
load cond5n_dt_bl
crosscov_cont_circ_circ(:,7)=xcov(squeeze(mean(mean(cond1n_dt_bl(roi_contour,time,:),1),3)),squeeze(mean(mean(cond1n_dt_bl(roi_contour,time,:),1),3)),'coeff');
crosscov_non_circ_circ(:,7)=xcov(squeeze(mean(mean(cond5n_dt_bl(roi_contour,time,:),1),3)),squeeze(mean(mean(cond5n_dt_bl(roi_contour,time,:),1),3)),'coeff');
clear cond1n_dt_bl
clear cond5n_dt_bl
cd /fat2/Ariel_Gilad/Matlab_analysis/experiments/mask/legolas/right_hemisphere/psychophysics/2008_11_25/d
load 2511
load cond1n_dt_bl
load cond5n_dt_bl
crosscov_cont_circ_circ(:,8)=xcov(squeeze(mean(mean(cond1n_dt_bl(roi_contour,time,:),1),3)),squeeze(mean(mean(cond1n_dt_bl(roi_contour,time,:),1),3)),'coeff');
crosscov_non_circ_circ(:,8)=xcov(squeeze(mean(mean(cond5n_dt_bl(roi_contour,time,:),1),3)),squeeze(mean(mean(cond5n_dt_bl(roi_contour,time,:),1),3)),'coeff');
clear cond1n_dt_bl
clear cond5n_dt_bl
cd /fat2/Ariel_Gilad/Matlab_analysis/experiments/mask/legolas/right_hemisphere/psychophysics/2008_11_25/e
load cond1n_dt_bl
load cond5n_dt_bl
crosscov_cont_circ_circ(:,9)=xcov(squeeze(mean(mean(cond1n_dt_bl(roi_contour,time,:),1),3)),squeeze(mean(mean(cond1n_dt_bl(roi_contour,time,:),1),3)),'coeff');
crosscov_non_circ_circ(:,9)=xcov(squeeze(mean(mean(cond5n_dt_bl(roi_contour,time,:),1),3)),squeeze(mean(mean(cond5n_dt_bl(roi_contour,time,:),1),3)),'coeff');
clear cond1n_dt_bl
clear cond5n_dt_bl
cd /fat2/Ariel_Gilad/Matlab_analysis/experiments/mask/legolas/right_hemisphere/psychophysics/2008_11_25/f
load cond1n_dt_bl
load cond5n_dt_bl
crosscov_cont_circ_circ(:,10)=xcov(squeeze(mean(mean(cond1n_dt_bl(roi_contour,time,:),1),3)),squeeze(mean(mean(cond1n_dt_bl(roi_contour,time,:),1),3)),'coeff');
crosscov_non_circ_circ(:,10)=xcov(squeeze(mean(mean(cond5n_dt_bl(roi_contour,time,:),1),3)),squeeze(mean(mean(cond5n_dt_bl(roi_contour,time,:),1),3)),'coeff');
clear cond1n_dt_bl
clear cond5n_dt_bl
cd /fat2/Ariel_Gilad/Matlab_analysis/experiments/mask/legolas/right_hemisphere/psychophysics/2008_12_03/d
load myrois
load cond1n_dt_bl
load cond5n_dt_bl
crosscov_cont_circ_circ(:,11)=xcov(squeeze(mean(mean(cond1n_dt_bl(roi_contour,time,:),1),3)),squeeze(mean(mean(cond1n_dt_bl(roi_contour,time,:),1),3)),'coeff');
crosscov_non_circ_circ(:,11)=xcov(squeeze(mean(mean(cond5n_dt_bl(roi_contour,time,:),1),3)),squeeze(mean(mean(cond5n_dt_bl(roi_contour,time,:),1),3)),'coeff');
clear cond1n_dt_bl
clear cond5n_dt_bl
cd /fat2/Ariel_Gilad/Matlab_analysis/experiments/mask/legolas/right_hemisphere/psychophysics/2008_12_03/e
load cond1n_dt_bl
load cond5n_dt_bl
crosscov_cont_circ_circ(:,12)=xcov(squeeze(mean(mean(cond1n_dt_bl(roi_contour,time,:),1),3)),squeeze(mean(mean(cond1n_dt_bl(roi_contour,time,:),1),3)),'coeff');
crosscov_non_circ_circ(:,12)=xcov(squeeze(mean(mean(cond5n_dt_bl(roi_contour,time,:),1),3)),squeeze(mean(mean(cond5n_dt_bl(roi_contour,time,:),1),3)),'coeff');
clear cond1n_dt_bl
clear cond5n_dt_bl
cd /fat2/Ariel_Gilad/Matlab_analysis/experiments/mask/legolas/right_hemisphere/psychophysics/2008_12_03/f
load cond1n_dt_bl
load cond5n_dt_bl
crosscov_cont_circ_circ(:,13)=xcov(squeeze(mean(mean(cond1n_dt_bl(roi_contour,time,:),1),3)),squeeze(mean(mean(cond1n_dt_bl(roi_contour,time,:),1),3)),'coeff');
crosscov_non_circ_circ(:,13)=xcov(squeeze(mean(mean(cond5n_dt_bl(roi_contour,time,:),1),3)),squeeze(mean(mean(cond5n_dt_bl(roi_contour,time,:),1),3)),'coeff');


figure;plot(x,mean(crosscov_cont_circ_circ,2))
hold on
plot(x,mean(crosscov_non_circ_circ,2),'r')
xlim([-100 100])



figure;errorbar(x,mean(crosscov_cont_circ_circ-crosscov_non_circ_circ,2),std(crosscov_cont_circ_circ-crosscov_non_circ_circ,0,2)/sqrt(13))
xlim([-100 100])







%%


crosscov_cont_V2_V2=zeros(win*2-1,13);
crosscov_non_V2_V2=zeros(win*2-1,13);

cd /fat2/Ariel_Gilad/Matlab_analysis/experiments/mask/legolas/right_hemisphere/11_11_2008/c/elhanan_new
load myrois
load cond1n_dt_bl
load cond4n_dt_bl
crosscov_cont_V2_V2(:,1)=xcov(squeeze(mean(mean(cond1n_dt_bl(roi_V2,time,:),1),3)),squeeze(mean(mean(cond1n_dt_bl(roi_V2,time,:),1),3)),'coeff');
crosscov_non_V2_V2(:,1)=xcov(squeeze(mean(mean(cond4n_dt_bl(roi_V2,time,:),1),3)),squeeze(mean(mean(cond4n_dt_bl(roi_V2,time,:),1),3)),'coeff');
clear cond1n_dt_bl
clear cond4n_dt_bl
load cond2n_dt_bl
load cond5n_dt_bl
crosscov_cont_V2_V2(:,2)=xcov(squeeze(mean(mean(cond2n_dt_bl(roi_V2,time,:),1),3)),squeeze(mean(mean(cond2n_dt_bl(roi_V2,time,:),1),3)),'coeff');
crosscov_non_V2_V2(:,2)=xcov(squeeze(mean(mean(cond5n_dt_bl(roi_V2,time,:),1),3)),squeeze(mean(mean(cond5n_dt_bl(roi_V2,time,:),1),3)),'coeff');
clear cond2n_dt_bl
clear cond5n_dt_bl
cd /fat2/Ariel_Gilad/Matlab_analysis/experiments/mask/legolas/right_hemisphere/11_11_2008/d/elhanan_new
load cond1n_dt_bl
load cond4n_dt_bl
crosscov_cont_V2_V2(:,3)=xcov(squeeze(mean(mean(cond1n_dt_bl(roi_V2,time,:),1),3)),squeeze(mean(mean(cond1n_dt_bl(roi_V2,time,:),1),3)),'coeff');
crosscov_non_V2_V2(:,3)=xcov(squeeze(mean(mean(cond4n_dt_bl(roi_V2,time,:),1),3)),squeeze(mean(mean(cond4n_dt_bl(roi_V2,time,:),1),3)),'coeff');
clear cond1n_dt_bl
clear cond4n_dt_bl
load cond2n_dt_bl
load cond5n_dt_bl
crosscov_cont_V2_V2(:,4)=xcov(squeeze(mean(mean(cond2n_dt_bl(roi_V2,time,:),1),3)),squeeze(mean(mean(cond2n_dt_bl(roi_V2,time,:),1),3)),'coeff');
crosscov_non_V2_V2(:,4)=xcov(squeeze(mean(mean(cond5n_dt_bl(roi_V2,time,:),1),3)),squeeze(mean(mean(cond5n_dt_bl(roi_V2,time,:),1),3)),'coeff');
clear cond2n_dt_bl
clear cond5n_dt_bl
cd /fat2/Ariel_Gilad/Matlab_analysis/experiments/mask/legolas/right_hemisphere/psychophysics/2008_11_18/c
load myrois
load cond1n_dt_bl
load cond5n_dt_bl
crosscov_cont_V2_V2(:,5)=xcov(squeeze(mean(mean(cond1n_dt_bl(roi_V2,time,:),1),3)),squeeze(mean(mean(cond1n_dt_bl(roi_V2,time,:),1),3)),'coeff');
crosscov_non_V2_V2(:,5)=xcov(squeeze(mean(mean(cond5n_dt_bl(roi_V2,time,:),1),3)),squeeze(mean(mean(cond5n_dt_bl(roi_V2,time,:),1),3)),'coeff');
clear cond1n_dt_bl
clear cond5n_dt_bl
cd /fat2/Ariel_Gilad/Matlab_analysis/experiments/mask/legolas/right_hemisphere/psychophysics/2008_11_18/d
load cond1n_dt_bl
load cond5n_dt_bl
crosscov_cont_V2_V2(:,6)=xcov(squeeze(mean(mean(cond1n_dt_bl(roi_V2,time,:),1),3)),squeeze(mean(mean(cond1n_dt_bl(roi_V2,time,:),1),3)),'coeff');
crosscov_non_V2_V2(:,6)=xcov(squeeze(mean(mean(cond5n_dt_bl(roi_V2,time,:),1),3)),squeeze(mean(mean(cond5n_dt_bl(roi_V2,time,:),1),3)),'coeff');
clear cond1n_dt_bl
clear cond5n_dt_bl
cd /fat2/Ariel_Gilad/Matlab_analysis/experiments/mask/legolas/right_hemisphere/psychophysics/2008_11_18/e
load cond1n_dt_bl
load cond5n_dt_bl
crosscov_cont_V2_V2(:,7)=xcov(squeeze(mean(mean(cond1n_dt_bl(roi_V2,time,:),1),3)),squeeze(mean(mean(cond1n_dt_bl(roi_V2,time,:),1),3)),'coeff');
crosscov_non_V2_V2(:,7)=xcov(squeeze(mean(mean(cond5n_dt_bl(roi_V2,time,:),1),3)),squeeze(mean(mean(cond5n_dt_bl(roi_V2,time,:),1),3)),'coeff');
clear cond1n_dt_bl
clear cond5n_dt_bl
cd /fat2/Ariel_Gilad/Matlab_analysis/experiments/mask/legolas/right_hemisphere/psychophysics/2008_11_25/d
load 2511
load cond1n_dt_bl
load cond5n_dt_bl
crosscov_cont_V2_V2(:,8)=xcov(squeeze(mean(mean(cond1n_dt_bl(roi_V2,time,:),1),3)),squeeze(mean(mean(cond1n_dt_bl(roi_V2,time,:),1),3)),'coeff');
crosscov_non_V2_V2(:,8)=xcov(squeeze(mean(mean(cond5n_dt_bl(roi_V2,time,:),1),3)),squeeze(mean(mean(cond5n_dt_bl(roi_V2,time,:),1),3)),'coeff');
clear cond1n_dt_bl
clear cond5n_dt_bl
cd /fat2/Ariel_Gilad/Matlab_analysis/experiments/mask/legolas/right_hemisphere/psychophysics/2008_11_25/e
load cond1n_dt_bl
load cond5n_dt_bl
crosscov_cont_V2_V2(:,9)=xcov(squeeze(mean(mean(cond1n_dt_bl(roi_V2,time,:),1),3)),squeeze(mean(mean(cond1n_dt_bl(roi_V2,time,:),1),3)),'coeff');
crosscov_non_V2_V2(:,9)=xcov(squeeze(mean(mean(cond5n_dt_bl(roi_V2,time,:),1),3)),squeeze(mean(mean(cond5n_dt_bl(roi_V2,time,:),1),3)),'coeff');
clear cond1n_dt_bl
clear cond5n_dt_bl
cd /fat2/Ariel_Gilad/Matlab_analysis/experiments/mask/legolas/right_hemisphere/psychophysics/2008_11_25/f
load cond1n_dt_bl
load cond5n_dt_bl
crosscov_cont_V2_V2(:,10)=xcov(squeeze(mean(mean(cond1n_dt_bl(roi_V2,time,:),1),3)),squeeze(mean(mean(cond1n_dt_bl(roi_V2,time,:),1),3)),'coeff');
crosscov_non_V2_V2(:,10)=xcov(squeeze(mean(mean(cond5n_dt_bl(roi_V2,time,:),1),3)),squeeze(mean(mean(cond5n_dt_bl(roi_V2,time,:),1),3)),'coeff');
clear cond1n_dt_bl
clear cond5n_dt_bl
cd /fat2/Ariel_Gilad/Matlab_analysis/experiments/mask/legolas/right_hemisphere/psychophysics/2008_12_03/d
load myrois
load cond1n_dt_bl
load cond5n_dt_bl
crosscov_cont_V2_V2(:,11)=xcov(squeeze(mean(mean(cond1n_dt_bl(roi_V2,time,:),1),3)),squeeze(mean(mean(cond1n_dt_bl(roi_V2,time,:),1),3)),'coeff');
crosscov_non_V2_V2(:,11)=xcov(squeeze(mean(mean(cond5n_dt_bl(roi_V2,time,:),1),3)),squeeze(mean(mean(cond5n_dt_bl(roi_V2,time,:),1),3)),'coeff');
clear cond1n_dt_bl
clear cond5n_dt_bl
cd /fat2/Ariel_Gilad/Matlab_analysis/experiments/mask/legolas/right_hemisphere/psychophysics/2008_12_03/e
load cond1n_dt_bl
load cond5n_dt_bl
crosscov_cont_V2_V2(:,12)=xcov(squeeze(mean(mean(cond1n_dt_bl(roi_V2,time,:),1),3)),squeeze(mean(mean(cond1n_dt_bl(roi_V2,time,:),1),3)),'coeff');
crosscov_non_V2_V2(:,12)=xcov(squeeze(mean(mean(cond5n_dt_bl(roi_V2,time,:),1),3)),squeeze(mean(mean(cond5n_dt_bl(roi_V2,time,:),1),3)),'coeff');
clear cond1n_dt_bl
clear cond5n_dt_bl
cd /fat2/Ariel_Gilad/Matlab_analysis/experiments/mask/legolas/right_hemisphere/psychophysics/2008_12_03/f
load cond1n_dt_bl
load cond5n_dt_bl
crosscov_cont_V2_V2(:,13)=xcov(squeeze(mean(mean(cond1n_dt_bl(roi_V2,time,:),1),3)),squeeze(mean(mean(cond1n_dt_bl(roi_V2,time,:),1),3)),'coeff');
crosscov_non_V2_V2(:,13)=xcov(squeeze(mean(mean(cond5n_dt_bl(roi_V2,time,:),1),3)),squeeze(mean(mean(cond5n_dt_bl(roi_V2,time,:),1),3)),'coeff');


figure;plot(x,mean(crosscov_cont_V2_V2,2))
hold on
plot(x,mean(crosscov_non_V2_V2,2),'r')
xlim([-100 100])



figure;errorbar(x,mean(crosscov_cont_V2_V2-crosscov_non_V2_V2,2),std(crosscov_cont_V2_V2-crosscov_non_V2_V2,0,2)/sqrt(13))
xlim([-100 100])


%%

crosscov_cont_V2_bg=zeros(win*2-1,13);
crosscov_non_V2_bg=zeros(win*2-1,13);

cd /fat2/Ariel_Gilad/Matlab_analysis/experiments/mask/legolas/right_hemisphere/11_11_2008/c/elhanan_new
load myrois
load cond1n_dt_bl
load cond4n_dt_bl
crosscov_cont_V2_bg(:,1)=xcov(squeeze(mean(mean(cond1n_dt_bl(roi_V2,time,:),1),3)),squeeze(mean(mean(cond1n_dt_bl(roi_maskin,time,:),1),3)),'coeff');
crosscov_non_V2_bg(:,1)=xcov(squeeze(mean(mean(cond4n_dt_bl(roi_V2,time,:),1),3)),squeeze(mean(mean(cond4n_dt_bl(roi_maskin,time,:),1),3)),'coeff');
clear cond1n_dt_bl
clear cond4n_dt_bl
load cond2n_dt_bl
load cond5n_dt_bl
crosscov_cont_V2_bg(:,2)=xcov(squeeze(mean(mean(cond2n_dt_bl(roi_V2,time,:),1),3)),squeeze(mean(mean(cond2n_dt_bl(roi_maskin,time,:),1),3)),'coeff');
crosscov_non_V2_bg(:,2)=xcov(squeeze(mean(mean(cond5n_dt_bl(roi_V2,time,:),1),3)),squeeze(mean(mean(cond5n_dt_bl(roi_maskin,time,:),1),3)),'coeff');
clear cond2n_dt_bl
clear cond5n_dt_bl
cd /fat2/Ariel_Gilad/Matlab_analysis/experiments/mask/legolas/right_hemisphere/11_11_2008/d/elhanan_new
load cond1n_dt_bl
load cond4n_dt_bl
crosscov_cont_V2_bg(:,3)=xcov(squeeze(mean(mean(cond1n_dt_bl(roi_V2,time,:),1),3)),squeeze(mean(mean(cond1n_dt_bl(roi_maskin,time,:),1),3)),'coeff');
crosscov_non_V2_bg(:,3)=xcov(squeeze(mean(mean(cond4n_dt_bl(roi_V2,time,:),1),3)),squeeze(mean(mean(cond4n_dt_bl(roi_maskin,time,:),1),3)),'coeff');
clear cond1n_dt_bl
clear cond4n_dt_bl
load cond2n_dt_bl
load cond5n_dt_bl
crosscov_cont_V2_bg(:,4)=xcov(squeeze(mean(mean(cond2n_dt_bl(roi_V2,time,:),1),3)),squeeze(mean(mean(cond2n_dt_bl(roi_maskin,time,:),1),3)),'coeff');
crosscov_non_V2_bg(:,4)=xcov(squeeze(mean(mean(cond5n_dt_bl(roi_V2,time,:),1),3)),squeeze(mean(mean(cond5n_dt_bl(roi_maskin,time,:),1),3)),'coeff');
clear cond2n_dt_bl
clear cond5n_dt_bl
cd /fat2/Ariel_Gilad/Matlab_analysis/experiments/mask/legolas/right_hemisphere/psychophysics/2008_11_18/c
load myrois
load cond1n_dt_bl
load cond5n_dt_bl
crosscov_cont_V2_bg(:,5)=xcov(squeeze(mean(mean(cond1n_dt_bl(roi_V2,time,:),1),3)),squeeze(mean(mean(cond1n_dt_bl(roi_bg_in,time,:),1),3)),'coeff');
crosscov_non_V2_bg(:,5)=xcov(squeeze(mean(mean(cond5n_dt_bl(roi_V2,time,:),1),3)),squeeze(mean(mean(cond5n_dt_bl(roi_bg_in,time,:),1),3)),'coeff');
clear cond1n_dt_bl
clear cond5n_dt_bl
cd /fat2/Ariel_Gilad/Matlab_analysis/experiments/mask/legolas/right_hemisphere/psychophysics/2008_11_18/d
load cond1n_dt_bl
load cond5n_dt_bl
crosscov_cont_V2_bg(:,6)=xcov(squeeze(mean(mean(cond1n_dt_bl(roi_V2,time,:),1),3)),squeeze(mean(mean(cond1n_dt_bl(roi_bg_in,time,:),1),3)),'coeff');
crosscov_non_V2_bg(:,6)=xcov(squeeze(mean(mean(cond5n_dt_bl(roi_V2,time,:),1),3)),squeeze(mean(mean(cond5n_dt_bl(roi_bg_in,time,:),1),3)),'coeff');
clear cond1n_dt_bl
clear cond5n_dt_bl
cd /fat2/Ariel_Gilad/Matlab_analysis/experiments/mask/legolas/right_hemisphere/psychophysics/2008_11_18/e
load cond1n_dt_bl
load cond5n_dt_bl
crosscov_cont_V2_bg(:,7)=xcov(squeeze(mean(mean(cond1n_dt_bl(roi_V2,time,:),1),3)),squeeze(mean(mean(cond1n_dt_bl(roi_bg_in,time,:),1),3)),'coeff');
crosscov_non_V2_bg(:,7)=xcov(squeeze(mean(mean(cond5n_dt_bl(roi_V2,time,:),1),3)),squeeze(mean(mean(cond5n_dt_bl(roi_bg_in,time,:),1),3)),'coeff');
clear cond1n_dt_bl
clear cond5n_dt_bl
cd /fat2/Ariel_Gilad/Matlab_analysis/experiments/mask/legolas/right_hemisphere/psychophysics/2008_11_25/d
load 2511
load cond1n_dt_bl
load cond5n_dt_bl
crosscov_cont_V2_bg(:,8)=xcov(squeeze(mean(mean(cond1n_dt_bl(roi_V2,time,:),1),3)),squeeze(mean(mean(cond1n_dt_bl(roi_bg_in,time,:),1),3)),'coeff');
crosscov_non_V2_bg(:,8)=xcov(squeeze(mean(mean(cond5n_dt_bl(roi_V2,time,:),1),3)),squeeze(mean(mean(cond5n_dt_bl(roi_bg_in,time,:),1),3)),'coeff');
clear cond1n_dt_bl
clear cond5n_dt_bl
cd /fat2/Ariel_Gilad/Matlab_analysis/experiments/mask/legolas/right_hemisphere/psychophysics/2008_11_25/e
load cond1n_dt_bl
load cond5n_dt_bl
crosscov_cont_V2_bg(:,9)=xcov(squeeze(mean(mean(cond1n_dt_bl(roi_V2,time,:),1),3)),squeeze(mean(mean(cond1n_dt_bl(roi_bg_in,time,:),1),3)),'coeff');
crosscov_non_V2_bg(:,9)=xcov(squeeze(mean(mean(cond5n_dt_bl(roi_V2,time,:),1),3)),squeeze(mean(mean(cond5n_dt_bl(roi_bg_in,time,:),1),3)),'coeff');
clear cond1n_dt_bl
clear cond5n_dt_bl
cd /fat2/Ariel_Gilad/Matlab_analysis/experiments/mask/legolas/right_hemisphere/psychophysics/2008_11_25/f
load cond1n_dt_bl
load cond5n_dt_bl
crosscov_cont_V2_bg(:,10)=xcov(squeeze(mean(mean(cond1n_dt_bl(roi_V2,time,:),1),3)),squeeze(mean(mean(cond1n_dt_bl(roi_bg_in,time,:),1),3)),'coeff');
crosscov_non_V2_bg(:,10)=xcov(squeeze(mean(mean(cond5n_dt_bl(roi_V2,time,:),1),3)),squeeze(mean(mean(cond5n_dt_bl(roi_bg_in,time,:),1),3)),'coeff');
clear cond1n_dt_bl
clear cond5n_dt_bl
cd /fat2/Ariel_Gilad/Matlab_analysis/experiments/mask/legolas/right_hemisphere/psychophysics/2008_12_03/d
load myrois
load cond1n_dt_bl
load cond5n_dt_bl
crosscov_cont_V2_bg(:,11)=xcov(squeeze(mean(mean(cond1n_dt_bl(roi_V2,time,:),1),3)),squeeze(mean(mean(cond1n_dt_bl(roi_bg_in,time,:),1),3)),'coeff');
crosscov_non_V2_bg(:,11)=xcov(squeeze(mean(mean(cond5n_dt_bl(roi_V2,time,:),1),3)),squeeze(mean(mean(cond5n_dt_bl(roi_bg_in,time,:),1),3)),'coeff');
clear cond1n_dt_bl
clear cond5n_dt_bl
cd /fat2/Ariel_Gilad/Matlab_analysis/experiments/mask/legolas/right_hemisphere/psychophysics/2008_12_03/e
load cond1n_dt_bl
load cond5n_dt_bl
crosscov_cont_V2_bg(:,12)=xcov(squeeze(mean(mean(cond1n_dt_bl(roi_V2,time,:),1),3)),squeeze(mean(mean(cond1n_dt_bl(roi_bg_in,time,:),1),3)),'coeff');
crosscov_non_V2_bg(:,12)=xcov(squeeze(mean(mean(cond5n_dt_bl(roi_V2,time,:),1),3)),squeeze(mean(mean(cond5n_dt_bl(roi_bg_in,time,:),1),3)),'coeff');
clear cond1n_dt_bl
clear cond5n_dt_bl
cd /fat2/Ariel_Gilad/Matlab_analysis/experiments/mask/legolas/right_hemisphere/psychophysics/2008_12_03/f
load cond1n_dt_bl
load cond5n_dt_bl
crosscov_cont_V2_bg(:,13)=xcov(squeeze(mean(mean(cond1n_dt_bl(roi_V2,time,:),1),3)),squeeze(mean(mean(cond1n_dt_bl(roi_bg_in,time,:),1),3)),'coeff');
crosscov_non_V2_bg(:,13)=xcov(squeeze(mean(mean(cond5n_dt_bl(roi_V2,time,:),1),3)),squeeze(mean(mean(cond5n_dt_bl(roi_bg_in,time,:),1),3)),'coeff');


figure;plot(x,mean(crosscov_cont_V2_bg,2))
hold on
plot(x,mean(crosscov_non_V2_bg,2),'r')
xlim([-100 100])


figure;errorbar(x,mean(crosscov_cont_V2_bg,2),std(crosscov_cont_V2_bg,0,2)/sqrt(13))
hold on
errorbar(x,mean(crosscov_non_V2_bg,2),std(crosscov_non_V2_bg,0,2)/sqrt(13),'r')
xlim([-100 100])

figure;errorbar(x,mean(crosscov_cont_V2_bg-crosscov_non_V2_bg,2),std(crosscov_cont_V2_bg-crosscov_non_V2_bg,0,2)/sqrt(13))
xlim([-100 100])



%%

crosscov_cont_circ_bg=zeros(win*2-1,13);
crosscov_non_circ_bg=zeros(win*2-1,13);

cd /fat2/Ariel_Gilad/Matlab_analysis/experiments/mask/legolas/right_hemisphere/11_11_2008/c/elhanan_new
load myrois
load cond1n_dt_bl
load cond4n_dt_bl
crosscov_cont_circ_bg(:,1)=xcov(squeeze(mean(mean(cond1n_dt_bl(roi_contour,time,:),1),3)),squeeze(mean(mean(cond1n_dt_bl(roi_maskin,time,:),1),3)),'coeff');
crosscov_non_circ_bg(:,1)=xcov(squeeze(mean(mean(cond4n_dt_bl(roi_contour,time,:),1),3)),squeeze(mean(mean(cond4n_dt_bl(roi_maskin,time,:),1),3)),'coeff');
clear cond1n_dt_bl
clear cond4n_dt_bl
load cond2n_dt_bl
load cond5n_dt_bl
crosscov_cont_circ_bg(:,2)=xcov(squeeze(mean(mean(cond2n_dt_bl(roi_contour,time,:),1),3)),squeeze(mean(mean(cond2n_dt_bl(roi_maskin,time,:),1),3)),'coeff');
crosscov_non_circ_bg(:,2)=xcov(squeeze(mean(mean(cond5n_dt_bl(roi_contour,time,:),1),3)),squeeze(mean(mean(cond5n_dt_bl(roi_maskin,time,:),1),3)),'coeff');
clear cond2n_dt_bl
clear cond5n_dt_bl
cd /fat2/Ariel_Gilad/Matlab_analysis/experiments/mask/legolas/right_hemisphere/11_11_2008/d/elhanan_new
load cond1n_dt_bl
load cond4n_dt_bl
crosscov_cont_circ_bg(:,3)=xcov(squeeze(mean(mean(cond1n_dt_bl(roi_contour,time,:),1),3)),squeeze(mean(mean(cond1n_dt_bl(roi_maskin,time,:),1),3)),'coeff');
crosscov_non_circ_bg(:,3)=xcov(squeeze(mean(mean(cond4n_dt_bl(roi_contour,time,:),1),3)),squeeze(mean(mean(cond4n_dt_bl(roi_maskin,time,:),1),3)),'coeff');
clear cond1n_dt_bl
clear cond4n_dt_bl
load cond2n_dt_bl
load cond5n_dt_bl
crosscov_cont_circ_bg(:,4)=xcov(squeeze(mean(mean(cond2n_dt_bl(roi_contour,time,:),1),3)),squeeze(mean(mean(cond2n_dt_bl(roi_maskin,time,:),1),3)),'coeff');
crosscov_non_circ_bg(:,4)=xcov(squeeze(mean(mean(cond5n_dt_bl(roi_contour,time,:),1),3)),squeeze(mean(mean(cond5n_dt_bl(roi_maskin,time,:),1),3)),'coeff');
clear cond2n_dt_bl
clear cond5n_dt_bl
cd /fat2/Ariel_Gilad/Matlab_analysis/experiments/mask/legolas/right_hemisphere/psychophysics/2008_11_18/c
load myrois
load cond1n_dt_bl
load cond5n_dt_bl
crosscov_cont_circ_bg(:,5)=xcov(squeeze(mean(mean(cond1n_dt_bl(roi_contour,time,:),1),3)),squeeze(mean(mean(cond1n_dt_bl(roi_bg_in,time,:),1),3)),'coeff');
crosscov_non_circ_bg(:,5)=xcov(squeeze(mean(mean(cond5n_dt_bl(roi_contour,time,:),1),3)),squeeze(mean(mean(cond5n_dt_bl(roi_bg_in,time,:),1),3)),'coeff');
clear cond1n_dt_bl
clear cond5n_dt_bl
cd /fat2/Ariel_Gilad/Matlab_analysis/experiments/mask/legolas/right_hemisphere/psychophysics/2008_11_18/d
load cond1n_dt_bl
load cond5n_dt_bl
crosscov_cont_circ_bg(:,6)=xcov(squeeze(mean(mean(cond1n_dt_bl(roi_contour,time,:),1),3)),squeeze(mean(mean(cond1n_dt_bl(roi_bg_in,time,:),1),3)),'coeff');
crosscov_non_circ_bg(:,6)=xcov(squeeze(mean(mean(cond5n_dt_bl(roi_contour,time,:),1),3)),squeeze(mean(mean(cond5n_dt_bl(roi_bg_in,time,:),1),3)),'coeff');
clear cond1n_dt_bl
clear cond5n_dt_bl
cd /fat2/Ariel_Gilad/Matlab_analysis/experiments/mask/legolas/right_hemisphere/psychophysics/2008_11_18/e
load cond1n_dt_bl
load cond5n_dt_bl
crosscov_cont_circ_bg(:,7)=xcov(squeeze(mean(mean(cond1n_dt_bl(roi_contour,time,:),1),3)),squeeze(mean(mean(cond1n_dt_bl(roi_bg_in,time,:),1),3)),'coeff');
crosscov_non_circ_bg(:,7)=xcov(squeeze(mean(mean(cond5n_dt_bl(roi_contour,time,:),1),3)),squeeze(mean(mean(cond5n_dt_bl(roi_bg_in,time,:),1),3)),'coeff');
clear cond1n_dt_bl
clear cond5n_dt_bl
cd /fat2/Ariel_Gilad/Matlab_analysis/experiments/mask/legolas/right_hemisphere/psychophysics/2008_11_25/d
load 2511
load cond1n_dt_bl
load cond5n_dt_bl
crosscov_cont_circ_bg(:,8)=xcov(squeeze(mean(mean(cond1n_dt_bl(roi_contour,time,:),1),3)),squeeze(mean(mean(cond1n_dt_bl(roi_bg_in,time,:),1),3)),'coeff');
crosscov_non_circ_bg(:,8)=xcov(squeeze(mean(mean(cond5n_dt_bl(roi_contour,time,:),1),3)),squeeze(mean(mean(cond5n_dt_bl(roi_bg_in,time,:),1),3)),'coeff');
clear cond1n_dt_bl
clear cond5n_dt_bl
cd /fat2/Ariel_Gilad/Matlab_analysis/experiments/mask/legolas/right_hemisphere/psychophysics/2008_11_25/e
load cond1n_dt_bl
load cond5n_dt_bl
crosscov_cont_circ_bg(:,9)=xcov(squeeze(mean(mean(cond1n_dt_bl(roi_contour,time,:),1),3)),squeeze(mean(mean(cond1n_dt_bl(roi_bg_in,time,:),1),3)),'coeff');
crosscov_non_circ_bg(:,9)=xcov(squeeze(mean(mean(cond5n_dt_bl(roi_contour,time,:),1),3)),squeeze(mean(mean(cond5n_dt_bl(roi_bg_in,time,:),1),3)),'coeff');
clear cond1n_dt_bl
clear cond5n_dt_bl
cd /fat2/Ariel_Gilad/Matlab_analysis/experiments/mask/legolas/right_hemisphere/psychophysics/2008_11_25/f
load cond1n_dt_bl
load cond5n_dt_bl
crosscov_cont_circ_bg(:,10)=xcov(squeeze(mean(mean(cond1n_dt_bl(roi_contour,time,:),1),3)),squeeze(mean(mean(cond1n_dt_bl(roi_bg_in,time,:),1),3)),'coeff');
crosscov_non_circ_bg(:,10)=xcov(squeeze(mean(mean(cond5n_dt_bl(roi_contour,time,:),1),3)),squeeze(mean(mean(cond5n_dt_bl(roi_bg_in,time,:),1),3)),'coeff');
clear cond1n_dt_bl
clear cond5n_dt_bl
cd /fat2/Ariel_Gilad/Matlab_analysis/experiments/mask/legolas/right_hemisphere/psychophysics/2008_12_03/d
load myrois
load cond1n_dt_bl
load cond5n_dt_bl
crosscov_cont_circ_bg(:,11)=xcov(squeeze(mean(mean(cond1n_dt_bl(roi_contour,time,:),1),3)),squeeze(mean(mean(cond1n_dt_bl(roi_bg_in,time,:),1),3)),'coeff');
crosscov_non_circ_bg(:,11)=xcov(squeeze(mean(mean(cond5n_dt_bl(roi_contour,time,:),1),3)),squeeze(mean(mean(cond5n_dt_bl(roi_bg_in,time,:),1),3)),'coeff');
clear cond1n_dt_bl
clear cond5n_dt_bl
cd /fat2/Ariel_Gilad/Matlab_analysis/experiments/mask/legolas/right_hemisphere/psychophysics/2008_12_03/e
load cond1n_dt_bl
load cond5n_dt_bl
crosscov_cont_circ_bg(:,12)=xcov(squeeze(mean(mean(cond1n_dt_bl(roi_contour,time,:),1),3)),squeeze(mean(mean(cond1n_dt_bl(roi_bg_in,time,:),1),3)),'coeff');
crosscov_non_circ_bg(:,12)=xcov(squeeze(mean(mean(cond5n_dt_bl(roi_contour,time,:),1),3)),squeeze(mean(mean(cond5n_dt_bl(roi_bg_in,time,:),1),3)),'coeff');
clear cond1n_dt_bl
clear cond5n_dt_bl
cd /fat2/Ariel_Gilad/Matlab_analysis/experiments/mask/legolas/right_hemisphere/psychophysics/2008_12_03/f
load cond1n_dt_bl
load cond5n_dt_bl
crosscov_cont_circ_bg(:,13)=xcov(squeeze(mean(mean(cond1n_dt_bl(roi_contour,time,:),1),3)),squeeze(mean(mean(cond1n_dt_bl(roi_bg_in,time,:),1),3)),'coeff');
crosscov_non_circ_bg(:,13)=xcov(squeeze(mean(mean(cond5n_dt_bl(roi_contour,time,:),1),3)),squeeze(mean(mean(cond5n_dt_bl(roi_bg_in,time,:),1),3)),'coeff');


figure;plot(x,mean(crosscov_cont_circ_bg,2))
hold on
plot(x,mean(crosscov_non_circ_bg,2),'r')
xlim([-100 100])


figure;errorbar(x,mean(crosscov_cont_circ_bg,2),std(crosscov_cont_circ_bg,0,2)/sqrt(13))
hold on
errorbar(x,mean(crosscov_non_circ_bg,2),std(crosscov_non_circ_bg,0,2)/sqrt(13),'r')
xlim([-100 100])

figure;errorbar(x,mean(crosscov_cont_circ_bg-crosscov_non_circ_bg,2),std(crosscov_cont_circ_bg-crosscov_non_circ_bg,0,2)/sqrt(13))
xlim([-100 100])




%%

figure;plot(x,mean(crosscov_cont_V2_V2,2))
hold on
plot(x,mean(crosscov_non_V2_V2,2),'r')
xlim([-100 100])

figure;plot(x,mean(crosscov_cont_circ_circ,2))
hold on
plot(x,mean(crosscov_non_circ_circ,2),'r')
xlim([-100 100])

figure;plot(x,mean(crosscov_cont_V2_circ,2))
hold on
plot(x,mean(crosscov_non_V2_circ,2),'r')
xlim([-100 100])


figure;plot(x,mean(crosscov_cont_V2_V2-crosscov_non_V2_V2,2))
hold on
plot(x,mean(crosscov_cont_V2_circ-crosscov_non_V2_circ,2),'r')
plot(x,mean(crosscov_cont_circ_circ-crosscov_non_circ_circ,2),'g')


figure;errorbar(x,mean(crosscov_cont_V2_V2-crosscov_non_V2_V2,2),std(crosscov_cont_V2_V2-crosscov_non_V2_V2,0,2)/sqrt(13),'g')
hold on
errorbar(x,mean(crosscov_cont_circ_circ-crosscov_non_circ_circ,2),std(crosscov_cont_circ_circ-crosscov_non_circ_circ,0,2)/sqrt(13),'b')
errorbar(x,mean(crosscov_cont_V2_circ-crosscov_non_V2_circ,2),std(crosscov_cont_V2_circ-crosscov_non_V2_circ,0,2)/sqrt(13),'r')
errorbar(x,mean(crosscov_cont_V2_bg-crosscov_non_V2_bg,2),std(crosscov_cont_V2_bg-crosscov_non_V2_bg,0,2)/sqrt(13),'c')
errorbar(x,mean(crosscov_cont_circ_bg-crosscov_non_circ_bg,2),std(crosscov_cont_circ_bg-crosscov_non_circ_bg,0,2)/sqrt(13),'m')
xlim([-100 100])


figure;errorbar(x,mean(crosscov_cont_V2_circ,2),std(crosscov_cont_V2_circ,0,2)/sqrt(13))
hold on
errorbar(x,mean(crosscov_non_V2_circ,2),std(crosscov_non_V2_circ,0,2)/sqrt(13),'r')
xlim([-100 100])

figure;errorbar(x,mean(crosscov_cont_V2_V2,2),std(crosscov_cont_V2_V2,0,2)/sqrt(13))
hold on
errorbar(x,mean(crosscov_non_V2_V2,2),std(crosscov_non_V2_V2,0,2)/sqrt(13),'r')
xlim([-100 100])

figure;errorbar(x,mean(crosscov_cont_circ_circ,2),std(crosscov_cont_circ_circ,0,2)/sqrt(13))
hold on
errorbar(x,mean(crosscov_non_circ_circ,2),std(crosscov_non_circ_circ,0,2)/sqrt(13),'r')
xlim([-100 100])

figure;errorbar(x,mean(crosscov_cont_circ_bg,2),std(crosscov_cont_circ_bg,0,2)/sqrt(13))
hold on
errorbar(x,mean(crosscov_non_circ_bg,2),std(crosscov_non_circ_bg,0,2)/sqrt(13),'r')
xlim([-100 100])

figure;errorbar(x,mean(crosscov_cont_V2_bg,2),std(crosscov_cont_V2_bg,0,2)/sqrt(13))
hold on
errorbar(x,mean(crosscov_non_V2_bg,2),std(crosscov_non_V2_bg,0,2)/sqrt(13),'r')
xlim([-100 100])


%%


for i=1:31
    p1(i)=signrank(crosscov_cont_V2_circ(i,:)-crosscov_non_V2_circ(i,:));
    p2(i)=signrank(crosscov_cont_V2_V2(i,:)-crosscov_non_V2_V2(i,:));
    p3(i)=signrank(crosscov_cont_circ_circ(i,:)-crosscov_non_circ_circ(i,:));
    p4(i)=signrank(crosscov_cont_circ_bg(i,:)-crosscov_non_circ_bg(i,:));
    p5(i)=signrank(crosscov_cont_V2_bg(i,:)-crosscov_non_V2_bg(i,:));
end








