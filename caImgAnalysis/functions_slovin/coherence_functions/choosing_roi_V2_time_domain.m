





time=34:42;


cond3n_dt_bl(isnan(cond3n_dt_bl))=1;
figure(100);
mimg(mfilt2(mean(cond3n_dt_bl(:,time,:),3)-1,100,100,1,'lm'),100,100,-0.5e-3,2.2e-3);colormap(mapgeog);
roi = choose_polygon(100);


c=std(mean(cond3n_dt_bl(:,10:25,:),2),0,3).^2;
SNR_V2=(mean(mean(cond3n_dt_bl(:,time,:),3),2)-mean(mean(cond3n_dt_bl(:,10:25,:),3),2)).^2./c;
SNR_V2(isnan(SNR_V2))=0;


thresh=25; %in std
roi_V2=roi(find(SNR_V2(roi)>=thresh));   %define new ROI for V2
figure;
c=zeros(10000,1);
c(roi_V2)=10;
mimg(c,100,100,0,10);colormap(mapgeog);


