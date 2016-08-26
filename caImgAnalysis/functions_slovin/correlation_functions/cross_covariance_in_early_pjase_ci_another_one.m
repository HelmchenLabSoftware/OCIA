



cd E:\Ariel_Gilad\Matlab_analysis\experiments\mask\Smeagol\14Dec2010\b

load myrois

roi=roi_bg_in;
r='bg_in';

time=28:43;
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
    eval(['save crv_',r,'_cond',int2str(c),' crv_cond',int2str(c),' time roi'])
    eval(['clear crv_cond',int2str(c)])
end


roi=roi_circle;
r='circle';

time=28:43;
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
    eval(['save crv_',r,'_cond',int2str(c),' crv_cond',int2str(c),' time roi'])
    eval(['clear crv_cond',int2str(c)])
end



cd E:\Ariel_Gilad\Matlab_analysis\experiments\mask\Smeagol\14Dec2010\c

load myrois

roi=roi_bg_in;
r='bg_in';

time=28:43;
for c=[1 5]
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
    eval(['save crv_',r,'_cond',int2str(c),' crv_cond',int2str(c),' time roi'])
    eval(['clear crv_cond',int2str(c)])
end


roi=roi_circle;
r='circle';

time=28:43;
for c=[1 5]
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
    eval(['save crv_',r,'_cond',int2str(c),' crv_cond',int2str(c),' time roi'])
    eval(['clear crv_cond',int2str(c)])
end


cd E:\Ariel_Gilad\Matlab_analysis\experiments\mask\Smeagol\14Dec2010\d

load myrois

roi=roi_bg_in;
r='bg_in';

time=28:43;
for c=[1 5]
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
    eval(['save crv_',r,'_cond',int2str(c),' crv_cond',int2str(c),' time roi'])
    eval(['clear crv_cond',int2str(c)])
end


roi=roi_circle;
r='circle';

time=28:43;
for c=[1 5]
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
    eval(['save crv_',r,'_cond',int2str(c),' crv_cond',int2str(c),' time roi'])
    eval(['clear crv_cond',int2str(c)])
end

cd E:\Ariel_Gilad\Matlab_analysis\experiments\mask\Smeagol\14Dec2010\e

load myrois

roi=roi_bg_in;
r='bg_in';

time=28:43;
for c=[1 5]
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
    eval(['save crv_',r,'_cond',int2str(c),' crv_cond',int2str(c),' time roi'])
    eval(['clear crv_cond',int2str(c)])
end


roi=roi_circle;
r='circle';

time=28:43;
for c=[1 5]
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
    eval(['save crv_',r,'_cond',int2str(c),' crv_cond',int2str(c),' time roi'])
    eval(['clear crv_cond',int2str(c)])
end


cd E:\Ariel_Gilad\Matlab_analysis\experiments\mask\Smeagol\22Dec2010\b

load myrois

roi=roi_bg_in;
r='bg_in';

time=28:43;
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
    eval(['save crv_',r,'_cond',int2str(c),' crv_cond',int2str(c),' time roi'])
    eval(['clear crv_cond',int2str(c)])
end


roi=roi_circle;
r='circle';

time=28:43;
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
    eval(['save crv_',r,'_cond',int2str(c),' crv_cond',int2str(c),' time roi'])
    eval(['clear crv_cond',int2str(c)])
end



cd E:\Ariel_Gilad\Matlab_analysis\experiments\mask\Smeagol\22Dec2010\c

load myrois

roi=roi_bg_in;
r='bg_in';

time=28:43;
for c=[1 5]
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
    eval(['save crv_',r,'_cond',int2str(c),' crv_cond',int2str(c),' time roi'])
    eval(['clear crv_cond',int2str(c)])
end


roi=roi_circle;
r='circle';

time=28:43;
for c=[1 5]
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
    eval(['save crv_',r,'_cond',int2str(c),' crv_cond',int2str(c),' time roi'])
    eval(['clear crv_cond',int2str(c)])
end


cd E:\Ariel_Gilad\Matlab_analysis\experiments\mask\Smeagol\22Dec2010\d

load myrois

roi=roi_bg_in;
r='bg_in';

time=28:43;
for c=[1 5]
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
    eval(['save crv_',r,'_cond',int2str(c),' crv_cond',int2str(c),' time roi'])
    eval(['clear crv_cond',int2str(c)])
end


roi=roi_circle;
r='circle';

time=28:43;
for c=[1 5]
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
    eval(['save crv_',r,'_cond',int2str(c),' crv_cond',int2str(c),' time roi'])
    eval(['clear crv_cond',int2str(c)])
end


