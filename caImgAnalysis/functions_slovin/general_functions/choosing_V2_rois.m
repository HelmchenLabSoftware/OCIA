
cond=condz(:,:,5)./condz(:,:,6);
cond=mean(cond1n_dt_bl,3);
cond(isnan(cond))=1;
roi=V2;


c=nanstd(cond(:,10:25),0,2).^2;
SNR_V2=(mean(cond(:,33:36),2)-mean(cond(:,10:25),2)).^2./c;
SNR_V2(isnan(SNR_V2))=0;
thresh=(3)^2; %in std

roi_V2=roi(find(SNR_V2(roi)>=thresh));   %define new ROI for V2

sd=sqrt(thresh);

figure;
c=zeros(10000,1);
c(roi_V2)=10;
mimg(c,100,100,0,10);colormap(mapgeog);


