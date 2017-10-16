%% 3004

%f
load myrois2

c2_3004f_cccirc_circ=squeeze(mean(a(roi_circ,:,:),1));
c2_3004f_cccirc_bg=squeeze(mean(a(roi_bg_out,:,:),1));
c3_3004f_cccirc_circ=squeeze(mean(b(roi_circ,:,:),1));
c3_3004f_cccirc_bg=squeeze(mean(b(roi_bg_out,:,:),1));
c4_3004f_cccirc_circ=squeeze(mean(c(roi_circ,:,:),1));
c4_3004f_cccirc_bg=squeeze(mean(c(roi_bg_out,:,:),1));
c5_3004f_cccirc_circ=squeeze(mean(d(roi_circ,:,:),1));
c5_3004f_cccirc_bg=squeeze(mean(d(roi_bg_out,:,:),1));


c2_3004f_ccbg_bg=squeeze(mean(a(roi_bg_out,:,:),1));
c3_3004f_ccbg_bg=squeeze(mean(b(roi_bg_out,:,:),1));
c4_3004f_ccbg_bg=squeeze(mean(c(roi_bg_out,:,:),1));
c5_3004f_ccbg_bg=squeeze(mean(d(roi_bg_out,:,:),1));


%j
load myrois2

c2_3004j_cccirc_circ=squeeze(mean(a(roi_circ,:,:),1));
c2_3004j_cccirc_bg=squeeze(mean(a(roi_bg_in,:,:),1));
c3_3004j_cccirc_circ=squeeze(mean(b(roi_circ,:,:),1));
c3_3004j_cccirc_bg=squeeze(mean(b(roi_bg_in,:,:),1));
c4_3004j_cccirc_circ=squeeze(mean(c(roi_circ,:,:),1));
c4_3004j_cccirc_bg=squeeze(mean(c(roi_bg_in,:,:),1));
c5_3004j_cccirc_circ=squeeze(mean(d(roi_circ,:,:),1));
c5_3004j_cccirc_bg=squeeze(mean(d(roi_bg_in,:,:),1));


c2_3004j_ccbg_bg=squeeze(mean(a(roi_bg_in,:,:),1));
c3_3004j_ccbg_bg=squeeze(mean(b(roi_bg_in,:,:),1));
c4_3004j_ccbg_bg=squeeze(mean(c(roi_bg_in,:,:),1));
c5_3004j_ccbg_bg=squeeze(mean(d(roi_bg_in,:,:),1));






%% 1102

%g
load myrois2

c2_1102g_cccirc_circ=squeeze(mean(a(roi_circ,:,:),1));
c2_1102g_cccirc_bg=squeeze(mean(a(roi_bg_out,:,:),1));
c3_1102g_cccirc_circ=squeeze(mean(b(roi_circ,:,:),1));
c3_1102g_cccirc_bg=squeeze(mean(b(roi_bg_out,:,:),1));
c4_1102g_cccirc_circ=squeeze(mean(c(roi_circ,:,:),1));
c4_1102g_cccirc_bg=squeeze(mean(c(roi_bg_out,:,:),1));
c5_1102g_cccirc_circ=squeeze(mean(d(roi_circ,:,:),1));
c5_1102g_cccirc_bg=squeeze(mean(d(roi_bg_out,:,:),1));


c2_1102g_ccbg_bg=squeeze(mean(a(roi_bg_out,:,:),1));
c3_1102g_ccbg_bg=squeeze(mean(b(roi_bg_out,:,:),1));
c4_1102g_ccbg_bg=squeeze(mean(c(roi_bg_out,:,:),1));
c5_1102g_ccbg_bg=squeeze(mean(d(roi_bg_out,:,:),1));


%h
load myrois2

c2_1102h_cccirc_circ=squeeze(mean(a(roi_circ,:,:),1));
c2_1102h_cccirc_bg=squeeze(mean(a(roi_bg_in,:,:),1));
c3_1102h_cccirc_circ=squeeze(mean(b(roi_circ,:,:),1));
c3_1102h_cccirc_bg=squeeze(mean(b(roi_bg_in,:,:),1));
c4_1102h_cccirc_circ=squeeze(mean(c(roi_circ,:,:),1));
c4_1102h_cccirc_bg=squeeze(mean(c(roi_bg_in,:,:),1));
c5_1102h_cccirc_circ=squeeze(mean(d(roi_circ,:,:),1));
c5_1102h_cccirc_bg=squeeze(mean(d(roi_bg_in,:,:),1));


c2_1102h_ccbg_bg=squeeze(mean(a(roi_bg_in,:,:),1));
c3_1102h_ccbg_bg=squeeze(mean(b(roi_bg_in,:,:),1));
c4_1102h_ccbg_bg=squeeze(mean(c(roi_bg_in,:,:),1));
c5_1102h_ccbg_bg=squeeze(mean(d(roi_bg_in,:,:),1));



%%

cont_cccirc_circ(:,1)=mean(c2_3004f_cccirc_circ,2);
cont_cccirc_circ(:,2)=mean(c3_3004f_cccirc_circ,2);
cont_cccirc_circ(:,3)=mean(c2_3004j_cccirc_circ,2);
cont_cccirc_circ(:,4)=mean(c3_3004j_cccirc_circ,2);
cont_cccirc_circ(:,5)=mean(c2_1102g_cccirc_circ,2);
cont_cccirc_circ(:,6)=mean(c4_1102g_cccirc_circ,2);
cont_cccirc_circ(:,7)=mean(c2_1102h_cccirc_circ,2);
cont_cccirc_circ(:,8)=mean(c4_1102h_cccirc_circ,2);

non_cccirc_circ(:,1)=mean(c4_3004f_cccirc_circ,2);
non_cccirc_circ(:,2)=mean(c5_3004f_cccirc_circ,2);
non_cccirc_circ(:,3)=mean(c4_3004j_cccirc_circ,2);
non_cccirc_circ(:,4)=mean(c5_3004j_cccirc_circ,2);
non_cccirc_circ(:,5)=mean(c3_1102g_cccirc_circ,2);
non_cccirc_circ(:,6)=mean(c5_1102g_cccirc_circ,2);
non_cccirc_circ(:,7)=mean(c3_1102h_cccirc_circ,2);
non_cccirc_circ(:,8)=mean(c5_1102h_cccirc_circ,2);


cont_cccirc_bg(:,1)=mean(c2_3004f_cccirc_bg,2);
cont_cccirc_bg(:,2)=mean(c3_3004f_cccirc_bg,2);
cont_cccirc_bg(:,3)=mean(c2_3004j_cccirc_bg,2);
cont_cccirc_bg(:,4)=mean(c3_3004j_cccirc_bg,2);
cont_cccirc_bg(:,5)=mean(c2_1102g_cccirc_bg,2);
cont_cccirc_bg(:,6)=mean(c4_1102g_cccirc_bg,2);
cont_cccirc_bg(:,7)=mean(c2_1102h_cccirc_bg,2);
cont_cccirc_bg(:,8)=mean(c4_1102h_cccirc_bg,2);

non_cccirc_bg(:,1)=mean(c4_3004f_cccirc_bg,2);
non_cccirc_bg(:,2)=mean(c5_3004f_cccirc_bg,2);
non_cccirc_bg(:,3)=mean(c4_3004j_cccirc_bg,2);
non_cccirc_bg(:,4)=mean(c5_3004j_cccirc_bg,2);
non_cccirc_bg(:,5)=mean(c3_1102g_cccirc_bg,2);
non_cccirc_bg(:,6)=mean(c5_1102g_cccirc_bg,2);
non_cccirc_bg(:,7)=mean(c3_1102h_cccirc_bg,2);
non_cccirc_bg(:,8)=mean(c5_1102h_cccirc_bg,2);


cont_ccbg_bg(:,1)=mean(c2_3004f_ccbg_bg,2);
cont_ccbg_bg(:,2)=mean(c3_3004f_ccbg_bg,2);
cont_ccbg_bg(:,3)=mean(c2_3004j_ccbg_bg,2);
cont_ccbg_bg(:,4)=mean(c3_3004j_ccbg_bg,2);
cont_ccbg_bg(:,5)=mean(c2_1102g_ccbg_bg,2);
cont_ccbg_bg(:,6)=mean(c4_1102g_ccbg_bg,2);
cont_ccbg_bg(:,7)=mean(c2_1102h_ccbg_bg,2);
cont_ccbg_bg(:,8)=mean(c4_1102h_ccbg_bg,2);

non_ccbg_bg(:,1)=mean(c4_3004f_ccbg_bg,2);
non_ccbg_bg(:,2)=mean(c5_3004f_ccbg_bg,2);
non_ccbg_bg(:,3)=mean(c4_3004j_ccbg_bg,2);
non_ccbg_bg(:,4)=mean(c5_3004j_ccbg_bg,2);
non_ccbg_bg(:,5)=mean(c3_1102g_ccbg_bg,2);
non_ccbg_bg(:,6)=mean(c5_1102g_ccbg_bg,2);
non_ccbg_bg(:,7)=mean(c3_1102h_ccbg_bg,2);
non_ccbg_bg(:,8)=mean(c5_1102h_ccbg_bg,2);


diff_cccirc_circ=cont_cccirc_circ-non_cccirc_circ;
diff_cccirc_bg=cont_cccirc_bg-non_cccirc_bg;
diff_ccbg_bg=cont_ccbg_bg-non_ccbg_bg;

diff_fg=diff_cccirc_circ-diff_ccbg_bg;


figure;errorbar(x,mean(diff_cccirc_circ,2),std(diff_cccirc_circ,0,2)/sqrt(size(diff_cccirc_circ,2)))
hold on
errorbar(x,mean(diff_ccbg_bg,2),std(diff_ccbg_bg,0,2)/sqrt(size(diff_ccbg_bg,2)),'r')
%errorbar(x,mean(diff_cccirc_bg,2),std(diff_cccirc_bg,0,2)/sqrt(size(diff_cccirc_bg,2)),'g')
plot(x,zeros(1,112),'k')
xlim([-100 300])

figure;errorbar(x,mean(diff_fg,2),std(diff_fg,0,2)/sqrt(size(diff_fg,2)))
hold on
plot(x,zeros(1,112),'k')
xlim([-100 300])

signrank(mean(diff_fg(28:33,:),2))




