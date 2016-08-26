cond=[1 4 2 5];
roi='V2total';     %choose region of interest
roi2='V2total';
time=112;          %choose time frames (starting from the begining)
pix=10000;
load 1111

eval(['s=size(roi_',roi2,',1);'])
eval(['t=size(roi_',roi,',1);'])

for p=1:s
    disp(p)
    eval(['load coeff_',roi,'_cond',int2str(cond(1)),'_pix_',int2str(roi_V2total(p))])
    eval(['load coeff_',roi,'_cond',int2str(cond(2)),'_pix_',int2str(roi_V2total(p))])
    eval(['load coeff_',roi,'_cond',int2str(cond(3)),'_pix_',int2str(roi_V2total(p))])
    eval(['load coeff_',roi,'_cond',int2str(cond(4)),'_pix_',int2str(roi_V2total(p))])
    eval(['a=coeff_',roi,'_cond',int2str(cond(1)),'_pix_',int2str(roi_V2total(p)),';'])
    eval(['b=coeff_',roi,'_cond',int2str(cond(2)),'_pix_',int2str(roi_V2total(p)),';'])
    eval(['c=coeff_',roi,'_cond',int2str(cond(3)),'_pix_',int2str(roi_V2total(p)),';'])
    eval(['d=coeff_',roi,'_cond',int2str(cond(4)),'_pix_',int2str(roi_V2total(p)),';'])
%     a=a-repmat(mean(a(:,10:20),2),1,120);
%     b=b-repmat(mean(b(:,10:20),2),1,120);
%     c=c-repmat(mean(c(:,10:20),2),1,120);
%     d=d-repmat(mean(d(:,10:20),2),1,120);
    figure;
    plot(mean(a,1))
    hold on
    plot(mean(b,1),'g')
    plot(mean(c,1),'r')
    plot(mean(d,1),'c')
    eval(['title(''pixel ',int2str(roi_V2total(p)),' v2'')'])
    eval(['clear coeff_',roi,'_cond',int2str(cond(1)),'_pix_',int2str(roi_V2total(p))])
    eval(['clear coeff_',roi,'_cond',int2str(cond(2)),'_pix_',int2str(roi_V2total(p))])
    eval(['clear coeff_',roi,'_cond',int2str(cond(3)),'_pix_',int2str(roi_V2total(p))])
    eval(['clear coeff_',roi,'_cond',int2str(cond(4)),'_pix_',int2str(roi_V2total(p))])
    clear a b c d
end
    
    
    
    
    
    
    