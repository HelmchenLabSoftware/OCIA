

%% a
cd D:\intrinsic\20150520\a\Matt_files\
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


kk=0;
for i=[18 26 28 29 30] 
    disp(i)
    kk=kk+1;
    eval(['load cond_1200_trial',int2str(i)])
    %figure;imagesc(smoothn(nanmean(tr(:,:,50:60),3),[5 5],'Gauss')-1,[-1e-2 1e-2]);colormap(mapgeog)
    if kk==1
        cond_1200_ave_nw=tr;
    else
        cond_1200_ave_nw=cond_1200_ave_nw+tr;
    end
end


kkk=0;
for i=[6 10 11 12 19 20 23 24 26 27 28 29 31]
    disp(i)
    kkk=kkk+1;
    eval(['load cond_100_trial',int2str(i)])
    %figure;imagesc(smoothn(nanmean(tr(:,:,50:60),3),[5 5],'Gauss')-1,[-1e-2 1e-2]);colormap(mapgeog)
    if kkk==1
        cond_100_ave=tr;
    else
        cond_100_ave=cond_100_ave+tr;
    end
end

kkkk=0;
for i=[2 3 5 8 16 17] 
    disp(i)
    kkkk=kkkk+1;
    eval(['load cond_100_trial',int2str(i)])
    %figure;imagesc(smoothn(nanmean(tr(:,:,50:60),3),[5 5],'Gauss')-1,[-1e-2 1e-2]);colormap(mapgeog)
    if kkkk==1
        cond_100_ave_nw=tr;
    else
        cond_100_ave_nw=cond_100_ave_nw+tr;
    end
end

%% b
cd D:\intrinsic\20150520\b\Matt_files\

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

for i=[3 4 9 26 25 11 10] 
    disp(i)
    kk=kk+1;
    eval(['load cond_1200_trial',int2str(i)])
    %figure;imagesc(smoothn(nanmean(tr(:,:,50:60),3),[5 5],'Gauss')-1,[-1e-2 1e-2]);colormap(mapgeog)
    if kk==1
        cond_1200_ave_nw=tr;
    else
        cond_1200_ave_nw=cond_1200_ave_nw+tr;
    end
end

for i=[4 8 12 13 14 16 19 23 25 26 27 28 30 32 34 38 39 40 41 43]
    disp(i)
    kkk=kkk+1;
    eval(['load cond_100_trial',int2str(i)])
    %figure;imagesc(smoothn(nanmean(tr(:,:,50:60),3),[5 5],'Gauss')-1,[-1e-2 1e-2]);colormap(mapgeog)
    if kkk==1
        cond_100_ave=tr;
    else
        cond_100_ave=cond_100_ave+tr;
    end
end

for i=[1 3 20 21 24 29] 
    disp(i)
    kkkk=kkkk+1;
    eval(['load cond_100_trial',int2str(i)])
    %figure;imagesc(smoothn(nanmean(tr(:,:,50:60),3),[5 5],'Gauss')-1,[-1e-2 1e-2]);colormap(mapgeog)
    if kkkk==1
        cond_100_ave_nw=tr;
    else
        cond_100_ave_nw=cond_100_ave_nw+tr;
    end
end


%% c
cd D:\intrinsic\20150520\c\Matt_files\

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

for i=[1 6 8 13 14 16 20 23 29 31 35 37 39 41 46] 
    disp(i)
    kk=kk+1;
    eval(['load cond_1200_trial',int2str(i)])
    %figure;imagesc(smoothn(nanmean(tr(:,:,50:60),3),[5 5],'Gauss')-1,[-1e-2 1e-2]);colormap(mapgeog)
    if kk==1
        cond_1200_ave_nw=tr;
    else
        cond_1200_ave_nw=cond_1200_ave_nw+tr;
    end
end

for i=[2 3 4 5 6 8 9 12 13 18 19 22 2 29 30 32 37 39 40 42 44 45]%[27 28 33 38 43 47 48 50]%[2:7 9:12 15 17:19 21:26 28 30 32:34 36 28 40 42:45] 
    disp(i)
    kkk=kkk+1;
    eval(['load cond_100_trial',int2str(i)])
    %figure;imagesc(smoothn(nanmean(tr(:,:,50:60),3),[5 5],'Gauss')-1,[-1e-2 1e-2]);colormap(mapgeog)
    if kkk==1
        cond_100_ave=tr;
    else
        cond_100_ave=cond_100_ave+tr;
    end
end

for i=[27 28 33 38 43 47 48 50]%[2:7 9:12 15 17:19 21:26 28 30 32:34 36 28 40 42:45] 
    disp(i)
    kkkk=kkkk+1;
    eval(['load cond_100_trial',int2str(i)])
    %figure;imagesc(smoothn(nanmean(tr(:,:,50:60),3),[5 5],'Gauss')-1,[-1e-2 1e-2]);colormap(mapgeog)
    if kkkk==1
        cond_100_ave_nw=tr;
    else
        cond_100_ave_nw=cond_100_ave_nw+tr;
    end
end




%% d
cd D:\intrinsic\20150520\d\Matt_files\

for i=[2 7 9 10 18 19 24 26 29 37 39 43]
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


for i=[4 5 8 13 17 20 25 27 31 33 34 35 40 41 42] 
    disp(i)
    kk=kk+1;
    eval(['load cond_1200_trial',int2str(i)])
    %figure;imagesc(smoothn(nanmean(tr(:,:,50:60),3),[5 5],'Gauss')-1,[-1e-2 1e-2]);colormap(mapgeog)
    if kk==1
        cond_1200_ave_nw=tr;
    else
        cond_1200_ave_nw=cond_1200_ave_nw+tr;
    end
end
cond_1200_ave_nw=cond_1200_ave_nw/kk;

figure;imagesc(smoothn(nanmean(cond_1200_ave_nw(:,:,54:56),3),[5 5],'Gauss')-1,[-1e-2 1.5e-2]);colormap(mapgeog)



for i=[2 3 6 8 9 10 15 17 18 23 24 31]
    disp(i)
    kkk=kkk+1;
    eval(['load cond_100_trial',int2str(i)])
    %figure;imagesc(smoothn(nanmean(tr(:,:,50:60),3),[5 5],'Gauss')-1,[-1e-2 1e-2]);colormap(mapgeog)
    if kkk==1
        cond_100_ave=tr;
    else
        cond_100_ave=cond_100_ave+tr;
    end
end
cond_100_ave=cond_100_ave/kkk;

figure;imagesc(smoothn(nanmean(cond_100_ave(:,:,54:56),3),[5 5],'Gauss')-1,[-1e-2 1.5e-2]);colormap(mapgeog)

for i=[1 4 7 14 21 25 27 30 34 36] 
    disp(i)
    kkkk=kkkk+1;
    eval(['load cond_100_trial',int2str(i)])
    %figure;imagesc(smoothn(nanmean(tr(:,:,50:60),3),[5 5],'Gauss')-1,[-1e-2 1e-2]);colormap(mapgeog)
    if kkkk==1
        cond_100_ave_nw=tr;
    else
        cond_100_ave_nw=cond_100_ave_nw+tr;
    end
end
cond_100_ave_nw=cond_100_ave_nw/kkkk;

figure;imagesc(smoothn(nanmean(cond_100_ave_nw(:,:,54:56),3),[5 5],'Gauss')-1,[-1e-2 1.5e-2]);colormap(mapgeog)




load rois_initial_205x205
x=(1:180)*0.05-2.7;

d=reshape(cond_100_ave,205*205,180);
d2=reshape(cond_100_ave_nw,205*205,180);
d3=reshape(cond_1200_ave,205*205,180);
d4=reshape(cond_1200_ave_nw,205*205,180);

figure;plot(x,smooth(squeeze(nanmean(d(roi_s1,:),1))-1,1,'Gauss'))
hold on
plot(x,smooth(squeeze(nanmean(d(roi_s2,:),1))-1,1,'Gauss'),'c')
plot(x,smooth(squeeze(nanmean(d(roi_m1,:),1))-1,1,'Gauss'),'r')
plot(x,smooth(squeeze(nanmean(d(roi_a1,:),1))-1,1,'Gauss'),'g')
plot(x,smooth(squeeze(nanmean(d(roi_m2,:),1))-1,1,'Gauss'),'k')
plot(x,smooth(squeeze(nanmean(d(roi_alm,:),1))-1,1,'Gauss'),'m')
plot(x,zeros(1,180),'k')
legend('s1','s2','m1','a1','m2','alm')


figure;plot(x,smooth(squeeze(nanmean(d2(roi_s1,:),1))-1,1,'Gauss'))
hold on
plot(x,smooth(squeeze(nanmean(d2(roi_s2,:),1))-1,1,'Gauss'),'c')
plot(x,smooth(squeeze(nanmean(d2(roi_m1,:),1))-1,1,'Gauss'),'r')
plot(x,smooth(squeeze(nanmean(d2(roi_a1,:),1))-1,1,'Gauss'),'g')
plot(x,smooth(squeeze(nanmean(d2(roi_m2,:),1))-1,1,'Gauss'),'k')
plot(x,smooth(squeeze(nanmean(d2(roi_alm,:),1))-1,1,'Gauss'),'m')
plot(x,zeros(1,180),'k')
legend('s1','s2','m1','a1','m2','alm')

figure;plot(x,smooth(squeeze(nanmean(d3(roi_s1,:),1))-1,1,'Gauss'))
hold on
plot(x,smooth(squeeze(nanmean(d3(roi_s2,:),1))-1,1,'Gauss'),'c')
plot(x,smooth(squeeze(nanmean(d3(roi_m1,:),1))-1,1,'Gauss'),'r')
plot(x,smooth(squeeze(nanmean(d3(roi_a1,:),1))-1,1,'Gauss'),'g')
plot(x,smooth(squeeze(nanmean(d3(roi_m2,:),1))-1,1,'Gauss'),'k')
plot(x,smooth(squeeze(nanmean(d3(roi_alm,:),1))-1,1,'Gauss'),'m')
plot(x,zeros(1,180),'k')
legend('s1','s2','m1','a1','m2','alm')

figure;plot(x,smooth(squeeze(nanmean(d4(roi_s1,:),1))-1,1,'Gauss'))
hold on
plot(x,smooth(squeeze(nanmean(d4(roi_s2,:),1))-1,1,'Gauss'),'c')
plot(x,smooth(squeeze(nanmean(d4(roi_m1,:),1))-1,1,'Gauss'),'r')
plot(x,smooth(squeeze(nanmean(d4(roi_a1,:),1))-1,1,'Gauss'),'g')
plot(x,smooth(squeeze(nanmean(d4(roi_m2,:),1))-1,1,'Gauss'),'k')
plot(x,smooth(squeeze(nanmean(d4(roi_alm,:),1))-1,1,'Gauss'),'m')
plot(x,zeros(1,180),'k')
legend('s1','s2','m1','a1','m2','alm')


d5=d2-d4;
figure;plot(x,smooth(squeeze(nanmean(d5(roi_s1,:),1)),1,'Gauss'))
hold on
plot(x,smooth(squeeze(nanmean(d5(roi_s2,:),1)),1,'Gauss'),'c')
plot(x,smooth(squeeze(nanmean(d5(roi_m1,:),1)),1,'Gauss'),'r')
plot(x,smooth(squeeze(nanmean(d5(roi_a1,:),1)),1,'Gauss'),'g')
plot(x,smooth(squeeze(nanmean(d5(roi_m2,:),1)),1,'Gauss'),'k')
plot(x,smooth(squeeze(nanmean(d5(roi_alm,:),1)),1,'Gauss'),'m')
plot(x,zeros(1,180),'k')
legend('s1','s2','m1','a1','m2','alm')


d5=d2-d4;
figure;plot(x,smooth(squeeze(nanmean(d5(roi_s1,:),1)),1,'Gauss'))
hold on
plot(x,smooth(squeeze(nanmean(d5(roi_s2,:),1)),1,'Gauss'),'c')
plot(x,smooth(squeeze(nanmean(d5(roi_m1,:),1)),1,'Gauss'),'r')
plot(x,smooth(squeeze(nanmean(d5(roi_a1,:),1)),1,'Gauss'),'g')
plot(x,smooth(squeeze(nanmean(d5(roi_m2,:),1)),1,'Gauss'),'k')
plot(x,smooth(squeeze(nanmean(d5(roi_alm,:),1)),1,'Gauss'),'m')
plot(x,zeros(1,180),'k')
legend('s1','s2','m1','a1','m2','alm')



d6=d-d3;
figure;plot(x,smooth(squeeze(nanmean(d6(roi_s1,:),1)),1,'Gauss'))
hold on
plot(x,smooth(squeeze(nanmean(d6(roi_s2,:),1)),1,'Gauss'),'c')
plot(x,smooth(squeeze(nanmean(d6(roi_m1,:),1)),1,'Gauss'),'r')
plot(x,smooth(squeeze(nanmean(d6(roi_a1,:),1)),1,'Gauss'),'g')
plot(x,smooth(squeeze(nanmean(d6(roi_m2,:),1)),1,'Gauss'),'k')
plot(x,smooth(squeeze(nanmean(d6(roi_alm,:),1)),1,'Gauss'),'m')
plot(x,zeros(1,180),'k')
legend('s1','s2','m1','a1','m2','alm')




