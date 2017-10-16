
cd E:\data_for_israel_july_2015\20150520\b\Matt_files\
load('whisker_envelope_1200_clean.mat')
load('whisker_envelope_100_clean.mat')
load('whisker_envelope_100.mat')

load('trials_ind_clean_205x205.mat')
load('trials_ind.mat')
load('whisker_envelope.mat', 'x_env')

th=0.5;

for i=1:size(tr_1200_clean,2)
    t=smooth(whisk_env_1200_clean(:,i),3,'Gauss');
    wh_ind=t>th;
    tt=t;
    tt(wh_ind)=nan;
    t(~wh_ind)=nan;
    figure;
    plot(x_env,t)
    hold on
    plot(x_env,tt,'r')
    xlim([-2.5 5.5])
    ylim([-5 10])
end



for i=1:size(tr_100,2)
    t=smooth(whisk_env_100(:,i),3,'Gauss');
    wh_ind=t>th;
    tt=t;
    tt(wh_ind)=nan;
    t(~wh_ind)=nan;
    figure;
    plot(x_env,t)
    hold on
    plot(x_env,tt,'r')
    xlim([-2.5 5.5])
    ylim([-5 10])
end


%% a
k=0;
for i=[5 7 8 11 12 16 17 19 22 23 24 31]  
    disp(i)
    k=k+1;
    eval(['load cond_1200_trial',int2str(i)])
    %figure;imagesc(smoothn(nanmean(tr(:,:,50:60),3),[5 5],'Gauss')-1,[-1e-2 1e-2]);colormap(mapgeog)
    if k==1
        cond_1200_ave=tr;
    else
        cond_1200_ave=cond_1200_ave+tr;
    end
end
cond_1200_ave=cond_1200_ave/k;

figure;imagesc(smoothn(nanmean(cond_1200_ave(:,:,54:56),3),[5 5],'Gauss')-1,[-1e-2 1.5e-2]);colormap(mapgeog)

k=0;
for i=[18 26 28 29 30] 
    disp(i)
    k=k+1;
    eval(['load cond_1200_trial',int2str(i)])
    %figure;imagesc(smoothn(nanmean(tr(:,:,50:60),3),[5 5],'Gauss')-1,[-1e-2 1e-2]);colormap(mapgeog)
    if k==1
        cond_1200_ave_nw=tr;
    else
        cond_1200_ave_nw=cond_1200_ave_nw+tr;
    end
end
cond_1200_ave_nw=cond_1200_ave_nw/k;

figure;imagesc(smoothn(nanmean(cond_1200_ave_nw(:,:,54:56),3),[5 5],'Gauss')-1,[-1e-2 1.5e-2]);colormap(mapgeog)



k=0;
for i=[6 10 11 12 19 20 23 24 26 27 28 29 31]
    disp(i)
    k=k+1;
    eval(['load cond_100_trial',int2str(i)])
    %figure;imagesc(smoothn(nanmean(tr(:,:,50:60),3),[5 5],'Gauss')-1,[-1e-2 1e-2]);colormap(mapgeog)
    if k==1
        cond_100_ave=tr;
    else
        cond_100_ave=cond_100_ave+tr;
    end
end
cond_100_ave=cond_100_ave/k;

figure;imagesc(smoothn(nanmean(cond_100_ave(:,:,54:56),3),[5 5],'Gauss')-1,[-1e-2 1.5e-2]);colormap(mapgeog)


k=0;
for i=[2 3 5 8 16 17] 
    disp(i)
    k=k+1;
    eval(['load cond_100_trial',int2str(i)])
    %figure;imagesc(smoothn(nanmean(tr(:,:,50:60),3),[5 5],'Gauss')-1,[-1e-2 1e-2]);colormap(mapgeog)
    if k==1
        cond_100_ave_nw=tr;
    else
        cond_100_ave_nw=cond_100_ave_nw+tr;
    end
end
cond_100_ave_nw=cond_100_ave_nw/k;

figure;imagesc(smoothn(nanmean(cond_100_ave_nw(:,:,54:56),3),[5 5],'Gauss')-1,[-1e-2 1.5e-2]);colormap(mapgeog)


%% b
k=0;
for i=[5 7 8 14 17 22 27 28 29 30]  
    disp(i)
    k=k+1;
    eval(['load cond_1200_trial',int2str(i)])
    %figure;imagesc(smoothn(nanmean(tr(:,:,50:60),3),[5 5],'Gauss')-1,[-1e-2 1e-2]);colormap(mapgeog)
    if k==1
        cond_1200_ave=tr;
    else
        cond_1200_ave=cond_1200_ave+tr;
    end
end
cond_1200_ave=cond_1200_ave/k;

figure;imagesc(smoothn(nanmean(cond_1200_ave(:,:,54:56),3),[5 5],'Gauss')-1,[-1e-2 1.5e-2]);colormap(mapgeog)

k=0;
for i=[3 4 9 26 25 11 10] 
    disp(i)
    k=k+1;
    eval(['load cond_1200_trial',int2str(i)])
    %figure;imagesc(smoothn(nanmean(tr(:,:,50:60),3),[5 5],'Gauss')-1,[-1e-2 1e-2]);colormap(mapgeog)
    if k==1
        cond_1200_ave_nw=tr;
    else
        cond_1200_ave_nw=cond_1200_ave_nw+tr;
    end
end
cond_1200_ave_nw=cond_1200_ave_nw/k;

figure;imagesc(smoothn(nanmean(cond_1200_ave_nw(:,:,54:56),3),[5 5],'Gauss')-1,[-1e-2 1.5e-2]);colormap(mapgeog)



k=0;
for i=[4 8 12 13 14 16 19 23 25 26 27 28 30 32 34 38 39 40 41 43]
    disp(i)
    k=k+1;
    eval(['load cond_100_trial',int2str(i)])
    %figure;imagesc(smoothn(nanmean(tr(:,:,50:60),3),[5 5],'Gauss')-1,[-1e-2 1e-2]);colormap(mapgeog)
    if k==1
        cond_100_ave=tr;
    else
        cond_100_ave=cond_100_ave+tr;
    end
end
cond_100_ave=cond_100_ave/k;

figure;imagesc(smoothn(nanmean(cond_100_ave(:,:,54:56),3),[5 5],'Gauss')-1,[-1e-2 1.5e-2]);colormap(mapgeog)


k=0;
for i=[1 3 20 21 24 29] 
    disp(i)
    k=k+1;
    eval(['load cond_100_trial',int2str(i)])
    %figure;imagesc(smoothn(nanmean(tr(:,:,50:60),3),[5 5],'Gauss')-1,[-1e-2 1e-2]);colormap(mapgeog)
    if k==1
        cond_100_ave_nw=tr;
    else
        cond_100_ave_nw=cond_100_ave_nw+tr;
    end
end
cond_100_ave_nw=cond_100_ave_nw/k;

figure;imagesc(smoothn(nanmean(cond_100_ave_nw(:,:,54:56),3),[5 5],'Gauss')-1,[-1e-2 1.5e-2]);colormap(mapgeog)



%% c
k=0;
for i=[2 3 7 9 10 11 12 17 19 22 24 28 30 33 38 42 43 44 45]%[1 6 8 13 14 16 20 23 29 31 35 37 39 41 46] 
    disp(i)
    k=k+1;
    eval(['load cond_1200_trial',int2str(i)])
    %figure;imagesc(smoothn(nanmean(tr(:,:,50:60),3),[5 5],'Gauss')-1,[-1e-2 1e-2]);colormap(mapgeog)
    if k==1
        cond_1200_ave=tr;
    else
        cond_1200_ave=cond_1200_ave+tr;
    end
end
cond_1200_ave=cond_1200_ave/k;

figure;imagesc(smoothn(nanmean(cond_1200_ave(:,:,54:56),3),[5 5],'Gauss')-1,[-1e-2 1.5e-2]);colormap(mapgeog)

k=0;
for i=[1 6 8 13 14 16 20 23 29 31 35 37 39 41 46] 
    disp(i)
    k=k+1;
    eval(['load cond_1200_trial',int2str(i)])
    %figure;imagesc(smoothn(nanmean(tr(:,:,50:60),3),[5 5],'Gauss')-1,[-1e-2 1e-2]);colormap(mapgeog)
    if k==1
        cond_1200_ave_nw=tr;
    else
        cond_1200_ave_nw=cond_1200_ave_nw+tr;
    end
end
cond_1200_ave_nw=cond_1200_ave_nw/k;

figure;imagesc(smoothn(nanmean(cond_1200_ave_nw(:,:,54:56),3),[5 5],'Gauss')-1,[-1e-2 1.5e-2]);colormap(mapgeog)






k=0;
for i=[2 3 4 5 6 8 9 12 13 18 19 22 2 29 30 32 37 39 40 42 44 45]%[27 28 33 38 43 47 48 50]%[2:7 9:12 15 17:19 21:26 28 30 32:34 36 28 40 42:45] 
    disp(i)
    k=k+1;
    eval(['load cond_100_trial',int2str(i)])
    %figure;imagesc(smoothn(nanmean(tr(:,:,50:60),3),[5 5],'Gauss')-1,[-1e-2 1e-2]);colormap(mapgeog)
    if k==1
        cond_100_ave=tr;
    else
        cond_100_ave=cond_100_ave+tr;
    end
end
cond_100_ave=cond_100_ave/k;

figure;imagesc(smoothn(nanmean(cond_100_ave(:,:,54:56),3),[5 5],'Gauss')-1,[-1e-2 1.5e-2]);colormap(mapgeog)


k=0;
for i=[27 28 33 38 43 47 48 50]%[2:7 9:12 15 17:19 21:26 28 30 32:34 36 28 40 42:45] 
    disp(i)
    k=k+1;
    eval(['load cond_100_trial',int2str(i)])
    %figure;imagesc(smoothn(nanmean(tr(:,:,50:60),3),[5 5],'Gauss')-1,[-1e-2 1e-2]);colormap(mapgeog)
    if k==1
        cond_100_ave_nw=tr;
    else
        cond_100_ave_nw=cond_100_ave_nw+tr;
    end
end
cond_100_ave_nw=cond_100_ave_nw/k;

figure;imagesc(smoothn(nanmean(cond_100_ave_nw(:,:,54:56),3),[5 5],'Gauss')-1,[-1e-2 1.5e-2]);colormap(mapgeog)


%%

