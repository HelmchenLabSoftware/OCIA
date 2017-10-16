


cd F:\Data\VSDI\Contour_integration\chakchak\right_hemisphere\11_02_2009\g
load myrois2
load time_course
cont_circle(:,1)=mean(cont2(roi_circle,:),1);
cont_circle(:,2)=mean(cont1(roi_circle,:),1);
cont_bg(:,1)=mean(cont2([roi_bg_in;roi_bg_out],:),1);
cont_bg(:,2)=mean(cont1([roi_bg_in;roi_bg_out],:),1);
non_circle(:,1)=mean(non2(roi_circle,:),1);
non_circle(:,2)=mean(non1(roi_circle,:),1);
non_bg(:,1)=mean(non2([roi_bg_in;roi_bg_out],:),1);
non_bg(:,2)=mean(non1([roi_bg_in;roi_bg_out],:),1);


cd F:\Data\VSDI\Contour_integration\chakchak\right_hemisphere\11_02_2009\h
load myrois2
load time_course
cont_circle(:,3)=mean(cont2(roi_circle,:),1);
cont_circle(:,4)=mean(cont1(roi_circle,:),1);
cont_bg(:,3)=mean(cont2([roi_bg_in],:),1);
cont_bg(:,4)=mean(cont1([roi_bg_in],:),1);
non_circle(:,3)=mean(non2(roi_circle,:),1);
non_circle(:,4)=mean(non1(roi_circle,:),1);
non_bg(:,3)=mean(non2([roi_bg_in],:),1);
non_bg(:,4)=mean(non1([roi_bg_in],:),1);


cd F:\Data\VSDI\Contour_integration\chakchak\right_hemisphere\30_04_2009\f
load myrois2
load time_course
cont_circle(:,5)=mean(cont9(roi_circle,:),1);
cont_circle(:,6)=mean(cont10(roi_circle,:),1);
cont_bg(:,5)=mean(cont9([roi_bg_in;roi_bg_out],:),1);
cont_bg(:,6)=mean(cont10([roi_bg_in;roi_bg_out],:),1);
non_circle(:,5)=mean(non9(roi_circle,:),1);
non_circle(:,6)=mean(non10(roi_circle,:),1);
non_bg(:,5)=mean(non9([roi_bg_in;roi_bg_out],:),1);
non_bg(:,6)=mean(non10([roi_bg_in;roi_bg_out],:),1);


cd F:\Data\VSDI\Contour_integration\chakchak\right_hemisphere\30_04_2009\j
load myrois2
load time_course
cont_circle(:,7)=mean(cont9(roi_circle,:),1);
cont_circle(:,8)=mean(cont10(roi_circle,:),1);
cont_bg(:,7)=mean(cont9([roi_bg_in],:),1);
cont_bg(:,8)=mean(cont10([roi_bg_in],:),1);
non_circle(:,7)=mean(non9(roi_circle,:),1);
non_circle(:,8)=mean(non10(roi_circle,:),1);
non_bg(:,7)=mean(non9([roi_bg_in],:),1);
non_bg(:,8)=mean(non10([roi_bg_in],:),1);




%%
diff_circ=cont_circle-non_circle;
diff_bg=cont_bg-non_bg;
figure;errorbar(x(18:68),mean(diff_circ(18:68,:),2),std(diff_circ(18:68,:),0,2)/sqrt(8))
hold on
errorbar(x(18:68),mean(diff_bg(18:68,:),2),std(diff_bg(18:68,:),0,2)/sqrt(8),'r')
plot(x(18:68),zeros(1,51),'k')
xlim([-50 300])
ylim([-2e-4 2e-4])

diff_fg=diff_circ-diff_bg;
figure;errorbar(x(18:68),mean(diff_fg(18:68,:),2),std(diff_fg(18:68,:),0,2)/sqrt(8))
hold on
plot(x(18:68),zeros(1,51),'k')
xlim([-50 300])
ylim([-2e-4 2e-4])












