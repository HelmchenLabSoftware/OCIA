


cd /fat2/Ariel_Gilad/Matlab_analysis/experiments/mask/legolas/right_hemisphere/11_11_2008/c

load pixels_to_remove
t=ones(10000,1);
t(pixels_to_remove)=0;
pixels=find(t);
clear t




load 1111


win=8;
for i=[1 2 3 4 5]%condition count
    z=0;
    eval(['load cond',int2str(i),'n_dt_bl'])
    eval(['a=size(cond',int2str(i),'n_dt_bl,3);'])    
    eval(['b=size(cond',int2str(i),'n_dt_bl,2)/2;'])
    for p=1:size(roi_dip,1)
        eval(['coeff_dip_cond',int2str(i),'_pix_',int2str(roi_dip(p)),'=NaN*ones(size(pixels,1),b-win,a);'])
        for h=1:a  %trial count
            
            z=z+1;
            disp(['pixel #',int2str(p),' condition #',int2str(i),' trial #',int2str(h),' transforming data'])
            %eval(['load cond',int2str(i),'n_dt_bl'])
            eval(['cond',int2str(i),'n_dt_tr=cond',int2str(i),'n_dt_bl(:,2:end,h);'])
            
                for j=1:(b-win)
                   eval(['cc=sum((repmat(cond',int2str(i),'n_dt_tr(roi_dip(p),j:j+win-1),[size(pixels,1) 1])-repmat(mean(cond',int2str(i),'n_dt_tr(roi_dip(p),j:j+win-1),2),[size(pixels,1) win])).*(cond',int2str(i),'n_dt_tr(pixels,j:j+win-1)-repmat(mean(cond',int2str(i),'n_dt_tr(pixels,j:j+win-1),2),[1 win])),2)/(win-1);'])
                   eval(['dip=repmat(std(cond',int2str(i),'n_dt_tr(roi_dip(p),j:j+win-1),0,2).^2,[size(pixels,1) 1]);'])
                   eval(['v2=std(cond',int2str(i),'n_dt_tr(pixels,j:j+win-1),0,2).^2;'])
                   eval(['coeff_dip_cond',int2str(i),'_pix_',int2str(roi_dip(p)),'(:,j,h)=cc./sqrt(dip.*v2);']) 
                end;
            
        end;
        cd pixels
        eval(['save coeff_dip_cond',int2str(i),'_pix_',int2str(roi_dip(p)),' coeff_dip_cond',int2str(i),'_pix_',int2str(roi_dip(p)),' roi_dip pixels'])
        cd ..
        eval(['clear coeff_dip_cond',int2str(i),'_pix_',int2str(roi_dip(p))])
    end;
    eval(['clear cond',int2str(i),'n_dt_bl'])            
end
