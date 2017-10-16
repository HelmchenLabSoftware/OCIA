
cd D:\intrinsic\20151023\a\Matt_files
fr2=142:147;

list100 = dir('cond_100_trial*');
for i=1:size(list100,1)
    disp(i)
    eval(['load cond_100_trial',int2str(i)])
    if i==1
        cond_100=tr;
    else
        cond_100=cat(4,cond_100,tr);
    end
end
cond_100=reshape(cond_100,256*256,180,size(cond_100,4));
list1200 = dir('cond_1200_trial*');
for i=1:size(list1200,1)
    disp(i)
    eval(['load cond_1200_trial',int2str(i)])
    if i==1
        cond_1200=tr;
    else
        cond_1200=cat(4,cond_1200,tr);
    end
end
cond_1200=reshape(cond_1200,256*256,180,size(cond_1200,4));




load('norm_frame_100')
fr_dev=reshape(fr_dev,256*256,1,size(cond_100,3));
cond_100=cond_100.*repmat(fr_dev,[1 180 1]);
fr_dev2=nanmean(cond_100(:,fr2,:),2);
cond_100=cond_100./repmat(fr_dev2,[1 180 1]);

load('norm_frame_1200')
fr_dev=reshape(fr_dev,256*256,1,size(cond_1200,3));
cond_1200=cond_1200.*repmat(fr_dev,[1 180 1]);
fr_dev2=nanmean(cond_1200(:,fr2,:),2);
cond_1200=cond_1200./repmat(fr_dev2,[1 180 1]);

load('rois_initial_205x205.mat')


load('trials_ind_clean_205x205.mat')
tr_100_c=ones(1,size(cond_100,3));
tr_100_c(tr_bad_100)=0;
tr_1200_c=ones(1,size(cond_1200,3));
tr_1200_c(tr_bad_1200)=0;
cond_100_ave=nanmean(cond_100(:,:,tr_100_c==1),3);
save cond_100_ave_clean_norm_response2 cond_100_ave fr_dev2 fr2
cond_1200_ave=nanmean(cond_1200(:,:,tr_1200_c==1),3);
save cond_1200_ave_clean_norm_response2 cond_1200_ave fr_dev2 fr2

cond_100_ave=nanmean(cond_100,3);
save cond_100_ave_norm_response2 cond_100_ave fr_dev2 fr2
cond_1200_ave=nanmean(cond_1200,3);
save cond_1200_ave_norm_response2 cond_1200_ave fr_dev2 fr2


% cond_100_ave=nanmean(cond_100,3);
% cond_1200_ave=nanmean(cond_1200,3);

% x=(1:180)*0.05-2.7;
% figure;plot(x,smooth(squeeze(nanmean(cond_100_ave(roi_a1,:,:),1))-1,1,'Gauss'),'g')
% hold on
% plot(x,smooth(squeeze(nanmean(cond_1200_ave(roi_a1,:,:),1))-1,1,'Gauss'),'--g')
% plot(x,zeros(1,180),'k')
% 
% 
% x=(1:180)*0.05-2.7;
% figure;plot(x,smooth(squeeze(nanmean(cond_100_ave(roi_m2,:,:),1))-1,1,'Gauss'),'k')
% hold on
% plot(x,smooth(squeeze(nanmean(cond_1200_ave(roi_m2,:,:),1))-1,1,'Gauss'),'--k')
% plot(x,zeros(1,180),'k')

x=(1:size(cond_100_ave,2))*0.05-1.9;
figure;plot(x,smooth(squeeze(nanmean(cond_100_ave(roi_s1,:,:),1))-1,1,'Gauss'),'b')
hold on
plot(x,smooth(squeeze(nanmean(cond_1200_ave(roi_s1,:,:),1))-1,1,'Gauss'),'--b')
plot(x,smooth(squeeze(nanmean(cond_100_ave(roi_s2,:,:),1))-1,1,'Gauss'),'c')
plot(x,smooth(squeeze(nanmean(cond_1200_ave(roi_s2,:,:),1))-1,1,'Gauss'),'--c')
xlim([-.2 2])
plot(x,zeros(1,180),'k')




%%

% for i=180:-1:1
%     figure;imagesc(smoothn(reshape(nanmean(cond_100(:,i,:),3)-nanmean(cond_1200(:,i,:),3),205,205),[5 5],'Gauss'),[-1.5e-2 1.5e-2]);colormap(mapgeog)
%     %hold on
%     %contour(reshape(h,205,205),'k')
%     title([int2str(x(i)*1000)])
%     %title([int2str(i)])
% end
% 



