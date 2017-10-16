cd F:\Data\VSDI\figure_figure\tolkin\25may2011
load('power_analysis_for_reviewer_1.mat')

x1=(20:10:1130)-200;
f=1:1:32:50;

figure;imagesc(x1(1:60),f,squeeze(nanmean(a(roi_top,:,1:60),1)),[0 12]);colormap(mapgeog)
xlim([-50 250])

figure;imagesc(x1(1:60),f,squeeze(nanmean(c(roi_top,:,1:60),1)),[0 12]);colormap(mapgeog)
xlim([-50 250])

figure;imagesc(x1(1:60),f,squeeze(nanmean(b(roi_top,:,1:60),1)),[-4 4]);colormap(mapgeog)
xlim([-50 250])


figure;imagesc(x1(1:60),f,squeeze(nanmean(a(roi_bottom,:,1:60),1)),[0 12]);colormap(mapgeog)
xlim([-50 250])

figure;imagesc(x1(1:60),f,squeeze(nanmean(c(roi_bottom,:,1:60),1)),[0 12]);colormap(mapgeog)
xlim([-50 250])

figure;imagesc(x1(1:60),f,squeeze(nanmean(b(roi_bottom,:,1:60),1)),[-4 4]);colormap(mapgeog)
xlim([-50 250])
