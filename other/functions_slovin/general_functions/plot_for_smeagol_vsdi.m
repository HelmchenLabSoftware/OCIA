


figure;plot(mean(mean(cond1n_dt_bl(roi_circle,2:100,:),3)-1,1));
hold on
plot(mean(mean(cond2n_dt_bl(roi_circle,2:100,:),3)-1,1),'g');
plot(mean(mean(cond4n_dt_bl(roi_circle,2:100,:),3)-1,1),'r');
plot(mean(mean(cond5n_dt_bl(roi_circle,2:100,:),3)-1,1),'c');


figure;plot(mean(mean(cond1n_dt_bl(roi_bg_in,2:100,:),3)-1,1));
hold on
plot(mean(mean(cond2n_dt_bl(roi_bg_in,2:100,:),3)-1,1),'g');
plot(mean(mean(cond4n_dt_bl(roi_bg_in,2:100,:),3)-1,1),'r');
plot(mean(mean(cond5n_dt_bl(roi_bg_in,2:100,:),3)-1,1),'c');



figure;plot(mean(mean(cond1n_dt_bl(roi_bg_out,2:100,:),3)-1,1));
hold on
plot(mean(mean(cond2n_dt_bl(roi_bg_out,2:100,:),3)-1,1),'g');
plot(mean(mean(cond4n_dt_bl(roi_bg_out,2:100,:),3)-1,1),'r');
plot(mean(mean(cond5n_dt_bl(roi_bg_out,2:100,:),3)-1,1),'c');


figure;plot(mean(mean(cond1n_dt_bl(roi,2:100,:),3)-1,1));
hold on
plot(mean(mean(cond2n_dt_bl(roi,2:100,:),3)-1,1),'g');
plot(mean(mean(cond4n_dt_bl(roi,2:100,:),3)-1,1),'r');
plot(mean(mean(cond5n_dt_bl(roi,2:100,:),3)-1,1),'c');


figure;plot(mean(cond1(roi_bg_in,2:100)-1,1));
hold on
plot(mean(cond4(roi_bg_in,2:100)-1,1),'g');

figure;plot(mean(cond2(roi_bg_in,2:100)-1,1));
hold on
plot(mean(cond5(roi_bg_in,2:100)-1,1),'g');


figure;plot(mean(cond1(roi_circ_right,2:100)-1,1));
hold on
plot(mean(cond4(roi_circ_right,2:100)-1,1),'g');

figure;plot(mean(cond2(roi_circ_right,2:100)-1,1));
hold on
plot(mean(cond5(roi_circ_right,2:100)-1,1),'g');


figure;plot(mean(cond1(roi_bg_left,2:100)-1,1));
hold on
plot(mean(cond4(roi_bg_left,2:100)-1,1),'g');

figure;plot(mean(cond2(roi_bg_left,2:100)-1,1));
hold on
plot(mean(cond5(roi_bg_left,2:100)-1,1),'g');


figure;plot(mean(cond1(roi_bg_far,2:100)-1,1));
hold on
plot(mean(cond4(roi_bg_far,2:100)-1,1),'g');
plot(mean(cond2(roi_bg_far,2:100)-1,1),'r');
plot(mean(cond5(roi_bg_far,2:100)-1,1),'c');

figure;plot(mean(cond1(roi_V2,2:100)-1,1));
hold on
plot(mean(cond4(roi_V2,2:100)-1,1),'g');
plot(mean(cond2(roi_V2,2:100)-1,1),'r');
plot(mean(cond5(roi_V2,2:100)-1,1),'c');




figure;plot(mean(cond1(roi_circle,2:100)-cond4(roi_circle,2:100),1));
hold on
plot(mean(cond2(roi_circle,2:100)-cond5(roi_circle,2:100),1),'r');
plot(mean(cond1(roi_bg_in,2:100)-cond4(roi_bg_in,2:100),1),'g');
plot(mean(cond2(roi_bg_in,2:100)-cond5(roi_bg_in,2:100),1),'c');





figure;plot(mean(cond1(roi_circle,2:100)-1,1));
hold on
plot(mean(cond1(roi_bg_in,2:100)-1,1),'g');

figure;plot(mean(cond4(roi_circle,2:100)-1,1));
hold on
plot(mean(cond4(roi_bg_in,2:100)-1,1),'g');




figure;plot(mean(cond1(roi_circle,2:100),1)-mean(cond1(roi_bg_in,2:100),1));
hold on
plot(mean(cond4(roi_circle,2:100),1)-mean(cond4(roi_bg_in,2:100),1),'g');



figure;plot(mean(cond2(roi_circle,2:100),1)-mean(cond2(roi_bg_in,2:100),1));
hold on
plot(mean(cond5(roi_circle,2:100),1)-mean(cond5(roi_bg_in,2:100),1),'g');





figure;plot(mean(mean(cond1n_dt_bl(roi3,2:100,:),3)-1,1));
hold on
plot(mean(mean(cond4n_dt_bl(roi3,2:100,:),3)-1,1),'g');




figure;plot(mean(mean(cond1n_dt_bl(roi_bg_in,2:100,:),3)-1,1));
hold on
plot(mean(mean(cond4n_dt_bl(roi_bg_in,2:100,:),3)-1,1),'g');

figure;plot(mean(mean(cond1n_dt_bl(roi_circle,2:100,:),3)-1,1));
hold on
plot(mean(mean(cond4n_dt_bl(roi_circle,2:100,:),3)-1,1),'g');


figure;plot(mean(mean(cond1n_dt_bl(roi_circle,2:100,:),3)-1,1));
hold on
plot(mean(mean(cond1n_dt_bl(roi_bg_in,2:100,:),3)-1,1),'g');

figure;plot(mean(mean(cond4n_dt_bl(roi_circle,2:100,:),3)-1,1));
hold on
plot(mean(mean(cond4n_dt_bl(roi_bg_in,2:100,:),3)-1,1),'g');



figure;plot(mean(mean(cond2n_dt_bl(roi_circle,2:100,:),3)-1,1));
hold on
plot(mean(mean(cond2n_dt_bl(roi_bg_in,2:100,:),3)-1,1),'g');

figure;plot(mean(mean(cond5n_dt_bl(roi_circle,2:100,:),3)-1,1));
hold on
plot(mean(mean(cond5n_dt_bl(roi_bg_in,2:100,:),3)-1,1),'g');


figure;plot(mean(mean(cond1n_dt_bl(roi_circ_right,2:100,:),3)-1,1));
hold on
plot(mean(mean(cond1n_dt_bl(roi_bg_right,2:100,:),3)-1,1),'g');

figure;plot(mean(mean(cond4n_dt_bl(roi_circ_right,2:100,:),3)-1,1));
hold on
plot(mean(mean(cond4n_dt_bl(roi_bg_right,2:100,:),3)-1,1),'g');


figure;plot(mean(mean(cond2n_dt_bl(roi_circ_right,2:100,:),3)-1,1));
hold on
plot(mean(mean(cond2n_dt_bl(roi_bg_right,2:100,:),3)-1,1),'g');

figure;plot(mean(mean(cond5n_dt_bl(roi_circ_right,2:100,:),3)-1,1));
hold on
plot(mean(mean(cond5n_dt_bl(roi_bg_right,2:100,:),3)-1,1),'g');



for i=1:17
    figure;mimg(mfilt2(cond1n_dt_bl(:,28:68,i),100,100,1,'lm')-1,100,100,-0.4e-3,1.8e-3);colormap(mapgeog);
end


for i=1:17
    figure;plot(mean(cond1n_dt_bl(roi_circle,2:100,i)-1,1));
    hold on
    plot(mean(cond1n_dt_bl(roi_bg_in,2:100,i)-1,1),'g');
end




figure;plot(mean(mean(cond1n_dt_bl(roi_circle,2:100,:),3),1)-mean(mean(cond4n_dt_bl(roi_circle,2:100,:),3),1));
hold on
plot(mean(mean(cond1n_dt_bl(roi_bg_in,2:100,:),3),1)-mean(mean(cond4n_dt_bl(roi_bg_in,2:100,:),3),1),'g');



figure;plot(mean(mean(cond2n_dt_bl(roi_circle,2:100,:),3),1)-mean(mean(cond5n_dt_bl(roi_circle,2:100,:),3),1));
hold on
plot(mean(mean(cond2n_dt_bl(roi_bg_in,2:100,:),3),1)-mean(mean(cond5n_dt_bl(roi_bg_in,2:100,:),3),1),'g');



figure;errorbar(mean(mean(cond1n_dt_bl(roi_circle,2:100,:),3),1)-mean(mean(cond4n_dt_bl(roi_circle,2:100,:),3),1));
hold on



figure;plot(mean(mean(cond1n_dt_bl(roi_circ_right,2:100,:),3),1)-mean(mean(cond4n_dt_bl(roi_circ_right,2:100,:),3),1));
hold on
plot(mean(mean(cond1n_dt_bl(roi_bg_right,2:100,:),3),1)-mean(mean(cond4n_dt_bl(roi_bg_right,2:100,:),3),1),'g');

figure;plot(mean(mean(cond2n_dt_bl(roi_circ_right,2:100,:),3),1)-mean(mean(cond5n_dt_bl(roi_circ_right,2:100,:),3),1));
hold on
plot(mean(mean(cond2n_dt_bl(roi_bg_right,2:100,:),3),1)-mean(mean(cond5n_dt_bl(roi_bg_right,2:100,:),3),1),'g');







figure;plot(mean(mean(cond1n_dt_bl(roi_bg_right,2:100,:),3)-1,1));
hold on
plot(mean(mean(cond4n_dt_bl(roi_bg_right,2:100,:),3)-1,1),'g');
plot(mean(mean(cond2n_dt_bl(roi_bg_right,2:100,:),3)-1,1),'r');
plot(mean(mean(cond5n_dt_bl(roi_bg_right,2:100,:),3)-1,1),'c');


figure;plot(mean(mean(cond1n_dt_bl(roi_bg_middle,2:100,:),3)-1,1));
hold on
plot(mean(mean(cond4n_dt_bl(roi_bg_middle,2:100,:),3)-1,1),'g');
plot(mean(mean(cond2n_dt_bl(roi_bg_middle,2:100,:),3)-1,1),'r');
plot(mean(mean(cond5n_dt_bl(roi_bg_middle,2:100,:),3)-1,1),'c');




figure;plot(mean(mean(cond1n_dt_bl(roi_circ_right,2:100,:),3)-1,1));
hold on
plot(mean(mean(cond4n_dt_bl(roi_circ_right,2:100,:),3)-1,1),'g');
plot(mean(mean(cond2n_dt_bl(roi_circ_right,2:100,:),3)-1,1),'r');
plot(mean(mean(cond5n_dt_bl(roi_circ_right,2:100,:),3)-1,1),'c');


figure;plot(mean(mean(cond1n_dt_bl(roi_circ_middle,2:100,:),3)-1,1));
hold on
plot(mean(mean(cond4n_dt_bl(roi_circ_middle,2:100,:),3)-1,1),'g');
plot(mean(mean(cond2n_dt_bl(roi_circ_middle,2:100,:),3)-1,1),'r');
plot(mean(mean(cond5n_dt_bl(roi_circ_middle,2:100,:),3)-1,1),'c');


figure;plot(mean(mean(cond1n_dt_bl(roi_circ_left,2:100,:),3)-1,1));
hold on
plot(mean(mean(cond4n_dt_bl(roi_circ_left,2:100,:),3)-1,1),'g');
plot(mean(mean(cond2n_dt_bl(roi_circ_left,2:100,:),3)-1,1),'r');
plot(mean(mean(cond5n_dt_bl(roi_circ_left,2:100,:),3)-1,1),'c');

figure;plot(mean(mean(cond1n_dt_bl(roi_circle,2:100,:),3)-1,1));
hold on
plot(mean(mean(cond4n_dt_bl(roi_circle,2:100,:),3)-1,1),'c');
plot(mean(mean(cond2n_dt_bl(roi_circle,2:100,:),3)-1,1),'r');
plot(mean(mean(cond5n_dt_bl(roi_circle,2:100,:),3)-1,1),'m');

figure;plot(mean(mean(cond1n_dt_bl(roi_circle,2:100,:),3),1)-mean(mean(cond4n_dt_bl(roi_circle,2:100,:),3),1));
hold on
plot(mean(mean(cond2n_dt_bl(roi_circle,2:100,:),3),1)-mean(mean(cond5n_dt_bl(roi_circle,2:100,:),3),1),'g');
plot(zeros(1,111),'k')

figure;plot(mean(mean(cond1n_dt_bl(roi_V2_circle,2:100,:),3)-1,1));
hold on
plot(mean(mean(cond2n_dt_bl(roi_V2_circle,2:100,:),3)-1,1),'c');
plot(mean(mean(cond4n_dt_bl(roi_V2_circle,2:100,:),3)-1,1),'r');
plot(mean(mean(cond5n_dt_bl(roi_V2_circle,2:100,:),3)-1,1),'m');

figure;plot(mean(mean(cond1n_dt_bl(roi_V2_circle,2:100,:),3),1)-mean(mean(cond4n_dt_bl(roi_V2_circle,2:100,:),3),1));
hold on
plot(mean(mean(cond2n_dt_bl(roi_V2_circle,2:100,:),3),1)-mean(mean(cond5n_dt_bl(roi_V2_circle,2:100,:),3),1),'g');
plot(zeros(1,111),'k')

figure;plot(mean(mean(cond1n_dt_bl(roi_V2_circ_right,2:100,:),3)-1,1));
hold on
plot(mean(mean(cond2n_dt_bl(roi_V2_circ_right,2:100,:),3)-1,1),'c');
plot(mean(mean(cond4n_dt_bl(roi_V2_circ_right,2:100,:),3)-1,1),'r');
plot(mean(mean(cond5n_dt_bl(roi_V2_circ_right,2:100,:),3)-1,1),'m');

figure;plot(mean(mean(cond1n_dt_bl(roi_V2_circ_right,2:100,:),3),1)-mean(mean(cond4n_dt_bl(roi_V2_circ_right,2:100,:),3),1));
hold on
plot(mean(mean(cond2n_dt_bl(roi_V2_circ_right,2:100,:),3),1)-mean(mean(cond5n_dt_bl(roi_V2_circ_right,2:100,:),3),1),'g');
plot(zeros(1,111),'k')

figure;plot(mean(mean(cond1n_dt_bl(roi_V2_circ_middle,2:100,:),3)-1,1));
hold on
plot(mean(mean(cond2n_dt_bl(roi_V2_circ_middle,2:100,:),3)-1,1),'c');
plot(mean(mean(cond4n_dt_bl(roi_V2_circ_middle,2:100,:),3)-1,1),'r');
plot(mean(mean(cond5n_dt_bl(roi_V2_circ_middle,2:100,:),3)-1,1),'m');

figure;plot(mean(mean(cond1n_dt_bl(roi_V2_circ_middle,2:100,:),3),1)-mean(mean(cond4n_dt_bl(roi_V2_circ_middle,2:100,:),3),1));
hold on
plot(mean(mean(cond2n_dt_bl(roi_V2_circ_middle,2:100,:),3),1)-mean(mean(cond5n_dt_bl(roi_V2_circ_middle,2:100,:),3),1),'g');
plot(zeros(1,111),'k')


figure;plot(mean(mean(cond1n_dt_bl(roi_V2_bg,2:100,:),3)-1,1));
hold on
plot(mean(mean(cond2n_dt_bl(roi_V2_bg,2:100,:),3)-1,1),'c');
plot(mean(mean(cond4n_dt_bl(roi_V2_bg,2:100,:),3)-1,1),'r');
plot(mean(mean(cond5n_dt_bl(roi_V2_bg,2:100,:),3)-1,1),'m');

figure;plot(mean(mean(cond1n_dt_bl(roi_V2_bg,2:100,:),3),1)-mean(mean(cond4n_dt_bl(roi_V2_bg,2:100,:),3),1));
hold on
plot(mean(mean(cond2n_dt_bl(roi_V2_bg,2:100,:),3),1)-mean(mean(cond5n_dt_bl(roi_V2_bg,2:100,:),3),1),'g');
plot(zeros(1,111),'k')


figure;plot(mean(mean(cond1n_dt_bl(roi_V2_bg_left,2:100,:),3)-1,1));
hold on
plot(mean(mean(cond2n_dt_bl(roi_V2_bg_left,2:100,:),3)-1,1),'c');
plot(mean(mean(cond4n_dt_bl(roi_V2_bg_left,2:100,:),3)-1,1),'r');
plot(mean(mean(cond5n_dt_bl(roi_V2_bg_left,2:100,:),3)-1,1),'m');

figure;plot(mean(mean(cond1n_dt_bl(roi_V2_bg_left,2:100,:),3),1)-mean(mean(cond4n_dt_bl(roi_V2_bg_left,2:100,:),3),1));
hold on
plot(mean(mean(cond2n_dt_bl(roi_V2_bg_left,2:100,:),3),1)-mean(mean(cond5n_dt_bl(roi_V2_bg_left,2:100,:),3),1),'g');
plot(zeros(1,111),'k')



figure;plot(mean(mean(cond1n_dt_bl(roi_bg_out,2:100,:),3)-1,1));
hold on
plot(mean(mean(cond2n_dt_bl(roi_bg_out,2:100,:),3)-1,1),'c');
plot(mean(mean(cond4n_dt_bl(roi_bg_out,2:100,:),3)-1,1),'r');
plot(mean(mean(cond5n_dt_bl(roi_bg_out,2:100,:),3)-1,1),'m');

figure;plot(mean(mean(cond1n_dt_bl(roi_bg_out,2:100,:),3),1)-mean(mean(cond4n_dt_bl(roi_bg_out,2:100,:),3),1));
hold on
plot(mean(mean(cond2n_dt_bl(roi_bg_out,2:100,:),3),1)-mean(mean(cond5n_dt_bl(roi_bg_out,2:100,:),3),1),'g');
plot(zeros(1,111),'k')



figure;plot(mean(mean(cond1n_dt_bl(roi_bg_in,2:100,:),3)-1,1));
hold on
plot(mean(mean(cond2n_dt_bl(roi_bg_in,2:100,:),3)-1,1),'c');
plot(mean(mean(cond4n_dt_bl(roi_bg_in,2:100,:),3)-1,1),'r');
plot(mean(mean(cond5n_dt_bl(roi_bg_in,2:100,:),3)-1,1),'m');

figure;plot(mean(mean(cond1n_dt_bl(roi_bg_in,2:100,:),3),1)-mean(mean(cond4n_dt_bl(roi_bg_in,2:100,:),3),1));
hold on
plot(mean(mean(cond2n_dt_bl(roi_bg_in,2:100,:),3),1)-mean(mean(cond5n_dt_bl(roi_bg_in,2:100,:),3),1),'g');
plot(zeros(1,111),'k')


figure;plot(mean(mean(cond1n_dt_bl(roi_circ_middle,2:100,:),3)-1,1));
hold on
plot(mean(mean(cond1n_dt_bl(roi_bg_middle,2:100,:),3)-1,1),'LineStyle','--','Color','b');
plot(mean(mean(cond4n_dt_bl(roi_circ_middle,2:100,:),3)-1,1),'LineStyle','-','Color','g');
plot(mean(mean(cond4n_dt_bl(roi_bg_middle,2:100,:),3)-1,1),'LineStyle','--','Color','g');

figure;plot(mean(mean(cond2n_dt_bl(roi_circ_middle,2:100,:),3)-1,1));
hold on
plot(mean(mean(cond2n_dt_bl(roi_bg_middle,2:100,:),3)-1,1),'LineStyle','--','Color','b');
plot(mean(mean(cond5n_dt_bl(roi_circ_middle,2:100,:),3)-1,1),'LineStyle','-','Color','g');
plot(mean(mean(cond5n_dt_bl(roi_bg_middle,2:100,:),3)-1,1),'LineStyle','--','Color','g');




figure;plot(mean(mean(cond1n_dt_bl(roi_circ_right,2:100,:),3)-1,1));
hold on
plot(mean(mean(cond1n_dt_bl(roi_bg_right,2:100,:),3)-1,1),'LineStyle','--','Color','b');
plot(mean(mean(cond4n_dt_bl(roi_circ_right,2:100,:),3)-1,1),'LineStyle','-','Color','g');
plot(mean(mean(cond4n_dt_bl(roi_bg_right,2:100,:),3)-1,1),'LineStyle','--','Color','g');

figure;plot(mean(mean(cond2n_dt_bl(roi_circ_right,2:100,:),3)-1,1));
hold on
plot(mean(mean(cond2n_dt_bl(roi_bg_right,2:100,:),3)-1,1),'LineStyle','--','Color','b');
plot(mean(mean(cond5n_dt_bl(roi_circ_right,2:100,:),3)-1,1),'LineStyle','-','Color','g');
plot(mean(mean(cond5n_dt_bl(roi_bg_right,2:100,:),3)-1,1),'LineStyle','--','Color','g');










figure;errorbar(mean(mean(cond1n_dt_bl(roi_circ_middle,2:100,:)-1,1),3),std(mean(cond1n_dt_bl(roi_circ_middle,2:100,:)-1,1),0,3)/sqrt(size(cond1n_dt_bl,3)));
hold on
errorbar(mean(mean(cond4n_dt_bl(roi_circ_middle,2:100,:)-1,1),3),std(mean(cond4n_dt_bl(roi_circ_middle,2:100,:)-1,1),0,3)/sqrt(size(cond4n_dt_bl,3)),'g');

figure;errorbar(mean(mean(cond2n_dt_bl(roi_circ_middle,2:100,:)-1,1),3),std(mean(cond2n_dt_bl(roi_circ_middle,2:100,:)-1,1),0,3)/sqrt(size(cond2n_dt_bl,3)));
hold on
errorbar(mean(mean(cond5n_dt_bl(roi_circ_middle,2:100,:)-1,1),3),std(mean(cond5n_dt_bl(roi_circ_middle,2:100,:)-1,1),0,3)/sqrt(size(cond5n_dt_bl,3)),'g');




figure;errorbar(mean(mean(cond1n_dt_bl(roi_bg_middle,2:100,:)-1,1),3),std(mean(cond1n_dt_bl(roi_bg_middle,2:100,:)-1,1),0,3)/sqrt(size(cond1n_dt_bl,3)));
hold on
errorbar(mean(mean(cond4n_dt_bl(roi_bg_middle,2:100,:)-1,1),3),std(mean(cond4n_dt_bl(roi_bg_middle,2:100,:)-1,1),0,3)/sqrt(size(cond4n_dt_bl,3)),'g');

figure;errorbar(mean(mean(cond2n_dt_bl(roi_bg_middle,2:100,:)-1,1),3),std(mean(cond2n_dt_bl(roi_bg_middle,2:100,:)-1,1),0,3)/sqrt(size(cond2n_dt_bl,3)));
hold on
errorbar(mean(mean(cond5n_dt_bl(roi_bg_middle,2:100,:)-1,1),3),std(mean(cond5n_dt_bl(roi_bg_middle,2:100,:)-1,1),0,3)/sqrt(size(cond5n_dt_bl,3)),'g');




figure;errorbar(mean(mean(cond1n_dt_bl(roi,2:100,:)-1,1),3),std(mean(cond1n_dt_bl(roi,2:100,:)-1,1),0,3)/sqrt(size(cond1n_dt_bl,3)));
hold on
errorbar(mean(mean(cond4n_dt_bl(roi,2:100,:)-1,1),3),std(mean(cond4n_dt_bl(roi,2:100,:)-1,1),0,3)/sqrt(size(cond4n_dt_bl,3)),'g');
xlim([18 68])

figure;errorbar(mean(mean(cond2n_dt_bl(roi,2:100,:)-1,1),3),std(mean(cond2n_dt_bl(roi,2:100,:)-1,1),0,3)/sqrt(size(cond2n_dt_bl,3)));
hold on
errorbar(mean(mean(cond5n_dt_bl(roi,2:100,:)-1,1),3),std(mean(cond5n_dt_bl(roi,2:100,:)-1,1),0,3)/sqrt(size(cond5n_dt_bl,3)),'g');
xlim([18 68])



figure;errorbar(mean(mean(cond1n_dt_bl(roi_bg_in,2:100,:)-1,1),3),std(mean(cond1n_dt_bl(roi_bg_in,2:100,:)-1,1),0,3)/sqrt(size(cond1n_dt_bl,3)));
hold on
errorbar(mean(mean(cond4n_dt_bl(roi_bg_in,2:100,:)-1,1),3),std(mean(cond4n_dt_bl(roi_bg_in,2:100,:)-1,1),0,3)/sqrt(size(cond4n_dt_bl,3)),'g');
xlim([18 58])

figure;errorbar(mean(mean(cond2n_dt_bl(roi_bg_in,2:100,:)-1,1),3),std(mean(cond2n_dt_bl(roi_bg_in,2:100,:)-1,1),0,3)/sqrt(size(cond2n_dt_bl,3)));
hold on
errorbar(mean(mean(cond5n_dt_bl(roi_bg_in,2:100,:)-1,1),3),std(mean(cond5n_dt_bl(roi_bg_in,2:100,:)-1,1),0,3)/sqrt(size(cond5n_dt_bl,3)),'g');
xlim([18 58])


figure;errorbar(mean(mean(cond1n_dt_bl(roi_bg_out,2:100,:)-1,1),3),std(mean(cond1n_dt_bl(roi_bg_out,2:100,:)-1,1),0,3)/sqrt(size(cond1n_dt_bl,3)));
hold on
errorbar(mean(mean(cond4n_dt_bl(roi_bg_out,2:100,:)-1,1),3),std(mean(cond4n_dt_bl(roi_bg_out,2:100,:)-1,1),0,3)/sqrt(size(cond4n_dt_bl,3)),'g');
xlim([18 88])

figure;errorbar(mean(mean(cond2n_dt_bl(roi_bg_out,2:100,:)-1,1),3),std(mean(cond2n_dt_bl(roi_bg_out,2:100,:)-1,1),0,3)/sqrt(size(cond2n_dt_bl,3)));
hold on
errorbar(mean(mean(cond5n_dt_bl(roi_bg_out,2:100,:)-1,1),3),std(mean(cond5n_dt_bl(roi_bg_out,2:100,:)-1,1),0,3)/sqrt(size(cond5n_dt_bl,3)),'g');
xlim([18 88])



figure;errorbar(mean(mean(cond1n_dt_bl(roi_circ_right,2:100,:)-1,1),3),std(mean(cond1n_dt_bl(roi_circ_right,2:100,:)-1,1),0,3)/sqrt(size(cond1n_dt_bl,3)));
hold on
errorbar(mean(mean(cond4n_dt_bl(roi_circ_right,2:100,:)-1,1),3),std(mean(cond4n_dt_bl(roi_circ_right,2:100,:)-1,1),0,3)/sqrt(size(cond4n_dt_bl,3)),'g');

figure;errorbar(mean(mean(cond2n_dt_bl(roi_circ_right,2:100,:)-1,1),3),std(mean(cond2n_dt_bl(roi_circ_right,2:100,:)-1,1),0,3)/sqrt(size(cond2n_dt_bl,3)));
hold on
errorbar(mean(mean(cond5n_dt_bl(roi_circ_right,2:100,:)-1,1),3),std(mean(cond5n_dt_bl(roi_circ_right,2:100,:)-1,1),0,3)/sqrt(size(cond5n_dt_bl,3)),'g');




figure;errorbar(mean(mean(cond1n_dt_bl(roi_bg_right,2:100,:)-1,1),3),std(mean(cond1n_dt_bl(roi_bg_right,2:100,:)-1,1),0,3)/sqrt(size(cond1n_dt_bl,3)));
hold on
errorbar(mean(mean(cond4n_dt_bl(roi_bg_right,2:100,:)-1,1),3),std(mean(cond4n_dt_bl(roi_bg_right,2:100,:)-1,1),0,3)/sqrt(size(cond4n_dt_bl,3)),'g');

figure;errorbar(mean(mean(cond2n_dt_bl(roi_bg_right,2:100,:)-1,1),3),std(mean(cond2n_dt_bl(roi_bg_right,2:100,:)-1,1),0,3)/sqrt(size(cond2n_dt_bl,3)));
hold on
errorbar(mean(mean(cond5n_dt_bl(roi_bg_right,2:100,:)-1,1),3),std(mean(cond5n_dt_bl(roi_bg_right,2:100,:)-1,1),0,3)/sqrt(size(cond5n_dt_bl,3)),'g');





figure;errorbar(mean(mean(cond1n_dt_bl(roi_V2,2:100,:)-1,1),3),std(mean(cond1n_dt_bl(roi_V2,2:100,:)-1,1),0,3)/sqrt(size(cond1n_dt_bl,3)));
hold on
errorbar(mean(mean(cond4n_dt_bl(roi_V2,2:100,:)-1,1),3),std(mean(cond4n_dt_bl(roi_V2,2:100,:)-1,1),0,3)/sqrt(size(cond4n_dt_bl,3)),'g');

figure;errorbar(mean(mean(cond2n_dt_bl(roi_V2,2:100,:)-1,1),3),std(mean(cond2n_dt_bl(roi_V2,2:100,:)-1,1),0,3)/sqrt(size(cond2n_dt_bl,3)));
hold on
errorbar(mean(mean(cond5n_dt_bl(roi_V2,2:100,:)-1,1),3),std(mean(cond5n_dt_bl(roi_V2,2:100,:)-1,1),0,3)/sqrt(size(cond5n_dt_bl,3)),'g');



figure;errorbar(mean(mean(cond1n_dt_bl(roi_V2_circle,2:100,:)-1,1),3),std(mean(cond1n_dt_bl(roi_V2_circle,2:100,:)-1,1),0,3)/sqrt(size(cond1n_dt_bl,3)));
hold on
errorbar(mean(mean(cond4n_dt_bl(roi_V2_circle,2:100,:)-1,1),3),std(mean(cond4n_dt_bl(roi_V2_circle,2:100,:)-1,1),0,3)/sqrt(size(cond4n_dt_bl,3)),'g');

figure;errorbar(mean(mean(cond2n_dt_bl(roi_V2_circle,2:100,:)-1,1),3),std(mean(cond2n_dt_bl(roi_V2_circle,2:100,:)-1,1),0,3)/sqrt(size(cond2n_dt_bl,3)));
hold on
errorbar(mean(mean(cond5n_dt_bl(roi_V2_circle,2:100,:)-1,1),3),std(mean(cond5n_dt_bl(roi_V2_circle,2:100,:)-1,1),0,3)/sqrt(size(cond5n_dt_bl,3)),'g');


figure;errorbar(mean(mean(cond1n_dt_bl(roi_V2_bg,2:100,:)-1,1),3),std(mean(cond1n_dt_bl(roi_V2_bg,2:100,:)-1,1),0,3)/sqrt(size(cond1n_dt_bl,3)));
hold on
errorbar(mean(mean(cond4n_dt_bl(roi_V2_bg,2:100,:)-1,1),3),std(mean(cond4n_dt_bl(roi_V2_bg,2:100,:)-1,1),0,3)/sqrt(size(cond4n_dt_bl,3)),'g');

figure;errorbar(mean(mean(cond2n_dt_bl(roi_V2_bg,2:100,:)-1,1),3),std(mean(cond2n_dt_bl(roi_V2_bg,2:100,:)-1,1),0,3)/sqrt(size(cond2n_dt_bl,3)));
hold on
errorbar(mean(mean(cond5n_dt_bl(roi_V2_bg,2:100,:)-1,1),3),std(mean(cond5n_dt_bl(roi_V2_bg,2:100,:)-1,1),0,3)/sqrt(size(cond5n_dt_bl,3)),'g');




figure;errorbar(mean(mean(cond1n_dt_bl(roi_V4,2:100,:)-1,1),3),std(mean(cond1n_dt_bl(roi_V4,2:100,:)-1,1),0,3)/sqrt(size(cond1n_dt_bl,3)));
hold on
errorbar(mean(mean(cond4n_dt_bl(roi_V4,2:100,:)-1,1),3),std(mean(cond4n_dt_bl(roi_V4,2:100,:)-1,1),0,3)/sqrt(size(cond4n_dt_bl,3)),'g');

figure;errorbar(mean(mean(cond2n_dt_bl(roi_V4,2:100,:)-1,1),3),std(mean(cond2n_dt_bl(roi_V4,2:100,:)-1,1),0,3)/sqrt(size(cond2n_dt_bl,3)));
hold on
errorbar(mean(mean(cond5n_dt_bl(roi_V4,2:100,:)-1,1),3),std(mean(cond5n_dt_bl(roi_V4,2:100,:)-1,1),0,3)/sqrt(size(cond5n_dt_bl,3)),'g');




figure;errorbar(mean(mean(cond1n_dt_bl(roi_circle,2:130,:)-1,1),3),std(mean(cond1n_dt_bl(roi_circle,2:130,:)-1,1),0,3)/sqrt(size(cond1n_dt_bl,3)));
hold on
errorbar(mean(mean(cond4n_dt_bl(roi_circle,2:130,:)-1,1),3),std(mean(cond4n_dt_bl(roi_circle,2:130,:)-1,1),0,3)/sqrt(size(cond4n_dt_bl,3)),'g');

figure;errorbar(mean(mean(cond2n_dt_bl(roi_circle,2:100,:)-1,1),3),std(mean(cond2n_dt_bl(roi_circle,2:100,:)-1,1),0,3)/sqrt(size(cond2n_dt_bl,3)));
hold on
errorbar(mean(mean(cond5n_dt_bl(roi_circle,2:100,:)-1,1),3),std(mean(cond5n_dt_bl(roi_circle,2:100,:)-1,1),0,3)/sqrt(size(cond5n_dt_bl,3)),'g');



figure;errorbar(mean(mean(cond1n_dt_bl(roi_circ_left,2:100,:)-1,1),3),std(mean(cond1n_dt_bl(roi_circ_left,2:100,:)-1,1),0,3)/sqrt(size(cond1n_dt_bl,3)));
hold on
errorbar(mean(mean(cond4n_dt_bl(roi_circ_left,2:100,:)-1,1),3),std(mean(cond4n_dt_bl(roi_circ_left,2:100,:)-1,1),0,3)/sqrt(size(cond4n_dt_bl,3)),'g');

figure;errorbar(mean(mean(cond2n_dt_bl(roi_circ_left,2:100,:)-1,1),3),std(mean(cond2n_dt_bl(roi_circ_left,2:100,:)-1,1),0,3)/sqrt(size(cond2n_dt_bl,3)));
hold on
errorbar(mean(mean(cond5n_dt_bl(roi_circ_left,2:100,:)-1,1),3),std(mean(cond5n_dt_bl(roi_circ_left,2:100,:)-1,1),0,3)/sqrt(size(cond5n_dt_bl,3)),'g');



figure;errorbar(mean(mean(cond1n_dt_bl(roi_bg_left,2:100,:)-1,1),3),std(mean(cond1n_dt_bl(roi_bg_left,2:100,:)-1,1),0,3)/sqrt(size(cond1n_dt_bl,3)));
hold on
errorbar(mean(mean(cond4n_dt_bl(roi_bg_left,2:100,:)-1,1),3),std(mean(cond4n_dt_bl(roi_bg_left,2:100,:)-1,1),0,3)/sqrt(size(cond4n_dt_bl,3)),'g');

figure;errorbar(mean(mean(cond2n_dt_bl(roi_bg_left,2:100,:)-1,1),3),std(mean(cond2n_dt_bl(roi_bg_left,2:100,:)-1,1),0,3)/sqrt(size(cond2n_dt_bl,3)));
hold on
errorbar(mean(mean(cond5n_dt_bl(roi_bg_left,2:100,:)-1,1),3),std(mean(cond5n_dt_bl(roi_bg_left,2:100,:)-1,1),0,3)/sqrt(size(cond5n_dt_bl,3)),'g');









figure;plot(mean(mean(a(roi_circle,2:100,:),3),1))
hold on
plot(mean(mean(b(roi_circle,2:100,:),1),3),'g')
plot(mean(mean(c(roi_circle,2:100,:),1),3),'c')
plot(mean(mean(d(roi_circle,2:100,:),1),3),'r')



figure;plot(mean(mean(a(roi_bg_in,2:100,:),1),3))
hold on
plot(mean(mean(b(roi_bg_in,2:100,:),1),3),'g')
plot(mean(mean(c(roi_bg_in,2:100,:),1),3),'c')
plot(mean(mean(d(roi_bg_in,2:100,:),1),3),'r')


figure;plot(mean(mean(a(roi,2:100,:),3),1))
hold on
plot(mean(mean(b(roi,2:100,:),1),3),'g')
plot(mean(mean(c(roi,2:100,:),1),3),'c')
plot(mean(mean(d(roi,2:100,:),1),3),'r')

figure;plot(mean(mean(a(roi2,2:100,:),3),1))
hold on
plot(mean(mean(b(roi2,2:100,:),1),3),'g')
plot(mean(mean(c(roi2,2:100,:),1),3),'c')
plot(mean(mean(d(roi2,2:100,:),1),3),'r')


figure;plot(mean(mean(a(roi_circ_middle,2:100,:),1),3))
hold on
plot(mean(mean(b(roi_circ_middle,2:100,:),1),3),'g')
plot(mean(mean(c(roi_circ_middle,2:100,:),1),3),'c')
plot(mean(mean(d(roi_circ_middle,2:100,:),1),3),'r')





figure;errorbar(mean(mean(a(roi_circle,2:100,:),1),3),std(mean(a(roi_circle,2:100,:),1),0,3)/sqrt(size(a,3)))
hold on
errorbar(mean(mean(b(roi_circle,2:100,:),1),3),std(mean(b(roi_circle,2:100,:),1),0,3)/sqrt(size(b,3)),'r')
errorbar(mean(mean(c(roi_circle,2:100,:),1),3),std(mean(c(roi_circle,2:100,:),1),0,3)/sqrt(size(c,3)),'m')
errorbar(mean(mean(d(roi_circle,2:100,:),1),3),std(mean(d(roi_circle,2:100,:),1),0,3)/sqrt(size(d,3)),'r')


figure;errorbar(mean(mean(a(roi_bg_in,2:100,:),1),3),std(mean(a(roi_bg_in,2:100,:),1),0,3)/sqrt(size(a,3)))
hold on
errorbar(mean(mean(b(roi_bg_in,2:100,:),1),3),std(mean(b(roi_bg_in,2:100,:),1),0,3)/sqrt(size(b,3)),'r')
errorbar(mean(mean(c(roi_bg_in,2:100,:),1),3),std(mean(c(roi_bg_in,2:100,:),1),0,3)/sqrt(size(c,3)),'m')
errorbar(mean(mean(d(roi_bg_in,2:100,:),1),3),std(mean(d(roi_bg_in,2:100,:),1),0,3)/sqrt(size(d,3)),'r')



figure;errorbar(mean(mean(a(roi_circ_middle,2:100,:),1),3),std(mean(a(roi_circ_middle,2:100,:),1),0,3)/sqrt(size(a,3)))
hold on
errorbar(mean(mean(b(roi_circ_middle,2:100,:),1),3),std(mean(b(roi_circ_middle,2:100,:),1),0,3)/sqrt(size(b,3)),'r')
xlim([40 60])
figure;errorbar(mean(mean(a(roi2,2:100,:),1),3),std(mean(a(roi2,2:100,:),1),0,3)/sqrt(size(a,3)))
hold on
errorbar(mean(mean(b(roi2,2:100,:),1),3),std(mean(b(roi2,2:100,:),1),0,3)/sqrt(size(b,3)),'r')
xlim([40 60])


figure;plot(mean(a(roi_circle,2:100),1))
hold on
plot(mean(b(roi_circle,2:100),1),'g')
plot(mean(c(roi_circle,2:100),1),'c')
plot(mean(d(roi_circle,2:100),1),'r')
legend('contour','non-contour','jit1','jit2')

figure;plot(mean(a(roi_bg_in,2:100),1))
hold on
plot(mean(b(roi_bg_in,2:100),1),'g')
plot(mean(c(roi_bg_in,2:100),1),'c')
plot(mean(d(roi_bg_in,2:100),1),'r')
legend('contour','non-contour','jit1','jit2')




%%

figure;errorbar(mean(cont_circle,2),std(cont_circle,0,2)/sqrt(size(cont_circle,2)));
hold on
errorbar(mean(non_circle,2),std(non_circle,0,2)/sqrt(size(non_circle,2)),'r');

figure;errorbar(mean(cont_bg_in,2),std(cont_bg_in,0,2)/sqrt(size(cont_bg_in,2)));
hold on
errorbar(mean(non_bg_in,2),std(non_bg_in,0,2)/sqrt(size(non_bg_in,2)),'r');

figure;errorbar(mean(cont_bg_out,2),std(cont_bg_out,0,2)/sqrt(size(cont_bg_out,2)));
hold on
errorbar(mean(non_bg_out,2),std(non_bg_out,0,2)/sqrt(size(non_bg_out,2)),'r');

figure;errorbar(mean(cont_bg,2),std(cont_bg,0,2)/sqrt(size(cont_bg,2)));
hold on
errorbar(mean(non_bg,2),std(non_bg,0,2)/sqrt(size(non_bg,2)),'r');

figure;errorbar(mean(cont_circle_diff,2),std(cont_circle_diff,0,2)/sqrt(size(cont_circle_diff,2)));
hold on
errorbar(mean(non_circle_diff,2),std(non_circle_diff,0,2)/sqrt(size(non_circle_diff,2)),'r');



for i=1:111
    p_circ(i)=ranksum(cont_circle(i,:),non_circle(i,:));
    p_bg(i)=ranksum(cont_bg_in(i,:),non_bg_in(i,:));
end

s=find(p_circ<0.05)
p_circ(s)

s=find(p_bg<0.05)
p_bg(s)



diff_circ=cont_circle-non_circle;
diff_bg_in=cont_bg_in-non_bg_in;
diff_bg_out=cont_bg_out-non_bg_out;
diff_bg=cont_bg-non_bg;
diff_circ_diff=cont_circle_diff-non_circle_diff;




x=(20:10:1120)-280;
figure;errorbar(x,mean(diff_circ,2),std(diff_circ,0,2)/sqrt(size(diff_circ,2)));
hold on
errorbar(x,mean(diff_bg_in,2),std(diff_bg_in,0,2)/sqrt(size(diff_bg_in,2)),'r');
plot(x,zeros(1,111),'k')
xlim([-100 500])


x=(20:10:1120)-280;
figure;errorbar(x,mean(diff_circ_out,2),std(diff_circ_out,0,2)/sqrt(size(diff_circ_out,2)));
hold on
errorbar(x,mean(diff_bg_out,2),std(diff_bg_out,0,2)/sqrt(size(diff_bg_out,2)),'r');
plot(x,zeros(1,111),'k')
xlim([-100 300])


errorbar(x,mean(diff_bg_out,2),std(diff_bg_out,0,2)/sqrt(size(diff_bg_out,2)),'g');
errorbar(x,mean(diff_bg,2),std(diff_bg,0,2)/sqrt(size(diff_bg,2)),'c');



figure;errorbar(mean(diff_circ-diff_bg,2),std(diff_circ-diff_bg,0,2)/sqrt(size(diff_circ,2)));
xlim([20 80])



fg=diff_circ-diff_bg;
for i=1:111
    p_fg(i)=signrank(fg(i,:));
end

s=find(p_fg<0.05)
p_fg(s)



for i=1:37
    figure;plot(diff_circ(:,i))
    hold on
    plot(zeros(1,111),'k')
    xlim([20 80])
end



for i=1:23
    figure;plot(x,diff_circ(:,i))
    hold on
    plot(x,diff_bg_in(:,i),'r')
    plot(x,zeros(1,111),'k')
    xlim([-100 400])
end

figure;errorbar(mean(time_circ_cont(2:112,:),2),std(time_circ_cont(2:112,:),0,2)/sqrt(size(time_circ_cont(2:112,:),2)));
hold on
errorbar(mean(time_circ_non(2:112,:),2),std(time_circ_non(2:112,:),0,2)/sqrt(size(time_circ_non(2:112,:),2)),'r');
xlim([20 80])



diff_circ2=time_circ_cont(2:112,:)-time_circ_non(2:112,:);
diff_bg_in2=time_bgi_cont(2:112,:)-time_bgi_non(2:112,:);


diff_bg_in2=cont_bg_in-non_bg_in;
diff_circ2=cont_circle_diff-non_circle_diff;



figure;errorbar(x,mean(diff_circ-diff_bg_in,2),std(diff_circ-diff_bg_in,0,2)/sqrt(size(diff_circ,2)));
hold on
plot(x,zeros(1,111),'k')
xlim([-100 300])

figure;errorbar(x,mean(diff_circ_out-diff_bg_out,2),std(diff_circ_out-diff_bg_out,0,2)/sqrt(size(diff_circ_out,2)));
hold on
plot(x,zeros(1,111),'k')
xlim([-100 300])



%[24 25 28:35]
x=(20:10:1120)-280;
figure;errorbar(x,mean(diff_circ(:,[1:4 8 10 14 17]),2),std(diff_circ(:,[1:4 8 10 14 17]),0,2)/sqrt(size(diff_circ(:,[1:4 8 10 14 17]),2)));
hold on
errorbar(x,mean(diff_bg_out,2),std(diff_bg_out,0,2)/sqrt(size(diff_bg_out,2)),'r');
plot(x,zeros(1,111),'k')
xlim([-100 400])

figure;errorbar(mean(diff_circ2,2),std(diff_circ2,0,2)/sqrt(size(diff_circ2,2)));
hold on
errorbar(mean(diff_bg_in2,2),std(diff_bg_in2,0,2)/sqrt(size(diff_bg_in2,2)),'r');
plot(zeros(1,111),'k')
xlim([20 60])


figure;errorbar(x,mean(diff_circ-diff_bg,2),std(diff_circ-diff_bg,0,2)/sqrt(size(diff_circ,2)));
hold on
errorbar(x,mean(diff_circ2-diff_bg_in2,2),std(diff_circ2-diff_bg_in2,0,2)/sqrt(size(diff_bg_in2,2)),'r');
xlim([20 60])
legend('Monkey S','Monkey L')
plot(x,zeros(1,111),'k')

figure;errorbar(x,mean(diff_circ(:,[24 25 28:35])-diff_bg_out,2),std(diff_circ(:,[24 25 28:35])-diff_bg_out,0,2)/sqrt(size(diff_circ(:,[24 25 28:35]),2)));
xlim([-100 400])


smeg_diff=diff_circ(:,[24 25 28:35])-diff_bg_out;
leg_diff=diff_circ2-diff_bg_in2;

for i=1:111
    ps(i)=signrank(smeg_diff(i,:));
    pl(i)=signrank(leg_diff(i,:));
end

x(ps<0.05)
ps(ps<0.05)

x(pl<0.05)
pl(pl<0.05)


for i=1:111
    p1(i)=signrank(diff_circ(i,:));
    %p2(i)=signrank(diff_bg_in(i,:));
    p3(i)=signrank(diff_bg_out(i,:));
    p4(i)=signrank(diff_V2_circ(i,:));
    p5(i)=signrank(diff_V2_bg(i,:));
    %p6(i)=signrank(diff_circ_diff(i,:));
end

x(p1<0.05)
p1(p1<0.05)

x(p2<0.05)
p2(p2<0.05)

x(p3<0.05)
p3(p3<0.05)

x(p4<0.05)
p4(p4<0.05)

x(p5<0.05)
p5(p5<0.05)

x(p6<0.05)
p6(p6<0.05)

%%

cont_circ_stage2=mean(cont_circle(43:53,[24 25 28:35]),1);
cont_bg_in_stage2=mean(cont_bg_in(43:53,:),1);
cont_bg_out_stage2=mean(cont_bg_out(43:53,:),1);

non_circ_stage2=mean(non_circle(43:53,[24 25 28:35]),1);
non_bg_in_stage2=mean(non_bg_in(43:53,:),1);
non_bg_out_stage2=mean(non_bg_out(43:53,:),1);

%smeagol
diff_circ_stage2=cont_circ_stage2-non_circ_stage2;
diff_bg_in_stage2=cont_bg_in_stage2-non_bg_in_stage2;
diff_bg_out_stage2=cont_bg_out_stage2-non_bg_out_stage2;

%legolas
diff_circ_stage2=mean(time_circ(44:54,:),1);
diff_bg_in_stage2=mean(time_bgi(44:54,:),1);
diff_bg_out_stage2=mean(time_bgo(44:54,:),1);

m=[mean(diff_circ_stage2) mean(diff_bg_out_stage2)];
s=[std(diff_circ_stage2)/sqrt(size(diff_circ_stage2,2)) std(diff_bg_out_stage2)/sqrt(size(diff_bg_out_stage2,2))];
figure;bar(m)
hold on
errorbar(m,s)


ranksum(diff_bg_in_stage2,diff_circ_stage2)
ranksum(diff_bg_out_stage2,diff_circ_stage2)
ranksum(diff_bg_out_stage2,diff_bg_in_stage2)

signrank(diff_circ_stage2)
signrank(diff_bg_in_stage2)
signrank(diff_bg_out_stage2)


%stage1
cont_circ_stage1=mean(cont_circle(32:42,[24 25 28:35]),1);
cont_bg_in_stage1=mean(cont_bg_in(32:42,:),1);
cont_bg_out_stage1=mean(cont_bg_out(32:42,:),1);

non_circ_stage1=mean(non_circle(32:42,[24 25 28:35]),1);
non_bg_in_stage1=mean(non_bg_in(32:42,:),1);
non_bg_out_stage1=mean(non_bg_out(32:42,:),1);


diff_circ_stage1=cont_circ_stage1-non_circ_stage1;
diff_bg_in_stage1=cont_bg_in_stage1-non_bg_in_stage1;
diff_bg_out_stage1=cont_bg_out_stage1-non_bg_out_stage1;

%legolas
diff_circ_stage1=mean(time_circ(33:43,:),1);
diff_bg_in_stage1=mean(time_bgi(33:43,:),1);
diff_bg_out_stage1=mean(time_bgo(33:43,:),1);

m=[mean(diff_circ_stage1) mean(diff_bg_out_stage1)];
s=[std(diff_circ_stage1)/sqrt(size(diff_circ_stage1,2)) std(diff_bg_out_stage1)/sqrt(size(diff_bg_out_stage1,2))];
figure;bar(m)
hold on
errorbar(m,s)


ranksum(diff_bg_in_stage1,diff_circ_stage1)
ranksum(diff_bg_out_stage1,diff_circ_stage1)
ranksum(diff_bg_out_stage1,diff_bg_in_stage1)

signrank(diff_circ_stage1)
signrank(diff_bg_in_stage1)
signrank(diff_bg_out_stage1)




%%

figure;errorbar(mean(time_circ_cont(2:112,:),2),std(time_circ_cont(2:112,:),0,2)/sqrt(size(time_circ_cont,2)));
hold on
errorbar(mean(time_circ_non(2:112,:),2),std(time_circ_non(2:112,:),0,2)/sqrt(size(time_circ_non(2:112,:),2)),'r');
xlim([18 58])



figure;errorbar(mean(time_bgi_cont(2:112,:),2),std(time_bgi_cont(2:112,:),0,2)/sqrt(size(time_bgi_cont(2:112,:),2)));
hold on
errorbar(mean(time_bgi_non(2:112,:),2),std(time_bgi_non(2:112,:),0,2)/sqrt(size(time_bgi_non(2:112,:),2)),'r');
xlim([18 58])


%% stages V1

time1=32:42;
time2=43:53;
%stage 1
m_s1=[mean(mean(cont_bg_out(time1,:)))-1 mean(mean(non_bg_out(time1,:)))-1 mean(mean(cont_circle(time1,:)))-1 mean(mean(non_circle(time1,:)))-1];
s_s1=[std(mean(cont_bg_out(time1,:)))/sqrt(size(cont_bg_out,2)) std(mean(non_bg_out(time1,:)))/sqrt(size(non_bg_out,2)) std(mean(cont_circle(time1,:)))/sqrt(size(cont_circle,2)) std(mean(non_circle(time1,:)))/sqrt(size(non_circle,2))];

figure;bar(m_s1)
hold on
errorbar(m_s1,s_s1)

ranksum(mean(cont_bg_out(time1,:),1),mean(non_bg_out(time1,:),1))
ranksum(mean(cont_circle(time1,:),1),mean(non_circle(time1,:),1))


%stage 2
m_s2=[mean(mean(cont_bg_out(time2,:)))-1 mean(mean(non_bg_out(time2,:)))-1 mean(mean(cont_circle(time2,:)))-1 mean(mean(non_circle(time2,:)))-1];
s_s2=[std(mean(cont_bg_out(time2,:)))/sqrt(size(cont_bg_out,2)) std(mean(non_bg_out(time2,:)))/sqrt(size(non_bg_out,2)) std(mean(cont_circle(time2,:)))/sqrt(size(cont_circle,2)) std(mean(non_circle(time2,:)))/sqrt(size(non_circle,2))];

figure;bar(m_s2)
hold on
errorbar(m_s2,s_s2)

ranksum(mean(cont_bg_out(time2,:),1),mean(non_bg_out(time2,:),1))
ranksum(mean(cont_circle(time2,:),1),mean(non_circle(time2,:),1))




%% V2
figure;errorbar(nanmean(cont_V2_circle,2),nanstd(cont_V2_circle,0,2)/sqrt(size(cont_V2_circle,2)));
hold on
errorbar(nanmean(non_V2_circle,2),nanstd(non_V2_circle,0,2)/sqrt(size(non_V2_circle,2)),'r');
xlim([18 68])

figure;errorbar(nanmean(cont_V2_bg,2),nanstd(cont_V2_bg,0,2)/sqrt(size(cont_V2_bg,2)));
hold on
errorbar(nanmean(non_V2_bg,2),nanstd(non_V2_bg,0,2)/sqrt(size(non_V2_bg,2)),'r');
xlim([18 68])


figure;errorbar(nanmean(cont_V2_circle(:,[1:21 26 27 36 37]),2),nanstd(cont_V2_circle(:,[1:21 26 27 36 37]),0,2)/sqrt(size(cont_V2_circle(:,[1:21 26 27 36 37]),2)));
hold on
errorbar(nanmean(non_V2_circle(:,[1:21 26 27 36 37]),2),nanstd(non_V2_circle(:,[1:21 26 27 36 37]),0,2)/sqrt(size(non_V2_circle(:,[1:21 26 27 36 37]),2)),'r');

figure;errorbar(nanmean(cont_V2_bg(:,[24 25 28:35]),2),nanstd(cont_V2_bg(:,[24 25 28:35]),0,2)/sqrt(size(cont_V2_bg(:,[24 25 28:35]),2)));
hold on
errorbar(nanmean(non_V2_bg(:,[24 25 28:35]),2),nanstd(non_V2_bg(:,[24 25 28:35]),0,2)/sqrt(size(non_V2_bg(:,[24 25 28:35]),2)),'r');


diff_V2_circle=cont_V2_circle-non_V2_circle;
diff_V2_bg=cont_V2_bg-non_V2_bg;


x=(20:10:1120)-280;
figure;errorbar(x,nanmean(diff_V2_circle(:,[1:23 26 27 36 37]),2),nanstd(diff_V2_circle(:,[1:23 26 27 36 37]),0,2)/sqrt(size(diff_V2_circle(:,[1:23 26 27 36 37]),2)));
hold on
errorbar(x,nanmean(diff_V2_bg(:,[24 25 28:35]),2),nanstd(diff_V2_bg(:,[24 25 28:35]),0,2)/sqrt(size(diff_V2_bg(:,[24 25 28:35]),2)),'r');
plot(x,zeros(1,111),'k')
xlim([-100 300])

x=(20:10:1120)-280;
figure;errorbar(x,nanmean(diff_circle(:,[1:23 26 27 36 37]),2),nanstd(diff_circle(:,[1:23 26 27 36 37]),0,2)/sqrt(size(diff_circle(:,[1:23 26 27 36 37]),2)));
hold on
errorbar(x,nanmean(diff_bg(:,[24 25 28:35]),2),nanstd(diff_bg(:,[24 25 28:35]),0,2)/sqrt(size(diff_bg(:,[24 25 28:35]),2)),'r');
plot(x,zeros(1,111),'k')
xlim([-100 300])





for i=1:7
    figure;plot(x,diff_V2_bg(:,i),'r')
    hold on
    plot(x,zeros(1,111),'k')
    plot(x,diff_bg_out(:,i))
    xlim([-100 300])
    title(['session ',int2str(i)])
end


for i=[15 16 17]
    figure;plot(x,diff_circ(:,i))
    hold on
    plot(x,zeros(1,111),'k')
    plot(x,diff_V2_circ(:,i),'c')
    xlim([-100 300])
    title(['session ',int2str(i)])
end





for i=[24 25 28:35]
    figure;plot(x,diff_bg(:,i),'r')
    hold on
    plot(x,zeros(1,111),'k')
    plot(x,diff_V2_bg(:,i),'m')
    xlim([-100 300])
    title(['session ',int2str(i)])
end

figure;plot(x,mean(cont_V2_bg,2)-mean(non_V2_bg,2),'r')
hold on
plot(x,zeros(1,111),'k')
xlim([-100 500])
plot(x,nanmean(cont_bg_out,2)-nanmean(non_bg_out,2))


figure;plot(x,nanmean(diff_V2_circ-diff_circ,2))
hold on
plot(x,zeros(1,111),'k')

x=(20:10:1120)-280;
figure;errorbar(x,nanmean(diff_V2_circ(:,ses_c),2),nanstd(diff_V2_circ(:,ses_c),0,2)/sqrt(size(diff_V2_circ(:,ses_c),2)));
hold on
errorbar(x,nanmean(diff_V2_bg(:,ses_b),2),nanstd(diff_V2_bg(:,ses_c),0,2)/sqrt(size(diff_V2_bg(:,ses_c),2)),'r');
plot(x,zeros(1,111),'k')
xlim([-100 300])

x=(20:10:1120)-280;
figure;errorbar(x,nanmean(diff_circ(:,ses_c),2),nanstd(diff_circ(:,ses_c),0,2)/sqrt(size(diff_circ(:,ses_c),2)));
hold on
errorbar(x,nanmean(diff_bg(:,ses_b),2),nanstd(diff_bg(:,ses_b),0,2)/sqrt(size(diff_bg(:,ses_b),2)),'r');
plot(x,zeros(1,111),'k')
xlim([-100 300])

xlim([-100 500])




diff=diff_V2_circ(:,1:9)-diff_circ(:,1:9);
x=(20:10:1120)-280;
figure;errorbar(x,mean(diff,2),std(diff,0,2)/sqrt(size(diff,2)));
hold on
plot(x,zeros(1,111),'k')
xlim([-100 500])


for i=1:37
    figure;plot(x,diff(:,i))
    hold on
    plot(x,zeros(1,111),'k')
    xlim([-100 500])
end





diff_circ=cont_circle-non_circle;

x=(20:10:1120)-280;
figure;errorbar(x,mean(diff_circ(:,[1:21 26 27 36 37]),2),std(diff_circ(:,[1:21 26 27 36 37]),0,2)/sqrt(size(diff_circ(:,[1:21 26 27 36 37]),2)));
hold on
errorbar(x,mean(diff_bg_in(:,[24 25 28:35]),2),std(diff_bg_in(:,[24 25 28:35]),0,2)/sqrt(size(diff_bg_in(:,[24 25 28:35]),2)),'r');
plot(x,zeros(1,111),'k')
xlim([-100 500])




diff_c=diff_V2_circ-diff_circ;
diff_b=diff_V2_bg-diff_bg;

x=(20:10:1120)-280;
figure;errorbar(x,nanmean(diff_c(:,[1:23 26 27 36 37]),2),nanstd(diff_c(:,[1:23 26 27 36 37]),0,2)/sqrt(size(diff_c(:,[1:23 26 27 36 37]),2)));
hold on
errorbar(x,nanmean(diff_b(:,[24 25 28:35]),2),nanstd(diff_b(:,[24 25 28:35]),0,2)/sqrt(size(diff_b(:,[24 25 28:35]),2)),'r');
plot(x,zeros(1,111),'k')
xlim([-100 500])






%% stages V2

time1=32:42;
time2=43:53;
%stage 1
m_s1=[mean(mean(cont_V2_bg(time1,[24 25 28:35])))-1 mean(mean(non_V2_bg(time1,[24 25 28:35])))-1 mean(mean(cont_V2_circle(time1,[1:23 26 27 36 37])))-1 mean(mean(non_V2_circle(time1,[1:23 26 27 36 37])))-1];
s_s1=[std(mean(cont_V2_bg(time1,[24 25 28:35])))/sqrt(size(cont_V2_bg(time1,[24 25 28:35]),2)) std(mean(non_V2_bg(time1,[24 25 28:35])))/sqrt(size(non_V2_bg(time1,[24 25 28:35]),2)) std(mean(cont_V2_circle(time1,[1:23 26 27 36 37])))/sqrt(size(cont_V2_circle(time1,[1:23 26 27 36 37]),2)) std(mean(non_V2_circle(time1,[1:23 26 27 36 37])))/sqrt(size(non_V2_circle(time1,[1:23 26 27 36 37]),2))];

figure;bar(m_s1)
hold on
errorbar(m_s1,s_s1)

ranksum(mean(cont_V2_bg(time1,[24 25 28:35]),1),mean(non_V2_bg(time1,[24 25 28:35]),1))
ranksum(mean(cont_V2_circle(time1,[1:23 26 27 36 37]),1),mean(non_V2_circle(time1,[1:23 26 27 36 37]),1))


%stage 2

m_s2=[mean(mean(cont_V2_bg(time2,[24 25 28:35])))-1 mean(mean(non_V2_bg(time2,[24 25 28:35])))-1 mean(mean(cont_V2_circle(time2,[1:23 26 27 36 37])))-1 mean(mean(non_V2_circle(time2,[1:23 26 27 36 37])))-1];
s_s2=[std(mean(cont_V2_bg(time2,[24 25 28:35])))/sqrt(size(cont_V2_bg(time2,[24 25 28:35]),2)) std(mean(non_V2_bg(time2,[24 25 28:35])))/sqrt(size(non_V2_bg(time2,[24 25 28:35]),2)) std(mean(cont_V2_circle(time2,[1:23 26 27 36 37])))/sqrt(size(cont_V2_circle(time2,[1:23 26 27 36 37]),2)) std(mean(non_V2_circle(time2,[1:23 26 27 36 37])))/sqrt(size(non_V2_circle(time2,[1:23 26 27 36 37]),2))];

figure;bar(m_s2)
hold on
errorbar(m_s2,s_s2)

ranksum(mean(cont_V2_bg(time2,[24 25 28:35]),1),mean(non_V2_bg(time2,[24 25 28:35]),1))
ranksum(mean(cont_V2_circle(time2,[1:23 26 27 36 37]),1),mean(non_V2_circle(time2,[1:23 26 27 36 37]),1))


%diffs

m_s1=[mean(mean(diff_V2_bg(time1,[24 25 28:35]))) mean(mean(diff_V2_circ(time1,[1:23 26 27 36 37])))];
s_s1=[std(mean(diff_V2_bg(time1,[24 25 28:35])))/sqrt(size(diff_V2_bg(time1,[24 25 28:35]),2)) std(mean(diff_V2_circ(time1,[1:23 26 27 36 37])))/sqrt(size(diff_V2_circ(time1,[1:23 26 27 36 37]),2))];

figure;bar(m_s1)
hold on
errorbar(m_s1,s_s1)

signrank(mean(diff_V2_bg(time1,[24 25 28:35]),1))
signrank(mean(diff_V2_circ(time1,[1:23 26 27 36 37]),1))


m_s2=[mean(mean(diff_V2_bg(time2,[24 25 28:35]))) mean(mean(diff_V2_circ(time2,[1:23 26 27 36 37])))];
s_s2=[std(mean(diff_V2_bg(time2,[24 25 28:35])))/sqrt(size(diff_V2_bg(time2,[24 25 28:35]),2)) std(mean(diff_V2_circ(time2,[1:23 26 27 36 37])))/sqrt(size(diff_V2_circ(time2,[1:23 26 27 36 37]),2))];

figure;bar(m_s2)
hold on
errorbar(m_s2,s_s2)

signrank(mean(diff_V2_bg(time2,[24 25 28:35]),1))
signrank(mean(diff_V2_circ(time2,[1:23 26 27 36 37]),1))


%% test different session
ses_c=[1:14 18 19 22 23];
ses_c=[24 25 28:33];
ses_b=[24 25 28:33];
%ses_c=20:37;
%ses_b=20:37;

diff_circ=cont_circle-non_circle;
diff_bg=cont_bg-non_bg;
diff_V2_circ=cont_V2_circle-non_V2_circle;
diff_V2_bg=cont_V2_bg-non_V2_bg;


x=(20:10:1120)-280;
figure;errorbar(x,nanmean(diff_V2_circ(:,ses_c),2),nanstd(diff_V2_circ(:,ses_c),0,2)/sqrt(size(diff_V2_circ(:,ses_c),2)));
hold on
errorbar(x,nanmean(diff_V2_bg(:,ses_b),2),nanstd(diff_V2_bg(:,ses_c),0,2)/sqrt(size(diff_V2_bg(:,ses_c),2)),'r');
plot(x,zeros(1,111),'k')
xlim([-100 300])

x=(20:10:1120)-280;
figure;errorbar(x,nanmean(diff_circ(:,ses_c),2),nanstd(diff_circ(:,ses_c),0,2)/sqrt(size(diff_circ(:,ses_c),2)));
hold on
errorbar(x,nanmean(diff_bg(:,ses_b),2),nanstd(diff_bg(:,ses_b),0,2)/sqrt(size(diff_bg(:,ses_b),2)),'r');
plot(x,zeros(1,111),'k')
xlim([-200 300])


for i=1:111
    p1(i)=signrank(diff_circ(i,ses_c));
    p2(i)=signrank(diff_bg(i,ses_b));
    p3(i)=signrank(diff_V2_circ(i,ses_c));
    p4(i)=signrank(diff_V2_bg(i,ses_b));
end

x(p1<0.05)
p1(p1<0.05)

x(p2<0.05)
p2(p2<0.05)

x(p3<0.05)
p3(p3<0.05)

x(p4<0.05)
p4(p4<0.05)


diff_c=diff_V2_circ-diff_circ;
diff_b=diff_V2_bg-diff_bg;

x=(20:10:1120)-280;
figure;errorbar(x,nanmean(diff_c(:,ses_c),2),nanstd(diff_c(:,ses_c),0,2)/sqrt(size(diff_c(:,ses_c),2)));
hold on
errorbar(x,nanmean(diff_b(:,ses_b),2),nanstd(diff_b(:,ses_b),0,2)/sqrt(size(diff_b(:,ses_b),2)),'r');
plot(x,zeros(1,111),'k')
xlim([-100 350])


diff=diff_circ-diff_bg;

x=(20:10:1120)-280;
figure;errorbar(x,nanmean(diff(:,ses_c),2),nanstd(diff(:,ses_c),0,2)/sqrt(size(diff(:,ses_c),2)));
hold on
plot(x,zeros(1,111),'k')
xlim([-100 350])


%% legolas

x=(20:10:1120)-280;
figure;errorbar(x,nanmean(diff_V2_circ(:,:),2),nanstd(diff_V2_circ(:,:),0,2)/sqrt(size(diff_V2_circ(:,:),2)));
hold on
errorbar(x,nanmean(diff_V2_bg(:,:),2),nanstd(diff_V2_bg(:,:),0,2)/sqrt(size(diff_V2_bg(:,:),2)),'r');
plot(x,zeros(1,111),'k')
xlim([-100 300])

x=(20:10:1120)-280;
figure;errorbar(x,nanmean(diff_circ(:,:),2),nanstd(diff_circ(:,:),0,2)/sqrt(size(diff_circ(:,:),2)));
hold on
errorbar(x,nanmean(diff_bg_in(:,:),2),nanstd(diff_bg_in(:,:),0,2)/sqrt(size(diff_bg_in(:,:),2)),'r');
%errorbar(x,nanmean(diff_bg_out(:,:),2),nanstd(diff_bg_out(:,:),0,2)/sqrt(size(diff_bg_in(:,:),2)),'g');
plot(x,zeros(1,111),'k')
xlim([-100 300])




x=(20:10:1120)-280;
figure;errorbar(x,nanmean(diff_circ_diff(:,:),2),nanstd(diff_circ_diff(:,:),0,2)/sqrt(size(diff_circ_diff(:,:),2)));
hold on
errorbar(x,nanmean(diff_bg_in(:,:),2),nanstd(diff_bg_in(:,:),0,2)/sqrt(size(diff_bg_in(:,:),2)),'r');
%errorbar(x,nanmean(diff_bg_out(:,:),2),nanstd(diff_bg_out(:,:),0,2)/sqrt(size(diff_bg_in(:,:),2)),'g');
plot(x,zeros(1,111),'k')
xlim([-100 300])







diff_c=diff_V2_circ-diff_circ(:,[1:13 26 27 29 32 33 20:23]);
diff_b=diff_V2_bg-diff_bg_out;

x=(20:10:1120)-280;
figure;errorbar(x,nanmean(diff_c(:,:),2),nanstd(diff_c(:,:),0,2)/sqrt(size(diff_c(:,:),2)));
hold on
errorbar(x,nanmean(diff_b(:,:),2),nanstd(diff_b(:,:),0,2)/sqrt(size(diff_b(:,:),2)),'r');
plot(x,zeros(1,111),'k')
xlim([-100 350])


u=[1:13 26 27 29 32 33 20:23];
for i=1:22    
    figure;plot(x,diff_circ(:,u(i)))
    hold on
    plot(x,zeros(1,111),'k')
    plot(x,diff_V2_circ(:,i),'c')
    xlim([-100 300])
    title(['session ',int2str(i)])
end



%% plot for a specific session


figure;plot(mean(a(roi_V2_bg,2:112,:)-1,1))
hold on
plot(mean(b(roi_V2_bg,2:112,:)-1,1),'r')


figure;plot(mean(a(roi_V2_circle,2:112,:)-1,1))
hold on
plot(mean(b(roi_V2_circle,2:112,:)-1,1),'r')

figure;plot(mean(c(roi_V2_circle,2:112,:)-1,1))
hold on
plot(mean(d(roi_V2_circle,2:112,:)-1,1),'r')


figure;plot(mean(a(roi_V2_circ_middle,2:112,:)-1,1))
hold on
plot(mean(b(roi_V2_circ_middle,2:112,:)-1,1),'r')


figure;plot(mean(a(roi_V2_bg_middle,2:112,:)-1,1))
hold on
plot(mean(b(roi_V2_bg_middle,2:112,:)-1,1),'r')


figure;plot(mean(a(roi_V2_bg_right,2:112,:)-1,1))
hold on
plot(mean(b(roi_V2_bg_right,2:112,:)-1,1),'r')


figure;plot(mean(a(roi_V2_bg_left,2:112,:)-1,1))
hold on
plot(mean(b(roi_V2_bg_left,2:112,:)-1,1),'r')


figure;plot(mean(a(roi,2:112,:)-1,1))
hold on
plot(mean(b(roi,2:112,:)-1,1),'r')
xlim([18 58])

figure;plot(mean(c(roi,2:112,:)-1,1))
hold on
plot(mean(d(roi,2:112,:)-1,1),'r')
xlim([18 58])


figure;plot(mean(a(roi_bg_in,2:112,:)-1,1))
hold on
plot(mean(b(roi_bg_in,2:112,:)-1,1),'r')
xlim([18 58])


figure;plot(mean(c(roi_bg_in,2:112,:)-1,1))
hold on
plot(mean(d(roi_bg_in,2:112,:)-1,1),'r')
xlim([18 58])


figure;plot(mean(a(roi_circle,2:112,:)-1,1))
hold on
plot(mean(b(roi_circle,2:112,:)-1,1),'r')
xlim([18 58])

figure;plot(mean(c(roi_circle,2:112,:)-1,1))
hold on
plot(mean(d(roi_circle,2:112,:)-1,1),'r')
xlim([18 58])


figure;plot(mean(a(roi_bg_out,2:112,:)-1,1))
hold on
plot(mean(b(roi_bg_out,2:112,:)-1,1),'r')
xlim([18 58])


figure;plot(mean(a(roi_V2,2:112,:)-1,1))
hold on
plot(mean(b(roi_V2,2:112,:)-1,1),'r')


figure;plot(mean(a(roi_maskout,2:112,:)-1,1))
hold on
plot(mean(b(roi_maskout,2:112,:)-1,1),'r')




figure;plot(mean(a(roi_V2_circle,2:112)-b(roi_V2_circle,2:112),1))
hold on
plot(zeros(1,111),'k')
xlim([18 58])

figure;plot(mean(c(roi_V2_circle,2:112)-d(roi_V2_circle,2:112),1))
hold on
plot(zeros(1,111),'k')
xlim([18 58])


figure;plot(mean(a(roi_V2_bg,2:112)-b(roi_V2_bg,2:112),1))
hold on
plot(zeros(1,111),'k')
xlim([18 58])

figure;plot(mean(c(roi_V2_bg,2:112)-d(roi_V2_bg,2:112),1))
hold on
plot(zeros(1,111),'k')
xlim([18 58])

figure;plot(mean(a(roi_V2_circ_right,2:112)-b(roi_V2_circ_right,2:112),1))
hold on
plot(zeros(1,111),'k')
xlim([18 58])


figure;plot(mean(a(roi_circle,2:112)-b(roi_circle,2:112),1))
hold on
plot(zeros(1,111),'k')
xlim([18 58])

figure;plot(mean(c(roi_circle,2:112)-d(roi_circle,2:112),1))
hold on
plot(zeros(1,111),'k')
xlim([18 58])




figure;plot(mean(a(roi,2:112)-b(roi,2:112),1))
hold on
plot(zeros(1,111),'k')
xlim([18 58])


figure;plot(mean(c(roi,2:112)-d(roi,2:112),1))
hold on
plot(zeros(1,111),'k')
xlim([18 58])




figure;plot(mean(a(roi_bg_in,2:112)-b(roi_bg_in,2:112),1))
hold on
plot(zeros(1,111),'k')
xlim([18 58])

figure;plot(mean(c(roi_bg_in,2:112)-d(roi_bg_in,2:112),1))
hold on
plot(zeros(1,111),'k')
xlim([18 58])


figure;plot(mean(a(roi_circle_diff,2:112,:)-d(roi_circle_diff,2:112,:),1))
hold on
plot(mean(a(roi_contour,2:112,:)-d(roi_contour,2:112,:),1),'r')
plot(mean(a(roi_bg_in,2:112,:)-d(roi_bg_in,2:112,:),1),'g')
plot(mean(a(roi_V2,2:112,:)-d(roi_V2,2:112,:),1),'m')
plot(zeros(1,111),'k')
xlim([18 58])





figure;plot(mean(a(roi_circle_diff,2:112,:)-b(roi_circle_diff,2:112,:),1))
hold on
plot(mean(a(roi_contour,2:112,:)-b(roi_contour,2:112,:),1),'r')
plot(mean(a(roi_maskin,2:112,:)-b(roi_maskin,2:112,:),1),'g')
plot(mean(a(roi_maskout,2:112,:)-b(roi_maskout,2:112,:),1),'g')
plot(mean(a(roi_V2,2:112,:)-b(roi_V2,2:112,:),1),'m')
plot(zeros(1,111),'k')
xlim([18 68])





figure;plot(mean(a(roi_circle_diff,2:112,:)-b(roi_circle_diff,2:112,:),1))
hold on
plot(mean(a(roi_contour,2:112,:)-b(roi_contour,2:112,:),1),'r')
plot(mean(a(roi_bg_in,2:112,:)-b(roi_bg_in,2:112,:),1),'g')
%plot(mean(a(roi,2:112,:)-b(roi,2:112,:),1),'k')
%plot(mean(a(roi2,2:112,:)-b(roi2,2:112,:),1),'y')
plot(mean(a(roi_V2,2:112,:)-b(roi_V2,2:112,:),1),'m')
plot(zeros(1,111),'k')
xlim([18 68])





figure;plot(mean(a(roi_circle,2:112,:)-b(roi_circle,2:112,:),1))
hold on
%plot(mean(a(roi_contour,2:112,:)-b(roi_contour,2:112,:),1),'r')
plot(mean(a(roi_bg_in,2:112,:)-b(roi_bg_in,2:112,:),1),'g')
%plot(mean(a(roi,2:112,:)-b(roi,2:112,:),1),'k')
%plot(mean(a(roi2,2:112,:)-b(roi2,2:112,:),1),'y')
plot(mean(a(roi_V2,2:112,:)-b(roi_V2,2:112,:),1),'m')
plot(zeros(1,111),'k')
xlim([18 68])



%% some more analysis 24 nov 2011

x=(20:10:1120)-280;

for i=1:57
    p=signrank(diff_bg_in(i,:));
    if p<0.05
        disp(x(i))
        disp(p)
    end
end
        
for i=1:57
    p=signrank(diff_circ_diff(i,:));
    if p<0.05
        disp(x(i))
        disp(p)
    end
end



for i=1:57
    p=signrank(diff_circ_out(i,:));
    if p<0.05
        disp(x(i))
        disp(p)
    end
end


for i=1:57
    p=signrank(diff_bg_out(i,:));
    if p<0.05
        disp(x(i))
        disp(p)
    end
end
        

for i=1:57
    p=signrank(fg_leg(i,:));
    if p<0.05
        disp(x(i))
        disp(p)
    end
end



for i=1:57
    p=signrank(fg_smeg(i,:));
    if p<0.05
        disp(x(i))
        disp(p)
    end
end

