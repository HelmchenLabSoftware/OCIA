
n=369;
time=1:94;
time=95:176;
time=177:257;
time=258:340;
time=341:369;

n=240;
time=1:62;
time=63:119;
time=120:173;
time=174:231;
time=232:240;

time=1:240;



n=563;
time=1:117;
time=118:268;
time=269:358;
time=359:450;
time=451:563;

time=1:563;

band=4:9;

x=(1:112)*10-200;
figure
plot(x,squeeze(mean(mean(coher_colin(band,:,time),1),3)),'LineWidth',3)
hold on
plot(x,squeeze(mean(mean(coher_nocolin(band,:,time),1),3)),'r','LineWidth',3)
plot(x,squeeze(mean(mean(coher_blank(band,:,time),1),3)),'g','LineWidth',3)

plot(x,squeeze(mean(mean(coher_colin(band,:,time),1),3))+3*squeeze(std(mean(coher_colin(band,:,time),1),0,3))./(sqrt(size(time,2))-1),'-.b','LineWidth',2)
plot(x,squeeze(mean(mean(coher_colin(band,:,time),1),3))-3*squeeze(std(mean(coher_colin(band,:,time),1),0,3))./(sqrt(size(time,2))-1),'-.b','LineWidth',2)

plot(x,squeeze(mean(mean(coher_nocolin(band,:,time),1),3))+3*squeeze(std(mean(coher_nocolin(band,:,time),1),0,3))./(sqrt(size(time,2))-1),'-.r','LineWidth',2)
plot(x,squeeze(mean(mean(coher_nocolin(band,:,time),1),3))-3*squeeze(std(mean(coher_nocolin(band,:,time),1),0,3))./(sqrt(size(time,2))-1),'-.r','LineWidth',2)

plot(x,squeeze(mean(mean(coher_blank(band,:,time),1),3))+3*squeeze(std(mean(coher_blank(band,:,time),1),0,3))./(sqrt(size(time,2))-1),'-.g','LineWidth',2)
plot(x,squeeze(mean(mean(coher_blank(band,:,time),1),3))-3*squeeze(std(mean(coher_blank(band,:,time),1),0,3))./(sqrt(size(time,2))-1),'-.g','LineWidth',2)

legend('collinear','orthogonal','blank');title('Beta coherence');xlabel('Time (ms)');ylabel('Coherence');xlim([-200 700]);

maxb=max(squeeze(mean(mean(coher_blank(band,1:80,time),1),3))+3*squeeze(std(mean(coher_blank(band,1:80,time),1),0,3))./(sqrt(size(time,2))-1));
minb=min(squeeze(mean(mean(coher_blank(band,1:80,time),1),3))-3*squeeze(std(mean(coher_blank(band,1:80,time),1),0,3))./(sqrt(size(time,2))-1));
cc=zeros(1,112);
cc(:,:)=maxb;
dd=zeros(1,112);
dd(:,:)=minb;

plot(x,cc,'k','LineWidth',1.5)
plot(x,dd,'k','LineWidth',1.5)


