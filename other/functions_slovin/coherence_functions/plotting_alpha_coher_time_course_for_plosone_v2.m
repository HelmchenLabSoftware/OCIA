n=1:size(coher_colin_V1,3);
n2=1:size(coher_blank_V1,3);

band=4:9;

x=(1:112)*10-200;
figure
plot(x,squeeze(mean(mean(coher_colin_V1(band,:,n),1),3)),'LineWidth',3)
hold on
plot(x,squeeze(mean(mean(coher_nocolin_V1(band,:,n),1),3)),'r','LineWidth',3)
plot(x,squeeze(mean(mean(coher_blank_V1(band,:,n2),1),3)),'g','LineWidth',3)

plot(x,squeeze(mean(mean(coher_colin_V1(band,:,n),1),3))+3*squeeze(std(mean(coher_colin_V1(band,:,n),1),0,3))./(sqrt(size(n,2))-1),'-.b','LineWidth',2)
plot(x,squeeze(mean(mean(coher_colin_V1(band,:,n),1),3))-3*squeeze(std(mean(coher_colin_V1(band,:,n),1),0,3))./(sqrt(size(n,2))-1),'-.b','LineWidth',2)

plot(x,squeeze(mean(mean(coher_nocolin_V1(band,:,n),1),3))+3*squeeze(std(mean(coher_nocolin_V1(band,:,n),1),0,3))./(sqrt(size(n,2))-1),'-.r','LineWidth',2)
plot(x,squeeze(mean(mean(coher_nocolin_V1(band,:,n),1),3))-3*squeeze(std(mean(coher_nocolin_V1(band,:,n),1),0,3))./(sqrt(size(n,2))-1),'-.r','LineWidth',2)

plot(x,squeeze(mean(mean(coher_blank_V1(band,:,n2),1),3))+3*squeeze(std(mean(coher_blank_V1(band,:,n2),1),0,3))./(sqrt(size(n,2))-1),'-.g','LineWidth',2)
plot(x,squeeze(mean(mean(coher_blank_V1(band,:,n2),1),3))-3*squeeze(std(mean(coher_blank_V1(band,:,n2),1),0,3))./(sqrt(size(n,2))-1),'-.g','LineWidth',2)

legend('collinear','orthogonal','blank')
xlim([-100 300]);
ylim([0 0.4]);
%ylim([0 0.1]);

top=prctile(reshape(squeeze(mean(coher_blank_V1(band,1:80,:),1)),[1,80*size(coher_blank_V1,3)]),95);
bottom=prctile(reshape(squeeze(mean(coher_blank_V1(band,1:80,:),1)),[1,80*size(coher_blank_V1,3)]),5);
plot(x,top*ones(1,112),'k','LineWidth',1.5)
plot(x,bottom*ones(1,112),'k','LineWidth',1.5)



n=1:size(coher_colin_V1_2,3);
n2=1:size(coher_blank_V1_2,3);

band=4:9;

x=(1:112)*10-200;
figure
plot(x,squeeze(mean(mean(coher_colin_V1_2(band,:,n),1),3)),'LineWidth',3)
hold on
plot(x,squeeze(mean(mean(coher_nocolin_V1_2(band,:,n),1),3)),'r','LineWidth',3)
plot(x,squeeze(mean(mean(coher_blank_V1_2(band,:,n2),1),3)),'g','LineWidth',3)

plot(x,squeeze(mean(mean(coher_colin_V1_2(band,:,n),1),3))+3*squeeze(std(mean(coher_colin_V1_2(band,:,n),1),0,3))./(sqrt(size(n,2))-1),'-.b','LineWidth',2)
plot(x,squeeze(mean(mean(coher_colin_V1_2(band,:,n),1),3))-3*squeeze(std(mean(coher_colin_V1_2(band,:,n),1),0,3))./(sqrt(size(n,2))-1),'-.b','LineWidth',2)

plot(x,squeeze(mean(mean(coher_nocolin_V1_2(band,:,n),1),3))+3*squeeze(std(mean(coher_nocolin_V1_2(band,:,n),1),0,3))./(sqrt(size(n,2))-1),'-.r','LineWidth',2)
plot(x,squeeze(mean(mean(coher_nocolin_V1_2(band,:,n),1),3))-3*squeeze(std(mean(coher_nocolin_V1_2(band,:,n),1),0,3))./(sqrt(size(n,2))-1),'-.r','LineWidth',2)

plot(x,squeeze(mean(mean(coher_blank_V1_2(band,:,n2),1),3))+3*squeeze(std(mean(coher_blank_V1_2(band,:,n2),1),0,3))./(sqrt(size(n,2))-1),'-.g','LineWidth',2)
plot(x,squeeze(mean(mean(coher_blank_V1_2(band,:,n2),1),3))-3*squeeze(std(mean(coher_blank_V1_2(band,:,n2),1),0,3))./(sqrt(size(n,2))-1),'-.g','LineWidth',2)

legend('collinear','orthogonal','blank')
xlim([-100 300]);
ylim([0 0.4]);
%ylim([0 0.06]);

top=prctile(reshape(squeeze(mean(coher_blank_V1_2(band,1:80,:),1)),[1,80*size(coher_blank_V1_2,3)]),95);
bottom=prctile(reshape(squeeze(mean(coher_blank_V1_2(band,1:80,:),1)),[1,80*size(coher_blank_V1_2,3)]),5);
plot(x,top*ones(1,112),'k','LineWidth',1.5)
plot(x,bottom*ones(1,112),'k','LineWidth',1.5)





n=1:size(coher_V1_V2tar_colin,3);
n2=1:size(coher_V1_V2tar_blank,3);

band=4:9;

x=(1:112)*10-200;
figure
plot(x,squeeze(mean(mean(coher_V1_V2tar_colin(band,:,n),1),3)),'LineWidth',3)
hold on
plot(x,squeeze(mean(mean(coher_V1_V2tar_nocolin(band,:,n),1),3)),'r','LineWidth',3)
plot(x,squeeze(mean(mean(coher_V1_V2tar_blank(band,:,n2),1),3)),'g','LineWidth',3)

plot(x,squeeze(mean(mean(coher_V1_V2tar_colin(band,:,n),1),3))+3*squeeze(std(mean(coher_V1_V2tar_colin(band,:,n),1),0,3))./(sqrt(size(n,2))-1),'-.b','LineWidth',2)
plot(x,squeeze(mean(mean(coher_V1_V2tar_colin(band,:,n),1),3))-3*squeeze(std(mean(coher_V1_V2tar_colin(band,:,n),1),0,3))./(sqrt(size(n,2))-1),'-.b','LineWidth',2)

plot(x,squeeze(mean(mean(coher_V1_V2tar_nocolin(band,:,n),1),3))+3*squeeze(std(mean(coher_V1_V2tar_nocolin(band,:,n),1),0,3))./(sqrt(size(n,2))-1),'-.r','LineWidth',2)
plot(x,squeeze(mean(mean(coher_V1_V2tar_nocolin(band,:,n),1),3))-3*squeeze(std(mean(coher_V1_V2tar_nocolin(band,:,n),1),0,3))./(sqrt(size(n,2))-1),'-.r','LineWidth',2)

plot(x,squeeze(mean(mean(coher_V1_V2tar_blank(band,:,n2),1),3))+3*squeeze(std(mean(coher_V1_V2tar_blank(band,:,n2),1),0,3))./(sqrt(size(n2,2))-1),'-.g','LineWidth',2)
plot(x,squeeze(mean(mean(coher_V1_V2tar_blank(band,:,n2),1),3))-3*squeeze(std(mean(coher_V1_V2tar_blank(band,:,n2),1),0,3))./(sqrt(size(n2,2))-1),'-.g','LineWidth',2)

legend('collinear','orthogonal','blank')
xlim([-100 300]);
ylim([0 0.4]);
%ylim([0 0.03]);


top=prctile(reshape(squeeze(mean(coher_V1_V2tar_blank(band,1:80,:),1)),[1,80*size(coher_V1_V2tar_blank,3)]),95);
bottom=prctile(reshape(squeeze(mean(coher_V1_V2tar_blank(band,1:80,:),1)),[1,80*size(coher_V1_V2tar_blank,3)]),5);
plot(x,top*ones(1,112),'k','LineWidth',1.5)
plot(x,bottom*ones(1,112),'k','LineWidth',1.5)






n=1:size(coher_V1_V2flan_colin,3);
n2=1:size(coher_V1_V2flan_blank,3);

band=4:9;

x=(1:112)*10-200;
figure
plot(x,squeeze(mean(mean(coher_V1_V2flan_colin(band,:,n),1),3)),'LineWidth',3)
hold on
plot(x,squeeze(mean(mean(coher_V1_V2flan_nocolin(band,:,n),1),3)),'r','LineWidth',3)
plot(x,squeeze(mean(mean(coher_V1_V2flan_blank(band,:,n2),1),3)),'g','LineWidth',3)

plot(x,squeeze(mean(mean(coher_V1_V2flan_colin(band,:,n),1),3))+3*squeeze(std(mean(coher_V1_V2flan_colin(band,:,n),1),0,3))./(sqrt(size(n,2))-1),'-.b','LineWidth',2)
plot(x,squeeze(mean(mean(coher_V1_V2flan_colin(band,:,n),1),3))-3*squeeze(std(mean(coher_V1_V2flan_colin(band,:,n),1),0,3))./(sqrt(size(n,2))-1),'-.b','LineWidth',2)

plot(x,squeeze(mean(mean(coher_V1_V2flan_nocolin(band,:,n),1),3))+3*squeeze(std(mean(coher_V1_V2flan_nocolin(band,:,n),1),0,3))./(sqrt(size(n,2))-1),'-.r','LineWidth',2)
plot(x,squeeze(mean(mean(coher_V1_V2flan_nocolin(band,:,n),1),3))-3*squeeze(std(mean(coher_V1_V2flan_nocolin(band,:,n),1),0,3))./(sqrt(size(n,2))-1),'-.r','LineWidth',2)

plot(x,squeeze(mean(mean(coher_V1_V2flan_blank(band,:,n2),1),3))+3*squeeze(std(mean(coher_V1_V2flan_blank(band,:,n2),1),0,3))./(sqrt(size(n2,2))-1),'-.g','LineWidth',2)
plot(x,squeeze(mean(mean(coher_V1_V2flan_blank(band,:,n2),1),3))-3*squeeze(std(mean(coher_V1_V2flan_blank(band,:,n2),1),0,3))./(sqrt(size(n2,2))-1),'-.g','LineWidth',2)

legend('collinear','orthogonal','blank')
xlim([-100 300]);
ylim([0 0.4]);
%ylim([0 0.042]);

top=prctile(reshape(squeeze(mean(coher_V1_V2flan_blank(band,1:80,:),1)),[1,80*size(coher_V1_V2flan_blank,3)]),95);
bottom=prctile(reshape(squeeze(mean(coher_V1_V2flan_blank(band,1:80,:),1)),[1,80*size(coher_V1_V2flan_blank,3)]),5);
plot(x,top*ones(1,112),'k','LineWidth',1.5)
plot(x,bottom*ones(1,112),'k','LineWidth',1.5)





