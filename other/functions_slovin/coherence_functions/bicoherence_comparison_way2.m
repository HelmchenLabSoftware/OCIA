cond=[1 4 2 5];    %choose conditions
roi='tar';       %choose region of interest
time=112;          %choose time frames (starting from the begining)
pix=10000;


perm=6;

% condition 1



eval(['load bicross_',roi,'_cond',int2str(cond(1))])
disp(['cond ',int2str(cond(1))])
e=zeros(pix,13,time);
eval(['e(pixels,:,:)=bicross_',roi,'_cond',int2str(cond(1)),'(:,:,1:time);'])
e(isnan(e))=0;
eval(['clear bicross_',roi,'_cond',int2str(cond(1))])

eval(['load power_cond',int2str(cond(1))])
disp(['cond ',int2str(cond(1))])
f=zeros(32,time,pix);
eval(['f(:,:,pixels)=power_cond',int2str(cond(1)),'(:,1:time,:);'])
f=shiftdim(f,2);
f(isnan(f))=0;
eval(['clear power_cond',int2str(cond(1))])


r=f(:,8:2:end,:);
eval(['q=circshift(f(:,:,:),[0 -perm 0]);'])
eval(['a=(abs(e).^2)./(repmat(mean(f(roi_',roi,',1:13,:),1),[pix 1 1]).*q(:,1:13,:).*r);'])
clear e f r
a(isnan(a))=0;

% condition 2



eval(['load bicross_',roi,'_cond',int2str(cond(2))])
disp(['cond ',int2str(cond(2))])
e=zeros(pix,13,time);
eval(['e(pixels,:,:)=bicross_',roi,'_cond',int2str(cond(2)),'(:,:,1:time);'])
e(isnan(e))=0;
eval(['clear bicross_',roi,'_cond',int2str(cond(2))])

eval(['load power_cond',int2str(cond(2))])
disp(['cond ',int2str(cond(2))])
f=zeros(32,time,pix);
eval(['f(:,:,pixels)=power_cond',int2str(cond(2)),'(:,1:time,:);'])
f=shiftdim(f,2);
f(isnan(f))=0;
eval(['clear power_cond',int2str(cond(2))])

r=f(:,8:2:end,:);
eval(['q=circshift(f(:,:,:),[0 -perm 0]);'])
eval(['b=(abs(e).^2)./(repmat(mean(f(roi_',roi,',1:13,:),1),[pix 1 1]).*q(:,1:13,:).*r);'])
clear e f r
b(isnan(b))=0;


% condition 3



eval(['load bicross_',roi,'_cond',int2str(cond(3))])
disp(['cond ',int2str(cond(3))])
e=zeros(pix,13,time);
eval(['e(pixels,:,:)=bicross_',roi,'_cond',int2str(cond(3)),'(:,:,1:time);'])
e(isnan(e))=0;
eval(['clear bicross_',roi,'_cond',int2str(cond(3))])

eval(['load power_cond',int2str(cond(3))])
disp(['cond ',int2str(cond(3))])
f=zeros(32,time,pix);
eval(['f(:,:,pixels)=power_cond',int2str(cond(3)),'(:,1:time,:);'])
f=shiftdim(f,2);
f(isnan(f))=0;
eval(['clear power_cond',int2str(cond(3))])

r=f(:,8:2:end,:);
eval(['q=circshift(f(:,:,:),[0 -perm 0]);'])
eval(['c=(abs(e).^2)./(repmat(mean(f(roi_',roi,',1:13,:),1),[pix 1 1]).*q(:,1:13,:).*r);'])
clear e f r
c(isnan(c))=0;


% condition 4



eval(['load bicross_',roi,'_cond',int2str(cond(4))])
disp(['cond ',int2str(cond(4))])
e=zeros(pix,13,time);
eval(['e(pixels,:,:)=bicross_',roi,'_cond',int2str(cond(4)),'(:,:,1:time);'])
e(isnan(e))=0;
eval(['clear bicross_',roi,'_cond',int2str(cond(4))])

eval(['load power_cond',int2str(cond(4))])
disp(['cond ',int2str(cond(4))])
f=zeros(32,time,pix);
eval(['f(:,:,pixels)=power_cond',int2str(cond(4)),'(:,1:time,:);'])
f=shiftdim(f,2);
f(isnan(f))=0;
eval(['clear power_cond',int2str(cond(4))])


r=f(:,8:2:end,:);
eval(['q=circshift(f(:,:,:),[0 -perm 0]);'])
eval(['d=(abs(e).^2)./(repmat(mean(f(roi_',roi,',1:13,:),1),[pix 1 1]).*q(:,1:13,:).*r);'])
clear e f r
d(isnan(d))=0;

