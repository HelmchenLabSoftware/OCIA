

cond=[2 4 6 3];    %choose conditions
roi='V1';       %choose region of interest
time=112;          %choose time frames (starting from the begining)
pix=10000;
freq=32;
% condition 1




eval(['load coher_',roi,'_cond',int2str(cond(1))])
disp(['cond ',int2str(cond(1)),' roi ',roi])
e=zeros(pix,freq,time);
eval(['e(pixels,:,:)=coher_',roi,'_cond',int2str(cond(1)),'(:,:,1:time);'])
e(isnan(e))=0;
eval(['clear coher_',roi,'_cond',int2str(cond(1))])

eval(['load power_cond',int2str(cond(1))])
disp(['cond ',int2str(cond(1))])
f=zeros(freq,time,pix);
eval(['f(:,:,pixels)=power_cond',int2str(cond(1)),'(:,1:time,:);'])
f=shiftdim(f,2);
f(isnan(f))=0;
eval(['clear power_cond',int2str(cond(1))])


eval(['a=(abs(e).^2)./(f.*repmat(mean(f(roi_',roi,',:,:),1),[pix 1 1]));'])
clear e f
a(isnan(a))=0;

% condition 2


eval(['load coher_',roi,'_cond',int2str(cond(2))])
disp(['cond ',int2str(cond(2)),' roi ',roi])
e=zeros(pix,freq,time);
eval(['e(pixels,:,:)=coher_',roi,'_cond',int2str(cond(2)),'(:,:,1:time);'])
e(isnan(e))=0;
eval(['clear coher_',roi,'_cond',int2str(cond(2))])


eval(['load power_cond',int2str(cond(2))])
disp(['cond ',int2str(cond(2))])
f=zeros(freq,time,pix);
eval(['f(:,:,pixels)=power_cond',int2str(cond(2)),'(:,1:time,:);'])
f=shiftdim(f,2);
f(isnan(f))=0;
eval(['clear power_cond',int2str(cond(2))])

eval(['b=(abs(e).^2)./(f.*repmat(mean(f(roi_',roi,',:,:),1),[pix 1 1]));'])
clear e f
b(isnan(b))=0;


% condition 3


eval(['load coher_',roi,'_cond',int2str(cond(3))])
disp(['cond ',int2str(cond(3)),' roi ',roi])
e=zeros(pix,freq,time);
eval(['e(pixels,:,:)=coher_',roi,'_cond',int2str(cond(3)),'(:,:,1:time);'])
e(isnan(e))=0;
eval(['clear coher_',roi,'_cond',int2str(cond(3))])


eval(['load power_cond',int2str(cond(3))])
disp(['cond ',int2str(cond(3))])
f=zeros(freq,time,pix);
eval(['f(:,:,pixels)=power_cond',int2str(cond(3)),'(:,1:time,:);'])
f=shiftdim(f,2);
f(isnan(f))=0;
eval(['clear power_cond',int2str(cond(3))])


eval(['c=(abs(e).^2)./(f.*repmat(mean(f(roi_',roi,',:,:),1),[pix 1 1]));'])
clear e f
c(isnan(c))=0;




% condition 4

eval(['load coher_',roi,'_cond',int2str(cond(4))])
disp(['cond ',int2str(cond(4)),' roi ',roi])
e=zeros(pix,freq,time);
eval(['e(pixels,:,:)=coher_',roi,'_cond',int2str(cond(4)),'(:,:,1:time);'])
e(isnan(e))=0;
eval(['clear coher_',roi,'_cond',int2str(cond(4))])


eval(['load power_cond',int2str(cond(4))])
disp(['cond ',int2str(cond(4))])
f=zeros(freq,time,pix);
eval(['f(:,:,pixels)=power_cond',int2str(cond(4)),'(:,1:time,:);'])
f=shiftdim(f,2);
f(isnan(f))=0;
eval(['clear power_cond',int2str(cond(4))])

eval(['d=(abs(e).^2)./(f.*repmat(mean(f(roi_',roi,',:,:),1),[pix 1 1]));'])
clear e f
d(isnan(d))=0;



%figure;plotspconds(cat(3,squeeze(mean(a(:,10:15,:),2)),squeeze(mean(b(:,10:15,:),2)),squeeze(mean(c(:,10:15,:),2))),100,100,10);