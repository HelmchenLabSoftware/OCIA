
cd F:\Data\VSDI\Contour_integration\legolas\right_hemisphere\22_10_2008\d\no_stim
load myrois

roi=roi_bg_in;
r='bg_in';

time=34:42;
for c=[4 5]
    eval(['load cond',int2str(c),'n_dt_bl'])
    eval(['t=cond',int2str(c),'n_dt_bl;'])
    eval(['clear cond',int2str(c),'n_dt_bl'])
    load myrois
    v=zeros(size(roi,1),size(roi,1),2*size(time,2)-1);
    for h=1:size(t,3)
        disp(h)
        for i=1:size(roi,1)
            for j=1:size(roi,1)
                v(i,j,:)=xcov(t(roi(i),time,h),t(roi(j),time,h),'coeff'); 
            end
        end
        if h==1
            crv=v;
        else
            crv=crv+v;
        end
        clear v
    end
    crv=crv/size(t,3);
    crv=reshape(crv,[size(roi,1)*size(roi,1),2*size(time,2)-1]);
    eval(['crv_cond',int2str(c),'=crv;'])
    clear crv
    eval(['save crv_',r,'_cond',int2str(c),'_34_42 crv_cond',int2str(c),' time roi'])
    eval(['clear crv_cond',int2str(c)])
end

roi=roi_contour;
r='contour';

time=31:39;
for c=[1 2 4 5]
    eval(['load cond',int2str(c),'n_dt_bl'])
    eval(['t=cond',int2str(c),'n_dt_bl;'])
    eval(['clear cond',int2str(c),'n_dt_bl'])
    load myrois
    v=zeros(size(roi,1),size(roi,1),2*size(time,2)-1);
    for h=1:size(t,3)
        disp(h)
        for i=1:size(roi,1)
            for j=1:size(roi,1)
                v(i,j,:)=xcov(t(roi(i),time,h),t(roi(j),time,h),'coeff'); 
            end
        end
        if h==1
            crv=v;
        else
            crv=crv+v;
        end
        clear v
    end
    crv=crv/size(t,3);
    crv=reshape(crv,[size(roi,1)*size(roi,1),2*size(time,2)-1]);
    eval(['crv_cond',int2str(c),'=crv;'])
    clear crv
    eval(['save crv_',r,'_cond',int2str(c),'_31_39 crv_cond',int2str(c),' time roi'])
    eval(['clear crv_cond',int2str(c)])
end


cd F:\Data\VSDI\Contour_integration\legolas\right_hemisphere\22_10_2008\e\no_stim
load myrois

roi=roi_bg_in;
r='bg_in';

time=34:42;
for c=[2 4 5]
    eval(['load cond',int2str(c),'n_dt_bl'])
    eval(['t=cond',int2str(c),'n_dt_bl;'])
    eval(['clear cond',int2str(c),'n_dt_bl'])
    load myrois
    v=zeros(size(roi,1),size(roi,1),2*size(time,2)-1);
    for h=1:size(t,3)
        disp(h)
        for i=1:size(roi,1)
            for j=1:size(roi,1)
                v(i,j,:)=xcov(t(roi(i),time,h),t(roi(j),time,h),'coeff'); 
            end
        end
        if h==1
            crv=v;
        else
            crv=crv+v;
        end
        clear v
    end
    crv=crv/size(t,3);
    crv=reshape(crv,[size(roi,1)*size(roi,1),2*size(time,2)-1]);
    eval(['crv_cond',int2str(c),'=crv;'])
    clear crv
    eval(['save crv_',r,'_cond',int2str(c),'_34_42 crv_cond',int2str(c),' time roi'])
    eval(['clear crv_cond',int2str(c)])
end


cd F:\Data\VSDI\Contour_integration\legolas\right_hemisphere\11_11_2008\c\elhanan_new
load myrois

roi=roi_maskin;
r='maskin';

time=34:42;
for c=[3]
    eval(['load cond',int2str(c),'n_dt_bl'])
    eval(['t=cond',int2str(c),'n_dt_bl;'])
    eval(['clear cond',int2str(c),'n_dt_bl'])
    load myrois
    v=zeros(size(roi,1),size(roi,1),2*size(time,2)-1);
    for h=1:size(t,3)
        disp(h)
        for i=1:size(roi,1)
            for j=1:size(roi,1)
                v(i,j,:)=xcov(t(roi(i),time,h),t(roi(j),time,h),'coeff'); 
            end
        end
        if h==1
            crv=v;
        else
            crv=crv+v;
        end
        clear v
    end
    crv=crv/size(t,3);
    crv=reshape(crv,[size(roi,1)*size(roi,1),2*size(time,2)-1]);
    eval(['crv_cond',int2str(c),'=crv;'])
    clear crv
    eval(['save crv_',r,'_cond',int2str(c),'_34_42 crv_cond',int2str(c),' time roi'])
    eval(['clear crv_cond',int2str(c)])
end

roi=roi_contour2;
r='contour2';

time=31:39;
for c=[3]
    eval(['load cond',int2str(c),'n_dt_bl'])
    eval(['t=cond',int2str(c),'n_dt_bl;'])
    eval(['clear cond',int2str(c),'n_dt_bl'])
    load myrois
    v=zeros(size(roi,1),size(roi,1),2*size(time,2)-1);
    for h=1:size(t,3)
        disp(h)
        for i=1:size(roi,1)
            for j=1:size(roi,1)
                v(i,j,:)=xcov(t(roi(i),time,h),t(roi(j),time,h),'coeff'); 
            end
        end
        if h==1
            crv=v;
        else
            crv=crv+v;
        end
        clear v
    end
    crv=crv/size(t,3);
    crv=reshape(crv,[size(roi,1)*size(roi,1),2*size(time,2)-1]);
    eval(['crv_cond',int2str(c),'=crv;'])
    clear crv
    eval(['save crv_',r,'_cond',int2str(c),'_31_39 crv_cond',int2str(c),' time roi'])
    eval(['clear crv_cond',int2str(c)])
end

cd F:\Data\VSDI\Contour_integration\legolas\right_hemisphere\11_11_2008\d\elhanan_new
load myrois

roi=roi_maskin;
r='maskin';

time=34:42;
for c=[3]
    eval(['load cond',int2str(c),'n_dt_bl'])
    eval(['t=cond',int2str(c),'n_dt_bl;'])
    eval(['clear cond',int2str(c),'n_dt_bl'])
    load myrois
    v=zeros(size(roi,1),size(roi,1),2*size(time,2)-1);
    for h=1:size(t,3)
        disp(h)
        for i=1:size(roi,1)
            for j=1:size(roi,1)
                v(i,j,:)=xcov(t(roi(i),time,h),t(roi(j),time,h),'coeff'); 
            end
        end
        if h==1
            crv=v;
        else
            crv=crv+v;
        end
        clear v
    end
    crv=crv/size(t,3);
    crv=reshape(crv,[size(roi,1)*size(roi,1),2*size(time,2)-1]);
    eval(['crv_cond',int2str(c),'=crv;'])
    clear crv
    eval(['save crv_',r,'_cond',int2str(c),'_34_42 crv_cond',int2str(c),' time roi'])
    eval(['clear crv_cond',int2str(c)])
end

roi=roi_contour2;
r='contour2';

time=31:39;
for c=[3]
    eval(['load cond',int2str(c),'n_dt_bl'])
    eval(['t=cond',int2str(c),'n_dt_bl;'])
    eval(['clear cond',int2str(c),'n_dt_bl'])
    load myrois
    v=zeros(size(roi,1),size(roi,1),2*size(time,2)-1);
    for h=1:size(t,3)
        disp(h)
        for i=1:size(roi,1)
            for j=1:size(roi,1)
                v(i,j,:)=xcov(t(roi(i),time,h),t(roi(j),time,h),'coeff'); 
            end
        end
        if h==1
            crv=v;
        else
            crv=crv+v;
        end
        clear v
    end
    crv=crv/size(t,3);
    crv=reshape(crv,[size(roi,1)*size(roi,1),2*size(time,2)-1]);
    eval(['crv_cond',int2str(c),'=crv;'])
    clear crv
    eval(['save crv_',r,'_cond',int2str(c),'_31_39 crv_cond',int2str(c),' time roi'])
    eval(['clear crv_cond',int2str(c)])
end



cd F:\Data\VSDI\Contour_integration\Smeagol\29Dec2010\c
load myrois

roi=roi_bg_out;
r='bg_out';

time=30:38;
for c=[3]
    eval(['load cond',int2str(c),'n_dt_bl'])
    eval(['t=cond',int2str(c),'n_dt_bl;'])
    eval(['clear cond',int2str(c),'n_dt_bl'])
    load myrois
    v=zeros(size(roi,1),size(roi,1),2*size(time,2)-1);
    for h=1:size(t,3)
        disp(h)
        for i=1:size(roi,1)
            for j=1:size(roi,1)
                v(i,j,:)=xcov(t(roi(i),time,h),t(roi(j),time,h),'coeff'); 
            end
        end
        if h==1
            crv=v;
        else
            crv=crv+v;
        end
        clear v
    end
    crv=crv/size(t,3);
    crv=reshape(crv,[size(roi,1)*size(roi,1),2*size(time,2)-1]);
    eval(['crv_cond',int2str(c),'=crv;'])
    clear crv
    eval(['save crv_',r,'_cond',int2str(c),'_34_42 crv_cond',int2str(c),' time roi'])
    eval(['clear crv_cond',int2str(c)])
end

roi=roi_circle;
r='circle';

time=27:35;
for c=[3]
    eval(['load cond',int2str(c),'n_dt_bl'])
    eval(['t=cond',int2str(c),'n_dt_bl;'])
    eval(['clear cond',int2str(c),'n_dt_bl'])
    load myrois
    v=zeros(size(roi,1),size(roi,1),2*size(time,2)-1);
    for h=1:size(t,3)
        disp(h)
        for i=1:size(roi,1)
            for j=1:size(roi,1)
                v(i,j,:)=xcov(t(roi(i),time,h),t(roi(j),time,h),'coeff'); 
            end
        end
        if h==1
            crv=v;
        else
            crv=crv+v;
        end
        clear v
    end
    crv=crv/size(t,3);
    crv=reshape(crv,[size(roi,1)*size(roi,1),2*size(time,2)-1]);
    eval(['crv_cond',int2str(c),'=crv;'])
    clear crv
    eval(['save crv_',r,'_cond',int2str(c),'_31_39 crv_cond',int2str(c),' time roi'])
    eval(['clear crv_cond',int2str(c)])
end



cd F:\Data\VSDI\Contour_integration\Smeagol\29Dec2010\e
load myrois

roi=roi_bg_out;
r='bg_out';

time=30:38;
for c=[3]
    eval(['load cond',int2str(c),'n_dt_bl'])
    eval(['t=cond',int2str(c),'n_dt_bl;'])
    eval(['clear cond',int2str(c),'n_dt_bl'])
    load myrois
    v=zeros(size(roi,1),size(roi,1),2*size(time,2)-1);
    for h=1:size(t,3)
        disp(h)
        for i=1:size(roi,1)
            for j=1:size(roi,1)
                v(i,j,:)=xcov(t(roi(i),time,h),t(roi(j),time,h),'coeff'); 
            end
        end
        if h==1
            crv=v;
        else
            crv=crv+v;
        end
        clear v
    end
    crv=crv/size(t,3);
    crv=reshape(crv,[size(roi,1)*size(roi,1),2*size(time,2)-1]);
    eval(['crv_cond',int2str(c),'=crv;'])
    clear crv
    eval(['save crv_',r,'_cond',int2str(c),'_34_42 crv_cond',int2str(c),' time roi'])
    eval(['clear crv_cond',int2str(c)])
end

roi=roi_circle;
r='circle';

time=27:35;
for c=[3]
    eval(['load cond',int2str(c),'n_dt_bl'])
    eval(['t=cond',int2str(c),'n_dt_bl;'])
    eval(['clear cond',int2str(c),'n_dt_bl'])
    load myrois
    v=zeros(size(roi,1),size(roi,1),2*size(time,2)-1);
    for h=1:size(t,3)
        disp(h)
        for i=1:size(roi,1)
            for j=1:size(roi,1)
                v(i,j,:)=xcov(t(roi(i),time,h),t(roi(j),time,h),'coeff'); 
            end
        end
        if h==1
            crv=v;
        else
            crv=crv+v;
        end
        clear v
    end
    crv=crv/size(t,3);
    crv=reshape(crv,[size(roi,1)*size(roi,1),2*size(time,2)-1]);
    eval(['crv_cond',int2str(c),'=crv;'])
    clear crv
    eval(['save crv_',r,'_cond',int2str(c),'_31_39 crv_cond',int2str(c),' time roi'])
    eval(['clear crv_cond',int2str(c)])
end





