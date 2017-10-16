cd W:\Neurophysiology-Storage1\Gilad\Data_per_mouse\mouse_tgg6fl23_8\20151021\c
load('rois_OCIA.mat')
load('first_move_in_delay.mat')
load('trials_with_and_wo_initial_moves_OCIA_from_movie.mat')

k=0;
for i=tr_1200_no_prior_move
    k=k+1;
    disp(i)
    load(['cond_1200_trial',int2str(i)])
    tr(:,:,first_move_1200_delay(i):end)=nan;
    tt(:,:,:,k)=tr;
end
tt=nanmean(tt,4);

k=0;
for i=tr_100_no_prior_move  
    k=k+1;
    disp(i)
    load(['cond_100_trial',int2str(i)])
    tr(:,:,first_move_100_delay(i):end)=nan;
    t(:,:,:,k)=tr;
end
t=nanmean(t,4);


d=reshape(t,size(t,2)*size(t,2),size(t,3));
figure;plot(smooth(squeeze(nanmean(d(roi_S1BC,:),1))-1,1,'Gauss'))
hold on
plot(smooth(squeeze(nanmean(d(roi_S2,:),1))-1,1,'Gauss'),'c')
plot(smooth(squeeze(nanmean(d(roi_M2,:),1))-1,1,'Gauss'),'k')
%plot(smooth(squeeze(nanmean(d(roi_A1,:),1))-1,1,'Gauss'),'g')
plot(smooth(squeeze(nanmean(d(roi_EC,:),1))-1,1,'Gauss'),'m')


d3=reshape(tt,size(tt,2)*size(tt,2),size(tt,3));
figure;plot(smooth(squeeze(nanmean(d3(roi_S1BC,:),1))-1,1,'Gauss'),'--b')
hold on
plot(smooth(squeeze(nanmean(d3(roi_S2,:),1))-1,1,'Gauss'),'--c')
plot(smooth(squeeze(nanmean(d3(roi_M2,:),1))-1,1,'Gauss'),'--k')
%plot(smooth(squeeze(nanmean(d3(roi_A1,:),1))-1,1,'Gauss'),'--g')
plot(smooth(squeeze(nanmean(d3(roi_EC,:),1))-1,1,'Gauss'),'--m')


time=110:130;
figure;imagesc(smoothn(nanmean(tt(:,:,time)-1,3),[5 5],'Gauss'),[-1e-2 1e-2]);colormap(mapgeog)
figure;imagesc(smoothn(nanmean(t(:,:,time)-1,3),[5 5],'Gauss'),[-1e-2 1e-2]);colormap(mapgeog)
figure;imagesc(smoothn(nanmean(tt(:,:,time)-t(:,:,time),3),[5 5],'Gauss'),[-1e-2 1e-2]);colormap(mapgeog)


figure;plot(smooth(squeeze(nanmean(d(roi_S1BC,:),1))-squeeze(nanmean(d3(roi_S1BC,:),1)),1,'Gauss'))
hold on
plot(smooth(squeeze(nanmean(d(roi_S2,:),1))-squeeze(nanmean(d3(roi_S2,:),1)),1,'Gauss'),'c')

save conds_1200_100_no_prior_move t tt tr_100_no_prior_move tr_1200_no_prior_move

%%


k=0;
for i=tr_1200_prior_move
    k=k+1;
    disp(i)
    load(['cond_1200_trial',int2str(i)])
    tr(:,:,first_move_1200_delay(i):end)=nan;
    tt(:,:,:,k)=tr;
end
tt=nanmean(tt,4);

k=0;
for i=tr_100_prior_move  
    k=k+1;
    disp(i)
    load(['cond_100_trial',int2str(i)])
    tr(:,:,first_move_100_delay(i):end)=nan;
    t(:,:,:,k)=tr;
end
t=nanmean(t,4);


d=reshape(t,size(t,2)*size(t,2),size(t,3));
figure;plot(smooth(squeeze(nanmean(d(roi_S1BC,:),1))-1,1,'Gauss'))
hold on
plot(smooth(squeeze(nanmean(d(roi_S2,:),1))-1,1,'Gauss'),'c')
plot(smooth(squeeze(nanmean(d(roi_M2,:),1))-1,1,'Gauss'),'k')
%plot(smooth(squeeze(nanmean(d(roi_A1,:),1))-1,1,'Gauss'),'g')
plot(smooth(squeeze(nanmean(d(roi_EC,:),1))-1,1,'Gauss'),'m')

d3=reshape(tt,size(tt,2)*size(tt,2),size(tt,3));
figure;plot(smooth(squeeze(nanmean(d3(roi_S1BC,:),1))-1,1,'Gauss'),'--b')
hold on
plot(smooth(squeeze(nanmean(d3(roi_S2,:),1))-1,1,'Gauss'),'--c')
plot(smooth(squeeze(nanmean(d3(roi_M2,:),1))-1,1,'Gauss'),'--k')
%plot(smooth(squeeze(nanmean(d3(roi_A1,:),1))-1,1,'Gauss'),'--g')
plot(smooth(squeeze(nanmean(d3(roi_EC,:),1))-1,1,'Gauss'),'--m')

time=110:140;
figure;imagesc(smoothn(nanmean(tt(:,:,time)-1,3),[5 5],'Gauss'),[-1e-2 1e-2]);colormap(mapgeog)
figure;imagesc(smoothn(nanmean(t(:,:,time)-1,3),[5 5],'Gauss'),[-1e-2 1e-2]);colormap(mapgeog)
figure;imagesc(smoothn(nanmean(tt(:,:,time)-t(:,:,time),3),[5 5],'Gauss'),[-1e-2 1e-2]);colormap(mapgeog)


save conds_1200_100_prior_move t tt tr_100_prior_move tr_1200_prior_move

