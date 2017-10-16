%% create spectograms for specific rois
clear all
%load rois
cd /fat2/Ariel_Gilad/Matlab_analysis/LED_test/2008_03_10/rois
load roi_V1
load roi_V2
load roi_V4

cd /fat2/Ariel_Gilad/Matlab_analysis/LED_test/2008_03_10/CrossNormalPattern4ms/conds
for i=[1 6] %condition count
    disp(['condition #',int2str(i),' good luck'])
    disp('catenating very large matrices. this could take a while')
    eval(['load spect_pixel_wise_cond',int2str(i),'_res_64_bl8_bl_1_239'])
    eval(['spect_pixel_wise_cond',int2str(i),'_roi_V1_1_239=spect_pixel_wise_cond',int2str(i),'_time_1_239(:,:,roi_V1);'])
    eval(['spect_pixel_wise_cond',int2str(i),'_roi_V2_1_239=spect_pixel_wise_cond',int2str(i),'_time_1_239(:,:,roi_V2);'])
    eval(['spect_pixel_wise_cond',int2str(i),'_roi_V4_1_239=spect_pixel_wise_cond',int2str(i),'_time_1_239(:,:,roi_V4);'])
    eval(['clear spect_pixel_wise_cond',int2str(i),'_time_1_239'])
    
    eval(['load spect_pixel_wise_cond',int2str(i),'_res_64_bl8_bl_240_479'])
    eval(['spect_pixel_wise_cond',int2str(i),'_roi_V1_240_479=spect_pixel_wise_cond',int2str(i),'_time_240_479(:,:,roi_V1);'])    
    eval(['spect_pixel_wise_cond',int2str(i),'_roi_V2_240_479=spect_pixel_wise_cond',int2str(i),'_time_240_479(:,:,roi_V2);']) 
    eval(['spect_pixel_wise_cond',int2str(i),'_roi_V4_240_479=spect_pixel_wise_cond',int2str(i),'_time_240_479(:,:,roi_V4);'])
    eval(['clear spect_pixel_wise_cond',int2str(i),'_time_240_479'])
    
    eval(['spect_pixel_wise_cond',int2str(i),'_roi_V1=cat(2,spect_pixel_wise_cond',int2str(i),'_roi_V1_1_239,spect_pixel_wise_cond',int2str(i),'_roi_V1_240_479);'])
    eval(['spect_pixel_wise_cond',int2str(i),'_roi_V2=cat(2,spect_pixel_wise_cond',int2str(i),'_roi_V2_1_239,spect_pixel_wise_cond',int2str(i),'_roi_V2_240_479);'])
    eval(['spect_pixel_wise_cond',int2str(i),'_roi_V4=cat(2,spect_pixel_wise_cond',int2str(i),'_roi_V4_1_239,spect_pixel_wise_cond',int2str(i),'_roi_V4_240_479);'])
    
    eval(['clear spect_pixel_wise_cond',int2str(i),'_roi_V1_1_239'])
    eval(['clear spect_pixel_wise_cond',int2str(i),'_roi_V1_240_479'])
    eval(['clear spect_pixel_wise_cond',int2str(i),'_roi_V2_1_239'])
    eval(['clear spect_pixel_wise_cond',int2str(i),'_roi_V2_240_479'])
    eval(['clear spect_pixel_wise_cond',int2str(i),'_roi_V4_1_239'])
    eval(['clear spect_pixel_wise_cond',int2str(i),'_roi_V4_240_479'])
    
    eval(['save spect_pixel_wise_cond',int2str(i),'_roi_V1 spect_pixel_wise_cond',int2str(i),'_roi_V1'])
    eval(['save spect_pixel_wise_cond',int2str(i),'_roi_V2 spect_pixel_wise_cond',int2str(i),'_roi_V2'])
    eval(['save spect_pixel_wise_cond',int2str(i),'_roi_V4 spect_pixel_wise_cond',int2str(i),'_roi_V4'])
    
    eval(['clear spect_pixel_wise_cond',int2str(i),'_roi_V1'])
    eval(['clear spect_pixel_wise_cond',int2str(i),'_roi_V2'])
    eval(['clear spect_pixel_wise_cond',int2str(i),'_roi_V4'])
    
end;

clear all



%% create spectograms for specific rois
clear all
%load rois
cd /fat2/Ariel_Gilad/Matlab_analysis/2008_02_19/rois
load roi_V1
load roi_V2
load roi_V4

cd /fat2/Ariel_Gilad/Matlab_analysis/2008_02_19/cond_data_a
for i=[1 3] %condition count
    disp(['condition #',int2str(i),' good luck'])
    disp('catenating very large matrices. this could take a while')
    eval(['load spect_pixel_wise_cond',int2str(i),'_res_64_bl8_hb_1_239_div_2'])
    eval(['spect_pixel_wise_cond',int2str(i),'_roi_V1_1_239_div_2=spect_pixel_wise_cond',int2str(i),'_time_1_239(:,:,roi_V1);'])
    eval(['spect_pixel_wise_cond',int2str(i),'_roi_V2_1_239_div_2=spect_pixel_wise_cond',int2str(i),'_time_1_239(:,:,roi_V2);'])
    eval(['spect_pixel_wise_cond',int2str(i),'_roi_V4_1_239_div_2=spect_pixel_wise_cond',int2str(i),'_time_1_239(:,:,roi_V4);'])
    eval(['clear spect_pixel_wise_cond',int2str(i),'_time_1_239'])
    
    eval(['load spect_pixel_wise_cond',int2str(i),'_res_64_bl8_hb_240_479_div_2'])
    eval(['spect_pixel_wise_cond',int2str(i),'_roi_V1_240_479_div_2=spect_pixel_wise_cond',int2str(i),'_time_240_479(:,:,roi_V1);'])    
    eval(['spect_pixel_wise_cond',int2str(i),'_roi_V2_240_479_div_2=spect_pixel_wise_cond',int2str(i),'_time_240_479(:,:,roi_V2);']) 
    eval(['spect_pixel_wise_cond',int2str(i),'_roi_V4_240_479_div_2=spect_pixel_wise_cond',int2str(i),'_time_240_479(:,:,roi_V4);'])
    eval(['clear spect_pixel_wise_cond',int2str(i),'_time_240_479'])
    
    eval(['spect_pixel_wise_cond',int2str(i),'_roi_V1_div_2=cat(2,spect_pixel_wise_cond',int2str(i),'_roi_V1_1_239_div_2,spect_pixel_wise_cond',int2str(i),'_roi_V1_240_479_div_2);'])
    eval(['spect_pixel_wise_cond',int2str(i),'_roi_V2_div_2=cat(2,spect_pixel_wise_cond',int2str(i),'_roi_V2_1_239_div_2,spect_pixel_wise_cond',int2str(i),'_roi_V2_240_479_div_2);'])
    eval(['spect_pixel_wise_cond',int2str(i),'_roi_V4_div_2=cat(2,spect_pixel_wise_cond',int2str(i),'_roi_V4_1_239_div_2,spect_pixel_wise_cond',int2str(i),'_roi_V4_240_479_div_2);'])
    
    eval(['clear spect_pixel_wise_cond',int2str(i),'_roi_V1_1_239_div_2'])
    eval(['clear spect_pixel_wise_cond',int2str(i),'_roi_V1_240_479_div_2'])
    eval(['clear spect_pixel_wise_cond',int2str(i),'_roi_V2_1_239_div_2'])
    eval(['clear spect_pixel_wise_cond',int2str(i),'_roi_V2_240_479_div_2'])
    eval(['clear spect_pixel_wise_cond',int2str(i),'_roi_V4_1_239_div_2'])
    eval(['clear spect_pixel_wise_cond',int2str(i),'_roi_V4_240_479_div_2'])
    
    eval(['save spect_pixel_wise_cond',int2str(i),'_roi_V1_div_2 spect_pixel_wise_cond',int2str(i),'_roi_V1_div_2'])
    eval(['save spect_pixel_wise_cond',int2str(i),'_roi_V2_div_2 spect_pixel_wise_cond',int2str(i),'_roi_V2_div_2'])
    eval(['save spect_pixel_wise_cond',int2str(i),'_roi_V4_div_2 spect_pixel_wise_cond',int2str(i),'_roi_V4_div_2'])
    
    eval(['clear spect_pixel_wise_cond',int2str(i),'_roi_V1_div_2'])
    eval(['clear spect_pixel_wise_cond',int2str(i),'_roi_V2_div_2'])
    eval(['clear spect_pixel_wise_cond',int2str(i),'_roi_V4_div_2'])
    
end;

clear all