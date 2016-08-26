cond=[4];    %choose conditions
roi='V1';          %choose region of interest
time=112;          %choose time frames (starting from the begining)
pix=10000;
load 1804
% condition 1

eval(['load power_cond',int2str(cond(1))])
disp(['cond ',int2str(cond(1))])
f=zeros(32,time,pix);
eval(['f(:,:,pixels)=power_cond',int2str(cond(1)),';'])
f=shiftdim(f,2);
f(isnan(f))=0;
eval(['clear power_cond',int2str(cond(1))])

for p=1:30

    eval(['load cross_',roi,'_cond',int2str(cond(1)),'_pix_',int2str(roi_V1(p))])
    disp(['cond ',int2str(cond(1))])
    e=zeros(pix,32,time);
    eval(['e(pixels,:,:)=cross_',roi,'_cond',int2str(cond(1)),'(:,:,1:time);'])
    e(isnan(e))=0;
    eval(['clear cross_',roi,'_cond',int2str(cond(1))])

    disp(int2str(p))

    eval(['a=(abs(e).^2)./(f.*repmat(f(roi_',roi,'(p),:,:),[pix 1 1]));'])
    clear e
    a(isnan(a))=0;
    eval(['coher_',roi,'_cond',int2str(cond(1)),'=a;'])
    eval(['save coher_',roi,'_cond',int2str(cond(1)),'_pix_',int2str(roi_V1(p)),' coher_',roi,'_cond',int2str(cond(1))])
    eval(['clear coher_',roi,'_cond',int2str(cond(1))])

end