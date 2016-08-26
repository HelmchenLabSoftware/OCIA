%% significance presentation

% create coherence conditions

cond=[5 2];    %choose conditions first condition should be the top one
roi='V1';          %choose region of interest
time=112;          %choose time frames (starting from the begining)

eval(['load cond',int2str(cond(1)),'n_dt_bl'])
eval(['n=size(cond',int2str(cond(1)),'n_dt_bl,3);'])
eval(['clear cond',int2str(cond(1)),'n_dt_bl'])

eval(['load coher_',roi,'_cond',int2str(cond(1))])
disp(['cond ',int2str(cond(1))])
a=zeros(10000,32,time);
eval(['a(pixels,:,:)=coher_',roi,'_cond',int2str(cond(1)),';'])
a(isnan(a))=0;
eval(['load coher_',roi,'_std_cond',int2str(cond(1))])  
disp(['cond ',int2str(cond(1))])
b=zeros(10000,32,time);
eval(['b(pixels,:,:)=coher_',roi,'_cond',int2str(cond(1)),'-coher_',roi,'_std_cond',int2str(cond(1)),'/sqrt(n);'])
b(isnan(b))=0;
eval(['clear coher_',roi,'_cond',int2str(cond(1))])
eval(['clear coher_',roi,'_std_cond',int2str(cond(1))])  

eval(['load cond',int2str(cond(2)),'n_dt_bl'])
eval(['n=size(cond',int2str(cond(2)),'n_dt_bl,3);'])
eval(['clear cond',int2str(cond(2)),'n_dt_bl'])

eval(['load coher_',roi,'_cond',int2str(cond(2))])
disp(['cond ',int2str(cond(2))])
c=zeros(10000,32,time);
eval(['c(pixels,:,:)=coher_',roi,'_cond',int2str(cond(2)),';'])
c(isnan(c))=0;
eval(['load coher_',roi,'_std_cond',int2str(cond(2))])  
disp(['cond ',int2str(cond(2))])
d=zeros(10000,32,time);
eval(['d(pixels,:,:)=coher_',roi,'_cond',int2str(cond(2)),'+coher_',roi,'_std_cond',int2str(cond(2)),'/sqrt(n);'])
d(isnan(d))=0;
eval(['clear coher_',roi,'_cond',int2str(cond(2))])
eval(['clear coher_',roi,'_std_cond',int2str(cond(2))]) 


%plot conditions

figure;plotspconds(cat(3,abs(squeeze(mean(a(:,4:9,:),2))).^2,abs(squeeze(mean(b(:,4:9,:),2))).^2,abs(squeeze(mean(c(:,4:9,:),2))).^2,abs(squeeze(mean(d(:,4:9,:),2))).^2),100,100,10);title('alpha coherence');
figure;plotspconds(cat(3,abs(squeeze(mean(a(:,10:15,:),2))).^2,abs(squeeze(mean(b(:,10:15,:),2))).^2,abs(squeeze(mean(c(:,10:15,:),2))).^2,abs(squeeze(mean(d(:,10:15,:),2))).^2),100,100,10);title('beta coherence');
figure;plotspconds(cat(3,abs(squeeze(mean(a(:,15:end,:),2))).^2,abs(squeeze(mean(b(:,15:end,:),2))).^2,abs(squeeze(mean(c(:,15:end,:),2))).^2,abs(squeeze(mean(d(:,15:end,:),2))).^2),100,100,10);title('gamma coherence');

figure;plotspconds(cat(3,abs(squeeze(mean(a(:,:,20:30),3))).^2,abs(squeeze(mean(b(:,:,20:30),3))).^2,abs(squeeze(mean(c(:,:,20:30),3))).^2,abs(squeeze(mean(d(:,:,20:30),3))).^2),100,100,10);title('frequency content onset');
figure;plotspconds(cat(3,abs(squeeze(mean(a(:,:,45:65),3))).^2,abs(squeeze(mean(b(:,:,45:65),3))).^2,abs(squeeze(mean(c(:,:,45:65),3))).^2,abs(squeeze(mean(d(:,:,45:65),3))).^2),100,100,10);title('frequency content offset');



