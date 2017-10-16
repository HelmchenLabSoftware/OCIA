cd F:\Data\VSDI\Contour_integration\legolas\right_hemisphere\11_11_2008\c\elhanan_new
load myrois

roi=roi_contour2;
r='contour2';

time=28:42;
win=6;
for c=[5]
    eval(['load cond',int2str(c),'n_dt_bl'])
    eval(['t=cond',int2str(c),'n_dt_bl;'])
    eval(['clear cond',int2str(c),'n_dt_bl'])
    load myrois
    k=size(time,2)-win;
    for h=1:size(t,3)
        v=nan*ones(size(roi,1),size(roi,1),k*2-1,k);
        disp(h)
        for i=1:size(roi,1)
            for j=1:size(roi,1)
                for ii=1:k
                    for jj=1:k
                        temp=corrcoef(t(roi(i),time(ii:ii+win),h),t(roi(j),time(jj:jj+win),h));
                        v(i,j,k+jj-ii,ii)=temp(1,2);
                    end
                end 
                
            end
        end
        v=nanmean(v,4);
        if h==1
            crv=v;
        else
            crv=crv+v;
        end
        clear v
    end
    crv=crv/size(t,3);
    crv=reshape(crv,[size(roi,1)*size(roi,1),2*k-1]);
    eval(['crv_cond',int2str(c),'=crv;'])
    clear crv
    eval(['save crv_',r,'_cond',int2str(c),'_sliding crv_cond',int2str(c),' time roi'])
    eval(['clear crv_cond',int2str(c)])
end


