





figure;
scatter(mean(mean(coher_nocolin_V1(4:9,20:30,:),1),2),mean(mean(coher_colin_V1(4:9,20:30,:),1),2))
%xlim([0 0.6]);ylim([0 0.6])
xlim([0 0.18]);ylim([0 0.18])
hold on
plot(0:0.01:1,0:0.01:1,'k')
axis square


figure;
scatter(mean(mean(coher_nocolin_V1_2(4:9,20:30,:),1),2),mean(mean(coher_colin_V1_2(4:9,20:30,:),1),2))
%xlim([0 0.6]);ylim([0 0.6])
xlim([0 0.12]);ylim([0 0.12])
hold on
plot(0:0.01:1,0:0.01:1,'k')
axis square



% figure;
% scatter(mean(mean(coher_nocolin_V2(4:9,20:30,:),1),2),mean(mean(coher_colin_V2(4:9,20:30,:),1),2))
% xlim([0 0.6]);ylim([0 0.6])
% hold on
% plot(0:0.01:1,0:0.01:1,'k')



figure;
scatter(mean(mean(coher_V1_V2tar_nocolin(4:9,20:30,:),1),2),mean(mean(coher_V1_V2tar_colin(4:9,20:30,:),1),2))
%xlim([0 0.6]);ylim([0 0.6])
xlim([0 0.08]);ylim([0 0.08])
hold on
plot(0:0.01:1,0:0.01:1,'k')
axis square

ranksum(squeeze(mean(mean(coher_V1_V2tar_nocolin(4:9,20:30,:),1),2)),squeeze(mean(mean(coher_V1_V2tar_colin(4:9,20:30,:),1),2)))




figure;
scatter(mean(mean(coher_V1_V2flan_nocolin(4:9,20:30,:),1),2),mean(mean(coher_V1_V2flan_colin(4:9,20:30,:),1),2))
%xlim([0 0.6]);ylim([0 0.6])
xlim([0 0.1]);ylim([0 0.1])
hold on
plot(0:0.01:1,0:0.01:1,'k')
axis square

ranksum(squeeze(mean(mean(coher_V1_V2flan_nocolin(4:9,20:30,:),1),2)),squeeze(mean(mean(coher_V1_V2flan_colin(4:9,20:30,:),1),2)))









