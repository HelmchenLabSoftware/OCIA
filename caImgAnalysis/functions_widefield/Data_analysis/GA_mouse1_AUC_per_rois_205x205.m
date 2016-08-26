cd D:\intrinsic\20150123\a\Matt_files
load('AUC_per_roi.mat')

GA_AUC_s1=AUC_s1_time';
GA_AUC_s2=AUC_s2_time';
GA_AUC_m1=AUC_m1_time';
GA_AUC_a1=AUC_a1_time';
GA_AUC_alm=AUC_alm_time';
GA_AUC_m2=AUC_m2_time';


cd D:\intrinsic\20150127\b\Matt_files
load('AUC_per_roi.mat')

GA_AUC_s1=cat(2,GA_AUC_s1,AUC_s1_time');
GA_AUC_s2=cat(2,GA_AUC_s2,AUC_s2_time');
GA_AUC_m1=cat(2,GA_AUC_m1,AUC_m1_time');
GA_AUC_a1=cat(2,GA_AUC_a1,AUC_a1_time');
GA_AUC_alm=cat(2,GA_AUC_alm,AUC_alm_time');
GA_AUC_m2=cat(2,GA_AUC_m2,AUC_m2_time');


cd D:\intrinsic\20150127\d\Matt_files
load('AUC_per_roi.mat')

GA_AUC_s1=cat(2,GA_AUC_s1,AUC_s1_time');
GA_AUC_s2=cat(2,GA_AUC_s2,AUC_s2_time');
GA_AUC_m1=cat(2,GA_AUC_m1,AUC_m1_time');
GA_AUC_a1=cat(2,GA_AUC_a1,AUC_a1_time');
GA_AUC_alm=cat(2,GA_AUC_alm,AUC_alm_time');
GA_AUC_m2=cat(2,GA_AUC_m2,AUC_m2_time');



cd D:\intrinsic\20150128\a\Matt_files
load('AUC_per_roi.mat')

GA_AUC_s1=cat(2,GA_AUC_s1,AUC_s1_time');
GA_AUC_s2=cat(2,GA_AUC_s2,AUC_s2_time');
GA_AUC_m1=cat(2,GA_AUC_m1,AUC_m1_time');
GA_AUC_a1=cat(2,GA_AUC_a1,AUC_a1_time');
GA_AUC_alm=cat(2,GA_AUC_alm,AUC_alm_time');
GA_AUC_m2=cat(2,GA_AUC_m2,AUC_m2_time');



cd D:\intrinsic\20150128\e\Matt_files
load('AUC_per_roi.mat')

GA_AUC_s1=cat(2,GA_AUC_s1,AUC_s1_time');
GA_AUC_s2=cat(2,GA_AUC_s2,AUC_s2_time');
GA_AUC_m1=cat(2,GA_AUC_m1,AUC_m1_time');
GA_AUC_a1=cat(2,GA_AUC_a1,AUC_a1_time');
GA_AUC_alm=cat(2,GA_AUC_alm,AUC_alm_time');
GA_AUC_m2=cat(2,GA_AUC_m2,AUC_m2_time');


cd D:\intrinsic\20150129\a\Matt_files
load('AUC_per_roi.mat')

GA_AUC_s1=cat(2,GA_AUC_s1,AUC_s1_time');
GA_AUC_s2=cat(2,GA_AUC_s2,AUC_s2_time');
GA_AUC_m1=cat(2,GA_AUC_m1,AUC_m1_time');
GA_AUC_a1=cat(2,GA_AUC_a1,AUC_a1_time');
GA_AUC_alm=cat(2,GA_AUC_alm,AUC_alm_time');
GA_AUC_m2=cat(2,GA_AUC_m2,AUC_m2_time');


cd D:\intrinsic\20150129\b\Matt_files
load('AUC_per_roi.mat')

GA_AUC_s1=cat(2,GA_AUC_s1,AUC_s1_time');
GA_AUC_s2=cat(2,GA_AUC_s2,AUC_s2_time');
GA_AUC_m1=cat(2,GA_AUC_m1,AUC_m1_time');
GA_AUC_a1=cat(2,GA_AUC_a1,AUC_a1_time');
GA_AUC_alm=cat(2,GA_AUC_alm,AUC_alm_time');
GA_AUC_m2=cat(2,GA_AUC_m2,AUC_m2_time');



cd D:\intrinsic\20150129\g\Matt_files
load('AUC_per_roi.mat')

GA_AUC_s1=cat(2,GA_AUC_s1,AUC_s1_time');
GA_AUC_s2=cat(2,GA_AUC_s2,AUC_s2_time');
GA_AUC_m1=cat(2,GA_AUC_m1,AUC_m1_time');
GA_AUC_a1=cat(2,GA_AUC_a1,AUC_a1_time');
GA_AUC_alm=cat(2,GA_AUC_alm,AUC_alm_time');
GA_AUC_m2=cat(2,GA_AUC_m2,AUC_m2_time');


cd D:\intrinsic\20150130\a\Matt_files
load('AUC_per_roi.mat')

GA_AUC_s1=cat(2,GA_AUC_s1,AUC_s1_time');
GA_AUC_s2=cat(2,GA_AUC_s2,AUC_s2_time');
GA_AUC_m1=cat(2,GA_AUC_m1,AUC_m1_time');
GA_AUC_a1=cat(2,GA_AUC_a1,AUC_a1_time');
GA_AUC_alm=cat(2,GA_AUC_alm,AUC_alm_time');
GA_AUC_m2=cat(2,GA_AUC_m2,AUC_m2_time');



x=(1:180)*0.05-2.7;
figure;errorbar(x,nanmean(GA_AUC_s1,2),nanstd(GA_AUC_s1,0,2)/sqrt(size(GA_AUC_s1,2)),'b')
hold on
errorbar(x,nanmean(GA_AUC_s2,2),nanstd(GA_AUC_s2,0,2)/sqrt(size(GA_AUC_s2,2)),'c')
errorbar(x,nanmean(GA_AUC_m1,2),nanstd(GA_AUC_m1,0,2)/sqrt(size(GA_AUC_m1,2)),'r')
errorbar(x,nanmean(GA_AUC_m2,2),nanstd(GA_AUC_m2,0,2)/sqrt(size(GA_AUC_m2,2)),'k')
errorbar(x,nanmean(GA_AUC_a1,2),nanstd(GA_AUC_a1,0,2)/sqrt(size(GA_AUC_a1,2)),'g')
errorbar(x,nanmean(GA_AUC_alm,2),nanstd(GA_AUC_alm,0,2)/sqrt(size(GA_AUC_alm,2)),'m')
xlim([-2.6 5.5])
plot(x,0.5*ones(1,180),'--k')





time=52:58;
figure;bar([nanmean(nanmean(GA_AUC_s1(time,:),1)) nanmean(nanmean(GA_AUC_s2(time,:),1)) nanmean(nanmean(GA_AUC_a1(time,:),1)) nanmean(nanmean(GA_AUC_m1(time,:),1)) nanmean(nanmean(GA_AUC_m2(time,:),1)) nanmean(nanmean(GA_AUC_alm(time,:),1))])
hold on
errorbar([nanmean(nanmean(GA_AUC_s1(time,:),1)) nanmean(nanmean(GA_AUC_s2(time,:),1)) nanmean(nanmean(GA_AUC_a1(time,:),1)) nanmean(nanmean(GA_AUC_m1(time,:),1)) nanmean(nanmean(GA_AUC_m2(time,:),1)) nanmean(nanmean(GA_AUC_alm(time,:),1))],[nanstd(nanmean(GA_AUC_s1(time,:),1)) nanstd(nanmean(GA_AUC_s2(time,:),1)) nanstd(nanmean(GA_AUC_a1(time,:),1)) nanstd(nanmean(GA_AUC_m1(time,:),1)) nanstd(nanmean(GA_AUC_m2(time,:),1)) nanstd(nanmean(GA_AUC_alm(time,:),1))]/sqrt(size(GA_AUC_s1,2)))
signrank(nanmean(GA_AUC_s1(time,:),1),0.5*ones(1,size(GA_AUC_s1,2)))
signrank(nanmean(GA_AUC_s2(time,:),1),0.5*ones(1,size(GA_AUC_s1,2)))
signrank(nanmean(GA_AUC_a1(time,:),1),0.5*ones(1,size(GA_AUC_s1,2)))
signrank(nanmean(GA_AUC_m1(time,:),1),0.5*ones(1,size(GA_AUC_s1,2)))
signrank(nanmean(GA_AUC_m2(time,:),1),0.5*ones(1,size(GA_AUC_s1,2)))
signrank(nanmean(GA_AUC_alm(time,:),1),0.5*ones(1,size(GA_AUC_s1,2)))


signrank(nanmean(GA_AUC_s1(time,:),1),nanmean(GA_AUC_m2(time,:),1))*6
signrank(nanmean(GA_AUC_s2(time,:),1),nanmean(GA_AUC_m2(time,:),1))*6
signrank(nanmean(GA_AUC_m1(time,:),1),nanmean(GA_AUC_m2(time,:),1))*6
signrank(nanmean(GA_AUC_a1(time,:),1),nanmean(GA_AUC_m2(time,:),1))*6
signrank(nanmean(GA_AUC_alm(time,:),1),nanmean(GA_AUC_m2(time,:),1))*6


time=104:114;
figure;bar([nanmean(nanmean(GA_AUC_s1(time,:),1)) nanmean(nanmean(GA_AUC_s2(time,:),1)) nanmean(nanmean(GA_AUC_a1(time,:),1)) nanmean(nanmean(GA_AUC_m1(time,:),1)) nanmean(nanmean(GA_AUC_m2(time,:),1)) nanmean(nanmean(GA_AUC_alm(time,:),1))])
hold on
errorbar([nanmean(nanmean(GA_AUC_s1(time,:),1)) nanmean(nanmean(GA_AUC_s2(time,:),1)) nanmean(nanmean(GA_AUC_a1(time,:),1)) nanmean(nanmean(GA_AUC_m1(time,:),1)) nanmean(nanmean(GA_AUC_m2(time,:),1)) nanmean(nanmean(GA_AUC_alm(time,:),1))],[nanstd(nanmean(GA_AUC_s1(time,:),1)) nanstd(nanmean(GA_AUC_s2(time,:),1)) nanstd(nanmean(GA_AUC_a1(time,:),1)) nanstd(nanmean(GA_AUC_m1(time,:),1)) nanstd(nanmean(GA_AUC_m2(time,:),1)) nanstd(nanmean(GA_AUC_alm(time,:),1))]/sqrt(size(GA_AUC_s1,2)))
signrank(nanmean(GA_AUC_s1(time,:),1),0.5*ones(1,size(GA_AUC_s1,2)))
signrank(nanmean(GA_AUC_s2(time,:),1),0.5*ones(1,size(GA_AUC_s1,2)))
signrank(nanmean(GA_AUC_a1(time,:),1),0.5*ones(1,size(GA_AUC_s1,2)))
signrank(nanmean(GA_AUC_m1(time,:),1),0.5*ones(1,size(GA_AUC_s1,2)))
signrank(nanmean(GA_AUC_m2(time,:),1),0.5*ones(1,size(GA_AUC_s1,2)))
signrank(nanmean(GA_AUC_alm(time,:),1),0.5*ones(1,size(GA_AUC_s1,2)))


signrank(nanmean(GA_AUC_s1(time,:),1),nanmean(GA_AUC_m2(time,:),1))*6
signrank(nanmean(GA_AUC_s2(time,:),1),nanmean(GA_AUC_m2(time,:),1))*6
signrank(nanmean(GA_AUC_m1(time,:),1),nanmean(GA_AUC_m2(time,:),1))*6
signrank(nanmean(GA_AUC_a1(time,:),1),nanmean(GA_AUC_m2(time,:),1))*6
signrank(nanmean(GA_AUC_alm(time,:),1),nanmean(GA_AUC_m2(time,:),1))*6






