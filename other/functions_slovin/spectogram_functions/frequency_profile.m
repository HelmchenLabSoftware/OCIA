%% plot frequency profiles
x=1:125/64:125;
plot(x,mean(mean(spect_pixel_wise_cond1_time_1_239(:,55:62,roi_V1),3),2))
hold on;
plot(x,mean(mean(spect_pixel_wise_cond1_time_1_239(:,230:241,roi_V1),3),2),'r')
plot(x,mean(mean(spect_pixel_wise_cond1_time_1_239(:,404:419,roi_V1),3),2),'g')
title('frequency profile for V1')
legend('first stim','second stim','third stim')

figure;
plot(x,mean(mean(spect_pixel_wise_cond1_time_1_239(:,55:62,roi_V2),3),2))
hold on;
plot(x,mean(mean(spect_pixel_wise_cond1_time_1_239(:,230:241,roi_V2),3),2),'r')
plot(x,mean(mean(spect_pixel_wise_cond1_time_1_239(:,404:419,roi_V2),3),2),'g')
title('frequency profile for V2')
legend('first stim','second stim','third stim')

figure;
plot(x,mean(mean(spect_pixel_wise_cond1_time_1_239(:,55:62,roi_V4),3),2))
hold on;
plot(x,mean(mean(spect_pixel_wise_cond1_time_1_239(:,230:241,roi_V4),3),2),'r')
plot(x,mean(mean(spect_pixel_wise_cond1_time_1_239(:,404:419,roi_V4),3),2),'g')
title('frequency profile for V4')
legend('first stim','second stim','third stim')

%% plot frequencies for same stimulus but different roi

figure;
x=1:125/64:125;
plot(x,mean(mean(spect_pixel_wise_cond1_time_1_239(:,55:62,roi_V1),3),2))
hold on;
plot(x,mean(mean(spect_pixel_wise_cond1_time_1_239(:,55:62,roi_V2),3),2),'r')
plot(x,mean(mean(spect_pixel_wise_cond1_time_1_239(:,55:62,roi_V4),3),2),'g')
title('frequency profile first stim')
legend('V1','V2','V4')


figure;
plot(x,mean(mean(spect_pixel_wise_cond1_time_1_239(:,230:241,roi_V1),3),2))
hold on;
plot(x,mean(mean(spect_pixel_wise_cond1_time_1_239(:,230:241,roi_V2),3),2),'r')
plot(x,mean(mean(spect_pixel_wise_cond1_time_1_239(:,230:241,roi_V4),3),2),'g')
title('frequency profile second stim')
legend('V1','V2','V4')


figure;
plot(x,mean(mean(spect_pixel_wise_cond1_time_1_239(:,404:419,roi_V1),3),2))
hold on;
plot(x,mean(mean(spect_pixel_wise_cond1_time_1_239(:,404:419,roi_V2),3),2),'r')
plot(x,mean(mean(spect_pixel_wise_cond1_time_1_239(:,404:419,roi_V4),3),2),'g')
title('frequency profile third stim')
legend('V1','V2','V4')


