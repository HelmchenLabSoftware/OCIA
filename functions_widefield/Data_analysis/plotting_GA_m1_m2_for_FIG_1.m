



cd D:\intrinsic\20150421\a\Matt_files
load('stim_ave.mat')
y3=fliplr(smoothn(nanmean(tr_ave(:,:,100:150),3)-1,[3 3],'Gauss')');
%figure;imagesc(y3,[-.25e-2 2.25e-2]);colormap(mapgeog)
[slice, slice1D_s1_amp, imgTransformedRotated, imgTransformed] = rotateAndSlice_guy(y3', 100, 34, 0, 15);
xs1=((1:205)-116)*0.05;
figure;plot(xs1,slice1D_s1_amp)
xlim([-4 0.5])
figure;bar([nanmean(slice1D_s1_amp(find(xs1==-2.2):find(xs1==-1.1))) nanmean(slice1D_s1_amp(find(xs1==-0.9):find(xs1==0)))])
GA_m1_m2=[nanmean(slice1D_s1_amp(find(xs1==-2.2):find(xs1==-1.1))) nanmean(slice1D_s1_amp(find(xs1==-0.9):find(xs1==0)))];


cd D:\intrinsic\20150504\mouse_tgg6fl23_3\c\Matt_files
load('stim_ave.mat')
y3=fliplr(smoothn(nanmean(tr_ave(:,:,100:120),3)-1,[3 3],'Gauss')');
%figure;imagesc(y3,[-.25e-2 1.25e-2]);colormap(mapgeog)
[slice, slice1D_s1_amp, imgTransformedRotated, imgTransformed] = rotateAndSlice_guy(y3', 100, 36, 0, 15);
xs1=((1:205)-150)*0.05;
figure;plot(xs1,slice1D_s1_amp)
xlim([-4 0.5])
figure;bar([nanmean(slice1D_s1_amp(find(xs1==-2.2):find(xs1==-1.1))) nanmean(slice1D_s1_amp(find(xs1==-0.9):find(xs1==0)))])
GA_m1_m2=cat(1,GA_m1_m2,[nanmean(slice1D_s1_amp(find(xs1==-2.2):find(xs1==-1.1))) nanmean(slice1D_s1_amp(find(xs1==-0.9):find(xs1==0)))]);



cd D:\intrinsic\20150504\mouse_tgg6fl23_5\c\Matt_files
load('stim_ave.mat')
y3=fliplr(smoothn(nanmean(tr_ave(:,:,80:100),3)-1,[3 3],'Gauss')');
%figure;imagesc(y3,[-.25e-2 2e-2]);colormap(mapgeog)
[slice, slice1D_s1_amp, imgTransformedRotated, imgTransformed] = rotateAndSlice_guy(y3', 100, 32, 0, 15);
xs1=((1:205)-140)*0.05;
figure;plot(xs1,slice1D_s1_amp)
xlim([-4 0.5])
figure;bar([nanmean(slice1D_s1_amp(find(xs1==-2.2):find(xs1==-1.1))) nanmean(slice1D_s1_amp(find(xs1==-0.9):find(xs1==0)))])
GA_m1_m2=cat(1,GA_m1_m2,[nanmean(slice1D_s1_amp(find(xs1==-2.2):find(xs1==-1.1))) nanmean(slice1D_s1_amp(find(xs1==-0.9):find(xs1==0)))]);


cd D:\intrinsic\20150504\mouse_tgg6fl23_4\c\Matt_files
load('stim_ave.mat')
y3=fliplr(smoothn(nanmean(tr_ave(:,:,80:100),3)-1,[3 3],'Gauss')');
%figure;imagesc(y3,[-.25e-2 2e-2]);colormap(mapgeog)
[slice, slice1D_s1_amp, imgTransformedRotated, imgTransformed] = rotateAndSlice_guy(y3', 100, 32, 0, 15);
xs1=((1:205)-145)*0.05;
figure;plot(xs1,slice1D_s1_amp)
xlim([-4 0.5])
figure;bar([nanmean(slice1D_s1_amp(find(xs1==-2.2):find(xs1==-1.1))) nanmean(slice1D_s1_amp(find(xs1==-0.9):find(xs1==0)))])
GA_m1_m2=cat(1,GA_m1_m2,[nanmean(slice1D_s1_amp(find(xs1==-2.2):find(xs1==-1.1))) nanmean(slice1D_s1_amp(find(xs1==-0.9):find(xs1==0)))]);

cd D:\intrinsic\20150508\mouse_tgg6fl23_4\b\Matt_files
load('stim_ave.mat')
y3=fliplr(smoothn(nanmean(tr_ave(:,:,100:150),3)-1,[3 3],'Gauss')');
figure;imagesc(y3,[-.25e-2 2e-2]);colormap(mapgeog)
[slice, slice1D_s1_amp, imgTransformedRotated, imgTransformed] = rotateAndSlice_guy(y3', 100, 39, 0, 15);
xs1=((1:205)-142)*0.05;
figure;plot(xs1,slice1D_s1_amp)
xlim([-4 0.5])
figure;bar([nanmean(slice1D_s1_amp(find(xs1==-2.2):find(xs1==-1.1))) nanmean(slice1D_s1_amp(find(xs1==-0.9):find(xs1==0)))])
GA_m1_m2=cat(1,GA_m1_m2,[nanmean(slice1D_s1_amp(find(xs1==-2.2):find(xs1==-1.1))) nanmean(slice1D_s1_amp(find(xs1==-0.9):find(xs1==0)))]);


cd D:\intrinsic\20150511\c\Matt_files
load('stim_ave.mat')
y3=fliplr(smoothn(nanmean(tr_ave(:,:,28),3)-1,[3 3],'Gauss')');
%figure;imagesc(y3,[-.25e-2 2.25e-2]);colormap(mapgeog)
%hold on
% line([139 151],[12 161],'Marker','.','LineStyle','-','LineWidth',3,'Color','w')
% axis square
% axis off
[slice, slice1D_s1_amp, imgTransformedRotated, imgTransformed] = rotateAndSlice_guy(y3', 100, 42, 0, 15);
xs1=((1:205)-151)*0.05;
figure;plot(xs1,slice1D_s1_amp)
xlim([-4 0.5])
figure;bar([nanmean(slice1D_s1_amp(find(xs1==-2.2):find(xs1==-1.1))) nanmean(slice1D_s1_amp(find(xs1==-0.9):find(xs1==0)))])
GA_m1_m2=cat(1,GA_m1_m2,[nanmean(slice1D_s1_amp(find(xs1==-2.2):find(xs1==-1.1))) nanmean(slice1D_s1_amp(find(xs1==-0.9):find(xs1==0)))]);




cd D:\intrinsic\20150518\f\Matt_files
load('stim_ave.mat')
y3=fliplr(smoothn(nanmean(tr_ave(:,:,100:150),3)-1,[3 3],'Gauss')');
[slice, slice1D_s1_amp, imgTransformedRotated, imgTransformed] = rotateAndSlice_guy(y3', 128, 60, 0, 15);
xs1=((1:256)-173)*0.05;
figure;plot(xs1,slice1D_s1_amp)
xlim([-4 0.5])
figure;bar([nanmean(slice1D_s1_amp(find(xs1==-2.2):find(xs1==-1.1))) nanmean(slice1D_s1_amp(find(xs1==-0.9):find(xs1==0)))])
GA_m1_m2=cat(1,GA_m1_m2,[nanmean(slice1D_s1_amp(find(xs1==-2.2):find(xs1==-1.1))) nanmean(slice1D_s1_amp(find(xs1==-0.9):find(xs1==0)))]);


cd D:\intrinsic\20150518\b\Matt_files
load('stim_ave.mat')
y3=fliplr(smoothn(nanmean(tr_ave(:,:,100:150),3)-1,[3 3],'Gauss')');
[slice, slice1D_s1_amp, imgTransformedRotated, imgTransformed] = rotateAndSlice_guy(y3', 128, 60, 0, 15);
xs1=((1:256)-173)*0.05;
figure;plot(xs1,slice1D_s1_amp)
xlim([-4 0.5])
figure;bar([nanmean(slice1D_s1_amp(129:151)) nanmean(slice1D_s1_amp(155:173))])
GA_m1_m2=cat(1,GA_m1_m2,[nanmean(slice1D_s1_amp(find(xs1==-2.2):find(xs1==-1.1))) nanmean(slice1D_s1_amp(find(xs1==-0.9):find(xs1==0)))]);

% this is 100 ms 
cd D:\intrinsic\20150518\c\Matt_files
load('stim_ave.mat')
y3=fliplr(smoothn(nanmean(tr_ave(:,:,100:150),3)-1,[3 3],'Gauss')');
[slice, slice1D_s1_amp, imgTransformedRotated, imgTransformed] = rotateAndSlice_guy(y3', 128, 60, 0, 15);
xs1=((1:256)-173)*0.05;
figure;plot(xs1,slice1D_s1_amp)
xlim([-4 0.5])
figure;bar([nanmean(slice1D_s1_amp(find(xs1==-2.2):find(xs1==-1.1))) nanmean(slice1D_s1_amp(find(xs1==-0.9):find(xs1==0)))])
GA_m1_m2=cat(1,GA_m1_m2,[nanmean(slice1D_s1_amp(find(xs1==-2.2):find(xs1==-1.1))) nanmean(slice1D_s1_amp(find(xs1==-0.9):find(xs1==0)))]);

figure;bar(nanmean(GA_m1_m2,1))
hold on
errorbar(nanmean(GA_m1_m2,1),nanmean(GA_m1_m2,1)/sqrt(size(GA_m1_m2,1)))
signrank(GA_m1_m2(:,1),GA_m1_m2(:,2))








