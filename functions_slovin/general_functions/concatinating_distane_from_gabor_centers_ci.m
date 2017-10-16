

plane_c_dist_1111(:,1)=plane_c_dist_1111c14;
plane_c_dist_1111(:,2)=plane_c_dist_1111c25;
plane_c_dist_1111(:,3)=plane_c_dist_1111d14;
plane_c_dist_1111(:,4)=plane_c_dist_1111d25;


plane_b_dist_1111(:,1)=plane_b_dist_1111c14;
plane_b_dist_1111(:,2)=plane_b_dist_1111c25;
plane_b_dist_1111(:,3)=plane_b_dist_1111d14;
plane_b_dist_1111(:,4)=plane_b_dist_1111d25;


figure;plot(mean(plane_c_dist_1111,2),'b')
hold on
plot(zeros(1,size(plane_b_dist_1111,1)),'k')
plot(mean(plane_b_dist_1111,2),'r')


plane_c_dist_2511(:,1)=plane_c_dist_2511d;
plane_c_dist_2511(:,2)=plane_c_dist_2511e;
plane_c_dist_2511(:,3)=plane_c_dist_2511f;

plane_b_dist_2511(:,1)=plane_b_dist_2511d;
plane_b_dist_2511(:,2)=plane_b_dist_2511e;
plane_b_dist_2511(:,3)=plane_b_dist_2511f;

figure;plot(mean(plane_c_dist_2511,2),'b')
hold on
plot(zeros(1,size(plane_b_dist_2511,1)),'k')
plot(mean(plane_b_dist_2511,2),'r')





plane_c_dist_1811(:,1)=plane_c_dist_1811c;
plane_c_dist_1811(:,2)=plane_c_dist_1811d;
plane_c_dist_1811(:,3)=plane_c_dist_1811e;

plane_b_dist_1811(:,1)=plane_b_dist_1811c;
plane_b_dist_1811(:,2)=plane_b_dist_1811d;
plane_b_dist_1811(:,3)=plane_b_dist_1811e;

figure;plot(mean(plane_c_dist_1811,2),'b')
hold on
plot(zeros(1,size(plane_b_dist_1811,1)),'k')
plot(mean(plane_b_dist_1811,2),'r')



plane_c_dist_1203(:,1)=plane_c_dist_1203d;
plane_c_dist_1203(:,2)=plane_c_dist_1203e;
plane_c_dist_1203(:,3)=plane_c_dist_1203f;

plane_b_dist_1203(:,1)=plane_b_dist_1203d;
plane_b_dist_1203(:,2)=plane_b_dist_1203e;
plane_b_dist_1203(:,3)=plane_b_dist_1203f;

figure;plot(mean(plane_c_dist_1203,2),'b')
hold on
plot(zeros(1,size(plane_b_dist_1203,1)),'k')
plot(mean(plane_b_dist_1203,2),'r')






plane_c_dist_0610(:,1)=plane_c_dist_0610e14;
plane_c_dist_0610(:,2)=plane_c_dist_0610e25;
plane_c_dist_0610(:,3)=plane_c_dist_0610f14;
plane_c_dist_0610(:,4)=plane_c_dist_0610f25;


plane_b_dist_0610(:,1)=plane_b_dist_0610e14;
plane_b_dist_0610(:,2)=plane_b_dist_0610e25;
plane_b_dist_0610(:,3)=plane_b_dist_0610f14;
plane_b_dist_0610(:,4)=plane_b_dist_0610f25;


figure;plot(mean(plane_c_dist_0610,2),'b')
hold on
plot(zeros(1,size(plane_b_dist_0610,1)),'k')
plot(mean(plane_b_dist_0610,2),'r')





plane_c_dist_2210(:,1)=plane_c_dist_2210d14;
plane_c_dist_2210(:,2)=plane_c_dist_2210d25;
plane_c_dist_2210(:,3)=plane_c_dist_2210e14;
plane_c_dist_2210(:,4)=plane_c_dist_2210e25;


plane_b_dist_2210(:,1)=plane_b_dist_2210d14;
plane_b_dist_2210(:,2)=plane_b_dist_2210d25;
plane_b_dist_2210(:,3)=plane_b_dist_2210e14;
plane_b_dist_2210(:,4)=plane_b_dist_2210e25;


figure;plot(mean(plane_c_dist_2210,2),'b')
hold on
plot(zeros(1,size(plane_b_dist_2210,1)),'k')
plot(mean(plane_b_dist_2210,2),'r')


%% LEGOLAS



distance_circle=nan*ones(12,23);
distance_circle(1:size(plane_c_dist_1111cd,1),1:4)=plane_c_dist_1111cd;
distance_circle(1:size(plane_c_dist_2511,1),5:7)=plane_c_dist_2511;
distance_circle(1:size(plane_c_dist_1811,1),8:10)=plane_c_dist_1811;
distance_circle(1:size(plane_c_dist_1203,1),11:13)=plane_c_dist_1203;
distance_circle(1:size(plane_c_dist_1111h14,1),14)=plane_c_dist_1111h14;
distance_circle(1:size(plane_c_dist_1111h25,1),15)=plane_c_dist_1111h25;
distance_circle(1:size(plane_c_dist_0610,1),16:19)=plane_c_dist_0610;
distance_circle(1:size(plane_c_dist_2210,1),20:23)=plane_c_dist_2210;



distance_bg=nan*ones(20,23);
distance_bg(1:size(plane_b_dist_1111cd,1),1:4)=plane_b_dist_1111cd;
distance_bg(1:size(plane_b_dist_2511,1),5:7)=plane_b_dist_2511;
distance_bg(1:size(plane_b_dist_1811,1),8:10)=plane_b_dist_1811;
distance_bg(1:size(plane_b_dist_1203,1),11:13)=plane_b_dist_1203;
distance_bg(1:size(plane_b_dist_1111h14,1),14)=plane_b_dist_1111h14;
distance_bg(1:size(plane_b_dist_1111h25,1),15)=plane_b_dist_1111h25;
distance_bg(1:size(plane_b_dist_0610,1),16:19)=plane_b_dist_0610;
distance_bg(1:size(plane_b_dist_2210,1),20:23)=plane_b_dist_2210;


xc=0:0.2:0.2*(size(distance_circle,1)-1);
xb=0:0.2:0.2*(size(distance_bg,1)-1);

figure;errorbar(xc,nanmean(distance_circle,2),nanstd(distance_circle,0,2)/sqrt(size(distance_circle,2)),'b')
hold on
errorbar(xb,nanmean(distance_bg,2),nanstd(distance_bg,0,2)/sqrt(size(distance_bg,2)),'r')
plot(xb,zeros(1,size(distance_bg,1)),'k')
xlim([0 2.2]);





% PER TIME PER COND

distance_circle_cont=nan*ones(12,256,23);
distance_circle_cont(1:size(plane_cont_c_dist_1111c1,1),:,1)=plane_cont_c_dist_1111c1;
distance_circle_cont(1:size(plane_cont_c_dist_1111c2,1),:,2)=plane_cont_c_dist_1111c2;
distance_circle_cont(1:size(plane_cont_c_dist_1111d1,1),:,3)=plane_cont_c_dist_1111d1;
distance_circle_cont(1:size(plane_cont_c_dist_1111d2,1),:,4)=plane_cont_c_dist_1111d2;
distance_circle_cont(1:size(plane_cont_c_dist_1111h1,1),:,5)=plane_cont_c_dist_1111h1;
distance_circle_cont(1:size(plane_cont_c_dist_1111h2,1),:,6)=plane_cont_c_dist_1111h2;
distance_circle_cont(1:size(plane_cont_c_dist_1811c,1),:,7)=plane_cont_c_dist_1811c;
distance_circle_cont(1:size(plane_cont_c_dist_1811d,1),:,8)=plane_cont_c_dist_1811d;
distance_circle_cont(1:size(plane_cont_c_dist_1811e,1),:,9)=plane_cont_c_dist_1811e;
distance_circle_cont(1:size(plane_cont_c_dist_2511d,1),:,10)=plane_cont_c_dist_2511d;
distance_circle_cont(1:size(plane_cont_c_dist_2511e,1),:,11)=plane_cont_c_dist_2511e;
distance_circle_cont(1:size(plane_cont_c_dist_2511f,1),:,12)=plane_cont_c_dist_2511f;
distance_circle_cont(1:size(plane_cont_c_dist_1203d,1),:,13)=plane_cont_c_dist_1203d;
distance_circle_cont(1:size(plane_cont_c_dist_1203e,1),:,14)=plane_cont_c_dist_1203e;
distance_circle_cont(1:size(plane_cont_c_dist_1203f,1),:,15)=plane_cont_c_dist_1203f;
distance_circle_cont(1:size(plane_cont_c_dist_0610e1,1),:,16)=plane_cont_c_dist_0610e1;
distance_circle_cont(1:size(plane_cont_c_dist_0610e2,1),:,17)=plane_cont_c_dist_0610e2;
distance_circle_cont(1:size(plane_cont_c_dist_0610f1,1),:,18)=plane_cont_c_dist_0610f1;
distance_circle_cont(1:size(plane_cont_c_dist_0610f2,1),:,19)=plane_cont_c_dist_0610f2;
distance_circle_cont(1:size(plane_cont_c_dist_2210d1,1),:,20)=plane_cont_c_dist_2210d1;
distance_circle_cont(1:size(plane_cont_c_dist_2210d2,1),:,21)=plane_cont_c_dist_2210d2;
distance_circle_cont(1:size(plane_cont_c_dist_2210e1,1),:,22)=plane_cont_c_dist_2210e1;
distance_circle_cont(1:size(plane_cont_c_dist_2210e2,1),:,23)=plane_cont_c_dist_2210e2;


distance_circle_non=nan*ones(12,256,23);
distance_circle_non(1:size(plane_non_c_dist_1111c4,1),:,1)=plane_non_c_dist_1111c4;
distance_circle_non(1:size(plane_non_c_dist_1111c5,1),:,2)=plane_non_c_dist_1111c5;
distance_circle_non(1:size(plane_non_c_dist_1111d4,1),:,3)=plane_non_c_dist_1111d4;
distance_circle_non(1:size(plane_non_c_dist_1111d5,1),:,4)=plane_non_c_dist_1111d5;
distance_circle_non(1:size(plane_non_c_dist_1111h4,1),:,5)=plane_non_c_dist_1111h4;
distance_circle_non(1:size(plane_non_c_dist_1111h5,1),:,6)=plane_non_c_dist_1111h5;
distance_circle_non(1:size(plane_non_c_dist_1811c,1),:,7)=plane_non_c_dist_1811c;
distance_circle_non(1:size(plane_non_c_dist_1811d,1),:,8)=plane_non_c_dist_1811d;
distance_circle_non(1:size(plane_non_c_dist_1811e,1),:,9)=plane_non_c_dist_1811e;
distance_circle_non(1:size(plane_non_c_dist_2511d,1),:,10)=plane_non_c_dist_2511d;
distance_circle_non(1:size(plane_non_c_dist_2511e,1),:,11)=plane_non_c_dist_2511e;
distance_circle_non(1:size(plane_non_c_dist_2511f,1),:,12)=plane_non_c_dist_2511f;
distance_circle_non(1:size(plane_non_c_dist_1203d,1),:,13)=plane_non_c_dist_1203d;
distance_circle_non(1:size(plane_non_c_dist_1203e,1),:,14)=plane_non_c_dist_1203e;
distance_circle_non(1:size(plane_non_c_dist_1203f,1),:,15)=plane_non_c_dist_1203f;
distance_circle_non(1:size(plane_non_c_dist_0610e4,1),:,16)=plane_non_c_dist_0610e4;
distance_circle_non(1:size(plane_non_c_dist_0610e5,1),:,17)=plane_non_c_dist_0610e5;
distance_circle_non(1:size(plane_non_c_dist_0610f4,1),:,18)=plane_non_c_dist_0610f4;
distance_circle_non(1:size(plane_non_c_dist_0610f5,1),:,19)=plane_non_c_dist_0610f5;
distance_circle_non(1:size(plane_non_c_dist_2210d4,1),:,20)=plane_non_c_dist_2210d4;
distance_circle_non(1:size(plane_non_c_dist_2210d5,1),:,21)=plane_non_c_dist_2210d5;
distance_circle_non(1:size(plane_non_c_dist_2210e4,1),:,22)=plane_non_c_dist_2210e4;
distance_circle_non(1:size(plane_non_c_dist_2210e5,1),:,23)=plane_non_c_dist_2210e5;



distance_bg_cont=nan*ones(20,256,23);
distance_bg_cont(1:size(plane_cont_b_dist_1111c1,1),:,1)=plane_cont_b_dist_1111c1;
distance_bg_cont(1:size(plane_cont_b_dist_1111c2,1),:,2)=plane_cont_b_dist_1111c2;
distance_bg_cont(1:size(plane_cont_b_dist_1111d1,1),:,3)=plane_cont_b_dist_1111d1;
distance_bg_cont(1:size(plane_cont_b_dist_1111d2,1),:,4)=plane_cont_b_dist_1111d2;
distance_bg_cont(1:size(plane_cont_b_dist_1111h1,1),:,5)=plane_cont_b_dist_1111h1;
distance_bg_cont(1:size(plane_cont_b_dist_1111h2,1),:,6)=plane_cont_b_dist_1111h2;
distance_bg_cont(1:size(plane_cont_b_dist_1811c,1),:,7)=plane_cont_b_dist_1811c;
distance_bg_cont(1:size(plane_cont_b_dist_1811d,1),:,8)=plane_cont_b_dist_1811d;
distance_bg_cont(1:size(plane_cont_b_dist_1811e,1),:,9)=plane_cont_b_dist_1811e;
distance_bg_cont(1:size(plane_cont_b_dist_2511d,1),:,10)=plane_cont_b_dist_2511d;
distance_bg_cont(1:size(plane_cont_b_dist_2511e,1),:,11)=plane_cont_b_dist_2511e;
distance_bg_cont(1:size(plane_cont_b_dist_2511f,1),:,12)=plane_cont_b_dist_2511f;
distance_bg_cont(1:size(plane_cont_b_dist_1203d,1),:,13)=plane_cont_b_dist_1203d;
distance_bg_cont(1:size(plane_cont_b_dist_1203e,1),:,14)=plane_cont_b_dist_1203e;
distance_bg_cont(1:size(plane_cont_b_dist_1203f,1),:,15)=plane_cont_b_dist_1203f;
distance_bg_cont(1:size(plane_cont_b_dist_0610e1,1),:,16)=plane_cont_b_dist_0610e1;
distance_bg_cont(1:size(plane_cont_b_dist_0610e2,1),:,17)=plane_cont_b_dist_0610e2;
distance_bg_cont(1:size(plane_cont_b_dist_0610f1,1),:,18)=plane_cont_b_dist_0610f1;
distance_bg_cont(1:size(plane_cont_b_dist_0610f2,1),:,19)=plane_cont_b_dist_0610f2;
distance_bg_cont(1:size(plane_cont_b_dist_2210d1,1),:,20)=plane_cont_b_dist_2210d1;
distance_bg_cont(1:size(plane_cont_b_dist_2210d2,1),:,21)=plane_cont_b_dist_2210d2;
distance_bg_cont(1:size(plane_cont_b_dist_2210e1,1),:,22)=plane_cont_b_dist_2210e1;
distance_bg_cont(1:size(plane_cont_b_dist_2210e2,1),:,23)=plane_cont_b_dist_2210e2;


distance_bg_non=nan*ones(20,256,23);
distance_bg_non(1:size(plane_non_b_dist_1111c4,1),:,1)=plane_non_b_dist_1111c4;
distance_bg_non(1:size(plane_non_b_dist_1111c5,1),:,2)=plane_non_b_dist_1111c5;
distance_bg_non(1:size(plane_non_b_dist_1111d4,1),:,3)=plane_non_b_dist_1111d4;
distance_bg_non(1:size(plane_non_b_dist_1111d5,1),:,4)=plane_non_b_dist_1111d5;
distance_bg_non(1:size(plane_non_b_dist_1111h4,1),:,5)=plane_non_b_dist_1111h4;
distance_bg_non(1:size(plane_non_b_dist_1111h5,1),:,6)=plane_non_b_dist_1111h5;
distance_bg_non(1:size(plane_non_b_dist_1811c,1),:,7)=plane_non_b_dist_1811c;
distance_bg_non(1:size(plane_non_b_dist_1811d,1),:,8)=plane_non_b_dist_1811d;
distance_bg_non(1:size(plane_non_b_dist_1811e,1),:,9)=plane_non_b_dist_1811e;
distance_bg_non(1:size(plane_non_b_dist_2511d,1),:,10)=plane_non_b_dist_2511d;
distance_bg_non(1:size(plane_non_b_dist_2511e,1),:,11)=plane_non_b_dist_2511e;
distance_bg_non(1:size(plane_non_b_dist_2511f,1),:,12)=plane_non_b_dist_2511f;
distance_bg_non(1:size(plane_non_b_dist_1203d,1),:,13)=plane_non_b_dist_1203d;
distance_bg_non(1:size(plane_non_b_dist_1203e,1),:,14)=plane_non_b_dist_1203e;
distance_bg_non(1:size(plane_non_b_dist_1203f,1),:,15)=plane_non_b_dist_1203f;
distance_bg_non(1:size(plane_non_b_dist_0610e4,1),:,16)=plane_non_b_dist_0610e4;
distance_bg_non(1:size(plane_non_b_dist_0610e5,1),:,17)=plane_non_b_dist_0610e5;
distance_bg_non(1:size(plane_non_b_dist_0610f4,1),:,18)=plane_non_b_dist_0610f4;
distance_bg_non(1:size(plane_non_b_dist_0610f5,1),:,19)=plane_non_b_dist_0610f5;
distance_bg_non(1:size(plane_non_b_dist_2210d4,1),:,20)=plane_non_b_dist_2210d4;
distance_bg_non(1:size(plane_non_b_dist_2210d5,1),:,21)=plane_non_b_dist_2210d5;
distance_bg_non(1:size(plane_non_b_dist_2210e4,1),:,22)=plane_non_b_dist_2210e4;
distance_bg_non(1:size(plane_non_b_dist_2210e5,1),:,23)=plane_non_b_dist_2210e5;



xc=0:0.2:0.2*(size(distance_circle_cont,1)-1);
xb=0:0.2:0.2*(size(distance_bg_cont,1)-1);
x=(10:10:2560)-280;
for i=28:38
    figure;errorbar(xc,nanmean(distance_circle_cont(:,i,:),3),nanstd(distance_circle_cont(:,i,:),0,3)/sqrt(size(distance_circle_cont,3)),'b')
    hold on
    errorbar(xc,nanmean(distance_circle_non(:,i,:),3),nanstd(distance_circle_non(:,i,:),0,3)/sqrt(size(distance_circle_non,3)),'r')
    plot(xc,zeros(1,size(distance_circle_cont,1)),'k')
    xlim([0 2.2])
    ylim([-.5e-3 1.5e-3])
    title(['time ',int2str(x(i)),' ms'])
end

time=43:53;
figure;errorbar(xc,nanmean(nanmean(distance_circle_cont(:,time,:),2),3),nanstd(nanmean(distance_circle_cont(:,time,:),2),0,3)/sqrt(size(distance_circle_cont,3)),'b')
hold on
errorbar(xc,nanmean(nanmean(distance_circle_non(:,time,:),2),3),nanstd(nanmean(distance_circle_non(:,time,:),2),0,3)/sqrt(size(distance_circle_non,3)),'r')
xlim([0 2.2])    


for i=28:58
    figure;errorbar(xb,nanmean(distance_bg_cont(:,i,:),3),nanstd(distance_bg_cont(:,i,:),0,3)/sqrt(size(distance_bg_cont,3)),'b')
    hold on
    errorbar(xb,nanmean(distance_bg_non(:,i,:),3),nanstd(distance_bg_non(:,i,:),0,3)/sqrt(size(distance_bg_non,3)),'r')
    plot(xb,zeros(1,size(distance_bg_cont,1)),'k')
    xlim([0 2.2])
    %ylim([-.5e-3 1.5e-3])
    title(['time ',int2str(x(i)),' ms'])
end

time=43:53;
figure;errorbar(xb,nanmean(nanmean(distance_bg_cont(:,time,:),2),3),nanstd(nanmean(distance_bg_cont(:,time,:),2),0,3)/sqrt(size(distance_bg_cont,3)),'b')
hold on
errorbar(xb,nanmean(nanmean(distance_bg_non(:,time,:),2),3),nanstd(nanmean(distance_bg_non(:,time,:),2),0,3)/sqrt(size(distance_bg_non,3)),'r')
xlim([0 2.2])    





% PER TIME diff

distance_circle=nan*ones(12,256,23);
distance_circle(1:size(plane_c_dist_1111c14,1),:,1)=plane_c_dist_1111c14;
distance_circle(1:size(plane_c_dist_1111c25,1),:,2)=plane_c_dist_1111c25;
distance_circle(1:size(plane_c_dist_1111d14,1),:,3)=plane_c_dist_1111d14;
distance_circle(1:size(plane_c_dist_1111d25,1),:,4)=plane_c_dist_1111d25;
distance_circle(1:size(plane_c_dist_1111h14,1),:,5)=plane_c_dist_1111h14;
distance_circle(1:size(plane_c_dist_1111h25,1),:,6)=plane_c_dist_1111h25;
distance_circle(1:size(plane_c_dist_1811c,1),:,7)=plane_c_dist_1811c;
distance_circle(1:size(plane_c_dist_1811d,1),:,8)=plane_c_dist_1811d;
distance_circle(1:size(plane_c_dist_1811e,1),:,9)=plane_c_dist_1811e;
distance_circle(1:size(plane_c_dist_2511d,1),:,10)=plane_c_dist_2511d;
distance_circle(1:size(plane_c_dist_2511e,1),:,11)=plane_c_dist_2511e;
distance_circle(1:size(plane_c_dist_2511f,1),:,12)=plane_c_dist_2511f;
distance_circle(1:size(plane_c_dist_1203d,1),:,13)=plane_c_dist_1203d;
distance_circle(1:size(plane_c_dist_1203e,1),:,14)=plane_c_dist_1203e;
distance_circle(1:size(plane_c_dist_1203f,1),:,15)=plane_c_dist_1203f;
distance_circle(1:size(plane_c_dist_0610e14,1),:,16)=plane_c_dist_0610e14;
distance_circle(1:size(plane_c_dist_0610e25,1),:,17)=plane_c_dist_0610e25;
distance_circle(1:size(plane_c_dist_0610f14,1),:,18)=plane_c_dist_0610f14;
distance_circle(1:size(plane_c_dist_0610f25,1),:,19)=plane_c_dist_0610f25;
distance_circle(1:size(plane_c_dist_2210d14,1),:,20)=plane_c_dist_2210d14;
distance_circle(1:size(plane_c_dist_2210d25,1),:,21)=plane_c_dist_2210d25;
distance_circle(1:size(plane_c_dist_2210e14,1),:,22)=plane_c_dist_2210e14;
distance_circle(1:size(plane_c_dist_2210e25,1),:,23)=plane_c_dist_2210e25;


distance_bg=nan*ones(20,256,23);
distance_bg(1:size(plane_b_dist_1111c14,1),:,1)=plane_b_dist_1111c14;
distance_bg(1:size(plane_b_dist_1111c25,1),:,2)=plane_b_dist_1111c25;
distance_bg(1:size(plane_b_dist_1111d14,1),:,3)=plane_b_dist_1111d14;
distance_bg(1:size(plane_b_dist_1111d25,1),:,4)=plane_b_dist_1111d25;
distance_bg(1:size(plane_b_dist_1111h14,1),:,5)=plane_b_dist_1111h14;
distance_bg(1:size(plane_b_dist_1111h25,1),:,6)=plane_b_dist_1111h25;
distance_bg(1:size(plane_b_dist_1811c,1),:,7)=plane_b_dist_1811c;
distance_bg(1:size(plane_b_dist_1811d,1),:,8)=plane_b_dist_1811d;
distance_bg(1:size(plane_b_dist_1811e,1),:,9)=plane_b_dist_1811e;
distance_bg(1:size(plane_b_dist_2511d,1),:,10)=plane_b_dist_2511d;
distance_bg(1:size(plane_b_dist_2511e,1),:,11)=plane_b_dist_2511e;
distance_bg(1:size(plane_b_dist_2511f,1),:,12)=plane_b_dist_2511f;
distance_bg(1:size(plane_b_dist_1203d,1),:,13)=plane_b_dist_1203d;
distance_bg(1:size(plane_b_dist_1203e,1),:,14)=plane_b_dist_1203e;
distance_bg(1:size(plane_b_dist_1203f,1),:,15)=plane_b_dist_1203f;
distance_bg(1:size(plane_b_dist_0610e14,1),:,16)=plane_b_dist_0610e14;
distance_bg(1:size(plane_b_dist_0610e25,1),:,17)=plane_b_dist_0610e25;
distance_bg(1:size(plane_b_dist_0610f14,1),:,18)=plane_b_dist_0610f14;
distance_bg(1:size(plane_b_dist_0610f25,1),:,19)=plane_b_dist_0610f25;
distance_bg(1:size(plane_b_dist_2210d14,1),:,20)=plane_b_dist_2210d14;
distance_bg(1:size(plane_b_dist_2210d25,1),:,21)=plane_b_dist_2210d25;
distance_bg(1:size(plane_b_dist_2210e14,1),:,22)=plane_b_dist_2210e14;
distance_bg(1:size(plane_b_dist_2210e25,1),:,23)=plane_b_dist_2210e25;


xc=0:0.2:0.2*(size(distance_circle,1)-1);
xb=0:0.2:0.2*(size(distance_bg,1)-1);
x=(10:10:2560)-280;
for i=28:58
    figure;errorbar(xc,nanmean(distance_circle(:,i,:),3),nanstd(distance_circle(:,i,:),0,3)/sqrt(size(distance_circle,3)),'b')
    hold on
    errorbar(xb,nanmean(distance_bg(:,i,:),3),nanstd(distance_bg(:,i,:),0,3)/sqrt(size(distance_bg,3)),'r')
    plot(xb,zeros(1,size(distance_bg,1)),'k')
    xlim([0 2.2])
    ylim([-.5e-3 .5e-3])
    title(['time ',int2str(x(i)),' ms'])
end

time=34:36;
figure;errorbar(xc,nanmean(nanmean(distance_circle(:,time,:),2),3),nanstd(nanmean(distance_circle(:,time,:),2),0,3)/sqrt(size(distance_circle,3)),'b')
hold on
errorbar(xb,nanmean(nanmean(distance_bg(:,time,:),2),3),nanstd(nanmean(distance_bg(:,time,:),2),0,3)/sqrt(size(distance_bg,3)),'r')
xlim([0 2.2])    


distance_circle=nan*ones(12,112,3);
distance_circle(1:size(plane_c_dist_1811,1),:,1)=plane_c_dist_1811;
distance_circle(1:size(plane_c_dist_2511,1),:,2)=plane_c_dist_2511;
distance_circle(1:size(plane_c_dist_1203,1),:,3)=plane_c_dist_1203;

distance_bg=nan*ones(18,112,3);
distance_bg(1:size(plane_b_dist_1811,1),:,1)=plane_b_dist_1811;
distance_bg(1:size(plane_b_dist_2511,1),:,2)=plane_b_dist_2511;
distance_bg(1:size(plane_b_dist_1203,1),:,3)=plane_b_dist_1203;


%% smeagol

plane_c_dist_0501(:,1)=plane_c_dist_0501b14;
plane_c_dist_0501(:,2)=plane_c_dist_0501b25;
plane_c_dist_0501(:,3)=plane_c_dist_0501c;
plane_c_dist_0501(:,4)=plane_c_dist_0501d;


plane_b_dist_0501(:,1)=plane_b_dist_0501b14;
plane_b_dist_0501(:,2)=plane_b_dist_0501b25;
plane_b_dist_0501(:,3)=plane_b_dist_0501c;
plane_b_dist_0501(:,4)=plane_b_dist_0501d;


figure;plot(mean(plane_c_dist_0501,2),'b')
hold on
plot(zeros(1,size(plane_b_dist_0501,1)),'k')
plot(mean(plane_b_dist_0501,2),'r')




distance_circle=nan*ones(14,10);
distance_circle(1:size(plane_c_dist_0501,1),1:4)=plane_c_dist_0501;
distance_circle(1:size(plane_c_dist_2912c14,1),5)=plane_c_dist_2912c14;
distance_circle(1:size(plane_c_dist_2912c25,1),6)=plane_c_dist_2912c25;
distance_circle(1:size(plane_c_dist_2912e14,1),7)=plane_c_dist_2912e14;
distance_circle(1:size(plane_c_dist_2912e25,1),8)=plane_c_dist_2912e25;
distance_circle(1:size(plane_c_dist_2912k14,1),9)=plane_c_dist_2912k14;
distance_circle(1:size(plane_c_dist_2912k25,1),10)=plane_c_dist_2912k25;
%distance_circle(1:size(plane_c_dist_0501e14,1),11)=plane_c_dist_0501e14;
%distance_circle(1:size(plane_c_dist_0501e25,1),12)=plane_c_dist_0501e25;


distance_bg=nan*ones(13,10);
distance_bg(1:size(plane_b_dist_0501,1),1:4)=plane_b_dist_0501;
distance_bg(1:size(plane_b_dist_2912c14,1),5)=plane_b_dist_2912c14;
distance_bg(1:size(plane_b_dist_2912c25,1),6)=plane_b_dist_2912c25;
distance_bg(1:size(plane_b_dist_2912e14,1),7)=plane_b_dist_2912e14;
distance_bg(1:size(plane_b_dist_2912e25,1),8)=plane_b_dist_2912e25;
distance_bg(1:size(plane_b_dist_2912k14,1),9)=plane_b_dist_2912k14;
distance_bg(1:size(plane_b_dist_2912k25,1),10)=plane_b_dist_2912k25;


xc=0:0.2:0.2*(size(distance_circle,1)-1);
xb=0:0.2:0.2*(size(distance_bg,1)-1);

figure;errorbar(xc,nanmean(distance_circle,2),nanstd(distance_circle,0,2)/sqrt(size(distance_circle,2)),'b')
hold on
errorbar(xb,nanmean(distance_bg,2),nanstd(distance_bg,0,2)/sqrt(size(distance_bg,2)),'r')
plot(xb,zeros(1,size(distance_bg,1)),'k')
xlim([0 2.4]);



% PER TIME PER COND

distance_circle_cont=nan*ones(14,256,10);
distance_circle_cont(1:size(plane_cont_c_dist_0501b1,1),:,1)=plane_cont_c_dist_0501b1;
distance_circle_cont(1:size(plane_cont_c_dist_0501b2,1),:,2)=plane_cont_c_dist_0501b2;
distance_circle_cont(1:size(plane_cont_c_dist_0501c,1),:,3)=plane_cont_c_dist_0501c;
distance_circle_cont(1:size(plane_cont_c_dist_0501d,1),:,4)=plane_cont_c_dist_0501d;
distance_circle_cont(1:size(plane_cont_c_dist_2912c1,1),:,5)=plane_cont_c_dist_2912c1;
distance_circle_cont(1:size(plane_cont_c_dist_2912c2,1),:,6)=plane_cont_c_dist_2912c2;
distance_circle_cont(1:size(plane_cont_c_dist_2912e1,1),:,7)=plane_cont_c_dist_2912e1;
distance_circle_cont(1:size(plane_cont_c_dist_2912e2,1),:,8)=plane_cont_c_dist_2912e2;
distance_circle_cont(1:size(plane_cont_c_dist_2912k1,1),:,9)=plane_cont_c_dist_2912k1;
distance_circle_cont(1:size(plane_cont_c_dist_2912k2,1),:,10)=plane_cont_c_dist_2912k2;


distance_circle_non=nan*ones(14,256,10);
distance_circle_non(1:size(plane_non_c_dist_0501b4,1),:,1)=plane_non_c_dist_0501b4;
distance_circle_non(1:size(plane_non_c_dist_0501b5,1),:,2)=plane_non_c_dist_0501b5;
distance_circle_non(1:size(plane_non_c_dist_0501c,1),:,3)=plane_non_c_dist_0501c;
distance_circle_non(1:size(plane_non_c_dist_0501d,1),:,4)=plane_non_c_dist_0501d;
distance_circle_non(1:size(plane_non_c_dist_2912c4,1),:,5)=plane_non_c_dist_2912c4;
distance_circle_non(1:size(plane_non_c_dist_2912c5,1),:,6)=plane_non_c_dist_2912c5;
distance_circle_non(1:size(plane_non_c_dist_2912e4,1),:,7)=plane_non_c_dist_2912e4;
distance_circle_non(1:size(plane_non_c_dist_2912e5,1),:,8)=plane_non_c_dist_2912e5;
distance_circle_non(1:size(plane_non_c_dist_2912k4,1),:,9)=plane_non_c_dist_2912k4;
distance_circle_non(1:size(plane_non_c_dist_2912k5,1),:,10)=plane_non_c_dist_2912k5;




distance_bg_cont=nan*ones(13,256,10);
distance_bg_cont(1:size(plane_cont_b_dist_0501b1,1),:,1)=plane_cont_b_dist_0501b1;
distance_bg_cont(1:size(plane_cont_b_dist_0501b2,1),:,2)=plane_cont_b_dist_0501b2;
distance_bg_cont(1:size(plane_cont_b_dist_0501c,1),:,3)=plane_cont_b_dist_0501c;
distance_bg_cont(1:size(plane_cont_b_dist_0501d,1),:,4)=plane_cont_b_dist_0501d;
distance_bg_cont(1:size(plane_cont_b_dist_2912c1,1),:,5)=plane_cont_b_dist_2912c1;
distance_bg_cont(1:size(plane_cont_b_dist_2912c2,1),:,6)=plane_cont_b_dist_2912c2;
distance_bg_cont(1:size(plane_cont_b_dist_2912e1,1),:,7)=plane_cont_b_dist_2912e1;
distance_bg_cont(1:size(plane_cont_b_dist_2912e2,1),:,8)=plane_cont_b_dist_2912e2;
distance_bg_cont(1:size(plane_cont_b_dist_2912k1,1),:,9)=plane_cont_b_dist_2912k1;
distance_bg_cont(1:size(plane_cont_b_dist_2912k2,1),:,10)=plane_cont_b_dist_2912k2;


distance_bg_non=nan*ones(13,256,10);
distance_bg_non(1:size(plane_non_b_dist_0501b4,1),:,1)=plane_non_b_dist_0501b4;
distance_bg_non(1:size(plane_non_b_dist_0501b5,1),:,2)=plane_non_b_dist_0501b5;
distance_bg_non(1:size(plane_non_b_dist_0501c,1),:,3)=plane_non_b_dist_0501c;
distance_bg_non(1:size(plane_non_b_dist_0501d,1),:,4)=plane_non_b_dist_0501d;
distance_bg_non(1:size(plane_non_b_dist_2912c4,1),:,5)=plane_non_b_dist_2912c4;
distance_bg_non(1:size(plane_non_b_dist_2912c5,1),:,6)=plane_non_b_dist_2912c5;
distance_bg_non(1:size(plane_non_b_dist_2912e4,1),:,7)=plane_non_b_dist_2912e4;
distance_bg_non(1:size(plane_non_b_dist_2912e5,1),:,8)=plane_non_b_dist_2912e5;
distance_bg_non(1:size(plane_non_b_dist_2912k4,1),:,9)=plane_non_b_dist_2912k4;
distance_bg_non(1:size(plane_non_b_dist_2912k5,1),:,10)=plane_non_b_dist_2912k5;





% PER TIME diff

distance_circle=nan*ones(14,256,10);
distance_circle(1:size(plane_c_dist_0501b14,1),:,1)=plane_c_dist_0501b14;
distance_circle(1:size(plane_c_dist_0501b25,1),:,2)=plane_c_dist_0501b25;
distance_circle(1:size(plane_c_dist_0501c15clean,1),:,3)=plane_c_dist_0501c15clean;
distance_circle(1:size(plane_c_dist_0501d15clean,1),:,4)=plane_c_dist_0501d15clean;
distance_circle(1:size(plane_c_dist_2912c14,1),:,5)=plane_c_dist_2912c14;
distance_circle(1:size(plane_c_dist_2912c25,1),:,6)=plane_c_dist_2912c25;
distance_circle(1:size(plane_c_dist_2912e14,1),:,7)=plane_c_dist_2912e14;
distance_circle(1:size(plane_c_dist_2912e25,1),:,8)=plane_c_dist_2912e25;
distance_circle(1:size(plane_c_dist_2912k14,1),:,9)=plane_c_dist_2912k14;
distance_circle(1:size(plane_c_dist_2912k25,1),:,10)=plane_c_dist_2912k25;


distance_bg=nan*ones(13,256,10);
distance_bg(1:size(plane_b_dist_0501b14,1),:,1)=plane_b_dist_0501b14;
distance_bg(1:size(plane_b_dist_0501b25,1),:,2)=plane_b_dist_0501b25;
distance_bg(1:size(plane_b_dist_0501c15clean,1),:,3)=plane_b_dist_0501c15clean;
distance_bg(1:size(plane_b_dist_0501d15clean,1),:,4)=plane_b_dist_0501d15clean;
distance_bg(1:size(plane_b_dist_2912c14,1),:,5)=plane_b_dist_2912c14;
distance_bg(1:size(plane_b_dist_2912c25,1),:,6)=plane_b_dist_2912c25;
distance_bg(1:size(plane_b_dist_2912e14,1),:,7)=plane_b_dist_2912e14;
distance_bg(1:size(plane_b_dist_2912e25,1),:,8)=plane_b_dist_2912e25;
distance_bg(1:size(plane_b_dist_2912k14,1),:,9)=plane_b_dist_2912k14;
distance_bg(1:size(plane_b_dist_2912k25,1),:,10)=plane_b_dist_2912k25;








distance_circle=nan*ones(14,112,2);
distance_circle(1:size(plane_c_dist_0501,1),:,1)=plane_c_dist_0501;
distance_circle(1:size(plane_c_dist_2212,1),:,2)=plane_c_dist_2212;


distance_bg=nan*ones(12,112,2);
distance_bg(1:size(plane_b_dist_0501,1),:,1)=plane_b_dist_0501;
distance_bg(1:size(plane_b_dist_2212,1),:,2)=plane_b_dist_2212;







