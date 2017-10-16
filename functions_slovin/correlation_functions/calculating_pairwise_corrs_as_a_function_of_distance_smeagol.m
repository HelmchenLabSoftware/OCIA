%% 2210e

cd F:\Data\VSDI\Contour_integration\legolas\right_hemisphere\22_10_2008\e\pixelwise
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

