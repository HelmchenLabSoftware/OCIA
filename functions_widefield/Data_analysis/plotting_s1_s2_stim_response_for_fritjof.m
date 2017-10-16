cd D:\intrinsic\20150520\d\Matt_files
load('norm_responses_for_fritjof_oct_2015.mat')
%load('cond_100_ave_clean_norm_response.mat')
%load('cond_1200_ave_clean_norm_response.mat')
cond_100_ave=reshape(cond_100_ave,205,205,size(cond_100_ave,2));
cond_1200_ave=reshape(cond_1200_ave,205,205,size(cond_1200_ave,2));
load rois_initial_205x205
h=zeros(205*205,1);
h(roi_s1)=1;
h(roi_s2)=1;
h(roi_m1)=1;
h(roi_m2)=1;
h(roi_a1)=1;
h(roi_alm)=1;
%h(roi_ppc)=1;

x=(1:size(cond_100_ave,3))*0.05-1.9;
d2=reshape(cond_1200_ave,205*205,size(cond_1200_ave,3));
d=reshape(cond_100_ave,205*205,size(cond_100_ave,3));

figure;plot(x,smooth(squeeze(nanmean(d(roi_s1,:),1))-1,1,'Gauss'),'b')
hold on
plot(x,smooth(squeeze(nanmean(d(roi_s2,:),1))-1,1,'Gauss'),'c')
plot(x,smooth(squeeze(nanmean(d2(roi_s1,:),1))-1,1,'Gauss'),'--b')
plot(x,smooth(squeeze(nanmean(d2(roi_s2,:),1))-1,1,'Gauss'),'--c')
plot(x,zeros(1,size(cond_100_ave,3)),'k')
xlim([-.2 2])

figure;plot(x,smooth(squeeze(nanmean(d(roi_s1,:),1))-squeeze(nanmean(d2(roi_s1,:),1)),1,'Gauss'))
hold on
plot(x,smooth(squeeze(nanmean(d(roi_s2,:),1))-squeeze(nanmean(d2(roi_s2,:),1)),1,'Gauss'),'c')
plot(x,zeros(1,size(cond_100_ave,3)),'k')
xlim([-.2 2])

%%


% for i=64:-1:34
%     figure;imagesc(smoothn(cond_100_ave(:,:,i)-1,[5 5],'Gauss'),[-1e-2 2e-2]);colormap(mapgeog)
%     %hold on
%     %contour(reshape(h,205,205),'k')
%     %title([int2str(x(i)*1000)])
%     title([int2str(i)])
% end

% 
% for i=180:-1:1
%     figure;imagesc(smoothn(cond_1200_ave(:,:,i)-1,[5 5],'Gauss'),[-1e-2 3e-2]);colormap(mapgeog)
%     %hold on
%     %contour(reshape(h,205,205),'k')
%     title([int2str(x(i)*1000)])
%     %title([int2str(i)])
% end
% 
y=fliplr(smoothn(nanmean(cond_100_ave(:,:,55:63)-1,3),[5 5],'Gauss')');
y(isnan(y))=10000;
figure;imagesc(y,[.5e-2 1.7e-2]);colormap(mapgeog)
axis square
axis off

%figure;imagesc(smoothn(cond_1200_ave(:,:,55)-1,[5 5],'Gauss'),[-1e-2 1.5e-2]);colormap(mapgeog)


cd D:\intrinsic\20150511\c\Matt_files
load('stim_ave.mat')
y=fliplr(smoothn(nanmean(tr_ave(:,:,28),3)-1,[5 5],'Gauss')');
y(isnan(y))=10000;
figure;imagesc(y,[-.25e-2 3e-2]);colormap(mapgeog)
hold on
line([139 151],[12 161],'Marker','.','LineStyle','-','LineWidth',3,'Color','w')
axis square
axis off





AUC_s1_time=nan*ones(1,180);
for i=1:180
    scores=[squeeze(nanmean(cond_100_s1(:,i,:),1))'-1,squeeze(nanmean(cond_1200_s1(:,i,:),1))'-1];
    labels=ones(1,size(scores,2));
    labels(size(cond_100_s1,3)+1:end)=0;
    [X,Y,THRE,AUC_s1_time(i),OPTROCPT,SUBY,SUBYNAMES] = perfcurve(labels,scores,1);
end
iter=100;
AUC_s1_time_sh=nan*ones(180,iter);
tot=cat(3,cond_100_s1,cond_1200_s1);
for it=1:iter
    disp(it)
    r=randperm(size(tot,3));
    temp=tot(:,:,r(1:size(cond_100_s1,3)));
    temp2=tot(:,:,r(size(cond_100_s1,3)+1:end));
    for i=1:180
        scores=[squeeze(temp(:,i,:))',squeeze(temp2(:,i,:))'];
        labels=ones(1,size(scores,2));
        labels(size(cond_100_s1,3)+1:end)=0;
        [X,Y,THRE,AUC_s1_time_sh(i,it),OPTROCPT,SUBY,SUBYNAMES] = perfcurve(labels,scores,1);
    end
end
figure;plot(x,AUC_s1_time,'b')
hold on
plot(x,nanmean(AUC_s1_time_sh,2)+1.96*nanstd(AUC_s1_time_sh,0,2),'--k')
plot(x,nanmean(AUC_s1_time_sh,2)-1.96*nanstd(AUC_s1_time_sh,0,2),'--k')
xlim([-.2 2])

AUC_s2_time=nan*ones(1,180);
for i=1:180
    scores=[squeeze(nanmean(cond_100_s2(:,i,:),1))'-1,squeeze(nanmean(cond_1200_s2(:,i,:),1))'-1];
    labels=ones(1,size(scores,2));
    labels(size(cond_100_s2,3)+1:end)=0;
    [X,Y,THRE,AUC_s2_time(i),OPTROCPT,SUBY,SUBYNAMES] = perfcurve(labels,scores,1);
end
iter=100;
AUC_s2_time_sh=nan*ones(180,iter);
tot=cat(3,cond_100_s2,cond_1200_s2);
for it=1:iter
    disp(it)
    r=randperm(size(tot,3));
    temp=tot(:,:,r(1:size(cond_100_s2,3)));
    temp2=tot(:,:,r(size(cond_100_s2,3)+1:end));
    for i=1:180
        scores=[squeeze(temp(:,i,:))',squeeze(temp2(:,i,:))'];
        labels=ones(1,size(scores,2));
        labels(size(cond_100_s2,3)+1:end)=0;
        [X,Y,THRE,AUC_s2_time_sh(i,it),OPTROCPT,SUBY,SUBYNAMES] = perfcurve(labels,scores,1);
    end
end
figure;plot(x,AUC_s2_time,'c')
hold on
plot(x,nanmean(AUC_s2_time_sh,2)+1.96*nanstd(AUC_s2_time_sh,0,2),'--k')
plot(x,nanmean(AUC_s2_time_sh,2)-1.96*nanstd(AUC_s2_time_sh,0,2),'--k')
xlim([-.2 2])

