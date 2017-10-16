

%% create coherence conditions

cond=1;    %choose conditions
roi='tar';          %choose region of interest (reference)
time=140;          %choose time frames (starting from the begining)

eval(['load coher_',roi,'_cond',int2str(cond(1))])
disp(['cond ',int2str(cond(1))])
a=zeros(10000,32,time);
eval(['a(pixels,:,:)=coher_',roi,'_cond',int2str(cond(1)),';'])
a(isnan(a))=0;
eval(['clear coher_',roi,'_cond',int2str(cond(1))])

eval(['load coher_',roi,'_std_cond',int2str(cond(1))])
disp(['cond ',int2str(cond(1))])
b=zeros(10000,32,time);
eval(['b(pixels,:,:)=coher_',roi,'_std_cond',int2str(cond(1)),';'])
b(isnan(b))=0;
eval(['clear coher_',roi,'_std_cond',int2str(cond(1))])



%% choose general ROI
figure(100);
mimg(abs(squeeze(mean(mean(a(:,4:9,25:28),2),3))).^2,100,100,0,1e-19);colormap(mapgeog);
roi = choose_polygon(100);
%% calculate std for SNR extraction

std=abs(mean(mean(mean(b(roi,4:9,5:10))))).^2;

%calculate SNR for V2

SNR_V2=(abs(mean(mean(a(:,4:9,23:25),2),3)).^2-abs(mean(mean(a(:,4:9,5:10),2),3)).^2)/std;

thresh=1.5; %in std

roi_V2=roi(find(SNR_V2(roi)>=thresh));   %define new ROI for V2
figure;
c=zeros(10000,1);
c(roi_V2)=10;
mimg(c,100,100,0,10);colormap(mapgeog);
