%% three flankers: take only the beta power for each trial



%cond4
load power_beta_cond4
a=zeros(112,10000,size(power_beta_cond4,3));
a(:,pixels,:)=power_beta_cond4(1:112,:,:);
clear power_beta_cond4

a=10*log10(a./repmat(mean(a(2:11,:,:),1),[112 1 1]));
a(isnan(a))=0;
a(isinf(a))=0;


%cond3
load power_beta_cond3
b=zeros(112,10000,size(power_beta_cond3,3));
b(:,pixels,:)=power_beta_cond3(1:112,:,:);
clear power_beta_cond3

b=10*log10(b./repmat(mean(b(2:11,:,:),1),[112 1 1]));
b(isnan(b))=0;
b(isinf(b))=0;




% %cond6
% load power_beta_cond6
% c=zeros(112,10000,size(power_beta_cond6,3));
% c(:,pixels,:)=power_beta_cond6(1:112,:,:);
% clear power_beta_cond6
% 
% c=10*log10(c./repmat(mean(c(2:11,:,:),1),[112 1 1]));
% c(isnan(c))=0;
% c(isinf(c))=0;


%% one flanker

%cond2
load power_beta_cond2
a=zeros(112,10000,size(power_beta_cond2,3));
a(:,pixels,:)=power_beta_cond2(1:112,:,:);
clear power_beta_cond2

a=10*log10(a./repmat(mean(a(2:11,:,:),1),[112 1 1]));
a(isnan(a))=0;
a(isinf(a))=0;


%cond4
load power_beta_cond4
b=zeros(112,10000,size(power_beta_cond4,3));
b(:,pixels,:)=power_beta_cond4(1:112,:,:);
clear power_beta_cond4

b=10*log10(b./repmat(mean(b(2:11,:,:),1),[112 1 1]));
b(isnan(b))=0;
b(isinf(b))=0;




%%

colin_V1=squeeze(mean(a(2:60,roi_V1,:),2));
colin_V1=10*log10(colin_V1./repmat(mean(colin_V1(1:11,:)),[59 1]));

colin_V1_2=squeeze(mean(a(2:60,roi_V1_2,:),2));
colin_V1_2=10*log10(colin_V1_2./repmat(mean(colin_V1_2(1:11,:)),[59 1]));

colin_V2t=squeeze(mean(a(2:60,roi_V2_target,:),2));
colin_V2t=10*log10(colin_V2t./repmat(mean(colin_V2t(1:11,:)),[59 1]));

colin_V2f=squeeze(mean(a(2:60,roi_V2_flanker,:),2));
colin_V2f=10*log10(colin_V2f./repmat(mean(colin_V2f(1:11,:)),[59 1]));


non_V1=squeeze(mean(b(2:60,roi_V1,:),2));
non_V1=10*log10(non_V1./repmat(mean(non_V1(1:11,:)),[59 1]));

non_V1_2=squeeze(mean(b(2:60,roi_V1_2,:),2));
non_V1_2=10*log10(non_V1_2./repmat(mean(non_V1_2(1:11,:)),[59 1]));

non_V2t=squeeze(mean(b(2:60,roi_V2_target,:),2));
non_V2t=10*log10(non_V2t./repmat(mean(non_V2t(1:11,:)),[59 1]));

non_V2f=squeeze(mean(b(2:60,roi_V2_flanker,:),2));
non_V2f=10*log10(non_V2f./repmat(mean(non_V2f(1:11,:)),[59 1]));




bl_V1=squeeze(mean(c(2:60,roi_V1,:),2));
bl_V1=10*log10(bl_V1./repmat(mean(bl_V1(1:11,:)),[59 1]));

bl_V1_2=squeeze(mean(c(2:60,roi_V1_2,:),2));
bl_V1_2=10*log10(bl_V1_2./repmat(mean(bl_V1_2(1:11,:)),[59 1]));

bl_V2t=squeeze(mean(c(2:60,roi_V2_target,:),2));
bl_V2t=10*log10(bl_V2t./repmat(mean(bl_V2t(1:11,:)),[59 1]));

bl_V2f=squeeze(mean(c(2:60,roi_V2_flanker,:),2));
bl_V2f=10*log10(bl_V2f./repmat(mean(bl_V2f(1:11,:)),[59 1]));





