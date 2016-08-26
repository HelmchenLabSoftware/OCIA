
for j=1:20
    
    figure
    plot(squeeze(mean(cond4n_dt_bl(roi_maskin,33:41,j),1)))
    hold on
    %plot(squeeze(mean(cond4n_dt_bl(roi_maskout,33:41,j),1)),'-.')
    plot(squeeze(mean(cond4n_dt_bl(roi_tar,33:41,j),1)),'r')
    plot(squeeze(mean(cond4n_dt_bl(roi_f1late,33:41,j),1)),'r')
    plot(squeeze(mean(cond4n_dt_bl(roi_f2,33:41,j),1)),'color','r','linestyle','-.')
    title(['trial ',int2str(j)])
end

for j=1:28
%     figure
%     plot(squeeze(mean(cond1n_dt_bl(roi_bg_in,2:120,j),1)))
    peak(j)=find(squeeze(mean(cond5n_dt_bl(roi_maskin,:,j),1))==max(squeeze(mean(cond5n_dt_bl(roi_maskin,35:50,j),1))));
    %peak2(j)=find(squeeze(mean(cond2n_dt_bl(roi_maskin,:,j),1))==min(squeeze(mean(cond2n_dt_bl(roi_maskin,37:65,j),1))));
    hold on
end 

for i=2
    figure;
    mimg(mfilt2(cond2n_dt_bl(:,28:120,i),100,100,1,'lm')-1,100,100,-.2e-3,1.2e-3);colormap(mapgeog);
    title(['trial ',int2str(i)])
end


for j=8
    
    figure
    plot(squeeze(mean(a(roi_maskin,2:120,j),1)))
    hold on
    plot(squeeze(mean(a(roi_maskout,2:120,j),1)),'-.')
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
    plot(squeeze(mean(cond2n_dt_bl(roi_maskin,2:120,14),1)),'g')
    title(['trial ',int2str(i)])
end
    
    
cond1n_dt_bl=cond1n_dt_bl./repmat(mean(cond1n_dt_bl(:,36:38,:),2),[1 256 1]);    
    
    
    
