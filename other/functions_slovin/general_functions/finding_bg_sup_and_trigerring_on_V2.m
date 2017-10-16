%% Normalization
%clear all
cd /fat2/Ariel_Gilad/Matlab_analysis/experiments/mask/legolas/right_hemisphere/psychophysics/2008_12_03/f

date='1203f';
load myrois

lim=28:48;

load pixels_to_remove
t=ones(10000,1);
t(pixels_to_remove)=0;
pixels=find(t);
clear t
roi_trig='roi_V2';
roi='roi_bg_in';

x=-250:10:250;

for c=[1 5]  
    disp(c)
    eval(['load cond',int2str(c),'n_dt_bl'])
    eval(['tr=size(cond',int2str(c),'n_dt_bl,3);']);
    eval(['cond=(cond',int2str(c),'n_dt_bl-1);'])
    der=cond(:,6:116,:)-cond(:,2:112,:);
    eval(['clear cond',int2str(c),'n_dt_bl'])
    peak=zeros(10000,tr);
    peak_time=zeros(10000,tr);
    for i=1:tr
        for j=1:10000
            peak(j,i)=max(cond(j,lim,i),[],2);
            peak_time(j,i)=find(cond(j,:,i)==max(cond(j,lim,i),[],2));
        end
    end
    der_time=zeros(10000,tr);
    for i=1:tr
        for j=1:10000
            der_time(j,i)=find(der(j,:,i)==max(der(j,peak_time(j,i)+3:peak_time(j,i)+10,i),[],2))+2;
        end
    end
    eval(['der_max_time_',roi,'_',date,'_cond',int2str(c),'=mean(der_time(',roi,',:));']);
    eval(['time_bg_sup_',date,'_cond',int2str(c),'=mean(peak_time(',roi_trig,',:));']);
    eval(['tt=round(mean(peak_time(',roi_trig,',:)));']);
    eval(['trig_bg_sup_',date,'_cond',int2str(c),'=zeros(size(x,2),tr);'])
    for i=1:tr
        eval(['trig_bg_sup_',date,'_cond',int2str(c),'(:,i)=squeeze(mean(cond(',roi,',tt(i)-25:tt(i)+25,i),1));'])
    end
end









