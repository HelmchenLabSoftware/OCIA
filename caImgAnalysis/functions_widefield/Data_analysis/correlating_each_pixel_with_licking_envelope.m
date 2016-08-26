cd D:\intrinsic\20150520\
load('20150520b.mat')
cd b
load('mouse_tgg6fl23_3_ses_b_20150520.mat')
st=1;
en=0;
go=[]; 
top_thresh=2.69;
bot_thresh=2.53;

time_lick=107:171; 
time_wf=100:164; 
x2=(1:180)*0.05-2.7;
x=(1:1500)*0.01-3;


cond='Texture 1 P100';
dec='Go';
ii=0;
for i=st:size(trials,1)-en
    if isequal(trials(i,1).stimulus,cond)
        if isequal(trials(i,1).decision,dec)
            if isequal(trials(i,1).report,'Report')
                ii=ii+1;
                if ii==1
                    go=trials(i,1).id;
                else
                    go=[go trials(i,1).id];
                end
            end
        end
    end
end

licks_go=nan*ones(1500,size(go,2));
k=0;
for i=go
    k=k+1;
    licks_go(1:size(licks(i).lick_vector(1,:),2),k)=licks(i).lick_vector(1,:); 
end


cd Matt_files
licks_go_norm=licks_go-repmat(nanmean(licks_go(2:100,:),1),1500,1);
% for i=1:size(licks_go_norm,2)
%     figure;plot(x,smooth(abs(licks_go_norm(:,i)),5,'Gauss'),'r')
% end

go_thresh=zeros(1500,size(licks_go,2));
go_thresh(licks_go>top_thresh)=1;
go_thresh(licks_go<bot_thresh)=1;
% for i=1:size(licks_go_norm,2)
%     figure;plot(x,smooth(go_thresh(:,i),27,'Gauss'),'r')
% end

load('rois_initial_205x205.mat')
load('trials_ind.mat')
load('pixels_to_remove.mat')

k=0;
for j=1:5:size(x,2)
    k=k+1;
    lick_trace(k,:)=nanmean(go_thresh(j:j+4,:),1);
    x_lick(k)=x(j);
end

lick_map=nan*ones(205*205,size(tr_100,2));
for i=1:size(tr_100,2)
    disp(i)
    eval(['load cond_100_trial',int2str(i)])
    d=reshape(tr,205*205,180);
    for j=1:size(d,1)
        tt=corrcoef(d(j,time_wf),smooth(lick_trace(time_lick,i),15,'Gauss'));
        lick_map(j,i)=tt(1,2);
    end   
end
save lick_map lick_map time_lick time_wf

load('trials_ind_clean_205x205.mat')
load rois_initial_205x205
h=zeros(205*205,1);
h(roi_s1)=1;
h(roi_s2)=1;
h(roi_m1)=1;
h(roi_m2)=1;
h(roi_a1)=1;
h(roi_alm)=1;

tr_100_c=ones(1,size(lick_map,2));
tr_100_c(tr_bad_100)=0;
lick_map_clean=lick_map(:,find(tr_100_c));
save lick_map_clean lick_map_clean time_lick time_wf


figure;imagesc(smoothn(nanmean(reshape(lick_map_clean,[205,205,size(lick_map_clean,2)]),3),[5 5],'Gauss'),[-.3 .5]);colormap(mapgeog)
hold on
contour(reshape(h,205,205),'r')




