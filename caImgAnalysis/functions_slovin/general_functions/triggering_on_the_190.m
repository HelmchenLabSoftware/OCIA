




%bg_sup=[38 38 39 39 40 40 41 50 46 47 38 39 46]-1;
bg_sup=ones(1,13)*46;

cd /fat2/Ariel_Gilad/Matlab_analysis/experiments/mask/legolas/right_hemisphere/11_11_2008/c/elhanan_new
load myrois
load cond1n_dt_bl
load cond4n_dt_bl
cond1n_dt_bl_190=cond1n_dt_bl./repmat(cond1n_dt_bl(:,46,:),[1 256 1]);
cond4n_dt_bl_190=cond4n_dt_bl./repmat(cond4n_dt_bl(:,46,:),[1 256 1]);
clear cond1n_dt_bl
clear cond4n_dt_bl
bg_trig_V2_cont(:,1)=squeeze(mean(mean(cond1n_dt_bl_190(roi_V2,bg_sup(1)-25:bg_sup(1)+25,:),3),1));
bg_trig_circ_cont(:,1)=squeeze(mean(mean(cond1n_dt_bl_190(roi_contour2,bg_sup(1)-25:bg_sup(1)+25,:),3),1));
bg_trig_V2_non(:,1)=squeeze(mean(mean(cond4n_dt_bl_190(roi_V2,bg_sup(1)-25:bg_sup(1)+25,:),3),1));
bg_trig_circ_non(:,1)=squeeze(mean(mean(cond4n_dt_bl_190(roi_contour2,bg_sup(1)-25:bg_sup(1)+25,:),3),1));
clear cond1n_dt_bl_190
clear cond4n_dt_bl_190
load cond2n_dt_bl
load cond5n_dt_bl
cond2n_dt_bl_190=cond2n_dt_bl./repmat(cond2n_dt_bl(:,46,:),[1 256 1]);
cond5n_dt_bl_190=cond5n_dt_bl./repmat(cond5n_dt_bl(:,46,:),[1 256 1]);
clear cond2n_dt_bl
clear cond2n_dt_bl
bg_trig_V2_cont(:,2)=squeeze(mean(mean(cond2n_dt_bl_190(roi_V2,bg_sup(2)-25:bg_sup(2)+25,:),3),1));
bg_trig_circ_cont(:,2)=squeeze(mean(mean(cond2n_dt_bl_190(roi_contour2,bg_sup(2)-25:bg_sup(2)+25,:),3),1));
bg_trig_V2_non(:,2)=squeeze(mean(mean(cond5n_dt_bl_190(roi_V2,bg_sup(2)-25:bg_sup(2)+25,:),3),1));
bg_trig_circ_non(:,2)=squeeze(mean(mean(cond5n_dt_bl_190(roi_contour2,bg_sup(2)-25:bg_sup(2)+25,:),3),1));
clear cond2n_dt_bl_190
clear cond5n_dt_bl_190
cd /fat2/Ariel_Gilad/Matlab_analysis/experiments/mask/legolas/right_hemisphere/11_11_2008/d/elhanan_new
load cond1n_dt_bl
load cond4n_dt_bl
cond1n_dt_bl_190=cond1n_dt_bl./repmat(cond1n_dt_bl(:,46,:),[1 256 1]);
cond4n_dt_bl_190=cond4n_dt_bl./repmat(cond4n_dt_bl(:,46,:),[1 256 1]);
clear cond1n_dt_bl
clear cond4n_dt_bl
bg_trig_V2_cont(:,3)=squeeze(mean(mean(cond1n_dt_bl_190(roi_V2,bg_sup(3)-25:bg_sup(3)+25,:),3),1));
bg_trig_circ_cont(:,3)=squeeze(mean(mean(cond1n_dt_bl_190(roi_contour2,bg_sup(3)-25:bg_sup(3)+25,:),3),1));
bg_trig_V2_non(:,3)=squeeze(mean(mean(cond4n_dt_bl_190(roi_V2,bg_sup(3)-25:bg_sup(3)+25,:),3),1));
bg_trig_circ_non(:,3)=squeeze(mean(mean(cond4n_dt_bl_190(roi_contour2,bg_sup(3)-25:bg_sup(3)+25,:),3),1));
clear cond1n_dt_bl_190
clear cond4n_dt_bl_190
load cond2n_dt_bl
load cond5n_dt_bl
cond2n_dt_bl_190=cond2n_dt_bl./repmat(cond2n_dt_bl(:,46,:),[1 256 1]);
cond5n_dt_bl_190=cond5n_dt_bl./repmat(cond5n_dt_bl(:,46,:),[1 256 1]);
clear cond2n_dt_bl
clear cond5n_dt_bl
bg_trig_V2_cont(:,4)=squeeze(mean(mean(cond2n_dt_bl_190(roi_V2,bg_sup(4)-25:bg_sup(4)+25,:),3),1));
bg_trig_circ_cont(:,4)=squeeze(mean(mean(cond2n_dt_bl_190(roi_contour2,bg_sup(4)-25:bg_sup(4)+25,:),3),1));
bg_trig_V2_non(:,4)=squeeze(mean(mean(cond5n_dt_bl_190(roi_V2,bg_sup(4)-25:bg_sup(4)+25,:),3),1));
bg_trig_circ_non(:,4)=squeeze(mean(mean(cond5n_dt_bl_190(roi_contour2,bg_sup(4)-25:bg_sup(4)+25,:),3),1));
clear cond2n_dt_bl_190
clear cond5n_dt_bl_190
cd /fat2/Ariel_Gilad/Matlab_analysis/experiments/mask/legolas/right_hemisphere/psychophysics/2008_11_18/c
load myrois
load cond1n_dt_bl
load cond5n_dt_bl
cond1n_dt_bl_190=cond1n_dt_bl./repmat(cond1n_dt_bl(:,46,:),[1 256 1]);
cond5n_dt_bl_190=cond5n_dt_bl./repmat(cond5n_dt_bl(:,46,:),[1 256 1]);
clear cond1n_dt_bl
clear cond5n_dt_bl
bg_trig_V2_cont(:,5)=squeeze(mean(mean(cond1n_dt_bl_190(roi_V2,bg_sup(5)-25:bg_sup(5)+25,:),3),1));
bg_trig_circ_cont(:,5)=squeeze(mean(mean(cond1n_dt_bl_190(roi_contour,bg_sup(5)-25:bg_sup(5)+25,:),3),1));
bg_trig_V2_non(:,5)=squeeze(mean(mean(cond5n_dt_bl_190(roi_V2,bg_sup(5)-25:bg_sup(5)+25,:),3),1));
bg_trig_circ_non(:,5)=squeeze(mean(mean(cond5n_dt_bl_190(roi_contour,bg_sup(5)-25:bg_sup(5)+25,:),3),1));
clear cond1n_dt_bl_190
clear cond5n_dt_bl_190
cd /fat2/Ariel_Gilad/Matlab_analysis/experiments/mask/legolas/right_hemisphere/psychophysics/2008_11_18/d
load cond1n_dt_bl
load cond5n_dt_bl
cond1n_dt_bl_190=cond1n_dt_bl./repmat(cond1n_dt_bl(:,46,:),[1 256 1]);
cond5n_dt_bl_190=cond5n_dt_bl./repmat(cond5n_dt_bl(:,46,:),[1 256 1]);
clear cond1n_dt_bl
clear cond5n_dt_bl
bg_trig_V2_cont(:,6)=squeeze(mean(mean(cond1n_dt_bl_190(roi_V2,bg_sup(6)-25:bg_sup(6)+25,:),3),1));
bg_trig_circ_cont(:,6)=squeeze(mean(mean(cond1n_dt_bl_190(roi_contour,bg_sup(6)-25:bg_sup(6)+25,:),3),1));
bg_trig_V2_non(:,6)=squeeze(mean(mean(cond5n_dt_bl_190(roi_V2,bg_sup(6)-25:bg_sup(6)+25,:),3),1));
bg_trig_circ_non(:,6)=squeeze(mean(mean(cond5n_dt_bl_190(roi_contour,bg_sup(6)-25:bg_sup(6)+25,:),3),1));
clear cond1n_dt_bl_190
clear cond5n_dt_bl_190
cd /fat2/Ariel_Gilad/Matlab_analysis/experiments/mask/legolas/right_hemisphere/psychophysics/2008_11_18/e
load cond1n_dt_bl
load cond5n_dt_bl
cond1n_dt_bl_190=cond1n_dt_bl./repmat(cond1n_dt_bl(:,46,:),[1 256 1]);
cond5n_dt_bl_190=cond5n_dt_bl./repmat(cond5n_dt_bl(:,46,:),[1 256 1]);
clear cond1n_dt_bl
clear cond5n_dt_bl
bg_trig_V2_cont(:,7)=squeeze(mean(mean(cond1n_dt_bl_190(roi_V2,bg_sup(7)-25:bg_sup(7)+25,:),3),1));
bg_trig_circ_cont(:,7)=squeeze(mean(mean(cond1n_dt_bl_190(roi_contour,bg_sup(7)-25:bg_sup(7)+25,:),3),1));
bg_trig_V2_non(:,7)=squeeze(mean(mean(cond5n_dt_bl_190(roi_V2,bg_sup(7)-25:bg_sup(7)+25,:),3),1));
bg_trig_circ_non(:,7)=squeeze(mean(mean(cond5n_dt_bl_190(roi_contour,bg_sup(7)-25:bg_sup(7)+25,:),3),1));
clear cond1n_dt_bl_190
clear cond5n_dt_bl_190
cd /fat2/Ariel_Gilad/Matlab_analysis/experiments/mask/legolas/right_hemisphere/psychophysics/2008_11_25/d
load 2511
load cond1n_dt_bl
load cond5n_dt_bl
cond1n_dt_bl_190=cond1n_dt_bl./repmat(cond1n_dt_bl(:,46,:),[1 256 1]);
cond5n_dt_bl_190=cond5n_dt_bl./repmat(cond5n_dt_bl(:,46,:),[1 256 1]);
clear cond1n_dt_bl
clear cond5n_dt_bl
bg_trig_V2_cont(:,8)=squeeze(mean(mean(cond1n_dt_bl_190(roi_V2,bg_sup(8)-25:bg_sup(8)+25,:),3),1));
bg_trig_circ_cont(:,8)=squeeze(mean(mean(cond1n_dt_bl_190(roi_contour,bg_sup(8)-25:bg_sup(8)+25,:),3),1));
bg_trig_V2_non(:,8)=squeeze(mean(mean(cond5n_dt_bl_190(roi_V2,bg_sup(8)-25:bg_sup(8)+25,:),3),1));
bg_trig_circ_non(:,8)=squeeze(mean(mean(cond5n_dt_bl_190(roi_contour,bg_sup(8)-25:bg_sup(8)+25,:),3),1));
clear cond1n_dt_bl_190
clear cond5n_dt_bl_190
cd /fat2/Ariel_Gilad/Matlab_analysis/experiments/mask/legolas/right_hemisphere/psychophysics/2008_11_25/e
load cond1n_dt_bl
load cond5n_dt_bl
cond1n_dt_bl_190=cond1n_dt_bl./repmat(cond1n_dt_bl(:,46,:),[1 256 1]);
cond5n_dt_bl_190=cond5n_dt_bl./repmat(cond5n_dt_bl(:,46,:),[1 256 1]);
clear cond1n_dt_bl
clear cond5n_dt_bl
bg_trig_V2_cont(:,9)=squeeze(mean(mean(cond1n_dt_bl_190(roi_V2,bg_sup(9)-25:bg_sup(9)+25,:),3),1));
bg_trig_circ_cont(:,9)=squeeze(mean(mean(cond1n_dt_bl_190(roi_contour,bg_sup(9)-25:bg_sup(9)+25,:),3),1));
bg_trig_V2_non(:,9)=squeeze(mean(mean(cond5n_dt_bl_190(roi_V2,bg_sup(9)-25:bg_sup(9)+25,:),3),1));
bg_trig_circ_non(:,9)=squeeze(mean(mean(cond5n_dt_bl_190(roi_contour,bg_sup(9)-25:bg_sup(9)+25,:),3),1));
clear cond1n_dt_bl_190
clear cond5n_dt_bl_190
cd /fat2/Ariel_Gilad/Matlab_analysis/experiments/mask/legolas/right_hemisphere/psychophysics/2008_11_25/f
load cond1n_dt_bl
load cond5n_dt_bl
cond1n_dt_bl_190=cond1n_dt_bl./repmat(cond1n_dt_bl(:,46,:),[1 256 1]);
cond5n_dt_bl_190=cond5n_dt_bl./repmat(cond5n_dt_bl(:,46,:),[1 256 1]);
clear cond1n_dt_bl
clear cond5n_dt_bl
bg_trig_V2_cont(:,10)=squeeze(mean(mean(cond1n_dt_bl_190(roi_V2,bg_sup(10)-25:bg_sup(10)+25,:),3),1));
bg_trig_circ_cont(:,10)=squeeze(mean(mean(cond1n_dt_bl_190(roi_contour,bg_sup(10)-25:bg_sup(10)+25,:),3),1));
bg_trig_V2_non(:,10)=squeeze(mean(mean(cond5n_dt_bl_190(roi_V2,bg_sup(10)-25:bg_sup(10)+25,:),3),1));
bg_trig_circ_non(:,10)=squeeze(mean(mean(cond5n_dt_bl_190(roi_contour,bg_sup(10)-25:bg_sup(10)+25,:),3),1));
clear cond1n_dt_bl_190
clear cond5n_dt_bl_190
cd /fat2/Ariel_Gilad/Matlab_analysis/experiments/mask/legolas/right_hemisphere/psychophysics/2008_12_03/d
load myrois
load cond1n_dt_bl
load cond5n_dt_bl
cond1n_dt_bl_190=cond1n_dt_bl./repmat(cond1n_dt_bl(:,46,:),[1 256 1]);
cond5n_dt_bl_190=cond5n_dt_bl./repmat(cond5n_dt_bl(:,46,:),[1 256 1]);
clear cond1n_dt_bl
clear cond5n_dt_bl
bg_trig_V2_cont(:,11)=squeeze(mean(mean(cond1n_dt_bl_190(roi_V2,bg_sup(11)-25:bg_sup(11)+25,:),3),1));
bg_trig_circ_cont(:,11)=squeeze(mean(mean(cond1n_dt_bl_190(roi_contour,bg_sup(11)-25:bg_sup(11)+25,:),3),1));
bg_trig_V2_non(:,11)=squeeze(mean(mean(cond5n_dt_bl_190(roi_V2,bg_sup(11)-25:bg_sup(11)+25,:),3),1));
bg_trig_circ_non(:,11)=squeeze(mean(mean(cond5n_dt_bl_190(roi_contour,bg_sup(11)-25:bg_sup(11)+25,:),3),1));
clear cond1n_dt_bl_190
clear cond5n_dt_bl_190
cd /fat2/Ariel_Gilad/Matlab_analysis/experiments/mask/legolas/right_hemisphere/psychophysics/2008_12_03/e
load cond1n_dt_bl
load cond5n_dt_bl
cond1n_dt_bl_190=cond1n_dt_bl./repmat(cond1n_dt_bl(:,46,:),[1 256 1]);
cond5n_dt_bl_190=cond5n_dt_bl./repmat(cond5n_dt_bl(:,46,:),[1 256 1]);
clear cond1n_dt_bl
clear cond5n_dt_bl
bg_trig_V2_cont(:,12)=squeeze(mean(mean(cond1n_dt_bl_190(roi_V2,bg_sup(12)-25:bg_sup(12)+25,:),3),1));
bg_trig_circ_cont(:,12)=squeeze(mean(mean(cond1n_dt_bl_190(roi_contour,bg_sup(12)-25:bg_sup(12)+25,:),3),1));
bg_trig_V2_non(:,12)=squeeze(mean(mean(cond5n_dt_bl_190(roi_V2,bg_sup(12)-25:bg_sup(12)+25,:),3),1));
bg_trig_circ_non(:,12)=squeeze(mean(mean(cond5n_dt_bl_190(roi_contour,bg_sup(12)-25:bg_sup(12)+25,:),3),1));
clear cond1n_dt_bl_190
clear cond5n_dt_bl_190
cd /fat2/Ariel_Gilad/Matlab_analysis/experiments/mask/legolas/right_hemisphere/psychophysics/2008_12_03/f
load cond1n_dt_bl
load cond5n_dt_bl
cond1n_dt_bl_190=cond1n_dt_bl./repmat(cond1n_dt_bl(:,46,:),[1 256 1]);
cond5n_dt_bl_190=cond5n_dt_bl./repmat(cond5n_dt_bl(:,46,:),[1 256 1]);
clear cond1n_dt_bl
clear cond5n_dt_bl
bg_trig_V2_cont(:,13)=squeeze(mean(mean(cond1n_dt_bl_190(roi_V2,bg_sup(13)-25:bg_sup(13)+25,:),3),1));
bg_trig_circ_cont(:,13)=squeeze(mean(mean(cond1n_dt_bl_190(roi_contour,bg_sup(13)-25:bg_sup(13)+25,:),3),1));
bg_trig_V2_non(:,13)=squeeze(mean(mean(cond5n_dt_bl_190(roi_V2,bg_sup(13)-25:bg_sup(13)+25,:),3),1));
bg_trig_circ_non(:,13)=squeeze(mean(mean(cond5n_dt_bl_190(roi_contour,bg_sup(13)-25:bg_sup(13)+25,:),3),1));
clear cond1n_dt_bl_190
clear cond5n_dt_bl_190




x=-250:10:250;
figure;errorbar(x,mean(bg_trig_V2_cont-1,2),std(bg_trig_V2_cont-1,0,2)/sqrt(13))
hold on
errorbar(x,mean(bg_trig_V2_non-1,2),std(bg_trig_V2_non-1,0,2)/sqrt(13),'r')
xlim([-40 60])

x=-250:10:250;
figure;plot(x,bg_trig_V2_cont-1,'b')
hold on
plot(x,bg_trig_V2_non-1,'r')
xlim([-40 60])


figure;errorbar(x,mean(bg_trig_V2_cont-bg_trig_V2_non,2),std(bg_trig_V2_cont-bg_trig_V2_non,0,2)/sqrt(13))
xlim([-40 60])




signrank(bg_trig_V2_cont(30,:)-bg_trig_V2_non(30,:))












