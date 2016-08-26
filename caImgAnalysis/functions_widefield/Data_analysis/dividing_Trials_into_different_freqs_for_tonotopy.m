cd D:\intrinsic\20150504\mouse_tgg6fl23_5\g\Matt_files
load('FreqVector_5Freq20Repetition.mat')
fr_4000=find(FV==FV(4));
fr_5656=find(FV==FV(2));
fr_8000=find(FV==FV(3));
fr_11314=find(FV==FV(5));
fr_16000=find(FV==FV(1));
load stim_trial1

k=0;
cond_fr4000=nan*ones(205,205,size(tr,3),size(fr_4000,2));
for i=fr_4000
    k=k+1;
    eval(['load stim_trial',int2str(i)])
    cond_fr4000(:,:,:,k)=tr;
end


k=0;
cond_fr5656=nan*ones(205,205,size(tr,3),size(fr_5656,2));
for i=fr_5656
    k=k+1;
    eval(['load stim_trial',int2str(i)])
    cond_fr5656(:,:,:,k)=tr;
end

k=0;
cond_fr8000=nan*ones(205,205,size(tr,3),size(fr_8000,2));
for i=fr_8000
    k=k+1;
    eval(['load stim_trial',int2str(i)])
    cond_fr8000(:,:,:,k)=tr;
end

k=0;
cond_fr11314=nan*ones(205,205,size(tr,3),size(fr_11314,2));
for i=fr_11314
    k=k+1;
    eval(['load stim_trial',int2str(i)])
    cond_fr11314(:,:,:,k)=tr;
end

k=0;
cond_fr16000=nan*ones(205,205,size(tr,3),size(fr_16000,2));
for i=fr_16000
    k=k+1;
    eval(['load stim_trial',int2str(i)])
    cond_fr16000(:,:,:,k)=tr;
end

save cond_fr4000 cond_fr4000
save cond_fr5656 cond_fr5656
save cond_fr8000 cond_fr8000
save cond_fr11314 cond_fr11314
save cond_fr16000 cond_fr16000




%%
time=82;
figure;imagesc(smoothn(nanmean(nanmean(cond_fr4000(:,:,time,:),3),4)-1,[5 5],'Gauss'),[-.25e-2 .5e-2]);colormap(mapgeog)
figure;imagesc(smoothn(nanmean(nanmean(cond_fr5656(:,:,time,:),3),4)-1,[5 5],'Gauss'),[-.25e-2 .5e-2]);colormap(mapgeog)
figure;imagesc(smoothn(nanmean(nanmean(cond_fr8000(:,:,time,:),3),4)-1,[5 5],'Gauss'),[-.25e-2 .5e-2]);colormap(mapgeog)
figure;imagesc(smoothn(nanmean(nanmean(cond_fr11314(:,:,time,:),3),4)-1,[5 5],'Gauss'),[-.25e-2 .5e-2]);colormap(mapgeog)
figure;imagesc(smoothn(nanmean(nanmean(cond_fr16000(:,:,time,:),3),4)-1,[5 5],'Gauss'),[-.25e-2 .5e-2]);colormap(mapgeog)


for i=150:-1:1
    figure;imagesc(smoothn(nanmean(nanmean(cond_fr4000(:,:,i,:),3),4)-1,[3 3],'Gauss'),[-1e-2 2.5e-2]);colormap(mapgeog)
    %hold on
    %contour(reshape(h,2048,2048),'k')
    %title([int2str(x(i)*1000)])
    title([int2str(i)])
end



figure(100);imagesc(smoothn(nanmean(nanmean(cond_fr4000(:,:,time,:),3),4)-1,[3 3],'Gauss'),[-1e-2 2e-2]);colormap(mapgeog)
roi_s1 = choose_polygon_imagesc(205);
roi_m1 = choose_polygon_imagesc(205);
roi_a1 = choose_polygon_imagesc(205);
roi_s2 = choose_polygon_imagesc(205);


d=reshape(nanmean(cond_fr4000,4),205*205,size(cond_fr4000,3));
figure;plot(smooth(squeeze(nanmean(d(roi_s1,:),1))-1,1,'Gauss'))
hold on
plot(smooth(squeeze(nanmean(d(roi_s2,:),1))-1,1,'Gauss'),'c')
plot(smooth(squeeze(nanmean(d(roi_m1,:),1))-1,1,'Gauss'),'r')
plot(smooth(squeeze(nanmean(d(roi_a1,:),1))-1,1,'Gauss'),'g')














