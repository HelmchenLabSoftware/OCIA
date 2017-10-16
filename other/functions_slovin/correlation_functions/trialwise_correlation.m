


bg_index1=(squeeze(mean(a(roi_maskin,:,:),1))+squeeze(mean(a(roi_maskout,:,:),1)));
bg_index2=(squeeze(mean(b(roi_maskin,:,:),1))+squeeze(mean(b(roi_maskout,:,:),1)));

for i=1:26
    tar_index1(:,i)=squeeze(mean(a(roi_circle{i},:,i),1));
    tar_index2(:,i)=squeeze(mean(b(roi_circle{i},:,i),1));
end
%tar_index=squeeze(mean(a(roi_tar,:,:),1));
f1_index1=squeeze(mean(a(roi_f1late,:,:),1));
f1_index2=squeeze(mean(b(roi_f1late,:,:),1));
contour_index=squeeze(mean(b(roi_contour,:,:),1));
f2_index1=squeeze(mean(a(roi_f2,:,:),1));
f2_index2=squeeze(mean(b(roi_f2,:,:),1));

for t=1:26
    total(:,t)=squeeze(mean(a([roi_f2;roi_f1late;roi_circle{t};roi_maskout;roi_maskout],:,t),1));
end

index1=bg_index1-tar_index1;
index2=bg_index1-f2_index1;
index3=bg_index1-f1_index1;
index4=tar_index2-bg_index2;
index5=f1_index2-bg_index2;
index6=f2_index2-bg_index2;
popout_index1=index1+index2+index3;
popout_index2=index4+index5+index6;



% popout_index5=2*(f2_index2+tar_index2+f1_index2)/3-bg_index2;
% popout_index6=(f2_index+tar_index+f1_index)-3*bg_index;



ind=popout_index-popout_index2;
time=46:110;

for j=1:26
%     figure;mimg(mfilt2(a(:,find(ind(:,j)==max(ind(time,j)))-4:find(ind(:,j)==max(ind(time,j)))+4,j),100,100,1,'lm'),100,100,-.8,.8);colormap(mapgeog);
      peak(1,j)=find(popout_index1(:,j)==max(popout_index1(time,j)));
      peak(2,j)=find(popout_index2(:,j)==max(popout_index2(time,j)));
%     figure;mimg(mfilt2(b(:,find(ind(:,j)==max(ind(time,j)))-4:find(ind(:,j)==max(ind(time,j)))+4,j),100,100,1,'lm'),100,100,-.4,.4);colormap(mapgeog);
%     figure;mimg(mfilt2(c(:,find(ind(:,j)==max(ind(time,j)))-4:find(ind(:,j)==max(ind(time,j)))+4,j),100,100,1,'lm'),100,100,-.4,.4);colormap(mapgeog);
%     figure
%     plot(squeeze(mean(cond1n_dt_bl(roi_maskin,2:120,j),1)))
%     hold on
%     plot(squeeze(mean(cond1n_dt_bl(roi_maskout,2:120,j),1)),'-.')
%     plot(squeeze(mean(cond1n_dt_bl(roi_circle{1,j},2:120,j),1)),'r')
%     plot(squeeze(mean(cond1n_dt_bl(roi_f2,2:120,j),1)),'color','r','linestyle','-.')
%     
    figure;
    plot(popout_index1(:,j))
    hold on
    plot(popout_index2(:,j),'r')
%     plot(popout_index3(:,j),'b')
%     plot(popout_index4(:,j),'r')
%     plot(popout_index5(:,j),'r')
%     plot(popout_index6(:,j),'r')
    %plot(ind(:,j),'g')
    title(['trial #',int2str(j),': bg is max at ',int2str(find(popout_index1(:,j)==max(popout_index1(time,j)))),' circle is max at ',int2str(find(popout_index2(:,j)==max(popout_index2(time,j))))])
end



for k=13
    figure;mimg(mfilt2(a(:,20:120,k),100,100,1,'lm'),100,100,-.8,.8);colormap(mapgeog);
    figure;mimg(mfilt2(b(:,20:120,k),100,100,1,'lm'),100,100,-.4,.4);colormap(mapgeog);
    %figure;mimg(mfilt2(c(:,20:120,k),100,100,1,'lm'),100,100,-.4,.4);colormap(mapgeog);
    title(['trial #',int2str(k)])
    h=zeros(10000,1);
    h(roi_f2)=1;
    %h(roi_circle{2,k})=2;
    figure;mimg(h,100,100,0,2);
end




