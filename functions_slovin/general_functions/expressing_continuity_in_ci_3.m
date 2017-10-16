
diff=a-b;
circ_gabors_s1_1111c14=mean(mean(diff([roi_f1late;roi_tar;roi_f2],32:42)));
circ_gabors_s2_1111c14=mean(mean(diff([roi_f1late;roi_tar;roi_f2],43:53)));
circ_between_s1_1111c14=mean(mean(diff(bet_cont,32:42)));
circ_between_s2_1111c14=mean(mean(diff(bet_cont,43:53)));

bg_gabors_s1_1111c14=mean(mean(diff([roi_f3;roi_f4;roi_f5],32:42)));
bg_gabors_s2_1111c14=mean(mean(diff([roi_f3;roi_f4;roi_f5],43:53)));
bg_between_s1_1111c14=mean(mean(diff(bet_bg,32:42)));
bg_between_s2_1111c14=mean(mean(diff(bet_bg,43:53)));

diff=a-b;
circ_gabors_s1_1111c25=mean(mean(diff([roi_f1late;roi_tar;roi_f2],32:42)));
circ_gabors_s2_1111c25=mean(mean(diff([roi_f1late;roi_tar;roi_f2],43:53)));
circ_between_s1_1111c25=mean(mean(diff(bet_cont,32:42)));
circ_between_s2_1111c25=mean(mean(diff(bet_cont,43:53)));

bg_gabors_s1_1111c25=mean(mean(diff([roi_f3;roi_f4;roi_f5],32:42)));
bg_gabors_s2_1111c25=mean(mean(diff([roi_f3;roi_f4;roi_f5],43:53)));
bg_between_s1_1111c25=mean(mean(diff(bet_bg,32:42)));
bg_between_s2_1111c25=mean(mean(diff(bet_bg,43:53)));


diff=a-b;
circ_gabors_s1_1111d14=mean(mean(diff([roi_f1late;roi_tar;roi_f2],32:42)));
circ_gabors_s2_1111d14=mean(mean(diff([roi_f1late;roi_tar;roi_f2],43:53)));
circ_between_s1_1111d14=mean(mean(diff(bet_cont,32:42)));
circ_between_s2_1111d14=mean(mean(diff(bet_cont,43:53)));

bg_gabors_s1_1111d14=mean(mean(diff([roi_f3;roi_f4;roi_f5],32:42)));
bg_gabors_s2_1111d14=mean(mean(diff([roi_f3;roi_f4;roi_f5],43:53)));
bg_between_s1_1111d14=mean(mean(diff(bet_bg,32:42)));
bg_between_s2_1111d14=mean(mean(diff(bet_bg,43:53)));

diff=a-b;
circ_gabors_s1_1111d25=mean(mean(diff([roi_f1late;roi_tar;roi_f2],32:42)));
circ_gabors_s2_1111d25=mean(mean(diff([roi_f1late;roi_tar;roi_f2],43:53)));
circ_between_s1_1111d25=mean(mean(diff(bet_cont,32:42)));
circ_between_s2_1111d25=mean(mean(diff(bet_cont,43:53)));

bg_gabors_s1_1111d25=mean(mean(diff([roi_f3;roi_f4;roi_f5],32:42)));
bg_gabors_s2_1111d25=mean(mean(diff([roi_f3;roi_f4;roi_f5],43:53)));
bg_between_s1_1111d25=mean(mean(diff(bet_bg,32:42)));
bg_between_s2_1111d25=mean(mean(diff(bet_bg,43:53)));


%%


circ_gabor_s1(1)=circ_gabors_s1_1111c14;
circ_gabor_s1(2)=circ_gabors_s1_1111c25;
circ_gabor_s1(3)=circ_gabors_s1_1111d14;
circ_gabor_s1(4)=circ_gabors_s1_1111d25;

circ_gabor_s2(1)=circ_gabors_s2_1111c14;
circ_gabor_s2(2)=circ_gabors_s2_1111c25;
circ_gabor_s2(3)=circ_gabors_s2_1111d14;
circ_gabor_s2(4)=circ_gabors_s2_1111d25;

bg_gabor_s1(1)=bg_gabors_s1_1111c14;
bg_gabor_s1(2)=bg_gabors_s1_1111c25;
bg_gabor_s1(3)=bg_gabors_s1_1111d14;
bg_gabor_s1(4)=bg_gabors_s1_1111d25;

bg_gabor_s2(1)=bg_gabors_s2_1111c14;
bg_gabor_s2(2)=bg_gabors_s2_1111c25;
bg_gabor_s2(3)=bg_gabors_s2_1111d14;
bg_gabor_s2(4)=bg_gabors_s2_1111d25;


circ_between_s1(1)=circ_between_s1_1111c14;
circ_between_s1(2)=circ_between_s1_1111c25;
circ_between_s1(3)=circ_between_s1_1111d14;
circ_between_s1(4)=circ_between_s1_1111d25;

circ_between_s2(1)=circ_between_s2_1111c14;
circ_between_s2(2)=circ_between_s2_1111c25;
circ_between_s2(3)=circ_between_s2_1111d14;
circ_between_s2(4)=circ_between_s2_1111d25;

bg_between_s1(1)=bg_between_s1_1111c14;
bg_between_s1(2)=bg_between_s1_1111c25;
bg_between_s1(3)=bg_between_s1_1111d14;
bg_between_s1(4)=bg_between_s1_1111d25;

bg_between_s2(1)=bg_between_s2_1111c14;
bg_between_s2(2)=bg_between_s2_1111c25;
bg_between_s2(3)=bg_between_s2_1111d14;
bg_between_s2(4)=bg_between_s2_1111d25;


[n1,x1]=hist(circ_gabor_s2,-0.2e-3:0.00005:0.2e-3);
[n2,x2]=hist(circ_between_s2,-0.2e-3:0.00005:0.2e-3);
figure;bar(x1,[n1;n2]')

[n1,x1]=hist(circ_gabor_s1,-0.2e-3:0.00005:0.2e-3);
[n2,x2]=hist(circ_between_s1,-0.2e-3:0.00005:0.2e-3);
figure;bar(x1,[n1;n2]')


[n1,x1]=hist(bg_gabor_s2,-0.2e-3:0.00005:0.2e-3);
[n2,x2]=hist(bg_between_s2,-0.2e-3:0.00005:0.2e-3);
figure;bar(x1,[n1;n2]')

[n1,x1]=hist(bg_gabor_s1,-0.2e-3:0.00005:0.2e-3);
[n2,x2]=hist(bg_between_s1,-0.2e-3:0.00005:0.2e-3);
figure;bar(x1,[n1;n2]')








%%
[n1,x1]=hist(mean(diff([roi_f1late;roi_tar;roi_f2],34:36),2),-0.5e-3:0.00005:0.5e-3);
[n2,x2]=hist(mean(diff([roi_f1late;roi_tar;roi_f2],49:51),2),-0.5e-3:0.00005:0.5e-3);
[n3,x3]=hist(mean(diff(bet_cont,34:36),2),-0.5e-3:0.00005:0.5e-3);
[n4,x4]=hist(mean(diff(bet_cont,49:51),2),-0.5e-3:0.00005:0.5e-3);

figure;bar(x1,[n2/size([roi_f1late;roi_tar;roi_f2],1);n4/size(bet_cont,1)]')
figure;bar(x1,[n1/size([roi_f1late;roi_tar;roi_f2],1);n3/size(bet_cont,1)]')







[n1,x1]=hist(mean(diff([roi_f3;roi_f4;roi_f5],32:42),2),-0.5e-3:0.00005:0.5e-3);
[n2,x2]=hist(mean(diff([roi_f3;roi_f4;roi_f5],43:53),2),-0.5e-3:0.00005:0.5e-3);
[n3,x3]=hist(mean(diff(bet_bg,32:42),2),-0.5e-3:0.00005:0.5e-3);
[n4,x4]=hist(mean(diff(bet_bg,43:53),2),-0.5e-3:0.00005:0.5e-3);

figure;bar(x1,[n2/size([roi_f3;roi_f4;roi_f5],1);n4/size(bet_bg,1)]')
figure;bar(x1,[n1/size([roi_f3;roi_f4;roi_f5],1);n3/size(bet_bg,1)]')


