cd E:\data_for_israel_july_2015\20150521\c\Matt_files
load('whisker_envelope_1200_clean.mat')
load('whisker_envelope_100_clean.mat')

load('trials_ind_clean_205x205.mat')
load('trials_ind.mat')
load('whisker_envelope.mat', 'x_env')

th=0.5;


tr1200=1:size(tr_1200,2);
tr1200(tr_bad_1200)=[];
k=0;
for i=1:size(tr1200,2)
    t=smooth(whisk_env_1200_clean(:,i),3,'Gauss');
    wh_ind=t>th;
    if sum(wh_ind(45:91))==0
        k=k+1;
        tr1200_no_whisk(k)=tr1200(i);
    end
end

k=0;
for i=tr1200_no_whisk
    disp(i)
    k=k+1;
    eval(['load cond_1200_trial',int2str(i)])
    figure;imagesc(smoothn(nanmean(tr(:,:,50:60),3),[5 5],'Gauss')-1,[-1e-2 1e-2]);colormap(mapgeog)
    if k==1
        cond_1200_ave=tr;
    else
        cond_1200_ave=cond_1200_ave+tr;
    end
end
cond_1200_ave=cond_1200_ave/k;


tr100=1:size(tr_100,2);
tr100(tr_bad_100)=[];
k=0;
for i=1:size(tr100,2)
    t=smooth(whisk_env_100_clean(:,i),3,'Gauss');
    wh_ind=t>th;
    if sum(wh_ind(45:91))==0
        k=k+1;
        tr100_no_whisk(k)=tr100(i);
%         tt=t;
%         tt(wh_ind)=nan;
%         t(~wh_ind)=nan;
%         figure;
%         plot(x_env,t)
%         hold on
%         plot(x_env,tt,'r')
%         xlim([-2.5 5.5])
%         ylim([-5 10])
        
    end
end


k=0;
for i=tr100_no_whisk
    disp(i)
    k=k+1;
    eval(['load cond_100_trial',int2str(i)])
    figure;imagesc(smoothn(nanmean(tr(:,:,50:60),3),[5 5],'Gauss')-1,[-1e-2 1e-2]);colormap(mapgeog)
    if k==1
        cond_100_ave=tr;
    else
        cond_100_ave=cond_100_ave+tr;
    end
end
cond_100_ave=cond_100_ave/k;


figure;imagesc(smoothn(nanmean(cond_100_ave(:,:,50:60),3),[5 5],'Gauss')-1,[-1e-2 1e-2]);colormap(mapgeog)

figure;imagesc(smoothn(nanmean(cond_1200_ave(:,:,50:60),3),[5 5],'Gauss')-1,[-1e-2 1e-2]);colormap(mapgeog)















