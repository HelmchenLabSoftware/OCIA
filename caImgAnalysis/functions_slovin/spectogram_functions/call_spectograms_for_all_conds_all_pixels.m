cd /fat2/Ariel_Gilad/Matlab_analysis/2008_02_19/cond_data_a
load cond1n_dt_hb;
[spect_pixel_wise_cond1,baseline_ave_pixels,baseline_std_pixels]=spectogram_pixel_wise(cond1n_dt_hb);
clear cond1n_dt_hb;
spect_pixel_wise_cond1_time_1_239=spect_pixel_wise_cond1(:,1:239,:);
save spect_pixel_wise_cond1_res_64_bl8_hb_1_239 spect_pixel_wise_cond1_time_1_239
clear spect_pixel_wise_cond1_time_1_239
spect_pixel_wise_cond1_time_240_479=spect_pixel_wise_cond1(:,240:end,:);
save spect_pixel_wise_cond1_res_64_bl8_hb_240_479 spect_pixel_wise_cond1_time_240_479
%spect_pixel_wise_cond1_1_5000=spect_pixel_wise_cond1(:,:,1:5000);
%save spect_pixel_wise_cond1_1_5000 spect_pixel_wise_cond1_1_5000
%clear spect_pixel_wise_cond1_1_5000
%spect_pixel_wise_cond1_5001_10000=spect_pixel_wise_cond1(:,:,5001:end);
%save spect_pixel_wise_cond1_5001_10000 spect_pixel_wise_cond1_5001_10000
clear all
load cond2n_dt_hb;
[spect_pixel_wise_cond2,baseline_ave_pixels,baseline_std_pixels]=spectogram_pixel_wise(cond2n_dt_hb);
clear cond2n_dt_hb;
spect_pixel_wise_cond2_time_1_239=spect_pixel_wise_cond2(:,1:239,:);
save spect_pixel_wise_cond2_res_64_bl8_hb_1_239 spect_pixel_wise_cond2_time_1_239
clear spect_pixel_wise_cond2_time_1_239
spect_pixel_wise_cond2_time_240_479=spect_pixel_wise_cond2(:,240:end,:);
save spect_pixel_wise_cond2_res_64_bl8_hb_240_479 spect_pixel_wise_cond2_time_240_479
%spect_pixel_wise_cond2_1_5000=spect_pixel_wise_cond2(:,:,1:5000);
%save spect_pixel_wise_cond2_1_5000 spect_pixel_wise_cond2_1_5000
%clear spect_pixel_wise_cond2_1_5000
%spect_pixel_wise_cond2_5001_10000=spect_pixel_wise_cond2(:,:,5001:end);
%save spect_pixel_wise_cond2_5001_10000 spect_pixel_wise_cond2_5001_10000
clear all
load cond3n_dt_hb;
[spect_pixel_wise_cond3,baseline_ave_pixels,baseline_std_pixels]=spectogram_pixel_wise(cond3n_dt_hb);
clear cond3n_dt_hb;
spect_pixel_wise_cond3_time_1_239=spect_pixel_wise_cond3(:,1:239,:);
save spect_pixel_wise_cond3_res_64_bl8_hb_1_239 spect_pixel_wise_cond3_time_1_239
clear spect_pixel_wise_cond3_time_1_239
spect_pixel_wise_cond3_time_240_479=spect_pixel_wise_cond3(:,240:end,:);
save spect_pixel_wise_cond3_res_64_bl8_hb_240_479 spect_pixel_wise_cond3_time_240_479
%spect_pixel_wise_cond3_1_5000=spect_pixel_wise_cond3(:,:,1:5000);
%save spect_pixel_wise_cond3_1_5000 spect_pixel_wise_cond3_1_5000
%clear spect_pixel_wise_cond3_1_5000
%spect_pixel_wise_cond3_5001_10000=spect_pixel_wise_cond3(:,:,5001:end);
%save spect_pixel_wise_cond3_5001_10000 spect_pixel_wise_cond3_5001_10000
clear all
load cond4n_dt_hb;
[spect_pixel_wise_cond4,baseline_ave_pixels,baseline_std_pixels]=spectogram_pixel_wise(cond4n_dt_hb);
clear cond4n_dt_hb;
spect_pixel_wise_cond4_time_1_239=spect_pixel_wise_cond4(:,1:239,:);
save spect_pixel_wise_cond4_res_64_bl8_hb_1_239 spect_pixel_wise_cond4_time_1_239
clear spect_pixel_wise_cond4_time_1_239
spect_pixel_wise_cond4_time_240_479=spect_pixel_wise_cond4(:,240:end,:);
save spect_pixel_wise_cond4_res_64_bl8_hb_240_479 spect_pixel_wise_cond4_time_240_479
%spect_pixel_wise_cond4_1_5000=spect_pixel_wise_cond4(:,:,1:5000);
%save spect_pixel_wise_cond4_1_5000 spect_pixel_wise_cond4_1_5000
%clear spect_pixel_wise_cond4_1_5000
%spect_pixel_wise_cond4_5001_10000=spect_pixel_wise_cond4(:,:,5001:end);
%save spect_pixel_wise_cond4_5001_10000 spect_pixel_wise_cond4_5001_10000
clear all
load cond5n_dt_hb;
[spect_pixel_wise_cond5,baseline_ave_pixels,baseline_std_pixels]=spectogram_pixel_wise(cond5n_dt_hb);
clear cond5n_dt_hb;
spect_pixel_wise_cond5_time_1_239=spect_pixel_wise_cond5(:,1:239,:);
save spect_pixel_wise_cond5_res_64_bl8_hb_1_239 spect_pixel_wise_cond5_time_1_239
clear spect_pixel_wise_cond5_time_1_239
spect_pixel_wise_cond5_time_240_479=spect_pixel_wise_cond5(:,240:end,:);
save spect_pixel_wise_cond5_res_64_bl8_hb_240_479 spect_pixel_wise_cond5_time_240_479
%spect_pixel_wise_cond5_1_5000=spect_pixel_wise_cond5(:,:,1:5000);
%save spect_pixel_wise_cond5_1_5000 spect_pixel_wise_cond5_1_5000
%clear spect_pixel_wise_cond5_1_5000
%spect_pixel_wise_cond5_5001_10000=spect_pixel_wise_cond5(:,:,5001:end);
%save spect_pixel_wise_cond5_5001_10000 spect_pixel_wise_cond5_5001_10000
clear all
load cond6n_dt_hb;
[spect_pixel_wise_cond6,baseline_ave_pixels,baseline_std_pixels]=spectogram_pixel_wise(cond6n_dt_hb);
clear cond6n_dt_hb;
spect_pixel_wise_cond6_time_1_239=spect_pixel_wise_cond6(:,1:239,:);
save spect_pixel_wise_cond6_res_64_bl8_hb_1_239 spect_pixel_wise_cond6_time_1_239
clear spect_pixel_wise_cond6_time_1_239
spect_pixel_wise_cond6_time_240_479=spect_pixel_wise_cond6(:,240:end,:);
save spect_pixel_wise_cond6_res_64_bl8_hb_240_479 spect_pixel_wise_cond6_time_240_479
%spect_pixel_wise_cond6_1_5000=spect_pixel_wise_cond6(:,:,1:5000);
%save spect_pixel_wise_cond6_1_5000 spect_pixel_wise_cond6_1_5000
%clear spect_pixel_wise_cond6_1_5000
%spect_pixel_wise_cond6_5001_10000=spect_pixel_wise_cond6(:,:,5001:end);
%save spect_pixel_wise_cond6_5001_10000 spect_pixel_wise_cond6_5001_10000
clear all
%%
cd /fat2/Ariel_Gilad/Matlab_analysis/recon_jul_19_06
load FRM1_blank;
[spect_pixel_wise_cond1,baseline_ave_pixels,baseline_std_pixels]=spectogram_pixel_wise(FRM1_blank);
clear FRM1_blank;
save spect_pixel_wise_cond1_res_64_bl8_hb spect_pixel_wise_cond1
save baseline_cond1_bl8_hb baseline_ave_pixels baseline_std_pixels
%spect_pixel_wise_cond1_1_5000=spect_pixel_wise_cond1(:,:,1:5000);
%save spect_pixel_wise_cond1_1_5000 spect_pixel_wise_cond1_1_5000
%clear spect_pixel_wise_cond1_1_5000
%spect_pixel_wise_cond1_5001_10000=spect_pixel_wise_cond1(:,:,5001:end);
%save spect_pixel_wise_cond1_5001_10000 spect_pixel_wise_cond1_5001_10000
clear all
load FRM2_blank;
[spect_pixel_wise_cond2,baseline_ave_pixels,baseline_std_pixels]=spectogram_pixel_wise(FRM2_blank);
clear FRM2_blank;
save spect_pixel_wise_cond2_res_64_bl8_hb spect_pixel_wise_cond2
save baseline_cond2_bl8_hb baseline_ave_pixels baseline_std_pixels
%spect_pixel_wise_cond2_1_5000=spect_pixel_wise_cond2(:,:,1:5000);
%save spect_pixel_wise_cond2_1_5000 spect_pixel_wise_cond2_1_5000
%clear spect_pixel_wise_cond2_1_5000
%spect_pixel_wise_cond2_5001_10000=spect_pixel_wise_cond2(:,:,5001:end);
%save spect_pixel_wise_cond2_5001_10000 spect_pixel_wise_cond2_5001_10000
clear all
load FRM3_blank;
[spect_pixel_wise_cond3,baseline_ave_pixels,baseline_std_pixels]=spectogram_pixel_wise(FRM3_blank);
clear FRM3_blank;
save spect_pixel_wise_cond3_res_64_bl8_hb spect_pixel_wise_cond3
save baseline_cond3_bl8_hb baseline_ave_pixels baseline_std_pixels
%spect_pixel_wise_cond3_1_5000=spect_pixel_wise_cond3(:,:,1:5000);
%save spect_pixel_wise_cond3_1_5000 spect_pixel_wise_cond3_1_5000
%clear spect_pixel_wise_cond3_1_5000
%spect_pixel_wise_cond3_5001_10000=spect_pixel_wise_cond3(:,:,5001:end);
%save spect_pixel_wise_cond3_5001_10000 spect_pixel_wise_cond3_5001_10000
clear all
load FRM4_blank;
[spect_pixel_wise_cond4,baseline_ave_pixels,baseline_std_pixels]=spectogram_pixel_wise(FRM4_blank);
clear FRM4_blank;
save spect_pixel_wise_cond4_res_64_bl8_hb spect_pixel_wise_cond4
save baseline_cond4_bl8_hb baseline_ave_pixels baseline_std_pixels
%spect_pixel_wise_cond4_1_5000=spect_pixel_wise_cond4(:,:,1:5000);
%save spect_pixel_wise_cond4_1_5000 spect_pixel_wise_cond4_1_5000
%clear spect_pixel_wise_cond4_1_5000
%spect_pixel_wise_cond4_5001_10000=spect_pixel_wise_cond4(:,:,5001:end);
%save spect_pixel_wise_cond4_5001_10000 spect_pixel_wise_cond4_5001_10000
clear all
load FRM5_blank;
[spect_pixel_wise_cond5,baseline_ave_pixels,baseline_std_pixels]=spectogram_pixel_wise(FRM5_blank);
clear FRM5_blank;
save spect_pixel_wise_cond5_res_64_bl8_hb spect_pixel_wise_cond5
save baseline_cond5_bl8_hb baseline_ave_pixels baseline_std_pixels
%spect_pixel_wise_cond5_1_5000=spect_pixel_wise_cond5(:,:,1:5000);
%save spect_pixel_wise_cond5_1_5000 spect_pixel_wise_cond5_1_5000
%clear spect_pixel_wise_cond5_1_5000
%spect_pixel_wise_cond5_5001_10000=spect_pixel_wise_cond5(:,:,5001:end);
%save spect_pixel_wise_cond5_5001_10000 spect_pixel_wise_cond5_5001_10000
clear all
load FRM6_blank;
[spect_pixel_wise_cond6,baseline_ave_pixels,baseline_std_pixels]=spectogram_pixel_wise(FRM6_blank);
clear FRM6_blank;
save spect_pixel_wise_cond6_res_64_bl8_hb spect_pixel_wise_cond6
save baseline_cond6_bl8_hb baseline_ave_pixels baseline_std_pixels
%spect_pixel_wise_cond6_1_5000=spect_pixel_wise_cond6(:,:,1:5000);
%save spect_pixel_wise_cond6_1_5000 spect_pixel_wise_cond6_1_5000
%clear spect_pixel_wise_cond6_1_5000
%spect_pixel_wise_cond6_5001_10000=spect_pixel_wise_cond6(:,:,5001:end);
%save spect_pixel_wise_cond6_5001_10000 spect_pixel_wise_cond6_5001_10000
clear all



%%
cd /fat2/Ariel_Gilad/Matlab_analysis/2008_02_19/cond_data_a
load cond1n_dt_hb;
[spect_pixel_wise_cond1,baseline_ave_pixels,baseline_std_pixels]=spectogram_pixel_wise(cond1n_dt_hb);
clear cond1n_dt_hb;
save spect_pixel_wise_cond1_res_64_bl8_hb spect_pixel_wise_cond1
save baseline_cond1_bl8_hb baseline_ave_pixels baseline_std_pixels
%spect_pixel_wise_cond1_1_5000=spect_pixel_wise_cond1(:,:,1:5000);
%save spect_pixel_wise_cond1_1_5000 spect_pixel_wise_cond1_1_5000
%clear spect_pixel_wise_cond1_1_5000
%spect_pixel_wise_cond1_5001_10000=spect_pixel_wise_cond1(:,:,5001:end);
%save spect_pixel_wise_cond1_5001_10000 spect_pixel_wise_cond1_5001_10000
clear all
load cond2n_dt_hb;
[spect_pixel_wise_cond2,baseline_ave_pixels,baseline_std_pixels]=spectogram_pixel_wise(cond2n_dt_hb);
clear cond2n_dt_hb;
save spect_pixel_wise_cond2_res_64_bl8_hb spect_pixel_wise_cond2
save baseline_cond2_bl8_hb baseline_ave_pixels baseline_std_pixels
%spect_pixel_wise_cond2_1_5000=spect_pixel_wise_cond2(:,:,1:5000);
%save spect_pixel_wise_cond2_1_5000 spect_pixel_wise_cond2_1_5000
%clear spect_pixel_wise_cond2_1_5000
%spect_pixel_wise_cond2_5001_10000=spect_pixel_wise_cond2(:,:,5001:end);
%save spect_pixel_wise_cond2_5001_10000 spect_pixel_wise_cond2_5001_10000
clear all
load cond3n_dt_hb;
[spect_pixel_wise_cond3,baseline_ave_pixels,baseline_std_pixels]=spectogram_pixel_wise(cond3n_dt_hb);
clear cond3n_dt_hb;
save spect_pixel_wise_cond3_res_64_bl8_hb spect_pixel_wise_cond3
save baseline_cond3_bl8_hb baseline_ave_pixels baseline_std_pixels
%spect_pixel_wise_cond3_1_5000=spect_pixel_wise_cond3(:,:,1:5000);
%save spect_pixel_wise_cond3_1_5000 spect_pixel_wise_cond3_1_5000
%clear spect_pixel_wise_cond3_1_5000
%spect_pixel_wise_cond3_5001_10000=spect_pixel_wise_cond3(:,:,5001:end);
%save spect_pixel_wise_cond3_5001_10000 spect_pixel_wise_cond3_5001_10000
clear all
load cond4n_dt_hb;
[spect_pixel_wise_cond4,baseline_ave_pixels,baseline_std_pixels]=spectogram_pixel_wise(cond4n_dt_hb);
clear cond4n_dt_hb;
save spect_pixel_wise_cond4_res_64_bl8_hb spect_pixel_wise_cond4
save baseline_cond4_bl8_hb baseline_ave_pixels baseline_std_pixels
%spect_pixel_wise_cond4_1_5000=spect_pixel_wise_cond4(:,:,1:5000);
%save spect_pixel_wise_cond4_1_5000 spect_pixel_wise_cond4_1_5000
%clear spect_pixel_wise_cond4_1_5000
%spect_pixel_wise_cond4_5001_10000=spect_pixel_wise_cond4(:,:,5001:end);
%save spect_pixel_wise_cond4_5001_10000 spect_pixel_wise_cond4_5001_10000
clear all
load cond5n_dt_hb;
[spect_pixel_wise_cond5,baseline_ave_pixels,baseline_std_pixels]=spectogram_pixel_wise(cond5n_dt_hb);
clear cond5n_dt_hb;
save spect_pixel_wise_cond5_res_64_bl8_hb spect_pixel_wise_cond5
save baseline_cond5_bl8_hb baseline_ave_pixels baseline_std_pixels
%spect_pixel_wise_cond5_1_5000=spect_pixel_wise_cond5(:,:,1:5000);
%save spect_pixel_wise_cond5_1_5000 spect_pixel_wise_cond5_1_5000
%clear spect_pixel_wise_cond5_1_5000
%spect_pixel_wise_cond5_5001_10000=spect_pixel_wise_cond5(:,:,5001:end);
%save spect_pixel_wise_cond5_5001_10000 spect_pixel_wise_cond5_5001_10000
clear all
load cond6n_dt_hb;
[spect_pixel_wise_cond6,baseline_ave_pixels,baseline_std_pixels]=spectogram_pixel_wise(cond6n_dt_hb);
clear cond6n_dt_hb;
save spect_pixel_wise_cond6_res_64_bl8_hb spect_pixel_wise_cond6
save baseline_cond6_bl8_hb baseline_ave_pixels baseline_std_pixels
%spect_pixel_wise_cond6_1_5000=spect_pixel_wise_cond6(:,:,1:5000);
%save spect_pixel_wise_cond6_1_5000 spect_pixel_wise_cond6_1_5000
%clear spect_pixel_wise_cond6_1_5000
%spect_pixel_wise_cond6_5001_10000=spect_pixel_wise_cond6(:,:,5001:end);
%save spect_pixel_wise_cond6_5001_10000 spect_pixel_wise_cond6_5001_10000
clear all
%%

cd /fat2/Ariel_Gilad/Matlab_analysis/25oct2006/cond_data_d
load cond1n_dt_bl;
[spect_pixel_wise_cond1,baseline_ave_pixels,baseline_std_pixels]=spectogram_pixel_wise(cond1n_dt_bl);
clear cond1n_dt_bl;
save spect_pixel_wise_cond1_res_64_bl8_bl spect_pixel_wise_cond1
save baseline_cond1_bl8_bl baseline_ave_pixels baseline_std_pixels
%spect_pixel_wise_cond1_1_5000=spect_pixel_wise_cond1(:,:,1:5000);
%save spect_pixel_wise_cond1_1_5000 spect_pixel_wise_cond1_1_5000
%clear spect_pixel_wise_cond1_1_5000
%spect_pixel_wise_cond1_5001_10000=spect_pixel_wise_cond1(:,:,5001:end);
%save spect_pixel_wise_cond1_5001_10000 spect_pixel_wise_cond1_5001_10000
clear all
load cond2n_dt_bl;
[spect_pixel_wise_cond2,baseline_ave_pixels,baseline_std_pixels]=spectogram_pixel_wise(cond2n_dt_bl);
clear cond2n_dt_bl;
save spect_pixel_wise_cond2_res_64_bl8_bl spect_pixel_wise_cond2
save baseline_cond2_bl8_bl baseline_ave_pixels baseline_std_pixels
%spect_pixel_wise_cond2_1_5000=spect_pixel_wise_cond2(:,:,1:5000);
%save spect_pixel_wise_cond2_1_5000 spect_pixel_wise_cond2_1_5000
%clear spect_pixel_wise_cond2_1_5000
%spect_pixel_wise_cond2_5001_10000=spect_pixel_wise_cond2(:,:,5001:end);
%save spect_pixel_wise_cond2_5001_10000 spect_pixel_wise_cond2_5001_10000
clear all
load cond3n_dt_bl;
[spect_pixel_wise_cond3,baseline_ave_pixels,baseline_std_pixels]=spectogram_pixel_wise(cond3n_dt_bl);
clear cond3n_dt_bl;
save spect_pixel_wise_cond3_res_64_bl8_bl spect_pixel_wise_cond3
save baseline_cond3_bl8_bl baseline_ave_pixels baseline_std_pixels
%spect_pixel_wise_cond3_1_5000=spect_pixel_wise_cond3(:,:,1:5000);
%save spect_pixel_wise_cond3_1_5000 spect_pixel_wise_cond3_1_5000
%clear spect_pixel_wise_cond3_1_5000
%spect_pixel_wise_cond3_5001_10000=spect_pixel_wise_cond3(:,:,5001:end);
%save spect_pixel_wise_cond3_5001_10000 spect_pixel_wise_cond3_5001_10000
clear all
load cond4n_dt_bl;
[spect_pixel_wise_cond4,baseline_ave_pixels,baseline_std_pixels]=spectogram_pixel_wise(cond4n_dt_bl);
clear cond4n_dt_bl;
save spect_pixel_wise_cond4_res_64_bl8_bl spect_pixel_wise_cond4
save baseline_cond4_bl8_bl baseline_ave_pixels baseline_std_pixels
%spect_pixel_wise_cond4_1_5000=spect_pixel_wise_cond4(:,:,1:5000);
%save spect_pixel_wise_cond4_1_5000 spect_pixel_wise_cond4_1_5000
%clear spect_pixel_wise_cond4_1_5000
%spect_pixel_wise_cond4_5001_10000=spect_pixel_wise_cond4(:,:,5001:end);
%save spect_pixel_wise_cond4_5001_10000 spect_pixel_wise_cond4_5001_10000
clear all
load cond5n_dt_bl;
[spect_pixel_wise_cond5,baseline_ave_pixels,baseline_std_pixels]=spectogram_pixel_wise(cond5n_dt_bl);
clear cond5n_dt_bl;
save spect_pixel_wise_cond5_res_64_bl8_bl spect_pixel_wise_cond5
save baseline_cond5_bl8_bl baseline_ave_pixels baseline_std_pixels
%spect_pixel_wise_cond5_1_5000=spect_pixel_wise_cond5(:,:,1:5000);
%save spect_pixel_wise_cond5_1_5000 spect_pixel_wise_cond5_1_5000
%clear spect_pixel_wise_cond5_1_5000
%spect_pixel_wise_cond5_5001_10000=spect_pixel_wise_cond5(:,:,5001:end);
%save spect_pixel_wise_cond5_5001_10000 spect_pixel_wise_cond5_5001_10000
clear all
load cond6n_dt_bl;
[spect_pixel_wise_cond6,baseline_ave_pixels,baseline_std_pixels]=spectogram_pixel_wise(cond6n_dt_bl);
clear cond6n_dt_bl;
save spect_pixel_wise_cond6_res_64_bl8_bl spect_pixel_wise_cond6
save baseline_cond6_bl8_bl baseline_ave_pixels baseline_std_pixels
%spect_pixel_wise_cond6_1_5000=spect_pixel_wise_cond6(:,:,1:5000);
%save spect_pixel_wise_cond6_1_5000 spect_pixel_wise_cond6_1_5000
%clear spect_pixel_wise_cond6_1_5000
%spect_pixel_wise_cond6_5001_10000=spect_pixel_wise_cond6(:,:,5001:end);
%save spect_pixel_wise_cond6_5001_10000 spect_pixel_wise_cond6_5001_10000
clear all

cd /fat2/Ariel_Gilad/Matlab_analysis/19mar2007/cond_data_b
load cond1n_dt_bl;
[spect_pixel_wise_cond1,baseline_ave_pixels,baseline_std_pixels]=spectogram_pixel_wise(cond1n_dt_bl);
clear cond1n_dt_bl;
save spect_pixel_wise_cond1_res_64_bl8_bl spect_pixel_wise_cond1
save baseline_cond1_bl8_bl baseline_ave_pixels baseline_std_pixels
%spect_pixel_wise_cond1_1_5000=spect_pixel_wise_cond1(:,:,1:5000);
%save spect_pixel_wise_cond1_1_5000 spect_pixel_wise_cond1_1_5000
%clear spect_pixel_wise_cond1_1_5000
%spect_pixel_wise_cond1_5001_10000=spect_pixel_wise_cond1(:,:,5001:end);
%save spect_pixel_wise_cond1_5001_10000 spect_pixel_wise_cond1_5001_10000
clear all
load cond2n_dt_bl;
[spect_pixel_wise_cond2,baseline_ave_pixels,baseline_std_pixels]=spectogram_pixel_wise(cond2n_dt_bl);
clear cond2n_dt_bl;
save spect_pixel_wise_cond2_res_64_bl8_bl spect_pixel_wise_cond2
save baseline_cond2_bl8_bl baseline_ave_pixels baseline_std_pixels
%spect_pixel_wise_cond2_1_5000=spect_pixel_wise_cond2(:,:,1:5000);
%save spect_pixel_wise_cond2_1_5000 spect_pixel_wise_cond2_1_5000
%clear spect_pixel_wise_cond2_1_5000
%spect_pixel_wise_cond2_5001_10000=spect_pixel_wise_cond2(:,:,5001:end);
%save spect_pixel_wise_cond2_5001_10000 spect_pixel_wise_cond2_5001_10000
clear all
load cond3n_dt_bl;
[spect_pixel_wise_cond3,baseline_ave_pixels,baseline_std_pixels]=spectogram_pixel_wise(cond3n_dt_bl);
clear cond3n_dt_bl;
save spect_pixel_wise_cond3_res_64_bl8_bl spect_pixel_wise_cond3
save baseline_cond3_bl8_bl baseline_ave_pixels baseline_std_pixels
%spect_pixel_wise_cond3_1_5000=spect_pixel_wise_cond3(:,:,1:5000);
%save spect_pixel_wise_cond3_1_5000 spect_pixel_wise_cond3_1_5000
%clear spect_pixel_wise_cond3_1_5000
%spect_pixel_wise_cond3_5001_10000=spect_pixel_wise_cond3(:,:,5001:end);
%save spect_pixel_wise_cond3_5001_10000 spect_pixel_wise_cond3_5001_10000
clear all
load cond4n_dt_bl;
[spect_pixel_wise_cond4,baseline_ave_pixels,baseline_std_pixels]=spectogram_pixel_wise(cond4n_dt_bl);
clear cond4n_dt_bl;
save spect_pixel_wise_cond4_res_64_bl8_bl spect_pixel_wise_cond4
save baseline_cond4_bl8_bl baseline_ave_pixels baseline_std_pixels
%spect_pixel_wise_cond4_1_5000=spect_pixel_wise_cond4(:,:,1:5000);
%save spect_pixel_wise_cond4_1_5000 spect_pixel_wise_cond4_1_5000
%clear spect_pixel_wise_cond4_1_5000
%spect_pixel_wise_cond4_5001_10000=spect_pixel_wise_cond4(:,:,5001:end);
%save spect_pixel_wise_cond4_5001_10000 spect_pixel_wise_cond4_5001_10000
clear all
load cond5n_dt_bl;
[spect_pixel_wise_cond5,baseline_ave_pixels,baseline_std_pixels]=spectogram_pixel_wise(cond5n_dt_bl);
clear cond5n_dt_bl;
save spect_pixel_wise_cond5_res_64_bl8_bl spect_pixel_wise_cond5
save baseline_cond5_bl8_bl baseline_ave_pixels baseline_std_pixels
%spect_pixel_wise_cond5_1_5000=spect_pixel_wise_cond5(:,:,1:5000);
%save spect_pixel_wise_cond5_1_5000 spect_pixel_wise_cond5_1_5000
%clear spect_pixel_wise_cond5_1_5000
%spect_pixel_wise_cond5_5001_10000=spect_pixel_wise_cond5(:,:,5001:end);
%save spect_pixel_wise_cond5_5001_10000 spect_pixel_wise_cond5_5001_10000
clear all
load cond6n_dt_bl;
[spect_pixel_wise_cond6,baseline_ave_pixels,baseline_std_pixels]=spectogram_pixel_wise(cond6n_dt_bl);
clear cond6n_dt_bl;
save spect_pixel_wise_cond6_res_64_bl8_bl spect_pixel_wise_cond6
save baseline_cond6_bl8_bl baseline_ave_pixels baseline_std_pixels
%spect_pixel_wise_cond6_1_5000=spect_pixel_wise_cond6(:,:,1:5000);
%save spect_pixel_wise_cond6_1_5000 spect_pixel_wise_cond6_1_5000
%clear spect_pixel_wise_cond6_1_5000
%spect_pixel_wise_cond6_5001_10000=spect_pixel_wise_cond6(:,:,5001:end);
%save spect_pixel_wise_cond6_5001_10000 spect_pixel_wise_cond6_5001_10000
clear all

%%
%make movies for all frequency bands
cd /fat2/Ariel_Gilad/Matlab_analysis/2008_01_15/cond_data
load spect_pixel_wise_cond1_res_64_bl8_hb.mat
M=mat2movie((squeeze(mean(spect_pixel_wise_cond1(1:3,:,:),1))).', 100, 100, -0.25, 0.2,mapgeog, 1, 223);
cd /fat2/Ariel_Gilad/Matlab_analysis/2008_01_15/movies
movie2avi(M,'movie_tetha_2_6_cond1_4_fps','compression','none','quality',100,'fps',4);
M=mat2movie((squeeze(mean(spect_pixel_wise_cond1(4:7,:,:),1))).', 100, 100, -0.25, 0.2,mapgeog, 1, 223);
movie2avi(M,'movie_alpha_7_14_cond1_4_fps','compression','none','quality',100,'fps',4);
M=mat2movie((squeeze(mean(spect_pixel_wise_cond1(8:12,:,:),1))).', 100, 100, -0.25, 0.2,mapgeog, 1, 223);
movie2avi(M,'movie_beta_16_24_cond1_4_fps','compression','none','quality',100,'fps',4);
M=mat2movie((squeeze(mean(spect_pixel_wise_cond1(13:20,:,:),1))).', 100, 100, -0.25, 0.2,mapgeog, 1, 223);
movie2avi(M,'movie_low_gamma_26_40_cond1_4_fps','compression','none','quality',100,'fps',4);
M=mat2movie((squeeze(mean(spect_pixel_wise_cond1(21:30,:,:),1))).', 100, 100, -0.25, 0.2,mapgeog, 1, 223);
movie2avi(M,'movie_42_60_cond1_4_fps','compression','none','quality',100,'fps',4);
M=mat2movie((squeeze(mean(spect_pixel_wise_cond1(31:45,:,:),1))).', 100, 100, -0.25, 0.2,mapgeog, 1, 223);
movie2avi(M,'movie_high_gamma_62_90_cond1_4_fps','compression','none','quality',100,'fps',4);
M=mat2movie((squeeze(mean(spect_pixel_wise_cond1(46:64,:,:),1))).', 100, 100, -0.25, 0.2,mapgeog, 1, 223);
movie2avi(M,'movie_90_125_cond1_4_fps','compression','none','quality',100,'fps',4);
clear all;
cd /fat2/Ariel_Gilad/Matlab_analysis/2008_01_15/cond_data
load spect_pixel_wise_cond2_res_64_bl8_hb.mat
M=mat2movie((squeeze(mean(spect_pixel_wise_cond2(1:3,:,:),1))).', 100, 100, -0.25, 0.2,mapgeog, 1, 223);
cd /fat2/Ariel_Gilad/Matlab_analysis/2008_01_15/movies
movie2avi(M,'movie_tetha_2_6_cond2_4_fps','compression','none','quality',100,'fps',4);
M=mat2movie((squeeze(mean(spect_pixel_wise_cond2(4:7,:,:),1))).', 100, 100, -0.25, 0.2,mapgeog, 1, 223);
movie2avi(M,'movie_alpha_7_14_cond2_4_fps','compression','none','quality',100,'fps',4);
M=mat2movie((squeeze(mean(spect_pixel_wise_cond2(8:12,:,:),1))).', 100, 100, -0.25, 0.2,mapgeog, 1, 223);
movie2avi(M,'movie_beta_16_24_cond2_4_fps','compression','none','quality',100,'fps',4);
M=mat2movie((squeeze(mean(spect_pixel_wise_cond2(13:20,:,:),1))).', 100, 100, -0.25, 0.2,mapgeog, 1, 223);
movie2avi(M,'movie_low_gamma_26_40_cond2_4_fps','compression','none','quality',100,'fps',4);
M=mat2movie((squeeze(mean(spect_pixel_wise_cond2(21:30,:,:),1))).', 100, 100, -0.25, 0.2,mapgeog, 1, 223);
movie2avi(M,'movie_42_60_cond2_4_fps','compression','none','quality',100,'fps',4);
M=mat2movie((squeeze(mean(spect_pixel_wise_cond2(31:45,:,:),1))).', 100, 100, -0.25, 0.2,mapgeog, 1, 223);
movie2avi(M,'movie_high_gamma_62_90_cond2_4_fps','compression','none','quality',100,'fps',4);
M=mat2movie((squeeze(mean(spect_pixel_wise_cond2(46:64,:,:),1))).', 100, 100, -0.25, 0.2,mapgeog, 1, 223);
movie2avi(M,'movie_90_125_cond2_4_fps','compression','none','quality',100,'fps',4);
clear all;
cd /fat2/Ariel_Gilad/Matlab_analysis/2008_01_15/cond_data
load spect_pixel_wise_cond3_res_64_bl8_hb.mat
M=mat2movie((squeeze(mean(spect_pixel_wise_cond3(1:3,:,:),1))).', 100, 100, -0.25, 0.2,mapgeog, 1, 223);
cd /fat2/Ariel_Gilad/Matlab_analysis/2008_01_15/movies
movie2avi(M,'movie_tetha_2_6_cond3_4_fps','compression','none','quality',100,'fps',4);
M=mat2movie((squeeze(mean(spect_pixel_wise_cond3(4:7,:,:),1))).', 100, 100, -0.25, 0.2,mapgeog, 1, 223);
movie2avi(M,'movie_alpha_7_14_cond3_4_fps','compression','none','quality',100,'fps',4);
M=mat2movie((squeeze(mean(spect_pixel_wise_cond3(8:12,:,:),1))).', 100, 100, -0.25, 0.2,mapgeog, 1, 223);
movie2avi(M,'movie_beta_16_24_cond3_4_fps','compression','none','quality',100,'fps',4);
M=mat2movie((squeeze(mean(spect_pixel_wise_cond3(13:20,:,:),1))).', 100, 100, -0.25, 0.2,mapgeog, 1, 223);
movie2avi(M,'movie_low_gamma_26_40_cond3_4_fps','compression','none','quality',100,'fps',4);
M=mat2movie((squeeze(mean(spect_pixel_wise_cond3(21:30,:,:),1))).', 100, 100, -0.25, 0.2,mapgeog, 1, 223);
movie2avi(M,'movie_42_60_cond3_4_fps','compression','none','quality',100,'fps',4);
M=mat2movie((squeeze(mean(spect_pixel_wise_cond3(31:45,:,:),1))).', 100, 100, -0.25, 0.2,mapgeog, 1, 223);
movie2avi(M,'movie_high_gamma_62_90_cond3_4_fps','compression','none','quality',100,'fps',4);
M=mat2movie((squeeze(mean(spect_pixel_wise_cond3(46:64,:,:),1))).', 100, 100, -0.25, 0.2,mapgeog, 1, 223);
movie2avi(M,'movie_90_125_cond3_4_fps','compression','none','quality',100,'fps',4);
clear all;
cd /fat2/Ariel_Gilad/Matlab_analysis/2008_01_15/cond_data
load spect_pixel_wise_cond4_res_64_bl8_hb.mat
M=mat2movie((squeeze(mean(spect_pixel_wise_cond4(1:3,:,:),1))).', 100, 100, -0.25, 0.2,mapgeog, 1, 223);
cd /fat2/Ariel_Gilad/Matlab_analysis/2008_01_15/movies
movie2avi(M,'movie_tetha_2_6_cond4_4_fps','compression','none','quality',100,'fps',4);
M=mat2movie((squeeze(mean(spect_pixel_wise_cond4(4:7,:,:),1))).', 100, 100, -0.25, 0.2,mapgeog, 1, 223);
movie2avi(M,'movie_alpha_7_14_cond4_4_fps','compression','none','quality',100,'fps',4);
M=mat2movie((squeeze(mean(spect_pixel_wise_cond4(8:12,:,:),1))).', 100, 100, -0.25, 0.2,mapgeog, 1, 223);
movie2avi(M,'movie_beta_16_24_cond4_4_fps','compression','none','quality',100,'fps',4);
M=mat2movie((squeeze(mean(spect_pixel_wise_cond4(13:20,:,:),1))).', 100, 100, -0.25, 0.2,mapgeog, 1, 223);
movie2avi(M,'movie_low_gamma_26_40_cond4_4_fps','compression','none','quality',100,'fps',4);
M=mat2movie((squeeze(mean(spect_pixel_wise_cond4(21:30,:,:),1))).', 100, 100, -0.25, 0.2,mapgeog, 1, 223);
movie2avi(M,'movie_42_60_cond4_4_fps','compression','none','quality',100,'fps',4);
M=mat2movie((squeeze(mean(spect_pixel_wise_cond4(31:45,:,:),1))).', 100, 100, -0.25, 0.2,mapgeog, 1, 223);
movie2avi(M,'movie_high_gamma_62_90_cond4_4_fps','compression','none','quality',100,'fps',4);
M=mat2movie((squeeze(mean(spect_pixel_1wise_cond4(46:64,:,:),1))).', 100, 100, -0.25, 0.2,mapgeog, 1, 223);
movie2avi(M,'movie_90_125_cond4_4_fps','compression','none','quality',100,'fps',4);
clear all;
cd /fat2/Ariel_Gilad/Matlab_analysis/2008_01_15/cond_data
load spect_pixel_wise_cond5_res_64_bl8_hb.mat
M=mat2movie((squeeze(mean(spect_pixel_wise_cond5(1:3,:,:),1))).', 100, 100, -0.25, 0.2,mapgeog, 1, 223);
cd /fat2/Ariel_Gilad/Matlab_analysis/2008_01_15/movies
movie2avi(M,'movie_tetha_2_6_cond5_4_fps','compression','none','quality',100,'fps',4);
M=mat2movie((squeeze(mean(spect_pixel_wise_cond5(4:7,:,:),1))).', 100, 100, -0.25, 0.2,mapgeog, 1, 223);
movie2avi(M,'movie_alpha_7_14_cond5_4_fps','compression','none','quality',100,'fps',4);
M=mat2movie((squeeze(mean(spect_pixel_wise_cond5(8:12,:,:),1))).', 100, 100, -0.25, 0.2,mapgeog, 1, 223);
movie2avi(M,'movie_beta_16_24_cond5_4_fps','compression','none','quality',100,'fps',4);
M=mat2movie((squeeze(mean(spect_pixel_wise_cond5(13:20,:,:),1))).', 100, 100, -0.25, 0.2,mapgeog, 1, 223);
movie2avi(M,'movie_low_gamma_26_40_cond5_4_fps','compression','none','quality',100,'fps',4);
M=mat2movie((squeeze(mean(spect_pixel_wise_cond5(21:30,:,:),1))).', 100, 100, -0.25, 0.2,mapgeog, 1, 223);
movie2avi(M,'movie_42_60_cond5_4_fps','compression','none','quality',100,'fps',4);
M=mat2movie((squeeze(mean(spect_pixel_wise_cond5(31:45,:,:),1))).', 100, 100, -0.25, 0.2,mapgeog, 1, 223);
movie2avi(M,'movie_high_gamma_62_90_cond5_4_fps','compression','none','quality',100,'fps',4);
M=mat2movie((squeeze(mean(spect_pixel_wise_cond5(46:64,:,:),1))).', 100, 100, -0.25, 0.2,mapgeog, 1, 223);
movie2avi(M,'movie_90_125_cond5_4_fps','compression','none','quality',100,'fps',4);
clear all;
cd /fat2/Ariel_Gilad/Matlab_analysis/2008_01_15/cond_data
load spect_pixel_wise_cond6_res_64_bl8_hb.mat
M=mat2movie((squeeze(mean(spect_pixel_wise_cond6(1:3,:,:),1))).', 100, 100, -0.25, 0.2,mapgeog, 1, 223);
cd /fat2/Ariel_Gilad/Matlab_analysis/2008_01_15/movies
movie2avi(M,'movie_tetha_2_6_cond6_4_fps','compression','none','quality',100,'fps',4);
M=mat2movie((squeeze(mean(spect_pixel_wise_cond6(4:7,:,:),1))).', 100, 100, -0.25, 0.2,mapgeog, 1, 223);
movie2avi(M,'movie_alpha_7_14_cond6_4_fps','compression','none','quality',100,'fps',4);
M=mat2movie((squeeze(mean(spect_pixel_wise_cond6(8:12,:,:),1))).', 100, 100, -0.25, 0.2,mapgeog, 1, 223);
movie2avi(M,'movie_beta_16_24_cond6_4_fps','compression','none','quality',100,'fps',4);
M=mat2movie((squeeze(mean(spect_pixel_wise_cond6(13:20,:,:),1))).', 100, 100, -0.25, 0.2,mapgeog, 1, 223);
movie2avi(M,'movie_low_gamma_26_40_cond6_4_fps','compression','none','quality',100,'fps',4);
M=mat2movie((squeeze(mean(spect_pixel_wise_cond6(21:30,:,:),1))).', 100, 100, -0.25, 0.2,mapgeog, 1, 223);
movie2avi(M,'movie_42_60_cond6_4_fps','compression','none','quality',100,'fps',4);
M=mat2movie((squeeze(mean(spect_pixel_wise_cond6(31:45,:,:),1))).', 100, 100, -0.25, 0.2,mapgeog, 1, 223);
movie2avi(M,'movie_high_gamma_62_90_cond6_4_fps','compression','none','quality',100,'fps',4);
M=mat2movie((squeeze(mean(spect_pixel_wise_cond6(46:64,:,:),1))).', 100, 100, -0.25, 0.2,mapgeog, 1, 223);
movie2avi(M,'movie_90_125_cond6_4_fps','compression','none','quality',100,'fps',4);
clear all;

%%
cd /fat2/Ariel_Gilad/Matlab_analysis/2008_01_23/cond_data
load spect_pixel_wise_cond1_res_64_bl8_hb.mat
M=mat2movie((squeeze(mean(spect_pixel_wise_cond1(1:3,:,:),1))).', 100, 100, -0.25, 0.2,mapgeog, 1, 223);
cd /fat2/Ariel_Gilad/Matlab_analysis/2008_01_23/movies
movie2avi(M,'movie_tetha_2_6_cond1_4_fps','compression','none','quality',100,'fps',4);
M=mat2movie((squeeze(mean(spect_pixel_wise_cond1(4:7,:,:),1))).', 100, 100, -0.25, 0.2,mapgeog, 1, 223);
movie2avi(M,'movie_alpha_7_14_cond1_4_fps','compression','none','quality',100,'fps',4);
M=mat2movie((squeeze(mean(spect_pixel_wise_cond1(8:12,:,:),1))).', 100, 100, -0.25, 0.2,mapgeog, 1, 223);
movie2avi(M,'movie_beta_16_24_cond1_4_fps','compression','none','quality',100,'fps',4);
M=mat2movie((squeeze(mean(spect_pixel_wise_cond1(13:20,:,:),1))).', 100, 100, -0.25, 0.2,mapgeog, 1, 223);
movie2avi(M,'movie_low_gamma_26_40_cond1_4_fps','compression','none','quality',100,'fps',4);
M=mat2movie((squeeze(mean(spect_pixel_wise_cond1(21:30,:,:),1))).', 100, 100, -0.25, 0.2,mapgeog, 1, 223);
movie2avi(M,'movie_42_60_cond1_4_fps','compression','none','quality',100,'fps',4);
M=mat2movie((squeeze(mean(spect_pixel_wise_cond1(31:45,:,:),1))).', 100, 100, -0.25, 0.2,mapgeog, 1, 223);
movie2avi(M,'movie_high_gamma_62_90_cond1_4_fps','compression','none','quality',100,'fps',4);
M=mat2movie((squeeze(mean(spect_pixel_wise_cond1(46:64,:,:),1))).', 100, 100, -0.25, 0.2,mapgeog, 1, 223);
movie2avi(M,'movie_90_125_cond1_4_fps','compression','none','quality',100,'fps',4);
clear all;
cd /fat2/Ariel_Gilad/Matlab_analysis/2008_01_23/cond_data
load spect_pixel_wise_cond2_res_64_bl8_hb.mat
M=mat2movie((squeeze(mean(spect_pixel_wise_cond2(1:3,:,:),1))).', 100, 100, -0.25, 0.2,mapgeog, 1, 223);
cd /fat2/Ariel_Gilad/Matlab_analysis/2008_01_23/movies
movie2avi(M,'movie_tetha_2_6_cond2_4_fps','compression','none','quality',100,'fps',4);
M=mat2movie((squeeze(mean(spect_pixel_wise_cond2(4:7,:,:),1))).', 100, 100, -0.25, 0.2,mapgeog, 1, 223);
movie2avi(M,'movie_alpha_7_14_cond2_4_fps','compression','none','quality',100,'fps',4);
M=mat2movie((squeeze(mean(spect_pixel_wise_cond2(8:12,:,:),1))).', 100, 100, -0.25, 0.2,mapgeog, 1, 223);
movie2avi(M,'movie_beta_16_24_cond2_4_fps','compression','none','quality',100,'fps',4);
M=mat2movie((squeeze(mean(spect_pixel_wise_cond2(13:20,:,:),1))).', 100, 100, -0.25, 0.2,mapgeog, 1, 223);
movie2avi(M,'movie_low_gamma_26_40_cond2_4_fps','compression','none','quality',100,'fps',4);
M=mat2movie((squeeze(mean(spect_pixel_wise_cond2(21:30,:,:),1))).', 100, 100, -0.25, 0.2,mapgeog, 1, 223);
movie2avi(M,'movie_42_60_cond2_4_fps','compression','none','quality',100,'fps',4);
M=mat2movie((squeeze(mean(spect_pixel_wise_cond2(31:45,:,:),1))).', 100, 100, -0.25, 0.2,mapgeog, 1, 223);
movie2avi(M,'movie_high_gamma_62_90_cond2_4_fps','compression','none','quality',100,'fps',4);
M=mat2movie((squeeze(mean(spect_pixel_wise_cond2(46:64,:,:),1))).', 100, 100, -0.25, 0.2,mapgeog, 1, 223);
movie2avi(M,'movie_90_125_cond2_4_fps','compression','none','quality',100,'fps',4);
clear all;
cd /fat2/Ariel_Gilad/Matlab_analysis/2008_01_23/cond_data
load spect_pixel_wise_cond3_res_64_bl8_hb.mat
M=mat2movie((squeeze(mean(spect_pixel_wise_cond3(1:3,:,:),1))).', 100, 100, -0.25, 0.2,mapgeog, 1, 223);
cd /fat2/Ariel_Gilad/Matlab_analysis/2008_01_23/movies
movie2avi(M,'movie_tetha_2_6_cond3_4_fps','compression','none','quality',100,'fps',4);
M=mat2movie((squeeze(mean(spect_pixel_wise_cond3(4:7,:,:),1))).', 100, 100, -0.25, 0.2,mapgeog, 1, 223);
movie2avi(M,'movie_alpha_7_14_cond3_4_fps','compression','none','quality',100,'fps',4);
M=mat2movie((squeeze(mean(spect_pixel_wise_cond3(8:12,:,:),1))).', 100, 100, -0.25, 0.2,mapgeog, 1, 223);
movie2avi(M,'movie_beta_16_24_cond3_4_fps','compression','none','quality',100,'fps',4);
M=mat2movie((squeeze(mean(spect_pixel_wise_cond3(13:20,:,:),1))).', 100, 100, -0.25, 0.2,mapgeog, 1, 223);
movie2avi(M,'movie_low_gamma_26_40_cond3_4_fps','compression','none','quality',100,'fps',4);
M=mat2movie((squeeze(mean(spect_pixel_wise_cond3(21:30,:,:),1))).', 100, 100, -0.25, 0.2,mapgeog, 1, 223);
movie2avi(M,'movie_42_60_cond3_4_fps','compression','none','quality',100,'fps',4);
M=mat2movie((squeeze(mean(spect_pixel_wise_cond3(31:45,:,:),1))).', 100, 100, -0.25, 0.2,mapgeog, 1, 223);
movie2avi(M,'movie_high_gamma_62_90_cond3_4_fps','compression','none','quality',100,'fps',4);
M=mat2movie((squeeze(mean(spect_pixel_wise_cond3(46:64,:,:),1))).', 100, 100, -0.25, 0.2,mapgeog, 1, 223);
movie2avi(M,'movie_90_125_cond3_4_fps','compression','none','quality',100,'fps',4);
clear all;
cd /fat2/Ariel_Gilad/Matlab_analysis/2008_01_23/cond_data
load spect_pixel_wise_cond4_res_64_bl8_hb.mat
M=mat2movie((squeeze(mean(spect_pixel_wise_cond4(1:3,:,:),1))).', 100, 100, -0.25, 0.2,mapgeog, 1, 223);
cd /fat2/Ariel_Gilad/Matlab_analysis/2008_01_23/movies
movie2avi(M,'movie_tetha_2_6_cond4_4_fps','compression','none','quality',100,'fps',4);
M=mat2movie((squeeze(mean(spect_pixel_wise_cond4(4:7,:,:),1))).', 100, 100, -0.25, 0.2,mapgeog, 1, 223);
movie2avi(M,'movie_alpha_7_14_cond4_4_fps','compression','none','quality',100,'fps',4);
M=mat2movie((squeeze(mean(spect_pixel_wise_cond4(8:12,:,:),1))).', 100, 100, -0.25, 0.2,mapgeog, 1, 223);
movie2avi(M,'movie_beta_16_24_cond4_4_fps','compression','none','quality',100,'fps',4);
M=mat2movie((squeeze(mean(spect_pixel_wise_cond4(13:20,:,:),1))).', 100, 100, -0.25, 0.2,mapgeog, 1, 223);
movie2avi(M,'movie_low_gamma_26_40_cond4_4_fps','compression','none','quality',100,'fps',4);
M=mat2movie((squeeze(mean(spect_pixel_wise_cond4(21:30,:,:),1))).', 100, 100, -0.25, 0.2,mapgeog, 1, 223);
movie2avi(M,'movie_42_60_cond4_4_fps','compression','none','quality',100,'fps',4);
M=mat2movie((squeeze(mean(spect_pixel_wise_cond4(31:45,:,:),1))).', 100, 100, -0.25, 0.2,mapgeog, 1, 223);
movie2avi(M,'movie_high_gamma_62_90_cond4_4_fps','compression','none','quality',100,'fps',4);
M=mat2movie((squeeze(mean(spect_pixel_1wise_cond4(46:64,:,:),1))).', 100, 100, -0.25, 0.2,mapgeog, 1, 223);
movie2avi(M,'movie_90_125_cond4_4_fps','compression','none','quality',100,'fps',4);
clear all;
cd /fat2/Ariel_Gilad/Matlab_analysis/2008_01_23/cond_data
load spect_pixel_wise_cond5_res_64_bl8_hb.mat
M=mat2movie((squeeze(mean(spect_pixel_wise_cond5(1:3,:,:),1))).', 100, 100, -0.25, 0.2,mapgeog, 1, 223);
cd /fat2/Ariel_Gilad/Matlab_analysis/2008_01_23/movies
movie2avi(M,'movie_tetha_2_6_cond5_4_fps','compression','none','quality',100,'fps',4);
M=mat2movie((squeeze(mean(spect_pixel_wise_cond5(4:7,:,:),1))).', 100, 100, -0.25, 0.2,mapgeog, 1, 223);
movie2avi(M,'movie_alpha_7_14_cond5_4_fps','compression','none','quality',100,'fps',4);
M=mat2movie((squeeze(mean(spect_pixel_wise_cond5(8:12,:,:),1))).', 100, 100, -0.25, 0.2,mapgeog, 1, 223);
movie2avi(M,'movie_beta_16_24_cond5_4_fps','compression','none','quality',100,'fps',4);
M=mat2movie((squeeze(mean(spect_pixel_wise_cond5(13:20,:,:),1))).', 100, 100, -0.25, 0.2,mapgeog, 1, 223);
movie2avi(M,'movie_low_gamma_26_40_cond5_4_fps','compression','none','quality',100,'fps',4);
M=mat2movie((squeeze(mean(spect_pixel_wise_cond5(21:30,:,:),1))).', 100, 100, -0.25, 0.2,mapgeog, 1, 223);
movie2avi(M,'movie_42_60_cond5_4_fps','compression','none','quality',100,'fps',4);
M=mat2movie((squeeze(mean(spect_pixel_wise_cond5(31:45,:,:),1))).', 100, 100, -0.25, 0.2,mapgeog, 1, 223);
movie2avi(M,'movie_high_gamma_62_90_cond5_4_fps','compression','none','quality',100,'fps',4);
M=mat2movie((squeeze(mean(spect_pixel_wise_cond5(46:64,:,:),1))).', 100, 100, -0.25, 0.2,mapgeog, 1, 223);
movie2avi(M,'movie_90_125_cond5_4_fps','compression','none','quality',100,'fps',4);
clear all;
cd /fat2/Ariel_Gilad/Matlab_analysis/2008_01_23/cond_data
load spect_pixel_wise_cond6_res_64_bl8_hb.mat
M=mat2movie((squeeze(mean(spect_pixel_wise_cond6(1:3,:,:),1))).', 100, 100, -0.25, 0.2,mapgeog, 1, 223);
cd /fat2/Ariel_Gilad/Matlab_analysis/2008_01_23/movies
movie2avi(M,'movie_tetha_2_6_cond6_4_fps','compression','none','quality',100,'fps',4);
M=mat2movie((squeeze(mean(spect_pixel_wise_cond6(4:7,:,:),1))).', 100, 100, -0.25, 0.2,mapgeog, 1, 223);
movie2avi(M,'movie_alpha_7_14_cond6_4_fps','compression','none','quality',100,'fps',4);
M=mat2movie((squeeze(mean(spect_pixel_wise_cond6(8:12,:,:),1))).', 100, 100, -0.25, 0.2,mapgeog, 1, 223);
movie2avi(M,'movie_beta_16_24_cond6_4_fps','compression','none','quality',100,'fps',4);
M=mat2movie((squeeze(mean(spect_pixel_wise_cond6(13:20,:,:),1))).', 100, 100, -0.25, 0.2,mapgeog, 1, 223);
movie2avi(M,'movie_low_gamma_26_40_cond6_4_fps','compression','none','quality',100,'fps',4);
M=mat2movie((squeeze(mean(spect_pixel_wise_cond6(21:30,:,:),1))).', 100, 100, -0.25, 0.2,mapgeog, 1, 223);
movie2avi(M,'movie_42_60_cond6_4_fps','compression','none','quality',100,'fps',4);
M=mat2movie((squeeze(mean(spect_pixel_wise_cond6(31:45,:,:),1))).', 100, 100, -0.25, 0.2,mapgeog, 1, 223);
movie2avi(M,'movie_high_gamma_62_90_cond6_4_fps','compression','none','quality',100,'fps',4);
M=mat2movie((squeeze(mean(spect_pixel_wise_cond6(46:64,:,:),1))).', 100, 100, -0.25, 0.2,mapgeog, 1, 223);
movie2avi(M,'movie_90_125_cond6_4_fps','compression','none','quality',100,'fps',4);
clear all;


%%

cd /fat2/Ariel_Gilad/Matlab_analysis/2008_02_19/cond_data_a
load cond1n_dt_hb;
load cond2n_dt_hb;
cond1n_dt_hb=cond1n_dt_hb./repmat(mean(cond2n_dt_hb,3),[1 1 size(cond1n_dt_hb,3)]);
clear cond2n_dt_hb;
[spect_pixel_wise_cond1,baseline_ave_pixels,baseline_std_pixels]=spectogram_pixel_wise(cond1n_dt_hb);
clear cond1n_dt_hb;
spect_pixel_wise_cond1_time_1_239=spect_pixel_wise_cond1(:,1:239,:);
save spect_pixel_wise_cond1_res_64_bl8_hb_1_239_div_2 spect_pixel_wise_cond1_time_1_239
clear spect_pixel_wise_cond1_time_1_239
spect_pixel_wise_cond1_time_240_479=spect_pixel_wise_cond1(:,240:end,:);
save spect_pixel_wise_cond1_res_64_bl8_hb_240_479_div_2 spect_pixel_wise_cond1_time_240_479
clear all
load cond3n_dt_hb;
load cond4n_dt_hb;
cond3n_dt_hb=cond3n_dt_hb./repmat(mean(cond4n_dt_hb,3),[1 1 size(cond3n_dt_hb,3)]);
clear cond4n_dt_hb;
[spect_pixel_wise_cond3,baseline_ave_pixels,baseline_std_pixels]=spectogram_pixel_wise(cond3n_dt_hb);
clear cond3n_dt_hb;
spect_pixel_wise_cond3_time_1_239=spect_pixel_wise_cond3(:,1:239,:);
save spect_pixel_wise_cond3_res_64_bl8_hb_1_239_div_2 spect_pixel_wise_cond3_time_1_239
clear spect_pixel_wise_cond3_time_1_239
spect_pixel_wise_cond3_time_240_479=spect_pixel_wise_cond3(:,240:end,:);
save spect_pixel_wise_cond3_res_64_bl8_hb_240_479_div_2 spect_pixel_wise_cond3_time_240_479
clear all



cd /fat2/Ariel_Gilad/Matlab_analysis/2008_02_12/cond_data_b
load cond1n_dt_hb;
load cond2n_dt_hb;
cond1n_dt_hb=cond1n_dt_hb./repmat(mean(cond2n_dt_hb,3),[1 1 size(cond1n_dt_hb,3)]);
clear cond2n_dt_hb;
[spect_pixel_wise_cond1,baseline_ave_pixels,baseline_std_pixels]=spectogram_pixel_wise(cond1n_dt_hb);
clear cond1n_dt_hb;
spect_pixel_wise_cond1_time_1_239=spect_pixel_wise_cond1(:,1:239,:);
save spect_pixel_wise_cond1_res_64_bl8_hb_1_239_div_2 spect_pixel_wise_cond1_time_1_239
clear spect_pixel_wise_cond1_time_1_239
spect_pixel_wise_cond1_time_240_479=spect_pixel_wise_cond1(:,240:end,:);
save spect_pixel_wise_cond1_res_64_bl8_hb_240_479_div_2 spect_pixel_wise_cond1_time_240_479
clear all
load cond3n_dt_hb;
load cond4n_dt_hb;
cond3n_dt_hb=cond3n_dt_hb./repmat(mean(cond4n_dt_hb,3),[1 1 size(cond3n_dt_hb,3)]);
clear cond4n_dt_hb;
[spect_pixel_wise_cond3,baseline_ave_pixels,baseline_std_pixels]=spectogram_pixel_wise(cond3n_dt_hb);
clear cond3n_dt_hb;
spect_pixel_wise_cond3_time_1_239=spect_pixel_wise_cond3(:,1:239,:);
save spect_pixel_wise_cond3_res_64_bl8_hb_1_239_div_2 spect_pixel_wise_cond3_time_1_239
clear spect_pixel_wise_cond3_time_1_239
spect_pixel_wise_cond3_time_240_479=spect_pixel_wise_cond3(:,240:end,:);
save spect_pixel_wise_cond3_res_64_bl8_hb_240_479_div_2 spect_pixel_wise_cond3_time_240_479
clear all



%%
cd /fat2/Ariel_Gilad/Matlab_analysis/LED_test/2008_03_10/CrossNormalPattern4ms/conds
load cond1n_30t;
[spect_pixel_wise_cond1,baseline_ave_pixels,baseline_std_pixels]=spectogram_pixel_wise(cond1n_30t);
clear cond1n_30t;
spect_pixel_wise_cond1_time_1_239=spect_pixel_wise_cond1(:,1:239,:);
save spect_pixel_wise_cond1_res_64_bl8_bl_1_239_raw spect_pixel_wise_cond1_time_1_239
clear spect_pixel_wise_cond1_time_1_239
spect_pixel_wise_cond1_time_240_479=spect_pixel_wise_cond1(:,240:end,:);
save spect_pixel_wise_cond1_res_64_bl8_bl_240_479_raw spect_pixel_wise_cond1_time_240_479
clear all
load cond6n_30t;
[spect_pixel_wise_cond6,baseline_ave_pixels,baseline_std_pixels]=spectogram_pixel_wise(cond6n_30t);
clear cond6n_30t;
spect_pixel_wise_cond6_time_1_239=spect_pixel_wise_cond6(:,1:239,:);
save spect_pixel_wise_cond6_res_64_bl8_bl_1_239_raw spect_pixel_wise_cond6_time_1_239
clear spect_pixel_wise_cond6_time_1_239
spect_pixel_wise_cond6_time_240_479=spect_pixel_wise_cond6(:,240:end,:);
save spect_pixel_wise_cond6_res_64_bl8_bl_240_479_raw spect_pixel_wise_cond6_time_240_479
clear all

cd /fat2/Ariel_Gilad/Matlab_analysis/LED_test/2008_03_10/CrossNormalPattern45Degrees10ms/conds
load cond1n_dt_bl;
[spect_pixel_wise_cond1,baseline_ave_pixels,baseline_std_pixels]=spectogram_pixel_wise(cond1n_dt_bl);
clear cond1n_dt_bl;
spect_pixel_wise_cond1_time_1_239=spect_pixel_wise_cond1(:,1:239,:);
save spect_pixel_wise_cond1_res_64_bl8_bl_1_239 spect_pixel_wise_cond1_time_1_239
clear spect_pixel_wise_cond1_time_1_239
spect_pixel_wise_cond1_time_240_479=spect_pixel_wise_cond1(:,240:end,:);
save spect_pixel_wise_cond1_res_64_bl8_bl_240_479 spect_pixel_wise_cond1_time_240_479
clear all
load cond6n_dt_bl;
[spect_pixel_wise_cond6,baseline_ave_pixels,baseline_std_pixels]=spectogram_pixel_wise(cond6n_dt_bl);
clear cond6n_dt_bl;
spect_pixel_wise_cond6_time_1_239=spect_pixel_wise_cond6(:,1:239,:);
save spect_pixel_wise_cond6_res_64_bl8_bl_1_239 spect_pixel_wise_cond6_time_1_239
clear spect_pixel_wise_cond6_time_1_239
spect_pixel_wise_cond6_time_240_479=spect_pixel_wise_cond6(:,240:end,:);
save spect_pixel_wise_cond6_res_64_bl8_bl_240_479 spect_pixel_wise_cond6_time_240_479
clear all





