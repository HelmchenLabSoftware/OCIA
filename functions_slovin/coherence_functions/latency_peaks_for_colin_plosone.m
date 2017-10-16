

%alpha
[ac i]=max(squeeze(mean(coher_colin_V1(4:9,20:40,:),1)));
[an j]=max(squeeze(mean(coher_nocolin_V1(4:9,20:40,:),1)));
l=j-i; %latency between peaks
[n x]=hist(l,-30:0.5:30);
figure
bar(-300:5:300,n/size(l,2))
%xlim([-50 150])
%ylim([0 0.35])
xlim([-200 200])
ylim([0 0.15])
signrank(l)

%alpha
[ac i]=max(squeeze(mean(coher_colin_V1_2(4:9,20:40,:),1)));
[an j]=max(squeeze(mean(coher_nocolin_V1_2(4:9,20:40,:),1)));
l=j-i; %latency between peaks
[n x]=hist(l,-30:0.5:30);
figure
bar(-300:5:300,n/size(l,2))
%xlim([-50 150])
%ylim([0 0.35])
xlim([-200 200])
ylim([0 0.1])
signrank(l)

%alpha
% [ac i]=max(squeeze(mean(coher_colin_V2(4:9,20:40,:),1)));
% [an j]=max(squeeze(mean(coher_nocolin_V2(4:9,20:40,:),1)));
% l=j-i; %latency between peaks
% [n x]=hist(l,-30:0.5:30);
% figure
% bar(-300:5:300,n/size(l,2))
% xlim([-50 150])
% ylim([0 0.35])
% signrank(l)


%alpha
[ac i]=max(squeeze(mean(coher_V1_V2tar_colin(4:9,20:40,:),1)));
[an j]=max(squeeze(mean(coher_V1_V2tar_nocolin(4:9,20:40,:),1)));
l=j-i; %latency between peaks
[n x]=hist(l,-30:0.5:30);
figure
bar(-300:5:300,n/size(l,2))
%xlim([-50 150])
%ylim([0 0.35])
xlim([-200 200])
ylim([0 0.1])
signrank(l)


%alpha
[ac i]=max(squeeze(mean(coher_V1_V2flan_colin(4:9,20:40,:),1)));
[an j]=max(squeeze(mean(coher_V1_V2flan_nocolin(4:9,20:40,:),1)));
l=j-i; %latency between peaks
[n x]=hist(l,-30:0.5:30);
figure
bar(-300:5:300,n/size(l,2))
%xlim([-50 150])
%ylim([0 0.35])
xlim([-200 200])
ylim([0 0.1])
signrank(l)




