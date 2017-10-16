
load 1804
load power_alpha_cond4
a=zeros(112,10000,27);
a(1:112,pixels,:)=power_alpha_cond4(1:112,:,:);
clear power_alpha_cond4

load power_alpha_cond3
b=zeros(112,10000,29);
b(1:112,pixels,:)=power_alpha_cond3(1:112,:,:);
clear power_alpha_cond3

load power_alpha_cond6
c=zeros(112,10000,30);
c(1:112,pixels,:)=power_alpha_cond6(1:112,:,:);
clear power_alpha_cond6

x1=(20:10:1130)-200;


colin=squeeze(mean(a(:,roi_V1,:),2));
colin=10*log10(colin./repmat(mean(colin(2:11,:)),112,1));
nocolin=squeeze(mean(b(:,roi_V1,:),2));
nocolin=10*log10(nocolin./repmat(mean(nocolin(2:11,:)),112,1));
blank=squeeze(mean(c(:,roi_V1,:),2));
blank=10*log10(blank./repmat(mean(blank(2:11,:)),112,1));

figure;errorbar(x1,mean(colin,2),std(colin,0,2)/sqrt(27));
hold on
errorbar(x1,mean(nocolin,2),std(nocolin,0,2)/sqrt(29),'r');
errorbar(x1,mean(blank,2),std(blank,0,2)/sqrt(30),'g');
xlim([-100 300])




colin=squeeze(mean(a(:,roi_V1_2,:),2));
colin=10*log10(colin./repmat(mean(colin(2:11,:)),112,1));
nocolin=squeeze(mean(b(:,roi_V1_2,:),2));
nocolin=10*log10(nocolin./repmat(mean(nocolin(2:11,:)),112,1));
blank=squeeze(mean(c(:,roi_V1_2,:),2));
blank=10*log10(blank./repmat(mean(blank(2:11,:)),112,1));

figure;errorbar(x1,mean(colin,2),std(colin,0,2)/sqrt(27));
hold on
errorbar(x1,mean(nocolin,2),std(nocolin,0,2)/sqrt(29),'r');
errorbar(x1,mean(blank,2),std(blank,0,2)/sqrt(30),'g');
xlim([-100 300])




colin=squeeze(mean(a(:,roi_V2,:),2));
colin=10*log10(colin./repmat(mean(colin(2:11,:)),112,1));
nocolin=squeeze(mean(b(:,roi_V2,:),2));
nocolin=10*log10(nocolin./repmat(mean(nocolin(2:11,:)),112,1));
blank=squeeze(mean(c(:,roi_V2,:),2));
blank=10*log10(blank./repmat(mean(blank(2:11,:)),112,1));

figure;errorbar(x1,mean(colin,2),std(colin,0,2)/sqrt(27));
hold on
errorbar(x1,mean(nocolin,2),std(nocolin,0,2)/sqrt(29),'r');
errorbar(x1,mean(blank,2),std(blank,0,2)/sqrt(30),'g');
xlim([-100 300])





% a=10*log10(a./repmat(mean(a(2:11,:,:),1),[112 1 1]));
% a(isnan(a))=0;
% a(isinf(a))=0;
% 
% b=10*log10(b./repmat(mean(b(2:11,:,:),1),[112 1 1]));
% b(isnan(b))=0;
% b(isinf(b))=0;

% x1=(20:10:1130)-200;
% 
% figure;errorbar(x1,mean(mean(a(:,roi_V1,:),2),3),std(mean(a(:,roi_V1,:),2),0,3)/sqrt(27));
% hold on
% errorbar(x1,mean(mean(b(:,roi_V1,:),2),3),std(mean(b(:,roi_V1,:),2),0,3)/sqrt(29),'r');
% xlim([-100 300])
% 
% figure;errorbar(x1,mean(mean(a(:,roi_V1_2,:),2),3),std(mean(a(:,roi_V1_2,:),2),0,3)/sqrt(27));
% hold on
% errorbar(x1,mean(mean(b(:,roi_V1_2,:),2),3),std(mean(b(:,roi_V1_2,:),2),0,3)/sqrt(29),'r');
% xlim([-100 300])
% 
% figure;errorbar(x1,mean(mean(a(:,roi_V2,:),2),3),std(mean(a(:,roi_V2,:),2),0,3)/sqrt(27));
% hold on
% errorbar(x1,mean(mean(b(:,roi_V2,:),2),3),std(mean(b(:,roi_V2,:),2),0,3)/sqrt(29),'r');
% xlim([-100 300])
% 
% 




