


x2=(1:459)*4-(420+25); %for collinear
figure;errorbar(x2(100:225),nanmean(mean(spect_4(13:25,100:225,:),1),3),nanstd(mean(spect_4(13:25,100:225,:),1),0,3)/sqrt(size(spect_4,3)))
hold on
errorbar(x2(100:225),nanmean(mean(spect_3(13:25,100:225,:),1),3),nanstd(mean(spect_3(13:25,100:225,:),1),0,3)/sqrt(size(spect_3,3)),'r')
errorbar(x2(100:225),nanmean(mean(spect_6(13:25,100:225,:),1),3),nanstd(mean(spect_6(13:25,100:225,:),1),0,3)/sqrt(size(spect_6,3)),'g')

x2=(1:459)*4-(420+25); %for collinear
figure;errorbar(x2(100:225),nanmean(mean(spect_4(31:64,100:225,:),1),3),nanstd(mean(spect_4(31:64,100:225,:),1),0,3)/sqrt(size(spect_4,3)))
hold on
errorbar(x2(100:225),nanmean(mean(spect_3(31:64,100:225,:),1),3),nanstd(mean(spect_3(31:64,100:225,:),1),0,3)/sqrt(size(spect_3,3)),'r')
errorbar(x2(100:225),nanmean(mean(spect_6(31:64,100:225,:),1),3),nanstd(mean(spect_6(31:64,100:225,:),1),0,3)/sqrt(size(spect_6,3)),'g')

x2=(1:459)*4-(420+25); %for collinear
figure;errorbar(x2(100:225),nanmean(mean(spect_4(8:12,100:225,:),1),3),nanstd(mean(spect_4(8:12,100:225,:),1),0,3)/sqrt(size(spect_4,3)))
hold on
errorbar(x2(100:225),nanmean(mean(spect_3(8:12,100:225,:),1),3),nanstd(mean(spect_3(8:12,100:225,:),1),0,3)/sqrt(size(spect_3,3)),'r')
errorbar(x2(100:225),nanmean(mean(spect_6(8:12,100:225,:),1),3),nanstd(mean(spect_6(8:12,100:225,:),1),0,3)/sqrt(size(spect_6,3)),'g')

x2=(1:459)*4-(420+25); %for collinear
figure;errorbar(x2(100:225),nanmean(mean(spect_4(4:7,100:225,:),1),3),nanstd(mean(spect_4(4:7,100:225,:),1),0,3)/sqrt(size(spect_4,3)))
hold on
errorbar(x2(100:225),nanmean(mean(spect_3(4:7,100:225,:),1),3),nanstd(mean(spect_3(4:7,100:225,:),1),0,3)/sqrt(size(spect_3,3)),'r')
errorbar(x2(100:225),nanmean(mean(spect_6(4:7,100:225,:),1),3),nanstd(mean(spect_6(4:7,100:225,:),1),0,3)/sqrt(size(spect_6,3)),'g')


x2=(1:459)*4-(420+25); %for collinear
figure;errorbar(x2(100:225),nanmean(mean(spect_4(6,100:225,:),1),3),nanstd(mean(spect_4(6,100:225,:),1),0,3)/sqrt(size(spect_4,3)))
hold on
errorbar(x2(100:225),nanmean(mean(spect_3(6,100:225,:),1),3),nanstd(mean(spect_3(6,100:225,:),1),0,3)/sqrt(size(spect_3,3)),'r')
errorbar(x2(100:225),nanmean(mean(spect_6(6,100:225,:),1),3),nanstd(mean(spect_6(6,100:225,:),1),0,3)/sqrt(size(spect_6,3)),'g')


figure;imagesc(nanmean(spect_4,3)-nanmean(spect_3,3),[-3 3])


figure;imagesc(nanmean(spect_4,3),[-4 10])
figure;imagesc(nanmean(spect_3,3),[-4 10])




spect_4=cat(3,spect_4_1402b,spect_4_1402c,spect_4_0702b,spect_4_0702c,spect_4_0702d,spect_4_1601b);
spect_3=cat(3,spect_3_1402b,spect_3_1402c,spect_3_0702b,spect_3_0702c,spect_3_0702d,spect_3_1601b);
spect_6=cat(3,spect_6_1402b,spect_6_1402c,spect_6_0702b,spect_6_0702c,spect_6_0702d,spect_6_1601b);




%%
x=(1:626)*4-500;
figure
errorbar(x(100:225),mean(colin(100:225,:),2),std(colin(100:225,:),0,2)./sqrt(size(colin,2)))
hold on
errorbar(x(100:225),mean(nocolin(100:225,:),2),std(nocolin(100:225,:),0,2)./sqrt(size(nocolin,2)),'r')
errorbar(x(100:225),mean(blank(100:225,:),2),std(blank(100:225,:),0,2)./sqrt(size(blank,2)),'g')
title('LFP signal');
legend('collinear','orthogonal','blank');xlim([-100 400]);xlabel('Time (ms)');ylabel('AD units');








