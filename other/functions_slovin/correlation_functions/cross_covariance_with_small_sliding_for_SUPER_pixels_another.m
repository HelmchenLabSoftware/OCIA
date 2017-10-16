
cd F:\Data\VSDI\Contour_integration\legolas\right_hemisphere\psychophysics\2008_11_18\d\correct_and_incorrect_together
load myrois

time=28:43;
win=4;
roi=roi_circle_diff;
r='circle_diff';
aa=size(roi,1);
sp=12;
for c=[1 5]
    kk=-sp+1;
    eval(['load cond',int2str(c),'n_dt_bl'])
    eval(['t=cond',int2str(c),'n_dt_bl;'])
    eval(['clear cond',int2str(c),'n_dt_bl'])
    superpix=zeros(floor(aa/sp)-1,size(t,2),size(t,3));
    for i=1:floor(aa/sp)-1
        kk=kk+12;
        superpix(i,:,:)=mean(t(roi(kk:kk+11),:,:),1);
    end
  
    k=size(time,2)-win;
    for h=1:size(t,3)
        v=nan*ones(size(superpix,1),size(superpix,1),k*2-1,k);
        disp(h)
        for i=1:size(superpix,1)
            for j=1:size(superpix,1)
                for ii=1:k
                    for jj=1:k
                        temp=corrcoef(superpix(i,time(ii:ii+win),h),superpix(j,time(jj:jj+win),h));
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
    crv=crv/size(superpix,3);
    crv=reshape(crv,[size(superpix,1)*size(superpix,1),2*k-1]);
    eval(['crv_cond',int2str(c),'=crv;'])
    clear crv
    eval(['save crv_',r,'_cond',int2str(c),'_superpix_w4 crv_cond',int2str(c),' time roi'])
    eval(['clear crv_cond',int2str(c)])
end 

roi=roi_bg_in_narrow;
r='roi_bg_in_narrow';
aa=size(roi,1);
sp=12;
for c=[1 5]
    kk=-sp+1;
    eval(['load cond',int2str(c),'n_dt_bl'])
    eval(['t=cond',int2str(c),'n_dt_bl;'])
    eval(['clear cond',int2str(c),'n_dt_bl'])
    superpix=zeros(floor(aa/sp)-1,size(t,2),size(t,3));
    for i=1:floor(aa/sp)-1
        kk=kk+12;
        superpix(i,:,:)=mean(t(roi(kk:kk+11),:,:),1);
    end
  
    k=size(time,2)-win;
    for h=1:size(t,3)
        v=nan*ones(size(superpix,1),size(superpix,1),k*2-1,k);
        disp(h)
        for i=1:size(superpix,1)
            for j=1:size(superpix,1)
                for ii=1:k
                    for jj=1:k
                        temp=corrcoef(superpix(i,time(ii:ii+win),h),superpix(j,time(jj:jj+win),h));
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
    crv=crv/size(superpix,3);
    crv=reshape(crv,[size(superpix,1)*size(superpix,1),2*k-1]);
    eval(['crv_cond',int2str(c),'=crv;'])
    clear crv
    eval(['save crv_',r,'_cond',int2str(c),'_superpix_w4 crv_cond',int2str(c),' time roi'])
    eval(['clear crv_cond',int2str(c)])
end 

cd F:\Data\VSDI\Contour_integration\legolas\right_hemisphere\psychophysics\2008_11_18\e\correct_and_incorrect_together
load myrois

time=28:43;
win=4;
roi=roi_circle_diff;
r='circle_diff';
aa=size(roi,1);
sp=12;
for c=[1 5]
    kk=-sp+1;
    eval(['load cond',int2str(c),'n_dt_bl'])
    eval(['t=cond',int2str(c),'n_dt_bl;'])
    eval(['clear cond',int2str(c),'n_dt_bl'])
    superpix=zeros(floor(aa/sp)-1,size(t,2),size(t,3));
    for i=1:floor(aa/sp)-1
        kk=kk+12;
        superpix(i,:,:)=mean(t(roi(kk:kk+11),:,:),1);
    end
  
    k=size(time,2)-win;
    for h=1:size(t,3)
        v=nan*ones(size(superpix,1),size(superpix,1),k*2-1,k);
        disp(h)
        for i=1:size(superpix,1)
            for j=1:size(superpix,1)
                for ii=1:k
                    for jj=1:k
                        temp=corrcoef(superpix(i,time(ii:ii+win),h),superpix(j,time(jj:jj+win),h));
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
    crv=crv/size(superpix,3);
    crv=reshape(crv,[size(superpix,1)*size(superpix,1),2*k-1]);
    eval(['crv_cond',int2str(c),'=crv;'])
    clear crv
    eval(['save crv_',r,'_cond',int2str(c),'_superpix_w4 crv_cond',int2str(c),' time roi'])
    eval(['clear crv_cond',int2str(c)])
end 

roi=roi_bg_in_narrow;
r='roi_bg_in_narrow';
aa=size(roi,1);
sp=12;
for c=[1 5]
    kk=-sp+1;
    eval(['load cond',int2str(c),'n_dt_bl'])
    eval(['t=cond',int2str(c),'n_dt_bl;'])
    eval(['clear cond',int2str(c),'n_dt_bl'])
    superpix=zeros(floor(aa/sp)-1,size(t,2),size(t,3));
    for i=1:floor(aa/sp)-1
        kk=kk+12;
        superpix(i,:,:)=mean(t(roi(kk:kk+11),:,:),1);
    end
  
    k=size(time,2)-win;
    for h=1:size(t,3)
        v=nan*ones(size(superpix,1),size(superpix,1),k*2-1,k);
        disp(h)
        for i=1:size(superpix,1)
            for j=1:size(superpix,1)
                for ii=1:k
                    for jj=1:k
                        temp=corrcoef(superpix(i,time(ii:ii+win),h),superpix(j,time(jj:jj+win),h));
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
    crv=crv/size(superpix,3);
    crv=reshape(crv,[size(superpix,1)*size(superpix,1),2*k-1]);
    eval(['crv_cond',int2str(c),'=crv;'])
    clear crv
    eval(['save crv_',r,'_cond',int2str(c),'_superpix_w4 crv_cond',int2str(c),' time roi'])
    eval(['clear crv_cond',int2str(c)])
end 

cd F:\Data\VSDI\Contour_integration\legolas\right_hemisphere\psychophysics\2008_11_25\d\correct_and_incorrect_together
load myrois

time=28:43;
win=4;
roi=roi_circle_diff;
r='circle_diff';
aa=size(roi,1);
sp=12;
for c=[1 5]
    kk=-sp+1;
    eval(['load cond',int2str(c),'n_dt_bl'])
    eval(['t=cond',int2str(c),'n_dt_bl;'])
    eval(['clear cond',int2str(c),'n_dt_bl'])
    superpix=zeros(floor(aa/sp)-1,size(t,2),size(t,3));
    for i=1:floor(aa/sp)-1
        kk=kk+12;
        superpix(i,:,:)=mean(t(roi(kk:kk+11),:,:),1);
    end
  
    k=size(time,2)-win;
    for h=1:size(t,3)
        v=nan*ones(size(superpix,1),size(superpix,1),k*2-1,k);
        disp(h)
        for i=1:size(superpix,1)
            for j=1:size(superpix,1)
                for ii=1:k
                    for jj=1:k
                        temp=corrcoef(superpix(i,time(ii:ii+win),h),superpix(j,time(jj:jj+win),h));
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
    crv=crv/size(superpix,3);
    crv=reshape(crv,[size(superpix,1)*size(superpix,1),2*k-1]);
    eval(['crv_cond',int2str(c),'=crv;'])
    clear crv
    eval(['save crv_',r,'_cond',int2str(c),'_superpix_w4 crv_cond',int2str(c),' time roi'])
    eval(['clear crv_cond',int2str(c)])
end 

roi=roi_bg_in_narrow;
r='roi_bg_in_narrow';
aa=size(roi,1);
sp=12;
for c=[1 5]
    kk=-sp+1;
    eval(['load cond',int2str(c),'n_dt_bl'])
    eval(['t=cond',int2str(c),'n_dt_bl;'])
    eval(['clear cond',int2str(c),'n_dt_bl'])
    superpix=zeros(floor(aa/sp)-1,size(t,2),size(t,3));
    for i=1:floor(aa/sp)-1
        kk=kk+12;
        superpix(i,:,:)=mean(t(roi(kk:kk+11),:,:),1);
    end
  
    k=size(time,2)-win;
    for h=1:size(t,3)
        v=nan*ones(size(superpix,1),size(superpix,1),k*2-1,k);
        disp(h)
        for i=1:size(superpix,1)
            for j=1:size(superpix,1)
                for ii=1:k
                    for jj=1:k
                        temp=corrcoef(superpix(i,time(ii:ii+win),h),superpix(j,time(jj:jj+win),h));
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
    crv=crv/size(superpix,3);
    crv=reshape(crv,[size(superpix,1)*size(superpix,1),2*k-1]);
    eval(['crv_cond',int2str(c),'=crv;'])
    clear crv
    eval(['save crv_',r,'_cond',int2str(c),'_superpix_w4 crv_cond',int2str(c),' time roi'])
    eval(['clear crv_cond',int2str(c)])
end 

cd F:\Data\VSDI\Contour_integration\legolas\right_hemisphere\psychophysics\2008_11_25\e\correct_and_incorrect_together
load myrois

time=28:43;
win=4;
roi=roi_circle_diff;
r='circle_diff';
aa=size(roi,1);
sp=12;
for c=[1 5]
    kk=-sp+1;
    eval(['load cond',int2str(c),'n_dt_bl'])
    eval(['t=cond',int2str(c),'n_dt_bl;'])
    eval(['clear cond',int2str(c),'n_dt_bl'])
    superpix=zeros(floor(aa/sp)-1,size(t,2),size(t,3));
    for i=1:floor(aa/sp)-1
        kk=kk+12;
        superpix(i,:,:)=mean(t(roi(kk:kk+11),:,:),1);
    end
  
    k=size(time,2)-win;
    for h=1:size(t,3)
        v=nan*ones(size(superpix,1),size(superpix,1),k*2-1,k);
        disp(h)
        for i=1:size(superpix,1)
            for j=1:size(superpix,1)
                for ii=1:k
                    for jj=1:k
                        temp=corrcoef(superpix(i,time(ii:ii+win),h),superpix(j,time(jj:jj+win),h));
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
    crv=crv/size(superpix,3);
    crv=reshape(crv,[size(superpix,1)*size(superpix,1),2*k-1]);
    eval(['crv_cond',int2str(c),'=crv;'])
    clear crv
    eval(['save crv_',r,'_cond',int2str(c),'_superpix_w4 crv_cond',int2str(c),' time roi'])
    eval(['clear crv_cond',int2str(c)])
end 

roi=roi_bg_in_narrow;
r='roi_bg_in_narrow';
aa=size(roi,1);
sp=12;
for c=[1 5]
    kk=-sp+1;
    eval(['load cond',int2str(c),'n_dt_bl'])
    eval(['t=cond',int2str(c),'n_dt_bl;'])
    eval(['clear cond',int2str(c),'n_dt_bl'])
    superpix=zeros(floor(aa/sp)-1,size(t,2),size(t,3));
    for i=1:floor(aa/sp)-1
        kk=kk+12;
        superpix(i,:,:)=mean(t(roi(kk:kk+11),:,:),1);
    end
  
    k=size(time,2)-win;
    for h=1:size(t,3)
        v=nan*ones(size(superpix,1),size(superpix,1),k*2-1,k);
        disp(h)
        for i=1:size(superpix,1)
            for j=1:size(superpix,1)
                for ii=1:k
                    for jj=1:k
                        temp=corrcoef(superpix(i,time(ii:ii+win),h),superpix(j,time(jj:jj+win),h));
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
    crv=crv/size(superpix,3);
    crv=reshape(crv,[size(superpix,1)*size(superpix,1),2*k-1]);
    eval(['crv_cond',int2str(c),'=crv;'])
    clear crv
    eval(['save crv_',r,'_cond',int2str(c),'_superpix_w4 crv_cond',int2str(c),' time roi'])
    eval(['clear crv_cond',int2str(c)])
end 

cd F:\Data\VSDI\Contour_integration\legolas\right_hemisphere\psychophysics\2008_11_25\f\correct_and_incorrect_together
load myrois

time=28:43;
win=4;
roi=roi_circle_diff;
r='circle_diff';
aa=size(roi,1);
sp=12;
for c=[1 5]
    kk=-sp+1;
    eval(['load cond',int2str(c),'n_dt_bl'])
    eval(['t=cond',int2str(c),'n_dt_bl;'])
    eval(['clear cond',int2str(c),'n_dt_bl'])
    superpix=zeros(floor(aa/sp)-1,size(t,2),size(t,3));
    for i=1:floor(aa/sp)-1
        kk=kk+12;
        superpix(i,:,:)=mean(t(roi(kk:kk+11),:,:),1);
    end
  
    k=size(time,2)-win;
    for h=1:size(t,3)
        v=nan*ones(size(superpix,1),size(superpix,1),k*2-1,k);
        disp(h)
        for i=1:size(superpix,1)
            for j=1:size(superpix,1)
                for ii=1:k
                    for jj=1:k
                        temp=corrcoef(superpix(i,time(ii:ii+win),h),superpix(j,time(jj:jj+win),h));
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
    crv=crv/size(superpix,3);
    crv=reshape(crv,[size(superpix,1)*size(superpix,1),2*k-1]);
    eval(['crv_cond',int2str(c),'=crv;'])
    clear crv
    eval(['save crv_',r,'_cond',int2str(c),'_superpix_w4 crv_cond',int2str(c),' time roi'])
    eval(['clear crv_cond',int2str(c)])
end 

roi=roi_bg_in_narrow;
r='roi_bg_in_narrow';
aa=size(roi,1);
sp=12;
for c=[1 5]
    kk=-sp+1;
    eval(['load cond',int2str(c),'n_dt_bl'])
    eval(['t=cond',int2str(c),'n_dt_bl;'])
    eval(['clear cond',int2str(c),'n_dt_bl'])
    superpix=zeros(floor(aa/sp)-1,size(t,2),size(t,3));
    for i=1:floor(aa/sp)-1
        kk=kk+12;
        superpix(i,:,:)=mean(t(roi(kk:kk+11),:,:),1);
    end
  
    k=size(time,2)-win;
    for h=1:size(t,3)
        v=nan*ones(size(superpix,1),size(superpix,1),k*2-1,k);
        disp(h)
        for i=1:size(superpix,1)
            for j=1:size(superpix,1)
                for ii=1:k
                    for jj=1:k
                        temp=corrcoef(superpix(i,time(ii:ii+win),h),superpix(j,time(jj:jj+win),h));
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
    crv=crv/size(superpix,3);
    crv=reshape(crv,[size(superpix,1)*size(superpix,1),2*k-1]);
    eval(['crv_cond',int2str(c),'=crv;'])
    clear crv
    eval(['save crv_',r,'_cond',int2str(c),'_superpix_w4 crv_cond',int2str(c),' time roi'])
    eval(['clear crv_cond',int2str(c)])
end 

cd F:\Data\VSDI\Contour_integration\legolas\right_hemisphere\psychophysics\2008_12_03\d\correct_and_incorrect_together
load myrois

time=28:43;
win=4;
roi=roi_circle_diff;
r='circle_diff';
aa=size(roi,1);
sp=12;
for c=[1 5]
    kk=-sp+1;
    eval(['load cond',int2str(c),'n_dt_bl'])
    eval(['t=cond',int2str(c),'n_dt_bl;'])
    eval(['clear cond',int2str(c),'n_dt_bl'])
    superpix=zeros(floor(aa/sp)-1,size(t,2),size(t,3));
    for i=1:floor(aa/sp)-1
        kk=kk+12;
        superpix(i,:,:)=mean(t(roi(kk:kk+11),:,:),1);
    end
  
    k=size(time,2)-win;
    for h=1:size(t,3)
        v=nan*ones(size(superpix,1),size(superpix,1),k*2-1,k);
        disp(h)
        for i=1:size(superpix,1)
            for j=1:size(superpix,1)
                for ii=1:k
                    for jj=1:k
                        temp=corrcoef(superpix(i,time(ii:ii+win),h),superpix(j,time(jj:jj+win),h));
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
    crv=crv/size(superpix,3);
    crv=reshape(crv,[size(superpix,1)*size(superpix,1),2*k-1]);
    eval(['crv_cond',int2str(c),'=crv;'])
    clear crv
    eval(['save crv_',r,'_cond',int2str(c),'_superpix_w4 crv_cond',int2str(c),' time roi'])
    eval(['clear crv_cond',int2str(c)])
end 

roi=roi_bg_in_narrow;
r='roi_bg_in_narrow';
aa=size(roi,1);
sp=12;
for c=[1 5]
    kk=-sp+1;
    eval(['load cond',int2str(c),'n_dt_bl'])
    eval(['t=cond',int2str(c),'n_dt_bl;'])
    eval(['clear cond',int2str(c),'n_dt_bl'])
    superpix=zeros(floor(aa/sp)-1,size(t,2),size(t,3));
    for i=1:floor(aa/sp)-1
        kk=kk+12;
        superpix(i,:,:)=mean(t(roi(kk:kk+11),:,:),1);
    end
  
    k=size(time,2)-win;
    for h=1:size(t,3)
        v=nan*ones(size(superpix,1),size(superpix,1),k*2-1,k);
        disp(h)
        for i=1:size(superpix,1)
            for j=1:size(superpix,1)
                for ii=1:k
                    for jj=1:k
                        temp=corrcoef(superpix(i,time(ii:ii+win),h),superpix(j,time(jj:jj+win),h));
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
    crv=crv/size(superpix,3);
    crv=reshape(crv,[size(superpix,1)*size(superpix,1),2*k-1]);
    eval(['crv_cond',int2str(c),'=crv;'])
    clear crv
    eval(['save crv_',r,'_cond',int2str(c),'_superpix_w4 crv_cond',int2str(c),' time roi'])
    eval(['clear crv_cond',int2str(c)])
end 

cd F:\Data\VSDI\Contour_integration\legolas\right_hemisphere\psychophysics\2008_12_03\e\correct_and_incorrect_together
load myrois

time=28:43;
win=4;
roi=roi_circle_diff;
r='circle_diff';
aa=size(roi,1);
sp=12;
for c=[1 5]
    kk=-sp+1;
    eval(['load cond',int2str(c),'n_dt_bl'])
    eval(['t=cond',int2str(c),'n_dt_bl;'])
    eval(['clear cond',int2str(c),'n_dt_bl'])
    superpix=zeros(floor(aa/sp)-1,size(t,2),size(t,3));
    for i=1:floor(aa/sp)-1
        kk=kk+12;
        superpix(i,:,:)=mean(t(roi(kk:kk+11),:,:),1);
    end
  
    k=size(time,2)-win;
    for h=1:size(t,3)
        v=nan*ones(size(superpix,1),size(superpix,1),k*2-1,k);
        disp(h)
        for i=1:size(superpix,1)
            for j=1:size(superpix,1)
                for ii=1:k
                    for jj=1:k
                        temp=corrcoef(superpix(i,time(ii:ii+win),h),superpix(j,time(jj:jj+win),h));
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
    crv=crv/size(superpix,3);
    crv=reshape(crv,[size(superpix,1)*size(superpix,1),2*k-1]);
    eval(['crv_cond',int2str(c),'=crv;'])
    clear crv
    eval(['save crv_',r,'_cond',int2str(c),'_superpix_w4 crv_cond',int2str(c),' time roi'])
    eval(['clear crv_cond',int2str(c)])
end 

roi=roi_bg_in_narrow;
r='roi_bg_in_narrow';
aa=size(roi,1);
sp=12;
for c=[1 5]
    kk=-sp+1;
    eval(['load cond',int2str(c),'n_dt_bl'])
    eval(['t=cond',int2str(c),'n_dt_bl;'])
    eval(['clear cond',int2str(c),'n_dt_bl'])
    superpix=zeros(floor(aa/sp)-1,size(t,2),size(t,3));
    for i=1:floor(aa/sp)-1
        kk=kk+12;
        superpix(i,:,:)=mean(t(roi(kk:kk+11),:,:),1);
    end
  
    k=size(time,2)-win;
    for h=1:size(t,3)
        v=nan*ones(size(superpix,1),size(superpix,1),k*2-1,k);
        disp(h)
        for i=1:size(superpix,1)
            for j=1:size(superpix,1)
                for ii=1:k
                    for jj=1:k
                        temp=corrcoef(superpix(i,time(ii:ii+win),h),superpix(j,time(jj:jj+win),h));
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
    crv=crv/size(superpix,3);
    crv=reshape(crv,[size(superpix,1)*size(superpix,1),2*k-1]);
    eval(['crv_cond',int2str(c),'=crv;'])
    clear crv
    eval(['save crv_',r,'_cond',int2str(c),'_superpix_w4 crv_cond',int2str(c),' time roi'])
    eval(['clear crv_cond',int2str(c)])
end 

cd F:\Data\VSDI\Contour_integration\legolas\right_hemisphere\psychophysics\2008_12_03\f\correct_and_incorrect_together
load myrois

time=28:43;
win=4;
roi=roi_circle_diff;
r='circle_diff';
aa=size(roi,1);
sp=12;
for c=[1 5]
    kk=-sp+1;
    eval(['load cond',int2str(c),'n_dt_bl'])
    eval(['t=cond',int2str(c),'n_dt_bl;'])
    eval(['clear cond',int2str(c),'n_dt_bl'])
    superpix=zeros(floor(aa/sp)-1,size(t,2),size(t,3));
    for i=1:floor(aa/sp)-1
        kk=kk+12;
        superpix(i,:,:)=mean(t(roi(kk:kk+11),:,:),1);
    end
  
    k=size(time,2)-win;
    for h=1:size(t,3)
        v=nan*ones(size(superpix,1),size(superpix,1),k*2-1,k);
        disp(h)
        for i=1:size(superpix,1)
            for j=1:size(superpix,1)
                for ii=1:k
                    for jj=1:k
                        temp=corrcoef(superpix(i,time(ii:ii+win),h),superpix(j,time(jj:jj+win),h));
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
    crv=crv/size(superpix,3);
    crv=reshape(crv,[size(superpix,1)*size(superpix,1),2*k-1]);
    eval(['crv_cond',int2str(c),'=crv;'])
    clear crv
    eval(['save crv_',r,'_cond',int2str(c),'_superpix_w4 crv_cond',int2str(c),' time roi'])
    eval(['clear crv_cond',int2str(c)])
end 

roi=roi_bg_in_narrow;
r='roi_bg_in_narrow';
aa=size(roi,1);
sp=12;
for c=[1 5]
    kk=-sp+1;
    eval(['load cond',int2str(c),'n_dt_bl'])
    eval(['t=cond',int2str(c),'n_dt_bl;'])
    eval(['clear cond',int2str(c),'n_dt_bl'])
    superpix=zeros(floor(aa/sp)-1,size(t,2),size(t,3));
    for i=1:floor(aa/sp)-1
        kk=kk+12;
        superpix(i,:,:)=mean(t(roi(kk:kk+11),:,:),1);
    end
  
    k=size(time,2)-win;
    for h=1:size(t,3)
        v=nan*ones(size(superpix,1),size(superpix,1),k*2-1,k);
        disp(h)
        for i=1:size(superpix,1)
            for j=1:size(superpix,1)
                for ii=1:k
                    for jj=1:k
                        temp=corrcoef(superpix(i,time(ii:ii+win),h),superpix(j,time(jj:jj+win),h));
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
    crv=crv/size(superpix,3);
    crv=reshape(crv,[size(superpix,1)*size(superpix,1),2*k-1]);
    eval(['crv_cond',int2str(c),'=crv;'])
    clear crv
    eval(['save crv_',r,'_cond',int2str(c),'_superpix_w4 crv_cond',int2str(c),' time roi'])
    eval(['clear crv_cond',int2str(c)])
end 

cd F:\Data\VSDI\Contour_integration\legolas\right_hemisphere\06_10_2008\e
load myrois

time=28:43;
win=4;
roi=roi_circle_diff;
r='circle_diff';
aa=size(roi,1);
sp=12;
for c=[1 2 4 5]
    kk=-sp+1;
    eval(['load cond',int2str(c),'n_dt_bl'])
    eval(['t=cond',int2str(c),'n_dt_bl;'])
    eval(['clear cond',int2str(c),'n_dt_bl'])
    superpix=zeros(floor(aa/sp)-1,size(t,2),size(t,3));
    for i=1:floor(aa/sp)-1
        kk=kk+12;
        superpix(i,:,:)=mean(t(roi(kk:kk+11),:,:),1);
    end
  
    k=size(time,2)-win;
    for h=1:size(t,3)
        v=nan*ones(size(superpix,1),size(superpix,1),k*2-1,k);
        disp(h)
        for i=1:size(superpix,1)
            for j=1:size(superpix,1)
                for ii=1:k
                    for jj=1:k
                        temp=corrcoef(superpix(i,time(ii:ii+win),h),superpix(j,time(jj:jj+win),h));
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
    crv=crv/size(superpix,3);
    crv=reshape(crv,[size(superpix,1)*size(superpix,1),2*k-1]);
    eval(['crv_cond',int2str(c),'=crv;'])
    clear crv
    eval(['save crv_',r,'_cond',int2str(c),'_superpix_w4 crv_cond',int2str(c),' time roi'])
    eval(['clear crv_cond',int2str(c)])
end 

roi=roi_bg_in_narrow;
r='roi_bg_in_narrow';
aa=size(roi,1);
sp=12;
for c=[1 2 4 5]
    kk=-sp+1;
    eval(['load cond',int2str(c),'n_dt_bl'])
    eval(['t=cond',int2str(c),'n_dt_bl;'])
    eval(['clear cond',int2str(c),'n_dt_bl'])
    superpix=zeros(floor(aa/sp)-1,size(t,2),size(t,3));
    for i=1:floor(aa/sp)-1
        kk=kk+12;
        superpix(i,:,:)=mean(t(roi(kk:kk+11),:,:),1);
    end
  
    k=size(time,2)-win;
    for h=1:size(t,3)
        v=nan*ones(size(superpix,1),size(superpix,1),k*2-1,k);
        disp(h)
        for i=1:size(superpix,1)
            for j=1:size(superpix,1)
                for ii=1:k
                    for jj=1:k
                        temp=corrcoef(superpix(i,time(ii:ii+win),h),superpix(j,time(jj:jj+win),h));
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
    crv=crv/size(superpix,3);
    crv=reshape(crv,[size(superpix,1)*size(superpix,1),2*k-1]);
    eval(['crv_cond',int2str(c),'=crv;'])
    clear crv
    eval(['save crv_',r,'_cond',int2str(c),'_superpix_w4 crv_cond',int2str(c),' time roi'])
    eval(['clear crv_cond',int2str(c)])
end 

cd F:\Data\VSDI\Contour_integration\legolas\right_hemisphere\06_10_2008\f
load myrois

time=28:43;
win=4;
roi=roi_circle_diff;
r='circle_diff';
aa=size(roi,1);
sp=12;
for c=[1 2 4 5]
    kk=-sp+1;
    eval(['load cond',int2str(c),'n_dt_bl'])
    eval(['t=cond',int2str(c),'n_dt_bl;'])
    eval(['clear cond',int2str(c),'n_dt_bl'])
    superpix=zeros(floor(aa/sp)-1,size(t,2),size(t,3));
    for i=1:floor(aa/sp)-1
        kk=kk+12;
        superpix(i,:,:)=mean(t(roi(kk:kk+11),:,:),1);
    end
  
    k=size(time,2)-win;
    for h=1:size(t,3)
        v=nan*ones(size(superpix,1),size(superpix,1),k*2-1,k);
        disp(h)
        for i=1:size(superpix,1)
            for j=1:size(superpix,1)
                for ii=1:k
                    for jj=1:k
                        temp=corrcoef(superpix(i,time(ii:ii+win),h),superpix(j,time(jj:jj+win),h));
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
    crv=crv/size(superpix,3);
    crv=reshape(crv,[size(superpix,1)*size(superpix,1),2*k-1]);
    eval(['crv_cond',int2str(c),'=crv;'])
    clear crv
    eval(['save crv_',r,'_cond',int2str(c),'_superpix_w4 crv_cond',int2str(c),' time roi'])
    eval(['clear crv_cond',int2str(c)])
end 

roi=roi_bg_in_narrow;
r='roi_bg_in_narrow';
aa=size(roi,1);
sp=12;
for c=[1 2 4 5]
    kk=-sp+1;
    eval(['load cond',int2str(c),'n_dt_bl'])
    eval(['t=cond',int2str(c),'n_dt_bl;'])
    eval(['clear cond',int2str(c),'n_dt_bl'])
    superpix=zeros(floor(aa/sp)-1,size(t,2),size(t,3));
    for i=1:floor(aa/sp)-1
        kk=kk+12;
        superpix(i,:,:)=mean(t(roi(kk:kk+11),:,:),1);
    end
  
    k=size(time,2)-win;
    for h=1:size(t,3)
        v=nan*ones(size(superpix,1),size(superpix,1),k*2-1,k);
        disp(h)
        for i=1:size(superpix,1)
            for j=1:size(superpix,1)
                for ii=1:k
                    for jj=1:k
                        temp=corrcoef(superpix(i,time(ii:ii+win),h),superpix(j,time(jj:jj+win),h));
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
    crv=crv/size(superpix,3);
    crv=reshape(crv,[size(superpix,1)*size(superpix,1),2*k-1]);
    eval(['crv_cond',int2str(c),'=crv;'])
    clear crv
    eval(['save crv_',r,'_cond',int2str(c),'_superpix_w4 crv_cond',int2str(c),' time roi'])
    eval(['clear crv_cond',int2str(c)])
end 

cd F:\Data\VSDI\Contour_integration\legolas\right_hemisphere\22_10_2008\d
load myrois

time=28:43;
win=4;
roi=roi_circle_diff;
r='circle_diff';
aa=size(roi,1);
sp=12;
for c=[1 2 4 5]
    kk=-sp+1;
    eval(['load cond',int2str(c),'n_dt_bl'])
    eval(['t=cond',int2str(c),'n_dt_bl;'])
    eval(['clear cond',int2str(c),'n_dt_bl'])
    superpix=zeros(floor(aa/sp)-1,size(t,2),size(t,3));
    for i=1:floor(aa/sp)-1
        kk=kk+12;
        superpix(i,:,:)=mean(t(roi(kk:kk+11),:,:),1);
    end
  
    k=size(time,2)-win;
    for h=1:size(t,3)
        v=nan*ones(size(superpix,1),size(superpix,1),k*2-1,k);
        disp(h)
        for i=1:size(superpix,1)
            for j=1:size(superpix,1)
                for ii=1:k
                    for jj=1:k
                        temp=corrcoef(superpix(i,time(ii:ii+win),h),superpix(j,time(jj:jj+win),h));
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
    crv=crv/size(superpix,3);
    crv=reshape(crv,[size(superpix,1)*size(superpix,1),2*k-1]);
    eval(['crv_cond',int2str(c),'=crv;'])
    clear crv
    eval(['save crv_',r,'_cond',int2str(c),'_superpix_w4 crv_cond',int2str(c),' time roi'])
    eval(['clear crv_cond',int2str(c)])
end 

roi=roi_bg_in_narrow;
r='roi_bg_in_narrow';
aa=size(roi,1);
sp=12;
for c=[1 2 4 5]
    kk=-sp+1;
    eval(['load cond',int2str(c),'n_dt_bl'])
    eval(['t=cond',int2str(c),'n_dt_bl;'])
    eval(['clear cond',int2str(c),'n_dt_bl'])
    superpix=zeros(floor(aa/sp)-1,size(t,2),size(t,3));
    for i=1:floor(aa/sp)-1
        kk=kk+12;
        superpix(i,:,:)=mean(t(roi(kk:kk+11),:,:),1);
    end
  
    k=size(time,2)-win;
    for h=1:size(t,3)
        v=nan*ones(size(superpix,1),size(superpix,1),k*2-1,k);
        disp(h)
        for i=1:size(superpix,1)
            for j=1:size(superpix,1)
                for ii=1:k
                    for jj=1:k
                        temp=corrcoef(superpix(i,time(ii:ii+win),h),superpix(j,time(jj:jj+win),h));
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
    crv=crv/size(superpix,3);
    crv=reshape(crv,[size(superpix,1)*size(superpix,1),2*k-1]);
    eval(['crv_cond',int2str(c),'=crv;'])
    clear crv
    eval(['save crv_',r,'_cond',int2str(c),'_superpix_w4 crv_cond',int2str(c),' time roi'])
    eval(['clear crv_cond',int2str(c)])
end 

cd F:\Data\VSDI\Contour_integration\legolas\right_hemisphere\22_10_2008\e
load myrois

time=28:43;
win=4;
roi=roi_circle_diff;
r='circle_diff';
aa=size(roi,1);
sp=12;
for c=[1 2 4 5]
    kk=-sp+1;
    eval(['load cond',int2str(c),'n_dt_bl'])
    eval(['t=cond',int2str(c),'n_dt_bl;'])
    eval(['clear cond',int2str(c),'n_dt_bl'])
    superpix=zeros(floor(aa/sp)-1,size(t,2),size(t,3));
    for i=1:floor(aa/sp)-1
        kk=kk+12;
        superpix(i,:,:)=mean(t(roi(kk:kk+11),:,:),1);
    end
  
    k=size(time,2)-win;
    for h=1:size(t,3)
        v=nan*ones(size(superpix,1),size(superpix,1),k*2-1,k);
        disp(h)
        for i=1:size(superpix,1)
            for j=1:size(superpix,1)
                for ii=1:k
                    for jj=1:k
                        temp=corrcoef(superpix(i,time(ii:ii+win),h),superpix(j,time(jj:jj+win),h));
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
    crv=crv/size(superpix,3);
    crv=reshape(crv,[size(superpix,1)*size(superpix,1),2*k-1]);
    eval(['crv_cond',int2str(c),'=crv;'])
    clear crv
    eval(['save crv_',r,'_cond',int2str(c),'_superpix_w4 crv_cond',int2str(c),' time roi'])
    eval(['clear crv_cond',int2str(c)])
end 

roi=roi_bg_in_narrow;
r='roi_bg_in_narrow';
aa=size(roi,1);
sp=12;
for c=[1 2 4 5]
    kk=-sp+1;
    eval(['load cond',int2str(c),'n_dt_bl'])
    eval(['t=cond',int2str(c),'n_dt_bl;'])
    eval(['clear cond',int2str(c),'n_dt_bl'])
    superpix=zeros(floor(aa/sp)-1,size(t,2),size(t,3));
    for i=1:floor(aa/sp)-1
        kk=kk+12;
        superpix(i,:,:)=mean(t(roi(kk:kk+11),:,:),1);
    end
  
    k=size(time,2)-win;
    for h=1:size(t,3)
        v=nan*ones(size(superpix,1),size(superpix,1),k*2-1,k);
        disp(h)
        for i=1:size(superpix,1)
            for j=1:size(superpix,1)
                for ii=1:k
                    for jj=1:k
                        temp=corrcoef(superpix(i,time(ii:ii+win),h),superpix(j,time(jj:jj+win),h));
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
    crv=crv/size(superpix,3);
    crv=reshape(crv,[size(superpix,1)*size(superpix,1),2*k-1]);
    eval(['crv_cond',int2str(c),'=crv;'])
    clear crv
    eval(['save crv_',r,'_cond',int2str(c),'_superpix_w4 crv_cond',int2str(c),' time roi'])
    eval(['clear crv_cond',int2str(c)])
end 

