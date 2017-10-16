



imagesc(x,y,spect_all_conds(:,:,2),[-10 15])

plot(y,squeeze(mean(spect_all_conds(:,x(127:176),4),2)));
hold on
plot(y,squeeze(mean(spect_all_conds(:,x(127:176),3),2)),'g');
plot(y,squeeze(mean(spect_all_conds(:,x(127:176),2),2)),'r');
plot(y,squeeze(mean(spect_all_conds(:,x(127:176),6),2)),'c');



y=1:50/32:50;
x=10:10:1120;

a=10*log10(a./repmat(mean(a(:,:,2:11),3),[1 1 112]));
a(isnan(a))=0;
a(isinf(a))=0;

b=10*log10(b./repmat(mean(b(:,:,2:11),3),[1 1 112]));
b(isnan(b))=0;
b(isinf(b))=0;

c=10*log10(c./repmat(mean(c(:,:,2:11),3),[1 1 112]));
c(isnan(c))=0;
c(isinf(c))=0;

d=10*log10(d./repmat(mean(d(:,:,2:11),3),[1 1 112]));
d(isnan(d))=0;
d(isinf(d))=0;

imagesc(x,y,squeeze(mean(a(roi_V1,:,:),1)),[-1 1.2])

