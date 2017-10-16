cd D:\intrinsic\20151027\a\Matt_files
load('cond_1200_ave_first_touch_norm.mat')
load('cond_100_ave_first_touch_norm.mat')

load rois_initial_205x205
h=zeros(205*205,1);
h(roi_s1)=1;
h(roi_s2)=1;
h(roi_m1)=1;
h(roi_m2)=1;
h(roi_a1)=1;
h(roi_alm)=1;
%h(roi_ppc)=1;
pix=256;
fr=200;

x=(1:size(cond_100_ave,3))*0.05-2.3;
d2=reshape(cond_1200_ave,256*256,size(cond_1200_ave,3));
d=reshape(cond_100_ave,256*256,size(cond_100_ave,3));

figure;plot(x,smooth(squeeze(nanmean(d(roi_s1,:),1))-1,1,'Gauss'),'b')
hold on
plot(x,smooth(squeeze(nanmean(d(roi_s2,:),1))-1,1,'Gauss'),'c')
plot(x,smooth(squeeze(nanmean(d2(roi_s1,:),1))-1,1,'Gauss'),'--b')
plot(x,smooth(squeeze(nanmean(d2(roi_s2,:),1))-1,1,'Gauss'),'--c')
plot(x,zeros(1,size(cond_100_ave,3)),'k')
xlim([-.2 2])

figure;plot(x,smooth(squeeze(nanmean(d2(roi_s1,:),1))-squeeze(nanmean(d(roi_s1,:),1)),1,'Gauss'))
hold on
plot(x,smooth(squeeze(nanmean(d2(roi_s2,:),1))-squeeze(nanmean(d(roi_s2,:),1)),1,'Gauss'),'c')
plot(x,zeros(1,size(cond_100_ave,3)),'k')
xlim([-.2 2])

%%

x=(1:size(cond_100_ave,3))*0.05-2.3;

AUC_s1_time=nan*ones(1,fr);
for i=1:170
    scores=[squeeze(nanmean(cond_100_s1(i,:),1))-1 squeeze(nanmean(cond_1200_s1(i,:),1))-1];
    labels=ones(1,size(scores,2));
    labels(size(cond_100_s1,2)+1:end)=0;
    [X,Y,THRE,AUC_s1_time(i),OPTROCPT,SUBY,SUBYNAMES] = perfcurve(labels,scores,1);
end
% iter=100;
% AUC_s1_time_sh=nan*ones(fr,iter);
% tot=cat(2,cond_100_s1,cond_1200_s1);
% for it=1:iter
%     disp(it)
%     r=randperm(size(tot,2));
%     temp=tot(:,r(1:size(cond_100_s1,2)));
%     temp2=tot(:,r(size(cond_100_s1,2)+1:end));
%     for i=1:170
%         scores=[squeeze(temp(i,:)),squeeze(temp2(i,:))];
%         labels=ones(1,size(scores,2));
%         labels(size(cond_100_s1,2)+1:end)=0;
%         [X,Y,THRE,AUC_s1_time_sh(i,it),OPTROCPT,SUBY,SUBYNAMES] = perfcurve(labels,scores,1);
%     end
% end
% figure;plot(x,AUC_s1_time,'b')
% hold on
% plot(x,nanmean(AUC_s1_time_sh,2)+1.96*nanstd(AUC_s1_time_sh,0,2),'--k')
% plot(x,nanmean(AUC_s1_time_sh,2)-1.96*nanstd(AUC_s1_time_sh,0,2),'--k')
% xlim([-.2 2])

AUC_s2_time=nan*ones(1,fr);
for i=1:170
    scores=[squeeze(nanmean(cond_100_s2(i,:),1))-1 squeeze(nanmean(cond_1200_s2(i,:),1))-1];
    labels=ones(1,size(scores,2));
    labels(size(cond_100_s1,2)+1:end)=0;
    [X,Y,THRE,AUC_s2_time(i),OPTROCPT,SUBY,SUBYNAMES] = perfcurve(labels,scores,1);
end

AUC_m1_time=nan*ones(1,fr);
for i=1:170
    scores=[squeeze(nanmean(cond_100_m1(i,:),1))-1 squeeze(nanmean(cond_1200_m1(i,:),1))-1];
    labels=ones(1,size(scores,2));
    labels(size(cond_100_s1,2)+1:end)=0;
    [X,Y,THRE,AUC_m1_time(i),OPTROCPT,SUBY,SUBYNAMES] = perfcurve(labels,scores,1);
end

AUC_m2_time=nan*ones(1,fr);
for i=1:170
    scores=[squeeze(nanmean(cond_100_m2(i,:),1))-1 squeeze(nanmean(cond_1200_m2(i,:),1))-1];
    labels=ones(1,size(scores,2));
    labels(size(cond_100_s1,2)+1:end)=0;
    [X,Y,THRE,AUC_m2_time(i),OPTROCPT,SUBY,SUBYNAMES] = perfcurve(labels,scores,1);
end

AUC_a1_time=nan*ones(1,fr);
for i=1:170
    scores=[squeeze(nanmean(cond_100_a1(i,:),1))-1 squeeze(nanmean(cond_1200_a1(i,:),1))-1];
    labels=ones(1,size(scores,2));
    labels(size(cond_100_a1,2)+1:end)=0;
    [X,Y,THRE,AUC_a1_time(i),OPTROCPT,SUBY,SUBYNAMES] = perfcurve(labels,scores,1);
end

AUC_ppc_time=nan*ones(1,fr);
for i=1:170
    scores=[squeeze(nanmean(cond_100_ppc(i,:),1))-1 squeeze(nanmean(cond_1200_ppc(i,:),1))-1];
    labels=ones(1,size(scores,2));
    labels(size(cond_100_ppc,2)+1:end)=0;
    [X,Y,THRE,AUC_ppc_time(i),OPTROCPT,SUBY,SUBYNAMES] = perfcurve(labels,scores,1);
end

figure;plot(x,AUC_s1_time,'b')
hold on
plot(x,0.65*ones(size(x,2),1),'--k')
plot(x,0.35*ones(size(x,2),1),'--k')
plot(x,AUC_s2_time,'c')
plot(x,AUC_m1_time,'r')
plot(x,AUC_m2_time,'k')
plot(x,AUC_a1_time,'g')
plot(x,AUC_ppc_time,'y')
% plot(x,nanmean(AUC_m1_time_sh,2)-1.96*nanstd(AUC_m1_time_sh,0,2),'--k')
xlim([-.2 2])







