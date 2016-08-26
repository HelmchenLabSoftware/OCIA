for j=1:20
    
    figure
    plot(squeeze(mean(cond1n_dt_bl(roi_maskin,2:120,j),1)))
    hold on
    plot(squeeze(mean(cond1n_dt_bl(roi_maskout,2:120,j),1)),'-.')
    plot(squeeze(mean(cond1n_dt_bl(roi_tar,2:120,j),1)),'r')
    %plot(squeeze(mean(cond1n_dt_bl(roi_f2,2:120,j),1)),'r')
    plot(squeeze(mean(cond1n_dt_bl(roi_f2,2:120,j),1)),'color','r','linestyle','-.')
    title(['trial ',int2str(j)])
end

for j=1:20
    figure
    plot(squeeze(mean(cond1n_dt_bl(roi_maskin,2:120,j),1)))
    hold on
    title(['trial ',int2str(j)])
    peak(j)=find(squeeze(mean(cond1n_dt_bl(roi_maskin,:,j),1))==max(squeeze(mean(cond1n_dt_bl(roi_maskin,35:50,j),1))));
    peak2(j)=find(squeeze(mean(cond1n_dt_bl(roi_maskin,:,j),1))==max(squeeze(mean(cond1n_dt_bl(roi_maskin,35:50,j),1))));
   
    d1=squeeze(mean(cond1n_dt_bl(roi_maskin,peak(j)+1,j),1))-squeeze(mean(cond1n_dt_bl(roi_maskin,peak(j),j),1));
    d2=squeeze(mean(cond1n_dt_bl(roi_maskin,peak(j)+2,j),1))-squeeze(mean(cond1n_dt_bl(roi_maskin,peak(j)+1,j),1));
    d3=squeeze(mean(cond1n_dt_bl(roi_maskin,peak(j)+3,j),1))-squeeze(mean(cond1n_dt_bl(roi_maskin,peak(j)+2,j),1));
    d4=squeeze(mean(cond1n_dt_bl(roi_maskin,peak(j)+4,j),1))-squeeze(mean(cond1n_dt_bl(roi_maskin,peak(j)+3,j),1));
    buf=squeeze(mean(cond1n_dt_bl(roi_maskin,peak(j):peak(j)+4,j),1));
    d=[d1,d2,d3,d4];
    if sum(d>0)>0
        i=find(d>0);
        if (d(i(end))/abs(d(i(end)-1)))*100>70
            disp(['trial ',int2str(j)])
            peak2(j)=peak2(j)+i(end);
            disp(int2str(peak2(j)))
%              figure
%              plot(squeeze(mean(cond1n_dt_bl(roi_maskin,2:120,j),1)))
%              hold on
%              title(['trial ',int2str(j)])
        end
    end
    maskin(j)=find(squeeze(mean(cond1n_dt_bl(roi_maskin,:,j),1))==min(squeeze(mean(cond1n_dt_bl(roi_maskin,39:75,j),1))));
    der(j)=(squeeze(mean(cond1n_dt_bl(roi_maskin,maskin(j),j),1))-squeeze(mean(cond1n_dt_bl(roi_maskin,peak(j),j),1)))./(maskin(j)-peak(j));
    mod(j)=(squeeze(mean(cond1n_dt_bl(roi_maskin,maskin(j),j),1))-1)/(squeeze(mean(cond1n_dt_bl(roi_maskin,peak(j),j),1))-1);
    time(j)=maskin(j)-peak(j);

    der1=squeeze(mean(cond1n_dt_bl(roi_maskin,4:end,j),1))-squeeze(mean(cond1n_dt_bl(roi_maskin,4-2:end-2,j),1));
    der_min(j)=find(der1==min(der1(30:50)));
end 


for i=1:20
    figure;
    mimg(mfilt2(cond1n_dt_bl(:,28:80,i),100,100,1,'lm')-1,100,100,-.2e-3,1.2e-3);colormap(mapgeog);
    title(['trial ',int2str(i)])
end


for j=8
    
    figure
    plot(squeeze(mean(a(roi_maskin,2:120,j),1)))
    hold on
    plot(squeeze(mean(a(roi_maskin,2:120,j),1)),'-.')
    plot(squeeze(mean(a(roi_tar,2:120,j),1)),'r')
    plot(squeeze(mean(a(roi_f2,2:120,j),1)),'color','r','linestyle','-.')
    title(['trial ',int2str(j)])
end


for j=1:11
    figure;mimg(mfilt2(a(:,20:120,j),100,100,1,'lm'),100,100,-.2,.4);colormap(mapgeog);
end
    
    
for i=10:19
    figure
    plot(squeeze(mean(cond22n_dt_bl(roi_maskin,2:120,i),1)))
    hold on
    plot(squeeze(mean(cond1n_dt_bl(roi_maskin,2:120,14),1)),'g')
    title(['trial ',int2str(i)])
end
    
    
cond1n_dt_bl=cond1n_dt_bl./repmat(mean(cond1n_dt_bl(:,36:38,:),2),[1 256 1]);    


%%

t=([2 8 11:14 16:18 20]);

figure;scatter(peak(t),first_eye1(t));
figure;scatter(peak2(t),first_eye1(t));
figure;scatter(maskin(t),first_eye1(t));
figure;scatter(der(t),first_eye1(t));
figure;scatter(mod(t),first_eye1(t));
figure;scatter(time(t),first_eye1(t));
figure;scatter(der_min(t),first_eye1(t));

[stats_peak] = regstats(peak(t),first_eye1(t),'linear',{'fstat','r'});
[stats_peak2] = regstats(peak2(t),first_eye1(t),'linear',{'fstat','r'});
[stats_maskin] = regstats(maskin(t),first_eye1(t),'linear',{'fstat','r'});
[stats_der] = regstats(der(t),first_eye1(t),'linear',{'fstat','r'});
[stats_mod] = regstats(mod(t),first_eye1(t),'linear',{'fstat','r'});
[stats_time] = regstats(time(t),first_eye1(t),'linear',{'fstat','r'});
[stats_der_min] = regstats(der_min(t),first_eye1(t),'linear',{'fstat','r'});


f_cond1(1,:)=[stats_peak.fstat.pval stats_peak2.fstat.pval stats_maskin.fstat.pval stats_der.fstat.pval stats_mod.fstat.pval stats_time.fstat.pval stats_der_min.fstat.pval];
f_cond1(2,:)=[stats_peak.fstat.pval stats_peak2.fstat.pval stats_maskin.fstat.pval stats_der.fstat.pval stats_mod.fstat.pval stats_time.fstat.pval stats_der_min.fstat.pval];



%%

%1111/c
cond1_left=[2 8 11:14 16:18 20];
cond2_left=[1:3 8 10 11 13:16 19];

%1111/d

cond1_left=[4 6 7 8 10 11 13 15:32];
cond2_left=[1 3 4 6:9 12:16 18:20 22:31];

%0610e
cond1_left=[1 3:6 9 11:20 22:25];
cond2_left=[3 4 7:12 15 16 19 21 22];

%2511d

cond1_left=[3 8 11 17 19 20 24 25];

%2511e

cond1_left=[1:5 8:20];

%1203d

cond1_left=[1:6 8:12 15:23 25:27];











