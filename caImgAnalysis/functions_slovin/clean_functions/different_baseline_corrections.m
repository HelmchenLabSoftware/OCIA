%% different baseline corrections

load coher_V2_final

time=112;


figure;plotspconds(cat(3,squeeze(mean(a(:,4:9,:),2)),squeeze(mean(b(:,4:9,:),2)),squeeze(mean(c(:,4:9,:),2))),100,100,10);
figure;plotspconds(cat(3,squeeze(mean(a(:,10:15,:),2)),squeeze(mean(b(:,10:15,:),2)),squeeze(mean(c(:,10:15,:),2))),100,100,10);


%% baseline correction 1

a=a-repmat(mean(a(:,:,2:13),3),[1,1,time]);
b=b-repmat(mean(b(:,:,2:13),3),[1,1,time]);
c=c-repmat(mean(c(:,:,2:13),3),[1,1,time]);

figure;plotspconds(cat(3,squeeze(mean(a(:,4:9,:),2)),squeeze(mean(b(:,4:9,:),2)),squeeze(mean(c(:,4:9,:),2))),100,100,10);
figure;plotspconds(cat(3,squeeze(mean(a(:,10:15,:),2)),squeeze(mean(b(:,10:15,:),2)),squeeze(mean(c(:,10:15,:),2))),100,100,10);

%% baseline correction 2

load coher_V2_final

a=a./repmat(mean(a(:,:,11:13),3),[1,1,time]);
b=b./repmat(mean(b(:,:,11:13),3),[1,1,time]);
c=c./repmat(mean(c(:,:,11:13),3),[1,1,time]);

a(isnan(a))=0;
b(isnan(b))=0;
c(isnan(c))=0;

figure;plotspconds(cat(3,squeeze(mean(a(:,4:9,:),2)),squeeze(mean(b(:,4:9,:),2)),squeeze(mean(c(:,4:9,:),2))),100,100,10);
figure;plotspconds(cat(3,squeeze(mean(a(:,10:15,:),2)),squeeze(mean(b(:,10:15,:),2)),squeeze(mean(c(:,10:15,:),2))),100,100,10);




%% baseline correction 3


a=a./repmat(mean(a(:,:,1:11),3),[1,1,time]);
b=b./repmat(mean(b(:,:,1:11),3),[1,1,time]);
c=c./repmat(mean(c(:,:,1:11),3),[1,1,time]);

a(isnan(a))=0;
b(isnan(b))=0;
c(isnan(c))=0;

figure;plotspconds(cat(3,squeeze(mean(a(:,4:9,:),2)),squeeze(mean(b(:,4:9,:),2)),squeeze(mean(c(:,4:9,:),2))),100,100,10);
figure;plotspconds(cat(3,squeeze(mean(a(:,10:15,:),2)),squeeze(mean(b(:,10:15,:),2)),squeeze(mean(c(:,10:15,:),2))),100,100,10);
figure;plotspconds(cat(3,squeeze(mean(a(:,16:20,:),2)),squeeze(mean(b(:,16:20,:),2)),squeeze(mean(c(:,16:20,:),2))),100,100,10);
figure;plotspconds(cat(3,squeeze(mean(a(:,20:29,:),2)),squeeze(mean(b(:,20:29,:),2)),squeeze(mean(c(:,20:29,:),2))),100,100,10);





