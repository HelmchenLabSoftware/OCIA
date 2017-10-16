% this m file compares between vsdi and lfp components


%% lfp power plots
x2=(1:459)*4-(420); %for faces and contour integration
x2=(1:459)*4-(420+25); %for collinear
f2=(1:64)*125/64;

%for faces: take only 6:12 for clean recording sessions


hg=squeeze(mean(mean(spect_colin(31:end,:,:),1),3));
hg=hg./max(hg(1:170));
lg=squeeze(mean(mean(spect_colin(13:25,:,:),1),3));
lg=lg./max(lg(1:170));
figure;plot(x2,lg)
hold on
plot(x2,hg,'r')

%down sample the lfp to 100 Hz
x3 = resample(x2,4,10);
l_ds = resample(l',4,10)';
corrcoef(mean(l_ds(13:25,40:65),1),mean(v(4:9,14:39),1))


%% vsdi plot
x1=(20:10:1130)-200; %for collinear
f1=(1:32)*50/32;
x1=(20:10:2010)-190; %for contour integration
x1=(20:10:1130)-190; %for faces 

%alpha power

al=squeeze(mean(mean(power_colin(4:9,:,:),1),3))';
al=squeeze(mean(mean(a(roi,4:9,:),2),1));
al=al/max(al(1:50));
figure;plot(x1,al)

%smoothed time

a=mean(cond2n_dt_bl,3);
a=a-1;
for i=2:241
    e(:,i)=mean(a(:,i:i+15).*repmat(hamming(16),1,10000)',2);
end        
figure
t=squeeze(mean(e(roi,1:112),1));
t=t/max(t(1:40));
plot(x1,t)

a=a-1;
for j=1:14
    for i=2:241
        e(:,i,j)=mean(a(:,i:i+15,j).*repmat(hamming(16),1,10000)',2);
    end 
end
figure
t=squeeze(mean(mean(e(roi,1:112,:),1),3));
t=t/max(t(1:40));
plot(x1,t)


a=colin-1;
for i=1:240
    e(i,:)=mean(a(i:i+15,:).*repmat(hamming(16),1,102),1);
end        
figure
t=squeeze(mean(e(roi_V1,1:112),1));
t=t/max(t(1:40));
plot(x1,t)


% vsdi time course

x4=(1:256)*10-280;
figure
errorbar(x4,mean(mean(a(roi_V1,:,:)-1,1),3),std(mean(a(roi_V1,:,:),1)-1,0,3)/sqrt(4))
xlim([-100 250])

figure
errorbar(x4(2:end),mean(colin,2),std(colin,0,2)/sqrt(104))
xlim([-100 300])


%% normalization
a=10*log10(a./repmat(mean(a(:,:,2:11),3),[1 1 112]));
a(isnan(a))=0;
a(isinf(a))=0;

b=10*log10(b./repmat(mean(b(:,:,2:11),3),[1 1 112]));
b(isnan(b))=0;
b(isinf(b))=0;

c=10*log10(c./repmat(mean(c(:,:,2:11),3),[1 1 112]));
c(isnan(c))=0;
c(isinf(c))=0;

d=10*log10(d./repmat(mean(d(:,:,2:11),3),[1 1 112]));
d(isnan(d))=0;
d(isinf(d))=0;

% subtrating baseline (i did it for vsdi faces chakchak)
a=a-repmat(mean(a(:,:,2:11),3),[1 1 112]);
a(isnan(a))=0;
a(isinf(a))=0;




%% some more relevant plots    
    
figure
imagesc(x2,f2,mean(spect_all_conds(:,:,4),3),[-4 15]);colormap(mapgeog)
xlim([-100 300])
ylim([5 125])

figure
imagesc(x1,f1,squeeze(mean(a(roi,:,:),1)),[-3 10]);colormap(mapgeog)
xlim([-100 300])
ylim([5 50])

figure
imagesc(x1,f1,squeeze(mean(power_nocolin,3)),[-2 7]);colormap(mapgeog)
xlim([-100 300])
ylim([5 50])

figure
imagesc(x1,f1,squeeze(mean(a(roi_V1,:,:),1)),[-1 4]);colormap(mapgeog)
xlim([-100 300])
ylim([5 50])

figure
imagesc(x1,f1,squeeze(mean(b(roi_V1,:,:),1)),[-1 4]);colormap(mapgeog)
xlim([-100 300])
ylim([5 50])




figure
imagesc(x2,f2,mean(spect_blank(:,:,:),3),[-2 10]);colormap(mapgeog)
xlim([-100 1000])
ylim([5 120])

figure
imagesc(x2,f2,mean(spect_contour,3),[-2 6]);colormap(mapgeog)
xlim([-100 300])
ylim([5 125])

figure
plot(squeeze(mean(mean(spect_0503a(13:25,:,1:2),1),3)))
hold on
plot(squeeze(mean(mean(spect_0503b(13:25,:,1:2),1),3)))
plot(squeeze(mean(mean(spect_0503c(13:25,:,1:2),1),3)))
plot(squeeze(mean(mean(spect_0504a(13:25,:,1:2),1),3)),'r')
plot(squeeze(mean(mean(spect_0504b(13:25,:,1:2),1),3)),'r')
plot(squeeze(mean(mean(spect_0504c(13:25,:,1:2),1),3)),'r')
plot(squeeze(mean(mean(spect_0504d(13:25,:,1:2),1),3)),'r')
plot(squeeze(mean(mean(spect_0510a(13:25,:,1:2),1),3)),'g')
plot(squeeze(mean(mean(spect_0510b(13:25,:,1:2),1),3)),'g')
plot(squeeze(mean(mean(spect_0510c(13:25,:,1:2),1),3)),'g')
plot(squeeze(mean(mean(spect_0510d(13:25,:,1:2),1),3)),'g')
plot(squeeze(mean(mean(spect_0510e(13:25,:,1:2),1),3)),'g')
plot(squeeze(mean(mean(spect_0511c(13:25,:,1:2),1),3)),'c')
plot(squeeze(mean(mean(spect_0511d(13:25,:,1:2),1),3)),'c')
plot(squeeze(mean(mean(spect_0511e(13:25,:,1:2),1),3)),'c')
plot(squeeze(mean(mean(spect_0511f(13:25,:,1:2),1),3)),'c')

%% plot lfps

x5=(1:626)*4-500;

figure
errorbar(x5,mean(time_contour,2),std(time_contour,0,2)/sqrt(16))
hold on
errorbar(x5,mean(time_noncon,2),std(time_noncon,0,2)/sqrt(16),'r')
errorbar(x5,mean(time_blank,2),std(time_blank,0,2)/sqrt(16),'g')
xlim([-200 300])

figure
errorbar(x5,mean(lfp_face(:,:),2),std(lfp_face(:,:),0,2)/sqrt(16))
xlim([-100 300])


figure
plot(time_vec,lfp_face)
xlim([-100 400])




%%


power_face=zeros(32,112,4);
power_face(:,:,1)=squeeze(mean(a(roi_V1,:,:),1));
power_face(:,:,2)=squeeze(mean(b(roi_V1,:,:),1));
power_face(:,:,3)=squeeze(mean(c(roi_V1,:,:),1));
power_face(:,:,4)=squeeze(mean(d(roi_V1,:,:),1));


power_face=cat(3,mean(power_face(:,:,1:2),3),mean(power_face(:,:,3:4),3));


power_contour=zeros(32,200,2);
power_contour(:,:,1)=squeeze(mean(a(roi,:,:),1));
power_contour(:,:,2)=squeeze(mean(b(roi,:,:),1));



figure;plot(x2,mean(spect_colin(7:20,:,1),1))
hold on
plot(x2,mean(spect_nocolin(7:20,:,1),1),'r')
xlim([-100 300])

figure;plot(x2,mean(spect_colin(7:20,:,2),1))
hold on
plot(x2,mean(spect_nocolin(7:20,:,2),1),'r')
xlim([-100 300])

figure;plot(x2,mean(spect_colin(7:20,:,3),1))
hold on
plot(x2,mean(spect_nocolin(7:20,:,3),1),'r')
xlim([-100 300])

figure;plot(x2,mean(spect_colin(7:20,:,4),1))
hold on
plot(x2,mean(spect_nocolin(7:20,:,4),1),'r')
xlim([-100 300])

figure;plot(x2,mean(spect_colin(7:20,:,5),1))
hold on
plot(x2,mean(spect_nocolin(7:20,:,5),1),'r')
xlim([-100 300])

figure;plot(x2,mean(spect_colin(7:20,:,6),1))
hold on
plot(x2,mean(spect_nocolin(7:20,:,6),1),'r')
xlim([-100 300])




% for collinear 14:39 and 40:65
% for faces and ci 13:38 and 38:63 , for time 14:39

ltime=40:65;
vtime=14:39;

c=corrcoef(mean(l_ds(4:7,ltime),1),mean(v(4:9,vtime),1));
m(1,1)=c(1,2);
c=corrcoef(mean(l_ds(8:12,ltime),1),mean(v(4:9,vtime),1));
m(1,2)=c(1,2);
c=corrcoef(mean(l_ds(13:25,ltime),1),mean(v(4:9,vtime),1));
m(1,3)=c(1,2);
c=corrcoef(mean(l_ds(31:64,ltime),1),mean(v(4:9,vtime),1));
m(1,4)=c(1,2);
c=corrcoef(mean(l_ds(4:7,ltime),1),mean(v(10:15,vtime),1));
m(2,1)=c(1,2);
c=corrcoef(mean(l_ds(8:12,ltime),1),mean(v(10:15,vtime),1));
m(2,2)=c(1,2);
c=corrcoef(mean(l_ds(13:25,ltime),1),mean(v(10:15,vtime),1));
m(2,3)=c(1,2);
c=corrcoef(mean(l_ds(31:64,ltime),1),mean(v(10:15,vtime),1));
m(2,4)=c(1,2);
c=corrcoef(mean(l_ds(4:7,ltime),1),mean(v(16:32,vtime),1));
m(3,1)=c(1,2);
c=corrcoef(mean(l_ds(8:12,ltime),1),mean(v(16:32,vtime),1));
m(3,2)=c(1,2);
c=corrcoef(mean(l_ds(13:25,ltime),1),mean(v(16:32,vtime),1));
m(3,3)=c(1,2);
c=corrcoef(mean(l_ds(31:64,ltime),1),mean(v(16:32,vtime),1));
m(3,4)=c(1,2);
c=corrcoef(mean(l_ds(4:7,ltime),1),mean(time_course(14:39,:),2));
m(4,1)=c(1,2);
c=corrcoef(mean(l_ds(8:12,ltime),1),mean(time_course(14:39,:),2));
m(4,2)=c(1,2);
c=corrcoef(mean(l_ds(13:25,ltime),1),mean(time_course(14:39,:),2));
m(4,3)=c(1,2);
c=corrcoef(mean(l_ds(31:64,ltime),1),mean(time_course(14:39,:),2));
m(4,4)=c(1,2);

figure;bar(m)
