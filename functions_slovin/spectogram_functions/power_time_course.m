
%%

a1804=a(roi_V1,:,:);
b1804=b(roi_V1,:,:);
c1804=c(roi_V1,:,:);


a1203=a(roi_V1,:,:);
b1203=b(roi_V1,:,:);
c1203=c(roi_V1,:,:);


a1005b=a(roi_V1,:,:);
b1005b=b(roi_V1,:,:);
c1005b=c(roi_V1,:,:);


a1005e=a(roi_V1,:,:);
b1005e=b(roi_V1,:,:);
c1005e=c(roi_V1,:,:);


a2011=a(roi_V1,:,:);
b2011=b(roi_V1,:,:);
c2011=c(roi_V1,:,:);


power_colin=cat(1,a1804,a1203,a1005b,a1005e,a2011);
power_colin=shiftdim(power_colin,1);
power_nocolin=cat(1,b1804,b1203,b1005b,b1005e,b2011);
power_nocolin=shiftdim(power_nocolin,1);
power_blank=cat(1,c1804,c1203,c1005b,c1005e,c2011);
power_blank=shiftdim(power_blank,1);



%%

f=(1:32)*50/32;
x=(20:10:1130)-200;
n=size(power_blank,3);
figure
plot(x,squeeze(mean(mean(power_colin(4:9,:,:),1),3)),'LineWidth',3)
hold on
plot(x,squeeze(mean(mean(power_nocolin(4:9,:,:),1),3)),'r','LineWidth',3)
plot(x,squeeze(mean(mean(power_blank(4:9,:,:),1),3)),'g','LineWidth',3)

plot(x,squeeze(mean(mean(power_colin(4:9,:,:),1),3))+squeeze(std(mean(power_colin(4:9,:,:),1),0,3))./(sqrt(n)-1),'-.b','LineWidth',2)
plot(x,squeeze(mean(mean(power_colin(4:9,:,:),1),3))-squeeze(std(mean(power_colin(4:9,:,:),1),0,3))./(sqrt(n)-1),'-.b','LineWidth',2)

plot(x,squeeze(mean(mean(power_nocolin(4:9,:,:),1),3))+squeeze(std(mean(power_nocolin(4:9,:,:),1),0,3))./(sqrt(n)-1),'-.r','LineWidth',2)
plot(x,squeeze(mean(mean(power_nocolin(4:9,:,:),1),3))-squeeze(std(mean(power_nocolin(4:9,:,:),1),0,3))./(sqrt(n)-1),'-.r','LineWidth',2)

plot(x,squeeze(mean(mean(power_blank(4:9,:,:),1),3))+squeeze(std(mean(power_blank(4:9,:,:),1),0,3))./(sqrt(n)-1),'-.g','LineWidth',2)
plot(x,squeeze(mean(mean(power_blank(4:9,:,:),1),3))-squeeze(std(mean(power_blank(4:9,:,:),1),0,3))./(sqrt(n)-1),'-.g','LineWidth',2)

legend('collinear','orthogonal','blank');title('Alpha power');xlabel('Time (ms)');ylabel('power');xlim([-200 700]);

maxb=max(squeeze(mean(mean(power_blank(4:9,1:50,:),1),3))+squeeze(std(mean(power_blank(4:9,1:50,:),1),0,3))./(sqrt(n)-1));
minb=min(squeeze(mean(mean(power_blank(4:9,1:50,:),1),3))-squeeze(std(mean(power_blank(4:9,1:50,:),1),0,3))./(sqrt(n)-1));
cc=zeros(1,112);
cc(:,:)=maxb;
dd=zeros(1,112);
dd(:,:)=minb;

plot(x,cc,'k','LineWidth',1.5)
plot(x,dd,'k','LineWidth',1.5)
xlim([-100 300])



figure
plot(x,squeeze(mean(mean(power_colin(10:15,:,:),1),3)),'LineWidth',3)
hold on
plot(x,squeeze(mean(mean(power_nocolin(10:15,:,:),1),3)),'r','LineWidth',3)
plot(x,squeeze(mean(mean(power_blank(10:15,:,:),1),3)),'g','LineWidth',3)

plot(x,squeeze(mean(mean(power_colin(10:15,:,:),1),3))+3*squeeze(std(mean(power_colin(10:15,:,:),1),0,3))./(sqrt(n)-1),'-.b','LineWidth',2)
plot(x,squeeze(mean(mean(power_colin(10:15,:,:),1),3))-3*squeeze(std(mean(power_colin(10:15,:,:),1),0,3))./(sqrt(n)-1),'-.b','LineWidth',2)

plot(x,squeeze(mean(mean(power_nocolin(10:15,:,:),1),3))+3*squeeze(std(mean(power_nocolin(10:15,:,:),1),0,3))./(sqrt(n)-1),'-.r','LineWidth',2)
plot(x,squeeze(mean(mean(power_nocolin(10:15,:,:),1),3))-3*squeeze(std(mean(power_nocolin(10:15,:,:),1),0,3))./(sqrt(n)-1),'-.r','LineWidth',2)

plot(x,squeeze(mean(mean(power_blank(10:15,:,:),1),3))+3*squeeze(std(mean(power_blank(10:15,:,:),1),0,3))./(sqrt(n)-1),'-.g','LineWidth',2)
plot(x,squeeze(mean(mean(power_blank(10:15,:,:),1),3))-3*squeeze(std(mean(power_blank(10:15,:,:),1),0,3))./(sqrt(n)-1),'-.g','LineWidth',2)

legend('collinear','orthogonal','blank');title('Beta power');xlabel('Time (ms)');ylabel('power');xlim([-200 700]);

maxb=max(squeeze(mean(mean(power_blank(10:15,1:50,:),1),3))+3*squeeze(std(mean(power_blank(10:15,1:50,:),1),0,3))./(sqrt(n)-1));
minb=min(squeeze(mean(mean(power_blank(10:15,1:50,:),1),3))-3*squeeze(std(mean(power_blank(10:15,1:50,:),1),0,3))./(sqrt(n)-1));
cc=zeros(1,112);
cc(:,:)=maxb;
dd=zeros(1,112);
dd(:,:)=minb;

plot(x,cc,'k','LineWidth',1.5)
plot(x,dd,'k','LineWidth',1.5)
xlim([-100 300])



figure
plot(x,squeeze(mean(mean(power_colin(16:32,:,:),1),3)),'LineWidth',3)
hold on
plot(x,squeeze(mean(mean(power_nocolin(16:32,:,:),1),3)),'r','LineWidth',3)
plot(x,squeeze(mean(mean(power_blank(16:32,:,:),1),3)),'g','LineWidth',3)

plot(x,squeeze(mean(mean(power_colin(16:32,:,:),1),3))+3*squeeze(std(mean(power_colin(16:32,:,:),1),0,3))./(sqrt(n)-1),'-.b','LineWidth',2)
plot(x,squeeze(mean(mean(power_colin(16:32,:,:),1),3))-3*squeeze(std(mean(power_colin(16:32,:,:),1),0,3))./(sqrt(n)-1),'-.b','LineWidth',2)

plot(x,squeeze(mean(mean(power_nocolin(16:32,:,:),1),3))+3*squeeze(std(mean(power_nocolin(16:32,:,:),1),0,3))./(sqrt(n)-1),'-.r','LineWidth',2)
plot(x,squeeze(mean(mean(power_nocolin(16:32,:,:),1),3))-3*squeeze(std(mean(power_nocolin(16:32,:,:),1),0,3))./(sqrt(n)-1),'-.r','LineWidth',2)

plot(x,squeeze(mean(mean(power_blank(16:32,:,:),1),3))+3*squeeze(std(mean(power_blank(16:32,:,:),1),0,3))./(sqrt(n)-1),'-.g','LineWidth',2)
plot(x,squeeze(mean(mean(power_blank(16:32,:,:),1),3))-3*squeeze(std(mean(power_blank(16:32,:,:),1),0,3))./(sqrt(n)-1),'-.g','LineWidth',2)

legend('collinear','orthogonal','blank');title('gamma powerence');xlabel('Time (ms)');ylabel('powerence');xlim([-200 700]);

maxb=max(squeeze(mean(mean(power_blank(16:32,1:50,:),1),3))+3*squeeze(std(mean(power_blank(16:32,1:50,:),1),0,3))./(sqrt(n)-1));
minb=min(squeeze(mean(mean(power_blank(16:32,1:50,:),1),3))-3*squeeze(std(mean(power_blank(16:32,1:50,:),1),0,3))./(sqrt(n)-1));
cc=zeros(1,112);
cc(:,:)=maxb;
dd=zeros(1,112);
dd(:,:)=minb;

plot(x,cc,'k','LineWidth',1.5)
plot(x,dd,'k','LineWidth',1.5)
xlim([-100 300])








%%

x=(1:459)*4-(420+25); %for collinear
f=(1:64)*125/64;

n=size(spect_blank,3);
figure
plot(x,squeeze(mean(mean(spect_colin(8:12,:,:),1),3)),'LineWidth',3)
hold on
plot(x,squeeze(mean(mean(spect_nocolin(8:12,:,:),1),3)),'r','LineWidth',3)
plot(x,squeeze(mean(mean(spect_blank(8:12,:,:),1),3)),'g','LineWidth',3)

plot(x,squeeze(mean(mean(spect_colin(8:12,:,:),1),3))+squeeze(std(mean(spect_colin(8:12,:,:),1),0,3))./(sqrt(n)-1),'-.b','LineWidth',2)
plot(x,squeeze(mean(mean(spect_colin(8:12,:,:),1),3))-squeeze(std(mean(spect_colin(8:12,:,:),1),0,3))./(sqrt(n)-1),'-.b','LineWidth',2)

plot(x,squeeze(mean(mean(spect_nocolin(8:12,:,:),1),3))+squeeze(std(mean(spect_nocolin(8:12,:,:),1),0,3))./(sqrt(n)-1),'-.r','LineWidth',2)
plot(x,squeeze(mean(mean(spect_nocolin(8:12,:,:),1),3))-squeeze(std(mean(spect_nocolin(8:12,:,:),1),0,3))./(sqrt(n)-1),'-.r','LineWidth',2)

plot(x,squeeze(mean(mean(spect_blank(8:12,:,:),1),3))+squeeze(std(mean(spect_blank(8:12,:,:),1),0,3))./(sqrt(n)-1),'-.g','LineWidth',2)
plot(x,squeeze(mean(mean(spect_blank(8:12,:,:),1),3))-squeeze(std(mean(spect_blank(8:12,:,:),1),0,3))./(sqrt(n)-1),'-.g','LineWidth',2)

legend('collinear','orthogonal','blank');title('Alpha spect');xlabel('Time (ms)');ylabel('spect');xlim([-200 700]);

maxb=max(squeeze(mean(mean(spect_blank(8:12,86:187,:),1),3))+squeeze(std(mean(spect_blank(8:12,86:187,:),1),0,3))./(sqrt(n)-1));
minb=min(squeeze(mean(mean(spect_blank(8:12,86:187,:),1),3))-squeeze(std(mean(spect_blank(8:12,86:187,:),1),0,3))./(sqrt(n)-1));
cc=zeros(1,459);
cc(:,:)=maxb;
dd=zeros(1,459);
dd(:,:)=minb;

plot(x,cc,'k','LineWidth',1.5)
plot(x,dd,'k','LineWidth',1.5)
xlim([-100 300])











