%% image spectograms for VSDI for different rois in all conds
cd /fat2/Ariel_Gilad/Matlab_analysis/2008_02_12/cond_data_b
x=(-30:448)*4;
y=1:125/64:125;
k=0;
a=roi_V1;k=k+1;
b=roi_V2;k=k+1;
c=roi_V4;k=k+1;
%d=roi_t;k=k+1;
%e=roi_f2;k=k+1;
%f=roi_f4;k=k+1;
%g=roi_surround_target;k=k+1;
%h=roi_surround_flanker;k=k+1;
s = struct('r1', a, 'r2', b,'r3', c);
%s = struct('r1', a, 'r2', b,'r3', c,'r4', d,'r5', e,'r6', f,'r7', g,'r8', h);
for i=1:6 %condition count
    %eval(['load spect_pixel_wise_cond',int2str(i),'_res_64_bl8_bl'])
    disp('catenating very large matrices. this could take a while')
    eval(['load spect_pixel_wise_cond',int2str(i),'_res_64_bl8_hb_1_239'])
    eval(['load spect_pixel_wise_cond',int2str(i),'_res_64_bl8_hb_240_479'])
    eval(['spect_pixel_wise_cond',int2str(i),'_time_1_239=cat(2,spect_pixel_wise_cond',int2str(i),'_time_1_239,spect_pixel_wise_cond',int2str(i),'_time_240_479);'])
    eval(['clear spect_pixel_wise_cond',int2str(i),'_time_240_479'])
    
    for j=1:k %rois count
        disp(['cond #',int2str(i),' roi #',int2str(j)])
        figure(j);h = gcf;
        eval(['set(h,''Name'',''spectograms roi ',int2str(j),''')']);
        subplot(3,2,i);
        %eval(['imagesc(x,y,mean(spect_pixel_wise_cond',int2str(i),'(:,:,s.r',int2str(j),'),3),[-0.25 0.25]);colorbar(mapgeog);'])
        eval(['imagesc(x,y,mean(spect_pixel_wise_cond',int2str(i),'_time_1_239(:,:,s.r',int2str(j),'),3),[-1 3]);colormap(mapgeog);colorbar(mapgeog);'])
    end;
    %eval(['clear spect_pixel_wise_cond',int2str(i)])
    eval(['clear spect_pixel_wise_cond',int2str(i),'_time_1_239'])
end;



%%  image division
cd /fat2/Ariel_Gilad/Matlab_analysis/2008_02_19/cond_data_a
clear all
%roi_V1
load spect_pixel_wise_cond1_roi_V4
load spect_pixel_wise_cond1_roi_V4_div_2
load spect_pixel_wise_cond3_roi_V4
load spect_pixel_wise_cond3_roi_V4_div_2
figure;
subplot(2,2,1);
imagesc(nanmean(spect_pixel_wise_cond1_roi_V4,3),[-0.15 0.5]);colorbar(mapgeog);
subplot(2,2,2);
imagesc(nanmean(spect_pixel_wise_cond1_roi_V4_div_2,3),[-0.15 0.5]);colorbar(mapgeog);
subplot(2,2,3);
imagesc(nanmean(spect_pixel_wise_cond3_roi_V4,3),[-0.15 0.5]);colorbar(mapgeog);
subplot(2,2,4);
imagesc(nanmean(spect_pixel_wise_cond3_roi_V4_div_2,3),[-0.15 0.5]);colorbar(mapgeog);

clear all



