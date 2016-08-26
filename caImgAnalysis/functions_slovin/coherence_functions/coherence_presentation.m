%% coherence presentation


% create coherence conditions

cond=[2 4 6 6];    %choose conditions
roi='V1';          %choose region of interest
time=112;          %choose time frames (starting from the begining)

eval(['load coher_',roi,'_cond',int2str(cond(1))])
disp(['cond ',int2str(cond(1))])
a=zeros(10000,32,time);
eval(['a(pixels,:,:)=coher_',roi,'_cond',int2str(cond(1)),'(:,:,1:time);'])
a(isnan(a))=0;
eval(['clear coher_',roi,'_cond',int2str(cond(1))])

eval(['load coher_',roi,'_cond',int2str(cond(2))])  
disp(['cond ',int2str(cond(2))])
b=zeros(10000,32,time);
eval(['b(pixels,:,:)=coher_',roi,'_cond',int2str(cond(2)),'(:,:,1:time);'])
b(isnan(b))=0;
eval(['clear coher_',roi,'_cond',int2str(cond(2))])

eval(['load coher_',roi,'_cond',int2str(cond(3))])
disp(['cond ',int2str(cond(3))])
c=zeros(10000,32,time);
eval(['c(pixels,:,:)=coher_',roi,'_cond',int2str(cond(3)),'(:,:,1:time);'])
c(isnan(c))=0;
eval(['clear coher_',roi,'_cond',int2str(cond(3))])

eval(['load coher_',roi,'_cond',int2str(cond(4))]) 
disp(['cond ',int2str(cond(4))])
d=zeros(10000,32,time);
eval(['d(pixels,:,:)=coher_',roi,'_cond',int2str(cond(4)),'(:,:,1:time);'])
d(isnan(d))=0;
eval(['clear coher_',roi,'_cond',int2str(cond(4))])


%% plot conditions

figure;plotspconds(cat(3,abs(squeeze(mean(a(:,4:9,:),2))).^2,abs(squeeze(mean(b(:,4:9,:),2))).^2,abs(squeeze(mean(c(:,4:9,:),2))).^2,abs(squeeze(mean(d(:,4:9,:),2))).^2),100,100,10);title('alpha coherence');
figure;plotspconds(cat(3,abs(squeeze(mean(a(:,10:15,:),2))).^2,abs(squeeze(mean(b(:,10:15,:),2))).^2,abs(squeeze(mean(c(:,10:15,:),2))).^2,abs(squeeze(mean(d(:,10:15,:),2))).^2),100,100,10);title('beta coherence');
figure;plotspconds(cat(3,abs(squeeze(mean(a(:,15:end,:),2))).^2,abs(squeeze(mean(b(:,15:end,:),2))).^2,abs(squeeze(mean(c(:,15:end,:),2))).^2,abs(squeeze(mean(d(:,15:end,:),2))).^2),100,100,10);title('gamma coherence');

figure;plotspconds(cat(3,abs(squeeze(mean(a(:,:,20:30),3))).^2,abs(squeeze(mean(b(:,:,20:30),3))).^2,abs(squeeze(mean(c(:,:,20:30),3))).^2,abs(squeeze(mean(d(:,:,20:30),3))).^2),100,100,10);title('frequency content onset');
figure;plotspconds(cat(3,abs(squeeze(mean(a(:,:,45:65),3))).^2,abs(squeeze(mean(b(:,:,45:65),3))).^2,abs(squeeze(mean(c(:,:,45:65),3))).^2,abs(squeeze(mean(d(:,:,45:65),3))).^2),100,100,10);title('frequency content offset');

clip=0.002;
figure;mimg(abs(squeeze(mean(mean(a(:,10:15,20:30),3),2))).^2,100,100,0,clip);colormap(mapgeog);title('alpha coherence cond a');
figure;mimg(abs(squeeze(mean(mean(b(:,10:15,20:30),3),2))).^2,100,100,0,clip);colormap(mapgeog);title('alpha coherence cond b');
figure;mimg(abs(squeeze(mean(mean(c(:,10:15,20:30),3),2))).^2,100,100,0,clip);colormap(mapgeog);title('alpha coherence cond c');
figure;mimg(abs(squeeze(mean(mean(d(:,10:15,20:30),3),2))).^2,100,100,0,clip);colormap(mapgeog);title('alpha coherence cond d');


%figure;plotspconds(cat(3,unwrap(angle(squeeze(mean(a(:,4:9,:),2))),[],2),unwrap(angle(squeeze(mean(b(:,4:9,:),2))),[],2),unwrap(angle(squeeze(mean(c(:,4:9,:),2))),[],2),unwrap(angle(squeeze(mean(d(:,4:9,:),2))),[],2)),100,100,10);title('alpha phase');
%figure;plotspconds(cat(3,angle(squeeze(mean(a(:,1:4,:),2))),angle(squeeze(mean(b(:,1:4,:),2))),angle(squeeze(mean(c(:,1:4,:),2))),angle(squeeze(mean(d(:,1:4,:),2)))),100,100,10);
figure;plotspconds(cat(3,angle(squeeze(mean(a(:,4:9,:),2))),angle(squeeze(mean(b(:,4:9,:),2))),angle(squeeze(mean(c(:,4:9,:),2))),angle(squeeze(mean(d(:,4:9,:),2)))),100,100,10);
figure;plotspconds(cat(3,angle(squeeze(mean(a(:,10:15,:),2))),angle(squeeze(mean(b(:,10:15,:),2))),angle(squeeze(mean(c(:,10:15,:),2))),angle(squeeze(mean(d(:,10:15,:),2)))),100,100,10);title('beta phase');
figure;plotspconds(cat(3,angle(squeeze(mean(a(:,15:end,:),2))),angle(squeeze(mean(b(:,15:end,:),2))),angle(squeeze(mean(c(:,15:end,:),2))),angle(squeeze(mean(d(:,15:end,:),2)))),100,100,10);title('gamma phase');


figure;plotspconds(abs(squeeze(mean(a(:,:,20:30),3))).^2-abs(squeeze(mean(b(:,:,20:30),3))).^2,100,100,10);title('differential frequency content onset');
figure;plotspconds(abs(squeeze(mean(a(:,:,45:65),3))).^2-abs(squeeze(mean(b(:,:,45:65),3))).^2,100,100,10);title('differential frequency content offset');

figure;plotspconds(abs(squeeze(mean(a(:,2:5,:),2))).^2-abs(squeeze(mean(b(:,2:5,:),2))).^2,100,100,10);
figure;plotspconds(abs(squeeze(mean(a(:,4:9,:),2))).^2-abs(squeeze(mean(b(:,4:9,:),2))).^2,100,100,10);
figure;plotspconds(abs(squeeze(mean(a(:,10:15,:),2))).^2-abs(squeeze(mean(b(:,10:15,:),2))).^2,100,100,10);
figure;plotspconds(abs(squeeze(mean(a(:,15:end,:),2))).^2-abs(squeeze(mean(b(:,15:end,:),2))).^2,100,100,10);


%plot areas



figure;plot(cat(2,abs(squeeze(mean(mean(a(roi_V2,4:9,:),2),1))).^2,abs(squeeze(mean(mean(b(roi_V2,4:9,:),2),1))).^2,abs(squeeze(mean(mean(c(roi_V2,4:9,:),2),1))).^2,abs(squeeze(mean(mean(d(roi_V2,4:9,:),2),1))).^2))
%title('Coherence alpha target-V2');xlabel('time bin');ylabel('Coherence');
%legend('co-linear','non co linear','flankers only','no stimulation');
figure;plot(cat(2,abs(squeeze(mean(mean(a(roi_V1,4:9,:),2),1))).^2,abs(squeeze(mean(mean(b(roi_V1,4:9,:),2),1))).^2,abs(squeeze(mean(mean(c(roi_V1,4:9,:),2),1))).^2,abs(squeeze(mean(mean(d(roi_V1,4:9,:),2),1))).^2))
%title('Coherence alpha target-target');xlabel('time bin');ylabel('Coherence');
%legend('co-linear','non co linear','flankers only','no stimulation');
figure;plot(cat(2,abs(squeeze(mean(mean(a(roi_V1_2,4:9,:),2),1))).^2,abs(squeeze(mean(mean(b(roi_V1_2,4:9,:),2),1))).^2,abs(squeeze(mean(mean(c(roi_V1_2,4:9,:),2),1))).^2,abs(squeeze(mean(mean(d(roi_V1_2,4:9,:),2),1))).^2))
%title('Coherence alpha target-flanker');xlabel('time bin');ylabel('Coherence');
%legend('co-linear','non co linear','flankers only','no stimulation');
figure;plot(cat(2,abs(squeeze(mean(mean(a(roi_V4,4:9,:),2),1))).^2,abs(squeeze(mean(mean(b(roi_V4,4:9,:),2),1))).^2,abs(squeeze(mean(mean(c(roi_V4,4:9,:),2),1))).^2,abs(squeeze(mean(mean(d(roi_V4,4:9,:),2),1))).^2))
%title('Coherence alpha target-V4');xlabel('time bin');ylabel('Coherence');
%legend('co-linear','non co linear','flankers only','no stimulation');



figure;plot(cat(2,abs(squeeze(mean(mean(a(roi_V2,10:15,:),2),1))).^2,abs(squeeze(mean(mean(b(roi_V2,10:15,:),2),1))).^2,abs(squeeze(mean(mean(c(roi_V2,10:15,:),2),1))).^2,abs(squeeze(mean(mean(d(roi_V2,10:15,:),2),1))).^2))
%title('Coherence alpha target-V2');xlabel('time bin');ylabel('Coherence');
%legend('co-linear','non co linear','flankers only','no stimulation');
figure;plot(cat(2,abs(squeeze(mean(mean(a(roi_V1,10:15,:),2),1))).^2,abs(squeeze(mean(mean(b(roi_V1,10:15,:),2),1))).^2,abs(squeeze(mean(mean(c(roi_V1,10:15,:),2),1))).^2,abs(squeeze(mean(mean(d(roi_V1,10:15,:),2),1))).^2))
%title('Coherence alpha target-target');xlabel('time bin');ylabel('Coherence');
%legend('co-linear','non co linear','flankers only','no stimulation');
figure;plot(cat(2,abs(squeeze(mean(mean(a(roi_V1_2,10:15,:),2),1))).^2,abs(squeeze(mean(mean(b(roi_V1_2,10:15,:),2),1))).^2,abs(squeeze(mean(mean(c(roi_V1_2,10:15,:),2),1))).^2,abs(squeeze(mean(mean(d(roi_V1_2,10:15,:),2),1))).^2))
%title('Coherence alpha target-flanker');xlabel('time bin');ylabel('Coherence');
%legend('co-linear','non co linear','flankers only','no stimulation');
figure;plot(cat(2,abs(squeeze(mean(mean(a(roi_V4,10:15,:),2),1))).^2,abs(squeeze(mean(mean(b(roi_V4,10:15,:),2),1))).^2,abs(squeeze(mean(mean(c(roi_V4,10:15,:),2),1))).^2,abs(squeeze(mean(mean(d(roi_V4,10:15,:),2),1))).^2))
%title('Coherence alpha target-V4');xlabel('time bin');ylabel('Coherence');
%legend('co-linear','non co linear','flankers only','no stimulation');


%a(roi_V4,:,:)=10;
%figure;mimg(abs(squeeze(mean(mean(a(:,4:9,25:28),2),3))).^2,100,100,0,1);colormap(mapgeog);
