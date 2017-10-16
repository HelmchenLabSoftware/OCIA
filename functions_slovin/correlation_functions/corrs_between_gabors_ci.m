


time=30:33;

diff_tar_tar=mean(mean(tar_cont(roi_tar,time)))-mean(mean(tar_non(roi_tar,time)));
diff_tar_f1=mean(mean(tar_cont(roi_f1late,time)))-mean(mean(tar_non(roi_f1late,time)));
diff_tar_f2=mean(mean(tar_cont(roi_f2,time)))-mean(mean(tar_non(roi_f2,time)));
diff_tar_f3=mean(mean(tar_cont(roi_f3,time)))-mean(mean(tar_non(roi_f3,time)));
diff_tar_f4=mean(mean(tar_cont(roi_f4,time)))-mean(mean(tar_non(roi_f4,time)));
diff_tar_f5=mean(mean(tar_cont(roi_f5,time)))-mean(mean(tar_non(roi_f5,time)));

diff_f1_f1=mean(mean(f1_cont(roi_f1late,time)))-mean(mean(f1_non(roi_f1late,time)));
diff_f1_f2=mean(mean(f1_cont(roi_f2,time)))-mean(mean(f1_non(roi_f2,time)));
diff_f1_f3=mean(mean(f1_cont(roi_f3,time)))-mean(mean(f1_non(roi_f3,time)));
diff_f1_f4=mean(mean(f1_cont(roi_f4,time)))-mean(mean(f1_non(roi_f4,time)));
diff_f2_f5=mean(mean(f1_cont(roi_f5,time)))-mean(mean(f1_non(roi_f5,time)));

diff_f2_f2=mean(mean(f2_cont(roi_f2,time)))-mean(mean(f2_non(roi_f2,time)));
diff_f2_f3=mean(mean(f2_cont(roi_f3,time)))-mean(mean(f2_non(roi_f3,time)));
diff_f2_f4=mean(mean(f2_cont(roi_f4,time)))-mean(mean(f2_non(roi_f4,time)));
diff_f2_f5=mean(mean(f2_cont(roi_f5,time)))-mean(mean(f2_non(roi_f5,time)));

diff_f3_f3=mean(mean(f3_cont(roi_f3,time)))-mean(mean(f3_non(roi_f3,time)));
diff_f3_f4=mean(mean(f3_cont(roi_f4,time)))-mean(mean(f3_non(roi_f4,time)));
diff_f3_f5=mean(mean(f3_cont(roi_f5,time)))-mean(mean(f3_non(roi_f5,time)));

diff_f4_f4=mean(mean(f4_cont(roi_f4,time)))-mean(mean(f4_non(roi_f4,time)));
diff_f4_f5=mean(mean(f4_cont(roi_f5,time)))-mean(mean(f4_non(roi_f5,time)));

diff_f5_f5=mean(mean(f4_cont(roi_f5,time)))-mean(mean(f5_non(roi_f5,time)));


corr_mat=zeros(6,6);
corr_mat(1,1)=diff_tar_tar;
corr_mat(1,2)=diff_tar_f1;
corr_mat(1,3)=diff_tar_f2;
corr_mat(1,4)=diff_tar_f3;
corr_mat(1,5)=diff_tar_f4;
corr_mat(1,6)=diff_tar_f5;
corr_mat(2,2)=diff_f1_f1;
corr_mat(2,3)=diff_f1_f2;
corr_mat(2,4)=diff_f1_f3;
corr_mat(2,5)=diff_f1_f4;
corr_mat(2,6)=diff_f1_f5;
corr_mat(3,3)=diff_f2_f2;
corr_mat(3,4)=diff_f2_f3;
corr_mat(3,5)=diff_f2_f4;
corr_mat(3,6)=diff_f2_f5;
corr_mat(4,4)=diff_f3_f3;
corr_mat(4,5)=diff_f3_f4;
corr_mat(4,6)=diff_f3_f5;
corr_mat(5,5)=diff_f4_f4;
corr_mat(5,6)=diff_f4_f5;
corr_mat(6,6)=diff_f5_f5;



figure;imagesc(corr_mat,[-0.04 0.04]);colormap(mapgeog)
axis square

local=[diff_tar_tar diff_f1_f1 diff_f2_f2 diff_tar_f1 diff_tar_f2 diff_f1_f2];
local2=[diff_f3_f3 diff_f4_f4 diff_f5_f5 diff_f3_f4 diff_f3_f5 diff_f4_f5];
bet=[diff_tar_f3 diff_tar_f4 diff_tar_f5 diff_f1_f3 diff_f1_f4 diff_f1_f5 diff_f2_f3 diff_f2_f4 diff_f2_f5];

figure;bar([mean(local) mean(local2) mean(bet)])


local=[diff_tar_tar diff_f1_f1 diff_f2_f2]; 
near=[diff_tar_f1 diff_tar_f2];
far=diff_f1_f2;
figure;bar([mean(local) mean(near) mean(far)])

local2=[diff_f3_f3 diff_f4_f4 diff_f5_f5]; 
near2=[diff_f3_f4 diff_f3_f5];
far2=diff_f4_f5;
figure;bar([mean(local2) mean(near2) mean(far2)])




time_f1_cont=mean(cont(roi_f1late,2:112),1)-1;
time_tar_cont=mean(cont(roi_tar,2:112),1)-1;
time_f2_cont=mean(cont(roi_f2,2:112),1)-1;
time_f3_cont=mean(cont(roi_f3,2:112),1)-1;
time_f4_cont=mean(cont(roi_f4,2:112),1)-1;
time_f5_cont=mean(cont(roi_f5,2:112),1)-1;

time_f1_non=mean(non(roi_f1late,2:112),1)-1;
time_tar_non=mean(non(roi_tar,2:112),1)-1;
time_f2_non=mean(non(roi_f2,2:112),1)-1;
time_f3_non=mean(non(roi_f3,2:112),1)-1;
time_f4_non=mean(non(roi_f4,2:112),1)-1;
time_f5_non=mean(non(roi_f5,2:112),1)-1;


time_f1_cont=time_f1_cont/max(time_f1_cont(30:41));
time_f2_cont=time_f2_cont/max(time_f2_cont(30:41));
time_f3_cont=time_f3_cont/max(time_f3_cont(30:41));
time_f4_cont=time_f4_cont/max(time_f4_cont(30:41));
time_f5_cont=time_f5_cont/max(time_f5_cont(30:41));
time_tar_cont=time_tar_cont/max(time_tar_cont(30:41));

time_f1_non=time_f1_non/max(time_f1_non(30:41));
time_f2_non=time_f2_non/max(time_f2_non(30:41));
time_f3_non=time_f3_non/max(time_f3_non(30:41));
time_f4_non=time_f4_non/max(time_f4_non(30:41));
time_f5_non=time_f5_non/max(time_f5_non(30:41));
time_tar_non=time_tar_non/max(time_tar_non(30:41));


figure;plot(time_f1_cont)
hold on
plot(time_tar_cont)
plot(time_f2_cont)
xlim([30 41])

figure;plot(time_f3_cont,'r')
hold on
plot(time_f4_cont,'r')
plot(time_f5_cont,'r')
xlim([30 41])



figure;plot(time_f1_non)
hold on
plot(time_tar_non)
plot(time_f2_non)
xlim([30 41])

figure;plot(time_f3_non,'r')
hold on
plot(time_f4_non,'r')
plot(time_f5_non,'r')
xlim([30 41])

corrcoef(time_f1_cont(30:41),time_f2_cont(30:41))
corrcoef(time_f1_cont(30:41),time_tar_cont(30:41))
corrcoef(time_tar_cont(30:41),time_f2_cont(30:41))

corrcoef(time_f3_cont(30:41),time_f4_cont(30:41))
corrcoef(time_f4_cont(30:41),time_f5_cont(30:41))
corrcoef(time_f3_cont(30:41),time_f5_cont(30:41))









