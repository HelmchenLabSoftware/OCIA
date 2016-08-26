
cd D:\intrinsic\20150127\d\Matt_files

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
cond_100=reshape(cond_100,205*205,180,size(cond_100,4));

load('rois_initial_205x205.mat')
cond_100_ave=nanmean(cond_100,3);
%cond_1200_ave=nanmean(cond_1200,3);
x=(1:180)*0.05-2.7;
figure;plot(x,smooth(squeeze(nanmean(cond_100_ave(roi_m2,:,:),1))-1,1,'Gauss'),'r')
hold on
plot(x,smooth(squeeze(nanmean(cond_100_ave(roi_s1,:,:),1))-1,1,'Gauss'),'b')
plot(x,zeros(1,180),'k')
legend('m1','s1')

load('norm_frame_100')
fr_dev=reshape(fr_dev,205*205,1,size(cond_100,3));
cond_100=cond_100.*repmat(fr_dev,[1 180 1]);

cond_100_ave=nanmean(cond_100,3);
%cond_1200_ave=nanmean(cond_1200,3);
x=(1:180)*0.05-2.7;
figure;plot(x,smooth(squeeze(nanmean(cond_100_ave(roi_m2,:,:),1)),1,'Gauss'),'r')
hold on
plot(x,smooth(squeeze(nanmean(cond_100_ave(roi_s1,:,:),1)),1,'Gauss'),'b')
%plot(x,smooth(squeeze(nanmean(cond_1200_ave(roi_m2,:,:),1))-1,1,'Gauss'),'--m')
legend('m1','s1')


fr_dev2=min(cond_100(:,:,:),[],2);
cond_100=cond_100./repmat(fr_dev2,[1 180 1]);

cond_100_ave=nanmean(cond_100,3);
figure;plot(x,smooth(squeeze(nanmean(cond_100_ave(roi_m2,:,:),1))-1,1,'Gauss'),'r')
hold on
plot(x,smooth(squeeze(nanmean(cond_100_ave(roi_s1,:,:),1))-1,1,'Gauss'),'b')
%plot(x,smooth(squeeze(nanmean(cond_1200_ave(roi_m2,:,:),1))-1,1,'Gauss'),'--m')
legend('m1','s1')



