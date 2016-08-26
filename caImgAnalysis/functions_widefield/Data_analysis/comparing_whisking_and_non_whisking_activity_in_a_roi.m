
cd E:\data_for_israel_july_2015\20150521\d\Matt_files
load('whisker_envelope.mat')
load('rois_initial_205x205.mat')
load('trials_ind.mat')
load('whisker_envelope.mat')

load('cond_100_trial1.mat')
x=(1:size(tr,3))*0.05-2.7;

th=0.5;
tc_m2_no_whisk_100=nan*ones(size(tr,3),size(tr_100,2));
tc_m2_whisk_100=nan*ones(size(tr,3),size(tr_100,2));
tc_m1_no_whisk_100=nan*ones(size(tr,3),size(tr_100,2));
tc_m1_whisk_100=nan*ones(size(tr,3),size(tr_100,2));
tc_s2_no_whisk_100=nan*ones(size(tr,3),size(tr_100,2));
tc_s2_whisk_100=nan*ones(size(tr,3),size(tr_100,2));
tc_s1_no_whisk_100=nan*ones(size(tr,3),size(tr_100,2));
tc_s1_whisk_100=nan*ones(size(tr,3),size(tr_100,2));
tc_a1_no_whisk_100=nan*ones(size(tr,3),size(tr_100,2));
tc_a1_whisk_100=nan*ones(size(tr,3),size(tr_100,2));
tc_alm_no_whisk_100=nan*ones(size(tr,3),size(tr_100,2));
tc_alm_whisk_100=nan*ones(size(tr,3),size(tr_100,2));
for i=1:size(tr_100,2)
    t=smooth(whisk_env(:,tr_100(i)),3,'Gauss');
    wh_ind=t(8:167)>th;
    eval(['load cond_100_trial',int2str(i)])
    d=reshape(tr,205*205,size(tr,3));
    tc_m2_no_whisk_100(~wh_ind,i)=smooth(squeeze(nanmean(d(roi_m2,~wh_ind),1))-1,1,'Gauss');
    tc_m2_whisk_100(wh_ind,i)=smooth(squeeze(nanmean(d(roi_m2,wh_ind),1))-1,1,'Gauss');
    tc_m1_no_whisk_100(~wh_ind,i)=smooth(squeeze(nanmean(d(roi_m1,~wh_ind),1))-1,1,'Gauss');
    tc_m1_whisk_100(wh_ind,i)=smooth(squeeze(nanmean(d(roi_m1,wh_ind),1))-1,1,'Gauss');
    tc_s1_no_whisk_100(~wh_ind,i)=smooth(squeeze(nanmean(d(roi_s1,~wh_ind),1))-1,1,'Gauss');
    tc_s1_whisk_100(wh_ind,i)=smooth(squeeze(nanmean(d(roi_s1,wh_ind),1))-1,1,'Gauss');
    tc_s2_no_whisk_100(~wh_ind,i)=smooth(squeeze(nanmean(d(roi_s2,~wh_ind),1))-1,1,'Gauss');
    tc_s2_whisk_100(wh_ind,i)=smooth(squeeze(nanmean(d(roi_s2,wh_ind),1))-1,1,'Gauss');
    tc_a1_no_whisk_100(~wh_ind,i)=smooth(squeeze(nanmean(d(roi_a1,~wh_ind),1))-1,1,'Gauss');
    tc_a1_whisk_100(wh_ind,i)=smooth(squeeze(nanmean(d(roi_a1,wh_ind),1))-1,1,'Gauss');
    tc_alm_no_whisk_100(~wh_ind,i)=smooth(squeeze(nanmean(d(roi_alm,~wh_ind),1))-1,1,'Gauss');
    tc_alm_whisk_100(wh_ind,i)=smooth(squeeze(nanmean(d(roi_alm,wh_ind),1))-1,1,'Gauss');
end

tc_m2_no_whisk_1200=nan*ones(size(tr,3),size(tr_1200,2));
tc_m2_whisk_1200=nan*ones(size(tr,3),size(tr_1200,2));
tc_m1_no_whisk_1200=nan*ones(size(tr,3),size(tr_1200,2));
tc_m1_whisk_1200=nan*ones(size(tr,3),size(tr_1200,2));
tc_s2_no_whisk_1200=nan*ones(size(tr,3),size(tr_1200,2));
tc_s2_whisk_1200=nan*ones(size(tr,3),size(tr_1200,2));
tc_s1_no_whisk_1200=nan*ones(size(tr,3),size(tr_1200,2));
tc_s1_whisk_1200=nan*ones(size(tr,3),size(tr_1200,2));
tc_a1_no_whisk_1200=nan*ones(size(tr,3),size(tr_1200,2));
tc_a1_whisk_1200=nan*ones(size(tr,3),size(tr_1200,2));
tc_alm_no_whisk_1200=nan*ones(size(tr,3),size(tr_1200,2));
tc_alm_whisk_1200=nan*ones(size(tr,3),size(tr_1200,2));
for i=1:size(tr_1200,2)
    t=smooth(whisk_env(:,tr_1200(i)),3,'Gauss');
    wh_ind=t(8:167)>th;
    eval(['load cond_1200_trial',int2str(i)])
    d=reshape(tr,205*205,size(tr,3));
    tc_m2_no_whisk_1200(~wh_ind,i)=smooth(squeeze(nanmean(d(roi_m2,~wh_ind),1))-1,1,'Gauss');
    tc_m2_whisk_1200(wh_ind,i)=smooth(squeeze(nanmean(d(roi_m2,wh_ind),1))-1,1,'Gauss');
    tc_m1_no_whisk_1200(~wh_ind,i)=smooth(squeeze(nanmean(d(roi_m1,~wh_ind),1))-1,1,'Gauss');
    tc_m1_whisk_1200(wh_ind,i)=smooth(squeeze(nanmean(d(roi_m1,wh_ind),1))-1,1,'Gauss');
    tc_s1_no_whisk_1200(~wh_ind,i)=smooth(squeeze(nanmean(d(roi_s1,~wh_ind),1))-1,1,'Gauss');
    tc_s1_whisk_1200(wh_ind,i)=smooth(squeeze(nanmean(d(roi_s1,wh_ind),1))-1,1,'Gauss');
    tc_s2_no_whisk_1200(~wh_ind,i)=smooth(squeeze(nanmean(d(roi_s2,~wh_ind),1))-1,1,'Gauss');
    tc_s2_whisk_1200(wh_ind,i)=smooth(squeeze(nanmean(d(roi_s2,wh_ind),1))-1,1,'Gauss');
    tc_a1_no_whisk_1200(~wh_ind,i)=smooth(squeeze(nanmean(d(roi_a1,~wh_ind),1))-1,1,'Gauss');
    tc_a1_whisk_1200(wh_ind,i)=smooth(squeeze(nanmean(d(roi_a1,wh_ind),1))-1,1,'Gauss');
    tc_alm_no_whisk_1200(~wh_ind,i)=smooth(squeeze(nanmean(d(roi_alm,~wh_ind),1))-1,1,'Gauss');
    tc_alm_whisk_1200(wh_ind,i)=smooth(squeeze(nanmean(d(roi_alm,wh_ind),1))-1,1,'Gauss');
end


figure;plot(x,nanmean(tc_s1_no_whisk_100(:,:),2),'b')
hold on
plot(x,nanmean(tc_s1_whisk_100(:,:),2),'y')
plot(x,zeros(1,size(tr,3)),'k')
xlim([-2.5 5.5])
plot(x,nanmean(tc_s1_no_whisk_1200(:,:),2),'--b')
hold on
plot(x,nanmean(tc_s1_whisk_1200(:,:),2),'--y')
plot(x,zeros(1,size(tr,3)),'k')
xlim([-2.5 5.5])


figure;plot(x,nanmean(tc_s2_no_whisk_100(:,:),2),'c')
hold on
plot(x,nanmean(tc_s2_whisk_100(:,:),2),'y')
plot(x,zeros(1,size(tr,3)),'k')
xlim([-2.5 5.5])
plot(x,nanmean(tc_s2_no_whisk_1200(:,:),2),'--c')
hold on
plot(x,nanmean(tc_s2_whisk_1200(:,:),2),'--y')
plot(x,zeros(1,size(tr,3)),'k')
xlim([-2.5 5.5])


figure;plot(x,nanmean(tc_m1_no_whisk_100(:,:),2),'r')
hold on
plot(x,nanmean(tc_m1_whisk_100(:,:),2),'y')
plot(x,zeros(1,size(tr,3)),'k')
xlim([-2.5 5.5])
plot(x,nanmean(tc_m1_no_whisk_1200(:,:),2),'--r')
hold on
plot(x,nanmean(tc_m1_whisk_1200(:,:),2),'--y')
plot(x,zeros(1,size(tr,3)),'k')
xlim([-2.5 5.5])


figure;plot(x,nanmean(tc_m2_no_whisk_100(:,:),2),'k')
hold on
plot(x,nanmean(tc_m2_whisk_100(:,:),2),'y')
plot(x,zeros(1,size(tr,3)),'k')
xlim([-2.5 5.5])
plot(x,nanmean(tc_m2_no_whisk_1200(:,:),2),'--k')
hold on
plot(x,nanmean(tc_m2_whisk_1200(:,:),2),'--y')
plot(x,zeros(1,size(tr,3)),'k')
xlim([-2.5 5.5])


figure;plot(x,nanmean(tc_alm_no_whisk_100(:,:),2),'m')
hold on
plot(x,nanmean(tc_alm_whisk_100(:,:),2),'y')
plot(x,zeros(1,size(tr,3)),'k')
xlim([-2.5 5.5])
plot(x,nanmean(tc_alm_no_whisk_1200(:,:),2),'--m')
hold on
plot(x,nanmean(tc_alm_whisk_1200(:,:),2),'--y')
plot(x,zeros(1,size(tr,3)),'k')
xlim([-2.5 5.5])


figure;plot(x,nanmean(tc_a1_no_whisk_100(:,:),2),'g')
hold on
plot(x,nanmean(tc_a1_whisk_100(:,:),2),'y')
plot(x,zeros(1,size(tr,3)),'k')
xlim([-2.5 5.5])
plot(x,nanmean(tc_a1_no_whisk_1200(:,:),2),'--g')
hold on
plot(x,nanmean(tc_a1_whisk_1200(:,:),2),'--y')
plot(x,zeros(1,size(tr,3)),'k')
xlim([-2.5 5.5])



figure;plot(x,nanmean(tc_a1_no_whisk_100(:,:),2)-nanmean(tc_a1_no_whisk_1200(:,:),2),'g')
hold on
plot(x,nanmean(tc_s1_no_whisk_100(:,:),2)-nanmean(tc_s1_no_whisk_1200(:,:),2),'b')
plot(x,nanmean(tc_m1_no_whisk_100(:,:),2)-nanmean(tc_m1_no_whisk_1200(:,:),2),'r')
plot(x,nanmean(tc_s2_no_whisk_100(:,:),2)-nanmean(tc_s2_no_whisk_1200(:,:),2),'c')
plot(x,nanmean(tc_m2_no_whisk_100(:,:),2)-nanmean(tc_m2_no_whisk_1200(:,:),2),'k')
plot(x,nanmean(tc_alm_no_whisk_100(:,:),2)-nanmean(tc_alm_no_whisk_1200(:,:),2),'m')
plot(x,zeros(1,size(tr,3)),'k')
xlim([-2.5 5.5])




%%


n1=sum(~isnan(tc_a1_no_whisk_100),2)/size(tc_a1_no_whisk_100,2);
n2=sum(~isnan(tc_a1_whisk_100),2)/size(tc_a1_whisk_100,2);
n3=sum(~isnan(tc_a1_no_whisk_1200),2)/size(tc_a1_no_whisk_1200,2);
n4=sum(~isnan(tc_a1_whisk_1200),2)/size(tc_a1_whisk_1200,2);

figure;plot(x,n1,'b')
hold on
%plot(x,n2,'r')
plot(x,n3,'--b')
%plot(x,n4,'--r')
xlim([-2.5 5.5])



