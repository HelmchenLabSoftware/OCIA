

cont_circle(:,1)=mean(a(roi_circle,2:112),1);
cont_circle(:,2)=mean(b(roi_circle,2:112),1);
non_circle(:,1)=mean(c(roi_circle,2:112),1);
non_circle(:,2)=mean(d(roi_circle,2:112),1);
cont_circle(:,5)=mean(b(roi_circle,2:112),1);
non_circle(:,5)=mean(d(roi_circle,2:112),1);
cont_circle(:,7)=mean(a(roi_circle,2:112),1);
cont_circle(:,8)=mean(b(roi_circle,2:112),1);
non_circle(:,7)=mean(c(roi_circle,2:112),1);
non_circle(:,8)=mean(d(roi_circle,2:112),1);
cont_circle(:,9)=mean(a(roi_circle,2:112),1);
non_circle(:,9)=mean(c(roi_circle,2:112),1);
cont_circle(:,11)=mean(a(roi_circle,2:112),1);
cont_circle(:,12)=mean(b(roi_circle,2:112),1);
non_circle(:,11)=mean(c(roi_circle,2:112),1);
non_circle(:,12)=mean(d(roi_circle,2:112),1);
cont_circle(:,13)=mean(a(roi_circle,2:112),1);
non_circle(:,13)=mean(c(roi_circle,2:112),1);
cont_circle(:,19)=mean(b(roi_circle,2:112),1);
non_circle(:,19)=mean(d(roi_circle,2:112),1);
cont_circle(:,20)=mean(a(roi_circle,2:112),1);
non_circle(:,20)=mean(d(roi_circle,2:112),1);
cont_circle(:,21)=mean(a(roi_circle,2:112),1);
non_circle(:,21)=mean(d(roi_circle,2:112),1);
cont_circle(:,22)=mean(a(roi_circle,2:112),1);
cont_circle(:,23)=mean(b(roi_circle,2:112),1);
non_circle(:,22)=mean(c(roi_circle,2:112),1);
non_circle(:,23)=mean(d(roi_circle,2:112),1);
cont_circle(:,36)=mean(a(roi_circle,2:112),1);
cont_circle(:,37)=mean(b(roi_circle,2:112),1);
non_circle(:,36)=mean(c(roi_circle,2:112),1);
non_circle(:,37)=mean(d(roi_circle,2:112),1);

cont_bg(:,24)=mean(a(roi_bg_out,2:112),1);
cont_bg(:,25)=mean(b(roi_bg_out,2:112),1);
non_bg(:,24)=mean(c(roi_bg_out,2:112),1);
non_bg(:,25)=mean(d(roi_bg_out,2:112),1);
cont_bg(:,30)=mean(a(roi_bg_out,2:112),1);
cont_bg(:,31)=mean(b(roi_bg_out,2:112),1);
non_bg(:,30)=mean(c(roi_bg_out,2:112),1);
non_bg(:,31)=mean(d(roi_bg_out,2:112),1);
cont_bg(:,32)=mean(a(roi_bg_out,2:112),1);
cont_bg(:,33)=mean(b(roi_bg_out,2:112),1);
non_bg(:,32)=mean(c(roi_bg_out,2:112),1);
non_bg(:,33)=mean(d(roi_bg_out,2:112),1);
cont_bg(:,34)=mean(a(roi_bg_out,2:112),1);
non_bg(:,34)=mean(d(roi_bg_out,2:112),1);
cont_bg(:,35)=mean(a(roi_bg_out,2:112),1);
non_bg(:,35)=mean(d(roi_bg_out,2:112),1);



cont_circle(:,24)=mean(a(roi_circle,2:112),1);
cont_circle(:,25)=mean(b(roi_circle,2:112),1);
non_circle(:,24)=mean(c(roi_circle,2:112),1);
non_circle(:,25)=mean(d(roi_circle,2:112),1);
cont_circle(:,30)=mean(a(roi_circle,2:112),1);
cont_circle(:,31)=mean(b(roi_circle,2:112),1);
non_circle(:,30)=mean(c(roi_circle,2:112),1);
non_circle(:,31)=mean(d(roi_circle,2:112),1);
cont_circle(:,32)=mean(a(roi_circle,2:112),1);
cont_circle(:,33)=mean(b(roi_circle,2:112),1);
non_circle(:,32)=mean(c(roi_circle,2:112),1);
non_circle(:,33)=mean(d(roi_circle,2:112),1);
cont_circle(:,34)=mean(a(roi_circle,2:112),1);
non_circle(:,34)=mean(d(roi_circle,2:112),1);
cont_circle(:,35)=mean(a(roi_circle,2:112),1);
non_circle(:,35)=mean(d(roi_circle,2:112),1);






cont_bg(:,1)=mean(a(roi_bg_in,2:112),1);
cont_bg(:,2)=mean(b(roi_bg_in,2:112),1);
non_bg(:,1)=mean(c(roi_bg_in,2:112),1);
non_bg(:,2)=mean(d(roi_bg_in,2:112),1);

cont_bg(:,5)=mean(b(roi_bg_in,2:112),1);
non_bg(:,5)=mean(d(roi_bg_in,2:112),1);

cont_bg(:,7)=mean(a(roi_bg_in,2:112),1);
cont_bg(:,8)=mean(b(roi_bg_in,2:112),1);
non_bg(:,7)=mean(c(roi_bg_in,2:112),1);
non_bg(:,8)=mean(d(roi_bg_in,2:112),1);

cont_bg(:,9)=mean(a(roi_bg_in,2:112),1);
non_bg(:,9)=mean(c(roi_bg_in,2:112),1);

cont_bg(:,11)=mean(a(roi_bg_in,2:112),1);
cont_bg(:,12)=mean(b(roi_bg_in,2:112),1);
non_bg(:,11)=mean(c(roi_bg_in,2:112),1);
non_bg(:,12)=mean(d(roi_bg_in,2:112),1);

cont_bg(:,13)=mean(a(roi_bg_in,2:112),1);
non_bg(:,13)=mean(c(roi_bg_in,2:112),1);

cont_bg(:,19)=mean(b(roi_bg_in,2:112),1);
non_bg(:,19)=mean(d(roi_bg_in,2:112),1);

cont_bg(:,20)=mean(a(roi_bg_in,2:112),1);
non_bg(:,20)=mean(d(roi_bg_in,2:112),1);

cont_bg(:,21)=mean(a(roi_bg_in,2:112),1);
non_bg(:,21)=mean(d(roi_bg_in,2:112),1);

cont_bg(:,22)=mean(a(roi_bg_in,2:112),1);
cont_bg(:,23)=mean(b(roi_bg_in,2:112),1);
non_bg(:,22)=mean(c(roi_bg_in,2:112),1);
non_bg(:,23)=mean(d(roi_bg_in,2:112),1);

cont_bg(:,36)=mean(a(roi_bg_in,2:112),1);
cont_bg(:,37)=mean(b(roi_bg_in,2:112),1);
non_bg(:,36)=mean(c(roi_bg_in,2:112),1);
non_bg(:,37)=mean(d(roi_bg_in,2:112),1);





%% for legolas

cont_V2_bg(:,2)=mean(b(roi_V2,2:112),1);
non_V2_bg(:,2)=mean(d(roi_V2,2:112),1);

cont_V2_bg(:,7)=mean(b(roi_V2,2:112),1);
non_V2_bg(:,7)=mean(d(roi_V2,2:112),1);


diff_bg_out(:,2)=mean(b(roi_maskout,2:112),1)-mean(d(roi_maskout,2:112),1);
diff_bg_out(:,7)=mean(b(roi_maskout,2:112),1)-mean(d(roi_maskout,2:112),1);


