
%ref V1
col_coher_alpha_v1_v1=mean(mean(a(roi_V1,4:9,20:30),2),3);
col_coher_alpha_v1_v2=mean(mean(a(roi_V2,4:9,20:30),2),3);
ort_coher_alpha_v1_v1=mean(mean(b(roi_V1,4:9,20:30),2),3);
ort_coher_alpha_v1_v2=mean(mean(b(roi_V2,4:9,20:30),2),3);

%ref V2
col_coher_alpha_v2_v2=mean(mean(a(roi_V2,4:9,20:30),2),3);
col_coher_alpha_v2_v1=mean(mean(a(roi_V1,4:9,20:30),2),3);
ort_coher_alpha_v2_v2=mean(mean(b(roi_V2,4:9,20:30),2),3);
ort_coher_alpha_v2_v1=mean(mean(b(roi_V1,4:9,20:30),2),3);



figure;scatter(col_coher_alpha_v1_v2,col_coher_alpha_v2_v2)
xlim([0 0.5])
ylim([0 0.5])
hold on
plot(0:0.01:1,0:0.01:1,'k')


figure;scatter(ort_coher_alpha_v1_v2,ort_coher_alpha_v2_v2)
xlim([0 0.5])
ylim([0 0.5])
hold on
plot(0:0.01:1,0:0.01:1,'k')



figure;scatter(ort_coher_alpha_v2_v2,col_coher_alpha_v2_v2)
xlim([0 0.6])
ylim([0 0.6])
hold on
plot(0:0.01:1,0:0.01:1,'k')

figure;scatter(ort_coher_alpha_v1_v2,col_coher_alpha_v1_v2)
xlim([0 0.6])
ylim([0 0.6])
hold on
plot(0:0.01:1,0:0.01:1,'k')

figure;scatter(ort_coher_alpha_v1_v1,col_coher_alpha_v1_v1)
xlim([0 0.6])
ylim([0 0.6])
hold on
plot(0:0.01:1,0:0.01:1,'k')


diff_v2_v2=col_coher_alpha_v2_v2-ort_coher_alpha_v2_v2;
diff_v1_v1=col_coher_alpha_v1_v1-ort_coher_alpha_v1_v1;
diff_v1_v2=col_coher_alpha_v1_v2-ort_coher_alpha_v1_v2;
diff_v2_v1=col_coher_alpha_v2_v1-ort_coher_alpha_v2_v1;


figure;scatter(diff_v2_v2,diff_v1_v2)
xlim([-.05 0.35])
ylim([-.05 0.35])
hold on
plot(-1:0.01:1,-1:0.01:1,'k')


figure;scatter(diff_v1_v1,diff_v2_v1)
xlim([-.05 0.35])
ylim([-.05 0.35])
hold on
plot(-1:0.01:1,-1:0.01:1,'k')






















