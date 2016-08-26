
coher_V1_V2tar_colin_1804=a(roi_V2_target,:,:);
coher_V1_V2tar_nocolin_1804=b(roi_V2_target,:,:);
coher_V1_V2tar_blank_1804=c(roi_V2_target,:,:);

coher_V1_V2flan_colin_1804=a(roi_V2_flanker,:,:);
coher_V1_V2flan_nocolin_1804=b(roi_V2_flanker,:,:);
coher_V1_V2flan_blank_1804=c(roi_V2_flanker,:,:);


%
coher_V1_V2tar_colin_1203=a(roi_V2_target,:,:);
coher_V1_V2tar_nocolin_1203=b(roi_V2_target,:,:);
coher_V1_V2tar_blank_1203=c(roi_V2_target,:,:);

coher_V1_V2flan_colin_1203=a(roi_V2_flanker,:,:);
coher_V1_V2flan_nocolin_1203=b(roi_V2_flanker,:,:);
coher_V1_V2flan_blank_1203=c(roi_V2_flanker,:,:);


%
coher_V1_V2tar_colin_1005b=a(roi_V2_target,:,:);
coher_V1_V2tar_nocolin_1005b=b(roi_V2_target,:,:);
coher_V1_V2tar_blank_1005b=c(roi_V2_target,:,:);

coher_V1_V2flan_colin_1005b=a(roi_V2_flanker,:,:);
coher_V1_V2flan_nocolin_1005b=b(roi_V2_flanker,:,:);
coher_V1_V2flan_blank_1005b=c(roi_V2_flanker,:,:);


%
coher_V1_V2tar_colin_1005e=a(roi_V2_target,:,:);
coher_V1_V2tar_nocolin_1005e=b(roi_V2_target,:,:);
coher_V1_V2tar_blank_1005e=c(roi_V2_target,:,:);

coher_V1_V2flan_colin_1005e=a(roi_V2_flanker,:,:);
coher_V1_V2flan_nocolin_1005e=b(roi_V2_flanker,:,:);
coher_V1_V2flan_blank_1005e=c(roi_V2_flanker,:,:);



%
coher_V1_V2tar_colin_2011p=a(roi_V2_target,:,:);
coher_V1_V2tar_nocolin_2011p=b(roi_V2_target,:,:);
coher_V1_V2tar_blank_2011p=c(roi_V2_target,:,:);

coher_V1_V2flan_colin_2011p=a(roi_V2_flanker,:,:);
coher_V1_V2flan_nocolin_2011p=b(roi_V2_flanker,:,:);
coher_V1_V2flan_blank_2011p=c(roi_V2_flanker,:,:);




%
coher_V1_V2tar_colin_3101=a(roi_V2_target,:,:);
coher_V1_V2tar_nocolin_3101=b(roi_V2_target,:,:);

coher_V1_V2flan_colin_3101=a(roi_V2_flanker,:,:);
coher_V1_V2flan_nocolin_3101=b(roi_V2_flanker,:,:);



%
coher_V1_V2tar_colin_0702=a(roi_V2_target,:,:);
coher_V1_V2tar_nocolin_0702=b(roi_V2_target,:,:);

coher_V1_V2flan_colin_0702=a(roi_V2_flanker,:,:);
coher_V1_V2flan_nocolin_0702=b(roi_V2_flanker,:,:);


%
coher_V1_V2tar_colin_2011c=a(roi_V2_target,:,:);
coher_V1_V2tar_nocolin_2011c=b(roi_V2_target,:,:);

coher_V1_V2flan_colin_2011c=a(roi_V2_flanker,:,:);
coher_V1_V2flan_nocolin_2011c=b(roi_V2_flanker,:,:);




coher_V1_V2tar_colin=coher_V1_V2tar_colin_1804;
coher_V1_V2tar_colin=cat(1,coher_V1_V2tar_colin,coher_V1_V2tar_colin_1203);
coher_V1_V2tar_colin=cat(1,coher_V1_V2tar_colin,coher_V1_V2tar_colin_1005b);
coher_V1_V2tar_colin=cat(1,coher_V1_V2tar_colin,coher_V1_V2tar_colin_1005e);
coher_V1_V2tar_colin=cat(1,coher_V1_V2tar_colin,coher_V1_V2tar_colin_2011p);
coher_V1_V2tar_colin=cat(1,coher_V1_V2tar_colin,coher_V1_V2tar_colin_3101);
coher_V1_V2tar_colin=cat(1,coher_V1_V2tar_colin,coher_V1_V2tar_colin_0702);
coher_V1_V2tar_colin=cat(1,coher_V1_V2tar_colin,coher_V1_V2tar_colin_2011c);


coher_V1_V2tar_nocolin=coher_V1_V2tar_nocolin_1804;
coher_V1_V2tar_nocolin=cat(1,coher_V1_V2tar_nocolin,coher_V1_V2tar_nocolin_1203);
coher_V1_V2tar_nocolin=cat(1,coher_V1_V2tar_nocolin,coher_V1_V2tar_nocolin_1005b);
coher_V1_V2tar_nocolin=cat(1,coher_V1_V2tar_nocolin,coher_V1_V2tar_nocolin_1005e);
coher_V1_V2tar_nocolin=cat(1,coher_V1_V2tar_nocolin,coher_V1_V2tar_nocolin_2011p);
coher_V1_V2tar_nocolin=cat(1,coher_V1_V2tar_nocolin,coher_V1_V2tar_nocolin_3101);
coher_V1_V2tar_nocolin=cat(1,coher_V1_V2tar_nocolin,coher_V1_V2tar_nocolin_0702);
coher_V1_V2tar_nocolin=cat(1,coher_V1_V2tar_nocolin,coher_V1_V2tar_nocolin_2011c);


coher_V1_V2tar_blank=coher_V1_V2tar_blank_1804;
coher_V1_V2tar_blank=cat(1,coher_V1_V2tar_blank,coher_V1_V2tar_blank_1203);
coher_V1_V2tar_blank=cat(1,coher_V1_V2tar_blank,coher_V1_V2tar_blank_1005b);
coher_V1_V2tar_blank=cat(1,coher_V1_V2tar_blank,coher_V1_V2tar_blank_1005e);
coher_V1_V2tar_blank=cat(1,coher_V1_V2tar_blank,coher_V1_V2tar_blank_2011p);




coher_V1_V2flan_colin=coher_V1_V2flan_colin_1804;
coher_V1_V2flan_colin=cat(1,coher_V1_V2flan_colin,coher_V1_V2flan_colin_1203);
coher_V1_V2flan_colin=cat(1,coher_V1_V2flan_colin,coher_V1_V2flan_colin_1005b);
coher_V1_V2flan_colin=cat(1,coher_V1_V2flan_colin,coher_V1_V2flan_colin_1005e);
coher_V1_V2flan_colin=cat(1,coher_V1_V2flan_colin,coher_V1_V2flan_colin_2011p);
coher_V1_V2flan_colin=cat(1,coher_V1_V2flan_colin,coher_V1_V2flan_colin_3101);
coher_V1_V2flan_colin=cat(1,coher_V1_V2flan_colin,coher_V1_V2flan_colin_0702);
coher_V1_V2flan_colin=cat(1,coher_V1_V2flan_colin,coher_V1_V2flan_colin_2011c);


coher_V1_V2flan_nocolin=coher_V1_V2flan_nocolin_1804;
coher_V1_V2flan_nocolin=cat(1,coher_V1_V2flan_nocolin,coher_V1_V2flan_nocolin_1203);
coher_V1_V2flan_nocolin=cat(1,coher_V1_V2flan_nocolin,coher_V1_V2flan_nocolin_1005b);
coher_V1_V2flan_nocolin=cat(1,coher_V1_V2flan_nocolin,coher_V1_V2flan_nocolin_1005e);
coher_V1_V2flan_nocolin=cat(1,coher_V1_V2flan_nocolin,coher_V1_V2flan_nocolin_2011p);
coher_V1_V2flan_nocolin=cat(1,coher_V1_V2flan_nocolin,coher_V1_V2flan_nocolin_3101);
coher_V1_V2flan_nocolin=cat(1,coher_V1_V2flan_nocolin,coher_V1_V2flan_nocolin_0702);
coher_V1_V2flan_nocolin=cat(1,coher_V1_V2flan_nocolin,coher_V1_V2flan_nocolin_2011c);


coher_V1_V2flan_blank=coher_V1_V2flan_blank_1804;
coher_V1_V2flan_blank=cat(1,coher_V1_V2flan_blank,coher_V1_V2flan_blank_1203);
coher_V1_V2flan_blank=cat(1,coher_V1_V2flan_blank,coher_V1_V2flan_blank_1005b);
coher_V1_V2flan_blank=cat(1,coher_V1_V2flan_blank,coher_V1_V2flan_blank_1005e);
coher_V1_V2flan_blank=cat(1,coher_V1_V2flan_blank,coher_V1_V2flan_blank_2011p);


coher_V1_V2tar_colin=shiftdim(coher_V1_V2tar_colin,1);
coher_V1_V2tar_nocolin=shiftdim(coher_V1_V2tar_nocolin,1);
coher_V1_V2tar_blank=shiftdim(coher_V1_V2tar_blank,1);
coher_V1_V2flan_colin=shiftdim(coher_V1_V2flan_colin,1);
coher_V1_V2flan_nocolin=shiftdim(coher_V1_V2flan_nocolin,1);
coher_V1_V2flan_blank=shiftdim(coher_V1_V2flan_blank,1);





