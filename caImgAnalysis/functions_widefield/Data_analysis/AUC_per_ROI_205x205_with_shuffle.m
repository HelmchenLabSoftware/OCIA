


cd D:\intrinsic\20150128\a\Matt_files
load('trials_ind_clean_205x205.mat')
load rois_initial_205x205
list100 = dir('cond_100_trial*');
tr_100_c=ones(1,size(list100,1));
tr_100_c(tr_bad_100)=0;
ff=find(tr_100_c==1);
k=0;
for i=ff
    k=k+1;
    disp(i)
    eval(['load cond_100_trial',int2str(i)])
    if k==1
        cond_100=tr;
    else
        cond_100=cat(4,cond_100,tr);
    end
end
cond_100=reshape(cond_100,205*205,180,size(cond_100,4));

list1200 = dir('cond_1200_trial*');
tr_1200_c=ones(1,size(list1200,1));
tr_1200_c(tr_bad_1200)=0;
gg=find(tr_1200_c==1);
k=0;
for i=gg
    k=k+1;
    disp(i)
    eval(['load cond_1200_trial',int2str(i)])
    if k==1
        cond_1200=tr;
    else
        cond_1200=cat(4,cond_1200,tr);
    end
end
cond_1200=reshape(cond_1200,205*205,180,size(cond_1200,4));


cond_100_m2=squeeze(nanmean(cond_100(roi_m2,:,:),1));
cond_1200_m2=squeeze(nanmean(cond_1200(roi_m2,:,:),1));
AUC_m2_time=nan*ones(1,180);
for i=1:180
    scores=[squeeze(nanmean(cond_100_m2(i,:),1)),squeeze(nanmean(cond_1200_m2(i,:),1))];
    labels=ones(1,size(scores,2));
    labels(size(cond_100,3)+1:end)=0;
    [X,Y,THRE,AUC_m2_time(i),OPTROCPT,SUBY,SUBYNAMES] = perfcurve(labels,scores,1);
end
iter=100;
AUC_m2_time_sh=nan*ones(180,iter);
tot=cat(2,cond_100_m2,cond_1200_m2);
for it=1:iter
    disp(it)
    r=randperm(size(tot,2));
    temp=tot(:,r(1:size(cond_100_m2,2)));
    temp2=tot(:,r(size(cond_100_m2,2)+1:end));
    for i=1:180
        scores=[temp(i,:),temp2(i,:)];
        labels=ones(1,size(scores,2));
        labels(size(cond_100,3)+1:end)=0;
        [X,Y,THRE,AUC_m2_time_sh(i,it),OPTROCPT,SUBY,SUBYNAMES] = perfcurve(labels,scores,1);
    end
end
x=(1:180)*0.05-2.7;
figure;plot(x,AUC_m2_time,'k')
hold on
plot(x,nanmean(AUC_m2_time_sh,2)+2*nanstd(AUC_m2_time_sh,0,2),'--k')
plot(x,nanmean(AUC_m2_time_sh,2)-2*nanstd(AUC_m2_time_sh,0,2),'--k')





cond_100_a1=squeeze(nanmean(cond_100(roi_a1,:,:),1));
cond_1200_a1=squeeze(nanmean(cond_1200(roi_a1,:,:),1));
AUC_a1_time=nan*ones(1,180);
for i=1:180
    scores=[squeeze(nanmean(cond_100_a1(i,:),1)),squeeze(nanmean(cond_1200_a1(i,:),1))];
    labels=ones(1,size(scores,2));
    labels(size(cond_100,3)+1:end)=0;
    [X,Y,THRE,AUC_a1_time(i),OPTROCPT,SUBY,SUBYNAMES] = perfcurve(labels,scores,1);
end
iter=100;
AUC_a1_time_sh=nan*ones(180,iter);
tot=cat(2,cond_100_a1,cond_1200_a1);
for it=1:iter
    disp(it)
    r=randperm(size(tot,2));
    temp=tot(:,r(1:size(cond_100_a1,2)));
    temp2=tot(:,r(size(cond_100_a1,2)+1:end));
    for i=1:180
        scores=[temp(i,:),temp2(i,:)];
        labels=ones(1,size(scores,2));
        labels(size(cond_100,3)+1:end)=0;
        [X,Y,THRE,AUC_a1_time_sh(i,it),OPTROCPT,SUBY,SUBYNAMES] = perfcurve(labels,scores,1);
    end
end
x=(1:180)*0.05-2.7;
figure;plot(x,AUC_a1_time,'g')
hold on
plot(x,nanmean(AUC_a1_time_sh,2)+2*nanstd(AUC_a1_time_sh,0,2),'--k')
plot(x,nanmean(AUC_a1_time_sh,2)-2*nanstd(AUC_a1_time_sh,0,2),'--k')


cond_100_s1=squeeze(nanmean(cond_100(roi_s1,:,:),1));
cond_1200_s1=squeeze(nanmean(cond_1200(roi_s1,:,:),1));
AUC_s1_time=nan*ones(1,180);
for i=1:180
    scores=[squeeze(nanmean(cond_100_s1(i,:),1)),squeeze(nanmean(cond_1200_s1(i,:),1))];
    labels=ones(1,size(scores,2));
    labels(size(cond_100,3)+1:end)=0;
    [X,Y,THRE,AUC_s1_time(i),OPTROCPT,SUBY,SUBYNAMES] = perfcurve(labels,scores,1);
end
iter=100;
AUC_s1_time_sh=nan*ones(180,iter);
tot=cat(2,cond_100_s1,cond_1200_s1);
for it=1:iter
    disp(it)
    r=randperm(size(tot,2));
    temp=tot(:,r(1:size(cond_100_s1,2)));
    temp2=tot(:,r(size(cond_100_s1,2)+1:end));
    for i=1:180
        scores=[temp(i,:),temp2(i,:)];
        labels=ones(1,size(scores,2));
        labels(size(cond_100,3)+1:end)=0;
        [X,Y,THRE,AUC_s1_time_sh(i,it),OPTROCPT,SUBY,SUBYNAMES] = perfcurve(labels,scores,1);
    end
end
x=(1:180)*0.05-2.7;
figure;plot(x,AUC_s1_time,'b')
hold on
plot(x,nanmean(AUC_s1_time_sh,2)+2*nanstd(AUC_s1_time_sh,0,2),'--k')
plot(x,nanmean(AUC_s1_time_sh,2)-2*nanstd(AUC_s1_time_sh,0,2),'--k')


cond_100_m1=squeeze(nanmean(cond_100(roi_m1,:,:),1));
cond_1200_m1=squeeze(nanmean(cond_1200(roi_m1,:,:),1));
AUC_m1_time=nan*ones(1,180);
for i=1:180
    scores=[squeeze(nanmean(cond_100_m1(i,:),1)),squeeze(nanmean(cond_1200_m1(i,:),1))];
    labels=ones(1,size(scores,2));
    labels(size(cond_100,3)+1:end)=0;
    [X,Y,THRE,AUC_m1_time(i),OPTROCPT,SUBY,SUBYNAMES] = perfcurve(labels,scores,1);
end
iter=100;
AUC_m1_time_sh=nan*ones(180,iter);
tot=cat(2,cond_100_m1,cond_1200_m1);
for it=1:iter
    disp(it)
    r=randperm(size(tot,2));
    temp=tot(:,r(1:size(cond_100_m1,2)));
    temp2=tot(:,r(size(cond_100_m1,2)+1:end));
    for i=1:180
        scores=[temp(i,:),temp2(i,:)];
        labels=ones(1,size(scores,2));
        labels(size(cond_100,3)+1:end)=0;
        [X,Y,THRE,AUC_m1_time_sh(i,it),OPTROCPT,SUBY,SUBYNAMES] = perfcurve(labels,scores,1);
    end
end
x=(1:180)*0.05-2.7;
figure;plot(x,AUC_m1_time,'r')
hold on
plot(x,nanmean(AUC_m1_time_sh,2)+2*nanstd(AUC_m1_time_sh,0,2),'--k')
plot(x,nanmean(AUC_m1_time_sh,2)-2*nanstd(AUC_m1_time_sh,0,2),'--k')


cond_100_s2=squeeze(nanmean(cond_100(roi_s2,:,:),1));
cond_1200_s2=squeeze(nanmean(cond_1200(roi_s2,:,:),1));
AUC_s2_time=nan*ones(1,180);
for i=1:180
    scores=[squeeze(nanmean(cond_100_s2(i,:),1)),squeeze(nanmean(cond_1200_s2(i,:),1))];
    labels=ones(1,size(scores,2));
    labels(size(cond_100,3)+1:end)=0;
    [X,Y,THRE,AUC_s2_time(i),OPTROCPT,SUBY,SUBYNAMES] = perfcurve(labels,scores,1);
end
iter=100;
AUC_s2_time_sh=nan*ones(180,iter);
tot=cat(2,cond_100_s2,cond_1200_s2);
for it=1:iter
    disp(it)
    r=randperm(size(tot,2));
    temp=tot(:,r(1:size(cond_100_s2,2)));
    temp2=tot(:,r(size(cond_100_s2,2)+1:end));
    for i=1:180
        scores=[temp(i,:),temp2(i,:)];
        labels=ones(1,size(scores,2));
        labels(size(cond_100,3)+1:end)=0;
        [X,Y,THRE,AUC_s2_time_sh(i,it),OPTROCPT,SUBY,SUBYNAMES] = perfcurve(labels,scores,1);
    end
end
x=(1:180)*0.05-2.7;
figure;plot(x,AUC_s2_time,'c')
hold on
plot(x,nanmean(AUC_s2_time_sh,2)+2*nanstd(AUC_s2_time_sh,0,2),'--k')
plot(x,nanmean(AUC_s2_time_sh,2)-2*nanstd(AUC_s2_time_sh,0,2),'--k')


cond_100_alm=squeeze(nanmean(cond_100(roi_alm,:,:),1));
cond_1200_alm=squeeze(nanmean(cond_1200(roi_alm,:,:),1));
AUC_alm_time=nan*ones(1,180);
for i=1:180
    scores=[squeeze(nanmean(cond_100_alm(i,:),1)),squeeze(nanmean(cond_1200_alm(i,:),1))];
    labels=ones(1,size(scores,2));
    labels(size(cond_100,3)+1:end)=0;
    [X,Y,THRE,AUC_alm_time(i),OPTROCPT,SUBY,SUBYNAMES] = perfcurve(labels,scores,1);
end
iter=100;
AUC_alm_time_sh=nan*ones(180,iter);
tot=cat(2,cond_100_alm,cond_1200_alm);
for it=1:iter
    disp(it)
    r=randperm(size(tot,2));
    temp=tot(:,r(1:size(cond_100_alm,2)));
    temp2=tot(:,r(size(cond_100_alm,2)+1:end));
    for i=1:180
        scores=[temp(i,:),temp2(i,:)];
        labels=ones(1,size(scores,2));
        labels(size(cond_100,3)+1:end)=0;
        [X,Y,THRE,AUC_alm_time_sh(i,it),OPTROCPT,SUBY,SUBYNAMES] = perfcurve(labels,scores,1);
    end
end
x=(1:180)*0.05-2.7;
figure;plot(x,AUC_alm_time,'m')
hold on
plot(x,nanmean(AUC_alm_time_sh,2)+2*nanstd(AUC_alm_time_sh,0,2),'--k')
plot(x,nanmean(AUC_alm_time_sh,2)-2*nanstd(AUC_alm_time_sh,0,2),'--k')


save AUC_per_roi AUC_*

figure;plot(x,AUC_alm_time,'m')
hold on
plot(x,AUC_s1_time,'b')
plot(x,AUC_s2_time,'c')
plot(x,AUC_m1_time,'r')
plot(x,AUC_m2_time,'k')
plot(x,AUC_a1_time,'g')
plot(x,0.5*ones(1,180),'--k')
legend('s1','s2','m1','m2','alm','a1')


cd D:\intrinsic\20150128\b\Matt_files
load('trials_ind_clean_205x205.mat')
load rois_initial_205x205
list100 = dir('cond_100_trial*');
tr_100_c=ones(1,size(list100,1));
tr_100_c(tr_bad_100)=0;
ff=find(tr_100_c==1);
k=0;
for i=ff
    k=k+1;
    disp(i)
    eval(['load cond_100_trial',int2str(i)])
    if k==1
        cond_100=tr;
    else
        cond_100=cat(4,cond_100,tr);
    end
end
cond_100=reshape(cond_100,205*205,180,size(cond_100,4));

list1200 = dir('cond_1200_trial*');
tr_1200_c=ones(1,size(list1200,1));
tr_1200_c(tr_bad_1200)=0;
gg=find(tr_1200_c==1);
k=0;
for i=gg
    k=k+1;
    disp(i)
    eval(['load cond_1200_trial',int2str(i)])
    if k==1
        cond_1200=tr;
    else
        cond_1200=cat(4,cond_1200,tr);
    end
end
cond_1200=reshape(cond_1200,205*205,180,size(cond_1200,4));


cond_100_m2=squeeze(nanmean(cond_100(roi_m2,:,:),1));
cond_1200_m2=squeeze(nanmean(cond_1200(roi_m2,:,:),1));
AUC_m2_time=nan*ones(1,180);
for i=1:180
    scores=[squeeze(nanmean(cond_100_m2(i,:),1)),squeeze(nanmean(cond_1200_m2(i,:),1))];
    labels=ones(1,size(scores,2));
    labels(size(cond_100,3)+1:end)=0;
    [X,Y,THRE,AUC_m2_time(i),OPTROCPT,SUBY,SUBYNAMES] = perfcurve(labels,scores,1);
end
iter=100;
AUC_m2_time_sh=nan*ones(180,iter);
tot=cat(2,cond_100_m2,cond_1200_m2);
for it=1:iter
    disp(it)
    r=randperm(size(tot,2));
    temp=tot(:,r(1:size(cond_100_m2,2)));
    temp2=tot(:,r(size(cond_100_m2,2)+1:end));
    for i=1:180
        scores=[temp(i,:),temp2(i,:)];
        labels=ones(1,size(scores,2));
        labels(size(cond_100,3)+1:end)=0;
        [X,Y,THRE,AUC_m2_time_sh(i,it),OPTROCPT,SUBY,SUBYNAMES] = perfcurve(labels,scores,1);
    end
end
x=(1:180)*0.05-2.7;
figure;plot(x,AUC_m2_time,'k')
hold on
plot(x,nanmean(AUC_m2_time_sh,2)+2*nanstd(AUC_m2_time_sh,0,2),'--k')
plot(x,nanmean(AUC_m2_time_sh,2)-2*nanstd(AUC_m2_time_sh,0,2),'--k')





cond_100_a1=squeeze(nanmean(cond_100(roi_a1,:,:),1));
cond_1200_a1=squeeze(nanmean(cond_1200(roi_a1,:,:),1));
AUC_a1_time=nan*ones(1,180);
for i=1:180
    scores=[squeeze(nanmean(cond_100_a1(i,:),1)),squeeze(nanmean(cond_1200_a1(i,:),1))];
    labels=ones(1,size(scores,2));
    labels(size(cond_100,3)+1:end)=0;
    [X,Y,THRE,AUC_a1_time(i),OPTROCPT,SUBY,SUBYNAMES] = perfcurve(labels,scores,1);
end
iter=100;
AUC_a1_time_sh=nan*ones(180,iter);
tot=cat(2,cond_100_a1,cond_1200_a1);
for it=1:iter
    disp(it)
    r=randperm(size(tot,2));
    temp=tot(:,r(1:size(cond_100_a1,2)));
    temp2=tot(:,r(size(cond_100_a1,2)+1:end));
    for i=1:180
        scores=[temp(i,:),temp2(i,:)];
        labels=ones(1,size(scores,2));
        labels(size(cond_100,3)+1:end)=0;
        [X,Y,THRE,AUC_a1_time_sh(i,it),OPTROCPT,SUBY,SUBYNAMES] = perfcurve(labels,scores,1);
    end
end
x=(1:180)*0.05-2.7;
figure;plot(x,AUC_a1_time,'g')
hold on
plot(x,nanmean(AUC_a1_time_sh,2)+2*nanstd(AUC_a1_time_sh,0,2),'--k')
plot(x,nanmean(AUC_a1_time_sh,2)-2*nanstd(AUC_a1_time_sh,0,2),'--k')


cond_100_s1=squeeze(nanmean(cond_100(roi_s1,:,:),1));
cond_1200_s1=squeeze(nanmean(cond_1200(roi_s1,:,:),1));
AUC_s1_time=nan*ones(1,180);
for i=1:180
    scores=[squeeze(nanmean(cond_100_s1(i,:),1)),squeeze(nanmean(cond_1200_s1(i,:),1))];
    labels=ones(1,size(scores,2));
    labels(size(cond_100,3)+1:end)=0;
    [X,Y,THRE,AUC_s1_time(i),OPTROCPT,SUBY,SUBYNAMES] = perfcurve(labels,scores,1);
end
iter=100;
AUC_s1_time_sh=nan*ones(180,iter);
tot=cat(2,cond_100_s1,cond_1200_s1);
for it=1:iter
    disp(it)
    r=randperm(size(tot,2));
    temp=tot(:,r(1:size(cond_100_s1,2)));
    temp2=tot(:,r(size(cond_100_s1,2)+1:end));
    for i=1:180
        scores=[temp(i,:),temp2(i,:)];
        labels=ones(1,size(scores,2));
        labels(size(cond_100,3)+1:end)=0;
        [X,Y,THRE,AUC_s1_time_sh(i,it),OPTROCPT,SUBY,SUBYNAMES] = perfcurve(labels,scores,1);
    end
end
x=(1:180)*0.05-2.7;
figure;plot(x,AUC_s1_time,'b')
hold on
plot(x,nanmean(AUC_s1_time_sh,2)+2*nanstd(AUC_s1_time_sh,0,2),'--k')
plot(x,nanmean(AUC_s1_time_sh,2)-2*nanstd(AUC_s1_time_sh,0,2),'--k')


cond_100_m1=squeeze(nanmean(cond_100(roi_m1,:,:),1));
cond_1200_m1=squeeze(nanmean(cond_1200(roi_m1,:,:),1));
AUC_m1_time=nan*ones(1,180);
for i=1:180
    scores=[squeeze(nanmean(cond_100_m1(i,:),1)),squeeze(nanmean(cond_1200_m1(i,:),1))];
    labels=ones(1,size(scores,2));
    labels(size(cond_100,3)+1:end)=0;
    [X,Y,THRE,AUC_m1_time(i),OPTROCPT,SUBY,SUBYNAMES] = perfcurve(labels,scores,1);
end
iter=100;
AUC_m1_time_sh=nan*ones(180,iter);
tot=cat(2,cond_100_m1,cond_1200_m1);
for it=1:iter
    disp(it)
    r=randperm(size(tot,2));
    temp=tot(:,r(1:size(cond_100_m1,2)));
    temp2=tot(:,r(size(cond_100_m1,2)+1:end));
    for i=1:180
        scores=[temp(i,:),temp2(i,:)];
        labels=ones(1,size(scores,2));
        labels(size(cond_100,3)+1:end)=0;
        [X,Y,THRE,AUC_m1_time_sh(i,it),OPTROCPT,SUBY,SUBYNAMES] = perfcurve(labels,scores,1);
    end
end
x=(1:180)*0.05-2.7;
figure;plot(x,AUC_m1_time,'r')
hold on
plot(x,nanmean(AUC_m1_time_sh,2)+2*nanstd(AUC_m1_time_sh,0,2),'--k')
plot(x,nanmean(AUC_m1_time_sh,2)-2*nanstd(AUC_m1_time_sh,0,2),'--k')


cond_100_s2=squeeze(nanmean(cond_100(roi_s2,:,:),1));
cond_1200_s2=squeeze(nanmean(cond_1200(roi_s2,:,:),1));
AUC_s2_time=nan*ones(1,180);
for i=1:180
    scores=[squeeze(nanmean(cond_100_s2(i,:),1)),squeeze(nanmean(cond_1200_s2(i,:),1))];
    labels=ones(1,size(scores,2));
    labels(size(cond_100,3)+1:end)=0;
    [X,Y,THRE,AUC_s2_time(i),OPTROCPT,SUBY,SUBYNAMES] = perfcurve(labels,scores,1);
end
iter=100;
AUC_s2_time_sh=nan*ones(180,iter);
tot=cat(2,cond_100_s2,cond_1200_s2);
for it=1:iter
    disp(it)
    r=randperm(size(tot,2));
    temp=tot(:,r(1:size(cond_100_s2,2)));
    temp2=tot(:,r(size(cond_100_s2,2)+1:end));
    for i=1:180
        scores=[temp(i,:),temp2(i,:)];
        labels=ones(1,size(scores,2));
        labels(size(cond_100,3)+1:end)=0;
        [X,Y,THRE,AUC_s2_time_sh(i,it),OPTROCPT,SUBY,SUBYNAMES] = perfcurve(labels,scores,1);
    end
end
x=(1:180)*0.05-2.7;
figure;plot(x,AUC_s2_time,'c')
hold on
plot(x,nanmean(AUC_s2_time_sh,2)+2*nanstd(AUC_s2_time_sh,0,2),'--k')
plot(x,nanmean(AUC_s2_time_sh,2)-2*nanstd(AUC_s2_time_sh,0,2),'--k')


cond_100_alm=squeeze(nanmean(cond_100(roi_alm,:,:),1));
cond_1200_alm=squeeze(nanmean(cond_1200(roi_alm,:,:),1));
AUC_alm_time=nan*ones(1,180);
for i=1:180
    scores=[squeeze(nanmean(cond_100_alm(i,:),1)),squeeze(nanmean(cond_1200_alm(i,:),1))];
    labels=ones(1,size(scores,2));
    labels(size(cond_100,3)+1:end)=0;
    [X,Y,THRE,AUC_alm_time(i),OPTROCPT,SUBY,SUBYNAMES] = perfcurve(labels,scores,1);
end
iter=100;
AUC_alm_time_sh=nan*ones(180,iter);
tot=cat(2,cond_100_alm,cond_1200_alm);
for it=1:iter
    disp(it)
    r=randperm(size(tot,2));
    temp=tot(:,r(1:size(cond_100_alm,2)));
    temp2=tot(:,r(size(cond_100_alm,2)+1:end));
    for i=1:180
        scores=[temp(i,:),temp2(i,:)];
        labels=ones(1,size(scores,2));
        labels(size(cond_100,3)+1:end)=0;
        [X,Y,THRE,AUC_alm_time_sh(i,it),OPTROCPT,SUBY,SUBYNAMES] = perfcurve(labels,scores,1);
    end
end
x=(1:180)*0.05-2.7;
figure;plot(x,AUC_alm_time,'m')
hold on
plot(x,nanmean(AUC_alm_time_sh,2)+2*nanstd(AUC_alm_time_sh,0,2),'--k')
plot(x,nanmean(AUC_alm_time_sh,2)-2*nanstd(AUC_alm_time_sh,0,2),'--k')


save AUC_per_roi AUC_*

figure;plot(x,AUC_alm_time,'m')
hold on
plot(x,AUC_s1_time,'b')
plot(x,AUC_s2_time,'c')
plot(x,AUC_m1_time,'r')
plot(x,AUC_m2_time,'k')
plot(x,AUC_a1_time,'g')
plot(x,0.5*ones(1,180),'--k')
legend('s1','s2','m1','m2','alm','a1')


cd D:\intrinsic\20150128\c\Matt_files
load('trials_ind_clean_205x205.mat')
load rois_initial_205x205
list100 = dir('cond_100_trial*');
tr_100_c=ones(1,size(list100,1));
tr_100_c(tr_bad_100)=0;
ff=find(tr_100_c==1);
k=0;
for i=ff
    k=k+1;
    disp(i)
    eval(['load cond_100_trial',int2str(i)])
    if k==1
        cond_100=tr;
    else
        cond_100=cat(4,cond_100,tr);
    end
end
cond_100=reshape(cond_100,205*205,180,size(cond_100,4));

list1200 = dir('cond_1200_trial*');
tr_1200_c=ones(1,size(list1200,1));
tr_1200_c(tr_bad_1200)=0;
gg=find(tr_1200_c==1);
k=0;
for i=gg
    k=k+1;
    disp(i)
    eval(['load cond_1200_trial',int2str(i)])
    if k==1
        cond_1200=tr;
    else
        cond_1200=cat(4,cond_1200,tr);
    end
end
cond_1200=reshape(cond_1200,205*205,180,size(cond_1200,4));


cond_100_m2=squeeze(nanmean(cond_100(roi_m2,:,:),1));
cond_1200_m2=squeeze(nanmean(cond_1200(roi_m2,:,:),1));
AUC_m2_time=nan*ones(1,180);
for i=1:180
    scores=[squeeze(nanmean(cond_100_m2(i,:),1)),squeeze(nanmean(cond_1200_m2(i,:),1))];
    labels=ones(1,size(scores,2));
    labels(size(cond_100,3)+1:end)=0;
    [X,Y,THRE,AUC_m2_time(i),OPTROCPT,SUBY,SUBYNAMES] = perfcurve(labels,scores,1);
end
iter=100;
AUC_m2_time_sh=nan*ones(180,iter);
tot=cat(2,cond_100_m2,cond_1200_m2);
for it=1:iter
    disp(it)
    r=randperm(size(tot,2));
    temp=tot(:,r(1:size(cond_100_m2,2)));
    temp2=tot(:,r(size(cond_100_m2,2)+1:end));
    for i=1:180
        scores=[temp(i,:),temp2(i,:)];
        labels=ones(1,size(scores,2));
        labels(size(cond_100,3)+1:end)=0;
        [X,Y,THRE,AUC_m2_time_sh(i,it),OPTROCPT,SUBY,SUBYNAMES] = perfcurve(labels,scores,1);
    end
end
x=(1:180)*0.05-2.7;
figure;plot(x,AUC_m2_time,'k')
hold on
plot(x,nanmean(AUC_m2_time_sh,2)+2*nanstd(AUC_m2_time_sh,0,2),'--k')
plot(x,nanmean(AUC_m2_time_sh,2)-2*nanstd(AUC_m2_time_sh,0,2),'--k')





cond_100_a1=squeeze(nanmean(cond_100(roi_a1,:,:),1));
cond_1200_a1=squeeze(nanmean(cond_1200(roi_a1,:,:),1));
AUC_a1_time=nan*ones(1,180);
for i=1:180
    scores=[squeeze(nanmean(cond_100_a1(i,:),1)),squeeze(nanmean(cond_1200_a1(i,:),1))];
    labels=ones(1,size(scores,2));
    labels(size(cond_100,3)+1:end)=0;
    [X,Y,THRE,AUC_a1_time(i),OPTROCPT,SUBY,SUBYNAMES] = perfcurve(labels,scores,1);
end
iter=100;
AUC_a1_time_sh=nan*ones(180,iter);
tot=cat(2,cond_100_a1,cond_1200_a1);
for it=1:iter
    disp(it)
    r=randperm(size(tot,2));
    temp=tot(:,r(1:size(cond_100_a1,2)));
    temp2=tot(:,r(size(cond_100_a1,2)+1:end));
    for i=1:180
        scores=[temp(i,:),temp2(i,:)];
        labels=ones(1,size(scores,2));
        labels(size(cond_100,3)+1:end)=0;
        [X,Y,THRE,AUC_a1_time_sh(i,it),OPTROCPT,SUBY,SUBYNAMES] = perfcurve(labels,scores,1);
    end
end
x=(1:180)*0.05-2.7;
figure;plot(x,AUC_a1_time,'g')
hold on
plot(x,nanmean(AUC_a1_time_sh,2)+2*nanstd(AUC_a1_time_sh,0,2),'--k')
plot(x,nanmean(AUC_a1_time_sh,2)-2*nanstd(AUC_a1_time_sh,0,2),'--k')


cond_100_s1=squeeze(nanmean(cond_100(roi_s1,:,:),1));
cond_1200_s1=squeeze(nanmean(cond_1200(roi_s1,:,:),1));
AUC_s1_time=nan*ones(1,180);
for i=1:180
    scores=[squeeze(nanmean(cond_100_s1(i,:),1)),squeeze(nanmean(cond_1200_s1(i,:),1))];
    labels=ones(1,size(scores,2));
    labels(size(cond_100,3)+1:end)=0;
    [X,Y,THRE,AUC_s1_time(i),OPTROCPT,SUBY,SUBYNAMES] = perfcurve(labels,scores,1);
end
iter=100;
AUC_s1_time_sh=nan*ones(180,iter);
tot=cat(2,cond_100_s1,cond_1200_s1);
for it=1:iter
    disp(it)
    r=randperm(size(tot,2));
    temp=tot(:,r(1:size(cond_100_s1,2)));
    temp2=tot(:,r(size(cond_100_s1,2)+1:end));
    for i=1:180
        scores=[temp(i,:),temp2(i,:)];
        labels=ones(1,size(scores,2));
        labels(size(cond_100,3)+1:end)=0;
        [X,Y,THRE,AUC_s1_time_sh(i,it),OPTROCPT,SUBY,SUBYNAMES] = perfcurve(labels,scores,1);
    end
end
x=(1:180)*0.05-2.7;
figure;plot(x,AUC_s1_time,'b')
hold on
plot(x,nanmean(AUC_s1_time_sh,2)+2*nanstd(AUC_s1_time_sh,0,2),'--k')
plot(x,nanmean(AUC_s1_time_sh,2)-2*nanstd(AUC_s1_time_sh,0,2),'--k')


cond_100_m1=squeeze(nanmean(cond_100(roi_m1,:,:),1));
cond_1200_m1=squeeze(nanmean(cond_1200(roi_m1,:,:),1));
AUC_m1_time=nan*ones(1,180);
for i=1:180
    scores=[squeeze(nanmean(cond_100_m1(i,:),1)),squeeze(nanmean(cond_1200_m1(i,:),1))];
    labels=ones(1,size(scores,2));
    labels(size(cond_100,3)+1:end)=0;
    [X,Y,THRE,AUC_m1_time(i),OPTROCPT,SUBY,SUBYNAMES] = perfcurve(labels,scores,1);
end
iter=100;
AUC_m1_time_sh=nan*ones(180,iter);
tot=cat(2,cond_100_m1,cond_1200_m1);
for it=1:iter
    disp(it)
    r=randperm(size(tot,2));
    temp=tot(:,r(1:size(cond_100_m1,2)));
    temp2=tot(:,r(size(cond_100_m1,2)+1:end));
    for i=1:180
        scores=[temp(i,:),temp2(i,:)];
        labels=ones(1,size(scores,2));
        labels(size(cond_100,3)+1:end)=0;
        [X,Y,THRE,AUC_m1_time_sh(i,it),OPTROCPT,SUBY,SUBYNAMES] = perfcurve(labels,scores,1);
    end
end
x=(1:180)*0.05-2.7;
figure;plot(x,AUC_m1_time,'r')
hold on
plot(x,nanmean(AUC_m1_time_sh,2)+2*nanstd(AUC_m1_time_sh,0,2),'--k')
plot(x,nanmean(AUC_m1_time_sh,2)-2*nanstd(AUC_m1_time_sh,0,2),'--k')


cond_100_s2=squeeze(nanmean(cond_100(roi_s2,:,:),1));
cond_1200_s2=squeeze(nanmean(cond_1200(roi_s2,:,:),1));
AUC_s2_time=nan*ones(1,180);
for i=1:180
    scores=[squeeze(nanmean(cond_100_s2(i,:),1)),squeeze(nanmean(cond_1200_s2(i,:),1))];
    labels=ones(1,size(scores,2));
    labels(size(cond_100,3)+1:end)=0;
    [X,Y,THRE,AUC_s2_time(i),OPTROCPT,SUBY,SUBYNAMES] = perfcurve(labels,scores,1);
end
iter=100;
AUC_s2_time_sh=nan*ones(180,iter);
tot=cat(2,cond_100_s2,cond_1200_s2);
for it=1:iter
    disp(it)
    r=randperm(size(tot,2));
    temp=tot(:,r(1:size(cond_100_s2,2)));
    temp2=tot(:,r(size(cond_100_s2,2)+1:end));
    for i=1:180
        scores=[temp(i,:),temp2(i,:)];
        labels=ones(1,size(scores,2));
        labels(size(cond_100,3)+1:end)=0;
        [X,Y,THRE,AUC_s2_time_sh(i,it),OPTROCPT,SUBY,SUBYNAMES] = perfcurve(labels,scores,1);
    end
end
x=(1:180)*0.05-2.7;
figure;plot(x,AUC_s2_time,'c')
hold on
plot(x,nanmean(AUC_s2_time_sh,2)+2*nanstd(AUC_s2_time_sh,0,2),'--k')
plot(x,nanmean(AUC_s2_time_sh,2)-2*nanstd(AUC_s2_time_sh,0,2),'--k')


cond_100_alm=squeeze(nanmean(cond_100(roi_alm,:,:),1));
cond_1200_alm=squeeze(nanmean(cond_1200(roi_alm,:,:),1));
AUC_alm_time=nan*ones(1,180);
for i=1:180
    scores=[squeeze(nanmean(cond_100_alm(i,:),1)),squeeze(nanmean(cond_1200_alm(i,:),1))];
    labels=ones(1,size(scores,2));
    labels(size(cond_100,3)+1:end)=0;
    [X,Y,THRE,AUC_alm_time(i),OPTROCPT,SUBY,SUBYNAMES] = perfcurve(labels,scores,1);
end
iter=100;
AUC_alm_time_sh=nan*ones(180,iter);
tot=cat(2,cond_100_alm,cond_1200_alm);
for it=1:iter
    disp(it)
    r=randperm(size(tot,2));
    temp=tot(:,r(1:size(cond_100_alm,2)));
    temp2=tot(:,r(size(cond_100_alm,2)+1:end));
    for i=1:180
        scores=[temp(i,:),temp2(i,:)];
        labels=ones(1,size(scores,2));
        labels(size(cond_100,3)+1:end)=0;
        [X,Y,THRE,AUC_alm_time_sh(i,it),OPTROCPT,SUBY,SUBYNAMES] = perfcurve(labels,scores,1);
    end
end
x=(1:180)*0.05-2.7;
figure;plot(x,AUC_alm_time,'m')
hold on
plot(x,nanmean(AUC_alm_time_sh,2)+2*nanstd(AUC_alm_time_sh,0,2),'--k')
plot(x,nanmean(AUC_alm_time_sh,2)-2*nanstd(AUC_alm_time_sh,0,2),'--k')


save AUC_per_roi AUC_*

figure;plot(x,AUC_alm_time,'m')
hold on
plot(x,AUC_s1_time,'b')
plot(x,AUC_s2_time,'c')
plot(x,AUC_m1_time,'r')
plot(x,AUC_m2_time,'k')
plot(x,AUC_a1_time,'g')
plot(x,0.5*ones(1,180),'--k')
legend('s1','s2','m1','m2','alm','a1')

cd D:\intrinsic\20150123\a\Matt_files
load('trials_ind_clean_205x205.mat')
load rois_initial_205x205
list100 = dir('cond_100_trial*');
tr_100_c=ones(1,size(list100,1));
tr_100_c(tr_bad_100)=0;
ff=find(tr_100_c==1);
k=0;
for i=ff
    k=k+1;
    disp(i)
    eval(['load cond_100_trial',int2str(i)])
    if k==1
        cond_100=tr;
    else
        cond_100=cat(4,cond_100,tr);
    end
end
cond_100=reshape(cond_100,205*205,180,size(cond_100,4));

list1200 = dir('cond_1200_trial*');
tr_1200_c=ones(1,size(list1200,1));
tr_1200_c(tr_bad_1200)=0;
gg=find(tr_1200_c==1);
k=0;
for i=gg
    k=k+1;
    disp(i)
    eval(['load cond_1200_trial',int2str(i)])
    if k==1
        cond_1200=tr;
    else
        cond_1200=cat(4,cond_1200,tr);
    end
end
cond_1200=reshape(cond_1200,205*205,180,size(cond_1200,4));


cond_100_m2=squeeze(nanmean(cond_100(roi_m2,:,:),1));
cond_1200_m2=squeeze(nanmean(cond_1200(roi_m2,:,:),1));
AUC_m2_time=nan*ones(1,180);
for i=1:180
    scores=[squeeze(nanmean(cond_100_m2(i,:),1)),squeeze(nanmean(cond_1200_m2(i,:),1))];
    labels=ones(1,size(scores,2));
    labels(size(cond_100,3)+1:end)=0;
    [X,Y,THRE,AUC_m2_time(i),OPTROCPT,SUBY,SUBYNAMES] = perfcurve(labels,scores,1);
end
iter=100;
AUC_m2_time_sh=nan*ones(180,iter);
tot=cat(2,cond_100_m2,cond_1200_m2);
for it=1:iter
    disp(it)
    r=randperm(size(tot,2));
    temp=tot(:,r(1:size(cond_100_m2,2)));
    temp2=tot(:,r(size(cond_100_m2,2)+1:end));
    for i=1:180
        scores=[temp(i,:),temp2(i,:)];
        labels=ones(1,size(scores,2));
        labels(size(cond_100,3)+1:end)=0;
        [X,Y,THRE,AUC_m2_time_sh(i,it),OPTROCPT,SUBY,SUBYNAMES] = perfcurve(labels,scores,1);
    end
end
x=(1:180)*0.05-2.7;
figure;plot(x,AUC_m2_time,'k')
hold on
plot(x,nanmean(AUC_m2_time_sh,2)+2*nanstd(AUC_m2_time_sh,0,2),'--k')
plot(x,nanmean(AUC_m2_time_sh,2)-2*nanstd(AUC_m2_time_sh,0,2),'--k')





cond_100_a1=squeeze(nanmean(cond_100(roi_a1,:,:),1));
cond_1200_a1=squeeze(nanmean(cond_1200(roi_a1,:,:),1));
AUC_a1_time=nan*ones(1,180);
for i=1:180
    scores=[squeeze(nanmean(cond_100_a1(i,:),1)),squeeze(nanmean(cond_1200_a1(i,:),1))];
    labels=ones(1,size(scores,2));
    labels(size(cond_100,3)+1:end)=0;
    [X,Y,THRE,AUC_a1_time(i),OPTROCPT,SUBY,SUBYNAMES] = perfcurve(labels,scores,1);
end
iter=100;
AUC_a1_time_sh=nan*ones(180,iter);
tot=cat(2,cond_100_a1,cond_1200_a1);
for it=1:iter
    disp(it)
    r=randperm(size(tot,2));
    temp=tot(:,r(1:size(cond_100_a1,2)));
    temp2=tot(:,r(size(cond_100_a1,2)+1:end));
    for i=1:180
        scores=[temp(i,:),temp2(i,:)];
        labels=ones(1,size(scores,2));
        labels(size(cond_100,3)+1:end)=0;
        [X,Y,THRE,AUC_a1_time_sh(i,it),OPTROCPT,SUBY,SUBYNAMES] = perfcurve(labels,scores,1);
    end
end
x=(1:180)*0.05-2.7;
figure;plot(x,AUC_a1_time,'g')
hold on
plot(x,nanmean(AUC_a1_time_sh,2)+2*nanstd(AUC_a1_time_sh,0,2),'--k')
plot(x,nanmean(AUC_a1_time_sh,2)-2*nanstd(AUC_a1_time_sh,0,2),'--k')


cond_100_s1=squeeze(nanmean(cond_100(roi_s1,:,:),1));
cond_1200_s1=squeeze(nanmean(cond_1200(roi_s1,:,:),1));
AUC_s1_time=nan*ones(1,180);
for i=1:180
    scores=[squeeze(nanmean(cond_100_s1(i,:),1)),squeeze(nanmean(cond_1200_s1(i,:),1))];
    labels=ones(1,size(scores,2));
    labels(size(cond_100,3)+1:end)=0;
    [X,Y,THRE,AUC_s1_time(i),OPTROCPT,SUBY,SUBYNAMES] = perfcurve(labels,scores,1);
end
iter=100;
AUC_s1_time_sh=nan*ones(180,iter);
tot=cat(2,cond_100_s1,cond_1200_s1);
for it=1:iter
    disp(it)
    r=randperm(size(tot,2));
    temp=tot(:,r(1:size(cond_100_s1,2)));
    temp2=tot(:,r(size(cond_100_s1,2)+1:end));
    for i=1:180
        scores=[temp(i,:),temp2(i,:)];
        labels=ones(1,size(scores,2));
        labels(size(cond_100,3)+1:end)=0;
        [X,Y,THRE,AUC_s1_time_sh(i,it),OPTROCPT,SUBY,SUBYNAMES] = perfcurve(labels,scores,1);
    end
end
x=(1:180)*0.05-2.7;
figure;plot(x,AUC_s1_time,'b')
hold on
plot(x,nanmean(AUC_s1_time_sh,2)+2*nanstd(AUC_s1_time_sh,0,2),'--k')
plot(x,nanmean(AUC_s1_time_sh,2)-2*nanstd(AUC_s1_time_sh,0,2),'--k')


cond_100_m1=squeeze(nanmean(cond_100(roi_m1,:,:),1));
cond_1200_m1=squeeze(nanmean(cond_1200(roi_m1,:,:),1));
AUC_m1_time=nan*ones(1,180);
for i=1:180
    scores=[squeeze(nanmean(cond_100_m1(i,:),1)),squeeze(nanmean(cond_1200_m1(i,:),1))];
    labels=ones(1,size(scores,2));
    labels(size(cond_100,3)+1:end)=0;
    [X,Y,THRE,AUC_m1_time(i),OPTROCPT,SUBY,SUBYNAMES] = perfcurve(labels,scores,1);
end
iter=100;
AUC_m1_time_sh=nan*ones(180,iter);
tot=cat(2,cond_100_m1,cond_1200_m1);
for it=1:iter
    disp(it)
    r=randperm(size(tot,2));
    temp=tot(:,r(1:size(cond_100_m1,2)));
    temp2=tot(:,r(size(cond_100_m1,2)+1:end));
    for i=1:180
        scores=[temp(i,:),temp2(i,:)];
        labels=ones(1,size(scores,2));
        labels(size(cond_100,3)+1:end)=0;
        [X,Y,THRE,AUC_m1_time_sh(i,it),OPTROCPT,SUBY,SUBYNAMES] = perfcurve(labels,scores,1);
    end
end
x=(1:180)*0.05-2.7;
figure;plot(x,AUC_m1_time,'r')
hold on
plot(x,nanmean(AUC_m1_time_sh,2)+2*nanstd(AUC_m1_time_sh,0,2),'--k')
plot(x,nanmean(AUC_m1_time_sh,2)-2*nanstd(AUC_m1_time_sh,0,2),'--k')


cond_100_s2=squeeze(nanmean(cond_100(roi_s2,:,:),1));
cond_1200_s2=squeeze(nanmean(cond_1200(roi_s2,:,:),1));
AUC_s2_time=nan*ones(1,180);
for i=1:180
    scores=[squeeze(nanmean(cond_100_s2(i,:),1)),squeeze(nanmean(cond_1200_s2(i,:),1))];
    labels=ones(1,size(scores,2));
    labels(size(cond_100,3)+1:end)=0;
    [X,Y,THRE,AUC_s2_time(i),OPTROCPT,SUBY,SUBYNAMES] = perfcurve(labels,scores,1);
end
iter=100;
AUC_s2_time_sh=nan*ones(180,iter);
tot=cat(2,cond_100_s2,cond_1200_s2);
for it=1:iter
    disp(it)
    r=randperm(size(tot,2));
    temp=tot(:,r(1:size(cond_100_s2,2)));
    temp2=tot(:,r(size(cond_100_s2,2)+1:end));
    for i=1:180
        scores=[temp(i,:),temp2(i,:)];
        labels=ones(1,size(scores,2));
        labels(size(cond_100,3)+1:end)=0;
        [X,Y,THRE,AUC_s2_time_sh(i,it),OPTROCPT,SUBY,SUBYNAMES] = perfcurve(labels,scores,1);
    end
end
x=(1:180)*0.05-2.7;
figure;plot(x,AUC_s2_time,'c')
hold on
plot(x,nanmean(AUC_s2_time_sh,2)+2*nanstd(AUC_s2_time_sh,0,2),'--k')
plot(x,nanmean(AUC_s2_time_sh,2)-2*nanstd(AUC_s2_time_sh,0,2),'--k')


cond_100_alm=squeeze(nanmean(cond_100(roi_alm,:,:),1));
cond_1200_alm=squeeze(nanmean(cond_1200(roi_alm,:,:),1));
AUC_alm_time=nan*ones(1,180);
for i=1:180
    scores=[squeeze(nanmean(cond_100_alm(i,:),1)),squeeze(nanmean(cond_1200_alm(i,:),1))];
    labels=ones(1,size(scores,2));
    labels(size(cond_100,3)+1:end)=0;
    [X,Y,THRE,AUC_alm_time(i),OPTROCPT,SUBY,SUBYNAMES] = perfcurve(labels,scores,1);
end
iter=100;
AUC_alm_time_sh=nan*ones(180,iter);
tot=cat(2,cond_100_alm,cond_1200_alm);
for it=1:iter
    disp(it)
    r=randperm(size(tot,2));
    temp=tot(:,r(1:size(cond_100_alm,2)));
    temp2=tot(:,r(size(cond_100_alm,2)+1:end));
    for i=1:180
        scores=[temp(i,:),temp2(i,:)];
        labels=ones(1,size(scores,2));
        labels(size(cond_100,3)+1:end)=0;
        [X,Y,THRE,AUC_alm_time_sh(i,it),OPTROCPT,SUBY,SUBYNAMES] = perfcurve(labels,scores,1);
    end
end
x=(1:180)*0.05-2.7;
figure;plot(x,AUC_alm_time,'m')
hold on
plot(x,nanmean(AUC_alm_time_sh,2)+2*nanstd(AUC_alm_time_sh,0,2),'--k')
plot(x,nanmean(AUC_alm_time_sh,2)-2*nanstd(AUC_alm_time_sh,0,2),'--k')


save AUC_per_roi AUC_*

figure;plot(x,AUC_alm_time,'m')
hold on
plot(x,AUC_s1_time,'b')
plot(x,AUC_s2_time,'c')
plot(x,AUC_m1_time,'r')
plot(x,AUC_m2_time,'k')
plot(x,AUC_a1_time,'g')
plot(x,0.5*ones(1,180),'--k')
legend('s1','s2','m1','m2','alm','a1')




cd D:\intrinsic\20150128\e\Matt_files
load('trials_ind_clean_205x205.mat')
load rois_initial_205x205
list100 = dir('cond_100_trial*');
tr_100_c=ones(1,size(list100,1));
tr_100_c(tr_bad_100)=0;
ff=find(tr_100_c==1);
k=0;
for i=ff
    k=k+1;
    disp(i)
    eval(['load cond_100_trial',int2str(i)])
    if k==1
        cond_100=tr;
    else
        cond_100=cat(4,cond_100,tr);
    end
end
cond_100=reshape(cond_100,205*205,180,size(cond_100,4));

list1200 = dir('cond_1200_trial*');
tr_1200_c=ones(1,size(list1200,1));
tr_1200_c(tr_bad_1200)=0;
gg=find(tr_1200_c==1);
k=0;
for i=gg
    k=k+1;
    disp(i)
    eval(['load cond_1200_trial',int2str(i)])
    if k==1
        cond_1200=tr;
    else
        cond_1200=cat(4,cond_1200,tr);
    end
end
cond_1200=reshape(cond_1200,205*205,180,size(cond_1200,4));


cond_100_m2=squeeze(nanmean(cond_100(roi_m2,:,:),1));
cond_1200_m2=squeeze(nanmean(cond_1200(roi_m2,:,:),1));
AUC_m2_time=nan*ones(1,180);
for i=1:180
    scores=[squeeze(nanmean(cond_100_m2(i,:),1)),squeeze(nanmean(cond_1200_m2(i,:),1))];
    labels=ones(1,size(scores,2));
    labels(size(cond_100,3)+1:end)=0;
    [X,Y,THRE,AUC_m2_time(i),OPTROCPT,SUBY,SUBYNAMES] = perfcurve(labels,scores,1);
end
iter=100;
AUC_m2_time_sh=nan*ones(180,iter);
tot=cat(2,cond_100_m2,cond_1200_m2);
for it=1:iter
    disp(it)
    r=randperm(size(tot,2));
    temp=tot(:,r(1:size(cond_100_m2,2)));
    temp2=tot(:,r(size(cond_100_m2,2)+1:end));
    for i=1:180
        scores=[temp(i,:),temp2(i,:)];
        labels=ones(1,size(scores,2));
        labels(size(cond_100,3)+1:end)=0;
        [X,Y,THRE,AUC_m2_time_sh(i,it),OPTROCPT,SUBY,SUBYNAMES] = perfcurve(labels,scores,1);
    end
end
x=(1:180)*0.05-2.7;
figure;plot(x,AUC_m2_time,'k')
hold on
plot(x,nanmean(AUC_m2_time_sh,2)+2*nanstd(AUC_m2_time_sh,0,2),'--k')
plot(x,nanmean(AUC_m2_time_sh,2)-2*nanstd(AUC_m2_time_sh,0,2),'--k')





cond_100_a1=squeeze(nanmean(cond_100(roi_a1,:,:),1));
cond_1200_a1=squeeze(nanmean(cond_1200(roi_a1,:,:),1));
AUC_a1_time=nan*ones(1,180);
for i=1:180
    scores=[squeeze(nanmean(cond_100_a1(i,:),1)),squeeze(nanmean(cond_1200_a1(i,:),1))];
    labels=ones(1,size(scores,2));
    labels(size(cond_100,3)+1:end)=0;
    [X,Y,THRE,AUC_a1_time(i),OPTROCPT,SUBY,SUBYNAMES] = perfcurve(labels,scores,1);
end
iter=100;
AUC_a1_time_sh=nan*ones(180,iter);
tot=cat(2,cond_100_a1,cond_1200_a1);
for it=1:iter
    disp(it)
    r=randperm(size(tot,2));
    temp=tot(:,r(1:size(cond_100_a1,2)));
    temp2=tot(:,r(size(cond_100_a1,2)+1:end));
    for i=1:180
        scores=[temp(i,:),temp2(i,:)];
        labels=ones(1,size(scores,2));
        labels(size(cond_100,3)+1:end)=0;
        [X,Y,THRE,AUC_a1_time_sh(i,it),OPTROCPT,SUBY,SUBYNAMES] = perfcurve(labels,scores,1);
    end
end
x=(1:180)*0.05-2.7;
figure;plot(x,AUC_a1_time,'g')
hold on
plot(x,nanmean(AUC_a1_time_sh,2)+2*nanstd(AUC_a1_time_sh,0,2),'--k')
plot(x,nanmean(AUC_a1_time_sh,2)-2*nanstd(AUC_a1_time_sh,0,2),'--k')


cond_100_s1=squeeze(nanmean(cond_100(roi_s1,:,:),1));
cond_1200_s1=squeeze(nanmean(cond_1200(roi_s1,:,:),1));
AUC_s1_time=nan*ones(1,180);
for i=1:180
    scores=[squeeze(nanmean(cond_100_s1(i,:),1)),squeeze(nanmean(cond_1200_s1(i,:),1))];
    labels=ones(1,size(scores,2));
    labels(size(cond_100,3)+1:end)=0;
    [X,Y,THRE,AUC_s1_time(i),OPTROCPT,SUBY,SUBYNAMES] = perfcurve(labels,scores,1);
end
iter=100;
AUC_s1_time_sh=nan*ones(180,iter);
tot=cat(2,cond_100_s1,cond_1200_s1);
for it=1:iter
    disp(it)
    r=randperm(size(tot,2));
    temp=tot(:,r(1:size(cond_100_s1,2)));
    temp2=tot(:,r(size(cond_100_s1,2)+1:end));
    for i=1:180
        scores=[temp(i,:),temp2(i,:)];
        labels=ones(1,size(scores,2));
        labels(size(cond_100,3)+1:end)=0;
        [X,Y,THRE,AUC_s1_time_sh(i,it),OPTROCPT,SUBY,SUBYNAMES] = perfcurve(labels,scores,1);
    end
end
x=(1:180)*0.05-2.7;
figure;plot(x,AUC_s1_time,'b')
hold on
plot(x,nanmean(AUC_s1_time_sh,2)+2*nanstd(AUC_s1_time_sh,0,2),'--k')
plot(x,nanmean(AUC_s1_time_sh,2)-2*nanstd(AUC_s1_time_sh,0,2),'--k')


cond_100_m1=squeeze(nanmean(cond_100(roi_m1,:,:),1));
cond_1200_m1=squeeze(nanmean(cond_1200(roi_m1,:,:),1));
AUC_m1_time=nan*ones(1,180);
for i=1:180
    scores=[squeeze(nanmean(cond_100_m1(i,:),1)),squeeze(nanmean(cond_1200_m1(i,:),1))];
    labels=ones(1,size(scores,2));
    labels(size(cond_100,3)+1:end)=0;
    [X,Y,THRE,AUC_m1_time(i),OPTROCPT,SUBY,SUBYNAMES] = perfcurve(labels,scores,1);
end
iter=100;
AUC_m1_time_sh=nan*ones(180,iter);
tot=cat(2,cond_100_m1,cond_1200_m1);
for it=1:iter
    disp(it)
    r=randperm(size(tot,2));
    temp=tot(:,r(1:size(cond_100_m1,2)));
    temp2=tot(:,r(size(cond_100_m1,2)+1:end));
    for i=1:180
        scores=[temp(i,:),temp2(i,:)];
        labels=ones(1,size(scores,2));
        labels(size(cond_100,3)+1:end)=0;
        [X,Y,THRE,AUC_m1_time_sh(i,it),OPTROCPT,SUBY,SUBYNAMES] = perfcurve(labels,scores,1);
    end
end
x=(1:180)*0.05-2.7;
figure;plot(x,AUC_m1_time,'r')
hold on
plot(x,nanmean(AUC_m1_time_sh,2)+2*nanstd(AUC_m1_time_sh,0,2),'--k')
plot(x,nanmean(AUC_m1_time_sh,2)-2*nanstd(AUC_m1_time_sh,0,2),'--k')


cond_100_s2=squeeze(nanmean(cond_100(roi_s2,:,:),1));
cond_1200_s2=squeeze(nanmean(cond_1200(roi_s2,:,:),1));
AUC_s2_time=nan*ones(1,180);
for i=1:180
    scores=[squeeze(nanmean(cond_100_s2(i,:),1)),squeeze(nanmean(cond_1200_s2(i,:),1))];
    labels=ones(1,size(scores,2));
    labels(size(cond_100,3)+1:end)=0;
    [X,Y,THRE,AUC_s2_time(i),OPTROCPT,SUBY,SUBYNAMES] = perfcurve(labels,scores,1);
end
iter=100;
AUC_s2_time_sh=nan*ones(180,iter);
tot=cat(2,cond_100_s2,cond_1200_s2);
for it=1:iter
    disp(it)
    r=randperm(size(tot,2));
    temp=tot(:,r(1:size(cond_100_s2,2)));
    temp2=tot(:,r(size(cond_100_s2,2)+1:end));
    for i=1:180
        scores=[temp(i,:),temp2(i,:)];
        labels=ones(1,size(scores,2));
        labels(size(cond_100,3)+1:end)=0;
        [X,Y,THRE,AUC_s2_time_sh(i,it),OPTROCPT,SUBY,SUBYNAMES] = perfcurve(labels,scores,1);
    end
end
x=(1:180)*0.05-2.7;
figure;plot(x,AUC_s2_time,'c')
hold on
plot(x,nanmean(AUC_s2_time_sh,2)+2*nanstd(AUC_s2_time_sh,0,2),'--k')
plot(x,nanmean(AUC_s2_time_sh,2)-2*nanstd(AUC_s2_time_sh,0,2),'--k')


cond_100_alm=squeeze(nanmean(cond_100(roi_alm,:,:),1));
cond_1200_alm=squeeze(nanmean(cond_1200(roi_alm,:,:),1));
AUC_alm_time=nan*ones(1,180);
for i=1:180
    scores=[squeeze(nanmean(cond_100_alm(i,:),1)),squeeze(nanmean(cond_1200_alm(i,:),1))];
    labels=ones(1,size(scores,2));
    labels(size(cond_100,3)+1:end)=0;
    [X,Y,THRE,AUC_alm_time(i),OPTROCPT,SUBY,SUBYNAMES] = perfcurve(labels,scores,1);
end
iter=100;
AUC_alm_time_sh=nan*ones(180,iter);
tot=cat(2,cond_100_alm,cond_1200_alm);
for it=1:iter
    disp(it)
    r=randperm(size(tot,2));
    temp=tot(:,r(1:size(cond_100_alm,2)));
    temp2=tot(:,r(size(cond_100_alm,2)+1:end));
    for i=1:180
        scores=[temp(i,:),temp2(i,:)];
        labels=ones(1,size(scores,2));
        labels(size(cond_100,3)+1:end)=0;
        [X,Y,THRE,AUC_alm_time_sh(i,it),OPTROCPT,SUBY,SUBYNAMES] = perfcurve(labels,scores,1);
    end
end
x=(1:180)*0.05-2.7;
figure;plot(x,AUC_alm_time,'m')
hold on
plot(x,nanmean(AUC_alm_time_sh,2)+2*nanstd(AUC_alm_time_sh,0,2),'--k')
plot(x,nanmean(AUC_alm_time_sh,2)-2*nanstd(AUC_alm_time_sh,0,2),'--k')


save AUC_per_roi AUC_*

figure;plot(x,AUC_alm_time,'m')
hold on
plot(x,AUC_s1_time,'b')
plot(x,AUC_s2_time,'c')
plot(x,AUC_m1_time,'r')
plot(x,AUC_m2_time,'k')
plot(x,AUC_a1_time,'g')
plot(x,0.5*ones(1,180),'--k')
legend('s1','s2','m1','m2','alm','a1')





cd D:\intrinsic\20150128\f\Matt_files
load('trials_ind_clean_205x205.mat')
load rois_initial_205x205
list100 = dir('cond_100_trial*');
tr_100_c=ones(1,size(list100,1));
tr_100_c(tr_bad_100)=0;
ff=find(tr_100_c==1);
k=0;
for i=ff
    k=k+1;
    disp(i)
    eval(['load cond_100_trial',int2str(i)])
    if k==1
        cond_100=tr;
    else
        cond_100=cat(4,cond_100,tr);
    end
end
cond_100=reshape(cond_100,205*205,180,size(cond_100,4));

list1200 = dir('cond_1200_trial*');
tr_1200_c=ones(1,size(list1200,1));
tr_1200_c(tr_bad_1200)=0;
gg=find(tr_1200_c==1);
k=0;
for i=gg
    k=k+1;
    disp(i)
    eval(['load cond_1200_trial',int2str(i)])
    if k==1
        cond_1200=tr;
    else
        cond_1200=cat(4,cond_1200,tr);
    end
end
cond_1200=reshape(cond_1200,205*205,180,size(cond_1200,4));


cond_100_m2=squeeze(nanmean(cond_100(roi_m2,:,:),1));
cond_1200_m2=squeeze(nanmean(cond_1200(roi_m2,:,:),1));
AUC_m2_time=nan*ones(1,180);
for i=1:180
    scores=[squeeze(nanmean(cond_100_m2(i,:),1)),squeeze(nanmean(cond_1200_m2(i,:),1))];
    labels=ones(1,size(scores,2));
    labels(size(cond_100,3)+1:end)=0;
    [X,Y,THRE,AUC_m2_time(i),OPTROCPT,SUBY,SUBYNAMES] = perfcurve(labels,scores,1);
end
iter=100;
AUC_m2_time_sh=nan*ones(180,iter);
tot=cat(2,cond_100_m2,cond_1200_m2);
for it=1:iter
    disp(it)
    r=randperm(size(tot,2));
    temp=tot(:,r(1:size(cond_100_m2,2)));
    temp2=tot(:,r(size(cond_100_m2,2)+1:end));
    for i=1:180
        scores=[temp(i,:),temp2(i,:)];
        labels=ones(1,size(scores,2));
        labels(size(cond_100,3)+1:end)=0;
        [X,Y,THRE,AUC_m2_time_sh(i,it),OPTROCPT,SUBY,SUBYNAMES] = perfcurve(labels,scores,1);
    end
end
x=(1:180)*0.05-2.7;
figure;plot(x,AUC_m2_time,'k')
hold on
plot(x,nanmean(AUC_m2_time_sh,2)+2*nanstd(AUC_m2_time_sh,0,2),'--k')
plot(x,nanmean(AUC_m2_time_sh,2)-2*nanstd(AUC_m2_time_sh,0,2),'--k')





cond_100_a1=squeeze(nanmean(cond_100(roi_a1,:,:),1));
cond_1200_a1=squeeze(nanmean(cond_1200(roi_a1,:,:),1));
AUC_a1_time=nan*ones(1,180);
for i=1:180
    scores=[squeeze(nanmean(cond_100_a1(i,:),1)),squeeze(nanmean(cond_1200_a1(i,:),1))];
    labels=ones(1,size(scores,2));
    labels(size(cond_100,3)+1:end)=0;
    [X,Y,THRE,AUC_a1_time(i),OPTROCPT,SUBY,SUBYNAMES] = perfcurve(labels,scores,1);
end
iter=100;
AUC_a1_time_sh=nan*ones(180,iter);
tot=cat(2,cond_100_a1,cond_1200_a1);
for it=1:iter
    disp(it)
    r=randperm(size(tot,2));
    temp=tot(:,r(1:size(cond_100_a1,2)));
    temp2=tot(:,r(size(cond_100_a1,2)+1:end));
    for i=1:180
        scores=[temp(i,:),temp2(i,:)];
        labels=ones(1,size(scores,2));
        labels(size(cond_100,3)+1:end)=0;
        [X,Y,THRE,AUC_a1_time_sh(i,it),OPTROCPT,SUBY,SUBYNAMES] = perfcurve(labels,scores,1);
    end
end
x=(1:180)*0.05-2.7;
figure;plot(x,AUC_a1_time,'g')
hold on
plot(x,nanmean(AUC_a1_time_sh,2)+2*nanstd(AUC_a1_time_sh,0,2),'--k')
plot(x,nanmean(AUC_a1_time_sh,2)-2*nanstd(AUC_a1_time_sh,0,2),'--k')


cond_100_s1=squeeze(nanmean(cond_100(roi_s1,:,:),1));
cond_1200_s1=squeeze(nanmean(cond_1200(roi_s1,:,:),1));
AUC_s1_time=nan*ones(1,180);
for i=1:180
    scores=[squeeze(nanmean(cond_100_s1(i,:),1)),squeeze(nanmean(cond_1200_s1(i,:),1))];
    labels=ones(1,size(scores,2));
    labels(size(cond_100,3)+1:end)=0;
    [X,Y,THRE,AUC_s1_time(i),OPTROCPT,SUBY,SUBYNAMES] = perfcurve(labels,scores,1);
end
iter=100;
AUC_s1_time_sh=nan*ones(180,iter);
tot=cat(2,cond_100_s1,cond_1200_s1);
for it=1:iter
    disp(it)
    r=randperm(size(tot,2));
    temp=tot(:,r(1:size(cond_100_s1,2)));
    temp2=tot(:,r(size(cond_100_s1,2)+1:end));
    for i=1:180
        scores=[temp(i,:),temp2(i,:)];
        labels=ones(1,size(scores,2));
        labels(size(cond_100,3)+1:end)=0;
        [X,Y,THRE,AUC_s1_time_sh(i,it),OPTROCPT,SUBY,SUBYNAMES] = perfcurve(labels,scores,1);
    end
end
x=(1:180)*0.05-2.7;
figure;plot(x,AUC_s1_time,'b')
hold on
plot(x,nanmean(AUC_s1_time_sh,2)+2*nanstd(AUC_s1_time_sh,0,2),'--k')
plot(x,nanmean(AUC_s1_time_sh,2)-2*nanstd(AUC_s1_time_sh,0,2),'--k')


cond_100_m1=squeeze(nanmean(cond_100(roi_m1,:,:),1));
cond_1200_m1=squeeze(nanmean(cond_1200(roi_m1,:,:),1));
AUC_m1_time=nan*ones(1,180);
for i=1:180
    scores=[squeeze(nanmean(cond_100_m1(i,:),1)),squeeze(nanmean(cond_1200_m1(i,:),1))];
    labels=ones(1,size(scores,2));
    labels(size(cond_100,3)+1:end)=0;
    [X,Y,THRE,AUC_m1_time(i),OPTROCPT,SUBY,SUBYNAMES] = perfcurve(labels,scores,1);
end
iter=100;
AUC_m1_time_sh=nan*ones(180,iter);
tot=cat(2,cond_100_m1,cond_1200_m1);
for it=1:iter
    disp(it)
    r=randperm(size(tot,2));
    temp=tot(:,r(1:size(cond_100_m1,2)));
    temp2=tot(:,r(size(cond_100_m1,2)+1:end));
    for i=1:180
        scores=[temp(i,:),temp2(i,:)];
        labels=ones(1,size(scores,2));
        labels(size(cond_100,3)+1:end)=0;
        [X,Y,THRE,AUC_m1_time_sh(i,it),OPTROCPT,SUBY,SUBYNAMES] = perfcurve(labels,scores,1);
    end
end
x=(1:180)*0.05-2.7;
figure;plot(x,AUC_m1_time,'r')
hold on
plot(x,nanmean(AUC_m1_time_sh,2)+2*nanstd(AUC_m1_time_sh,0,2),'--k')
plot(x,nanmean(AUC_m1_time_sh,2)-2*nanstd(AUC_m1_time_sh,0,2),'--k')


cond_100_s2=squeeze(nanmean(cond_100(roi_s2,:,:),1));
cond_1200_s2=squeeze(nanmean(cond_1200(roi_s2,:,:),1));
AUC_s2_time=nan*ones(1,180);
for i=1:180
    scores=[squeeze(nanmean(cond_100_s2(i,:),1)),squeeze(nanmean(cond_1200_s2(i,:),1))];
    labels=ones(1,size(scores,2));
    labels(size(cond_100,3)+1:end)=0;
    [X,Y,THRE,AUC_s2_time(i),OPTROCPT,SUBY,SUBYNAMES] = perfcurve(labels,scores,1);
end
iter=100;
AUC_s2_time_sh=nan*ones(180,iter);
tot=cat(2,cond_100_s2,cond_1200_s2);
for it=1:iter
    disp(it)
    r=randperm(size(tot,2));
    temp=tot(:,r(1:size(cond_100_s2,2)));
    temp2=tot(:,r(size(cond_100_s2,2)+1:end));
    for i=1:180
        scores=[temp(i,:),temp2(i,:)];
        labels=ones(1,size(scores,2));
        labels(size(cond_100,3)+1:end)=0;
        [X,Y,THRE,AUC_s2_time_sh(i,it),OPTROCPT,SUBY,SUBYNAMES] = perfcurve(labels,scores,1);
    end
end
x=(1:180)*0.05-2.7;
figure;plot(x,AUC_s2_time,'c')
hold on
plot(x,nanmean(AUC_s2_time_sh,2)+2*nanstd(AUC_s2_time_sh,0,2),'--k')
plot(x,nanmean(AUC_s2_time_sh,2)-2*nanstd(AUC_s2_time_sh,0,2),'--k')


cond_100_alm=squeeze(nanmean(cond_100(roi_alm,:,:),1));
cond_1200_alm=squeeze(nanmean(cond_1200(roi_alm,:,:),1));
AUC_alm_time=nan*ones(1,180);
for i=1:180
    scores=[squeeze(nanmean(cond_100_alm(i,:),1)),squeeze(nanmean(cond_1200_alm(i,:),1))];
    labels=ones(1,size(scores,2));
    labels(size(cond_100,3)+1:end)=0;
    [X,Y,THRE,AUC_alm_time(i),OPTROCPT,SUBY,SUBYNAMES] = perfcurve(labels,scores,1);
end
iter=100;
AUC_alm_time_sh=nan*ones(180,iter);
tot=cat(2,cond_100_alm,cond_1200_alm);
for it=1:iter
    disp(it)
    r=randperm(size(tot,2));
    temp=tot(:,r(1:size(cond_100_alm,2)));
    temp2=tot(:,r(size(cond_100_alm,2)+1:end));
    for i=1:180
        scores=[temp(i,:),temp2(i,:)];
        labels=ones(1,size(scores,2));
        labels(size(cond_100,3)+1:end)=0;
        [X,Y,THRE,AUC_alm_time_sh(i,it),OPTROCPT,SUBY,SUBYNAMES] = perfcurve(labels,scores,1);
    end
end
x=(1:180)*0.05-2.7;
figure;plot(x,AUC_alm_time,'m')
hold on
plot(x,nanmean(AUC_alm_time_sh,2)+2*nanstd(AUC_alm_time_sh,0,2),'--k')
plot(x,nanmean(AUC_alm_time_sh,2)-2*nanstd(AUC_alm_time_sh,0,2),'--k')


save AUC_per_roi AUC_*

figure;plot(x,AUC_alm_time,'m')
hold on
plot(x,AUC_s1_time,'b')
plot(x,AUC_s2_time,'c')
plot(x,AUC_m1_time,'r')
plot(x,AUC_m2_time,'k')
plot(x,AUC_a1_time,'g')
plot(x,0.5*ones(1,180),'--k')
legend('s1','s2','m1','m2','alm','a1')




