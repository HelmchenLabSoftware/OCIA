

cont_cc_circ_circ_leg=mean(cont_cccirc_circ_leg(30:33,:),1);
cont_cc_bg_bg_leg=mean(cont_ccbg_bg_leg(34,:),1);
non_cc_circ_circ_leg=mean(non_cccirc_circ_leg(30:33,:),1);
non_cc_bg_bg_leg=mean(non_ccbg_bg_leg(34,:),1);
cont_cc_circ_bg_leg=mean(cont_cccirc_bg_leg(30:34,:),1);
non_cc_circ_bg_leg=mean(non_cccirc_bg_leg(30:34,:),1);

cont_cc_circ_circ_smeg=mean(cont_cccirc_circle_smeg(27,ses1_smeg),1);
cont_cc_bg_bg_smeg=mean(cont_ccbg_bg_smeg(30:31,ses1_smeg),1);
non_cc_circ_circ_smeg=mean(non_cccirc_circle_smeg(27,ses1_smeg),1);
non_cc_bg_bg_smeg=mean(non_ccbg_bg_smeg(30:31,ses1_smeg),1);
cont_cc_circ_bg_smeg=mean(cont_cccirc_bg_smeg(27:28,ses1_smeg),1);
non_cc_circ_bg_smeg=mean(non_cccirc_bg_smeg(27:28,ses1_smeg),1);


% figure 4e
figure;bar([mean(cont_cc_circ_circ_leg) mean(cont_cc_bg_bg_leg) mean(cont_cc_circ_bg_leg);mean(non_cc_circ_circ_leg) mean(non_cc_bg_bg_leg) mean(non_cc_circ_bg_leg)]')
hold on
errorbar([mean(cont_cc_circ_circ_leg) mean(cont_cc_bg_bg_leg) mean(cont_cc_circ_bg_leg)],[std(cont_cc_circ_circ_leg) std(cont_cc_bg_bg_leg) std(cont_cc_circ_bg_leg)]/sqrt(size(cont_cc_circ_circ_leg,2)))
errorbar([mean(non_cc_circ_circ_leg) mean(non_cc_bg_bg_leg) mean(non_cc_circ_bg_leg)],[std(non_cc_circ_circ_leg) std(non_cc_bg_bg_leg) std(non_cc_circ_bg_leg)]/sqrt(size(non_cc_circ_circ_leg,2)))
ylim([0 0.5])

figure;bar([mean(cont_cc_circ_circ_smeg) mean(cont_cc_bg_bg_smeg) mean(cont_cc_circ_bg_smeg);mean(non_cc_circ_circ_smeg) mean(non_cc_bg_bg_smeg) mean(non_cc_circ_bg_smeg)]')
hold on
errorbar([mean(cont_cc_circ_circ_smeg) mean(cont_cc_bg_bg_smeg)  mean(cont_cc_circ_bg_smeg)],[std(cont_cc_circ_circ_smeg) std(cont_cc_bg_bg_smeg) std(cont_cc_circ_bg_smeg)]/sqrt(size(cont_cc_circ_circ_smeg,2)))
errorbar([mean(non_cc_circ_circ_smeg) mean(non_cc_bg_bg_smeg) mean(non_cc_circ_bg_smeg)],[std(non_cc_circ_circ_smeg) std(non_cc_bg_bg_smeg) std(non_cc_circ_bg_smeg)]/sqrt(size(non_cc_circ_circ_smeg,2)))
ylim([0 0.5])


