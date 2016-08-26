%% 2912c

cd F:\Data\VSDI\Contour_integration\Smeagol\29Dec2010\c\pixelwise
lim=-0.25:0.025:0.25;
t=1:2;
load coeff_bg_out_circle_cond1
coeff_bg_circ_cond1=mean(coeff_bg_out_circle_cond1(:,:,t),3);
clear coeff_bg_out_circle_cond1
load coeff_bg_out_circle_cond2
coeff_bg_circ_cond2=mean(coeff_bg_out_circle_cond2(:,:,t),3);
clear coeff_bg_out_circle_cond2
load coeff_bg_out_circle_cond4
coeff_bg_circ_cond4=mean(coeff_bg_out_circle_cond4(:,:,t),3);
clear coeff_bg_out_circle_cond4
load coeff_bg_out_circle_cond5
coeff_bg_circ_cond5=mean(coeff_bg_out_circle_cond5(:,:,t),3);
clear coeff_bg_out_circle_cond5
cont_bg_circ=cat(3,coeff_bg_circ_cond1,coeff_bg_circ_cond2);
non_bg_circ=cat(3,coeff_bg_circ_cond4,coeff_bg_circ_cond5);
cont_bg_circ=reshape(cont_bg_circ,[size(cont_bg_circ,1)*size(cont_bg_circ,2) size(cont_bg_circ,3)]);
non_bg_circ=reshape(non_bg_circ,[size(non_bg_circ,1)*size(non_bg_circ,2) size(non_bg_circ,3)]);
[n1 x1]=hist(mean(cont_bg_circ-non_bg_circ,2),lim);
figure;bar(x1,n1/size(cont_bg_circ,1)')
ranksum(mean(cont_bg_circ,2),mean(non_bg_circ,2))
mean(mean(cont_bg_circ-non_bg_circ,2))
signrank(mean(cont_bg_circ-non_bg_circ,2))
signrank(n1)
xlim([-0.3 0.3])



load coeff_circle_cond1
coeff_circ_circ_cond1=mean(coeff_circle_cond1(:,:,t),3);
clear coeff_circle_cond1
load coeff_circle_cond2
coeff_circ_circ_cond2=mean(coeff_circle_cond2(:,:,t),3);
clear coeff_circle_cond2
load coeff_circle_cond4
coeff_circ_circ_cond4=mean(coeff_circle_cond4(:,:,t),3);
clear coeff_circle_cond4
load coeff_circle_cond5
coeff_circ_circ_cond5=mean(coeff_circle_cond5(:,:,t),3);
clear coeff_circle_cond5
cont_circ_circ=cat(3,coeff_circ_circ_cond1,coeff_circ_circ_cond2);
non_circ_circ=cat(3,coeff_circ_circ_cond4,coeff_circ_circ_cond5);
cont_circ_circ=reshape(cont_circ_circ,[size(cont_circ_circ,1)*size(cont_circ_circ,2) size(cont_circ_circ,3)]);
non_circ_circ=reshape(non_circ_circ,[size(non_circ_circ,1)*size(non_circ_circ,2) size(non_circ_circ,3)]);
[n1 x1]=hist(mean(cont_circ_circ-non_circ_circ,2),lim);
figure;bar(x1,n1/size(cont_circ_circ,1)')
ranksum(mean(cont_circ_circ,2),mean(non_circ_circ,2))
mean(mean(cont_circ_circ-non_circ_circ,2))
signrank(mean(cont_circ_circ-non_circ_circ,2))
signrank(n1)
xlim([-0.3 0.3])


load coeff_bg_out_cond1
coeff_bg_bg_cond1=mean(coeff_bg_out_cond1(:,:,t),3);
clear coeff_bg_out_cond1
load coeff_bg_out_cond2
coeff_bg_bg_cond2=mean(coeff_bg_out_cond2(:,:,t),3);
clear coeff_bg_out_cond2
load coeff_bg_out_cond4
coeff_bg_bg_cond4=mean(coeff_bg_out_cond4(:,:,t),3);
clear coeff_bg_out_cond4
load coeff_bg_out_cond5
coeff_bg_bg_cond5=mean(coeff_bg_out_cond5(:,:,t),3);
clear coeff_bg_out_cond5
cont_bg_bg=cat(3,coeff_bg_bg_cond1,coeff_bg_bg_cond2);
non_bg_bg=cat(3,coeff_bg_bg_cond4,coeff_bg_bg_cond5);
cont_bg_bg=reshape(cont_bg_bg,[size(cont_bg_bg,1)*size(cont_bg_bg,2) size(cont_bg_bg,3)]);
non_bg_bg=reshape(non_bg_bg,[size(non_bg_bg,1)*size(non_bg_bg,2) size(non_bg_bg,3)]);
[n1 x1]=hist(mean(cont_bg_bg-non_bg_bg,2),lim);
figure;bar(x1,n1/size(cont_bg_bg,1)')
ranksum(mean(cont_bg_bg,2),mean(non_bg_bg,2))
mean(mean(cont_bg_bg-non_bg_bg,2))
signrank(mean(cont_bg_bg-non_bg_bg,2))
signrank(n1)
xlim([-0.3 0.3])


save corr_bg_circ cont_bg_circ non_bg_circ roi_circle roi_bg_out
save corr_circ_circ cont_circ_circ non_circ_circ roi_circle roi_bg_out
save corr_bg_bg cont_bg_bg non_bg_bg roi_circle roi_bg_out


%% 2912e

cd F:\Data\VSDI\Contour_integration\Smeagol\29Dec2010\e\pixelwise
lim=-0.25:0.025:0.25;
t=9:11;
load coeff_bg_out_circle_cond1
coeff_bg_circ_cond1=mean(coeff_bg_out_circle_cond1(:,:,t),3);
clear coeff_bg_out_circle_cond1
load coeff_bg_out_circle_cond2
coeff_bg_circ_cond2=mean(coeff_bg_out_circle_cond2(:,:,t),3);
clear coeff_bg_out_circle_cond2
load coeff_bg_out_circle_cond4
coeff_bg_circ_cond4=mean(coeff_bg_out_circle_cond4(:,:,t),3);
clear coeff_bg_out_circle_cond4
load coeff_bg_out_circle_cond5
coeff_bg_circ_cond5=mean(coeff_bg_out_circle_cond5(:,:,t),3);
clear coeff_bg_out_circle_cond5
cont_bg_circ=cat(3,coeff_bg_circ_cond1,coeff_bg_circ_cond2);
non_bg_circ=cat(3,coeff_bg_circ_cond4,coeff_bg_circ_cond5);
cont_bg_circ=reshape(cont_bg_circ,[size(cont_bg_circ,1)*size(cont_bg_circ,2) size(cont_bg_circ,3)]);
non_bg_circ=reshape(non_bg_circ,[size(non_bg_circ,1)*size(non_bg_circ,2) size(non_bg_circ,3)]);
[n1 x1]=hist(mean(cont_bg_circ-non_bg_circ,2),lim);
figure;bar(x1,n1/size(cont_bg_circ,1)')
ranksum(mean(cont_bg_circ,2),mean(non_bg_circ,2))
mean(mean(cont_bg_circ-non_bg_circ,2))
signrank(mean(cont_bg_circ-non_bg_circ,2))
signrank(n1)
xlim([-0.3 0.3])



load coeff_circle_cond1
coeff_circ_circ_cond1=mean(coeff_circle_cond1(:,:,t),3);
clear coeff_circle_cond1
load coeff_circle_cond2
coeff_circ_circ_cond2=mean(coeff_circle_cond2(:,:,t),3);
clear coeff_circle_cond2
load coeff_circle_cond4
coeff_circ_circ_cond4=mean(coeff_circle_cond4(:,:,t),3);
clear coeff_circle_cond4
load coeff_circle_cond5
coeff_circ_circ_cond5=mean(coeff_circle_cond5(:,:,t),3);
clear coeff_circle_cond5
cont_circ_circ=cat(3,coeff_circ_circ_cond1,coeff_circ_circ_cond2);
non_circ_circ=cat(3,coeff_circ_circ_cond4,coeff_circ_circ_cond5);
cont_circ_circ=reshape(cont_circ_circ,[size(cont_circ_circ,1)*size(cont_circ_circ,2) size(cont_circ_circ,3)]);
non_circ_circ=reshape(non_circ_circ,[size(non_circ_circ,1)*size(non_circ_circ,2) size(non_circ_circ,3)]);
[n1 x1]=hist(mean(cont_circ_circ-non_circ_circ,2),lim);
figure;bar(x1,n1/size(cont_circ_circ,1)')
ranksum(mean(cont_circ_circ,2),mean(non_circ_circ,2))
mean(mean(cont_circ_circ-non_circ_circ,2))
signrank(mean(cont_circ_circ-non_circ_circ,2))
signrank(n1)
xlim([-0.3 0.3])


load coeff_bg_out_cond1
coeff_bg_bg_cond1=mean(coeff_bg_out_cond1(:,:,t),3);
clear coeff_bg_out_cond1
load coeff_bg_out_cond2
coeff_bg_bg_cond2=mean(coeff_bg_out_cond2(:,:,t),3);
clear coeff_bg_out_cond2
load coeff_bg_out_cond4
coeff_bg_bg_cond4=mean(coeff_bg_out_cond4(:,:,t),3);
clear coeff_bg_out_cond4
load coeff_bg_out_cond5
coeff_bg_bg_cond5=mean(coeff_bg_out_cond5(:,:,t),3);
clear coeff_bg_out_cond5
cont_bg_bg=cat(3,coeff_bg_bg_cond1,coeff_bg_bg_cond2);
non_bg_bg=cat(3,coeff_bg_bg_cond4,coeff_bg_bg_cond5);
cont_bg_bg=reshape(cont_bg_bg,[size(cont_bg_bg,1)*size(cont_bg_bg,2) size(cont_bg_bg,3)]);
non_bg_bg=reshape(non_bg_bg,[size(non_bg_bg,1)*size(non_bg_bg,2) size(non_bg_bg,3)]);
[n1 x1]=hist(mean(cont_bg_bg-non_bg_bg,2),lim);
figure;bar(x1,n1/size(cont_bg_bg,1)')
ranksum(mean(cont_bg_bg,2),mean(non_bg_bg,2))
mean(mean(cont_bg_bg-non_bg_bg,2))
signrank(mean(cont_bg_bg-non_bg_bg,2))
signrank(n1)
xlim([-0.3 0.3])


save corr_bg_circ cont_bg_circ non_bg_circ roi_circle roi_bg_out
save corr_circ_circ cont_circ_circ non_circ_circ roi_circle roi_bg_out
save corr_bg_bg cont_bg_bg non_bg_bg roi_circle roi_bg_out



%% 1711b

cd F:\Data\VSDI\Contour_integration\Smeagol\17Nov2010\b\pixelwise
lim=-0.25:0.025:0.25;
t=6:9;
load coeff_bg_in_circle_cond1
coeff_bg_circ_cond1=mean(coeff_bg_in_circle_cond1(:,:,t),3);
clear coeff_bg_in_circle_cond1
load coeff_bg_in_circle_cond2
coeff_bg_circ_cond2=mean(coeff_bg_in_circle_cond2(:,:,t),3);
clear coeff_bg_in_circle_cond2
load coeff_bg_in_circle_cond4
coeff_bg_circ_cond4=mean(coeff_bg_in_circle_cond4(:,:,t),3);
clear coeff_bg_in_circle_cond4
load coeff_bg_in_circle_cond5
coeff_bg_circ_cond5=mean(coeff_bg_in_circle_cond5(:,:,t),3);
clear coeff_bg_in_circle_cond5
cont_bg_circ=cat(3,coeff_bg_circ_cond1,coeff_bg_circ_cond2);
non_bg_circ=cat(3,coeff_bg_circ_cond4,coeff_bg_circ_cond5);
cont_bg_circ=reshape(cont_bg_circ,[size(cont_bg_circ,1)*size(cont_bg_circ,2) size(cont_bg_circ,3)]);
non_bg_circ=reshape(non_bg_circ,[size(non_bg_circ,1)*size(non_bg_circ,2) size(non_bg_circ,3)]);
[n1 x1]=hist(mean(cont_bg_circ-non_bg_circ,2),lim);
figure;bar(x1,n1/size(cont_bg_circ,1)')
ranksum(mean(cont_bg_circ,2),mean(non_bg_circ,2))
mean(mean(cont_bg_circ-non_bg_circ,2))
signrank(mean(cont_bg_circ-non_bg_circ,2))
signrank(n1)
xlim([-0.3 0.3])



load coeff_circle_cond1
coeff_circ_circ_cond1=mean(coeff_circle_cond1(:,:,t),3);
clear coeff_circle_cond1
load coeff_circle_cond2
coeff_circ_circ_cond2=mean(coeff_circle_cond2(:,:,t),3);
clear coeff_circle_cond2
load coeff_circle_cond4
coeff_circ_circ_cond4=mean(coeff_circle_cond4(:,:,t),3);
clear coeff_circle_cond4
load coeff_circle_cond5
coeff_circ_circ_cond5=mean(coeff_circle_cond5(:,:,t),3);
clear coeff_circle_cond5
cont_circ_circ=cat(3,coeff_circ_circ_cond1,coeff_circ_circ_cond2);
non_circ_circ=cat(3,coeff_circ_circ_cond4,coeff_circ_circ_cond5);
cont_circ_circ=reshape(cont_circ_circ,[size(cont_circ_circ,1)*size(cont_circ_circ,2) size(cont_circ_circ,3)]);
non_circ_circ=reshape(non_circ_circ,[size(non_circ_circ,1)*size(non_circ_circ,2) size(non_circ_circ,3)]);
[n1 x1]=hist(mean(cont_circ_circ-non_circ_circ,2),lim);
figure;bar(x1,n1/size(cont_circ_circ,1)')
ranksum(mean(cont_circ_circ,2),mean(non_circ_circ,2))
mean(mean(cont_circ_circ-non_circ_circ,2))
signrank(mean(cont_circ_circ-non_circ_circ,2))
signrank(n1)
xlim([-0.3 0.3])


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
[n1 x1]=hist(mean(cont_bg_bg-non_bg_bg,2),lim);
figure;bar(x1,n1/size(cont_bg_bg,1)')
ranksum(mean(cont_bg_bg,2),mean(non_bg_bg,2))
mean(mean(cont_bg_bg-non_bg_bg,2))
signrank(mean(cont_bg_bg-non_bg_bg,2))
signrank(n1)
xlim([-0.3 0.3])


save corr_bg_circ cont_bg_circ non_bg_circ roi_circle roi_bg_in
save corr_circ_circ cont_circ_circ non_circ_circ roi_circle roi_bg_in
save corr_bg_bg cont_bg_bg non_bg_bg roi_circle roi_bg_in



%% 1711c

cd F:\Data\VSDI\Contour_integration\Smeagol\17Nov2010\c\pixelwise
lim=-0.25:0.025:0.25;
t=7:9;
load coeff_bg_in_circle_cond1
coeff_bg_circ_cond1=mean(coeff_bg_in_circle_cond1(:,:,t),3);
clear coeff_bg_in_circle_cond1
load coeff_bg_in_circle_cond2
coeff_bg_circ_cond2=mean(coeff_bg_in_circle_cond2(:,:,t),3);
clear coeff_bg_in_circle_cond2
load coeff_bg_in_circle_cond4
coeff_bg_circ_cond4=mean(coeff_bg_in_circle_cond4(:,:,t),3);
clear coeff_bg_in_circle_cond4
load coeff_bg_in_circle_cond5
coeff_bg_circ_cond5=mean(coeff_bg_in_circle_cond5(:,:,t),3);
clear coeff_bg_in_circle_cond5
cont_bg_circ=cat(3,coeff_bg_circ_cond1,coeff_bg_circ_cond2);
non_bg_circ=cat(3,coeff_bg_circ_cond4,coeff_bg_circ_cond5);
cont_bg_circ=reshape(cont_bg_circ,[size(cont_bg_circ,1)*size(cont_bg_circ,2) size(cont_bg_circ,3)]);
non_bg_circ=reshape(non_bg_circ,[size(non_bg_circ,1)*size(non_bg_circ,2) size(non_bg_circ,3)]);
[n1 x1]=hist(mean(cont_bg_circ-non_bg_circ,2),lim);
figure;bar(x1,n1/size(cont_bg_circ,1)')
ranksum(mean(cont_bg_circ,2),mean(non_bg_circ,2))
mean(mean(cont_bg_circ-non_bg_circ,2))
signrank(mean(cont_bg_circ-non_bg_circ,2))
signrank(n1)
xlim([-0.3 0.3])



load coeff_circle_cond1
coeff_circ_circ_cond1=mean(coeff_circle_cond1(:,:,t),3);
clear coeff_circle_cond1
load coeff_circle_cond2
coeff_circ_circ_cond2=mean(coeff_circle_cond2(:,:,t),3);
clear coeff_circle_cond2
load coeff_circle_cond4
coeff_circ_circ_cond4=mean(coeff_circle_cond4(:,:,t),3);
clear coeff_circle_cond4
load coeff_circle_cond5
coeff_circ_circ_cond5=mean(coeff_circle_cond5(:,:,t),3);
clear coeff_circle_cond5
cont_circ_circ=cat(3,coeff_circ_circ_cond1,coeff_circ_circ_cond2);
non_circ_circ=cat(3,coeff_circ_circ_cond4,coeff_circ_circ_cond5);
cont_circ_circ=reshape(cont_circ_circ,[size(cont_circ_circ,1)*size(cont_circ_circ,2) size(cont_circ_circ,3)]);
non_circ_circ=reshape(non_circ_circ,[size(non_circ_circ,1)*size(non_circ_circ,2) size(non_circ_circ,3)]);
[n1 x1]=hist(mean(cont_circ_circ-non_circ_circ,2),lim);
figure;bar(x1,n1/size(cont_circ_circ,1)')
ranksum(mean(cont_circ_circ,2),mean(non_circ_circ,2))
mean(mean(cont_circ_circ-non_circ_circ,2))
signrank(mean(cont_circ_circ-non_circ_circ,2))
signrank(n1)
xlim([-0.3 0.3])


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
[n1 x1]=hist(mean(cont_bg_bg-non_bg_bg,2),lim);
figure;bar(x1,n1/size(cont_bg_bg,1)')
ranksum(mean(cont_bg_bg,2),mean(non_bg_bg,2))
mean(mean(cont_bg_bg-non_bg_bg,2))
signrank(mean(cont_bg_bg-non_bg_bg,2))
signrank(n1)
xlim([-0.3 0.3])


save corr_bg_circ cont_bg_circ non_bg_circ roi_circle roi_bg_in
save corr_circ_circ cont_circ_circ non_circ_circ roi_circle roi_bg_in
save corr_bg_bg cont_bg_bg non_bg_bg roi_circle roi_bg_in


%% 1711g

cd F:\Data\VSDI\Contour_integration\Smeagol\17Nov2010\g\pixelwise
lim=-0.25:0.025:0.25;
t=6:9;
load coeff_bg_in_circle_cond1
coeff_bg_circ_cond1=mean(coeff_bg_in_circle_cond1(:,:,t),3);
clear coeff_bg_in_circle_cond1
load coeff_bg_in_circle_cond2
coeff_bg_circ_cond2=mean(coeff_bg_in_circle_cond2(:,:,t),3);
clear coeff_bg_in_circle_cond2
load coeff_bg_in_circle_cond4
coeff_bg_circ_cond4=mean(coeff_bg_in_circle_cond4(:,:,t),3);
clear coeff_bg_in_circle_cond4
load coeff_bg_in_circle_cond5
coeff_bg_circ_cond5=mean(coeff_bg_in_circle_cond5(:,:,t),3);
clear coeff_bg_in_circle_cond5
cont_bg_circ=cat(3,coeff_bg_circ_cond1,coeff_bg_circ_cond2);
non_bg_circ=cat(3,coeff_bg_circ_cond4,coeff_bg_circ_cond5);
cont_bg_circ=reshape(cont_bg_circ,[size(cont_bg_circ,1)*size(cont_bg_circ,2) size(cont_bg_circ,3)]);
non_bg_circ=reshape(non_bg_circ,[size(non_bg_circ,1)*size(non_bg_circ,2) size(non_bg_circ,3)]);
[n1 x1]=hist(mean(cont_bg_circ-non_bg_circ,2),lim);
figure;bar(x1,n1/size(cont_bg_circ,1)')
ranksum(mean(cont_bg_circ,2),mean(non_bg_circ,2))
mean(mean(cont_bg_circ-non_bg_circ,2))
signrank(mean(cont_bg_circ-non_bg_circ,2))
signrank(n1)
xlim([-0.3 0.3])



load coeff_circle_cond1
coeff_circ_circ_cond1=mean(coeff_circle_cond1(:,:,t),3);
clear coeff_circle_cond1
load coeff_circle_cond2
coeff_circ_circ_cond2=mean(coeff_circle_cond2(:,:,t),3);
clear coeff_circle_cond2
load coeff_circle_cond4
coeff_circ_circ_cond4=mean(coeff_circle_cond4(:,:,t),3);
clear coeff_circle_cond4
load coeff_circle_cond5
coeff_circ_circ_cond5=mean(coeff_circle_cond5(:,:,t),3);
clear coeff_circle_cond5
cont_circ_circ=cat(3,coeff_circ_circ_cond1,coeff_circ_circ_cond2);
non_circ_circ=cat(3,coeff_circ_circ_cond4,coeff_circ_circ_cond5);
cont_circ_circ=reshape(cont_circ_circ,[size(cont_circ_circ,1)*size(cont_circ_circ,2) size(cont_circ_circ,3)]);
non_circ_circ=reshape(non_circ_circ,[size(non_circ_circ,1)*size(non_circ_circ,2) size(non_circ_circ,3)]);
[n1 x1]=hist(mean(cont_circ_circ-non_circ_circ,2),lim);
figure;bar(x1,n1/size(cont_circ_circ,1)')
ranksum(mean(cont_circ_circ,2),mean(non_circ_circ,2))
mean(mean(cont_circ_circ-non_circ_circ,2))
signrank(mean(cont_circ_circ-non_circ_circ,2))
signrank(n1)
xlim([-0.3 0.3])


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
[n1 x1]=hist(mean(cont_bg_bg-non_bg_bg,2),lim);
figure;bar(x1,n1/size(cont_bg_bg,1)')
ranksum(mean(cont_bg_bg,2),mean(non_bg_bg,2))
mean(mean(cont_bg_bg-non_bg_bg,2))
signrank(mean(cont_bg_bg-non_bg_bg,2))
signrank(n1)
xlim([-0.3 0.3])


save corr_bg_circ cont_bg_circ non_bg_circ roi_circle roi_bg_in
save corr_circ_circ cont_circ_circ non_circ_circ roi_circle roi_bg_in
save corr_bg_bg cont_bg_bg non_bg_bg roi_circle roi_bg_in


%% 2411b

cd F:\Data\VSDI\Contour_integration\Smeagol\24Nov2010\b\pixelwise
lim=-0.25:0.025:0.25;
t=4:5;
load coeff_bg_in_circle_cond1
coeff_bg_circ_cond1=mean(coeff_bg_in_circle_cond1(:,:,t),3);
clear coeff_bg_in_circle_cond1
load coeff_bg_in_circle_cond2
coeff_bg_circ_cond2=mean(coeff_bg_in_circle_cond2(:,:,t),3);
clear coeff_bg_in_circle_cond2
load coeff_bg_in_circle_cond4
coeff_bg_circ_cond4=mean(coeff_bg_in_circle_cond4(:,:,t),3);
clear coeff_bg_in_circle_cond4
load coeff_bg_in_circle_cond5
coeff_bg_circ_cond5=mean(coeff_bg_in_circle_cond5(:,:,t),3);
clear coeff_bg_in_circle_cond5
cont_bg_circ=cat(3,coeff_bg_circ_cond1,coeff_bg_circ_cond2);
non_bg_circ=cat(3,coeff_bg_circ_cond4,coeff_bg_circ_cond5);
cont_bg_circ=reshape(cont_bg_circ,[size(cont_bg_circ,1)*size(cont_bg_circ,2) size(cont_bg_circ,3)]);
non_bg_circ=reshape(non_bg_circ,[size(non_bg_circ,1)*size(non_bg_circ,2) size(non_bg_circ,3)]);
[n1 x1]=hist(mean(cont_bg_circ-non_bg_circ,2),lim);
figure;bar(x1,n1/size(cont_bg_circ,1)')
ranksum(mean(cont_bg_circ,2),mean(non_bg_circ,2))
mean(mean(cont_bg_circ-non_bg_circ,2))
signrank(mean(cont_bg_circ-non_bg_circ,2))
signrank(n1)
xlim([-0.3 0.3])



load coeff_circle_cond1
coeff_circ_circ_cond1=mean(coeff_circle_cond1(:,:,t),3);
clear coeff_circle_cond1
load coeff_circle_cond2
coeff_circ_circ_cond2=mean(coeff_circle_cond2(:,:,t),3);
clear coeff_circle_cond2
load coeff_circle_cond4
coeff_circ_circ_cond4=mean(coeff_circle_cond4(:,:,t),3);
clear coeff_circle_cond4
load coeff_circle_cond5
coeff_circ_circ_cond5=mean(coeff_circle_cond5(:,:,t),3);
clear coeff_circle_cond5
cont_circ_circ=cat(3,coeff_circ_circ_cond1,coeff_circ_circ_cond2);
non_circ_circ=cat(3,coeff_circ_circ_cond4,coeff_circ_circ_cond5);
cont_circ_circ=reshape(cont_circ_circ,[size(cont_circ_circ,1)*size(cont_circ_circ,2) size(cont_circ_circ,3)]);
non_circ_circ=reshape(non_circ_circ,[size(non_circ_circ,1)*size(non_circ_circ,2) size(non_circ_circ,3)]);
[n1 x1]=hist(mean(cont_circ_circ-non_circ_circ,2),lim);
figure;bar(x1,n1/size(cont_circ_circ,1)')
ranksum(mean(cont_circ_circ,2),mean(non_circ_circ,2))
mean(mean(cont_circ_circ-non_circ_circ,2))
signrank(mean(cont_circ_circ-non_circ_circ,2))
signrank(n1)
xlim([-0.3 0.3])


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
[n1 x1]=hist(mean(cont_bg_bg-non_bg_bg,2),lim);
figure;bar(x1,n1/size(cont_bg_bg,1)')
ranksum(mean(cont_bg_bg,2),mean(non_bg_bg,2))
mean(mean(cont_bg_bg-non_bg_bg,2))
signrank(mean(cont_bg_bg-non_bg_bg,2))
signrank(n1)
xlim([-0.3 0.3])


save corr_bg_circ cont_bg_circ non_bg_circ roi_circle roi_bg_in
save corr_circ_circ cont_circ_circ non_circ_circ roi_circle roi_bg_in
save corr_bg_bg cont_bg_bg non_bg_bg roi_circle roi_bg_in


%% 2411d

cd F:\Data\VSDI\Contour_integration\Smeagol\24Nov2010\d\pixelwise
lim=-0.25:0.025:0.25;
t=1:4;
load coeff_bg_in_circle_cond1
coeff_bg_circ_cond1=mean(coeff_bg_in_circle_cond1(:,:,t),3);
clear coeff_bg_in_circle_cond1
load coeff_bg_in_circle_cond2
coeff_bg_circ_cond2=mean(coeff_bg_in_circle_cond2(:,:,t),3);
clear coeff_bg_in_circle_cond2
load coeff_bg_in_circle_cond4
coeff_bg_circ_cond4=mean(coeff_bg_in_circle_cond4(:,:,t),3);
clear coeff_bg_in_circle_cond4
load coeff_bg_in_circle_cond5
coeff_bg_circ_cond5=mean(coeff_bg_in_circle_cond5(:,:,t),3);
clear coeff_bg_in_circle_cond5
cont_bg_circ=cat(3,coeff_bg_circ_cond1,coeff_bg_circ_cond2);
non_bg_circ=cat(3,coeff_bg_circ_cond4,coeff_bg_circ_cond5);
cont_bg_circ=reshape(cont_bg_circ,[size(cont_bg_circ,1)*size(cont_bg_circ,2) size(cont_bg_circ,3)]);
non_bg_circ=reshape(non_bg_circ,[size(non_bg_circ,1)*size(non_bg_circ,2) size(non_bg_circ,3)]);
[n1 x1]=hist(mean(cont_bg_circ-non_bg_circ,2),lim);
figure;bar(x1,n1/size(cont_bg_circ,1)')
ranksum(mean(cont_bg_circ,2),mean(non_bg_circ,2))
mean(mean(cont_bg_circ-non_bg_circ,2))
signrank(mean(cont_bg_circ-non_bg_circ,2))
signrank(n1)
xlim([-0.3 0.3])



load coeff_circle_cond1
coeff_circ_circ_cond1=mean(coeff_circle_cond1(:,:,t),3);
clear coeff_circle_cond1
load coeff_circle_cond2
coeff_circ_circ_cond2=mean(coeff_circle_cond2(:,:,t),3);
clear coeff_circle_cond2
load coeff_circle_cond4
coeff_circ_circ_cond4=mean(coeff_circle_cond4(:,:,t),3);
clear coeff_circle_cond4
load coeff_circle_cond5
coeff_circ_circ_cond5=mean(coeff_circle_cond5(:,:,t),3);
clear coeff_circle_cond5
cont_circ_circ=cat(3,coeff_circ_circ_cond1,coeff_circ_circ_cond2);
non_circ_circ=cat(3,coeff_circ_circ_cond4,coeff_circ_circ_cond5);
cont_circ_circ=reshape(cont_circ_circ,[size(cont_circ_circ,1)*size(cont_circ_circ,2) size(cont_circ_circ,3)]);
non_circ_circ=reshape(non_circ_circ,[size(non_circ_circ,1)*size(non_circ_circ,2) size(non_circ_circ,3)]);
[n1 x1]=hist(mean(cont_circ_circ-non_circ_circ,2),lim);
figure;bar(x1,n1/size(cont_circ_circ,1)')
ranksum(mean(cont_circ_circ,2),mean(non_circ_circ,2))
mean(mean(cont_circ_circ-non_circ_circ,2))
signrank(mean(cont_circ_circ-non_circ_circ,2))
signrank(n1)
xlim([-0.3 0.3])


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
[n1 x1]=hist(mean(cont_bg_bg-non_bg_bg,2),lim);
figure;bar(x1,n1/size(cont_bg_bg,1)')
ranksum(mean(cont_bg_bg,2),mean(non_bg_bg,2))
mean(mean(cont_bg_bg-non_bg_bg,2))
signrank(mean(cont_bg_bg-non_bg_bg,2))
signrank(n1)
xlim([-0.3 0.3])


save corr_bg_circ cont_bg_circ non_bg_circ roi_circle roi_bg_in
save corr_circ_circ cont_circ_circ non_circ_circ roi_circle roi_bg_in
save corr_bg_bg cont_bg_bg non_bg_bg roi_circle roi_bg_in



%% 2411f

cd F:\Data\VSDI\Contour_integration\Smeagol\24Nov2010\f\pixelwise
lim=-0.25:0.025:0.25;
t=1:4;
load coeff_bg_in_circle_cond1
coeff_bg_circ_cond1=mean(coeff_bg_in_circle_cond1(:,:,t),3);
clear coeff_bg_in_circle_cond1
load coeff_bg_in_circle_cond2
coeff_bg_circ_cond2=mean(coeff_bg_in_circle_cond2(:,:,t),3);
clear coeff_bg_in_circle_cond2
load coeff_bg_in_circle_cond4
coeff_bg_circ_cond4=mean(coeff_bg_in_circle_cond4(:,:,t),3);
clear coeff_bg_in_circle_cond4
load coeff_bg_in_circle_cond5
coeff_bg_circ_cond5=mean(coeff_bg_in_circle_cond5(:,:,t),3);
clear coeff_bg_in_circle_cond5
cont_bg_circ=cat(3,coeff_bg_circ_cond1,coeff_bg_circ_cond2);
non_bg_circ=cat(3,coeff_bg_circ_cond4,coeff_bg_circ_cond5);
cont_bg_circ=reshape(cont_bg_circ,[size(cont_bg_circ,1)*size(cont_bg_circ,2) size(cont_bg_circ,3)]);
non_bg_circ=reshape(non_bg_circ,[size(non_bg_circ,1)*size(non_bg_circ,2) size(non_bg_circ,3)]);
[n1 x1]=hist(mean(cont_bg_circ-non_bg_circ,2),lim);
figure;bar(x1,n1/size(cont_bg_circ,1)')
ranksum(mean(cont_bg_circ,2),mean(non_bg_circ,2))
mean(mean(cont_bg_circ-non_bg_circ,2))
signrank(mean(cont_bg_circ-non_bg_circ,2))
signrank(n1)
xlim([-0.3 0.3])



load coeff_circle_cond1
coeff_circ_circ_cond1=mean(coeff_circle_cond1(:,:,t),3);
clear coeff_circle_cond1
load coeff_circle_cond2
coeff_circ_circ_cond2=mean(coeff_circle_cond2(:,:,t),3);
clear coeff_circle_cond2
load coeff_circle_cond4
coeff_circ_circ_cond4=mean(coeff_circle_cond4(:,:,t),3);
clear coeff_circle_cond4
load coeff_circle_cond5
coeff_circ_circ_cond5=mean(coeff_circle_cond5(:,:,t),3);
clear coeff_circle_cond5
cont_circ_circ=cat(3,coeff_circ_circ_cond1,coeff_circ_circ_cond2);
non_circ_circ=cat(3,coeff_circ_circ_cond4,coeff_circ_circ_cond5);
cont_circ_circ=reshape(cont_circ_circ,[size(cont_circ_circ,1)*size(cont_circ_circ,2) size(cont_circ_circ,3)]);
non_circ_circ=reshape(non_circ_circ,[size(non_circ_circ,1)*size(non_circ_circ,2) size(non_circ_circ,3)]);
[n1 x1]=hist(mean(cont_circ_circ-non_circ_circ,2),lim);
figure;bar(x1,n1/size(cont_circ_circ,1)')
ranksum(mean(cont_circ_circ,2),mean(non_circ_circ,2))
mean(mean(cont_circ_circ-non_circ_circ,2))
signrank(mean(cont_circ_circ-non_circ_circ,2))
signrank(n1)
xlim([-0.3 0.3])


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
[n1 x1]=hist(mean(cont_bg_bg-non_bg_bg,2),lim);
figure;bar(x1,n1/size(cont_bg_bg,1)')
ranksum(mean(cont_bg_bg,2),mean(non_bg_bg,2))
mean(mean(cont_bg_bg-non_bg_bg,2))
signrank(mean(cont_bg_bg-non_bg_bg,2))
signrank(n1)
xlim([-0.3 0.3])


save corr_bg_circ cont_bg_circ non_bg_circ roi_circle roi_bg_in
save corr_circ_circ cont_circ_circ non_circ_circ roi_circle roi_bg_in
save corr_bg_bg cont_bg_bg non_bg_bg roi_circle roi_bg_in



%% 1412b

cd F:\Data\VSDI\Contour_integration\Smeagol\14Dec2010\b\pixelwise
lim=-0.25:0.025:0.25;
t=6:9;
load coeff_bg_in_circle_cond1
coeff_bg_circ_cond1=mean(coeff_bg_in_circle_cond1(:,:,t),3);
clear coeff_bg_in_circle_cond1
load coeff_bg_in_circle_cond2
coeff_bg_circ_cond2=mean(coeff_bg_in_circle_cond2(:,:,t),3);
clear coeff_bg_in_circle_cond2
load coeff_bg_in_circle_cond4
coeff_bg_circ_cond4=mean(coeff_bg_in_circle_cond4(:,:,t),3);
clear coeff_bg_in_circle_cond4
load coeff_bg_in_circle_cond5
coeff_bg_circ_cond5=mean(coeff_bg_in_circle_cond5(:,:,t),3);
clear coeff_bg_in_circle_cond5
cont_bg_circ=cat(3,coeff_bg_circ_cond1,coeff_bg_circ_cond2);
non_bg_circ=cat(3,coeff_bg_circ_cond4,coeff_bg_circ_cond5);
cont_bg_circ=reshape(cont_bg_circ,[size(cont_bg_circ,1)*size(cont_bg_circ,2) size(cont_bg_circ,3)]);
non_bg_circ=reshape(non_bg_circ,[size(non_bg_circ,1)*size(non_bg_circ,2) size(non_bg_circ,3)]);
[n1 x1]=hist(mean(cont_bg_circ-non_bg_circ,2),lim);
figure;bar(x1,n1/size(cont_bg_circ,1)')
ranksum(mean(cont_bg_circ,2),mean(non_bg_circ,2))
mean(mean(cont_bg_circ-non_bg_circ,2))
signrank(mean(cont_bg_circ-non_bg_circ,2))
signrank(n1)
xlim([-0.3 0.3])



load coeff_circle_cond1
coeff_circ_circ_cond1=mean(coeff_circle_cond1(:,:,t),3);
clear coeff_circle_cond1
load coeff_circle_cond2
coeff_circ_circ_cond2=mean(coeff_circle_cond2(:,:,t),3);
clear coeff_circle_cond2
load coeff_circle_cond4
coeff_circ_circ_cond4=mean(coeff_circle_cond4(:,:,t),3);
clear coeff_circle_cond4
load coeff_circle_cond5
coeff_circ_circ_cond5=mean(coeff_circle_cond5(:,:,t),3);
clear coeff_circle_cond5
cont_circ_circ=cat(3,coeff_circ_circ_cond1,coeff_circ_circ_cond2);
non_circ_circ=cat(3,coeff_circ_circ_cond4,coeff_circ_circ_cond5);
cont_circ_circ=reshape(cont_circ_circ,[size(cont_circ_circ,1)*size(cont_circ_circ,2) size(cont_circ_circ,3)]);
non_circ_circ=reshape(non_circ_circ,[size(non_circ_circ,1)*size(non_circ_circ,2) size(non_circ_circ,3)]);
[n1 x1]=hist(mean(cont_circ_circ-non_circ_circ,2),lim);
figure;bar(x1,n1/size(cont_circ_circ,1)')
ranksum(mean(cont_circ_circ,2),mean(non_circ_circ,2))
mean(mean(cont_circ_circ-non_circ_circ,2))
signrank(mean(cont_circ_circ-non_circ_circ,2))
signrank(n1)
xlim([-0.3 0.3])


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
[n1 x1]=hist(mean(cont_bg_bg-non_bg_bg,2),lim);
figure;bar(x1,n1/size(cont_bg_bg,1)')
ranksum(mean(cont_bg_bg,2),mean(non_bg_bg,2))
mean(mean(cont_bg_bg-non_bg_bg,2))
signrank(mean(cont_bg_bg-non_bg_bg,2))
signrank(n1)
xlim([-0.3 0.3])


save corr_bg_circ cont_bg_circ non_bg_circ roi_circle roi_bg_in
save corr_circ_circ cont_circ_circ non_circ_circ roi_circle roi_bg_in
save corr_bg_bg cont_bg_bg non_bg_bg roi_circle roi_bg_in


%% 1412c

cd F:\Data\VSDI\Contour_integration\Smeagol\14Dec2010\c\pixelwise
lim=-0.25:0.025:0.25;
t=6:11;
load coeff_bg_in_circle_cond1
coeff_bg_circ_cond1=mean(coeff_bg_in_circle_cond1(:,:,t),3);
clear coeff_bg_in_circle_cond1
load coeff_bg_in_circle_cond5
coeff_bg_circ_cond5=mean(coeff_bg_in_circle_cond5(:,:,t),3);
clear coeff_bg_in_circle_cond5
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
xlim([-0.3 0.3])



load coeff_circle_cond1
coeff_circ_circ_cond1=mean(coeff_circle_cond1(:,:,t),3);
clear coeff_circle_cond1
load coeff_circle_cond5
coeff_circ_circ_cond5=mean(coeff_circle_cond5(:,:,t),3);
clear coeff_circle_cond5
cont_circ_circ=coeff_circ_circ_cond1;
non_circ_circ=coeff_circ_circ_cond5;
cont_circ_circ=reshape(cont_circ_circ,[size(cont_circ_circ,1)*size(cont_circ_circ,2) size(cont_circ_circ,3)]);
non_circ_circ=reshape(non_circ_circ,[size(non_circ_circ,1)*size(non_circ_circ,2) size(non_circ_circ,3)]);
[n1 x1]=hist(mean(cont_circ_circ-non_circ_circ,2),lim);
figure;bar(x1,n1/size(cont_circ_circ,1)')
ranksum(mean(cont_circ_circ,2),mean(non_circ_circ,2))
mean(mean(cont_circ_circ-non_circ_circ,2))
signrank(mean(cont_circ_circ-non_circ_circ,2))
signrank(n1)
xlim([-0.3 0.3])


load coeff_bg_in_cond1
coeff_bg_bg_cond1=mean(coeff_bg_in_cond1(:,:,t),3);
clear coeff_bg_in_cond1
load coeff_bg_in_cond5
coeff_bg_bg_cond5=mean(coeff_bg_in_cond5(:,:,t),3);
clear coeff_bg_in_cond5
cont_bg_bg=coeff_bg_bg_cond1;
non_bg_bg=coeff_bg_bg_cond5;
cont_bg_bg=reshape(cont_bg_bg,[size(cont_bg_bg,1)*size(cont_bg_bg,2) size(cont_bg_bg,3)]);
non_bg_bg=reshape(non_bg_bg,[size(non_bg_bg,1)*size(non_bg_bg,2) size(non_bg_bg,3)]);
[n1 x1]=hist(mean(cont_bg_bg-non_bg_bg,2),lim);
figure;bar(x1,n1/size(cont_bg_bg,1)')
ranksum(mean(cont_bg_bg,2),mean(non_bg_bg,2))
mean(mean(cont_bg_bg-non_bg_bg,2))
signrank(mean(cont_bg_bg-non_bg_bg,2))
signrank(n1)
xlim([-0.3 0.3])


save corr_bg_circ cont_bg_circ non_bg_circ roi_circle roi_bg_in
save corr_circ_circ cont_circ_circ non_circ_circ roi_circle roi_bg_in
save corr_bg_bg cont_bg_bg non_bg_bg roi_circle roi_bg_in



%% 1412d

cd F:\Data\VSDI\Contour_integration\Smeagol\14Dec2010\d\pixelwise
lim=-0.25:0.025:0.25;
t=9:10;
load coeff_bg_in_circle_cond1
coeff_bg_circ_cond1=mean(coeff_bg_in_circle_cond1(:,:,t),3);
clear coeff_bg_in_circle_cond1
load coeff_bg_in_circle_cond5
coeff_bg_circ_cond5=mean(coeff_bg_in_circle_cond5(:,:,t),3);
clear coeff_bg_in_circle_cond5
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
xlim([-0.3 0.3])



load coeff_circle_cond1
coeff_circ_circ_cond1=mean(coeff_circle_cond1(:,:,t),3);
clear coeff_circle_cond1
load coeff_circle_cond5
coeff_circ_circ_cond5=mean(coeff_circle_cond5(:,:,t),3);
clear coeff_circle_cond5
cont_circ_circ=coeff_circ_circ_cond1;
non_circ_circ=coeff_circ_circ_cond5;
cont_circ_circ=reshape(cont_circ_circ,[size(cont_circ_circ,1)*size(cont_circ_circ,2) size(cont_circ_circ,3)]);
non_circ_circ=reshape(non_circ_circ,[size(non_circ_circ,1)*size(non_circ_circ,2) size(non_circ_circ,3)]);
[n1 x1]=hist(mean(cont_circ_circ-non_circ_circ,2),lim);
figure;bar(x1,n1/size(cont_circ_circ,1)')
ranksum(mean(cont_circ_circ,2),mean(non_circ_circ,2))
mean(mean(cont_circ_circ-non_circ_circ,2))
signrank(mean(cont_circ_circ-non_circ_circ,2))
signrank(n1)
xlim([-0.3 0.3])


load coeff_bg_in_cond1
coeff_bg_bg_cond1=mean(coeff_bg_in_cond1(:,:,t),3);
clear coeff_bg_in_cond1
load coeff_bg_in_cond5
coeff_bg_bg_cond5=mean(coeff_bg_in_cond5(:,:,t),3);
clear coeff_bg_in_cond5
cont_bg_bg=coeff_bg_bg_cond1;
non_bg_bg=coeff_bg_bg_cond5;
cont_bg_bg=reshape(cont_bg_bg,[size(cont_bg_bg,1)*size(cont_bg_bg,2) size(cont_bg_bg,3)]);
non_bg_bg=reshape(non_bg_bg,[size(non_bg_bg,1)*size(non_bg_bg,2) size(non_bg_bg,3)]);
[n1 x1]=hist(mean(cont_bg_bg-non_bg_bg,2),lim);
figure;bar(x1,n1/size(cont_bg_bg,1)')
ranksum(mean(cont_bg_bg,2),mean(non_bg_bg,2))
mean(mean(cont_bg_bg-non_bg_bg,2))
signrank(mean(cont_bg_bg-non_bg_bg,2))
signrank(n1)
xlim([-0.3 0.3])


save corr_bg_circ cont_bg_circ non_bg_circ roi_circle roi_bg_in
save corr_circ_circ cont_circ_circ non_circ_circ roi_circle roi_bg_in
save corr_bg_bg cont_bg_bg non_bg_bg roi_circle roi_bg_in



%% 1412e

cd F:\Data\VSDI\Contour_integration\Smeagol\14Dec2010\e\pixelwise
lim=-0.25:0.025:0.25;
t=6;
load coeff_bg_in_circle_cond1
coeff_bg_circ_cond1=mean(coeff_bg_in_circle_cond1(:,:,t),3);
clear coeff_bg_in_circle_cond1
load coeff_bg_in_circle_cond5
coeff_bg_circ_cond5=mean(coeff_bg_in_circle_cond5(:,:,t),3);
clear coeff_bg_in_circle_cond5
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
xlim([-0.3 0.3])



load coeff_circle_cond1
coeff_circ_circ_cond1=mean(coeff_circle_cond1(:,:,t),3);
clear coeff_circle_cond1
load coeff_circle_cond5
coeff_circ_circ_cond5=mean(coeff_circle_cond5(:,:,t),3);
clear coeff_circle_cond5
cont_circ_circ=coeff_circ_circ_cond1;
non_circ_circ=coeff_circ_circ_cond5;
cont_circ_circ=reshape(cont_circ_circ,[size(cont_circ_circ,1)*size(cont_circ_circ,2) size(cont_circ_circ,3)]);
non_circ_circ=reshape(non_circ_circ,[size(non_circ_circ,1)*size(non_circ_circ,2) size(non_circ_circ,3)]);
[n1 x1]=hist(mean(cont_circ_circ-non_circ_circ,2),lim);
figure;bar(x1,n1/size(cont_circ_circ,1)')
ranksum(mean(cont_circ_circ,2),mean(non_circ_circ,2))
mean(mean(cont_circ_circ-non_circ_circ,2))
signrank(mean(cont_circ_circ-non_circ_circ,2))
signrank(n1)
xlim([-0.3 0.3])


load coeff_bg_in_cond1
coeff_bg_bg_cond1=mean(coeff_bg_in_cond1(:,:,t),3);
clear coeff_bg_in_cond1
load coeff_bg_in_cond5
coeff_bg_bg_cond5=mean(coeff_bg_in_cond5(:,:,t),3);
clear coeff_bg_in_cond5
cont_bg_bg=coeff_bg_bg_cond1;
non_bg_bg=coeff_bg_bg_cond5;
cont_bg_bg=reshape(cont_bg_bg,[size(cont_bg_bg,1)*size(cont_bg_bg,2) size(cont_bg_bg,3)]);
non_bg_bg=reshape(non_bg_bg,[size(non_bg_bg,1)*size(non_bg_bg,2) size(non_bg_bg,3)]);
[n1 x1]=hist(mean(cont_bg_bg-non_bg_bg,2),lim);
figure;bar(x1,n1/size(cont_bg_bg,1)')
ranksum(mean(cont_bg_bg,2),mean(non_bg_bg,2))
mean(mean(cont_bg_bg-non_bg_bg,2))
signrank(mean(cont_bg_bg-non_bg_bg,2))
signrank(n1)
xlim([-0.3 0.3])


save corr_bg_circ cont_bg_circ non_bg_circ roi_circle roi_bg_in
save corr_circ_circ cont_circ_circ non_circ_circ roi_circle roi_bg_in
save corr_bg_bg cont_bg_bg non_bg_bg roi_circle roi_bg_in



%% 2212b

cd F:\Data\VSDI\Contour_integration\Smeagol\22Dec2010\b\pixelwise
lim=-0.25:0.025:0.25;
t=6:9;
load coeff_bg_in_circle_cond1
coeff_bg_circ_cond1=mean(coeff_bg_in_circle_cond1(:,:,t),3);
clear coeff_bg_in_circle_cond1
load coeff_bg_in_circle_cond2
coeff_bg_circ_cond2=mean(coeff_bg_in_circle_cond2(:,:,t),3);
clear coeff_bg_in_circle_cond2
load coeff_bg_in_circle_cond4
coeff_bg_circ_cond4=mean(coeff_bg_in_circle_cond4(:,:,t),3);
clear coeff_bg_in_circle_cond4
load coeff_bg_in_circle_cond5
coeff_bg_circ_cond5=mean(coeff_bg_in_circle_cond5(:,:,t),3);
clear coeff_bg_in_circle_cond5
cont_bg_circ=cat(3,coeff_bg_circ_cond1,coeff_bg_circ_cond2);
non_bg_circ=cat(3,coeff_bg_circ_cond4,coeff_bg_circ_cond5);
cont_bg_circ=reshape(cont_bg_circ,[size(cont_bg_circ,1)*size(cont_bg_circ,2) size(cont_bg_circ,3)]);
non_bg_circ=reshape(non_bg_circ,[size(non_bg_circ,1)*size(non_bg_circ,2) size(non_bg_circ,3)]);
[n1 x1]=hist(mean(cont_bg_circ-non_bg_circ,2),lim);
figure;bar(x1,n1/size(cont_bg_circ,1)')
ranksum(mean(cont_bg_circ,2),mean(non_bg_circ,2))
mean(mean(cont_bg_circ-non_bg_circ,2))
signrank(mean(cont_bg_circ-non_bg_circ,2))
signrank(n1)
xlim([-0.3 0.3])



load coeff_circle_cond1
coeff_circ_circ_cond1=mean(coeff_circle_cond1(:,:,t),3);
clear coeff_circle_cond1
load coeff_circle_cond2
coeff_circ_circ_cond2=mean(coeff_circle_cond2(:,:,t),3);
clear coeff_circle_cond2
load coeff_circle_cond4
coeff_circ_circ_cond4=mean(coeff_circle_cond4(:,:,t),3);
clear coeff_circle_cond4
load coeff_circle_cond5
coeff_circ_circ_cond5=mean(coeff_circle_cond5(:,:,t),3);
clear coeff_circle_cond5
cont_circ_circ=cat(3,coeff_circ_circ_cond1,coeff_circ_circ_cond2);
non_circ_circ=cat(3,coeff_circ_circ_cond4,coeff_circ_circ_cond5);
cont_circ_circ=reshape(cont_circ_circ,[size(cont_circ_circ,1)*size(cont_circ_circ,2) size(cont_circ_circ,3)]);
non_circ_circ=reshape(non_circ_circ,[size(non_circ_circ,1)*size(non_circ_circ,2) size(non_circ_circ,3)]);
[n1 x1]=hist(mean(cont_circ_circ-non_circ_circ,2),lim);
figure;bar(x1,n1/size(cont_circ_circ,1)')
ranksum(mean(cont_circ_circ,2),mean(non_circ_circ,2))
mean(mean(cont_circ_circ-non_circ_circ,2))
signrank(mean(cont_circ_circ-non_circ_circ,2))
signrank(n1)
xlim([-0.3 0.3])


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
[n1 x1]=hist(mean(cont_bg_bg-non_bg_bg,2),lim);
figure;bar(x1,n1/size(cont_bg_bg,1)')
ranksum(mean(cont_bg_bg,2),mean(non_bg_bg,2))
mean(mean(cont_bg_bg-non_bg_bg,2))
signrank(mean(cont_bg_bg-non_bg_bg,2))
signrank(n1)
xlim([-0.3 0.3])


save corr_bg_circ cont_bg_circ non_bg_circ roi_circle roi_bg_in
save corr_circ_circ cont_circ_circ non_circ_circ roi_circle roi_bg_in
save corr_bg_bg cont_bg_bg non_bg_bg roi_circle roi_bg_in


%% 2212c

cd F:\Data\VSDI\Contour_integration\Smeagol\22Dec2010\c\pixelwise
lim=-0.25:0.025:0.25;
t=2:4;
load coeff_bg_in_circle_cond1
coeff_bg_circ_cond1=mean(coeff_bg_in_circle_cond1(:,:,t),3);
clear coeff_bg_in_circle_cond1
load coeff_bg_in_circle_cond5
coeff_bg_circ_cond5=mean(coeff_bg_in_circle_cond5(:,:,t),3);
clear coeff_bg_in_circle_cond5
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
xlim([-0.3 0.3])



load coeff_circle_cond1
coeff_circ_circ_cond1=mean(coeff_circle_cond1(:,:,t),3);
clear coeff_circle_cond1
load coeff_circle_cond5
coeff_circ_circ_cond5=mean(coeff_circle_cond5(:,:,t),3);
clear coeff_circle_cond5
cont_circ_circ=coeff_circ_circ_cond1;
non_circ_circ=coeff_circ_circ_cond5;
cont_circ_circ=reshape(cont_circ_circ,[size(cont_circ_circ,1)*size(cont_circ_circ,2) size(cont_circ_circ,3)]);
non_circ_circ=reshape(non_circ_circ,[size(non_circ_circ,1)*size(non_circ_circ,2) size(non_circ_circ,3)]);
[n1 x1]=hist(mean(cont_circ_circ-non_circ_circ,2),lim);
figure;bar(x1,n1/size(cont_circ_circ,1)')
ranksum(mean(cont_circ_circ,2),mean(non_circ_circ,2))
mean(mean(cont_circ_circ-non_circ_circ,2))
signrank(mean(cont_circ_circ-non_circ_circ,2))
signrank(n1)
xlim([-0.3 0.3])


load coeff_bg_in_cond1
coeff_bg_bg_cond1=mean(coeff_bg_in_cond1(:,:,t),3);
clear coeff_bg_in_cond1
load coeff_bg_in_cond5
coeff_bg_bg_cond5=mean(coeff_bg_in_cond5(:,:,t),3);
clear coeff_bg_in_cond5
cont_bg_bg=coeff_bg_bg_cond1;
non_bg_bg=coeff_bg_bg_cond5;
cont_bg_bg=reshape(cont_bg_bg,[size(cont_bg_bg,1)*size(cont_bg_bg,2) size(cont_bg_bg,3)]);
non_bg_bg=reshape(non_bg_bg,[size(non_bg_bg,1)*size(non_bg_bg,2) size(non_bg_bg,3)]);
[n1 x1]=hist(mean(cont_bg_bg-non_bg_bg,2),lim);
figure;bar(x1,n1/size(cont_bg_bg,1)')
ranksum(mean(cont_bg_bg,2),mean(non_bg_bg,2))
mean(mean(cont_bg_bg-non_bg_bg,2))
signrank(mean(cont_bg_bg-non_bg_bg,2))
signrank(n1)
xlim([-0.3 0.3])


save corr_bg_circ cont_bg_circ non_bg_circ roi_circle roi_bg_in
save corr_circ_circ cont_circ_circ non_circ_circ roi_circle roi_bg_in
save corr_bg_bg cont_bg_bg non_bg_bg roi_circle roi_bg_in

%% 2212d

cd F:\Data\VSDI\Contour_integration\Smeagol\22Dec2010\d\pixelwise
lim=-0.25:0.025:0.25;
t=1:4;
load coeff_bg_in_circle_cond1
coeff_bg_circ_cond1=mean(coeff_bg_in_circle_cond1(:,:,t),3);
clear coeff_bg_in_circle_cond1
load coeff_bg_in_circle_cond5
coeff_bg_circ_cond5=mean(coeff_bg_in_circle_cond5(:,:,t),3);
clear coeff_bg_in_circle_cond5
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
xlim([-0.3 0.3])



load coeff_circle_cond1
coeff_circ_circ_cond1=mean(coeff_circle_cond1(:,:,t),3);
clear coeff_circle_cond1
load coeff_circle_cond5
coeff_circ_circ_cond5=mean(coeff_circle_cond5(:,:,t),3);
clear coeff_circle_cond5
cont_circ_circ=coeff_circ_circ_cond1;
non_circ_circ=coeff_circ_circ_cond5;
cont_circ_circ=reshape(cont_circ_circ,[size(cont_circ_circ,1)*size(cont_circ_circ,2) size(cont_circ_circ,3)]);
non_circ_circ=reshape(non_circ_circ,[size(non_circ_circ,1)*size(non_circ_circ,2) size(non_circ_circ,3)]);
[n1 x1]=hist(mean(cont_circ_circ-non_circ_circ,2),lim);
figure;bar(x1,n1/size(cont_circ_circ,1)')
ranksum(mean(cont_circ_circ,2),mean(non_circ_circ,2))
mean(mean(cont_circ_circ-non_circ_circ,2))
signrank(mean(cont_circ_circ-non_circ_circ,2))
signrank(n1)
xlim([-0.3 0.3])


load coeff_bg_in_cond1
coeff_bg_bg_cond1=mean(coeff_bg_in_cond1(:,:,t),3);
clear coeff_bg_in_cond1
load coeff_bg_in_cond5
coeff_bg_bg_cond5=mean(coeff_bg_in_cond5(:,:,t),3);
clear coeff_bg_in_cond5
cont_bg_bg=coeff_bg_bg_cond1;
non_bg_bg=coeff_bg_bg_cond5;
cont_bg_bg=reshape(cont_bg_bg,[size(cont_bg_bg,1)*size(cont_bg_bg,2) size(cont_bg_bg,3)]);
non_bg_bg=reshape(non_bg_bg,[size(non_bg_bg,1)*size(non_bg_bg,2) size(non_bg_bg,3)]);
[n1 x1]=hist(mean(cont_bg_bg-non_bg_bg,2),lim);
figure;bar(x1,n1/size(cont_bg_bg,1)')
ranksum(mean(cont_bg_bg,2),mean(non_bg_bg,2))
mean(mean(cont_bg_bg-non_bg_bg,2))
signrank(mean(cont_bg_bg-non_bg_bg,2))
signrank(n1)
xlim([-0.3 0.3])


save corr_bg_circ cont_bg_circ non_bg_circ roi_circle roi_bg_in
save corr_circ_circ cont_circ_circ non_circ_circ roi_circle roi_bg_in
save corr_bg_bg cont_bg_bg non_bg_bg roi_circle roi_bg_in




%% 2912b

cd F:\Data\VSDI\Contour_integration\Smeagol\29Dec2010\b\pixelwise
lim=-0.25:0.025:0.25;
t=6:10;
load coeff_bg_in_circle_cond1
coeff_bg_circ_cond1=mean(coeff_bg_in_circle_cond1(:,:,t),3);
clear coeff_bg_in_circle_cond1
load coeff_bg_in_circle_cond2
coeff_bg_circ_cond2=mean(coeff_bg_in_circle_cond2(:,:,t),3);
clear coeff_bg_in_circle_cond2
load coeff_bg_in_circle_cond4
coeff_bg_circ_cond4=mean(coeff_bg_in_circle_cond4(:,:,t),3);
clear coeff_bg_in_circle_cond4
load coeff_bg_in_circle_cond5
coeff_bg_circ_cond5=mean(coeff_bg_in_circle_cond5(:,:,t),3);
clear coeff_bg_in_circle_cond5
cont_bg_circ=cat(3,coeff_bg_circ_cond1,coeff_bg_circ_cond2);
non_bg_circ=cat(3,coeff_bg_circ_cond4,coeff_bg_circ_cond5);
cont_bg_circ=reshape(cont_bg_circ,[size(cont_bg_circ,1)*size(cont_bg_circ,2) size(cont_bg_circ,3)]);
non_bg_circ=reshape(non_bg_circ,[size(non_bg_circ,1)*size(non_bg_circ,2) size(non_bg_circ,3)]);
[n1 x1]=hist(mean(cont_bg_circ-non_bg_circ,2),lim);
figure;bar(x1,n1/size(cont_bg_circ,1)')
ranksum(mean(cont_bg_circ,2),mean(non_bg_circ,2))
mean(mean(cont_bg_circ-non_bg_circ,2))
signrank(mean(cont_bg_circ-non_bg_circ,2))
signrank(n1)
xlim([-0.3 0.3])



load coeff_circle_cond1
coeff_circ_circ_cond1=mean(coeff_circle_cond1(:,:,t),3);
clear coeff_circle_cond1
load coeff_circle_cond2
coeff_circ_circ_cond2=mean(coeff_circle_cond2(:,:,t),3);
clear coeff_circle_cond2
load coeff_circle_cond4
coeff_circ_circ_cond4=mean(coeff_circle_cond4(:,:,t),3);
clear coeff_circle_cond4
load coeff_circle_cond5
coeff_circ_circ_cond5=mean(coeff_circle_cond5(:,:,t),3);
clear coeff_circle_cond5
cont_circ_circ=cat(3,coeff_circ_circ_cond1,coeff_circ_circ_cond2);
non_circ_circ=cat(3,coeff_circ_circ_cond4,coeff_circ_circ_cond5);
cont_circ_circ=reshape(cont_circ_circ,[size(cont_circ_circ,1)*size(cont_circ_circ,2) size(cont_circ_circ,3)]);
non_circ_circ=reshape(non_circ_circ,[size(non_circ_circ,1)*size(non_circ_circ,2) size(non_circ_circ,3)]);
[n1 x1]=hist(mean(cont_circ_circ-non_circ_circ,2),lim);
figure;bar(x1,n1/size(cont_circ_circ,1)')
ranksum(mean(cont_circ_circ,2),mean(non_circ_circ,2))
mean(mean(cont_circ_circ-non_circ_circ,2))
signrank(mean(cont_circ_circ-non_circ_circ,2))
signrank(n1)
xlim([-0.3 0.3])


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
[n1 x1]=hist(mean(cont_bg_bg-non_bg_bg,2),lim);
figure;bar(x1,n1/size(cont_bg_bg,1)')
ranksum(mean(cont_bg_bg,2),mean(non_bg_bg,2))
mean(mean(cont_bg_bg-non_bg_bg,2))
signrank(mean(cont_bg_bg-non_bg_bg,2))
signrank(n1)
xlim([-0.3 0.3])


save corr_bg_circ cont_bg_circ non_bg_circ roi_circle roi_bg_in
save corr_circ_circ cont_circ_circ non_circ_circ roi_circle roi_bg_in
save corr_bg_bg cont_bg_bg non_bg_bg roi_circle roi_bg_in





%% 2912d

cd F:\Data\VSDI\Contour_integration\Smeagol\29Dec2010\d\pixelwise
lim=-0.25:0.025:0.25;
t=4:6;
load coeff_bg_in_circle_cond1
coeff_bg_circ_cond1=mean(coeff_bg_in_circle_cond1(:,:,t),3);
clear coeff_bg_in_circle_cond1
load coeff_bg_in_circle_cond2
coeff_bg_circ_cond2=mean(coeff_bg_in_circle_cond2(:,:,t),3);
clear coeff_bg_in_circle_cond2
load coeff_bg_in_circle_cond4
coeff_bg_circ_cond4=mean(coeff_bg_in_circle_cond4(:,:,t),3);
clear coeff_bg_in_circle_cond4
load coeff_bg_in_circle_cond5
coeff_bg_circ_cond5=mean(coeff_bg_in_circle_cond5(:,:,t),3);
clear coeff_bg_in_circle_cond5
cont_bg_circ=cat(3,coeff_bg_circ_cond1,coeff_bg_circ_cond2);
non_bg_circ=cat(3,coeff_bg_circ_cond4,coeff_bg_circ_cond5);
cont_bg_circ=reshape(cont_bg_circ,[size(cont_bg_circ,1)*size(cont_bg_circ,2) size(cont_bg_circ,3)]);
non_bg_circ=reshape(non_bg_circ,[size(non_bg_circ,1)*size(non_bg_circ,2) size(non_bg_circ,3)]);
[n1 x1]=hist(mean(cont_bg_circ-non_bg_circ,2),lim);
figure;bar(x1,n1/size(cont_bg_circ,1)')
ranksum(mean(cont_bg_circ,2),mean(non_bg_circ,2))
mean(mean(cont_bg_circ-non_bg_circ,2))
signrank(mean(cont_bg_circ-non_bg_circ,2))
signrank(n1)
xlim([-0.3 0.3])



load coeff_circle_cond1
coeff_circ_circ_cond1=mean(coeff_circle_cond1(:,:,t),3);
clear coeff_circle_cond1
load coeff_circle_cond2
coeff_circ_circ_cond2=mean(coeff_circle_cond2(:,:,t),3);
clear coeff_circle_cond2
load coeff_circle_cond4
coeff_circ_circ_cond4=mean(coeff_circle_cond4(:,:,t),3);
clear coeff_circle_cond4
load coeff_circle_cond5
coeff_circ_circ_cond5=mean(coeff_circle_cond5(:,:,t),3);
clear coeff_circle_cond5
cont_circ_circ=cat(3,coeff_circ_circ_cond1,coeff_circ_circ_cond2);
non_circ_circ=cat(3,coeff_circ_circ_cond4,coeff_circ_circ_cond5);
cont_circ_circ=reshape(cont_circ_circ,[size(cont_circ_circ,1)*size(cont_circ_circ,2) size(cont_circ_circ,3)]);
non_circ_circ=reshape(non_circ_circ,[size(non_circ_circ,1)*size(non_circ_circ,2) size(non_circ_circ,3)]);
[n1 x1]=hist(mean(cont_circ_circ-non_circ_circ,2),lim);
figure;bar(x1,n1/size(cont_circ_circ,1)')
ranksum(mean(cont_circ_circ,2),mean(non_circ_circ,2))
mean(mean(cont_circ_circ-non_circ_circ,2))
signrank(mean(cont_circ_circ-non_circ_circ,2))
signrank(n1)
xlim([-0.3 0.3])


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
[n1 x1]=hist(mean(cont_bg_bg-non_bg_bg,2),lim);
figure;bar(x1,n1/size(cont_bg_bg,1)')
ranksum(mean(cont_bg_bg,2),mean(non_bg_bg,2))
mean(mean(cont_bg_bg-non_bg_bg,2))
signrank(mean(cont_bg_bg-non_bg_bg,2))
signrank(n1)
xlim([-0.3 0.3])


save corr_bg_circ cont_bg_circ non_bg_circ roi_circle roi_bg_in
save corr_circ_circ cont_circ_circ non_circ_circ roi_circle roi_bg_in
save corr_bg_bg cont_bg_bg non_bg_bg roi_circle roi_bg_in




%% 0501e

cd F:\Data\VSDI\Contour_integration\Smeagol\05Jan2011\e\pixelwise
lim=-0.25:0.025:0.25;
t=9:11;
load coeff_bg_in_circle_cond1
coeff_bg_circ_cond1=mean(coeff_bg_in_circle_cond1(:,:,t),3);
clear coeff_bg_in_circle_cond1
load coeff_bg_in_circle_cond2
coeff_bg_circ_cond2=mean(coeff_bg_in_circle_cond2(:,:,t),3);
clear coeff_bg_in_circle_cond2
load coeff_bg_in_circle_cond4
coeff_bg_circ_cond4=mean(coeff_bg_in_circle_cond4(:,:,t),3);
clear coeff_bg_in_circle_cond4
load coeff_bg_in_circle_cond5
coeff_bg_circ_cond5=mean(coeff_bg_in_circle_cond5(:,:,t),3);
clear coeff_bg_in_circle_cond5
cont_bg_circ=cat(3,coeff_bg_circ_cond1,coeff_bg_circ_cond2);
non_bg_circ=cat(3,coeff_bg_circ_cond4,coeff_bg_circ_cond5);
cont_bg_circ=reshape(cont_bg_circ,[size(cont_bg_circ,1)*size(cont_bg_circ,2) size(cont_bg_circ,3)]);
non_bg_circ=reshape(non_bg_circ,[size(non_bg_circ,1)*size(non_bg_circ,2) size(non_bg_circ,3)]);
[n1 x1]=hist(mean(cont_bg_circ-non_bg_circ,2),lim);
figure;bar(x1,n1/size(cont_bg_circ,1)')
ranksum(mean(cont_bg_circ,2),mean(non_bg_circ,2))
mean(mean(cont_bg_circ-non_bg_circ,2))
signrank(mean(cont_bg_circ-non_bg_circ,2))
signrank(n1)
xlim([-0.3 0.3])



load coeff_circle_cond1
coeff_circ_circ_cond1=mean(coeff_circle_cond1(:,:,t),3);
clear coeff_circle_cond1
load coeff_circle_cond2
coeff_circ_circ_cond2=mean(coeff_circle_cond2(:,:,t),3);
clear coeff_circle_cond2
load coeff_circle_cond4
coeff_circ_circ_cond4=mean(coeff_circle_cond4(:,:,t),3);
clear coeff_circle_cond4
load coeff_circle_cond5
coeff_circ_circ_cond5=mean(coeff_circle_cond5(:,:,t),3);
clear coeff_circle_cond5
cont_circ_circ=cat(3,coeff_circ_circ_cond1,coeff_circ_circ_cond2);
non_circ_circ=cat(3,coeff_circ_circ_cond4,coeff_circ_circ_cond5);
cont_circ_circ=reshape(cont_circ_circ,[size(cont_circ_circ,1)*size(cont_circ_circ,2) size(cont_circ_circ,3)]);
non_circ_circ=reshape(non_circ_circ,[size(non_circ_circ,1)*size(non_circ_circ,2) size(non_circ_circ,3)]);
[n1 x1]=hist(mean(cont_circ_circ-non_circ_circ,2),lim);
figure;bar(x1,n1/size(cont_circ_circ,1)')
ranksum(mean(cont_circ_circ,2),mean(non_circ_circ,2))
mean(mean(cont_circ_circ-non_circ_circ,2))
signrank(mean(cont_circ_circ-non_circ_circ,2))
signrank(n1)
xlim([-0.3 0.3])


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
[n1 x1]=hist(mean(cont_bg_bg-non_bg_bg,2),lim);
figure;bar(x1,n1/size(cont_bg_bg,1)')
ranksum(mean(cont_bg_bg,2),mean(non_bg_bg,2))
mean(mean(cont_bg_bg-non_bg_bg,2))
signrank(mean(cont_bg_bg-non_bg_bg,2))
signrank(n1)
xlim([-0.3 0.3])


save corr_bg_circ cont_bg_circ non_bg_circ roi_circle roi_bg_in
save corr_circ_circ cont_circ_circ non_circ_circ roi_circle roi_bg_in
save corr_bg_bg cont_bg_bg non_bg_bg roi_circle roi_bg_in






%% 2912k

cd F:\Data\VSDI\Contour_integration\Smeagol\29Dec2010\k\pixelwise
lim=-0.25:0.025:0.25;
t=6:9;
load coeff_bg_out_circle_cond1
coeff_bg_circ_cond1=mean(coeff_bg_out_circle_cond1(:,:,t),3);
clear coeff_bg_out_circle_cond1
load coeff_bg_out_circle_cond2
coeff_bg_circ_cond2=mean(coeff_bg_out_circle_cond2(:,:,t),3);
clear coeff_bg_out_circle_cond2
load coeff_bg_out_circle_cond4
coeff_bg_circ_cond4=mean(coeff_bg_out_circle_cond4(:,:,t),3);
clear coeff_bg_out_circle_cond4
load coeff_bg_out_circle_cond5
coeff_bg_circ_cond5=mean(coeff_bg_out_circle_cond5(:,:,t),3);
clear coeff_bg_out_circle_cond5
cont_bg_circ=cat(3,coeff_bg_circ_cond1,coeff_bg_circ_cond2);
non_bg_circ=cat(3,coeff_bg_circ_cond4,coeff_bg_circ_cond5);
cont_bg_circ=reshape(cont_bg_circ,[size(cont_bg_circ,1)*size(cont_bg_circ,2) size(cont_bg_circ,3)]);
non_bg_circ=reshape(non_bg_circ,[size(non_bg_circ,1)*size(non_bg_circ,2) size(non_bg_circ,3)]);
[n1 x1]=hist(mean(cont_bg_circ-non_bg_circ,2),lim);
figure;bar(x1,n1/size(cont_bg_circ,1)')
ranksum(mean(cont_bg_circ,2),mean(non_bg_circ,2))
mean(mean(cont_bg_circ-non_bg_circ,2))
signrank(mean(cont_bg_circ-non_bg_circ,2))
signrank(n1)
xlim([-0.3 0.3])



load coeff_circle_cond1
coeff_circ_circ_cond1=mean(coeff_circle_cond1(:,:,t),3);
clear coeff_circle_cond1
load coeff_circle_cond2
coeff_circ_circ_cond2=mean(coeff_circle_cond2(:,:,t),3);
clear coeff_circle_cond2
load coeff_circle_cond4
coeff_circ_circ_cond4=mean(coeff_circle_cond4(:,:,t),3);
clear coeff_circle_cond4
load coeff_circle_cond5
coeff_circ_circ_cond5=mean(coeff_circle_cond5(:,:,t),3);
clear coeff_circle_cond5
cont_circ_circ=cat(3,coeff_circ_circ_cond1,coeff_circ_circ_cond2);
non_circ_circ=cat(3,coeff_circ_circ_cond4,coeff_circ_circ_cond5);
cont_circ_circ=reshape(cont_circ_circ,[size(cont_circ_circ,1)*size(cont_circ_circ,2) size(cont_circ_circ,3)]);
non_circ_circ=reshape(non_circ_circ,[size(non_circ_circ,1)*size(non_circ_circ,2) size(non_circ_circ,3)]);
[n1 x1]=hist(mean(cont_circ_circ-non_circ_circ,2),lim);
figure;bar(x1,n1/size(cont_circ_circ,1)')
ranksum(mean(cont_circ_circ,2),mean(non_circ_circ,2))
mean(mean(cont_circ_circ-non_circ_circ,2))
signrank(mean(cont_circ_circ-non_circ_circ,2))
signrank(n1)
xlim([-0.3 0.3])


load coeff_bg_out_cond1
coeff_bg_bg_cond1=mean(coeff_bg_out_cond1(:,:,t),3);
clear coeff_bg_out_cond1
load coeff_bg_out_cond2
coeff_bg_bg_cond2=mean(coeff_bg_out_cond2(:,:,t),3);
clear coeff_bg_out_cond2
load coeff_bg_out_cond4
coeff_bg_bg_cond4=mean(coeff_bg_out_cond4(:,:,t),3);
clear coeff_bg_out_cond4
load coeff_bg_out_cond5
coeff_bg_bg_cond5=mean(coeff_bg_out_cond5(:,:,t),3);
clear coeff_bg_out_cond5
cont_bg_bg=cat(3,coeff_bg_bg_cond1,coeff_bg_bg_cond2);
non_bg_bg=cat(3,coeff_bg_bg_cond4,coeff_bg_bg_cond5);
cont_bg_bg=reshape(cont_bg_bg,[size(cont_bg_bg,1)*size(cont_bg_bg,2) size(cont_bg_bg,3)]);
non_bg_bg=reshape(non_bg_bg,[size(non_bg_bg,1)*size(non_bg_bg,2) size(non_bg_bg,3)]);
[n1 x1]=hist(mean(cont_bg_bg-non_bg_bg,2),lim);
figure;bar(x1,n1/size(cont_bg_bg,1)')
ranksum(mean(cont_bg_bg,2),mean(non_bg_bg,2))
mean(mean(cont_bg_bg-non_bg_bg,2))
signrank(mean(cont_bg_bg-non_bg_bg,2))
signrank(n1)
xlim([-0.3 0.3])


save corr_bg_circ cont_bg_circ non_bg_circ roi_circle roi_bg_out
save corr_circ_circ cont_circ_circ non_circ_circ roi_circle roi_bg_out
save corr_bg_bg cont_bg_bg non_bg_bg roi_circle roi_bg_out




%% 0501b

cd F:\Data\VSDI\Contour_integration\Smeagol\05Jan2011\b\pixelwise
lim=-0.25:0.025:0.25;
t=6:9;
load coeff_bg_out_circle_cond1
coeff_bg_circ_cond1=mean(coeff_bg_out_circle_cond1(:,:,t),3);
clear coeff_bg_out_circle_cond1
load coeff_bg_out_circle_cond2
coeff_bg_circ_cond2=mean(coeff_bg_out_circle_cond2(:,:,t),3);
clear coeff_bg_out_circle_cond2
load coeff_bg_out_circle_cond4
coeff_bg_circ_cond4=mean(coeff_bg_out_circle_cond4(:,:,t),3);
clear coeff_bg_out_circle_cond4
load coeff_bg_out_circle_cond5
coeff_bg_circ_cond5=mean(coeff_bg_out_circle_cond5(:,:,t),3);
clear coeff_bg_out_circle_cond5
cont_bg_circ=cat(3,coeff_bg_circ_cond1,coeff_bg_circ_cond2);
non_bg_circ=cat(3,coeff_bg_circ_cond4,coeff_bg_circ_cond5);
cont_bg_circ=reshape(cont_bg_circ,[size(cont_bg_circ,1)*size(cont_bg_circ,2) size(cont_bg_circ,3)]);
non_bg_circ=reshape(non_bg_circ,[size(non_bg_circ,1)*size(non_bg_circ,2) size(non_bg_circ,3)]);
[n1 x1]=hist(mean(cont_bg_circ-non_bg_circ,2),lim);
figure;bar(x1,n1/size(cont_bg_circ,1)')
ranksum(mean(cont_bg_circ,2),mean(non_bg_circ,2))
mean(mean(cont_bg_circ-non_bg_circ,2))
signrank(mean(cont_bg_circ-non_bg_circ,2))
signrank(n1)
xlim([-0.3 0.3])



load coeff_circle_cond1
coeff_circ_circ_cond1=mean(coeff_circle_cond1(:,:,t),3);
clear coeff_circle_cond1
load coeff_circle_cond2
coeff_circ_circ_cond2=mean(coeff_circle_cond2(:,:,t),3);
clear coeff_circle_cond2
load coeff_circle_cond4
coeff_circ_circ_cond4=mean(coeff_circle_cond4(:,:,t),3);
clear coeff_circle_cond4
load coeff_circle_cond5
coeff_circ_circ_cond5=mean(coeff_circle_cond5(:,:,t),3);
clear coeff_circle_cond5
cont_circ_circ=cat(3,coeff_circ_circ_cond1,coeff_circ_circ_cond2);
non_circ_circ=cat(3,coeff_circ_circ_cond4,coeff_circ_circ_cond5);
cont_circ_circ=reshape(cont_circ_circ,[size(cont_circ_circ,1)*size(cont_circ_circ,2) size(cont_circ_circ,3)]);
non_circ_circ=reshape(non_circ_circ,[size(non_circ_circ,1)*size(non_circ_circ,2) size(non_circ_circ,3)]);
[n1 x1]=hist(mean(cont_circ_circ-non_circ_circ,2),lim);
figure;bar(x1,n1/size(cont_circ_circ,1)')
ranksum(mean(cont_circ_circ,2),mean(non_circ_circ,2))
mean(mean(cont_circ_circ-non_circ_circ,2))
signrank(mean(cont_circ_circ-non_circ_circ,2))
signrank(n1)
xlim([-0.3 0.3])


load coeff_bg_out_cond1
coeff_bg_bg_cond1=mean(coeff_bg_out_cond1(:,:,t),3);
clear coeff_bg_out_cond1
load coeff_bg_out_cond2
coeff_bg_bg_cond2=mean(coeff_bg_out_cond2(:,:,t),3);
clear coeff_bg_out_cond2
load coeff_bg_out_cond4
coeff_bg_bg_cond4=mean(coeff_bg_out_cond4(:,:,t),3);
clear coeff_bg_out_cond4
load coeff_bg_out_cond5
coeff_bg_bg_cond5=mean(coeff_bg_out_cond5(:,:,t),3);
clear coeff_bg_out_cond5
cont_bg_bg=cat(3,coeff_bg_bg_cond1,coeff_bg_bg_cond2);
non_bg_bg=cat(3,coeff_bg_bg_cond4,coeff_bg_bg_cond5);
cont_bg_bg=reshape(cont_bg_bg,[size(cont_bg_bg,1)*size(cont_bg_bg,2) size(cont_bg_bg,3)]);
non_bg_bg=reshape(non_bg_bg,[size(non_bg_bg,1)*size(non_bg_bg,2) size(non_bg_bg,3)]);
[n1 x1]=hist(mean(cont_bg_bg-non_bg_bg,2),lim);
figure;bar(x1,n1/size(cont_bg_bg,1)')
ranksum(mean(cont_bg_bg,2),mean(non_bg_bg,2))
mean(mean(cont_bg_bg-non_bg_bg,2))
signrank(mean(cont_bg_bg-non_bg_bg,2))
signrank(n1)
xlim([-0.3 0.3])


save corr_bg_circ cont_bg_circ non_bg_circ roi_circle roi_bg_out
save corr_circ_circ cont_circ_circ non_circ_circ roi_circle roi_bg_out
save corr_bg_bg cont_bg_bg non_bg_bg roi_circle roi_bg_out





%% 0501c

cd F:\Data\VSDI\Contour_integration\Smeagol\05Jan2011\c\pixelwise
lim=-0.25:0.025:0.25;
t=3:5;
load coeff_bg_out_circle_cond1
coeff_bg_circ_cond1=mean(coeff_bg_out_circle_cond1(:,:,t),3);
clear coeff_bg_out_circle_cond1
load coeff_bg_out_circle_cond5
coeff_bg_circ_cond5=mean(coeff_bg_out_circle_cond5(:,:,t),3);
clear coeff_bg_out_circle_cond5
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
xlim([-0.3 0.3])



load coeff_circle_cond1
coeff_circ_circ_cond1=mean(coeff_circle_cond1(:,:,t),3);
clear coeff_circle_cond1
load coeff_circle_cond5
coeff_circ_circ_cond5=mean(coeff_circle_cond5(:,:,t),3);
clear coeff_circle_cond5
cont_circ_circ=coeff_circ_circ_cond1;
non_circ_circ=coeff_circ_circ_cond5;
cont_circ_circ=reshape(cont_circ_circ,[size(cont_circ_circ,1)*size(cont_circ_circ,2) size(cont_circ_circ,3)]);
non_circ_circ=reshape(non_circ_circ,[size(non_circ_circ,1)*size(non_circ_circ,2) size(non_circ_circ,3)]);
[n1 x1]=hist(mean(cont_circ_circ-non_circ_circ,2),lim);
figure;bar(x1,n1/size(cont_circ_circ,1)')
ranksum(mean(cont_circ_circ,2),mean(non_circ_circ,2))
mean(mean(cont_circ_circ-non_circ_circ,2))
signrank(mean(cont_circ_circ-non_circ_circ,2))
signrank(n1)
xlim([-0.3 0.3])


load coeff_bg_out_cond1
coeff_bg_bg_cond1=mean(coeff_bg_out_cond1(:,:,t),3);
clear coeff_bg_out_cond1
load coeff_bg_out_cond5
coeff_bg_bg_cond5=mean(coeff_bg_out_cond5(:,:,t),3);
clear coeff_bg_out_cond5
cont_bg_bg=coeff_bg_bg_cond1;
non_bg_bg=coeff_bg_bg_cond5;
cont_bg_bg=reshape(cont_bg_bg,[size(cont_bg_bg,1)*size(cont_bg_bg,2) size(cont_bg_bg,3)]);
non_bg_bg=reshape(non_bg_bg,[size(non_bg_bg,1)*size(non_bg_bg,2) size(non_bg_bg,3)]);
[n1 x1]=hist(mean(cont_bg_bg-non_bg_bg,2),lim);
figure;bar(x1,n1/size(cont_bg_bg,1)')
ranksum(mean(cont_bg_bg,2),mean(non_bg_bg,2))
mean(mean(cont_bg_bg-non_bg_bg,2))
signrank(mean(cont_bg_bg-non_bg_bg,2))
signrank(n1)
xlim([-0.3 0.3])


save corr_bg_circ cont_bg_circ non_bg_circ roi_circle roi_bg_out
save corr_circ_circ cont_circ_circ non_circ_circ roi_circle roi_bg_out
save corr_bg_bg cont_bg_bg non_bg_bg roi_circle roi_bg_out




%% 0501d

cd F:\Data\VSDI\Contour_integration\Smeagol\05Jan2011\d\pixelwise
lim=-0.25:0.025:0.25;
t=3:6;
load coeff_bg_out_circle_cond1
coeff_bg_circ_cond1=mean(coeff_bg_out_circle_cond1(:,:,t),3);
clear coeff_bg_out_circle_cond1
load coeff_bg_out_circle_cond5
coeff_bg_circ_cond5=mean(coeff_bg_out_circle_cond5(:,:,t),3);
clear coeff_bg_out_circle_cond5
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
xlim([-0.3 0.3])



load coeff_circle_cond1
coeff_circ_circ_cond1=mean(coeff_circle_cond1(:,:,t),3);
clear coeff_circle_cond1
load coeff_circle_cond5
coeff_circ_circ_cond5=mean(coeff_circle_cond5(:,:,t),3);
clear coeff_circle_cond5
cont_circ_circ=coeff_circ_circ_cond1;
non_circ_circ=coeff_circ_circ_cond5;
cont_circ_circ=reshape(cont_circ_circ,[size(cont_circ_circ,1)*size(cont_circ_circ,2) size(cont_circ_circ,3)]);
non_circ_circ=reshape(non_circ_circ,[size(non_circ_circ,1)*size(non_circ_circ,2) size(non_circ_circ,3)]);
[n1 x1]=hist(mean(cont_circ_circ-non_circ_circ,2),lim);
figure;bar(x1,n1/size(cont_circ_circ,1)')
ranksum(mean(cont_circ_circ,2),mean(non_circ_circ,2))
mean(mean(cont_circ_circ-non_circ_circ,2))
signrank(mean(cont_circ_circ-non_circ_circ,2))
signrank(n1)
xlim([-0.3 0.3])


load coeff_bg_out_cond1
coeff_bg_bg_cond1=mean(coeff_bg_out_cond1(:,:,t),3);
clear coeff_bg_out_cond1
load coeff_bg_out_cond5
coeff_bg_bg_cond5=mean(coeff_bg_out_cond5(:,:,t),3);
clear coeff_bg_out_cond5
cont_bg_bg=coeff_bg_bg_cond1;
non_bg_bg=coeff_bg_bg_cond5;
cont_bg_bg=reshape(cont_bg_bg,[size(cont_bg_bg,1)*size(cont_bg_bg,2) size(cont_bg_bg,3)]);
non_bg_bg=reshape(non_bg_bg,[size(non_bg_bg,1)*size(non_bg_bg,2) size(non_bg_bg,3)]);
[n1 x1]=hist(mean(cont_bg_bg-non_bg_bg,2),lim);
figure;bar(x1,n1/size(cont_bg_bg,1)')
ranksum(mean(cont_bg_bg,2),mean(non_bg_bg,2))
mean(mean(cont_bg_bg-non_bg_bg,2))
signrank(mean(cont_bg_bg-non_bg_bg,2))
signrank(n1)
xlim([-0.3 0.3])


save corr_bg_circ cont_bg_circ non_bg_circ roi_circle roi_bg_out
save corr_circ_circ cont_circ_circ non_circ_circ roi_circle roi_bg_out
save corr_bg_bg cont_bg_bg non_bg_bg roi_circle roi_bg_out




