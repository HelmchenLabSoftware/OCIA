


x7=-250:10:250;
vband=10:15;
lband=4:7;
figure;
errorbar(x7,squeeze(mean(mean(mean(cov_cond3(vband,lband,:,:),1),2),3)),squeeze(std(mean(mean(cov_cond3(vband,lband,:,:),1),2),0,3))/sqrt(size(cov_cond3,3)),'LineWidth',2)
ylim([-0.1 0.1])
xlim([-150 150])
hold on
figure;
lband=8:12;
errorbar(x7,squeeze(mean(mean(mean(cov_cond3(vband,lband,:,:),1),2),3)),squeeze(std(mean(mean(cov_cond3(vband,lband,:,:),1),2),0,3))/sqrt(size(cov_cond3,3)),'LineWidth',2)
ylim([-0.1 0.1])
xlim([-150 150])
figure;
lband=13:25;
errorbar(x7,squeeze(mean(mean(mean(cov_cond3(vband,lband,:,:),1),2),3)),squeeze(std(mean(mean(cov_cond3(vband,lband,:,:),1),2),0,3))/sqrt(size(cov_cond3,3)),'LineWidth',2)
ylim([-0.1 0.1])
xlim([-150 150])
figure;
lband=31:64;
errorbar(x7,squeeze(mean(mean(mean(cov_cond3(vband,lband,:,:),1),2),3)),squeeze(std(mean(mean(cov_cond3(vband,lband,:,:),1),2),0,3))/sqrt(size(cov_cond3,3)),'LineWidth',2)
ylim([-0.1 0.1])
xlim([-150 150])


x7=-250:10:250;
vband=4:9;
lband=13:25;
figure;
plot(x7,squeeze(mean(mean(mean(cov_cond3a(vband,lband,:,:),1),2),3)),'LineWidth',2);
ylim([-0.15 0.15])
xlim([-250 250])
hold on
plot(x7,squeeze(mean(mean(mean(cov_cond3b(vband,lband,:,:),1),2),3)),'r','LineWidth',2);
plot(x7,squeeze(mean(mean(mean(cov_cond3aa(vband,lband,:,:),1),2),3)),'g','LineWidth',2);
plot(x7,squeeze(mean(mean(mean(cov_cond3c(vband,lband,:,:),1),2),3)),'c','LineWidth',2);
plot(x7,squeeze(mean(mean(mean(cov_cond3d(vband,lband,:,:),1),2),3)),'m','LineWidth',2);
plot(x7,squeeze(mean(mean(mean(cov_cond3e(vband,lband,:,:),1),2),3)),'k','LineWidth',2);
plot(x7,squeeze(mean(mean(mean(cov_cond3f(vband,lband,:,:),1),2),3)),'y','LineWidth',2);




%
x7=-250:10:250;
vband=4:9;
lband=13:25;
figure;
plot(x7,squeeze(mean(mean(cov_cond3a(vband,lband,:,:),1),2)),'b','LineWidth',2);
ylim([-0.5 0.5])
xlim([-250 250])
hold on
plot(x7,squeeze(mean(mean(cov_cond3b(vband,lband,:,:),1),2)),'r','LineWidth',2);
plot(x7,squeeze(mean(mean(cov_cond3aa(vband,lband,:,:),1),2)),'g','LineWidth',2);
plot(x7,squeeze(mean(mean(cov_cond3c(vband,lband,:,:),1),2)),'c','LineWidth',2);
plot(x7,squeeze(mean(mean(cov_cond3d(vband,lband,:,:),1),2)),'m','LineWidth',2);
plot(x7,squeeze(mean(mean(cov_cond3e(vband,lband,:,:),1),2)),'k','LineWidth',2);
plot(x7,squeeze(mean(mean(cov_cond3f(vband,lband,:,:),1),2)),'y','LineWidth',2);


for t=1:22
    figure;plot(x7,squeeze(mean(mean(cov_cond3c(vband,lband,t,:),1),2)),'m','LineWidth',2);
end



for i=1:51
    p(i)=signrank(squeeze(mean(mean(cov_cond3(vband,lband,:,i),1),2)));
end   

x7(p<0.05)




