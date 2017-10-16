cd D:\intrinsic\20150617\a\Matt_files
load('whisker_envelope.mat')
load('pixels_to_remove.mat')
x=(1:180)*0.05-2.7;
time_whisk=21:121;%9:161; % 105:149;  %9:42
time_wf=14:114; %2:154; %98:142; %2:35 

list1 = dir('stim_trial*');

whisk_map=nan*ones(205*205,size(list1,1));
for i=1:size(list1,1)
    disp(i)
    eval(['load stim_trial',int2str(i)])
    d=reshape(tr,205*205,size(tr,3));
    for j=1:size(d,1)
        ss=sum(isnan(d(j,time_wf)));
        if ss==size(time_wf,2)
            whisk_map(j,i)=nan;
        else
            www=d(j,time_wf(1):time_wf(end-ss));
            kkk=whisk_env(time_whisk(1):time_whisk(end-ss),i);
            tt=corrcoef(www,kkk);
            whisk_map(j,i)=tt(1,2);
        end
    end   
end
save whisk_map_short whisk_map time_whisk time_wf


figure;imagesc(smoothn(nanmean(reshape(whisk_map,[205,205,size(whisk_map,2)]),3),[5 5],'Gauss'),[.1 .4]);colormap(mapgeog)



