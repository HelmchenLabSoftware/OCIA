function [spect_pixel_wise,baseline_ave_pixels,baseline_std_pixels]=spectogram_pixel_wise(data)
%creates a spectogram for every pixel 
data_t=data(:,2:end,1);
for k=2:size(data,3)
    data_t=[data_t data(:,2:end,k)];
end;
clear data;
spect_pixel_wise=NaN*ones(64,479,10000);
baseline_ave_pixels=NaN*ones(64,10000);
baseline_std_pixels=NaN*ones(64,10000);
for i=1:10000
   disp(i)
   [spect_ave,baseline_ave,baseline_std]=spectogram_for_data_EEG_way(data_t(i,:),32,1:30,i);
   spect_pixel_wise(:,:,i)=spect_ave;
   baseline_ave_pixels(:,i)=baseline_ave;
   baseline_std_pixels(:,i)=baseline_std;
end;






