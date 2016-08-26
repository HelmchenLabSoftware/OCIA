
cd F:\Data\VSDI\Contour_integration\Smeagol\17Nov2010\g
load myrois

time=28:43;
win=4;

roi=roi_bg_in;
r='roi_bg_in';
aa=size(roi,1);
sp=12;
for c=[5]
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

cd F:\Data\VSDI\Contour_integration\Smeagol\24Nov2010\b
load myrois

time=28:43;
win=4;
roi=roi_circle;
r='circle';
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


cd F:\Data\VSDI\Contour_integration\Smeagol\24Nov2010\d
load myrois

time=28:43;
win=4;
roi=roi_circle;
r='circle';
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


cd F:\Data\VSDI\Contour_integration\Smeagol\24Nov2010\f
load myrois

time=28:43;
win=4;
roi=roi_circle;
r='circle';
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


cd F:\Data\VSDI\Contour_integration\Smeagol\14Dec2010\b
load myrois

time=28:43;
win=4;
roi=roi_circle;
r='circle';
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


cd F:\Data\VSDI\Contour_integration\Smeagol\22Dec2010\b
load myrois

time=28:43;
win=4;
roi=roi_circle;
r='circle';
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

cd F:\Data\VSDI\Contour_integration\Smeagol\29Dec2010\b
load myrois

time=28:43;
win=4;
roi=roi_circle;
r='circle';
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

cd F:\Data\VSDI\Contour_integration\Smeagol\29Dec2010\d
load myrois

time=28:43;
win=4;
roi=roi_circle;
r='circle';
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


cd F:\Data\VSDI\Contour_integration\Smeagol\14Dec2010\c
load myrois

time=28:43;
win=4;
roi=roi_circle;
r='circle';
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

cd F:\Data\VSDI\Contour_integration\Smeagol\14Dec2010\d
load myrois

time=28:43;
win=4;
roi=roi_circle;
r='circle';
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

cd F:\Data\VSDI\Contour_integration\Smeagol\14Dec2010\e
load myrois

time=28:43;
win=4;
roi=roi_circle;
r='circle';
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

cd F:\Data\VSDI\Contour_integration\Smeagol\22Dec2010\c
load myrois

time=28:43;
win=4;
roi=roi_circle;
r='circle';
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

cd F:\Data\VSDI\Contour_integration\Smeagol\22Dec2010\d
load myrois

time=28:43;
win=4;
roi=roi_circle;
r='circle';
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



