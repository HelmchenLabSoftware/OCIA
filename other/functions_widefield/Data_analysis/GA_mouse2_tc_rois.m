

cd D:\intrinsic\20150128\mouse_tgg6fl23_2\c\Matt_files
load('time_course_ROIs_clean.mat')

GA_100_del1100_s1=nanmean(resp_100_s1,2);
GA_100_del1100_s2=nanmean(resp_100_s2,2);
GA_100_del1100_m1=nanmean(resp_100_m1,2);
GA_100_del1100_a1=nanmean(resp_100_a1,2);
GA_100_del1100_alm=nanmean(resp_100_alm,2);
GA_100_del1100_m2=nanmean(resp_100_m2,2);

GA_1200_del1100_s1=nanmean(resp_1200_s1,2);
GA_1200_del1100_s2=nanmean(resp_1200_s2,2);
GA_1200_del1100_m1=nanmean(resp_1200_m1,2);
GA_1200_del1100_a1=nanmean(resp_1200_a1,2);
GA_1200_del1100_alm=nanmean(resp_1200_alm,2);
GA_1200_del1100_m2=nanmean(resp_1200_m2,2);

cd D:\intrinsic\20150129\mouse_tgg6fl23_2\c\Matt_files
load('time_course_ROIs_clean.mat')

GA_100_del1100_s1=cat(2,GA_100_del1100_s1,nanmean(resp_100_s1,2));
GA_100_del1100_s2=cat(2,GA_100_del1100_s2,nanmean(resp_100_s2,2));
GA_100_del1100_m1=cat(2,GA_100_del1100_m1,nanmean(resp_100_m1,2));
GA_100_del1100_a1=cat(2,GA_100_del1100_a1,nanmean(resp_100_a1,2));
GA_100_del1100_alm=cat(2,GA_100_del1100_alm,nanmean(resp_100_alm,2));
GA_100_del1100_m2=cat(2,GA_100_del1100_m2,nanmean(resp_100_m2,2));

GA_1200_del1100_s1=cat(2,GA_1200_del1100_s1,nanmean(resp_1200_s1,2));
GA_1200_del1100_s2=cat(2,GA_1200_del1100_s2,nanmean(resp_1200_s2,2));
GA_1200_del1100_m1=cat(2,GA_1200_del1100_m1,nanmean(resp_1200_m1,2));
GA_1200_del1100_a1=cat(2,GA_1200_del1100_a1,nanmean(resp_1200_a1,2));
GA_1200_del1100_alm=cat(2,GA_1200_del1100_alm,nanmean(resp_1200_alm,2));
GA_1200_del1100_m2=cat(2,GA_1200_del1100_m2,nanmean(resp_1200_m2,2));

cd D:\intrinsic\20150130\mouse_tgg6fl23_2\b\Matt_files
load('time_course_ROIs_clean.mat')

GA_100_del1100_s1=cat(2,GA_100_del1100_s1,nanmean(resp_100_s1,2));
GA_100_del1100_s2=cat(2,GA_100_del1100_s2,nanmean(resp_100_s2,2));
GA_100_del1100_m1=cat(2,GA_100_del1100_m1,nanmean(resp_100_m1,2));
GA_100_del1100_a1=cat(2,GA_100_del1100_a1,nanmean(resp_100_a1,2));
GA_100_del1100_alm=cat(2,GA_100_del1100_alm,nanmean(resp_100_alm,2));
GA_100_del1100_m2=cat(2,GA_100_del1100_m2,nanmean(resp_100_m2,2));

GA_1200_del1100_s1=cat(2,GA_1200_del1100_s1,nanmean(resp_1200_s1,2));
GA_1200_del1100_s2=cat(2,GA_1200_del1100_s2,nanmean(resp_1200_s2,2));
GA_1200_del1100_m1=cat(2,GA_1200_del1100_m1,nanmean(resp_1200_m1,2));
GA_1200_del1100_a1=cat(2,GA_1200_del1100_a1,nanmean(resp_1200_a1,2));
GA_1200_del1100_alm=cat(2,GA_1200_del1100_alm,nanmean(resp_1200_alm,2));
GA_1200_del1100_m2=cat(2,GA_1200_del1100_m2,nanmean(resp_1200_m2,2));

cd D:\intrinsic\20150130\mouse_tgg6fl23_2\c\Matt_files
load('time_course_ROIs_clean.mat')

GA_100_del1100_s1=cat(2,GA_100_del1100_s1,nanmean(resp_100_s1,2));
GA_100_del1100_s2=cat(2,GA_100_del1100_s2,nanmean(resp_100_s2,2));
GA_100_del1100_m1=cat(2,GA_100_del1100_m1,nanmean(resp_100_m1,2));
GA_100_del1100_a1=cat(2,GA_100_del1100_a1,nanmean(resp_100_a1,2));
GA_100_del1100_alm=cat(2,GA_100_del1100_alm,nanmean(resp_100_alm,2));
GA_100_del1100_m2=cat(2,GA_100_del1100_m2,nanmean(resp_100_m2,2));

GA_1200_del1100_s1=cat(2,GA_1200_del1100_s1,nanmean(resp_1200_s1,2));
GA_1200_del1100_s2=cat(2,GA_1200_del1100_s2,nanmean(resp_1200_s2,2));
GA_1200_del1100_m1=cat(2,GA_1200_del1100_m1,nanmean(resp_1200_m1,2));
GA_1200_del1100_a1=cat(2,GA_1200_del1100_a1,nanmean(resp_1200_a1,2));
GA_1200_del1100_alm=cat(2,GA_1200_del1100_alm,nanmean(resp_1200_alm,2));
GA_1200_del1100_m2=cat(2,GA_1200_del1100_m2,nanmean(resp_1200_m2,2));


x=(1:180)*0.05-2.7;
x=x(1:3:180);

figure;errorbar(x,nanmean(GA_100_del1100_s1,2),nanstd(GA_100_del1100_s1,0,2)/sqrt(size(GA_100_del1100_s1,2)),'b')
hold on
errorbar(x,nanmean(GA_1200_del1100_s1,2),nanstd(GA_1200_del1100_s1,0,2)/sqrt(size(GA_1200_del1100_s1,2)),'c')
title('S1')

figure;errorbar(x,nanmean(GA_100_del1100_s2,2),nanstd(GA_100_del1100_s2,0,2)/sqrt(size(GA_100_del1100_s2,2)),'--b')
hold on
errorbar(x,nanmean(GA_1200_del1100_s2,2),nanstd(GA_1200_del1100_s2,0,2)/sqrt(size(GA_1200_del1100_s2,2)),'--c')
title('S2')

figure;errorbar(x,nanmean(GA_100_del1100_m1,2),nanstd(GA_100_del1100_m1,0,2)/sqrt(size(GA_100_del1100_m1,2)),'r')
hold on
errorbar(x,nanmean(GA_1200_del1100_m1,2),nanstd(GA_1200_del1100_m1,0,2)/sqrt(size(GA_1200_del1100_m1,2)),'m')
title('M1')

figure;errorbar(x,nanmean(GA_100_del1100_a1,2),nanstd(GA_100_del1100_a1,0,2)/sqrt(size(GA_100_del1100_a1,2)),'g')
hold on
errorbar(x,nanmean(GA_1200_del1100_a1,2),nanstd(GA_1200_del1100_a1,0,2)/sqrt(size(GA_1200_del1100_a1,2)),'y')
title('A1')

figure;errorbar(x,nanmean(GA_100_del1100_alm,2),nanstd(GA_100_del1100_alm,0,2)/sqrt(size(GA_100_del1100_alm,2)),'--r')
hold on
errorbar(x,nanmean(GA_1200_del1100_alm,2),nanstd(GA_1200_del1100_alm,0,2)/sqrt(size(GA_1200_del1100_alm,2)),'--m')
title('Alm')

figure;errorbar(x,nanmean(GA_100_del1100_m2,2),nanstd(GA_100_del1100_m2,0,2)/sqrt(size(GA_100_del1100_m2,2)),'--r')
hold on
errorbar(x,nanmean(GA_1200_del1100_m2,2),nanstd(GA_1200_del1100_m2,0,2)/sqrt(size(GA_1200_del1100_m2,2)),'--m')
title('M2')


diff_s1=GA_100_del1100_s1-GA_1200_del1100_s1;
diff_s2=GA_100_del1100_s2-GA_1200_del1100_s2;
diff_m1=GA_100_del1100_m1-GA_1200_del1100_m1;
diff_m2=GA_100_del1100_m2-GA_1200_del1100_m2;
diff_a1=GA_100_del1100_a1-GA_1200_del1100_a1;
diff_alm=GA_100_del1100_alm-GA_1200_del1100_alm;
figure;errorbar(x,nanmean(diff_s1,2),nanstd(diff_s1,0,2)/sqrt(size(diff_s1,2)),'b')
hold on
errorbar(x,nanmean(diff_s2,2),nanstd(diff_s2,0,2)/sqrt(size(diff_s2,2)),'c')
errorbar(x,nanmean(diff_m1,2),nanstd(diff_m1,0,2)/sqrt(size(diff_m1,2)),'r')
errorbar(x,nanmean(diff_alm,2),nanstd(diff_alm,0,2)/sqrt(size(diff_alm,2)),'m')
errorbar(x,nanmean(diff_a1,2),nanstd(diff_a1,0,2)/sqrt(size(diff_a1,2)),'g')
errorbar(x,nanmean(diff_m2,2),nanstd(diff_m2,0,2)/sqrt(size(diff_m2,2)),'k')
legend('s1','s2','m1','alm','a1','m2')
plot(x,zeros(1,60),'k')




%%

cd D:\intrinsic\20150128\mouse_tgg6fl23_2\a\Matt_files
load('time_course_ROIs_clean.mat')

GA_100_del800_s1=nanmean(resp_100_s1,2);
GA_100_del800_s2=nanmean(resp_100_s2,2);
GA_100_del800_m1=nanmean(resp_100_m1,2);
GA_100_del800_a1=nanmean(resp_100_a1,2);
GA_100_del800_alm=nanmean(resp_100_alm,2);
GA_100_del800_m2=nanmean(resp_100_m2,2);

GA_1200_del800_s1=nanmean(resp_1200_s1,2);
GA_1200_del800_s2=nanmean(resp_1200_s2,2);
GA_1200_del800_m1=nanmean(resp_1200_m1,2);
GA_1200_del800_a1=nanmean(resp_1200_a1,2);
GA_1200_del800_alm=nanmean(resp_1200_alm,2);
GA_1200_del800_m2=nanmean(resp_1200_m2,2);

cd D:\intrinsic\20150128\mouse_tgg6fl23_2\b\Matt_files
load('time_course_ROIs_clean.mat')

GA_100_del800_s1=cat(2,GA_100_del800_s1,nanmean(resp_100_s1,2));
GA_100_del800_s2=cat(2,GA_100_del800_s2,nanmean(resp_100_s2,2));
GA_100_del800_m1=cat(2,GA_100_del800_m1,nanmean(resp_100_m1,2));
GA_100_del800_a1=cat(2,GA_100_del800_a1,nanmean(resp_100_a1,2));
GA_100_del800_alm=cat(2,GA_100_del800_alm,nanmean(resp_100_alm,2));
GA_100_del800_m2=cat(2,GA_100_del800_m2,nanmean(resp_100_m2,2));

GA_1200_del800_s1=cat(2,GA_1200_del800_s1,nanmean(resp_1200_s1,2));
GA_1200_del800_s2=cat(2,GA_1200_del800_s2,nanmean(resp_1200_s2,2));
GA_1200_del800_m1=cat(2,GA_1200_del800_m1,nanmean(resp_1200_m1,2));
GA_1200_del800_a1=cat(2,GA_1200_del800_a1,nanmean(resp_1200_a1,2));
GA_1200_del800_alm=cat(2,GA_1200_del800_alm,nanmean(resp_1200_alm,2));
GA_1200_del800_m2=cat(2,GA_1200_del800_m2,nanmean(resp_1200_m2,2));

cd D:\intrinsic\20150129\mouse_tgg6fl23_2\a\Matt_files
load('time_course_ROIs_clean.mat')

GA_100_del800_s1=cat(2,GA_100_del800_s1,nanmean(resp_100_s1,2));
GA_100_del800_s2=cat(2,GA_100_del800_s2,nanmean(resp_100_s2,2));
GA_100_del800_m1=cat(2,GA_100_del800_m1,nanmean(resp_100_m1,2));
GA_100_del800_a1=cat(2,GA_100_del800_a1,nanmean(resp_100_a1,2));
GA_100_del800_alm=cat(2,GA_100_del800_alm,nanmean(resp_100_alm,2));
GA_100_del800_m2=cat(2,GA_100_del800_m2,nanmean(resp_100_m2,2));

GA_1200_del800_s1=cat(2,GA_1200_del800_s1,nanmean(resp_1200_s1,2));
GA_1200_del800_s2=cat(2,GA_1200_del800_s2,nanmean(resp_1200_s2,2));
GA_1200_del800_m1=cat(2,GA_1200_del800_m1,nanmean(resp_1200_m1,2));
GA_1200_del800_a1=cat(2,GA_1200_del800_a1,nanmean(resp_1200_a1,2));
GA_1200_del800_alm=cat(2,GA_1200_del800_alm,nanmean(resp_1200_alm,2));
GA_1200_del800_m2=cat(2,GA_1200_del800_m2,nanmean(resp_1200_m2,2));

cd D:\intrinsic\20150130\mouse_tgg6fl23_2\a\Matt_files
load('time_course_ROIs_clean.mat')

GA_100_del800_s1=cat(2,GA_100_del800_s1,nanmean(resp_100_s1,2));
GA_100_del800_s2=cat(2,GA_100_del800_s2,nanmean(resp_100_s2,2));
GA_100_del800_m1=cat(2,GA_100_del800_m1,nanmean(resp_100_m1,2));
GA_100_del800_a1=cat(2,GA_100_del800_a1,nanmean(resp_100_a1,2));
GA_100_del800_alm=cat(2,GA_100_del800_alm,nanmean(resp_100_alm,2));
GA_100_del800_m2=cat(2,GA_100_del800_m2,nanmean(resp_100_m2,2));

GA_1200_del800_s1=cat(2,GA_1200_del800_s1,nanmean(resp_1200_s1,2));
GA_1200_del800_s2=cat(2,GA_1200_del800_s2,nanmean(resp_1200_s2,2));
GA_1200_del800_m1=cat(2,GA_1200_del800_m1,nanmean(resp_1200_m1,2));
GA_1200_del800_a1=cat(2,GA_1200_del800_a1,nanmean(resp_1200_a1,2));
GA_1200_del800_alm=cat(2,GA_1200_del800_alm,nanmean(resp_1200_alm,2));
GA_1200_del800_m2=cat(2,GA_1200_del800_m2,nanmean(resp_1200_m2,2));


x=(1:180)*0.05-2.7;
x=x(1:3:180);

figure;errorbar(x,nanmean(GA_100_del800_s1,2),nanstd(GA_100_del800_s1,0,2)/sqrt(size(GA_100_del800_s1,2)),'b')
hold on
errorbar(x,nanmean(GA_1200_del800_s1,2),nanstd(GA_1200_del800_s1,0,2)/sqrt(size(GA_1200_del800_s1,2)),'c')
title('S1')

figure;errorbar(x,nanmean(GA_100_del800_s2,2),nanstd(GA_100_del800_s2,0,2)/sqrt(size(GA_100_del800_s2,2)),'--b')
hold on
errorbar(x,nanmean(GA_1200_del800_s2,2),nanstd(GA_1200_del800_s2,0,2)/sqrt(size(GA_1200_del800_s2,2)),'--c')
title('S2')

figure;errorbar(x,nanmean(GA_100_del800_m1,2),nanstd(GA_100_del800_m1,0,2)/sqrt(size(GA_100_del800_m1,2)),'r')
hold on
errorbar(x,nanmean(GA_1200_del800_m1,2),nanstd(GA_1200_del800_m1,0,2)/sqrt(size(GA_1200_del800_m1,2)),'m')
title('M1')

figure;errorbar(x,nanmean(GA_100_del800_a1,2),nanstd(GA_100_del800_a1,0,2)/sqrt(size(GA_100_del800_a1,2)),'g')
hold on
errorbar(x,nanmean(GA_1200_del800_a1,2),nanstd(GA_1200_del800_a1,0,2)/sqrt(size(GA_1200_del800_a1,2)),'y')
title('A1')

figure;errorbar(x,nanmean(GA_100_del800_alm,2),nanstd(GA_100_del800_alm,0,2)/sqrt(size(GA_100_del800_alm,2)),'--r')
hold on
errorbar(x,nanmean(GA_1200_del800_alm,2),nanstd(GA_1200_del800_alm,0,2)/sqrt(size(GA_1200_del800_alm,2)),'--m')
title('Alm')

figure;errorbar(x,nanmean(GA_100_del800_m2,2),nanstd(GA_100_del800_m2,0,2)/sqrt(size(GA_100_del800_m2,2)),'--r')
hold on
errorbar(x,nanmean(GA_1200_del800_m2,2),nanstd(GA_1200_del800_m2,0,2)/sqrt(size(GA_1200_del800_m2,2)),'--m')
title('M2')


diff_s1=GA_100_del800_s1-GA_1200_del800_s1;
diff_s2=GA_100_del800_s2-GA_1200_del800_s2;
diff_m1=GA_100_del800_m1-GA_1200_del800_m1;
diff_m2=GA_100_del800_m2-GA_1200_del800_m2;
diff_a1=GA_100_del800_a1-GA_1200_del800_a1;
diff_alm=GA_100_del800_alm-GA_1200_del800_alm;
figure;errorbar(x,nanmean(diff_s1,2),nanstd(diff_s1,0,2)/sqrt(size(diff_s1,2)),'b')
hold on
errorbar(x,nanmean(diff_s2,2),nanstd(diff_s2,0,2)/sqrt(size(diff_s2,2)),'c')
errorbar(x,nanmean(diff_m1,2),nanstd(diff_m1,0,2)/sqrt(size(diff_m1,2)),'r')
errorbar(x,nanmean(diff_alm,2),nanstd(diff_alm,0,2)/sqrt(size(diff_alm,2)),'m')
errorbar(x,nanmean(diff_a1,2),nanstd(diff_a1,0,2)/sqrt(size(diff_a1,2)),'g')
errorbar(x,nanmean(diff_m2,2),nanstd(diff_m2,0,2)/sqrt(size(diff_m2,2)),'k')
legend('s1','s2','m1','alm','a1','m2')
plot(x,zeros(1,60),'k')



