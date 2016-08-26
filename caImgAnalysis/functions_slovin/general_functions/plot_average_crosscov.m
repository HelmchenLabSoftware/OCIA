win=25;
x7=-win*10:10:win*10;

load crosscov_cond3_all_roi_win250_70_110_band_ave_alpha_alpha_raw
figure;
errorbar(x7,mean(cov_cond3,1),std(cov_cond3,0,1)/sqrt(size(cov_cond3,1)))
ylim([-0.1 0.1])
xlim([-150 150])

load crosscov_cond3_all_roi_win250_70_110_band_ave_alpha_beta_raw
figure;
errorbar(x7,mean(cov_cond3,1),std(cov_cond3,0,1)/sqrt(size(cov_cond3,1)))
ylim([-0.1 0.1])
xlim([-150 150])


load crosscov_cond3_all_roi_win250_70_110_band_ave_alpha_lg_raw
figure;
errorbar(x7,mean(cov_cond3,1),std(cov_cond3,0,1)/sqrt(size(cov_cond3,1)))
ylim([-0.1 0.1])
xlim([-150 150])


load crosscov_cond3_all_roi_win250_70_110_band_ave_alpha_hg_raw
figure;
errorbar(x7,mean(cov_cond3,1),std(cov_cond3,0,1)/sqrt(size(cov_cond3,1)))
ylim([-0.1 0.1])
xlim([-150 150])

load crosscov_cond3_all_roi_win250_70_110_band_ave_beta_alpha_raw
figure;
errorbar(x7,mean(cov_cond3,1),std(cov_cond3,0,1)/sqrt(size(cov_cond3,1)))
ylim([-0.1 0.1])
xlim([-150 150])

load crosscov_cond3_all_roi_win250_70_110_band_ave_beta_beta_raw
figure;
errorbar(x7,mean(cov_cond3,1),std(cov_cond3,0,1)/sqrt(size(cov_cond3,1)))
ylim([-0.1 0.1])
xlim([-150 150])

load crosscov_cond3_all_roi_win250_70_110_band_ave_beta_lg_raw
figure;
errorbar(x7,mean(cov_cond3,1),std(cov_cond3,0,1)/sqrt(size(cov_cond3,1)))
ylim([-0.1 0.1])
xlim([-150 150])

load crosscov_cond3_all_roi_win250_70_110_band_ave_beta_hg_raw
figure;
errorbar(x7,mean(cov_cond3,1),std(cov_cond3,0,1)/sqrt(size(cov_cond3,1)))
ylim([-0.1 0.1])
xlim([-150 150])

load crosscov_cond3_all_roi_win250_70_110_band_ave_gamma_alpha_raw
figure;
errorbar(x7,mean(cov_cond3,1),std(cov_cond3,0,1)/sqrt(size(cov_cond3,1)))
ylim([-0.1 0.1])
xlim([-150 150])

load crosscov_cond3_all_roi_win250_70_110_band_ave_gamma_beta_raw
figure;
errorbar(x7,mean(cov_cond3,1),std(cov_cond3,0,1)/sqrt(size(cov_cond3,1)))
ylim([-0.1 0.1])
xlim([-150 150])

load crosscov_cond3_all_roi_win250_70_110_band_ave_gamma_lg_raw
figure;
errorbar(x7,mean(cov_cond3,1),std(cov_cond3,0,1)/sqrt(size(cov_cond3,1)))
ylim([-0.1 0.1])
xlim([-150 150])

load crosscov_cond3_all_roi_win250_70_110_band_ave_gamma_hg_raw
figure;
errorbar(x7,mean(cov_cond3,1),std(cov_cond3,0,1)/sqrt(size(cov_cond3,1)))
ylim([-0.1 0.1])
xlim([-150 150])



%%

win=25;
x7=-win*10:10:win*10;

load crosscov_cond3_all_roi_win250_70_110_band_ave_gamma_hg_raw
figure;
plot(x7,mean(cov_cond3a,1),'LineWidth',2)
xlim([-250 250])
hold on
plot(x7,mean(cov_cond3b,1),'r','LineWidth',2)
plot(x7,mean(cov_cond3aa,1),'g','LineWidth',2)
plot(x7,mean(cov_cond3c,1),'c','LineWidth',2)
plot(x7,mean(cov_cond3d,1),'m','LineWidth',2)
plot(x7,mean(cov_cond3e,1),'y','LineWidth',2)
plot(x7,mean(cov_cond3f,1),'k','LineWidth',2)
ylim([-.2 .2])









%%

for i=1:51
    p(i)=signtest(cov_cond3(:,i));
end   

x7(p<0.05)







