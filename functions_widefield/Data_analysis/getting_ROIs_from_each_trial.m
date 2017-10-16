


cd D:\intrinsic\20150128\e\Matt_files
load('rois_initial.mat')
load('trials_ind.mat')

k=0;
resp_100_s1=nan*ones(60,size(tr_100,2));
resp_100_s2=nan*ones(60,size(tr_100,2));
resp_100_a1=nan*ones(60,size(tr_100,2));
resp_100_m1=nan*ones(60,size(tr_100,2));
resp_100_m2=nan*ones(60,size(tr_100,2));
resp_100_alm=nan*ones(60,size(tr_100,2));
for i=tr_100
    disp(i)
    k=k+1;
    eval(['load trial_',int2str(i)])
    d=reshape(tr,2048*2048,60);
    resp_100_s1(:,k)=nanmean(d(roi_s1,:),1);
    resp_100_s2(:,k)=nanmean(d(roi_s2,:),1);
    resp_100_m1(:,k)=nanmean(d(roi_m1,:),1);
    resp_100_m2(:,k)=nanmean(d(roi_m2,:),1);
    resp_100_a1(:,k)=nanmean(d(roi_a1,:),1);
    resp_100_alm(:,k)=nanmean(d(roi_alm,:),1);
end
    
    
k=0;
resp_1200_s1=nan*ones(60,size(tr_1200,2));
resp_1200_s2=nan*ones(60,size(tr_1200,2));
resp_1200_a1=nan*ones(60,size(tr_1200,2));
resp_1200_m1=nan*ones(60,size(tr_1200,2));
resp_1200_m2=nan*ones(60,size(tr_1200,2));
resp_1200_alm=nan*ones(60,size(tr_1200,2));
for i=tr_1200
    disp(i)
    k=k+1;
    eval(['load trial_',int2str(i)])
    d=reshape(tr,2048*2048,60);
    resp_1200_s1(:,k)=nanmean(d(roi_s1,:),1);
    resp_1200_s2(:,k)=nanmean(d(roi_s2,:),1);
    resp_1200_m1(:,k)=nanmean(d(roi_m1,:),1);
    resp_1200_m2(:,k)=nanmean(d(roi_m2,:),1);
    resp_1200_a1(:,k)=nanmean(d(roi_a1,:),1);
    resp_1200_alm(:,k)=nanmean(d(roi_alm,:),1);
end
    

% k=0;
% resp_000_s1=nan*ones(60,size(tr_000,2));
% resp_000_s2=nan*ones(60,size(tr_000,2));
% resp_000_a1=nan*ones(60,size(tr_000,2));
% resp_000_m1=nan*ones(60,size(tr_000,2));
% resp_000_m2=nan*ones(60,size(tr_000,2));
% resp_000_alm=nan*ones(60,size(tr_000,2));
% for i=tr_000
%     disp(i)
%     k=k+1;
%     eval(['load trial_',int2str(i)])
%     d=reshape(tr,2048*2048,60);
%     resp_000_s1(:,k)=nanmean(d(roi_s1,:),1);
%     resp_000_s2(:,k)=nanmean(d(roi_s2,:),1);
%     resp_000_m1(:,k)=nanmean(d(roi_m1,:),1);
%     resp_000_m2(:,k)=nanmean(d(roi_m2,:),1);
%     resp_000_a1(:,k)=nanmean(d(roi_a1,:),1);
%     resp_000_alm(:,k)=nanmean(d(roi_alm,:),1);
% end


save time_course_ROIs resp_*


%%
x=(1:180)*0.05-2.7;
x=x(1:3:180);

figure;errorbar(x,nanmean(resp_100_s1,2),nanstd(resp_100_s1,0,2)/sqrt(size(resp_100_s1,2)))
hold on
errorbar(x,nanmean(resp_1200_s1,2),nanstd(resp_1200_s1,0,2)/sqrt(size(resp_1200_s1,2)),'c')

figure;errorbar(x,nanmean(resp_100_m1,2),nanstd(resp_100_m1,0,2)/sqrt(size(resp_100_m1,2)),'r')
hold on
errorbar(x,nanmean(resp_1200_m1,2),nanstd(resp_1200_m1,0,2)/sqrt(size(resp_1200_m1,2)),'m')

figure;errorbar(x,nanmean(resp_100_s2,2),nanstd(resp_100_s2,0,2)/sqrt(size(resp_100_s2,2)),'g')
hold on
errorbar(x,nanmean(resp_1200_s2,2),nanstd(resp_1200_s2,0,2)/sqrt(size(resp_1200_s2,2)),'y')

figure;errorbar(x,nanmean(resp_100_m2,2),nanstd(resp_100_m2,0,2)/sqrt(size(resp_100_m2,2)),'k')
hold on
errorbar(x,nanmean(resp_1200_m2,2),nanstd(resp_1200_m2,0,2)/sqrt(size(resp_1200_m2,2)),'m')

figure;errorbar(x,nanmean(resp_100_a1,2),nanstd(resp_100_a1,0,2)/sqrt(size(resp_100_a1,2)),'b')
hold on
errorbar(x,nanmean(resp_1200_a1,2),nanstd(resp_1200_a1,0,2)/sqrt(size(resp_1200_a1,2)),'c')

figure;errorbar(x,nanmean(resp_100_alm,2),nanstd(resp_100_alm,0,2)/sqrt(size(resp_100_alm,2)),'r')
hold on
errorbar(x,nanmean(resp_1200_alm,2),nanstd(resp_1200_alm,0,2)/sqrt(size(resp_1200_alm,2)),'m')





