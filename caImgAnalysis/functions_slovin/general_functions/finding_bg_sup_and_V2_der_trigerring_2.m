%% Normalization
%clear all
cd /fat2/Ariel_Gilad/Matlab_analysis/experiments/mask/legolas/right_hemisphere/psychophysics/2008_12_03/f

date='1203f';
load myrois

load pixels_to_remove
t=ones(10000,1);
t(pixels_to_remove)=0;
pixels=find(t);
clear t
roi_trig='roi_bg_in';
roi='roi_bg_in';

x=-250:10:250;
lim=28:48;

for c=[1 5]  
    disp(c)
    eval(['load cond',int2str(c),'n_dt_bl'])
    eval(['tr=size(cond',int2str(c),'n_dt_bl,3);']);
    eval(['cond=(cond',int2str(c),'n_dt_bl-1);'])
    der=cond(:,6:116,:)-cond(:,2:112,:);
    eval(['clear cond',int2str(c),'n_dt_bl'])
    peak=zeros(tr,1);
    peak_time=zeros(tr,1);
    der_time=zeros(tr,1);
    for i=1:tr    
        eval(['peak(i)=max(mean(cond(',roi_trig,',lim,i),1),[],2);']);
        eval(['peak_time(i)=find(mean(cond(',roi_trig,',:,i),1)==max(mean(cond(',roi_trig,',lim,i),1),[],2));']);
        eval(['der_time(i)=find(mean(der(',roi,',:,i),1)==max(mean(der(',roi,',peak_time(i)+3:peak_time(i)+12,i),1),[],2))+2;']);
    end
    eval(['der_max_time_',roi,'_',date,'_cond',int2str(c),'=der_time;']);
    eval(['time_bg_sup_',date,'_cond',int2str(c),'=peak_time;']);
    eval(['trig_bg_sup_',date,'_cond',int2str(c),'=zeros(size(x,2),tr);'])
    for i=1:tr
        eval(['trig_bg_sup_',date,'_cond',int2str(c),'(:,i)=squeeze(mean(cond(',roi,',peak_time(i)-25:peak_time(i)+25,i),1));'])
    end
    eval(['trig_der_',date,'_cond',int2str(c),'=zeros(size(x,2),tr);'])
    for i=1:tr
        eval(['trig_der_',date,'_cond',int2str(c),'(:,i)=squeeze(mean(der(',roi,',peak_time(i)-25:peak_time(i)+25,i),1));'])
    end
end









