cd /fat2/Ariel_Gilad/Matlab_analysis/2008_01_15/cond_data
load spect_pixel_wise_cond1_res_64_bl8 
figure(10);subplot(3,2,1);
[spect_ave_sig_V1]=calculate_significance_for_spectogram(nanmean(spect_pixel_wise_cond1(:,:,roi_V1),3));
imagesc(spect_ave_sig_V1);colorbar(mapgeog);title('significance for cond1 roi V1');
figure(11);subplot(3,2,1);
[spect_ave_sig_V2]=calculate_significance_for_spectogram(nanmean(spect_pixel_wise_cond1(:,:,roi_V2),3));
imagesc(spect_ave_sig_V1);colorbar(mapgeog);title('significance for cond1 roi V2');
figure(12);subplot(3,2,1);
[spect_ave_sig_V4]=calculate_significance_for_spectogram(nanmean(spect_pixel_wise_cond1(:,:,roi_V4),3));
imagesc(spect_ave_sig_V1);colorbar(mapgeog);title('significance for cond1 roi V4');
clear spect_ave_sig_V1 spect_ave_sig_V2 spect_ave_sig_V4 spect_pixel_wise_cond1;
load spect_pixel_wise_cond2_res_64_bl8 
figure(10);subplot(3,2,2);
[spect_ave_sig_V1]=calculate_significance_for_spectogram(nanmean(spect_pixel_wise_cond2(:,:,roi_V1),3));
imagesc(spect_ave_sig_V1);colorbar(mapgeog);title('significance for cond2 roi V1');
figure(11);subplot(3,2,2);
[spect_ave_sig_V2]=calculate_significance_for_spectogram(nanmean(spect_pixel_wise_cond2(:,:,roi_V2),3));
imagesc(spect_ave_sig_V1);colorbar(mapgeog);title('significance for cond2 roi V2');
figure(12);subplot(3,2,2);
[spect_ave_sig_V4]=calculate_significance_for_spectogram(nanmean(spect_pixel_wise_cond2(:,:,roi_V4),3));
imagesc(spect_ave_sig_V1);colorbar(mapgeog);title('significance for cond2 roi V4');
clear spect_ave_sig_V1 spect_ave_sig_V2 spect_ave_sig_V4 spect_pixel_wise_cond2;
load spect_pixel_wise_cond3_res_64_bl8 
figure(10);subplot(3,2,3);
[spect_ave_sig_V1]=calculate_significance_for_spectogram(nanmean(spect_pixel_wise_cond3(:,:,roi_V1),3));
imagesc(spect_ave_sig_V1);colorbar(mapgeog);title('significance for cond3 roi V1');
figure(11);subplot(3,2,3);
[spect_ave_sig_V2]=calculate_significance_for_spectogram(nanmean(spect_pixel_wise_cond3(:,:,roi_V2),3));
imagesc(spect_ave_sig_V1);colorbar(mapgeog);title('significance for cond3 roi V2');
figure(12);subplot(3,2,3);
[spect_ave_sig_V4]=calculate_significance_for_spectogram(nanmean(spect_pixel_wise_cond3(:,:,roi_V4),3));
imagesc(spect_ave_sig_V1);colorbar(mapgeog);title('significance for cond3 roi V4');
clear spect_ave_sig_V1 spect_ave_sig_V2 spect_ave_sig_V4 spect_pixel_wise_cond3;
load spect_pixel_wise_cond4_res_64_bl8 
figure(10);subplot(3,2,4);
[spect_ave_sig_V1]=calculate_significance_for_spectogram(nanmean(spect_pixel_wise_cond4(:,:,roi_V1),3));
imagesc(spect_ave_sig_V1);colorbar(mapgeog);title('significance for cond4 roi V1');
figure(11);subplot(3,2,4);
[spect_ave_sig_V2]=calculate_significance_for_spectogram(nanmean(spect_pixel_wise_cond4(:,:,roi_V2),3));
imagesc(spect_ave_sig_V1);colorbar(mapgeog);title('significance for cond4 roi V2');
figure(12);subplot(3,2,4);
[spect_ave_sig_V4]=calculate_significance_for_spectogram(nanmean(spect_pixel_wise_cond4(:,:,roi_V4),3));
imagesc(spect_ave_sig_V1);colorbar(mapgeog);title('significance for cond4 roi V4');
clear spect_ave_sig_V1 spect_ave_sig_V2 spect_ave_sig_V4 spect_pixel_wise_cond4;
load spect_pixel_wise_cond5_res_64_bl8 
figure(10);subplot(3,2,5);
[spect_ave_sig_V1]=calculate_significance_for_spectogram(nanmean(spect_pixel_wise_cond5(:,:,roi_V1),3));
imagesc(spect_ave_sig_V1);colorbar(mapgeog);title('significance for cond5 roi V1');
figure(11);subplot(3,2,5);
[spect_ave_sig_V2]=calculate_significance_for_spectogram(nanmean(spect_pixel_wise_cond5(:,:,roi_V2),3));
imagesc(spect_ave_sig_V1);colorbar(mapgeog);title('significance for cond5 roi V2');
figure(12);subplot(3,2,5);
[spect_ave_sig_V4]=calculate_significance_for_spectogram(nanmean(spect_pixel_wise_cond5(:,:,roi_V4),3));
imagesc(spect_ave_sig_V1);colorbar(mapgeog);title('significance for cond5 roi V4');
clear spect_ave_sig_V1 spect_ave_sig_V2 spect_ave_sig_V4 spect_pixel_wise_cond5;
load spect_pixel_wise_cond6_res_64_bl8 
figure(10);subplot(3,2,6);
[spect_ave_sig_V1]=calculate_significance_for_spectogram(nanmean(spect_pixel_wise_cond6(:,:,roi_V1),3));
imagesc(spect_ave_sig_V1);colorbar(mapgeog);title('significance for cond6 roi V1');
figure(11);subplot(3,2,6);
[spect_ave_sig_V2]=calculate_significance_for_spectogram(nanmean(spect_pixel_wise_cond6(:,:,roi_V2),3));
imagesc(spect_ave_sig_V1);colorbar(mapgeog);title('significance for cond6 roi V2');
figure(12);subplot(3,2,6);
[spect_ave_sig_V4]=calculate_significance_for_spectogram(nanmean(spect_pixel_wise_cond6(:,:,roi_V4),3));
imagesc(spect_ave_sig_V1);colorbar(mapgeog);title('significance for cond6 roi V4');
clear spect_ave_sig_V1 spect_ave_sig_V2 spect_ave_sig_V4 spect_pixel_wise_cond6;