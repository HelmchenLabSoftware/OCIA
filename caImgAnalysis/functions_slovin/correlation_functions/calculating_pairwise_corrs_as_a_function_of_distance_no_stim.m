
%% 1111c1245 contour2
cd F:\Data\VSDI\Contour_integration\legolas\right_hemisphere\11_11_2008\c\elhanan_new\no_stim\pixelwise
t=8;
load coeff_maskin_contour2_cond1
coeff_bg_circ_cond1c=mean(coeff_maskin_contour2_cond1(:,:,t),3);
clear coeff_maskin_contour2_cond1
load coeff_maskin_contour2_cond2
coeff_bg_circ_cond2c=mean(coeff_maskin_contour2_cond2(:,:,t),3);
clear coeff_maskin_contour2_cond2
load coeff_maskin_contour2_cond4
coeff_bg_circ_cond4c=mean(coeff_maskin_contour2_cond4(:,:,t),3);
clear coeff_maskin_contour2_cond4
load coeff_maskin_contour2_cond5
coeff_bg_circ_cond5c=mean(coeff_maskin_contour2_cond5(:,:,t),3);
clear coeff_maskin_contour2_cond5

cd F:\Data\VSDI\Contour_integration\legolas\right_hemisphere\11_11_2008\d\elhanan_new\no_stim\pixelwise
t=8;
load coeff_maskin_contour2_cond1
coeff_bg_circ_cond1d=mean(coeff_maskin_contour2_cond1(:,:,t),3);
clear coeff_maskin_contour2_cond1
load coeff_maskin_contour2_cond2
coeff_bg_circ_cond2d=mean(coeff_maskin_contour2_cond2(:,:,t),3);
clear coeff_maskin_contour2_cond2
load coeff_maskin_contour2_cond4
coeff_bg_circ_cond4d=mean(coeff_maskin_contour2_cond4(:,:,t),3);
clear coeff_maskin_contour2_cond4
load coeff_maskin_contour2_cond5
coeff_bg_circ_cond5d=mean(coeff_maskin_contour2_cond5(:,:,t),3);
clear coeff_maskin_contour2_cond5

cont_bg_circ=cat(3,coeff_bg_circ_cond1c,coeff_bg_circ_cond2c,coeff_bg_circ_cond1d,coeff_bg_circ_cond2d);
non_bg_circ=cat(3,coeff_bg_circ_cond4c,coeff_bg_circ_cond5c,coeff_bg_circ_cond4d,coeff_bg_circ_cond5d);
cont_bg_circ=reshape(cont_bg_circ,[size(cont_bg_circ,1)*size(cont_bg_circ,2) size(cont_bg_circ,3)]);
non_bg_circ=reshape(non_bg_circ,[size(non_bg_circ,1)*size(non_bg_circ,2) size(non_bg_circ,3)]);

[n1 x1]=hist(mean(cont_bg_circ-non_bg_circ,2),-0.2:0.01:0.2);
figure;bar(x1,n1/size(cont_bg_circ,1)')
ranksum(mean(cont_bg_circ,2),mean(non_bg_circ,2))
mean(mean(cont_bg_circ-non_bg_circ,2))
signrank(mean(cont_bg_circ-non_bg_circ,2))
signrank(n1)





cd F:\Data\VSDI\Contour_integration\legolas\right_hemisphere\11_11_2008\c\elhanan_new\no_stim\pixelwise
t=8;
load coeff_contour2_cond1
coeff_circ_cond1c=mean(coeff_contour2_cond1(:,:,t),3);
clear coeff_contour2_cond1
load coeff_contour2_cond2
coeff_circ_cond2c=mean(coeff_contour2_cond2(:,:,t),3);
clear coeff_contour2_cond2
load coeff_contour2_cond4
coeff_circ_cond4c=mean(coeff_contour2_cond4(:,:,t),3);
clear coeff_contour2_cond4
load coeff_contour2_cond5
coeff_circ_cond5c=mean(coeff_contour2_cond5(:,:,t),3);
clear coeff_contour2_cond5

cd F:\Data\VSDI\Contour_integration\legolas\right_hemisphere\11_11_2008\d\elhanan_new\no_stim\pixelwise
t=8;
load coeff_contour2_cond1
coeff_circ_cond1d=mean(coeff_contour2_cond1(:,:,t),3);
clear coeff_contour2_cond1
load coeff_contour2_cond2
coeff_circ_cond2d=mean(coeff_contour2_cond2(:,:,t),3);
clear coeff_contour2_cond2
load coeff_contour2_cond4
coeff_circ_cond4d=mean(coeff_contour2_cond4(:,:,t),3);
clear coeff_contour2_cond4
load coeff_contour2_cond5
coeff_circ_cond5d=mean(coeff_contour2_cond5(:,:,t),3);
clear coeff_contour2_cond5

cont_circ_circ=cat(3,coeff_circ_cond1c,coeff_circ_cond2c,coeff_circ_cond1d,coeff_circ_cond2d);
non_circ_circ=cat(3,coeff_circ_cond4c,coeff_circ_cond5c,coeff_circ_cond4d,coeff_circ_cond5d);
cont_circ_circ=reshape(cont_circ_circ,[size(cont_circ_circ,1)*size(cont_circ_circ,2) size(cont_circ_circ,3)]);
non_circ_circ=reshape(non_circ_circ,[size(non_circ_circ,1)*size(non_circ_circ,2) size(non_circ_circ,3)]);

[n1 x1]=hist(mean(cont_circ_circ-non_circ_circ,2),-0.2:0.01:0.2);
figure;bar(x1,n1/size(cont_circ_circ,1)')
ranksum(mean(cont_circ_circ,2),mean(non_circ_circ,2))
mean(mean(cont_circ_circ-non_circ_circ,2))
signrank(mean(cont_circ_circ-non_circ_circ,2))
signrank(n1)


cd F:\Data\VSDI\Contour_integration\legolas\right_hemisphere\11_11_2008\c\elhanan_new\no_stim\pixelwise
t=8;
load coeff_maskin_cond1
coeff_bg_cond1c=mean(coeff_maskin_cond1(:,:,t),3);
clear coeff_maskin_cond1
load coeff_maskin_cond2
coeff_bg_cond2c=mean(coeff_maskin_cond2(:,:,t),3);
clear coeff_maskin_cond2
load coeff_maskin_cond4
coeff_bg_cond4c=mean(coeff_maskin_cond4(:,:,t),3);
clear coeff_maskin_cond4
load coeff_maskin_cond5
coeff_bg_cond5c=mean(coeff_maskin_cond5(:,:,t),3);
clear coeff_maskin_cond5

cd F:\Data\VSDI\Contour_integration\legolas\right_hemisphere\11_11_2008\d\elhanan_new\no_stim\pixelwise
t=8;
load coeff_maskin_cond1
coeff_bg_cond1d=mean(coeff_maskin_cond1(:,:,t),3);
clear coeff_maskin_cond1
load coeff_maskin_cond2
coeff_bg_cond2d=mean(coeff_maskin_cond2(:,:,t),3);
clear coeff_maskin_cond2
load coeff_maskin_cond4
coeff_bg_cond4d=mean(coeff_maskin_cond4(:,:,t),3);
clear coeff_maskin_cond4
load coeff_maskin_cond5
coeff_bg_cond5d=mean(coeff_maskin_cond5(:,:,t),3);
clear coeff_maskin_cond5

cont_bg_bg=cat(3,coeff_bg_cond1c,coeff_bg_cond2c,coeff_bg_cond1d,coeff_bg_cond2d);
non_bg_bg=cat(3,coeff_bg_cond4c,coeff_bg_cond5c,coeff_bg_cond4d,coeff_bg_cond5d);
cont_bg_bg=reshape(cont_bg_bg,[size(cont_bg_bg,1)*size(cont_bg_bg,2) size(cont_bg_bg,3)]);
non_bg_bg=reshape(non_bg_bg,[size(non_bg_bg,1)*size(non_bg_bg,2) size(non_bg_bg,3)]);

[n1 x1]=hist(mean(cont_bg_bg-non_bg_bg,2),-0.2:0.01:0.2);
figure;bar(x1,n1/size(cont_bg_bg,1)')
ranksum(mean(cont_bg_bg,2),mean(non_bg_bg,2))
mean(mean(cont_bg_bg-non_bg_bg,2))
signrank(mean(cont_bg_bg-non_bg_bg,2))
signrank(n1)


save corr_bg_circ_1111cd cont_bg_circ non_bg_circ
save corr_circ_circ_1111cd cont_circ_circ non_circ_circ
save corr_bg_bg_1111cd cont_bg_bg non_bg_bg


%% 1111h

cd F:\Data\VSDI\Contour_integration\legolas\right_hemisphere\11_11_2008\h\no_stim\pixelwise
t=6:9;
load coeff_maskin_contour_cond1
coeff_bg_circ_cond1=mean(coeff_maskin_contour_cond1(:,:,t),3);
clear coeff_maskin_contour_cond1
load coeff_maskin_contour_cond2
coeff_bg_circ_cond2=mean(coeff_maskin_contour_cond2(:,:,t),3);
clear coeff_maskin_contour_cond2
load coeff_maskin_contour_cond4
coeff_bg_circ_cond4=mean(coeff_maskin_contour_cond4(:,:,t),3);
clear coeff_maskin_contour_cond4
load coeff_maskin_contour_cond5
coeff_bg_circ_cond5=mean(coeff_maskin_contour_cond5(:,:,t),3);
clear coeff_maskin_contour_cond5
cont_bg_circ=cat(3,coeff_bg_circ_cond1,coeff_bg_circ_cond2);
non_bg_circ=cat(3,coeff_bg_circ_cond4,coeff_bg_circ_cond5);
cont_bg_circ=reshape(cont_bg_circ,[size(cont_bg_circ,1)*size(cont_bg_circ,2) size(cont_bg_circ,3)]);
non_bg_circ=reshape(non_bg_circ,[size(non_bg_circ,1)*size(non_bg_circ,2) size(non_bg_circ,3)]);
[n1 x1]=hist(mean(cont_bg_circ-non_bg_circ,2),-0.2:0.01:0.2);
figure;bar(x1,n1/size(cont_bg_circ,1)')
ranksum(mean(cont_bg_circ,2),mean(non_bg_circ,2))
mean(mean(cont_bg_circ-non_bg_circ,2))
signrank(mean(cont_bg_circ-non_bg_circ,2))
signrank(n1)



load coeff_contour_cond1
coeff_circ_circ_cond1=mean(coeff_contour_cond1(:,:,t),3);
clear coeff_contour_cond1
load coeff_contour_cond2
coeff_circ_circ_cond2=mean(coeff_contour_cond2(:,:,t),3);
clear coeff_contour_cond2
load coeff_contour_cond4
coeff_circ_circ_cond4=mean(coeff_contour_cond4(:,:,t),3);
clear coeff_contour_cond4
load coeff_contour_cond5
coeff_circ_circ_cond5=mean(coeff_contour_cond5(:,:,t),3);
clear coeff_contour_cond5
cont_circ_circ=cat(3,coeff_circ_circ_cond1,coeff_circ_circ_cond2);
non_circ_circ=cat(3,coeff_circ_circ_cond4,coeff_circ_circ_cond5);
cont_circ_circ=reshape(cont_circ_circ,[size(cont_circ_circ,1)*size(cont_circ_circ,2) size(cont_circ_circ,3)]);
non_circ_circ=reshape(non_circ_circ,[size(non_circ_circ,1)*size(non_circ_circ,2) size(non_circ_circ,3)]);
[n1 x1]=hist(mean(cont_circ_circ-non_circ_circ,2),-0.2:0.01:0.2);
figure;bar(x1,n1/size(cont_circ_circ,1)')
ranksum(mean(cont_circ_circ,2),mean(non_circ_circ,2))
mean(mean(cont_circ_circ-non_circ_circ,2))
signrank(mean(cont_circ_circ-non_circ_circ,2))
signrank(n1)



load coeff_maskin_cond1
coeff_bg_bg_cond1=mean(coeff_maskin_cond1(:,:,t),3);
clear coeff_maskin_cond1
load coeff_maskin_cond2
coeff_bg_bg_cond2=mean(coeff_maskin_cond2(:,:,t),3);
clear coeff_maskin_cond2
load coeff_maskin_cond4
coeff_bg_bg_cond4=mean(coeff_maskin_cond4(:,:,t),3);
clear coeff_maskin_cond4
load coeff_maskin_cond5
coeff_bg_bg_cond5=mean(coeff_maskin_cond5(:,:,t),3);
clear coeff_maskin_cond5
cont_bg_bg=cat(3,coeff_bg_bg_cond1,coeff_bg_bg_cond2);
non_bg_bg=cat(3,coeff_bg_bg_cond4,coeff_bg_bg_cond5);
cont_bg_bg=reshape(cont_bg_bg,[size(cont_bg_bg,1)*size(cont_bg_bg,2) size(cont_bg_bg,3)]);
non_bg_bg=reshape(non_bg_bg,[size(non_bg_bg,1)*size(non_bg_bg,2) size(non_bg_bg,3)]);
[n1 x1]=hist(mean(cont_bg_bg-non_bg_bg,2),-0.2:0.01:0.2);
figure;bar(x1,n1/size(cont_bg_bg,1)')
ranksum(mean(cont_bg_bg,2),mean(non_bg_bg,2))
mean(mean(cont_bg_bg-non_bg_bg,2))
signrank(mean(cont_bg_bg-non_bg_bg,2))
signrank(n1)


save corr_bg_circ cont_bg_circ non_bg_circ
save corr_circ_circ cont_circ_circ non_circ_circ
save corr_bg_bg cont_bg_bg non_bg_bg



%% 2511d

cd F:\Data\VSDI\Contour_integration\legolas\right_hemisphere\psychophysics\2008_11_25\d\correct_and_incorrect_together\no_stim\pixelwise
t=2:7;
lim=-0.4:0.025:0.4;
load coeff_bg_in_circle_diff_cond1
coeff_bg_circ_cond1=mean(coeff_bg_in_circle_diff_cond1(:,:,t),3);
clear coeff_bg_in_circle_diff_cond1
load coeff_bg_in_circle_diff_cond5
coeff_bg_circ_cond5=mean(coeff_bg_in_circle_diff_cond5(:,:,t),3);
clear coeff_bg_in_circle_diff_cond5
cont_bg_circ=coeff_bg_circ_cond1;
non_bg_circ=coeff_bg_circ_cond5;
cont_bg_circ=reshape(cont_bg_circ,[size(cont_bg_circ,1)*size(cont_bg_circ,2) size(cont_bg_circ,3)]);
non_bg_circ=reshape(non_bg_circ,[size(non_bg_circ,1)*size(non_bg_circ,2) size(non_bg_circ,3)]);
[n1 x1]=hist(mean(cont_bg_circ-non_bg_circ,2),lim);
figure;bar(x1,n1/size(cont_bg_circ,1)')
ranksum(mean(cont_bg_circ,2),mean(non_bg_circ,2))
mean(mean(cont_bg_circ-non_bg_circ,2))
signrank(mean(cont_bg_circ-non_bg_circ,2))
signrank(n1)
xlim([-.4 .4])


load coeff_circle_diff_cond1
coeff_circ_circ_cond1=mean(coeff_circle_diff_cond1(:,:,t),3);
clear coeff_circle_diff_cond1
load coeff_circle_diff_cond5
coeff_circ_circ_cond5=mean(coeff_circle_diff_cond5(:,:,t),3);
clear coeff_circle_diff_cond5
cont_circ_circ=cat(3,coeff_circ_circ_cond1);
non_circ_circ=cat(3,coeff_circ_circ_cond5);
cont_circ_circ=reshape(cont_circ_circ,[size(cont_circ_circ,1)*size(cont_circ_circ,2) size(cont_circ_circ,3)]);
non_circ_circ=reshape(non_circ_circ,[size(non_circ_circ,1)*size(non_circ_circ,2) size(non_circ_circ,3)]);
[n1 x1]=hist(mean(cont_circ_circ-non_circ_circ,2),lim);
figure;bar(x1,n1/size(cont_circ_circ,1)')
ranksum(mean(cont_circ_circ,2),mean(non_circ_circ,2))
mean(mean(cont_circ_circ-non_circ_circ,2))
signrank(mean(cont_circ_circ-non_circ_circ,2))
signrank(n1)
xlim([-.4 .4])


load coeff_bg_in_cond1
coeff_bg_bg_cond1=mean(coeff_bg_in_cond1(:,:,t),3);
clear coeff_bg_in_cond1
load coeff_bg_in_cond5
coeff_bg_bg_cond5=mean(coeff_bg_in_cond5(:,:,t),3);
clear coeff_bg_in_cond5
cont_bg_bg=cat(3,coeff_bg_bg_cond1);
non_bg_bg=cat(3,coeff_bg_bg_cond5);
cont_bg_bg=reshape(cont_bg_bg,[size(cont_bg_bg,1)*size(cont_bg_bg,2) size(cont_bg_bg,3)]);
non_bg_bg=reshape(non_bg_bg,[size(non_bg_bg,1)*size(non_bg_bg,2) size(non_bg_bg,3)]);
[n1 x1]=hist(mean(cont_bg_bg-non_bg_bg,2),lim);
figure;bar(x1,n1/size(cont_bg_bg,1)')
ranksum(mean(cont_bg_bg,2),mean(non_bg_bg,2))
mean(mean(cont_bg_bg-non_bg_bg,2))
signrank(mean(cont_bg_bg-non_bg_bg,2))
signrank(n1)
xlim([-.4 .4])

save corr_bg_circ cont_bg_circ non_bg_circ roi_circle_diff roi_bg_in 
save corr_circ_circ cont_circ_circ non_circ_circ roi_circle_diff roi_bg_in
save corr_bg_bg cont_bg_bg non_bg_bg roi_circle_diff roi_bg_in


%% 2511e

cd F:\Data\VSDI\Contour_integration\legolas\right_hemisphere\psychophysics\2008_11_25\e\correct_and_incorrect_together\no_stim\pixelwise
t=7:9;
lim=-0.4:0.025:0.4;
load coeff_bg_in_circle_diff_cond1
coeff_bg_circ_cond1=mean(coeff_bg_in_circle_diff_cond1(:,:,t),3);
clear coeff_bg_in_circle_diff_cond1
load coeff_bg_in_circle_diff_cond5
coeff_bg_circ_cond5=mean(coeff_bg_in_circle_diff_cond5(:,:,t),3);
clear coeff_bg_in_circle_diff_cond5
cont_bg_circ=coeff_bg_circ_cond1;
non_bg_circ=coeff_bg_circ_cond5;
cont_bg_circ=reshape(cont_bg_circ,[size(cont_bg_circ,1)*size(cont_bg_circ,2) size(cont_bg_circ,3)]);
non_bg_circ=reshape(non_bg_circ,[size(non_bg_circ,1)*size(non_bg_circ,2) size(non_bg_circ,3)]);
[n1 x1]=hist(mean(cont_bg_circ-non_bg_circ,2),lim);
figure;bar(x1,n1/size(cont_bg_circ,1)')
ranksum(mean(cont_bg_circ,2),mean(non_bg_circ,2))
mean(mean(cont_bg_circ-non_bg_circ,2))
signrank(mean(cont_bg_circ-non_bg_circ,2))
signrank(n1)
xlim([-.4 .4])


load coeff_circle_diff_cond1
coeff_circ_circ_cond1=mean(coeff_circle_diff_cond1(:,:,t),3);
clear coeff_circle_diff_cond1
load coeff_circle_diff_cond5
coeff_circ_circ_cond5=mean(coeff_circle_diff_cond5(:,:,t),3);
clear coeff_circle_diff_cond5
cont_circ_circ=cat(3,coeff_circ_circ_cond1);
non_circ_circ=cat(3,coeff_circ_circ_cond5);
cont_circ_circ=reshape(cont_circ_circ,[size(cont_circ_circ,1)*size(cont_circ_circ,2) size(cont_circ_circ,3)]);
non_circ_circ=reshape(non_circ_circ,[size(non_circ_circ,1)*size(non_circ_circ,2) size(non_circ_circ,3)]);
[n1 x1]=hist(mean(cont_circ_circ-non_circ_circ,2),lim);
figure;bar(x1,n1/size(cont_circ_circ,1)')
ranksum(mean(cont_circ_circ,2),mean(non_circ_circ,2))
mean(mean(cont_circ_circ-non_circ_circ,2))
signrank(mean(cont_circ_circ-non_circ_circ,2))
signrank(n1)
xlim([-.4 .4])


load coeff_bg_in_cond1
coeff_bg_bg_cond1=mean(coeff_bg_in_cond1(:,:,t),3);
clear coeff_bg_in_cond1
load coeff_bg_in_cond5
coeff_bg_bg_cond5=mean(coeff_bg_in_cond5(:,:,t),3);
clear coeff_bg_in_cond5
cont_bg_bg=cat(3,coeff_bg_bg_cond1);
non_bg_bg=cat(3,coeff_bg_bg_cond5);
cont_bg_bg=reshape(cont_bg_bg,[size(cont_bg_bg,1)*size(cont_bg_bg,2) size(cont_bg_bg,3)]);
non_bg_bg=reshape(non_bg_bg,[size(non_bg_bg,1)*size(non_bg_bg,2) size(non_bg_bg,3)]);
[n1 x1]=hist(mean(cont_bg_bg-non_bg_bg,2),lim);
figure;bar(x1,n1/size(cont_bg_bg,1)')
ranksum(mean(cont_bg_bg,2),mean(non_bg_bg,2))
mean(mean(cont_bg_bg-non_bg_bg,2))
signrank(mean(cont_bg_bg-non_bg_bg,2))
signrank(n1)
xlim([-.4 .4])

save corr_bg_circ cont_bg_circ non_bg_circ roi_circle_diff roi_bg_in 
save corr_circ_circ cont_circ_circ non_circ_circ roi_circle_diff roi_bg_in
save corr_bg_bg cont_bg_bg non_bg_bg roi_circle_diff roi_bg_in


%% 2511f

cd F:\Data\VSDI\Contour_integration\legolas\right_hemisphere\psychophysics\2008_11_25\f\correct_and_incorrect_together\no_stim\pixelwise
t=7:9;
lim=-0.4:0.025:0.4;
load coeff_bg_in_circle_diff_cond1
coeff_bg_circ_cond1=mean(coeff_bg_in_circle_diff_cond1(:,:,t),3);
clear coeff_bg_in_circle_diff_cond1
load coeff_bg_in_circle_diff_cond5
coeff_bg_circ_cond5=mean(coeff_bg_in_circle_diff_cond5(:,:,t),3);
clear coeff_bg_in_circle_diff_cond5
cont_bg_circ=coeff_bg_circ_cond1;
non_bg_circ=coeff_bg_circ_cond5;
cont_bg_circ=reshape(cont_bg_circ,[size(cont_bg_circ,1)*size(cont_bg_circ,2) size(cont_bg_circ,3)]);
non_bg_circ=reshape(non_bg_circ,[size(non_bg_circ,1)*size(non_bg_circ,2) size(non_bg_circ,3)]);
[n1 x1]=hist(mean(cont_bg_circ-non_bg_circ,2),lim);
figure;bar(x1,n1/size(cont_bg_circ,1)')
ranksum(mean(cont_bg_circ,2),mean(non_bg_circ,2))
mean(mean(cont_bg_circ-non_bg_circ,2))
signrank(mean(cont_bg_circ-non_bg_circ,2))
signrank(n1)
xlim([-.4 .4])


load coeff_circle_diff_cond1
coeff_circ_circ_cond1=mean(coeff_circle_diff_cond1(:,:,t),3);
clear coeff_circle_diff_cond1
load coeff_circle_diff_cond5
coeff_circ_circ_cond5=mean(coeff_circle_diff_cond5(:,:,t),3);
clear coeff_circle_diff_cond5
cont_circ_circ=cat(3,coeff_circ_circ_cond1);
non_circ_circ=cat(3,coeff_circ_circ_cond5);
cont_circ_circ=reshape(cont_circ_circ,[size(cont_circ_circ,1)*size(cont_circ_circ,2) size(cont_circ_circ,3)]);
non_circ_circ=reshape(non_circ_circ,[size(non_circ_circ,1)*size(non_circ_circ,2) size(non_circ_circ,3)]);
[n1 x1]=hist(mean(cont_circ_circ-non_circ_circ,2),lim);
figure;bar(x1,n1/size(cont_circ_circ,1)')
ranksum(mean(cont_circ_circ,2),mean(non_circ_circ,2))
mean(mean(cont_circ_circ-non_circ_circ,2))
signrank(mean(cont_circ_circ-non_circ_circ,2))
signrank(n1)
xlim([-.4 .4])


load coeff_bg_in_cond1
coeff_bg_bg_cond1=mean(coeff_bg_in_cond1(:,:,t),3);
clear coeff_bg_in_cond1
load coeff_bg_in_cond5
coeff_bg_bg_cond5=mean(coeff_bg_in_cond5(:,:,t),3);
clear coeff_bg_in_cond5
cont_bg_bg=cat(3,coeff_bg_bg_cond1);
non_bg_bg=cat(3,coeff_bg_bg_cond5);
cont_bg_bg=reshape(cont_bg_bg,[size(cont_bg_bg,1)*size(cont_bg_bg,2) size(cont_bg_bg,3)]);
non_bg_bg=reshape(non_bg_bg,[size(non_bg_bg,1)*size(non_bg_bg,2) size(non_bg_bg,3)]);
[n1 x1]=hist(mean(cont_bg_bg-non_bg_bg,2),lim);
figure;bar(x1,n1/size(cont_bg_bg,1)')
ranksum(mean(cont_bg_bg,2),mean(non_bg_bg,2))
mean(mean(cont_bg_bg-non_bg_bg,2))
signrank(mean(cont_bg_bg-non_bg_bg,2))
signrank(n1)
xlim([-.4 .4])

save corr_bg_circ cont_bg_circ non_bg_circ roi_circle_diff roi_bg_in 
save corr_circ_circ cont_circ_circ non_circ_circ roi_circle_diff roi_bg_in
save corr_bg_bg cont_bg_bg non_bg_bg roi_circle_diff roi_bg_in

%% 1811c

cd F:\Data\VSDI\Contour_integration\legolas\right_hemisphere\psychophysics\2008_11_18\c\correct_and_incorrect_together\no_stim\pixelwise
t=8:9;
lim=-0.4:0.025:0.4;
load coeff_bg_in_circle_diff_cond1
coeff_bg_circ_cond1=mean(coeff_bg_in_circle_diff_cond1(:,:,t),3);
clear coeff_bg_in_circle_diff_cond1
load coeff_bg_in_circle_diff_cond5
coeff_bg_circ_cond5=mean(coeff_bg_in_circle_diff_cond5(:,:,t),3);
clear coeff_bg_in_circle_diff_cond5
cont_bg_circ=coeff_bg_circ_cond1;
non_bg_circ=coeff_bg_circ_cond5;
cont_bg_circ=reshape(cont_bg_circ,[size(cont_bg_circ,1)*size(cont_bg_circ,2) size(cont_bg_circ,3)]);
non_bg_circ=reshape(non_bg_circ,[size(non_bg_circ,1)*size(non_bg_circ,2) size(non_bg_circ,3)]);
[n1 x1]=hist(mean(cont_bg_circ-non_bg_circ,2),lim);
figure;bar(x1,n1/size(cont_bg_circ,1)')
ranksum(mean(cont_bg_circ,2),mean(non_bg_circ,2))
mean(mean(cont_bg_circ-non_bg_circ,2))
signrank(mean(cont_bg_circ-non_bg_circ,2))
signrank(n1)
xlim([-.4 .4])


load coeff_circle_diff_cond1
coeff_circ_circ_cond1=mean(coeff_circle_diff_cond1(:,:,t),3);
clear coeff_circle_diff_cond1
load coeff_circle_diff_cond5
coeff_circ_circ_cond5=mean(coeff_circle_diff_cond5(:,:,t),3);
clear coeff_circle_diff_cond5
cont_circ_circ=cat(3,coeff_circ_circ_cond1);
non_circ_circ=cat(3,coeff_circ_circ_cond5);
cont_circ_circ=reshape(cont_circ_circ,[size(cont_circ_circ,1)*size(cont_circ_circ,2) size(cont_circ_circ,3)]);
non_circ_circ=reshape(non_circ_circ,[size(non_circ_circ,1)*size(non_circ_circ,2) size(non_circ_circ,3)]);
[n1 x1]=hist(mean(cont_circ_circ-non_circ_circ,2),lim);
figure;bar(x1,n1/size(cont_circ_circ,1)')
ranksum(mean(cont_circ_circ,2),mean(non_circ_circ,2))
mean(mean(cont_circ_circ-non_circ_circ,2))
signrank(mean(cont_circ_circ-non_circ_circ,2))
signrank(n1)
xlim([-.4 .4])


load coeff_bg_in_cond1
coeff_bg_bg_cond1=mean(coeff_bg_in_cond1(:,:,t),3);
clear coeff_bg_in_cond1
load coeff_bg_in_cond5
coeff_bg_bg_cond5=mean(coeff_bg_in_cond5(:,:,t),3);
clear coeff_bg_in_cond5
cont_bg_bg=cat(3,coeff_bg_bg_cond1);
non_bg_bg=cat(3,coeff_bg_bg_cond5);
cont_bg_bg=reshape(cont_bg_bg,[size(cont_bg_bg,1)*size(cont_bg_bg,2) size(cont_bg_bg,3)]);
non_bg_bg=reshape(non_bg_bg,[size(non_bg_bg,1)*size(non_bg_bg,2) size(non_bg_bg,3)]);
[n1 x1]=hist(mean(cont_bg_bg-non_bg_bg,2),lim);
figure;bar(x1,n1/size(cont_bg_bg,1)')
ranksum(mean(cont_bg_bg,2),mean(non_bg_bg,2))
mean(mean(cont_bg_bg-non_bg_bg,2))
signrank(mean(cont_bg_bg-non_bg_bg,2))
signrank(n1)
xlim([-.4 .4])

save corr_bg_circ cont_bg_circ non_bg_circ roi_circle_diff roi_bg_in 
save corr_circ_circ cont_circ_circ non_circ_circ roi_circle_diff roi_bg_in
save corr_bg_bg cont_bg_bg non_bg_bg roi_circle_diff roi_bg_in



%% 1811d

cd F:\Data\VSDI\Contour_integration\legolas\right_hemisphere\psychophysics\2008_11_18\d\correct_and_incorrect_together\no_stim\pixelwise
t=6:9;
lim=-0.4:0.025:0.4;
load coeff_bg_in_circle_diff_cond1
coeff_bg_circ_cond1=mean(coeff_bg_in_circle_diff_cond1(:,:,t),3);
clear coeff_bg_in_circle_diff_cond1
load coeff_bg_in_circle_diff_cond5
coeff_bg_circ_cond5=mean(coeff_bg_in_circle_diff_cond5(:,:,t),3);
clear coeff_bg_in_circle_diff_cond5
cont_bg_circ=coeff_bg_circ_cond1;
non_bg_circ=coeff_bg_circ_cond5;
cont_bg_circ=reshape(cont_bg_circ,[size(cont_bg_circ,1)*size(cont_bg_circ,2) size(cont_bg_circ,3)]);
non_bg_circ=reshape(non_bg_circ,[size(non_bg_circ,1)*size(non_bg_circ,2) size(non_bg_circ,3)]);
[n1 x1]=hist(mean(cont_bg_circ-non_bg_circ,2),lim);
figure;bar(x1,n1/size(cont_bg_circ,1)')
ranksum(mean(cont_bg_circ,2),mean(non_bg_circ,2))
mean(mean(cont_bg_circ-non_bg_circ,2))
signrank(mean(cont_bg_circ-non_bg_circ,2))
signrank(n1)
xlim([-.4 .4])


load coeff_circle_diff_cond1
coeff_circ_circ_cond1=mean(coeff_circle_diff_cond1(:,:,t),3);
clear coeff_circle_diff_cond1
load coeff_circle_diff_cond5
coeff_circ_circ_cond5=mean(coeff_circle_diff_cond5(:,:,t),3);
clear coeff_circle_diff_cond5
cont_circ_circ=cat(3,coeff_circ_circ_cond1);
non_circ_circ=cat(3,coeff_circ_circ_cond5);
cont_circ_circ=reshape(cont_circ_circ,[size(cont_circ_circ,1)*size(cont_circ_circ,2) size(cont_circ_circ,3)]);
non_circ_circ=reshape(non_circ_circ,[size(non_circ_circ,1)*size(non_circ_circ,2) size(non_circ_circ,3)]);
[n1 x1]=hist(mean(cont_circ_circ-non_circ_circ,2),lim);
figure;bar(x1,n1/size(cont_circ_circ,1)')
ranksum(mean(cont_circ_circ,2),mean(non_circ_circ,2))
mean(mean(cont_circ_circ-non_circ_circ,2))
signrank(mean(cont_circ_circ-non_circ_circ,2))
signrank(n1)
xlim([-.4 .4])


load coeff_bg_in_cond1
coeff_bg_bg_cond1=mean(coeff_bg_in_cond1(:,:,t),3);
clear coeff_bg_in_cond1
load coeff_bg_in_cond5
coeff_bg_bg_cond5=mean(coeff_bg_in_cond5(:,:,t),3);
clear coeff_bg_in_cond5
cont_bg_bg=cat(3,coeff_bg_bg_cond1);
non_bg_bg=cat(3,coeff_bg_bg_cond5);
cont_bg_bg=reshape(cont_bg_bg,[size(cont_bg_bg,1)*size(cont_bg_bg,2) size(cont_bg_bg,3)]);
non_bg_bg=reshape(non_bg_bg,[size(non_bg_bg,1)*size(non_bg_bg,2) size(non_bg_bg,3)]);
[n1 x1]=hist(mean(cont_bg_bg-non_bg_bg,2),lim);
figure;bar(x1,n1/size(cont_bg_bg,1)')
ranksum(mean(cont_bg_bg,2),mean(non_bg_bg,2))
mean(mean(cont_bg_bg-non_bg_bg,2))
signrank(mean(cont_bg_bg-non_bg_bg,2))
signrank(n1)
xlim([-.4 .4])

save corr_bg_circ cont_bg_circ non_bg_circ roi_circle_diff roi_bg_in 
save corr_circ_circ cont_circ_circ non_circ_circ roi_circle_diff roi_bg_in
save corr_bg_bg cont_bg_bg non_bg_bg roi_circle_diff roi_bg_in



%% 1811e

cd F:\Data\VSDI\Contour_integration\legolas\right_hemisphere\psychophysics\2008_11_18\e\correct_and_incorrect_together\no_stim\pixelwise
t=7:10;
lim=-0.4:0.025:0.4;
load coeff_bg_in_circle_diff_cond1
coeff_bg_circ_cond1=mean(coeff_bg_in_circle_diff_cond1(:,:,t),3);
clear coeff_bg_in_circle_diff_cond1
load coeff_bg_in_circle_diff_cond5
coeff_bg_circ_cond5=mean(coeff_bg_in_circle_diff_cond5(:,:,t),3);
clear coeff_bg_in_circle_diff_cond5
cont_bg_circ=coeff_bg_circ_cond1;
non_bg_circ=coeff_bg_circ_cond5;
cont_bg_circ=reshape(cont_bg_circ,[size(cont_bg_circ,1)*size(cont_bg_circ,2) size(cont_bg_circ,3)]);
non_bg_circ=reshape(non_bg_circ,[size(non_bg_circ,1)*size(non_bg_circ,2) size(non_bg_circ,3)]);
[n1 x1]=hist(mean(cont_bg_circ-non_bg_circ,2),lim);
figure;bar(x1,n1/size(cont_bg_circ,1)')
ranksum(mean(cont_bg_circ,2),mean(non_bg_circ,2))
mean(mean(cont_bg_circ-non_bg_circ,2))
signrank(mean(cont_bg_circ-non_bg_circ,2))
signrank(n1)
xlim([-.4 .4])


load coeff_circle_diff_cond1
coeff_circ_circ_cond1=mean(coeff_circle_diff_cond1(:,:,t),3);
clear coeff_circle_diff_cond1
load coeff_circle_diff_cond5
coeff_circ_circ_cond5=mean(coeff_circle_diff_cond5(:,:,t),3);
clear coeff_circle_diff_cond5
cont_circ_circ=cat(3,coeff_circ_circ_cond1);
non_circ_circ=cat(3,coeff_circ_circ_cond5);
cont_circ_circ=reshape(cont_circ_circ,[size(cont_circ_circ,1)*size(cont_circ_circ,2) size(cont_circ_circ,3)]);
non_circ_circ=reshape(non_circ_circ,[size(non_circ_circ,1)*size(non_circ_circ,2) size(non_circ_circ,3)]);
[n1 x1]=hist(mean(cont_circ_circ-non_circ_circ,2),lim);
figure;bar(x1,n1/size(cont_circ_circ,1)')
ranksum(mean(cont_circ_circ,2),mean(non_circ_circ,2))
mean(mean(cont_circ_circ-non_circ_circ,2))
signrank(mean(cont_circ_circ-non_circ_circ,2))
signrank(n1)
xlim([-.4 .4])


load coeff_bg_in_cond1
coeff_bg_bg_cond1=mean(coeff_bg_in_cond1(:,:,t),3);
clear coeff_bg_in_cond1
load coeff_bg_in_cond5
coeff_bg_bg_cond5=mean(coeff_bg_in_cond5(:,:,t),3);
clear coeff_bg_in_cond5
cont_bg_bg=cat(3,coeff_bg_bg_cond1);
non_bg_bg=cat(3,coeff_bg_bg_cond5);
cont_bg_bg=reshape(cont_bg_bg,[size(cont_bg_bg,1)*size(cont_bg_bg,2) size(cont_bg_bg,3)]);
non_bg_bg=reshape(non_bg_bg,[size(non_bg_bg,1)*size(non_bg_bg,2) size(non_bg_bg,3)]);
[n1 x1]=hist(mean(cont_bg_bg-non_bg_bg,2),lim);
figure;bar(x1,n1/size(cont_bg_bg,1)')
ranksum(mean(cont_bg_bg,2),mean(non_bg_bg,2))
mean(mean(cont_bg_bg-non_bg_bg,2))
signrank(mean(cont_bg_bg-non_bg_bg,2))
signrank(n1)
xlim([-.4 .4])

save corr_bg_circ cont_bg_circ non_bg_circ roi_circle_diff roi_bg_in 
save corr_circ_circ cont_circ_circ non_circ_circ roi_circle_diff roi_bg_in
save corr_bg_bg cont_bg_bg non_bg_bg roi_circle_diff roi_bg_in


%% 1203d

cd F:\Data\VSDI\Contour_integration\legolas\right_hemisphere\psychophysics\2008_12_03\d\correct_and_incorrect_together\no_stim\pixelwise
t=5:9;
lim=-0.4:0.025:0.4;
load coeff_bg_in_circle_diff_cond1
coeff_bg_circ_cond1=mean(coeff_bg_in_circle_diff_cond1(:,:,t),3);
clear coeff_bg_in_circle_diff_cond1
load coeff_bg_in_circle_diff_cond5
coeff_bg_circ_cond5=mean(coeff_bg_in_circle_diff_cond5(:,:,t),3);
clear coeff_bg_in_circle_diff_cond5
cont_bg_circ=coeff_bg_circ_cond1;
non_bg_circ=coeff_bg_circ_cond5;
cont_bg_circ=reshape(cont_bg_circ,[size(cont_bg_circ,1)*size(cont_bg_circ,2) size(cont_bg_circ,3)]);
non_bg_circ=reshape(non_bg_circ,[size(non_bg_circ,1)*size(non_bg_circ,2) size(non_bg_circ,3)]);
[n1 x1]=hist(mean(cont_bg_circ-non_bg_circ,2),lim);
figure;bar(x1,n1/size(cont_bg_circ,1)')
ranksum(mean(cont_bg_circ,2),mean(non_bg_circ,2))
mean(mean(cont_bg_circ-non_bg_circ,2))
signrank(mean(cont_bg_circ-non_bg_circ,2))
signrank(n1)
xlim([-.4 .4])


load coeff_circle_diff_cond1
coeff_circ_circ_cond1=mean(coeff_circle_diff_cond1(:,:,t),3);
clear coeff_circle_diff_cond1
load coeff_circle_diff_cond5
coeff_circ_circ_cond5=mean(coeff_circle_diff_cond5(:,:,t),3);
clear coeff_circle_diff_cond5
cont_circ_circ=cat(3,coeff_circ_circ_cond1);
non_circ_circ=cat(3,coeff_circ_circ_cond5);
cont_circ_circ=reshape(cont_circ_circ,[size(cont_circ_circ,1)*size(cont_circ_circ,2) size(cont_circ_circ,3)]);
non_circ_circ=reshape(non_circ_circ,[size(non_circ_circ,1)*size(non_circ_circ,2) size(non_circ_circ,3)]);
[n1 x1]=hist(mean(cont_circ_circ-non_circ_circ,2),lim);
figure;bar(x1,n1/size(cont_circ_circ,1)')
ranksum(mean(cont_circ_circ,2),mean(non_circ_circ,2))
mean(mean(cont_circ_circ-non_circ_circ,2))
signrank(mean(cont_circ_circ-non_circ_circ,2))
signrank(n1)
xlim([-.4 .4])


load coeff_bg_in_cond1
coeff_bg_bg_cond1=mean(coeff_bg_in_cond1(:,:,t),3);
clear coeff_bg_in_cond1
load coeff_bg_in_cond5
coeff_bg_bg_cond5=mean(coeff_bg_in_cond5(:,:,t),3);
clear coeff_bg_in_cond5
cont_bg_bg=cat(3,coeff_bg_bg_cond1);
non_bg_bg=cat(3,coeff_bg_bg_cond5);
cont_bg_bg=reshape(cont_bg_bg,[size(cont_bg_bg,1)*size(cont_bg_bg,2) size(cont_bg_bg,3)]);
non_bg_bg=reshape(non_bg_bg,[size(non_bg_bg,1)*size(non_bg_bg,2) size(non_bg_bg,3)]);
[n1 x1]=hist(mean(cont_bg_bg-non_bg_bg,2),lim);
figure;bar(x1,n1/size(cont_bg_bg,1)')
ranksum(mean(cont_bg_bg,2),mean(non_bg_bg,2))
mean(mean(cont_bg_bg-non_bg_bg,2))
signrank(mean(cont_bg_bg-non_bg_bg,2))
signrank(n1)
xlim([-.4 .4])

save corr_bg_circ cont_bg_circ non_bg_circ roi_circle_diff roi_bg_in 
save corr_circ_circ cont_circ_circ non_circ_circ roi_circle_diff roi_bg_in
save corr_bg_bg cont_bg_bg non_bg_bg roi_circle_diff roi_bg_in



%% 1203e

cd F:\Data\VSDI\Contour_integration\legolas\right_hemisphere\psychophysics\2008_12_03\e\correct_and_incorrect_together\no_stim\pixelwise
t=5:9;
lim=-0.4:0.025:0.4;
load coeff_bg_in_circle_diff_cond1
coeff_bg_circ_cond1=mean(coeff_bg_in_circle_diff_cond1(:,:,t),3);
clear coeff_bg_in_circle_diff_cond1
load coeff_bg_in_circle_diff_cond5
coeff_bg_circ_cond5=mean(coeff_bg_in_circle_diff_cond5(:,:,t),3);
clear coeff_bg_in_circle_diff_cond5
cont_bg_circ=coeff_bg_circ_cond1;
non_bg_circ=coeff_bg_circ_cond5;
cont_bg_circ=reshape(cont_bg_circ,[size(cont_bg_circ,1)*size(cont_bg_circ,2) size(cont_bg_circ,3)]);
non_bg_circ=reshape(non_bg_circ,[size(non_bg_circ,1)*size(non_bg_circ,2) size(non_bg_circ,3)]);
[n1 x1]=hist(mean(cont_bg_circ-non_bg_circ,2),lim);
figure;bar(x1,n1/size(cont_bg_circ,1)')
ranksum(mean(cont_bg_circ,2),mean(non_bg_circ,2))
mean(mean(cont_bg_circ-non_bg_circ,2))
signrank(mean(cont_bg_circ-non_bg_circ,2))
signrank(n1)
xlim([-.4 .4])


load coeff_circle_diff_cond1
coeff_circ_circ_cond1=mean(coeff_circle_diff_cond1(:,:,t),3);
clear coeff_circle_diff_cond1
load coeff_circle_diff_cond5
coeff_circ_circ_cond5=mean(coeff_circle_diff_cond5(:,:,t),3);
clear coeff_circle_diff_cond5
cont_circ_circ=cat(3,coeff_circ_circ_cond1);
non_circ_circ=cat(3,coeff_circ_circ_cond5);
cont_circ_circ=reshape(cont_circ_circ,[size(cont_circ_circ,1)*size(cont_circ_circ,2) size(cont_circ_circ,3)]);
non_circ_circ=reshape(non_circ_circ,[size(non_circ_circ,1)*size(non_circ_circ,2) size(non_circ_circ,3)]);
[n1 x1]=hist(mean(cont_circ_circ-non_circ_circ,2),lim);
figure;bar(x1,n1/size(cont_circ_circ,1)')
ranksum(mean(cont_circ_circ,2),mean(non_circ_circ,2))
mean(mean(cont_circ_circ-non_circ_circ,2))
signrank(mean(cont_circ_circ-non_circ_circ,2))
signrank(n1)
xlim([-.4 .4])


load coeff_bg_in_cond1
coeff_bg_bg_cond1=mean(coeff_bg_in_cond1(:,:,t),3);
clear coeff_bg_in_cond1
load coeff_bg_in_cond5
coeff_bg_bg_cond5=mean(coeff_bg_in_cond5(:,:,t),3);
clear coeff_bg_in_cond5
cont_bg_bg=cat(3,coeff_bg_bg_cond1);
non_bg_bg=cat(3,coeff_bg_bg_cond5);
cont_bg_bg=reshape(cont_bg_bg,[size(cont_bg_bg,1)*size(cont_bg_bg,2) size(cont_bg_bg,3)]);
non_bg_bg=reshape(non_bg_bg,[size(non_bg_bg,1)*size(non_bg_bg,2) size(non_bg_bg,3)]);
[n1 x1]=hist(mean(cont_bg_bg-non_bg_bg,2),lim);
figure;bar(x1,n1/size(cont_bg_bg,1)')
ranksum(mean(cont_bg_bg,2),mean(non_bg_bg,2))
mean(mean(cont_bg_bg-non_bg_bg,2))
signrank(mean(cont_bg_bg-non_bg_bg,2))
signrank(n1)
xlim([-.4 .4])

save corr_bg_circ cont_bg_circ non_bg_circ roi_circle_diff roi_bg_in 
save corr_circ_circ cont_circ_circ non_circ_circ roi_circle_diff roi_bg_in
save corr_bg_bg cont_bg_bg non_bg_bg roi_circle_diff roi_bg_in



%% 1203e

cd F:\Data\VSDI\Contour_integration\legolas\right_hemisphere\psychophysics\2008_12_03\f\correct_and_incorrect_together\no_stim\pixelwise
t=4:6;
lim=-0.4:0.025:0.4;
load coeff_bg_in_circle_diff_cond1
coeff_bg_circ_cond1=mean(coeff_bg_in_circle_diff_cond1(:,:,t),3);
clear coeff_bg_in_circle_diff_cond1
load coeff_bg_in_circle_diff_cond5
coeff_bg_circ_cond5=mean(coeff_bg_in_circle_diff_cond5(:,:,t),3);
clear coeff_bg_in_circle_diff_cond5
cont_bg_circ=coeff_bg_circ_cond1;
non_bg_circ=coeff_bg_circ_cond5;
cont_bg_circ=reshape(cont_bg_circ,[size(cont_bg_circ,1)*size(cont_bg_circ,2) size(cont_bg_circ,3)]);
non_bg_circ=reshape(non_bg_circ,[size(non_bg_circ,1)*size(non_bg_circ,2) size(non_bg_circ,3)]);
[n1 x1]=hist(mean(cont_bg_circ-non_bg_circ,2),lim);
figure;bar(x1,n1/size(cont_bg_circ,1)')
ranksum(mean(cont_bg_circ,2),mean(non_bg_circ,2))
mean(mean(cont_bg_circ-non_bg_circ,2))
signrank(mean(cont_bg_circ-non_bg_circ,2))
signrank(n1)
xlim([-.4 .4])


load coeff_circle_diff_cond1
coeff_circ_circ_cond1=mean(coeff_circle_diff_cond1(:,:,t),3);
clear coeff_circle_diff_cond1
load coeff_circle_diff_cond5
coeff_circ_circ_cond5=mean(coeff_circle_diff_cond5(:,:,t),3);
clear coeff_circle_diff_cond5
cont_circ_circ=cat(3,coeff_circ_circ_cond1);
non_circ_circ=cat(3,coeff_circ_circ_cond5);
cont_circ_circ=reshape(cont_circ_circ,[size(cont_circ_circ,1)*size(cont_circ_circ,2) size(cont_circ_circ,3)]);
non_circ_circ=reshape(non_circ_circ,[size(non_circ_circ,1)*size(non_circ_circ,2) size(non_circ_circ,3)]);
[n1 x1]=hist(mean(cont_circ_circ-non_circ_circ,2),lim);
figure;bar(x1,n1/size(cont_circ_circ,1)')
ranksum(mean(cont_circ_circ,2),mean(non_circ_circ,2))
mean(mean(cont_circ_circ-non_circ_circ,2))
signrank(mean(cont_circ_circ-non_circ_circ,2))
signrank(n1)
xlim([-.4 .4])


load coeff_bg_in_cond1
coeff_bg_bg_cond1=mean(coeff_bg_in_cond1(:,:,t),3);
clear coeff_bg_in_cond1
load coeff_bg_in_cond5
coeff_bg_bg_cond5=mean(coeff_bg_in_cond5(:,:,t),3);
clear coeff_bg_in_cond5
cont_bg_bg=cat(3,coeff_bg_bg_cond1);
non_bg_bg=cat(3,coeff_bg_bg_cond5);
cont_bg_bg=reshape(cont_bg_bg,[size(cont_bg_bg,1)*size(cont_bg_bg,2) size(cont_bg_bg,3)]);
non_bg_bg=reshape(non_bg_bg,[size(non_bg_bg,1)*size(non_bg_bg,2) size(non_bg_bg,3)]);
[n1 x1]=hist(mean(cont_bg_bg-non_bg_bg,2),lim);
figure;bar(x1,n1/size(cont_bg_bg,1)')
ranksum(mean(cont_bg_bg,2),mean(non_bg_bg,2))
mean(mean(cont_bg_bg-non_bg_bg,2))
signrank(mean(cont_bg_bg-non_bg_bg,2))
signrank(n1)
xlim([-.4 .4])

save corr_bg_circ cont_bg_circ non_bg_circ roi_circle_diff roi_bg_in 
save corr_circ_circ cont_circ_circ non_circ_circ roi_circle_diff roi_bg_in
save corr_bg_bg cont_bg_bg non_bg_bg roi_circle_diff roi_bg_in


%% 0610e

cd F:\Data\VSDI\Contour_integration\legolas\right_hemisphere\06_10_2008\e\no_stim\pixelwise
t=6:9;
load coeff_bg_in_circle_diff_cond1
coeff_bg_circ_cond1=mean(coeff_bg_in_circle_diff_cond1(:,:,t),3);
clear coeff_bg_in_circle_diff_cond1
load coeff_bg_in_circle_diff_cond2
coeff_bg_circ_cond2=mean(coeff_bg_in_circle_diff_cond2(:,:,t),3);
clear coeff_bg_in_circle_diff_cond2
load coeff_bg_in_circle_diff_cond4
coeff_bg_circ_cond4=mean(coeff_bg_in_circle_diff_cond4(:,:,t),3);
clear coeff_bg_in_circle_diff_cond4
load coeff_bg_in_circle_diff_cond5
coeff_bg_circ_cond5=mean(coeff_bg_in_circle_diff_cond5(:,:,t),3);
clear coeff_bg_in_circle_diff_cond5
cont_bg_circ=cat(3,coeff_bg_circ_cond1,coeff_bg_circ_cond2);
non_bg_circ=cat(3,coeff_bg_circ_cond4,coeff_bg_circ_cond5);
cont_bg_circ=reshape(cont_bg_circ,[size(cont_bg_circ,1)*size(cont_bg_circ,2) size(cont_bg_circ,3)]);
non_bg_circ=reshape(non_bg_circ,[size(non_bg_circ,1)*size(non_bg_circ,2) size(non_bg_circ,3)]);
[n1 x1]=hist(mean(cont_bg_circ-non_bg_circ,2),-0.2:0.01:0.2);
figure;bar(x1,n1/size(cont_bg_circ,1)')
ranksum(mean(cont_bg_circ,2),mean(non_bg_circ,2))
mean(mean(cont_bg_circ-non_bg_circ,2))
signrank(mean(cont_bg_circ-non_bg_circ,2))
signrank(n1)



load coeff_circle_diff_cond1
coeff_circ_circ_cond1=mean(coeff_circle_diff_cond1(:,:,t),3);
clear coeff_circle_diff_cond1
load coeff_circle_diff_cond2
coeff_circ_circ_cond2=mean(coeff_circle_diff_cond2(:,:,t),3);
clear coeff_circle_diff_cond2
load coeff_circle_diff_cond4
coeff_circ_circ_cond4=mean(coeff_circle_diff_cond4(:,:,t),3);
clear coeff_circle_diff_cond4
load coeff_circle_diff_cond5
coeff_circ_circ_cond5=mean(coeff_circle_diff_cond5(:,:,t),3);
clear coeff_circle_diff_cond5
cont_circ_circ=cat(3,coeff_circ_circ_cond1,coeff_circ_circ_cond2);
non_circ_circ=cat(3,coeff_circ_circ_cond4,coeff_circ_circ_cond5);
cont_circ_circ=reshape(cont_circ_circ,[size(cont_circ_circ,1)*size(cont_circ_circ,2) size(cont_circ_circ,3)]);
non_circ_circ=reshape(non_circ_circ,[size(non_circ_circ,1)*size(non_circ_circ,2) size(non_circ_circ,3)]);
[n1 x1]=hist(mean(cont_circ_circ-non_circ_circ,2),-0.2:0.01:0.2);
figure;bar(x1,n1/size(cont_circ_circ,1)')
ranksum(mean(cont_circ_circ,2),mean(non_circ_circ,2))
mean(mean(cont_circ_circ-non_circ_circ,2))
signrank(mean(cont_circ_circ-non_circ_circ,2))
signrank(n1)



load coeff_bg_in_cond1
coeff_bg_bg_cond1=mean(coeff_bg_in_cond1(:,:,t),3);
clear coeff_bg_in_cond1
load coeff_bg_in_cond2
coeff_bg_bg_cond2=mean(coeff_bg_in_cond2(:,:,t),3);
clear coeff_bg_in_cond2
load coeff_bg_in_cond4
coeff_bg_bg_cond4=mean(coeff_bg_in_cond4(:,:,t),3);
clear coeff_bg_in_cond4
load coeff_bg_in_cond5
coeff_bg_bg_cond5=mean(coeff_bg_in_cond5(:,:,t),3);
clear coeff_bg_in_cond5
cont_bg_bg=cat(3,coeff_bg_bg_cond1,coeff_bg_bg_cond2);
non_bg_bg=cat(3,coeff_bg_bg_cond4,coeff_bg_bg_cond5);
cont_bg_bg=reshape(cont_bg_bg,[size(cont_bg_bg,1)*size(cont_bg_bg,2) size(cont_bg_bg,3)]);
non_bg_bg=reshape(non_bg_bg,[size(non_bg_bg,1)*size(non_bg_bg,2) size(non_bg_bg,3)]);
[n1 x1]=hist(mean(cont_bg_bg-non_bg_bg,2),-0.2:0.01:0.2);
figure;bar(x1,n1/size(cont_bg_bg,1)')
ranksum(mean(cont_bg_bg,2),mean(non_bg_bg,2))
mean(mean(cont_bg_bg-non_bg_bg,2))
signrank(mean(cont_bg_bg-non_bg_bg,2))
signrank(n1)


save corr_bg_circ cont_bg_circ non_bg_circ roi_circle_diff roi_bg_in
save corr_circ_circ cont_circ_circ non_circ_circ roi_circle_diff roi_bg_in
save corr_bg_bg cont_bg_bg non_bg_bg roi_circle_diff roi_bg_in

%% 0610f

cd F:\Data\VSDI\Contour_integration\legolas\right_hemisphere\06_10_2008\f\no_stim\pixelwise
t=6:9;
load coeff_bg_in_circle_diff_cond1
coeff_bg_circ_cond1=mean(coeff_bg_in_circle_diff_cond1(:,:,t),3);
clear coeff_bg_in_circle_diff_cond1
load coeff_bg_in_circle_diff_cond2
coeff_bg_circ_cond2=mean(coeff_bg_in_circle_diff_cond2(:,:,t),3);
clear coeff_bg_in_circle_diff_cond2
load coeff_bg_in_circle_diff_cond4
coeff_bg_circ_cond4=mean(coeff_bg_in_circle_diff_cond4(:,:,t),3);
clear coeff_bg_in_circle_diff_cond4
load coeff_bg_in_circle_diff_cond5
coeff_bg_circ_cond5=mean(coeff_bg_in_circle_diff_cond5(:,:,t),3);
clear coeff_bg_in_circle_diff_cond5
cont_bg_circ=cat(3,coeff_bg_circ_cond1,coeff_bg_circ_cond2);
non_bg_circ=cat(3,coeff_bg_circ_cond4,coeff_bg_circ_cond5);
cont_bg_circ=reshape(cont_bg_circ,[size(cont_bg_circ,1)*size(cont_bg_circ,2) size(cont_bg_circ,3)]);
non_bg_circ=reshape(non_bg_circ,[size(non_bg_circ,1)*size(non_bg_circ,2) size(non_bg_circ,3)]);
[n1 x1]=hist(mean(cont_bg_circ-non_bg_circ,2),-0.2:0.01:0.2);
figure;bar(x1,n1/size(cont_bg_circ,1)')
ranksum(mean(cont_bg_circ,2),mean(non_bg_circ,2))
mean(mean(cont_bg_circ-non_bg_circ,2))
signrank(mean(cont_bg_circ-non_bg_circ,2))
signrank(n1)



load coeff_circle_diff_cond1
coeff_circ_circ_cond1=mean(coeff_circle_diff_cond1(:,:,t),3);
clear coeff_circle_diff_cond1
load coeff_circle_diff_cond2
coeff_circ_circ_cond2=mean(coeff_circle_diff_cond2(:,:,t),3);
clear coeff_circle_diff_cond2
load coeff_circle_diff_cond4
coeff_circ_circ_cond4=mean(coeff_circle_diff_cond4(:,:,t),3);
clear coeff_circle_diff_cond4
load coeff_circle_diff_cond5
coeff_circ_circ_cond5=mean(coeff_circle_diff_cond5(:,:,t),3);
clear coeff_circle_diff_cond5
cont_circ_circ=cat(3,coeff_circ_circ_cond1,coeff_circ_circ_cond2);
non_circ_circ=cat(3,coeff_circ_circ_cond4,coeff_circ_circ_cond5);
cont_circ_circ=reshape(cont_circ_circ,[size(cont_circ_circ,1)*size(cont_circ_circ,2) size(cont_circ_circ,3)]);
non_circ_circ=reshape(non_circ_circ,[size(non_circ_circ,1)*size(non_circ_circ,2) size(non_circ_circ,3)]);
[n1 x1]=hist(mean(cont_circ_circ-non_circ_circ,2),-0.2:0.01:0.2);
figure;bar(x1,n1/size(cont_circ_circ,1)')
ranksum(mean(cont_circ_circ,2),mean(non_circ_circ,2))
mean(mean(cont_circ_circ-non_circ_circ,2))
signrank(mean(cont_circ_circ-non_circ_circ,2))
signrank(n1)



load coeff_bg_in_cond1
coeff_bg_bg_cond1=mean(coeff_bg_in_cond1(:,:,t),3);
clear coeff_bg_in_cond1
load coeff_bg_in_cond2
coeff_bg_bg_cond2=mean(coeff_bg_in_cond2(:,:,t),3);
clear coeff_bg_in_cond2
load coeff_bg_in_cond4
coeff_bg_bg_cond4=mean(coeff_bg_in_cond4(:,:,t),3);
clear coeff_bg_in_cond4
load coeff_bg_in_cond5
coeff_bg_bg_cond5=mean(coeff_bg_in_cond5(:,:,t),3);
clear coeff_bg_in_cond5
cont_bg_bg=cat(3,coeff_bg_bg_cond1,coeff_bg_bg_cond2);
non_bg_bg=cat(3,coeff_bg_bg_cond4,coeff_bg_bg_cond5);
cont_bg_bg=reshape(cont_bg_bg,[size(cont_bg_bg,1)*size(cont_bg_bg,2) size(cont_bg_bg,3)]);
non_bg_bg=reshape(non_bg_bg,[size(non_bg_bg,1)*size(non_bg_bg,2) size(non_bg_bg,3)]);
[n1 x1]=hist(mean(cont_bg_bg-non_bg_bg,2),-0.2:0.01:0.2);
figure;bar(x1,n1/size(cont_bg_bg,1)')
ranksum(mean(cont_bg_bg,2),mean(non_bg_bg,2))
mean(mean(cont_bg_bg-non_bg_bg,2))
signrank(mean(cont_bg_bg-non_bg_bg,2))
signrank(n1)


save corr_bg_circ cont_bg_circ non_bg_circ roi_circle_diff roi_bg_in
save corr_circ_circ cont_circ_circ non_circ_circ roi_circle_diff roi_bg_in
save corr_bg_bg cont_bg_bg non_bg_bg roi_circle_diff roi_bg_in



%% 2210d

cd F:\Data\VSDI\Contour_integration\legolas\right_hemisphere\22_10_2008\d\no_stim\pixelwise
t=6:9;
load coeff_bg_in_circle_diff_cond1
coeff_bg_circ_cond1=mean(coeff_bg_in_circle_diff_cond1(:,:,t),3);
clear coeff_bg_in_circle_diff_cond1
load coeff_bg_in_circle_diff_cond2
coeff_bg_circ_cond2=mean(coeff_bg_in_circle_diff_cond2(:,:,t),3);
clear coeff_bg_in_circle_diff_cond2
load coeff_bg_in_circle_diff_cond4
coeff_bg_circ_cond4=mean(coeff_bg_in_circle_diff_cond4(:,:,t),3);
clear coeff_bg_in_circle_diff_cond4
load coeff_bg_in_circle_diff_cond5
coeff_bg_circ_cond5=mean(coeff_bg_in_circle_diff_cond5(:,:,t),3);
clear coeff_bg_in_circle_diff_cond5
cont_bg_circ=cat(3,coeff_bg_circ_cond1,coeff_bg_circ_cond2);
non_bg_circ=cat(3,coeff_bg_circ_cond4,coeff_bg_circ_cond5);
cont_bg_circ=reshape(cont_bg_circ,[size(cont_bg_circ,1)*size(cont_bg_circ,2) size(cont_bg_circ,3)]);
non_bg_circ=reshape(non_bg_circ,[size(non_bg_circ,1)*size(non_bg_circ,2) size(non_bg_circ,3)]);
[n1 x1]=hist(mean(cont_bg_circ-non_bg_circ,2),-0.2:0.01:0.2);
figure;bar(x1,n1/size(cont_bg_circ,1)')
ranksum(mean(cont_bg_circ,2),mean(non_bg_circ,2))
mean(mean(cont_bg_circ-non_bg_circ,2))
signrank(mean(cont_bg_circ-non_bg_circ,2))
signrank(n1)



load coeff_circle_diff_cond1
coeff_circ_circ_cond1=mean(coeff_circle_diff_cond1(:,:,t),3);
clear coeff_circle_diff_cond1
load coeff_circle_diff_cond2
coeff_circ_circ_cond2=mean(coeff_circle_diff_cond2(:,:,t),3);
clear coeff_circle_diff_cond2
load coeff_circle_diff_cond4
coeff_circ_circ_cond4=mean(coeff_circle_diff_cond4(:,:,t),3);
clear coeff_circle_diff_cond4
load coeff_circle_diff_cond5
coeff_circ_circ_cond5=mean(coeff_circle_diff_cond5(:,:,t),3);
clear coeff_circle_diff_cond5
cont_circ_circ=cat(3,coeff_circ_circ_cond1,coeff_circ_circ_cond2);
non_circ_circ=cat(3,coeff_circ_circ_cond4,coeff_circ_circ_cond5);
cont_circ_circ=reshape(cont_circ_circ,[size(cont_circ_circ,1)*size(cont_circ_circ,2) size(cont_circ_circ,3)]);
non_circ_circ=reshape(non_circ_circ,[size(non_circ_circ,1)*size(non_circ_circ,2) size(non_circ_circ,3)]);
[n1 x1]=hist(mean(cont_circ_circ-non_circ_circ,2),-0.2:0.01:0.2);
figure;bar(x1,n1/size(cont_circ_circ,1)')
ranksum(mean(cont_circ_circ,2),mean(non_circ_circ,2))
mean(mean(cont_circ_circ-non_circ_circ,2))
signrank(mean(cont_circ_circ-non_circ_circ,2))
signrank(n1)



load coeff_bg_in_cond1
coeff_bg_bg_cond1=mean(coeff_bg_in_cond1(:,:,t),3);
clear coeff_bg_in_cond1
load coeff_bg_in_cond2
coeff_bg_bg_cond2=mean(coeff_bg_in_cond2(:,:,t),3);
clear coeff_bg_in_cond2
load coeff_bg_in_cond4
coeff_bg_bg_cond4=mean(coeff_bg_in_cond4(:,:,t),3);
clear coeff_bg_in_cond4
load coeff_bg_in_cond5
coeff_bg_bg_cond5=mean(coeff_bg_in_cond5(:,:,t),3);
clear coeff_bg_in_cond5
cont_bg_bg=cat(3,coeff_bg_bg_cond1,coeff_bg_bg_cond2);
non_bg_bg=cat(3,coeff_bg_bg_cond4,coeff_bg_bg_cond5);
cont_bg_bg=reshape(cont_bg_bg,[size(cont_bg_bg,1)*size(cont_bg_bg,2) size(cont_bg_bg,3)]);
non_bg_bg=reshape(non_bg_bg,[size(non_bg_bg,1)*size(non_bg_bg,2) size(non_bg_bg,3)]);
[n1 x1]=hist(mean(cont_bg_bg-non_bg_bg,2),-0.2:0.01:0.2);
figure;bar(x1,n1/size(cont_bg_bg,1)')
ranksum(mean(cont_bg_bg,2),mean(non_bg_bg,2))
mean(mean(cont_bg_bg-non_bg_bg,2))
signrank(mean(cont_bg_bg-non_bg_bg,2))
signrank(n1)


save corr_bg_circ cont_bg_circ non_bg_circ roi_circle_diff roi_bg_in
save corr_circ_circ cont_circ_circ non_circ_circ roi_circle_diff roi_bg_in
save corr_bg_bg cont_bg_bg non_bg_bg roi_circle_diff roi_bg_in



%% 2210e

cd F:\Data\VSDI\Contour_integration\legolas\right_hemisphere\22_10_2008\e\no_stim\pixelwise
t=6:9;
load coeff_bg_in_circle_diff_cond1
coeff_bg_circ_cond1=mean(coeff_bg_in_circle_diff_cond1(:,:,t),3);
clear coeff_bg_in_circle_diff_cond1
load coeff_bg_in_circle_diff_cond2
coeff_bg_circ_cond2=mean(coeff_bg_in_circle_diff_cond2(:,:,t),3);
clear coeff_bg_in_circle_diff_cond2
load coeff_bg_in_circle_diff_cond4
coeff_bg_circ_cond4=mean(coeff_bg_in_circle_diff_cond4(:,:,t),3);
clear coeff_bg_in_circle_diff_cond4
load coeff_bg_in_circle_diff_cond5
coeff_bg_circ_cond5=mean(coeff_bg_in_circle_diff_cond5(:,:,t),3);
clear coeff_bg_in_circle_diff_cond5
cont_bg_circ=cat(3,coeff_bg_circ_cond1,coeff_bg_circ_cond2);
non_bg_circ=cat(3,coeff_bg_circ_cond4,coeff_bg_circ_cond5);
cont_bg_circ=reshape(cont_bg_circ,[size(cont_bg_circ,1)*size(cont_bg_circ,2) size(cont_bg_circ,3)]);
non_bg_circ=reshape(non_bg_circ,[size(non_bg_circ,1)*size(non_bg_circ,2) size(non_bg_circ,3)]);
[n1 x1]=hist(mean(cont_bg_circ-non_bg_circ,2),-0.2:0.01:0.2);
figure;bar(x1,n1/size(cont_bg_circ,1)')
ranksum(mean(cont_bg_circ,2),mean(non_bg_circ,2))
mean(mean(cont_bg_circ-non_bg_circ,2))
signrank(mean(cont_bg_circ-non_bg_circ,2))
signrank(n1)



load coeff_circle_diff_cond1
coeff_circ_circ_cond1=mean(coeff_circle_diff_cond1(:,:,t),3);
clear coeff_circle_diff_cond1
load coeff_circle_diff_cond2
coeff_circ_circ_cond2=mean(coeff_circle_diff_cond2(:,:,t),3);
clear coeff_circle_diff_cond2
load coeff_circle_diff_cond4
coeff_circ_circ_cond4=mean(coeff_circle_diff_cond4(:,:,t),3);
clear coeff_circle_diff_cond4
load coeff_circle_diff_cond5
coeff_circ_circ_cond5=mean(coeff_circle_diff_cond5(:,:,t),3);
clear coeff_circle_diff_cond5
cont_circ_circ=cat(3,coeff_circ_circ_cond1,coeff_circ_circ_cond2);
non_circ_circ=cat(3,coeff_circ_circ_cond4,coeff_circ_circ_cond5);
cont_circ_circ=reshape(cont_circ_circ,[size(cont_circ_circ,1)*size(cont_circ_circ,2) size(cont_circ_circ,3)]);
non_circ_circ=reshape(non_circ_circ,[size(non_circ_circ,1)*size(non_circ_circ,2) size(non_circ_circ,3)]);
[n1 x1]=hist(mean(cont_circ_circ-non_circ_circ,2),-0.2:0.01:0.2);
figure;bar(x1,n1/size(cont_circ_circ,1)')
ranksum(mean(cont_circ_circ,2),mean(non_circ_circ,2))
mean(mean(cont_circ_circ-non_circ_circ,2))
signrank(mean(cont_circ_circ-non_circ_circ,2))
signrank(n1)



load coeff_bg_in_cond1
coeff_bg_bg_cond1=mean(coeff_bg_in_cond1(:,:,t),3);
clear coeff_bg_in_cond1
load coeff_bg_in_cond2
coeff_bg_bg_cond2=mean(coeff_bg_in_cond2(:,:,t),3);
clear coeff_bg_in_cond2
load coeff_bg_in_cond4
coeff_bg_bg_cond4=mean(coeff_bg_in_cond4(:,:,t),3);
clear coeff_bg_in_cond4
load coeff_bg_in_cond5
coeff_bg_bg_cond5=mean(coeff_bg_in_cond5(:,:,t),3);
clear coeff_bg_in_cond5
cont_bg_bg=cat(3,coeff_bg_bg_cond1,coeff_bg_bg_cond2);
non_bg_bg=cat(3,coeff_bg_bg_cond4,coeff_bg_bg_cond5);
cont_bg_bg=reshape(cont_bg_bg,[size(cont_bg_bg,1)*size(cont_bg_bg,2) size(cont_bg_bg,3)]);
non_bg_bg=reshape(non_bg_bg,[size(non_bg_bg,1)*size(non_bg_bg,2) size(non_bg_bg,3)]);
[n1 x1]=hist(mean(cont_bg_bg-non_bg_bg,2),-0.2:0.01:0.2);
figure;bar(x1,n1/size(cont_bg_bg,1)')
ranksum(mean(cont_bg_bg,2),mean(non_bg_bg,2))
mean(mean(cont_bg_bg-non_bg_bg,2))
signrank(mean(cont_bg_bg-non_bg_bg,2))
signrank(n1)


save corr_bg_circ cont_bg_circ non_bg_circ roi_circle_diff roi_bg_in
save corr_circ_circ cont_circ_circ non_circ_circ roi_circle_diff roi_bg_in
save corr_bg_bg cont_bg_bg non_bg_bg roi_circle_diff roi_bg_in

