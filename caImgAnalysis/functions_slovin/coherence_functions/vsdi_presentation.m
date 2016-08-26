


colin=zeros(255,27);
colin=squeeze(mean(cond4n_dt_bl(roi_V1,2:256,:),1));
colin=cat(2,colin,squeeze(mean(cond4n_dt_bl(roi_V1,2:256,:),1)));

nocolin=zeros(255,29);
nocolin=squeeze(mean(cond3n_dt_bl(roi_V1,2:256,:),1));
nocolin=cat(2,nocolin,squeeze(mean(cond3n_dt_bl(roi_V1,2:256,:),1)));

blank=zeros(255,30);
blank=squeeze(mean(cond6n_dt_bl(roi_V1,2:256,:),1));
blank=cat(2,blank,squeeze(mean(cond6n_dt_bl(roi_V1,2:256,:),1)));



x=(2:256)*10-270;
figure
errorbar(x(1:2:end),mean(colin((1:2:end),:),2),std(colin((1:2:end),:),0,2)/sqrt(5))
hold on
errorbar(x(1:2:end),mean(nocolin((1:2:end),:),2),std(nocolin((1:2:end),:),0,2)/sqrt(5),'r')
errorbar(x(1:2:end),mean(blank((1:2:end),:),2),std(blank((1:2:end),:),0,2)/sqrt(5),'g')
title('VSDI signal');xlim([-180 380]);xlabel('Time (ms)');ylabel('\DeltaF/F');
legend('collinear','orthogonal','blank');



%% coherence


coher_colin=zeros(32,112,94);
coher_nocolin=zeros(32,112,94);
coher_blank=zeros(32,112,94);



coher_colin=shiftdim(squeeze(a(roi_V2comb,:,:)),1);
coher_nocolin=shiftdim(squeeze(b(roi_V2comb,:,:)),1);
coher_blank=shiftdim(squeeze(c(roi_V2comb,:,:)),1);

coher_colin=cat(3,coher_colin,shiftdim(squeeze(a(roi_V2comb,:,:)),1));
coher_nocolin=cat(3,coher_nocolin,shiftdim(squeeze(b(roi_V2comb,:,:)),1));
coher_blank=cat(3,coher_blank,shiftdim(squeeze(c(roi_V2comb,:,:)),1));


coher_colin=coher_colin-repmat(mean(coher_colin(:,2:11,:),2),[1 112 1]);
coher_nocolin=coher_nocolin-repmat(mean(coher_nocolin(:,2:11,:),2),[1 112 1]);
coher_blank=coher_blank-repmat(mean(coher_blank(:,2:11,:),2),[1 112 1]);

m(1)=max(squeeze(mean(coher_colin(4:9,20:40,1),1)));
m(2)=max(squeeze(mean(coher_colin(4:9,20:40,2),1)));
m(3)=max(squeeze(mean(coher_colin(4:9,20:40,3),1)));
m(4)=max(squeeze(mean(coher_colin(4:9,20:40,4),1)));
m(5)=max(squeeze(mean(coher_colin(4:9,20:40,5),1)));


coher_colin=coher_colin./shiftdim(repmat(m,[112 1 32]),2);
coher_nocolin=coher_nocolin./shiftdim(repmat(m,[112 1 32]),2);
coher_blank=coher_blank./shiftdim(repmat(m,[112 1 32]),2);



f=(1:32)*50/32;
x=(1:112)*10-200;
n=369;
figure
errorbar(x,squeeze(mean(mean(coher_colin(4:9,:,:),1),3)),3*squeeze(std(mean(coher_colin(4:9,:,:),1),0,3))./(sqrt(n)-1))
hold on
errorbar(x,squeeze(mean(mean(coher_nocolin(4:9,:,:),1),3)),3*squeeze(std(mean(coher_nocolin(4:9,:,:),1),0,3))./(sqrt(n)-1),'r')
errorbar(x,squeeze(mean(mean(coher_blank(4:9,:,:),1),3)),3*squeeze(std(mean(coher_blank(4:9,:,:),1),0,3))./(sqrt(n)-1),'g')
legend('collinear','orthogonal','blank');title('Alpha coherence');xlabel('Time (ms)');ylabel('Coherence');xlim([-200 700]);

%%
f=(1:32)*50/32;
x=(20:10:1130)-200;
n=size(coher_blank,3);
figure
plot(x,squeeze(mean(mean(coher_colin(4:9,:,:),1),3)),'LineWidth',3)
hold on
plot(x,squeeze(mean(mean(coher_nocolin(4:9,:,:),1),3)),'r','LineWidth',3)
plot(x,squeeze(mean(mean(coher_blank(4:9,:,:),1),3)),'g','LineWidth',3)

plot(x,squeeze(mean(mean(coher_colin(4:9,:,:),1),3))+3*squeeze(std(mean(coher_colin(4:9,:,:),1),0,3))./(sqrt(n)-1),'-.b','LineWidth',2)
plot(x,squeeze(mean(mean(coher_colin(4:9,:,:),1),3))-3*squeeze(std(mean(coher_colin(4:9,:,:),1),0,3))./(sqrt(n)-1),'-.b','LineWidth',2)

plot(x,squeeze(mean(mean(coher_nocolin(4:9,:,:),1),3))+3*squeeze(std(mean(coher_nocolin(4:9,:,:),1),0,3))./(sqrt(n)-1),'-.r','LineWidth',2)
plot(x,squeeze(mean(mean(coher_nocolin(4:9,:,:),1),3))-3*squeeze(std(mean(coher_nocolin(4:9,:,:),1),0,3))./(sqrt(n)-1),'-.r','LineWidth',2)

plot(x,squeeze(mean(mean(coher_blank(4:9,:,:),1),3))+3*squeeze(std(mean(coher_blank(4:9,:,:),1),0,3))./(sqrt(n)-1),'-.g','LineWidth',2)
plot(x,squeeze(mean(mean(coher_blank(4:9,:,:),1),3))-3*squeeze(std(mean(coher_blank(4:9,:,:),1),0,3))./(sqrt(n)-1),'-.g','LineWidth',2)

legend('collinear','orthogonal','blank');title('Alpha coherence');xlabel('Time (ms)');ylabel('Coherence');xlim([-200 700]);

maxb=max(squeeze(mean(mean(coher_blank(4:9,1:50,:),1),3))+3*squeeze(std(mean(coher_blank(4:9,1:50,:),1),0,3))./(sqrt(n)-1));
minb=min(squeeze(mean(mean(coher_blank(4:9,1:50,:),1),3))-3*squeeze(std(mean(coher_blank(4:9,1:50,:),1),0,3))./(sqrt(n)-1));
cc=zeros(1,112);
cc(:,:)=maxb;
dd=zeros(1,112);
dd(:,:)=minb;

plot(x,cc,'k','LineWidth',1.5)
plot(x,dd,'k','LineWidth',1.5)
xlim([-100 300])



figure
plot(x,squeeze(mean(mean(coher_colin(10:15,:,:),1),3)),'LineWidth',3)
hold on
plot(x,squeeze(mean(mean(coher_nocolin(10:15,:,:),1),3)),'r','LineWidth',3)
plot(x,squeeze(mean(mean(coher_blank(10:15,:,:),1),3)),'g','LineWidth',3)

plot(x,squeeze(mean(mean(coher_colin(10:15,:,:),1),3))+3*squeeze(std(mean(coher_colin(10:15,:,:),1),0,3))./(sqrt(n)-1),'-.b','LineWidth',2)
plot(x,squeeze(mean(mean(coher_colin(10:15,:,:),1),3))-3*squeeze(std(mean(coher_colin(10:15,:,:),1),0,3))./(sqrt(n)-1),'-.b','LineWidth',2)

plot(x,squeeze(mean(mean(coher_nocolin(10:15,:,:),1),3))+3*squeeze(std(mean(coher_nocolin(10:15,:,:),1),0,3))./(sqrt(n)-1),'-.r','LineWidth',2)
plot(x,squeeze(mean(mean(coher_nocolin(10:15,:,:),1),3))-3*squeeze(std(mean(coher_nocolin(10:15,:,:),1),0,3))./(sqrt(n)-1),'-.r','LineWidth',2)

plot(x,squeeze(mean(mean(coher_blank(10:15,:,:),1),3))+3*squeeze(std(mean(coher_blank(10:15,:,:),1),0,3))./(sqrt(n)-1),'-.g','LineWidth',2)
plot(x,squeeze(mean(mean(coher_blank(10:15,:,:),1),3))-3*squeeze(std(mean(coher_blank(10:15,:,:),1),0,3))./(sqrt(n)-1),'-.g','LineWidth',2)

legend('collinear','orthogonal','blank');title('Beta coherence');xlabel('Time (ms)');ylabel('Coherence');xlim([-200 700]);

maxb=max(squeeze(mean(mean(coher_blank(10:15,1:50,:),1),3))+3*squeeze(std(mean(coher_blank(10:15,1:50,:),1),0,3))./(sqrt(n)-1));
minb=min(squeeze(mean(mean(coher_blank(10:15,1:50,:),1),3))-3*squeeze(std(mean(coher_blank(10:15,1:50,:),1),0,3))./(sqrt(n)-1));
cc=zeros(1,112);
cc(:,:)=maxb;
dd=zeros(1,112);
dd(:,:)=minb;

plot(x,cc,'k','LineWidth',1.5)
plot(x,dd,'k','LineWidth',1.5)
xlim([-100 300])



figure
plot(x,squeeze(mean(mean(coher_colin(16:32,:,:),1),3)),'LineWidth',3)
hold on
plot(x,squeeze(mean(mean(coher_nocolin(16:32,:,:),1),3)),'r','LineWidth',3)
plot(x,squeeze(mean(mean(coher_blank(16:32,:,:),1),3)),'g','LineWidth',3)

plot(x,squeeze(mean(mean(coher_colin(16:32,:,:),1),3))+3*squeeze(std(mean(coher_colin(16:32,:,:),1),0,3))./(sqrt(n)-1),'-.b','LineWidth',2)
plot(x,squeeze(mean(mean(coher_colin(16:32,:,:),1),3))-3*squeeze(std(mean(coher_colin(16:32,:,:),1),0,3))./(sqrt(n)-1),'-.b','LineWidth',2)

plot(x,squeeze(mean(mean(coher_nocolin(16:32,:,:),1),3))+3*squeeze(std(mean(coher_nocolin(16:32,:,:),1),0,3))./(sqrt(n)-1),'-.r','LineWidth',2)
plot(x,squeeze(mean(mean(coher_nocolin(16:32,:,:),1),3))-3*squeeze(std(mean(coher_nocolin(16:32,:,:),1),0,3))./(sqrt(n)-1),'-.r','LineWidth',2)

plot(x,squeeze(mean(mean(coher_blank(16:32,:,:),1),3))+3*squeeze(std(mean(coher_blank(16:32,:,:),1),0,3))./(sqrt(n)-1),'-.g','LineWidth',2)
plot(x,squeeze(mean(mean(coher_blank(16:32,:,:),1),3))-3*squeeze(std(mean(coher_blank(16:32,:,:),1),0,3))./(sqrt(n)-1),'-.g','LineWidth',2)

legend('collinear','orthogonal','blank');title('gamma coherence');xlabel('Time (ms)');ylabel('Coherence');xlim([-200 700]);

maxb=max(squeeze(mean(mean(coher_blank(16:32,1:80,:),1),3))+3*squeeze(std(mean(coher_blank(16:32,1:80,:),1),0,3))./(sqrt(n)-1));
minb=min(squeeze(mean(mean(coher_blank(16:32,1:80,:),1),3))-3*squeeze(std(mean(coher_blank(16:32,1:80,:),1),0,3))./(sqrt(n)-1));
cc=zeros(1,112);
cc(:,:)=maxb;
dd=zeros(1,112);
dd(:,:)=minb;

plot(x,cc,'k','LineWidth',1.5)
plot(x,dd,'k','LineWidth',1.5)
xlim([-100 300])

%%

%statistics
x=(1:112)*10-200;
[h,p,ci,stats] = ttest((squeeze(mean(coher_blank(4:9,:,:),1))-squeeze(repmat(mean(mean(coher_blank(4:9,:,:),1),3),[1 1 369]))).',0,1e-3);
s=max(ci(1,:));
cc=zeros(1,112);
cc(:,:)=s;
figure;
plot(x,squeeze(mean(mean(coher_colin(4:9,:,:),1),3)))
hold on
plot(x,squeeze(mean(mean(coher_nocolin(4:9,:,:),1),3)),'r')
plot(x,squeeze(mean(mean(coher_blank(4:9,:,:),1),3)),'g')
errorbar(x,squeeze(mean(mean(coher_blank(4:9,:,:),1),3)),ci(1,:),'g');
errorbar(x,squeeze(mean(mean(coher_blank(4:9,:,:),1),3)),3*squeeze(std(mean(coher_blank(4:9,:,:),1),0,3))./(sqrt(369)-1),'m')


sd=squeeze(std(mean(coher_blank(4:9,:,:),1),0,3));

x=(1:112)*10-200;
[h,p,ci,stats] = ttest((squeeze(mean(coher_blank(10:15,:,:),1))-squeeze(repmat(mean(mean(coher_blank(10:15,:,:),1),3),[1 1 369]))).',0,1e-3);
s=max(ci(1,:));
cc=zeros(1,112);
cc(:,:)=s;
figure;
plot(x,squeeze(mean(mean(coher_colin(10:15,:,:),1),3)))
hold on
plot(x,squeeze(mean(mean(coher_nocolin(10:15,:,:),1),3)),'r')
%plot(x,squeeze(mean(mean(coher_blank(10:15,:,:),1),3)),'g')
errorbar(x,squeeze(mean(mean(coher_blank(10:15,:,:),1),3)),ci(1,:),'g');


%normalization
m(1)=max(squeeze(mean(coher_colin(10:15,20:40,1),1)));
m(2)=max(squeeze(mean(coher_colin(10:15,20:40,2),1)));
m(3)=max(squeeze(mean(coher_colin(10:15,20:40,3),1)));
m(4)=max(squeeze(mean(coher_colin(10:15,20:40,4),1)));
m(5)=max(squeeze(mean(coher_colin(10:15,20:40,5),1)));

coher_colin=coher_colin./shiftdim(repmat(m,[112 1 32]),2);
coher_nocolin=coher_nocolin./shiftdim(repmat(m,[112 1 32]),2);
coher_blank=coher_blank./shiftdim(repmat(m,[112 1 32]),2);

f=(1:32)*50/32;
x=(1:112)*10-200;

figure
errorbar(x,squeeze(mean(mean(coher_colin(10:15,:,:),1),3)),squeeze(std(mean(coher_colin(10:15,:,:),1),0,3))./(sqrt(369)-1))
hold on
errorbar(x,squeeze(mean(mean(coher_nocolin(10:15,:,:),1),3)),squeeze(std(mean(coher_nocolin(10:15,:,:),1),0,3))./(sqrt(369)-1),'r')
errorbar(x,squeeze(mean(mean(coher_blank(10:15,:,:),1),3)),squeeze(std(mean(coher_blank(10:15,:,:),1),0,3))./(sqrt(369)-1),'g')
legend('collinear','orthogonal','blank');title('Beta coherence');xlabel('Time (ms)');ylabel('Coherence');xlim([-200 700]);


figure
errorbar(x,squeeze(mean(mean(coher_colin(15:25,:,:),1),3)),squeeze(std(mean(coher_colin(15:25,:,:),1),0,3))./(sqrt(369)-1))
hold on
errorbar(x,squeeze(mean(mean(coher_nocolin(15:25,:,:),1),3)),squeeze(std(mean(coher_nocolin(15:25,:,:),1),0,3))./(sqrt(369)-1),'r')
errorbar(x,squeeze(mean(mean(coher_blank(15:25,:,:),1),3)),squeeze(std(mean(coher_blank(15:25,:,:),1),0,3))./(sqrt(369)-1),'g')
legend('collinear','orthogonal','blank');title('Beta coherence');xlabel('Time (ms)');ylabel('Coherence');xlim([-200 700]);




alpha_colin(:,1)=squeeze(mean(mean(a(roi_V1,4:9,:),2),1));
alpha_nocolin(:,1)=squeeze(mean(mean(b(roi_V1,4:9,:),2),1));
alpha_blank(:,1)=squeeze(mean(mean(c(roi_V1,4:9,:),2),1));


errorbar(squeeze(mean(alpha_colin,2)),squeeze(std(alpha_colin,0,2))./sqrt(5))
hold on
errorbar(squeeze(mean(alpha_nocolin,2)),squeeze(std(alpha_nocolin,0,2))./sqrt(5),'r')
errorbar(squeeze(mean(alpha_blank(:,1:2),2)),squeeze(std(alpha_blank(:,1:2),0,2))./sqrt(2),'c')




beta_colin=zeros(112,5);
beta_nocolin=zeros(112,5);
beta_blank=zeros(112,5);


beta_colin(:,5)=squeeze(mean(mean(a(roi_V1,10:15,:),2),1));
beta_nocolin(:,5)=squeeze(mean(mean(b(roi_V1,10:15,:),2),1));
beta_blank(:,5)=squeeze(mean(mean(c(roi_V1,10:15,:),2),1));



errorbar(squeeze(mean(beta_colin,2)),squeeze(std(beta_colin,0,2))./sqrt(5))
hold on
errorbar(squeeze(mean(beta_nocolin,2)),squeeze(std(beta_nocolin,0,2))./sqrt(5),'r')
errorbar(squeeze(mean(beta_blank,2)),squeeze(std(beta_blank,0,2))./sqrt(3),'r')



%% power
f=(1:32)*50/32;
x=(1:112)*10-200;


a=10*log10(a);
b=10*log10(b);
c=10*log10(c);
a(isnan(a))=0;
b(isnan(b))=0;
c(isnan(c))=0;
a(isinf(a))=0;
b(isinf(b))=0;
c(isinf(c))=0;

a=10*log10(a./repmat(mean(a(:,:,2:11),3),[1 1 112]));
a(isnan(a))=0;
a(isinf(a))=0;

b=10*log10(b./repmat(mean(b(:,:,2:11),3),[1 1 112]));
b(isnan(b))=0;
b(isinf(b))=0;

c=10*log10(c./repmat(mean(c(:,:,2:11),3),[1 1 112]));
c(isnan(c))=0;
c(isinf(c))=0;



power_colin=zeros(32,112,5);
power_nocolin=zeros(32,112,5);
power_blank=zeros(32,112,5);



power_colin(:,:,5)=squeeze(mean(a(roi_V1,:,:),1));
power_nocolin(:,:,5)=squeeze(mean(b(roi_V1,:,:),1));
power_blank(:,:,5)=squeeze(mean(c(roi_V1,:,:),1));

f=(1:32)*50/32;
x=(1:112)*10-200;
figure
imagesc(x,f,mean(power_colin,3),[-.8 6]);colormap(mapgeog);colorbar;
xlim([-190 500]);
title('Spectogram - collinear condition');
xlabel('Tme (ms)');ylabel('Frequency (Hz)');





figure
errorbar(f,squeeze(mean(mean(power_colin(:,20:40,:),2),3)),squeeze(std(mean(power_colin(:,20:40,:),2),0,3))./sqrt(5),'b')
hold on
errorbar(f,squeeze(mean(mean(power_nocolin(:,20:40,:),2),3)),squeeze(std(mean(power_nocolin(:,20:40,:),2),0,3))./sqrt(5),'r')
errorbar(f,squeeze(mean(mean(power_blank(:,20:40,:),2),3)),squeeze(std(mean(power_blank(:,20:40,:),2),0,3))./sqrt(5),'c')
legend('collinear','orthogonal','blank');title('Power');xlabel('Frequency (Hz)');ylabel('10*log10(power)');xlim([0 50]);





errorbar(squeeze(mean(mean(power_blank(4:9,:,:),1),3)),squeeze(std(mean(power_blank(4:9,:,:),1),0,3))./sqrt(5),'c');title('Power');xlabel('Frequency (Hz)');ylabel('Power (dB)');
legend('collinear','orthogonal','blank');





band=10:15;
figure
scatter(mean(mean(b(roi_V1,band,20:30),2),3),mean(mean(a(roi_V1,band,20:30),2),3));
hold on
plot(-.15:0.01:0.9,-.15:0.01:0.9,'k')
xlim([0 0.02]);ylim([0 0.02]);
ranksum(mean(mean(b(roi_V1,band,20:30),2),3),mean(mean(a(roi_V1,band,20:30),2),3))

figure
scatter(mean(mean(b(roi_V1_2,band,20:30),2),3),mean(mean(a(roi_V1_2,band,20:30),2),3));
hold on
plot(-.15:0.01:0.9,-.15:0.01:0.9,'k')
xlim([0 0.02]);ylim([0 0.02]);
ranksum(mean(mean(b(roi_V1_2,band,20:30),2),3),mean(mean(a(roi_V1_2,band,20:30),2),3))

figure
scatter(mean(mean(b(roi_V2,band,20:30),2),3),mean(mean(a(roi_V2,band,20:30),2),3));
hold on
plot(-.15:0.01:0.9,-.15:0.01:0.9,'k')
xlim([0 0.02]);ylim([0 0.02]);
ranksum(mean(mean(b(roi_V2,band,20:30),2),3),mean(mean(a(roi_V2,band,20:30),2),3))










