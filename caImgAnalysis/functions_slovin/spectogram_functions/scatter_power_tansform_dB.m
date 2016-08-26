%scatter power and dB


a=10*log10(a./repmat(mean(a(:,:,2:15),3),[1 1 112]));
a(isnan(a))=0;
a(isinf(a))=0;

b=10*log10(b./repmat(mean(b(:,:,2:15),3),[1 1 112]));
b(isnan(b))=0;
b(isinf(b))=0;


a1804=squeeze(mean(mean(a(roi_V1,4:9,20:30),2),3));
b1804=squeeze(mean(mean(b(roi_V1,4:9,20:30),2),3));
a1203=squeeze(mean(mean(a(roi_V1,4:9,20:30),2),3));
b1203=squeeze(mean(mean(b(roi_V1,4:9,20:30),2),3));
a1005b=squeeze(mean(mean(a(roi_V1,4:9,20:30),2),3));
b1005b=squeeze(mean(mean(b(roi_V1,4:9,20:30),2),3));
a1005e=squeeze(mean(mean(a(roi_V1,4:9,20:30),2),3));
b1005e=squeeze(mean(mean(b(roi_V1,4:9,20:30),2),3));
a2011=squeeze(mean(mean(a(roi_V1,4:9,20:30),2),3));
b2011=squeeze(mean(mean(b(roi_V1,4:9,20:30),2),3));




aall=[a1804 ; a1203 ; a1005b ; a1005e ; a2011];
ball=[b1804 ; b1203 ; b1005b ; b1005e ; b2011];

figure
scatter(b1804,a1804)
hold on
xlim([-4 8]);xlim([-4 8])
plot(-9:0.001:9,-9:0.001:9,'k')
ranksum(b1804,a1804)


figure
scatter(b1203,a1203)
hold on
xlim([-4 8]);xlim([-4 8])
plot(-9:0.001:9,-9:0.001:9,'k')
ranksum(b1203,a1203)

figure
scatter(b1005b,a1005b)
hold on
xlim([-4 8]);xlim([-4 8])
plot(-9:0.001:9,-9:0.001:9,'k')
ranksum(b1005b,a1005b)

figure
scatter(b1005e,a1005e)
hold on
xlim([-4 8]);xlim([-4 8])
plot(-9:0.001:9,-9:0.001:9,'k')
ranksum(b1005e,a1005e)

figure
scatter(b2011,a2011)
hold on
xlim([-4 8]);xlim([-4 8])
plot(-9:0.001:9,-9:0.001:9,'k')
ranksum(b2011,a2011)


ranksum(ball,aall)




%% one flanker



a3101=squeeze(mean(mean(a(roi_V2,4:9,20:30),2),3));
b3101=squeeze(mean(mean(b(roi_V2,4:9,20:30),2),3));
a0702=squeeze(mean(mean(a(roi_V1_2,4:9,20:30),2),3));
b0702=squeeze(mean(mean(b(roi_V1_2,4:9,20:30),2),3));
a2011=squeeze(mean(mean(a(roi_V2,4:9,20:30),2),3));
b2011=squeeze(mean(mean(b(roi_V2,4:9,20:30),2),3));


figure
scatter(b3101,a3101)
hold on
xlim([-4 8]);xlim([-4 8])
plot(-9:0.001:9,-9:0.001:9,'k')
ranksum(b3101,a3101)

figure
scatter(b0702,a0702)
hold on
xlim([-4 8]);xlim([-4 8])
plot(-9:0.001:9,-9:0.001:9,'k')
ranksum(b0702,a0702)


figure
scatter(b2011,a2011)
hold on
xlim([-.2 .2]);xlim([-.2 .2])
plot(-9:0.001:9,-9:0.001:9,'k')
ranksum(b2011,a2011)








