
cd D:\intrinsic\20150511
load rois_v2

cd D:\intrinsic\20150511\c\Matt_files
load('stim_ave.mat')
y=fliplr(smoothn(nanmean(tr_ave(:,:,28),3)-1,[3 3],'Gauss')');
y(isnan(y))=10000;
figure;imagesc(y,[-.25e-2 2.25e-2]);colormap(mapgeog)
hold on
line([143 158],[13 156],'Marker','.','LineStyle','-','LineWidth',3,'Color','w')
axis square
axis off

y=fliplr(smoothn(nanmean(tr_ave(:,:,28),3)-1,[1 1],'Gauss')');
[slice, slice1D_s1_amp, imgTransformedRotated, imgTransformed] = rotateAndSlice_guy(y', 100, 42, 0, 15);
xs1=((1:205)-151)*0.05;
figure;plot(xs1,slice1D_s1_amp)
xlim([-3 0.5])
figure;bar([nanmean(slice1D_s1_amp(107:129)) nanmean(slice1D_s1_amp(133:151))])


d=reshape(nanmean(tr_ave(:,:,28),3)-1,205*205,1);
amp_wh=[nanmean(d(roi_s1)) nanmean(d(roi_s2)) nanmean(d(roi_a1)) nanmean(d(roi_v1))];
figure;bar(amp_wh)




cd D:\intrinsic\20150511\d\Matt_files
load('stim_ave.mat')
y=fliplr(smoothn(nanmean(tr_ave(:,:,15),3)-1,[3 3],'Gauss')');
y(isnan(y))=10000;
figure;imagesc(y,[-.25e-2 1.25e-2]);colormap(mapgeog)
hold on
line([143 158],[13 156],'Marker','.','LineStyle','-','LineWidth',3,'Color','w')
axis square
axis off
d=reshape(nanmean(tr_ave(:,:,15),3)-1,205*205,1);
amp_aud=[nanmean(d(roi_s1)) nanmean(d(roi_s2)) nanmean(d(roi_a1)) nanmean(d(roi_v1))];
figure;bar(amp_aud)

y=fliplr(smoothn(nanmean(tr_ave(:,:,15),3)-1,[3 3],'Gauss')');
[slice, slice1D_s1_amp, imgTransformedRotated, imgTransformed] = rotateAndSlice_guy(y', 100, 42, 0, 15);
xs1=((1:205)-151)*0.05;
figure;plot(xs1,slice1D_s1_amp)
xlim([-3 0.5])


cd D:\intrinsic\20150511\b\Matt_files
load('stim_ave_trials_3_8_9.mat')
y=fliplr(smoothn(nanmean(tr_ave(:,:,148:158),3)-1,[3 3],'Gauss')');
y(isnan(y))=10000;
figure;imagesc(y,[-.25e-2 3e-2]);colormap(mapgeog)
hold on
line([143 158],[13 156],'Marker','.','LineStyle','-','LineWidth',3,'Color','w')
axis square
axis off
d=reshape(nanmean(tr_ave(:,:,148:158),3)-1,205*205,1);
amp_vis=[nanmean(d(roi_s1)) nanmean(d(roi_s2)) nanmean(d(roi_a1)) nanmean(d(roi_v1))];
figure;bar(amp_vis)


y=fliplr(smoothn(nanmean(tr_ave(:,:,148:158),3)-1,[3 3],'Gauss')');
[slice, slice1D_s1_amp, imgTransformedRotated, imgTransformed] = rotateAndSlice_guy(y', 100, 42, 0, 15);
xs1=((1:205)-151)*0.05;
figure;plot(xs1,slice1D_s1_amp)
xlim([-3 0.5])





