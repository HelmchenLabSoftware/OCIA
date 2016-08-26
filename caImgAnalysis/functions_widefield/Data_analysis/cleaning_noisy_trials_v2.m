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
cond_100=reshape(cond_100,205*205,size(cond_100,3),size(cond_100,4));
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
cond_1200=reshape(cond_1200,205*205,size(cond_1200,3),size(cond_1200,4));

%%
load rois_initial_205x205
load('trials_ind.mat')

for i=1:size(cond_100,3)
    figure('position',[20 20 900 900]);   
    subplot(2,1,1)
    errorbar(nanmean(nanmean(cond_100(roi_s1,1:180,:),1),3),2*nanstd(nanmean(cond_100(roi_s1,1:180,:),1),0,3),'k')
    hold on
    plot(nanmean(cond_100(roi_s2,1:180,i),1),'b')
    xlim([0 180])
    title(['trial #',int2str(i)])
    subplot(2,1,2)
    errorbar(nanmean(nanmean(cond_100(roi_m2,1:180,:),1),3),2*nanstd(nanmean(cond_100(roi_m2,1:180,:),1),0,3),'k')
    hold on
    plot(nanmean(cond_100(roi_m2,1:180,i),1),'r')
    xlim([0 180])
end

tr_bad_100=[1 6 8];
tr_100_c=ones(1,size(cond_100,3));
tr_100_c(tr_bad_100)=0;
tr_100_clean=tr_100(tr_100_c==1);



for i=1:size(cond_1200,3)
    figure('position',[20 20 900 900]);   
    subplot(2,1,1)
    errorbar(nanmean(nanmean(cond_1200(roi_s1,:,:),1),3),2*nanstd(nanmean(cond_1200(roi_s1,:,:),1),0,3),'k')
    hold on
    plot(nanmean(cond_1200(roi_s2,:,i),1),'b')
    xlim([0 180])
    title(['trial #',int2str(i)])
    subplot(2,1,2)
    errorbar(nanmean(nanmean(cond_1200(roi_m2,:,:),1),3),2*nanstd(nanmean(cond_1200(roi_m2,:,:),1),0,3),'k')
    hold on
    plot(nanmean(cond_1200(roi_m2,:,i),1),'r')
    xlim([0 180])
end

tr_bad_1200=[16];
tr_1200_c=ones(1,size(cond_1200,3));
tr_1200_c(tr_bad_1200)=0;
tr_1200_clean=tr_1200(tr_1200_c==1);

save trials_ind_clean_205x205 tr_bad* tr_1200_clean tr_100_clean % tr_000_clean

cond_100_ave=nanmean(cond_100(:,:,tr_100_c==1),3);
save cond_100_ave_clean cond_100_ave

cond_1200_ave=nanmean(cond_1200(:,:,tr_1200_c==1),3);
save cond_1200_ave_clean cond_1200_ave










