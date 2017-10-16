cd /fat2/Ariel_Gilad/Matlab_analysis/experiments/mask/legolas/right_hemisphere/11_11_2008/c

load pixels_to_remove
t=ones(10000,1);
t(pixels_to_remove)=0;
pixels=find(t);
clear t




load 1111

NFFT = 64;
win=16;
for i=[1 4 3 2 5]%condition count
    z=0;
    eval(['load cond',int2str(i),'n_dt_bl'])
    eval(['a=size(cond',int2str(i),'n_dt_bl,3);'])    
    eval(['b=size(cond',int2str(i),'n_dt_bl,2)/2;'])
    for p=1:size(roi_tar,1)
        for h=1:a  %trial count
            tic
            z=z+1;
            disp(['pixel #',int2str(p),' condition #',int2str(i),' trial #',int2str(h),' transforming data'])
            eval(['load cond',int2str(i),'n_dt_bl'])
            eval(['cond',int2str(i),'n_dt_bl=cond',int2str(i),'n_dt_bl(:,2:end,h);'])
            eval(['covar_tar_cond',int2str(i),'_t=NaN*ones(size(pixels,1),b-win);'])
            data_win=zeros(size(pixels,1),32);
                for j=1:(b-win)
                   eval(['covar_tar_cond',int2str(i),'_t(:,j)=sum((repmat(cond',int2str(i),'n_dt_bl(roi_tar(p),j:j+win-1),[size(pixels,1) 1])-repmat(mean(cond',int2str(i),'n_dt_bl(roi_tar(p),j:j+win-1),2),[size(pixels,1) win])).*(cond',int2str(i),'n_dt_bl(pixels,j:j+win-1)-repmat(mean(cond',int2str(i),'n_dt_bl(pixels,j:j+win-1),2),[1 win])),2)/(win-1);'])
                    
                end;
            eval(['clear cond',int2str(i),'n_dt_bl'])
            if z==1
                eval(['covar_tar_cond',int2str(i),'=covar_tar_cond',int2str(i),'_t;'])    
            else
                eval(['covar_tar_cond',int2str(i),'=covar_tar_cond',int2str(i),'+covar_tar_cond',int2str(i),'_t;'])
            end
            eval(['clear covar_tar_cond',int2str(i),'_t'])
            toc
        end;
    end;
    eval(['covar_tar_cond',int2str(i),'=covar_tar_cond',int2str(i),'/z;'])
    eval(['save covar_tar_cond',int2str(i),' covar_tar_cond',int2str(i),' roi_tar pixels'])
    eval(['clear covar_tar_cond',int2str(i)])
end


