cd D:\intrinsic\20150617\a\Matt_files
load('whisker_trigger_map_session_average.mat')
xs2=((1:205)-125)*0.05;
GA_m1_m2=nan*ones(21,2);
for i=1:21
    y4=fliplr(smoothn(nanmean(amp_trig_ses(:,:,18:22,i),3)-1,[3 3],'Gauss')');
    [slice, slice1D_wh_amp, imgTransformedRotated, imgTransformed] = rotateAndSlice_guy(y4', 100, 42, 0, 15);    
    GA_m1_m2(i,:)=[nanmean(slice1D_wh_amp(find(xs2==-2.2):find(xs2==-1.1))) nanmean(slice1D_wh_amp(find(xs2==-0.9):find(xs2==0)))];
%     figure;plot(xs2,slice1D_wh_amp)
%     xlim([-3 0.5])
end

figure;bar(nanmean(GA_m1_m2,1))
hold on
errorbar(nanmean(GA_m1_m2,1),nanmean(GA_m1_m2,1)/sqrt(size(GA_m1_m2,1)))
signrank(GA_m1_m2(:,1),GA_m1_m2(:,2))







