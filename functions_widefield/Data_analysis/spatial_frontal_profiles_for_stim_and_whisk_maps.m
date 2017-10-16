
cd D:\intrinsic\20150511\c\Matt_files
load('seed_map_s1_per_trial.mat')

y=fliplr(smoothn(nanmean(seed_map_s1,3),[1 1],'Gauss')');            
figure;imagesc(y,[.5 1]);colormap(mapgeog)
line([143 160],[11 175],'Marker','.','LineStyle','-','LineWidth',3,'Color','w')
line([129 134],[18 61],'Marker','.','LineStyle','-','LineWidth',3,'Color','r')
axis square
axis off

load('stim_ave.mat')
y3=fliplr(smoothn(nanmean(tr_ave(:,:,28),3)-1,[3 3],'Gauss')');
figure;imagesc(y3,[-.25e-2 2.25e-2]);colormap(mapgeog)
hold on
line([139 151],[12 161],'Marker','.','LineStyle','-','LineWidth',3,'Color','w')
axis square
axis off
[slice, slice1D_s1_amp, imgTransformedRotated, imgTransformed] = rotateAndSlice_guy(y3', 100, 42, 0, 15);
xs1=((1:205)-151)*0.05;
figure;plot(xs1,slice1D_s1_amp)


cd D:\intrinsic\20150617\a\Matt_files
load('whisk_map.mat')
y2=fliplr(smoothn(nanmean(reshape(nanmean(whisk_map(:,:),2),[205,205]),3),[5 5],'Gauss')');
figure;imagesc(y2,[.1 .4]);colormap(mapgeog)
hold on
axis square
axis off
[slice, slice1D_wh, imgTransformedRotated, imgTransformed] = rotateAndSlice_guy(y2', 100, 42, 0, 15);
xs2=((1:205)-125)*0.05;
%figure;plot(xs2,slice1D_wh)

load('stim_whisk_trig_ave.mat')
y4=fliplr(smoothn(nanmean(amp_trig_ave(:,:,18:22),3)-1,[3 3],'Gauss')');
figure;imagesc(y4,[0e-2 2.5e-2]);colormap(mapgeog)
hold on
axis square
axis off
[slice, slice1D_wh_amp, imgTransformedRotated, imgTransformed] = rotateAndSlice_guy(y4', 100, 42, 0, 15);
xs2=((1:205)-125)*0.05;
figure;plot(xs2,slice1D_wh_amp)
xlim([-3 0.5])

slice1D_wh_n_amp=slice1D_wh_amp/max(slice1D_wh_amp);
slice1D_s1_n_amp=slice1D_s1_amp/max(slice1D_s1_amp);
figure;plot(xs1,slice1D_s1_n_amp,'b')
hold on
plot(xs2,slice1D_wh_n_amp,'r')
xlim([-3 0.5])

slice1D_wh_n=slice1D_wh/max(slice1D_wh);
slice1D_s1_n=slice1D_s1/max(slice1D_s1);
figure;plot(xs1,slice1D_s1_n,'b')
hold on
plot(xs2,slice1D_wh_n,'r')

