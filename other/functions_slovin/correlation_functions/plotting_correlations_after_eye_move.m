
c=1;
for i=1:21
    roi=em2rois(1,c).bgout{i,1};
    if isnan(roi)
        roi=[];
    end
    roi2=em2rois(1,c).contour{i,1};
    if isnan(roi2)
        roi2=[];
    end
    h=zeros(10000,1);
    h(roi2)=2;
    h(roi)=1;
    figure;mimg(h,100,100,0,2);
end


for i=[20]
    roi=em2rois(1,c).bgout{i,1};
    if isnan(roi)
        roi=[];
    end
    roi2=em2rois(1,c).contour{i,1};
    if isnan(roi2)
        roi2=[];
    end
    h=zeros(10000,1);
    h(roi2)=2;
    h(roi)=1;
    figure;mimg(h,100,100,0,2);
    before=mean(b(:,:,i),3);
    after=mean(a(:,:,i),3);
    figure;plot(mean(before(roi_bg_in,:),1))
    hold on
    plot(mean(after(roi,:),1),'r')
    figure;mimg(mfilt2(mean(a(:,20:112,i),3),100,100,1,'lm'),100,100,-.2,0.6);colormap(mapgeog)
    figure;mimg(mfilt2(mean(b(:,20:112,i),3),100,100,1,'lm'),100,100,-.2,0.6);colormap(mapgeog)
end

