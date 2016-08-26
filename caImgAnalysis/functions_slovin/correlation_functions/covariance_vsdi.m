

cd /fat2/Ariel_Gilad/Matlab_analysis/experiments/mask/legolas/right_hemisphere/11_11_2008/c

load pixels_to_remove
t=ones(10000,1);
t(pixels_to_remove)=0;
pixels=find(t);
clear t

load 1111

for i=[1 4 3 2 5]%condition count
    z=0;
    eval(['load cond',int2str(i),'n_dt_bl'])
    eval(['a=size(cond',int2str(i),'n_dt_bl,3);'])    
    eval(['b=size(cond',int2str(i),'n_dt_bl,2)/2;'])
    for p=1:size(roi_tar,1)
        z=z+1;
        eval(['covar_tar_cond',int2str(i),'_t=NaN*ones(size(pixels,1),b);'])
        for h=1:b  %time frame count 
            disp(['covariance of pixel #',int2str(p),' condition #',int2str(i),' time frame #',int2str(h),' calculating'])
            l=0;
            for pp=1:size(pixels,1)
                l=l+1;
                eval(['cc=cov(squeeze(cond',int2str(i),'n_dt_bl(roi_tar(p),h,:)),squeeze(cond',int2str(i),'n_dt_bl(pixels(l),h,:)));'])
                eval(['covar_tar_cond',int2str(i),'_t(l,h)=cc(1,2);'])
            end
        end;
            if z==1
                eval(['covar_tar_cond',int2str(i),'=covar_tar_cond',int2str(i),'_t;'])    
            else
                eval(['covar_tar_cond',int2str(i),'=covar_tar_cond',int2str(i),'+covar_tar_cond',int2str(i),'_t;'])
            end
            eval(['clear covar_tar_cond',int2str(i),'_t'])
        
    end;
    eval(['covar_tar_cond',int2str(i),'=covar_tar_cond',int2str(i),'/z;'])
    eval(['save covar_tar_cond',int2str(i),' covar_tar_cond',int2str(i),' roi_tar pixels'])
    eval(['clear covar_tar_cond',int2str(i)])
end


