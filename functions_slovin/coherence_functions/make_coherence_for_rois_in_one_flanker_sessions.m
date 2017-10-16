





coher_colin_V1_0702=a(roi_V1,:,:);
coher_nocolin_V1_0702=b(roi_V1,:,:);

coher_colin_V1_2_0702=a(roi_V1_2,:,:);
coher_nocolin_V1_2_0702=b(roi_V1_2,:,:);

coher_colin_V2_0702=a(roi_V2,:,:);
coher_nocolin_V2_0702=b(roi_V2,:,:);


coher_colin_V1_3101=a(roi_V1,:,:);
coher_nocolin_V1_3101=b(roi_V1,:,:);

coher_colin_V1_2_3101=a(roi_V1_2,:,:);
coher_nocolin_V1_2_3101=b(roi_V1_2,:,:);

coher_colin_V2_3101=a(roi_V2,:,:);
coher_nocolin_V2_3101=b(roi_V2,:,:);



coher_colin_V1_2011=a(roi_V1,:,:);
coher_nocolin_V1_2011=b(roi_V1,:,:);

coher_colin_V1_2_2011=a(roi_V1_2,:,:);
coher_nocolin_V1_2_2011=b(roi_V1_2,:,:);

coher_colin_V2_2011=a(roi_V2,:,:);
coher_nocolin_V2_2011=b(roi_V2,:,:);



coher_colin_V1=cat(1,coher_colin_V1_0702,coher_colin_V1_3101,coher_colin_V1_2011);
coher_colin_V1_2=cat(1,coher_colin_V1_2_0702,coher_colin_V1_2_3101,coher_colin_V1_2_2011);
coher_colin_V2=cat(1,coher_colin_V2_0702,coher_colin_V2_3101,coher_colin_V2_2011);

coher_nocolin_V1=cat(1,coher_nocolin_V1_0702,coher_nocolin_V1_3101,coher_nocolin_V1_2011);
coher_nocolin_V1_2=cat(1,coher_nocolin_V1_2_0702,coher_nocolin_V1_2_3101,coher_nocolin_V1_2_2011);
coher_nocolin_V2=cat(1,coher_nocolin_V2_0702,coher_nocolin_V2_3101,coher_nocolin_V2_2011);




coher_colin_V1=cat(3,coher_colin,shiftdim(coher_colin_V1,1));
coher_nocolin_V1=cat(3,coher_nocolin,shiftdim(coher_nocolin_V1,1));


coher_colin_V1_2=cat(3,coher_colin,shiftdim(coher_colin_V1_2,1));
coher_nocolin_V1_2=cat(3,coher_nocolin,shiftdim(coher_nocolin_V1_2,1));


coher_colin_V2=cat(3,coher_colin,shiftdim(coher_colin_V2,1));
coher_nocolin_V2=cat(3,coher_nocolin,shiftdim(coher_nocolin_V2,1));










