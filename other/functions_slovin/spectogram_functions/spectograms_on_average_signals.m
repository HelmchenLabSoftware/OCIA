

ave(:,1,:)=nanmean(b1402(1:1500,:,:),2);
ave(:,2,:)=nanmean(c1402(1:1500,:,:),2);
ave(:,3,:)=nanmean(b0702(1:1500,:,:),2);
ave(:,4,:)=nanmean(c0702(1:1500,:,:),2);
ave(:,5,:)=nanmean(d0702(1:1500,:,:),2);
ave(:,6,:)=nanmean(b1601(1:1500,:,:),2);




colin=b1402(1:500,:,4);
colin=cat(2,colin,c1402(1:500,:,4));
colin=cat(2,colin,b0702(1:500,:,4));
colin=cat(2,colin,c0702(1:500,:,4));
colin=cat(2,colin,d0702(1:500,:,4));
colin=cat(2,colin,b1601(1:500,:,4));

colin(:,isnan(colin(1,:)))=[];


noncolin=b1402(1:500,:,3);
noncolin=cat(2,noncolin,c1402(1:500,:,3));
noncolin=cat(2,noncolin,b0702(1:500,:,3));
noncolin=cat(2,noncolin,c0702(1:500,:,3));
noncolin=cat(2,noncolin,d0702(1:500,:,3));
noncolin=cat(2,noncolin,b1601(1:500,:,3));

noncolin(:,isnan(noncolin(1,:)))=[];

figure;errorbar(mean(colin,2),std(colin,0,2)/sqrt(size(colin,2)));
hold on
errorbar(mean(noncolin,2),std(noncolin,0,2)/sqrt(size(noncolin,2)),'r');
xlim([1 275])

diff=colin-noncolin;
figure;errorbar(mean(diff,2),std(diff,0,2)/sqrt(size(diff,2)));
hold on
plot(zeros(1,500),'k')
xlim([1 275])






