%% 1111c3
cd F:\Data\VSDI\Contour_integration\legolas\right_hemisphere\11_11_2008\c\elhanan_new\pixelwise
t=8;
load coeff_maskin_contour2_cond3
coeff_bg_circ_cond3=mean(coeff_maskin_contour2_cond3(:,:,t),3);
clear coeff_maskin_contour2_cond3
bl_bg_circ=coeff_bg_circ_cond3;
bl_bg_circ=reshape(bl_bg_circ,[size(bl_bg_circ,1)*size(bl_bg_circ,2) size(bl_bg_circ,3)]);


load coeff_contour2_cond3
coeff_circ_cond3=mean(coeff_contour2_cond3(:,:,t),3);
clear coeff_contour2_cond3
bl_circ_circ=coeff_circ_cond3;
bl_circ_circ=reshape(bl_circ_circ,[size(bl_circ_circ,1)*size(bl_circ_circ,2) size(bl_circ_circ,3)]);


load coeff_maskin_cond3
coeff_bg_cond3=mean(coeff_maskin_cond3(:,:,t),3);
clear coeff_maskin_cond3
bl_bg_bg=coeff_bg_cond3;
bl_bg_bg=reshape(bl_bg_bg,[size(bl_bg_bg,1)*size(bl_bg_bg,2) size(bl_bg_bg,3)]);


save corr_bg_circ_bl bl_bg_circ
save corr_circ_circ_bl bl_circ_circ
save corr_bg_bg_bl bl_bg_bg


%% 1111d3
clear all
cd F:\Data\VSDI\Contour_integration\legolas\right_hemisphere\11_11_2008\d\elhanan_new\pixelwise
t=8;
load coeff_maskin_contour2_cond3
coeff_bg_circ_cond3=mean(coeff_maskin_contour2_cond3(:,:,t),3);
clear coeff_maskin_contour2_cond3
bl_bg_circ=coeff_bg_circ_cond3;
bl_bg_circ=reshape(bl_bg_circ,[size(bl_bg_circ,1)*size(bl_bg_circ,2) size(bl_bg_circ,3)]);


load coeff_contour2_cond3
coeff_circ_cond3=mean(coeff_contour2_cond3(:,:,t),3);
clear coeff_contour2_cond3
bl_circ_circ=coeff_circ_cond3;
bl_circ_circ=reshape(bl_circ_circ,[size(bl_circ_circ,1)*size(bl_circ_circ,2) size(bl_circ_circ,3)]);


load coeff_maskin_cond3
coeff_bg_cond3=mean(coeff_maskin_cond3(:,:,t),3);
clear coeff_maskin_cond3
bl_bg_bg=coeff_bg_cond3;
bl_bg_bg=reshape(bl_bg_bg,[size(bl_bg_bg,1)*size(bl_bg_bg,2) size(bl_bg_bg,3)]);


save corr_bg_circ_bl bl_bg_circ
save corr_circ_circ_bl bl_circ_circ
save corr_bg_bg_bl bl_bg_bg


%% 1111h3
clear all
cd F:\Data\VSDI\Contour_integration\legolas\right_hemisphere\11_11_2008\h\pixelwise
t=8;
load coeff_maskin_contour_cond3
coeff_bg_circ_cond3=mean(coeff_maskin_contour_cond3(:,:,t),3);
clear coeff_maskin_contour_cond3
bl_bg_circ=coeff_bg_circ_cond3;
bl_bg_circ=reshape(bl_bg_circ,[size(bl_bg_circ,1)*size(bl_bg_circ,2) size(bl_bg_circ,3)]);


load coeff_contour_cond3
coeff_circ_cond3=mean(coeff_contour_cond3(:,:,t),3);
clear coeff_contour_cond3
bl_circ_circ=coeff_circ_cond3;
bl_circ_circ=reshape(bl_circ_circ,[size(bl_circ_circ,1)*size(bl_circ_circ,2) size(bl_circ_circ,3)]);


load coeff_maskin_cond3
coeff_bg_cond3=mean(coeff_maskin_cond3(:,:,t),3);
clear coeff_maskin_cond3
bl_bg_bg=coeff_bg_cond3;
bl_bg_bg=reshape(bl_bg_bg,[size(bl_bg_bg,1)*size(bl_bg_bg,2) size(bl_bg_bg,3)]);


save corr_bg_circ_bl bl_bg_circ
save corr_circ_circ_bl bl_circ_circ
save corr_bg_bg_bl bl_bg_bg



%% 2511d3
clear all
cd F:\Data\VSDI\Contour_integration\legolas\right_hemisphere\psychophysics\2008_11_25\d\correct_and_incorrect_together\pixelwise
t=6:9;
load coeff_bg_in_circle_diff_cond3
coeff_bg_circ_cond3=mean(coeff_bg_in_circle_diff_cond3(:,:,t),3);
clear coeff_bg_in_circle_diff_cond3
bl_bg_circ=coeff_bg_circ_cond3;
bl_bg_circ=reshape(bl_bg_circ,[size(bl_bg_circ,1)*size(bl_bg_circ,2) size(bl_bg_circ,3)]);


load coeff_contour_cond3
coeff_circ_cond3=mean(coeff_contour_cond3(:,:,t),3);
clear coeff_contour_cond3
bl_circ_circ=coeff_circ_cond3;
bl_circ_circ=reshape(bl_circ_circ,[size(bl_circ_circ,1)*size(bl_circ_circ,2) size(bl_circ_circ,3)]);


load coeff_bg_in_cond3
coeff_bg_cond3=mean(coeff_bg_in_cond3(:,:,t),3);
clear coeff_bg_in_cond3
bl_bg_bg=coeff_bg_cond3;
bl_bg_bg=reshape(bl_bg_bg,[size(bl_bg_bg,1)*size(bl_bg_bg,2) size(bl_bg_bg,3)]);


save corr_bg_circ_bl bl_bg_circ
save corr_circ_circ_bl bl_circ_circ
save corr_bg_bg_bl bl_bg_bg


%% 2511e3
clear all
cd F:\Data\VSDI\Contour_integration\legolas\right_hemisphere\psychophysics\2008_11_25\e\correct_and_incorrect_together\pixelwise
t=6:9;
load coeff_bg_in_circle_diff_cond3
coeff_bg_circ_cond3=mean(coeff_bg_in_circle_diff_cond3(:,:,t),3);
clear coeff_bg_in_circle_diff_cond3
bl_bg_circ=coeff_bg_circ_cond3;
bl_bg_circ=reshape(bl_bg_circ,[size(bl_bg_circ,1)*size(bl_bg_circ,2) size(bl_bg_circ,3)]);


load coeff_contour_cond3
coeff_circ_cond3=mean(coeff_contour_cond3(:,:,t),3);
clear coeff_contour_cond3
bl_circ_circ=coeff_circ_cond3;
bl_circ_circ=reshape(bl_circ_circ,[size(bl_circ_circ,1)*size(bl_circ_circ,2) size(bl_circ_circ,3)]);


load coeff_bg_in_cond3
coeff_bg_cond3=mean(coeff_bg_in_cond3(:,:,t),3);
clear coeff_bg_in_cond3
bl_bg_bg=coeff_bg_cond3;
bl_bg_bg=reshape(bl_bg_bg,[size(bl_bg_bg,1)*size(bl_bg_bg,2) size(bl_bg_bg,3)]);


save corr_bg_circ_bl bl_bg_circ
save corr_circ_circ_bl bl_circ_circ
save corr_bg_bg_bl bl_bg_bg


%% 2511f3
clear all
cd F:\Data\VSDI\Contour_integration\legolas\right_hemisphere\psychophysics\2008_11_25\f\correct_and_incorrect_together\pixelwise
t=6:9;
load coeff_bg_in_circle_diff_cond3
coeff_bg_circ_cond3=mean(coeff_bg_in_circle_diff_cond3(:,:,t),3);
clear coeff_bg_in_circle_diff_cond3
bl_bg_circ=coeff_bg_circ_cond3;
bl_bg_circ=reshape(bl_bg_circ,[size(bl_bg_circ,1)*size(bl_bg_circ,2) size(bl_bg_circ,3)]);


load coeff_contour_cond3
coeff_circ_cond3=mean(coeff_contour_cond3(:,:,t),3);
clear coeff_contour_cond3
bl_circ_circ=coeff_circ_cond3;
bl_circ_circ=reshape(bl_circ_circ,[size(bl_circ_circ,1)*size(bl_circ_circ,2) size(bl_circ_circ,3)]);


load coeff_bg_in_cond3
coeff_bg_cond3=mean(coeff_bg_in_cond3(:,:,t),3);
clear coeff_bg_in_cond3
bl_bg_bg=coeff_bg_cond3;
bl_bg_bg=reshape(bl_bg_bg,[size(bl_bg_bg,1)*size(bl_bg_bg,2) size(bl_bg_bg,3)]);


save corr_bg_circ_bl bl_bg_circ
save corr_circ_circ_bl bl_circ_circ
save corr_bg_bg_bl bl_bg_bg


%% 1811c3
clear all
cd F:\Data\VSDI\Contour_integration\legolas\right_hemisphere\psychophysics\2008_11_18\c\correct_and_incorrect_together\pixelwise
t=6:9;
load coeff_bg_in_circle_diff_cond3
coeff_bg_circ_cond3=mean(coeff_bg_in_circle_diff_cond3(:,:,t),3);
clear coeff_bg_in_circle_diff_cond3
bl_bg_circ=coeff_bg_circ_cond3;
bl_bg_circ=reshape(bl_bg_circ,[size(bl_bg_circ,1)*size(bl_bg_circ,2) size(bl_bg_circ,3)]);


load coeff_contour_cond3
coeff_circ_cond3=mean(coeff_contour_cond3(:,:,t),3);
clear coeff_contour_cond3
bl_circ_circ=coeff_circ_cond3;
bl_circ_circ=reshape(bl_circ_circ,[size(bl_circ_circ,1)*size(bl_circ_circ,2) size(bl_circ_circ,3)]);


load coeff_bg_in_cond3
coeff_bg_cond3=mean(coeff_bg_in_cond3(:,:,t),3);
clear coeff_bg_in_cond3
bl_bg_bg=coeff_bg_cond3;
bl_bg_bg=reshape(bl_bg_bg,[size(bl_bg_bg,1)*size(bl_bg_bg,2) size(bl_bg_bg,3)]);


save corr_bg_circ_bl bl_bg_circ
save corr_circ_circ_bl bl_circ_circ
save corr_bg_bg_bl bl_bg_bg


%% 1811d3
clear all
cd F:\Data\VSDI\Contour_integration\legolas\right_hemisphere\psychophysics\2008_11_18\d\correct_and_incorrect_together\pixelwise
t=6:9;
load coeff_bg_in_circle_diff_cond3
coeff_bg_circ_cond3=mean(coeff_bg_in_circle_diff_cond3(:,:,t),3);
clear coeff_bg_in_circle_diff_cond3
bl_bg_circ=coeff_bg_circ_cond3;
bl_bg_circ=reshape(bl_bg_circ,[size(bl_bg_circ,1)*size(bl_bg_circ,2) size(bl_bg_circ,3)]);


load coeff_contour_cond3
coeff_circ_cond3=mean(coeff_contour_cond3(:,:,t),3);
clear coeff_contour_cond3
bl_circ_circ=coeff_circ_cond3;
bl_circ_circ=reshape(bl_circ_circ,[size(bl_circ_circ,1)*size(bl_circ_circ,2) size(bl_circ_circ,3)]);


load coeff_bg_in_cond3
coeff_bg_cond3=mean(coeff_bg_in_cond3(:,:,t),3);
clear coeff_bg_in_cond3
bl_bg_bg=coeff_bg_cond3;
bl_bg_bg=reshape(bl_bg_bg,[size(bl_bg_bg,1)*size(bl_bg_bg,2) size(bl_bg_bg,3)]);


save corr_bg_circ_bl bl_bg_circ
save corr_circ_circ_bl bl_circ_circ
save corr_bg_bg_bl bl_bg_bg

%% 1811e3
clear all
cd F:\Data\VSDI\Contour_integration\legolas\right_hemisphere\psychophysics\2008_11_18\e\correct_and_incorrect_together\pixelwise
t=6:9;
load coeff_bg_in_circle_diff_cond3
coeff_bg_circ_cond3=mean(coeff_bg_in_circle_diff_cond3(:,:,t),3);
clear coeff_bg_in_circle_diff_cond3
bl_bg_circ=coeff_bg_circ_cond3;
bl_bg_circ=reshape(bl_bg_circ,[size(bl_bg_circ,1)*size(bl_bg_circ,2) size(bl_bg_circ,3)]);


load coeff_contour_cond3
coeff_circ_cond3=mean(coeff_contour_cond3(:,:,t),3);
clear coeff_contour_cond3
bl_circ_circ=coeff_circ_cond3;
bl_circ_circ=reshape(bl_circ_circ,[size(bl_circ_circ,1)*size(bl_circ_circ,2) size(bl_circ_circ,3)]);


load coeff_bg_in_cond3
coeff_bg_cond3=mean(coeff_bg_in_cond3(:,:,t),3);
clear coeff_bg_in_cond3
bl_bg_bg=coeff_bg_cond3;
bl_bg_bg=reshape(bl_bg_bg,[size(bl_bg_bg,1)*size(bl_bg_bg,2) size(bl_bg_bg,3)]);


save corr_bg_circ_bl bl_bg_circ
save corr_circ_circ_bl bl_circ_circ
save corr_bg_bg_bl bl_bg_bg

%% 1203d3
clear all
cd F:\Data\VSDI\Contour_integration\legolas\right_hemisphere\psychophysics\2008_12_03\d\correct_and_incorrect_together\pixelwise
t=6:9;
load coeff_bg_in_circle_diff_cond3
coeff_bg_circ_cond3=mean(coeff_bg_in_circle_diff_cond3(:,:,t),3);
clear coeff_bg_in_circle_diff_cond3
bl_bg_circ=coeff_bg_circ_cond3;
bl_bg_circ=reshape(bl_bg_circ,[size(bl_bg_circ,1)*size(bl_bg_circ,2) size(bl_bg_circ,3)]);


load coeff_contour_cond3
coeff_circ_cond3=mean(coeff_contour_cond3(:,:,t),3);
clear coeff_contour_cond3
bl_circ_circ=coeff_circ_cond3;
bl_circ_circ=reshape(bl_circ_circ,[size(bl_circ_circ,1)*size(bl_circ_circ,2) size(bl_circ_circ,3)]);


load coeff_bg_in_cond3
coeff_bg_cond3=mean(coeff_bg_in_cond3(:,:,t),3);
clear coeff_bg_in_cond3
bl_bg_bg=coeff_bg_cond3;
bl_bg_bg=reshape(bl_bg_bg,[size(bl_bg_bg,1)*size(bl_bg_bg,2) size(bl_bg_bg,3)]);


save corr_bg_circ_bl bl_bg_circ
save corr_circ_circ_bl bl_circ_circ
save corr_bg_bg_bl bl_bg_bg


%% 1203e3
clear all
cd F:\Data\VSDI\Contour_integration\legolas\right_hemisphere\psychophysics\2008_12_03\e\correct_and_incorrect_together\pixelwise
t=6:9;
load coeff_bg_in_circle_diff_cond3
coeff_bg_circ_cond3=mean(coeff_bg_in_circle_diff_cond3(:,:,t),3);
clear coeff_bg_in_circle_diff_cond3
bl_bg_circ=coeff_bg_circ_cond3;
bl_bg_circ=reshape(bl_bg_circ,[size(bl_bg_circ,1)*size(bl_bg_circ,2) size(bl_bg_circ,3)]);


load coeff_contour_cond3
coeff_circ_cond3=mean(coeff_contour_cond3(:,:,t),3);
clear coeff_contour_cond3
bl_circ_circ=coeff_circ_cond3;
bl_circ_circ=reshape(bl_circ_circ,[size(bl_circ_circ,1)*size(bl_circ_circ,2) size(bl_circ_circ,3)]);


load coeff_bg_in_cond3
coeff_bg_cond3=mean(coeff_bg_in_cond3(:,:,t),3);
clear coeff_bg_in_cond3
bl_bg_bg=coeff_bg_cond3;
bl_bg_bg=reshape(bl_bg_bg,[size(bl_bg_bg,1)*size(bl_bg_bg,2) size(bl_bg_bg,3)]);


save corr_bg_circ_bl bl_bg_circ
save corr_circ_circ_bl bl_circ_circ
save corr_bg_bg_bl bl_bg_bg


%% 1203f3
clear all
cd F:\Data\VSDI\Contour_integration\legolas\right_hemisphere\psychophysics\2008_12_03\f\correct_and_incorrect_together\pixelwise
t=6:9;
load coeff_bg_in_circle_diff_cond3
coeff_bg_circ_cond3=mean(coeff_bg_in_circle_diff_cond3(:,:,t),3);
clear coeff_bg_in_circle_diff_cond3
bl_bg_circ=coeff_bg_circ_cond3;
bl_bg_circ=reshape(bl_bg_circ,[size(bl_bg_circ,1)*size(bl_bg_circ,2) size(bl_bg_circ,3)]);


load coeff_contour_cond3
coeff_circ_cond3=mean(coeff_contour_cond3(:,:,t),3);
clear coeff_contour_cond3
bl_circ_circ=coeff_circ_cond3;
bl_circ_circ=reshape(bl_circ_circ,[size(bl_circ_circ,1)*size(bl_circ_circ,2) size(bl_circ_circ,3)]);


load coeff_bg_in_cond3
coeff_bg_cond3=mean(coeff_bg_in_cond3(:,:,t),3);
clear coeff_bg_in_cond3
bl_bg_bg=coeff_bg_cond3;
bl_bg_bg=reshape(bl_bg_bg,[size(bl_bg_bg,1)*size(bl_bg_bg,2) size(bl_bg_bg,3)]);


save corr_bg_circ_bl bl_bg_circ
save corr_circ_circ_bl bl_circ_circ
save corr_bg_bg_bl bl_bg_bg


%% 1203d3
clear all
cd F:\Data\VSDI\Contour_integration\legolas\right_hemisphere\psychophysics\2008_12_03\d\correct_and_incorrect_together\pixelwise
t=6:9;
load coeff_bg_in_circle_diff_cond3
coeff_bg_circ_cond3=mean(coeff_bg_in_circle_diff_cond3(:,:,t),3);
clear coeff_bg_in_circle_diff_cond3
bl_bg_circ=coeff_bg_circ_cond3;
bl_bg_circ=reshape(bl_bg_circ,[size(bl_bg_circ,1)*size(bl_bg_circ,2) size(bl_bg_circ,3)]);


load coeff_contour_cond3
coeff_circ_cond3=mean(coeff_contour_cond3(:,:,t),3);
clear coeff_contour_cond3
bl_circ_circ=coeff_circ_cond3;
bl_circ_circ=reshape(bl_circ_circ,[size(bl_circ_circ,1)*size(bl_circ_circ,2) size(bl_circ_circ,3)]);


load coeff_bg_in_cond3
coeff_bg_cond3=mean(coeff_bg_in_cond3(:,:,t),3);
clear coeff_bg_in_cond3
bl_bg_bg=coeff_bg_cond3;
bl_bg_bg=reshape(bl_bg_bg,[size(bl_bg_bg,1)*size(bl_bg_bg,2) size(bl_bg_bg,3)]);


save corr_bg_circ_bl bl_bg_circ
save corr_circ_circ_bl bl_circ_circ
save corr_bg_bg_bl bl_bg_bg



%% 0610e3
clear all
cd F:\Data\VSDI\Contour_integration\legolas\right_hemisphere\06_10_2008\e\pixelwise
t=6:9;
load coeff_bg_in_circle_diff_cond3
coeff_bg_circ_cond3=mean(coeff_bg_in_circle_diff_cond3(:,:,t),3);
clear coeff_bg_in_circle_diff_cond3
bl_bg_circ=coeff_bg_circ_cond3;
bl_bg_circ=reshape(bl_bg_circ,[size(bl_bg_circ,1)*size(bl_bg_circ,2) size(bl_bg_circ,3)]);


load coeff_contour_cond3
coeff_circ_cond3=mean(coeff_contour_cond3(:,:,t),3);
clear coeff_contour_cond3
bl_circ_circ=coeff_circ_cond3;
bl_circ_circ=reshape(bl_circ_circ,[size(bl_circ_circ,1)*size(bl_circ_circ,2) size(bl_circ_circ,3)]);


load coeff_bg_in_cond3
coeff_bg_cond3=mean(coeff_bg_in_cond3(:,:,t),3);
clear coeff_bg_in_cond3
bl_bg_bg=coeff_bg_cond3;
bl_bg_bg=reshape(bl_bg_bg,[size(bl_bg_bg,1)*size(bl_bg_bg,2) size(bl_bg_bg,3)]);


save corr_bg_circ_bl bl_bg_circ
save corr_circ_circ_bl bl_circ_circ
save corr_bg_bg_bl bl_bg_bg



%% 0610f3
clear all
cd F:\Data\VSDI\Contour_integration\legolas\right_hemisphere\06_10_2008\f\pixelwise
t=6:9;
load coeff_bg_in_circle_diff_cond3
coeff_bg_circ_cond3=mean(coeff_bg_in_circle_diff_cond3(:,:,t),3);
clear coeff_bg_in_circle_diff_cond3
bl_bg_circ=coeff_bg_circ_cond3;
bl_bg_circ=reshape(bl_bg_circ,[size(bl_bg_circ,1)*size(bl_bg_circ,2) size(bl_bg_circ,3)]);


load coeff_contour_cond3
coeff_circ_cond3=mean(coeff_contour_cond3(:,:,t),3);
clear coeff_contour_cond3
bl_circ_circ=coeff_circ_cond3;
bl_circ_circ=reshape(bl_circ_circ,[size(bl_circ_circ,1)*size(bl_circ_circ,2) size(bl_circ_circ,3)]);


load coeff_bg_in_cond3
coeff_bg_cond3=mean(coeff_bg_in_cond3(:,:,t),3);
clear coeff_bg_in_cond3
bl_bg_bg=coeff_bg_cond3;
bl_bg_bg=reshape(bl_bg_bg,[size(bl_bg_bg,1)*size(bl_bg_bg,2) size(bl_bg_bg,3)]);


save corr_bg_circ_bl bl_bg_circ
save corr_circ_circ_bl bl_circ_circ
save corr_bg_bg_bl bl_bg_bg

%% 2210e3
clear all
cd F:\Data\VSDI\Contour_integration\legolas\right_hemisphere\22_10_2008\d\pixelwise
t=6:9;
load coeff_bg_in_circle_diff_cond3
coeff_bg_circ_cond3=mean(coeff_bg_in_circle_diff_cond3(:,:,t),3);
clear coeff_bg_in_circle_diff_cond3
bl_bg_circ=coeff_bg_circ_cond3;
bl_bg_circ=reshape(bl_bg_circ,[size(bl_bg_circ,1)*size(bl_bg_circ,2) size(bl_bg_circ,3)]);


load coeff_contour_cond3
coeff_circ_cond3=mean(coeff_contour_cond3(:,:,t),3);
clear coeff_contour_cond3
bl_circ_circ=coeff_circ_cond3;
bl_circ_circ=reshape(bl_circ_circ,[size(bl_circ_circ,1)*size(bl_circ_circ,2) size(bl_circ_circ,3)]);


load coeff_bg_in_cond3
coeff_bg_cond3=mean(coeff_bg_in_cond3(:,:,t),3);
clear coeff_bg_in_cond3
bl_bg_bg=coeff_bg_cond3;
bl_bg_bg=reshape(bl_bg_bg,[size(bl_bg_bg,1)*size(bl_bg_bg,2) size(bl_bg_bg,3)]);


save corr_bg_circ_bl bl_bg_circ
save corr_circ_circ_bl bl_circ_circ
save corr_bg_bg_bl bl_bg_bg

%% 2210e3
clear all
cd F:\Data\VSDI\Contour_integration\legolas\right_hemisphere\22_10_2008\e\pixelwise
t=6:9;
load coeff_bg_in_circle_diff_cond3
coeff_bg_circ_cond3=mean(coeff_bg_in_circle_diff_cond3(:,:,t),3);
clear coeff_bg_in_circle_diff_cond3
bl_bg_circ=coeff_bg_circ_cond3;
bl_bg_circ=reshape(bl_bg_circ,[size(bl_bg_circ,1)*size(bl_bg_circ,2) size(bl_bg_circ,3)]);


load coeff_contour_cond3
coeff_circ_cond3=mean(coeff_contour_cond3(:,:,t),3);
clear coeff_contour_cond3
bl_circ_circ=coeff_circ_cond3;
bl_circ_circ=reshape(bl_circ_circ,[size(bl_circ_circ,1)*size(bl_circ_circ,2) size(bl_circ_circ,3)]);


load coeff_bg_in_cond3
coeff_bg_cond3=mean(coeff_bg_in_cond3(:,:,t),3);
clear coeff_bg_in_cond3
bl_bg_bg=coeff_bg_cond3;
bl_bg_bg=reshape(bl_bg_bg,[size(bl_bg_bg,1)*size(bl_bg_bg,2) size(bl_bg_bg,3)]);


save corr_bg_circ_bl bl_bg_circ
save corr_circ_circ_bl bl_circ_circ
save corr_bg_bg_bl bl_bg_bg

