%% significance presentation 2

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
eval(['b(pixels,:,:)=coher_',roi,'_std_cond',int2str(cond(1)),'/sqrt(n);'])
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
eval(['d(pixels,:,:)=coher_',roi,'_std_cond',int2str(cond(2)),'/sqrt(n);'])
d(isnan(d))=0;
eval(['clear coher_',roi,'_cond',int2str(cond(2))])
eval(['clear coher_',roi,'_std_cond',int2str(cond(2))]) 

figure(100);
clip=0.25;
mimg(abs(squeeze(mean(mean(a(:,4:9,20:30),3),2))).^2,100,100,0,clip);colormap(mapgeog);
roi1 = choose_polygon(100);

figure;errorbar(abs(squeeze(mean(mean(a(roi1,4:9,:),2),1))).^2,abs(squeeze(mean(mean(b(roi1,4:9,:),2),1))).^2)
hold on 
errorbar(abs(squeeze(mean(mean(c(roi1,4:9,:),2),1))).^2,abs(squeeze(mean(mean(d(roi1,4:9,:),2),1))).^2,'r')


