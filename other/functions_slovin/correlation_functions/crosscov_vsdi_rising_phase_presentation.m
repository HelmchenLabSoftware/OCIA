


crosscorr_circ_V2_cont=zeros(31,13);
crosscorr_circ_V2_cont(:,1)=mean(crosscorr_1111c1,2);
crosscorr_circ_V2_cont(:,2)=mean(crosscorr_1111c2,2);
crosscorr_circ_V2_cont(:,3)=mean(crosscorr_1111d1,2);
crosscorr_circ_V2_cont(:,4)=mean(crosscorr_1111d2,2);
crosscorr_circ_V2_cont(:,5)=mean(crosscorr_1811c1,2);
crosscorr_circ_V2_cont(:,6)=mean(crosscorr_1811d1,2);
crosscorr_circ_V2_cont(:,7)=mean(crosscorr_1811e1,2);
crosscorr_circ_V2_cont(:,8)=mean(crosscorr_2511d1,2);
crosscorr_circ_V2_cont(:,9)=mean(crosscorr_2511e1,2);
crosscorr_circ_V2_cont(:,10)=mean(crosscorr_2511f1,2);
crosscorr_circ_V2_cont(:,11)=mean(crosscorr_1203d1,2);
crosscorr_circ_V2_cont(:,12)=mean(crosscorr_1203e1,2);
crosscorr_circ_V2_cont(:,13)=mean(crosscorr_1203f1,2);


crosscorr_circ_V2_non=zeros(31,13);
crosscorr_circ_V2_non(:,1)=mean(crosscorr_1111c4,2);
crosscorr_circ_V2_non(:,2)=mean(crosscorr_1111c5,2);
crosscorr_circ_V2_non(:,3)=mean(crosscorr_1111d4,2);
crosscorr_circ_V2_non(:,4)=mean(crosscorr_1111d5,2);
crosscorr_circ_V2_non(:,5)=mean(crosscorr_1811c5,2);
crosscorr_circ_V2_non(:,6)=mean(crosscorr_1811d5,2);
crosscorr_circ_V2_non(:,7)=mean(crosscorr_1811e5,2);
crosscorr_circ_V2_non(:,8)=mean(crosscorr_2511d5,2);
crosscorr_circ_V2_non(:,9)=mean(crosscorr_2511e5,2);
crosscorr_circ_V2_non(:,10)=mean(crosscorr_2511f5,2);
crosscorr_circ_V2_non(:,11)=mean(crosscorr_1203d5,2);
crosscorr_circ_V2_non(:,12)=mean(crosscorr_1203e5,2);
crosscorr_circ_V2_non(:,13)=mean(crosscorr_1203f5,2);


crosscorr_circ_V2_blank=zeros(31,11);
crosscorr_circ_V2_blank(:,1)=mean(crosscorr_1111c3,2);
crosscorr_circ_V2_blank(:,2)=mean(crosscorr_1111d3,2);
crosscorr_circ_V2_blank(:,3)=mean(crosscorr_1811c3,2);
crosscorr_circ_V2_blank(:,4)=mean(crosscorr_1811d3,2);
crosscorr_circ_V2_blank(:,5)=mean(crosscorr_1811e3,2);
crosscorr_circ_V2_blank(:,6)=mean(crosscorr_2511d3,2);
crosscorr_circ_V2_blank(:,7)=mean(crosscorr_2511e3,2);
crosscorr_circ_V2_blank(:,8)=mean(crosscorr_2511f3,2);
crosscorr_circ_V2_blank(:,9)=mean(crosscorr_1203d3,2);
crosscorr_circ_V2_blank(:,10)=mean(crosscorr_1203e3,2);
crosscorr_circ_V2_blank(:,11)=mean(crosscorr_1203f3,2);


x=-150:10:150;
figure;
errorbar(x,mean(crosscorr_circ_V2_cont,2),std(crosscorr_circ_V2_cont,0,2)/sqrt(size(crosscorr_circ_V2_cont,2)));
hold on
errorbar(x,mean(crosscorr_circ_V2_non,2),std(crosscorr_circ_V2_non,0,2)/sqrt(size(crosscorr_circ_V2_non,2)),'r');
errorbar(x,mean(crosscorr_circ_V2_blank,2),std(crosscorr_circ_V2_blank,0,2)/sqrt(size(crosscorr_circ_V2_blank,2)),'g');




figure;
errorbar(x,mean(crosscorr_circ_V2_cont-crosscorr_circ_V2_non,2),std(crosscorr_circ_V2_cont-crosscorr_circ_V2_non,0,2)/sqrt(size(crosscorr_circ_V2_cont,2)));




x=-500:10:500;
figure;
errorbar(x,mean(crosscorr_2511d1,2),std(crosscorr_2511f1,0,2)/sqrt(size(crosscorr_2511f1,2)));
hold on
errorbar(x,mean(crosscorr_2511d5,2),std(crosscorr_2511f5,0,2)/sqrt(size(crosscorr_2511f5,2)),'r');


%%

crosscorr_cont_V2_circ=zeros(101,13);
crosscorr_non_V2_circ=zeros(101,13);

crosscorr_cont_V2_circ(:,1)=xcorr(squeeze(mean(mean(cond1n_dt_bl(roi_V2,18:68,:),1),3)),squeeze(mean(mean(cond1n_dt_bl(roi_contour2,18:68,:),1),3)),'coeff');
crosscorr_non_V2_circ(:,1)=xcorr(squeeze(mean(mean(cond4n_dt_bl(roi_V2,18:68,:),1),3)),squeeze(mean(mean(cond4n_dt_bl(roi_contour2,18:68,:),1),3)),'coeff');

crosscorr_cont_V2_circ(:,2)=xcorr(squeeze(mean(mean(cond2n_dt_bl(roi_V2,18:68,:),1),3)),squeeze(mean(mean(cond2n_dt_bl(roi_contour2,18:68,:),1),3)),'coeff');
crosscorr_non_V2_circ(:,2)=xcorr(squeeze(mean(mean(cond5n_dt_bl(roi_V2,18:68,:),1),3)),squeeze(mean(mean(cond5n_dt_bl(roi_contour2,18:68,:),1),3)),'coeff');

crosscorr_cont_V2_circ(:,3)=xcorr(squeeze(mean(mean(cond1n_dt_bl(roi_V2,18:68,:),1),3)),squeeze(mean(mean(cond1n_dt_bl(roi_contour2,18:68,:),1),3)),'coeff');
crosscorr_non_V2_circ(:,3)=xcorr(squeeze(mean(mean(cond4n_dt_bl(roi_V2,18:68,:),1),3)),squeeze(mean(mean(cond4n_dt_bl(roi_contour2,18:68,:),1),3)),'coeff');

crosscorr_cont_V2_circ(:,4)=xcorr(squeeze(mean(mean(cond2n_dt_bl(roi_V2,18:68,:),1),3)),squeeze(mean(mean(cond2n_dt_bl(roi_contour2,18:68,:),1),3)),'coeff');
crosscorr_non_V2_circ(:,4)=xcorr(squeeze(mean(mean(cond5n_dt_bl(roi_V2,18:68,:),1),3)),squeeze(mean(mean(cond5n_dt_bl(roi_contour2,18:68,:),1),3)),'coeff');

crosscorr_cont_V2_circ(:,5)=xcorr(squeeze(mean(mean(cond1n_dt_bl(roi_V2,18:68,:),1),3)),squeeze(mean(mean(cond1n_dt_bl(roi_contour,18:68,:),1),3)),'coeff');
crosscorr_non_V2_circ(:,5)=xcorr(squeeze(mean(mean(cond5n_dt_bl(roi_V2,18:68,:),1),3)),squeeze(mean(mean(cond5n_dt_bl(roi_contour,18:68,:),1),3)),'coeff');

crosscorr_cont_V2_circ(:,6)=xcorr(squeeze(mean(mean(cond1n_dt_bl(roi_V2,18:68,:),1),3)),squeeze(mean(mean(cond1n_dt_bl(roi_contour,18:68,:),1),3)),'coeff');
crosscorr_non_V2_circ(:,6)=xcorr(squeeze(mean(mean(cond5n_dt_bl(roi_V2,18:68,:),1),3)),squeeze(mean(mean(cond5n_dt_bl(roi_contour,18:68,:),1),3)),'coeff');

crosscorr_cont_V2_circ(:,7)=xcorr(squeeze(mean(mean(cond1n_dt_bl(roi_V2,18:68,:),1),3)),squeeze(mean(mean(cond1n_dt_bl(roi_contour,18:68,:),1),3)),'coeff');
crosscorr_non_V2_circ(:,7)=xcorr(squeeze(mean(mean(cond5n_dt_bl(roi_V2,18:68,:),1),3)),squeeze(mean(mean(cond5n_dt_bl(roi_contour,18:68,:),1),3)),'coeff');

crosscorr_cont_V2_circ(:,8)=xcorr(squeeze(mean(mean(cond1n_dt_bl(roi_V2,18:68,:),1),3)),squeeze(mean(mean(cond1n_dt_bl(roi_contour,18:68,:),1),3)),'coeff');
crosscorr_non_V2_circ(:,8)=xcorr(squeeze(mean(mean(cond5n_dt_bl(roi_V2,18:68,:),1),3)),squeeze(mean(mean(cond5n_dt_bl(roi_contour,18:68,:),1),3)),'coeff');

crosscorr_cont_V2_circ(:,9)=xcorr(squeeze(mean(mean(cond1n_dt_bl(roi_V2,18:68,:),1),3)),squeeze(mean(mean(cond1n_dt_bl(roi_contour,18:68,:),1),3)),'coeff');
crosscorr_non_V2_circ(:,9)=xcorr(squeeze(mean(mean(cond5n_dt_bl(roi_V2,18:68,:),1),3)),squeeze(mean(mean(cond5n_dt_bl(roi_contour,18:68,:),1),3)),'coeff');

crosscorr_cont_V2_circ(:,10)=xcorr(squeeze(mean(mean(cond1n_dt_bl(roi_V2,18:68,:),1),3)),squeeze(mean(mean(cond1n_dt_bl(roi_contour,18:68,:),1),3)),'coeff');
crosscorr_non_V2_circ(:,10)=xcorr(squeeze(mean(mean(cond5n_dt_bl(roi_V2,18:68,:),1),3)),squeeze(mean(mean(cond5n_dt_bl(roi_contour,18:68,:),1),3)),'coeff');

crosscorr_cont_V2_circ(:,11)=xcorr(squeeze(mean(mean(cond1n_dt_bl(roi_V2,18:68,:),1),3)),squeeze(mean(mean(cond1n_dt_bl(roi_contour,18:68,:),1),3)),'coeff');
crosscorr_non_V2_circ(:,11)=xcorr(squeeze(mean(mean(cond5n_dt_bl(roi_V2,18:68,:),1),3)),squeeze(mean(mean(cond5n_dt_bl(roi_contour,18:68,:),1),3)),'coeff');

crosscorr_cont_V2_circ(:,12)=xcorr(squeeze(mean(mean(cond1n_dt_bl(roi_V2,18:68,:),1),3)),squeeze(mean(mean(cond1n_dt_bl(roi_contour,18:68,:),1),3)),'coeff');
crosscorr_non_V2_circ(:,12)=xcorr(squeeze(mean(mean(cond5n_dt_bl(roi_V2,18:68,:),1),3)),squeeze(mean(mean(cond5n_dt_bl(roi_contour,18:68,:),1),3)),'coeff');

crosscorr_cont_V2_circ(:,13)=xcorr(squeeze(mean(mean(cond1n_dt_bl(roi_V2,18:68,:),1),3)),squeeze(mean(mean(cond1n_dt_bl(roi_contour,18:68,:),1),3)),'coeff');
crosscorr_non_V2_circ(:,13)=xcorr(squeeze(mean(mean(cond5n_dt_bl(roi_V2,18:68,:),1),3)),squeeze(mean(mean(cond5n_dt_bl(roi_contour,18:68,:),1),3)),'coeff');


x=-500:10:500;
figure;plot(x,mean(crosscorr_cont_V2_circ,2))
hold on
plot(x,mean(crosscorr_non_V2_circ,2),'r')
xlim([-100 100])



figure;errorbar(x,mean(crosscorr_cont_V2_circ-crosscorr_non_V2_circ,2),std(crosscorr_cont_V2_circ-crosscorr_non_V2_circ,0,2)/sqrt(13))
xlim([-100 100])






%%
x=-500:10:500;
load crosscorr_ave_V2_contour2
figure;plot(x,crosscorr_cond1)
hold on
plot(x,crosscorr_cond4,'r')
figure;plot(x,crosscorr_cond1-crosscorr_cond4)
xlim([-100 100])

load crosscorr_ave_contour2_contour2
figure;plot(x,crosscorr_cond1)
hold on
plot(x,crosscorr_cond4,'r')
figure;plot(x,crosscorr_cond1-crosscorr_cond4)
xlim([-100 100])

load crosscorr_ave_V2_V2
figure;plot(x,crosscorr_cond1)
hold on
plot(x,crosscorr_cond4,'r')
figure;plot(x,crosscorr_cond1-crosscorr_cond4)
xlim([-100 100])


x=-500:10:500;
load crosscorr_ave_V2_contour2
figure;plot(x,crosscorr_cond2)
hold on
plot(x,crosscorr_cond5,'r')
figure;plot(x,crosscorr_cond2-crosscorr_cond5)
xlim([-100 100])

load crosscorr_ave_contour2_contour2
figure;plot(x,crosscorr_cond2)
hold on
plot(x,crosscorr_cond5,'r')
figure;plot(x,crosscorr_cond2-crosscorr_cond5)
xlim([-100 100])

load crosscorr_ave_V2_V2
figure;plot(x,crosscorr_cond2)
hold on
plot(x,crosscorr_cond5,'r')
figure;plot(x,crosscorr_cond2-crosscorr_cond5)
xlim([-100 100])



















x=-500:10:500;
load crosscorr_ave_V2_contour
figure;plot(x,crosscorr_cond1)
hold on
plot(x,crosscorr_cond5,'r')
figure;plot(x,crosscorr_cond1-crosscorr_cond5)
xlim([-100 100])

load crosscorr_ave_contour_contour
figure;plot(x,crosscorr_cond1)
hold on
plot(x,crosscorr_cond5,'r')
figure;plot(x,crosscorr_cond1-crosscorr_cond5)
xlim([-100 100])

load crosscorr_ave_V2_V2
figure;plot(x,crosscorr_cond1)
hold on
plot(x,crosscorr_cond5,'r')
figure;plot(x,crosscorr_cond1-crosscorr_cond5)
xlim([-100 100])




x=-500:10:500;
figure;plot(x,mean(crosscorr_circ_V2_cont,2))
hold on
plot(x,mean(crosscorr_circ_V2_non,2),'r')
xlim([-100 100])




