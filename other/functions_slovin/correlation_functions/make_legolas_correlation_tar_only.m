

%% 1111

%c
c1_1111c_tar_tar=squeeze(mean(a(roi_tar,:,:),1));
c2_1111c_tar_tar=squeeze(mean(b(roi_tar,:,:),1));
c4_1111c_tar_tar=squeeze(mean(c(roi_tar,:,:),1));
c5_1111c_tar_tar=squeeze(mean(d(roi_tar,:,:),1));

%d 
c1_1111d_tar_tar=squeeze(mean(a(roi_tar,:,:),1));
c2_1111d_tar_tar=squeeze(mean(b(roi_tar,:,:),1));
c4_1111d_tar_tar=squeeze(mean(c(roi_tar,:,:),1));
c5_1111d_tar_tar=squeeze(mean(d(roi_tar,:,:),1));

%h 
c1_1111h_tar_tar=squeeze(mean(a(roi_tar,:,:),1));
c2_1111h_tar_tar=squeeze(mean(b(roi_tar,:,:),1));
c4_1111h_tar_tar=squeeze(mean(c(roi_tar,:,:),1));
c5_1111h_tar_tar=squeeze(mean(d(roi_tar,:,:),1));

%% 2511

%d
c1_2511d_tar_tar=squeeze(mean(a(roi_tar,:,:),1));
c5_2511d_tar_tar=squeeze(mean(b(roi_tar,:,:),1));

%e
c1_2511e_tar_tar=squeeze(mean(a(roi_tar,:,:),1));
c5_2511e_tar_tar=squeeze(mean(b(roi_tar,:,:),1));

%f
c1_2511f_tar_tar=squeeze(mean(a(roi_tar,:,:),1));
c5_2511f_tar_tar=squeeze(mean(b(roi_tar,:,:),1));


%% 1811

%c
c1_1811c_tar_tar=squeeze(mean(a(roi_tar,:,:),1));
c5_1811c_tar_tar=squeeze(mean(b(roi_tar,:,:),1));

%d
c1_1811d_tar_tar=squeeze(mean(a(roi_tar,:,:),1));
c5_1811d_tar_tar=squeeze(mean(b(roi_tar,:,:),1));

%e
c1_1811e_tar_tar=squeeze(mean(a(roi_tar,:,:),1));
c5_1811e_tar_tar=squeeze(mean(b(roi_tar,:,:),1));


%% 1203

%d
c1_1203d_tar_tar=squeeze(mean(a(roi_tar,:,:),1));
c5_1203d_tar_tar=squeeze(mean(b(roi_tar,:,:),1));

%e
c1_1203e_tar_tar=squeeze(mean(a(roi_tar,:,:),1));
c5_1203e_tar_tar=squeeze(mean(b(roi_tar,:,:),1));

%f
c1_1203f_tar_tar=squeeze(mean(a(roi_tar,:,:),1));
c5_1203f_tar_tar=squeeze(mean(b(roi_tar,:,:),1));



%% 0610

%e
c1_0610e_tar_tar=squeeze(mean(a(roi_tar,:,:),1));
c2_0610e_tar_tar=squeeze(mean(b(roi_tar,:,:),1));
c4_0610e_tar_tar=squeeze(mean(c(roi_tar,:,:),1));
c5_0610e_tar_tar=squeeze(mean(d(roi_tar,:,:),1));

%f
c1_0610f_tar_tar=squeeze(mean(a(roi_tar,:,:),1));
c2_0610f_tar_tar=squeeze(mean(b(roi_tar,:,:),1));
c4_0610f_tar_tar=squeeze(mean(c(roi_tar,:,:),1));
c5_0610f_tar_tar=squeeze(mean(d(roi_tar,:,:),1));


%% 2210

%d
c1_2210d_tar_tar=squeeze(mean(a(roi_tar,:,:),1));
c2_2210d_tar_tar=squeeze(mean(b(roi_tar,:,:),1));
c4_2210d_tar_tar=squeeze(mean(c(roi_tar,:,:),1));
c5_2210d_tar_tar=squeeze(mean(d(roi_tar,:,:),1));

%e
c1_2210e_tar_tar=squeeze(mean(a(roi_tar,:,:),1));
c2_2210e_tar_tar=squeeze(mean(b(roi_tar,:,:),1));
c4_2210e_tar_tar=squeeze(mean(c(roi_tar,:,:),1));
c5_2210e_tar_tar=squeeze(mean(d(roi_tar,:,:),1));


%%

cont_tar_tar(:,1)=mean(c1_1111c_tar_tar,2);
cont_tar_tar(:,2)=mean(c2_1111c_tar_tar,2);
cont_tar_tar(:,3)=mean(c1_1111d_tar_tar,2);
cont_tar_tar(:,4)=mean(c2_1111d_tar_tar,2);
cont_tar_tar(:,5)=mean(c1_1811c_tar_tar,2);
cont_tar_tar(:,6)=mean(c1_1811d_tar_tar,2);
cont_tar_tar(:,7)=mean(c1_1811e_tar_tar,2);
cont_tar_tar(:,8)=mean(c1_2511d_tar_tar,2);
cont_tar_tar(:,9)=mean(c1_2511e_tar_tar,2);
cont_tar_tar(:,10)=mean(c1_2511f_tar_tar,2);
cont_tar_tar(:,11)=mean(c1_1203d_tar_tar,2);
cont_tar_tar(:,12)=mean(c1_1203e_tar_tar,2);
cont_tar_tar(:,13)=mean(c1_1203f_tar_tar,2);
cont_tar_tar(:,14)=mean(c1_1111h_tar_tar,2);
cont_tar_tar(:,15)=mean(c2_1111h_tar_tar,2);
cont_tar_tar(:,16)=mean(c1_0610e_tar_tar,2);
cont_tar_tar(:,17)=mean(c2_0610e_tar_tar,2);
cont_tar_tar(:,18)=mean(c1_0610f_tar_tar,2);
cont_tar_tar(:,19)=mean(c2_0610f_tar_tar,2);
cont_tar_tar(:,20)=mean(c1_2210d_tar_tar,2);
cont_tar_tar(:,21)=mean(c2_2210d_tar_tar,2);
cont_tar_tar(:,22)=mean(c1_2210e_tar_tar,2);
cont_tar_tar(:,23)=mean(c2_2210e_tar_tar,2);

non_tar_tar(:,1)=mean(c4_1111c_tar_tar,2);
non_tar_tar(:,2)=mean(c5_1111c_tar_tar,2);
non_tar_tar(:,3)=mean(c4_1111d_tar_tar,2);
non_tar_tar(:,4)=mean(c5_1111d_tar_tar,2);
non_tar_tar(:,5)=mean(c5_1811c_tar_tar,2);
non_tar_tar(:,6)=mean(c5_1811d_tar_tar,2);
non_tar_tar(:,7)=mean(c5_1811e_tar_tar,2);
non_tar_tar(:,8)=mean(c5_2511d_tar_tar,2);
non_tar_tar(:,9)=mean(c5_2511e_tar_tar,2);
non_tar_tar(:,10)=mean(c5_2511f_tar_tar,2);
non_tar_tar(:,11)=mean(c5_1203d_tar_tar,2);
non_tar_tar(:,12)=mean(c5_1203e_tar_tar,2);
non_tar_tar(:,13)=mean(c5_1203f_tar_tar,2);
non_tar_tar(:,14)=mean(c4_1111h_tar_tar,2);
non_tar_tar(:,15)=mean(c5_1111h_tar_tar,2);
non_tar_tar(:,16)=mean(c4_0610e_tar_tar,2);
non_tar_tar(:,17)=mean(c5_0610e_tar_tar,2);
non_tar_tar(:,18)=mean(c4_0610f_tar_tar,2);
non_tar_tar(:,19)=mean(c5_0610f_tar_tar,2);
non_tar_tar(:,20)=mean(c4_2210d_tar_tar,2);
non_tar_tar(:,21)=mean(c5_2210d_tar_tar,2);
non_tar_tar(:,22)=mean(c4_2210e_tar_tar,2);
non_tar_tar(:,23)=mean(c5_2210e_tar_tar,2);

