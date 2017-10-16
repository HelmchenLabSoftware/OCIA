

x=(10:10:2560)-280;
figure;errorbar(x(15:68),mean(tc_tar_cont(15:68,:)-1,2),std(tc_tar_cont(15:68,:),0,2)/sqrt(size(tc_tar_cont,2)-1));
hold on
errorbar(x(15:68),mean(tc_tar_non(15:68,:)-1,2),std(tc_tar_non(15:68,:),0,2)/sqrt(size(tc_tar_non,2)-1),'r');
errorbar(x(15:68),mean(tc_tar_bl(15:68,:)-1,2),std(tc_tar_bl(15:68,:),0,2)/sqrt(55),'g');
xlim([-100 300])



x=(10:10:2560)-280;
figure;errorbar(x(15:68),mean(tc_f3_cont(15:68,:)-1,2),std(tc_f3_cont(15:68,:),0,2)/sqrt(size(tc_f3_cont,2)-1));
hold on
errorbar(x(15:68),mean(tc_f3_non(15:68,:)-1,2),std(tc_f3_non(15:68,:),0,2)/sqrt(size(tc_f3_non,2)-1),'r');
errorbar(x(15:68),mean(tc_f3_bl(15:68,:)-1,2),std(tc_f3_bl(15:68,:),0,2)/sqrt(55),'g');
xlim([-100 300])



x=(10:10:2560)-280;
figure;errorbar(x(15:68),mean(tc_f2_cont(15:68,:)-1,2),std(tc_f2_cont(15:68,:),0,2)/sqrt(size(tc_f2_cont,2)-1));
hold on
errorbar(x(15:68),mean(tc_f2_non(15:68,:)-1,2),std(tc_f2_non(15:68,:),0,2)/sqrt(size(tc_f2_non,2)-1),'r');
errorbar(x(15:68),mean(tc_f2_bl(15:68,:)-1,2),std(tc_f2_bl(15:68,:),0,2)/sqrt(size(tc_f2_bl,2)-1),'g');
xlim([-100 300])


x=(10:10:2560)-280;
figure;errorbar(x(15:68),mean(tc_f1late_cont(15:68,:)-1,2),std(tc_f1late_cont(15:68,:),0,2)/sqrt(size(tc_f1late_cont,2)-1));
hold on
errorbar(x(15:68),mean(tc_f1late_non(15:68,:)-1,2),std(tc_f1late_non(15:68,:),0,2)/sqrt(size(tc_f1late_non,2)-1),'r');
errorbar(x(15:68),mean(tc_f1late_bl(15:68,:)-1,2),std(tc_f1late_bl(15:68,:),0,2)/sqrt(size(tc_f1late_bl,2)-1),'g');
xlim([-100 300])


