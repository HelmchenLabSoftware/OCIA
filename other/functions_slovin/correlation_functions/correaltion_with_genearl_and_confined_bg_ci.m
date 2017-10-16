%% plotting correlations for figure 5 contour integration

cd F:\Data\VSDI\Contour_integration
load correlation_diffs_bg_general_vs_confined

cc_bg_bg_leg=mean(diff_ccbg_bg_leg(34,:),1);
cc_bgn_bgn_leg=mean(diff_ccbgn_bgn_leg(34,:),1);

[h p]=ttest(cc_bg_bg_leg)
[h p]=ttest(cc_bgn_bgn_leg)

%% smeagol

cc_bg_bg_smeg=mean(diff_ccbg_bg_smeg(30:31,ses1_smeg),1);
cc_bgn_bgn_smeg=mean(diff_ccbgn_bgn_smeg(30:31,ses1_smeg),1);

[h p]=ttest(cc_bg_bg_smeg)
[h p]=ttest(cc_bgn_bgn_smeg)

% figure 4e

figure;bar([mean(cc_bg_bg_leg) mean(cc_bg_bg_smeg);mean(cc_bgn_bgn_leg) mean(cc_bgn_bgn_smeg)]')
hold on
errorbar([mean(cc_bg_bg_leg) mean(cc_bg_bg_smeg)],[std(cc_bg_bg_leg)/sqrt(size(cc_bg_bg_leg,2)) std(cc_bg_bg_smeg)/sqrt(size(cc_bg_bg_smeg,2))])
errorbar([mean(cc_bgn_bgn_leg) mean(cc_bgn_bgn_smeg)],[std(cc_bgn_bgn_leg)/sqrt(size(cc_bg_bg_leg,2)) std(cc_bgn_bgn_smeg)/sqrt(size(cc_bg_bg_smeg,2))])



