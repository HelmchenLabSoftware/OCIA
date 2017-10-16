cond=[1 4 2 5];
roi='V2total';     %choose region of interest
roi2='vvv';
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
    diff1=a-b;
    diff2=c-d;
    eval(['clear coeff_',roi,'_cond',int2str(cond(1)),'_pix_',int2str(roi_V2total(p))])
    eval(['clear coeff_',roi,'_cond',int2str(cond(2)),'_pix_',int2str(roi_V2total(p))])
    eval(['clear coeff_',roi,'_cond',int2str(cond(3)),'_pix_',int2str(roi_V2total(p))])
    eval(['clear coeff_',roi,'_cond',int2str(cond(4)),'_pix_',int2str(roi_V2total(p))])
    clear a b c d
    eval(['coefff_',roi2,'_diff14_pix_',int2str(roi_V2total(p)),'=zeros(',int2str(t),',',int2str(time),');'])
    eval(['coefff_',roi2,'_diff25_pix_',int2str(roi_V2total(p)),'=zeros(',int2str(t),',',int2str(time),');'])
    eval(['v1=find(diff1(:,1:',int2str(time),')>0);'])
    eval(['v2=find(diff2(:,1:',int2str(time),')>0);'])
    eval(['coefff_',roi2,'_diff14_pix_',int2str(roi_V2total(p)),'(v1)=1;'])
    eval(['coefff_',roi2,'_diff25_pix_',int2str(roi_V2total(p)),'(v2)=1;'])
    if p==1
        eval(['coefff_',roi2,'_diff14=coefff_',roi2,'_diff14_pix_',int2str(roi_V2total(p)),';'])
        eval(['coefff_',roi2,'_diff25=coefff_',roi2,'_diff25_pix_',int2str(roi_V2total(p)),';'])
    else
        eval(['coefff_',roi2,'_diff14=coefff_',roi2,'_diff14+coefff_',roi2,'_diff14_pix_',int2str(roi_V2total(p)),';'])
        eval(['coefff_',roi2,'_diff25=coefff_',roi2,'_diff25+coefff_',roi2,'_diff25_pix_',int2str(roi_V2total(p)),';'])
    end 
    eval(['clear coefff_',roi2,'_diff14_pix_',int2str(roi_V2total(p))])
    eval(['clear coefff_',roi2,'_diff25_pix_',int2str(roi_V2total(p))])
end
eval(['save coefff_',roi2,'_diff14 coefff_',roi2,'_diff14'])
eval(['save coefff_',roi2,'_diff25 coefff_',roi2,'_diff25'])
