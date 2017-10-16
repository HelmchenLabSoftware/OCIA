cd D:\intrinsic\20150129\mouse_tgg6fl23_2\c\Matt_files
load('time_course_ROIs.mat')
load('trials_ind.mat')

for i=1:size(resp_100_s2,2)
    figure;errorbar(nanmean(resp_100_s2,2),2*nanstd(resp_100_s2,0,2),'k')
    hold on
    plot(resp_100_s2(:,i),'r')
end

tr_bad_100=[24 41];
tr_100_c=ones(1,size(resp_100_s1,2));
tr_100_c(tr_bad_100)=0;
tr_100_clean=tr_100(tr_100_c==1);


for i=1:size(resp_1200_s2,2)
    figure;errorbar(nanmean(resp_1200_s2,2),2*nanstd(resp_1200_s2,0,2),'k')
    hold on
    plot(resp_1200_s2(:,i),'r')
end

tr_bad_1200=[8 27];
tr_1200_c=ones(1,size(resp_1200_s1,2));
tr_1200_c(tr_bad_1200)=0;
tr_1200_clean=tr_1200(tr_1200_c==1);


% for i=1:size(resp_000_s1,2)
%     figure;errorbar(nanmean(resp_000_s1,2),2*nanstd(resp_000_s1,0,2),'k')
%     hold on
%     plot(resp_000_s1(:,i),'r')
% end
% 
% tr_bad_000=[12 15];
% tr_000_c=ones(1,size(resp_000_s1,2));
% tr_000_c(tr_bad_000)=0;
% tr_000_clean=tr_000(tr_000_c==1);


save trials_ind_clean tr_bad* tr_1200_clean tr_100_clean % tr_000_clean


resp_100_s1=resp_100_s1(:,tr_100_c==1);
resp_100_m1=resp_100_m1(:,tr_100_c==1);
resp_100_s2=resp_100_s2(:,tr_100_c==1);
resp_100_a1=resp_100_a1(:,tr_100_c==1);
resp_100_alm=resp_100_alm(:,tr_100_c==1);

resp_1200_s1=resp_1200_s1(:,tr_1200_c==1);
resp_1200_m1=resp_1200_m1(:,tr_1200_c==1);
resp_1200_s2=resp_1200_s2(:,tr_1200_c==1);
resp_1200_a1=resp_1200_a1(:,tr_1200_c==1);
resp_1200_alm=resp_1200_alm(:,tr_1200_c==1);

% resp_000_s1=resp_000_s1(:,tr_000_c==1);
% resp_000_m1=resp_000_m1(:,tr_000_c==1);
% resp_000_s2=resp_000_s2(:,tr_000_c==1);
% resp_000_a1=resp_000_a1(:,tr_000_c==1);
% resp_000_alm=resp_000_alm(:,tr_000_c==1);

save time_course_ROIs_clean resp_*

%%
load('time_course_ROIs_clean.mat')
x=(1:180)*0.05-2.7;
x=x(1:3:180);

figure;errorbar(x,nanmean(resp_100_s1,2),nanstd(resp_100_s1,0,2)/sqrt(size(resp_100_s1,2)))
hold on
errorbar(x,nanmean(resp_1200_s1,2),nanstd(resp_1200_s1,0,2)/sqrt(size(resp_1200_s1,2)),'c')
%errorbar(x,nanmean(resp_000_s1,2),nanstd(resp_000_s1,0,2)/sqrt(size(resp_000_s1,2)),'k')

figure;errorbar(x,nanmean(resp_100_m1,2),nanstd(resp_100_m1,0,2)/sqrt(size(resp_100_m1,2)),'r')
hold on
errorbar(x,nanmean(resp_1200_m1,2),nanstd(resp_1200_m1,0,2)/sqrt(size(resp_1200_m1,2)),'m')

figure;errorbar(x,nanmean(resp_100_s2,2),nanstd(resp_100_s2,0,2)/sqrt(size(resp_100_s2,2)),'g')
hold on
errorbar(x,nanmean(resp_1200_s2,2),nanstd(resp_1200_s2,0,2)/sqrt(size(resp_1200_s2,2)),'y')

figure;errorbar(x,nanmean(resp_100_a1,2),nanstd(resp_100_a1,0,2)/sqrt(size(resp_100_a1,2)),'b')
hold on
errorbar(x,nanmean(resp_1200_a1,2),nanstd(resp_1200_a1,0,2)/sqrt(size(resp_1200_a1,2)),'c')

figure;errorbar(x,nanmean(resp_100_alm,2),nanstd(resp_100_alm,0,2)/sqrt(size(resp_100_alm,2)),'r')
hold on
errorbar(x,nanmean(resp_1200_alm,2),nanstd(resp_1200_alm,0,2)/sqrt(size(resp_1200_alm,2)),'m')
%errorbar(x,nanmean(resp_000_alm,2),nanstd(resp_000_alm,0,2)/sqrt(size(resp_000_alm,2)),'k')


figure;errorbar(x,nanmean(resp_100_m2,2),nanstd(resp_100_m2,0,2)/sqrt(size(resp_100_m2,2)),'k')
hold on
errorbar(x,nanmean(resp_1200_m2,2),nanstd(resp_1200_m2,0,2)/sqrt(size(resp_1200_m2,2)),'b')




figure;plot(x,nanmean(resp_100_s1,2)-nanmean(resp_1200_s1,2),'b')
hold on
plot(x,nanmean(resp_100_s2,2)-nanmean(resp_1200_s2,2),'c')
plot(x,nanmean(resp_100_m1,2)-nanmean(resp_1200_m1,2),'r')
plot(x,nanmean(resp_100_m2,2)-nanmean(resp_1200_m2,2),'k')
plot(x,nanmean(resp_100_alm,2)-nanmean(resp_1200_alm,2),'m')
plot(x,nanmean(resp_100_a1,2)-nanmean(resp_1200_a1,2),'g')
legend('s1','s2','m1','m2','alm','a1')
plot(x,zeros(1,60),'k')














