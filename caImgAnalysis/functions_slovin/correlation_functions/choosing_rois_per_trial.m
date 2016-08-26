


bg_index=(squeeze(mean(a(roi_bg_in,:,:),1))+squeeze(mean(a(roi_bg_out,:,:),1)));

% for i=1:25
%     tar_index(:,i)=squeeze(mean(a(roi_circle{i},:,i),1));
% end
tar_index=squeeze(mean(a(roi_tar,:,:),1));
f1_index=squeeze(mean(a(roi_f1,:,:),1));
contour_index=squeeze(mean(a(roi_contour,:,:),1));
f2_index=squeeze(mean(a(roi_f2,:,:),1));

popout_index=bg_index-2*tar_index;
popout_index2=bg_index-2*f2_index;
popout_index3=bg_index-(f2_index+tar_index);
popout_index4=bg_index-2*contour_index;
popout_index5=bg_index-2*(f2_index+tar_index+f1_index)/3;
popout_index6=(f2_index+tar_index+f1_index)-3*bg_index;



ind=popout_index5;
time=46:110;

for j=1:25
    figure;mimg(mfilt2(a(:,find(ind(:,j)==max(ind(time,j)))-4:find(ind(:,j)==max(ind(time,j)))+4,j),100,100,1,'lm'),100,100,-.4,.4);colormap(mapgeog);
    peak(j)=find(ind(:,j)==max(ind(time,j)));
    figure;mimg(mfilt2(b(:,find(ind(:,j)==max(ind(time,j)))-4:find(ind(:,j)==max(ind(time,j)))+4,j),100,100,1,'lm'),100,100,-.4,.4);colormap(mapgeog);
    figure;mimg(mfilt2(c(:,find(ind(:,j)==max(ind(time,j)))-4:find(ind(:,j)==max(ind(time,j)))+4,j),100,100,1,'lm'),100,100,-.4,.4);colormap(mapgeog);
    figure;
    plot(popout_index(:,j))
    hold on
    plot(popout_index2(:,j),'r')
    plot(popout_index3(:,j),'g')
    plot(popout_index4(:,j),'c')
    plot(popout_index5(:,j),'m')
    %plot(popout_index6(:,j),'+')
    %plot(ind(:,j),'m')
    title(['trial #',int2str(j),' max is ',int2str(find(ind(:,j)==max(ind(time,j))))])
end



for k=27
    figure;mimg(mfilt2(a(:,20:120,k),100,100,1,'lm'),100,100,-.8,.8);colormap(mapgeog);
    figure;mimg(mfilt2(b(:,20:120,k),100,100,1,'lm'),100,100,-.4,.4);colormap(mapgeog);
    figure;mimg(mfilt2(c(:,20:120,k),100,100,1,'lm'),100,100,-.4,.4);colormap(mapgeog);
    title(['trial #',int2str(k)])
    h=zeros(10000,1);
    h(roi_f2)=1;
    h(roi_circle{2,k})=2;
    figure;mimg(h,100,100,0,2);
end




