


cd /media/D410DCC610DCB12A/Ariel_Gilad/Matlab_analysis/experiments/mask/legolas/right_hemisphere/psychophysics/2008_11_25/d/correct_and_incorrect_together

load pixels_to_remove
t=ones(10000,1);
t(pixels_to_remove)=0;
pixels=find(t);
clear t

time=200;
load rois2_b


win=8;

for i=[1 5] %condition count
    eval(['load cond',int2str(i),'n_dt_bl'])
    eval(['a=size(cond',int2str(i),'n_dt_bl,3);'])    
    b=time;
    for h=1:a  %trial count
        z=0;
        roi_bg_out=em2rois(1,i).bgout{h,1};
        if isnan(roi_bg_out)
            roi_bg_out=[];
        end
        for p=1:size(roi_bg_out,1)
            z=z+1;
            eval(['coeff_bg_out_cond',int2str(i),'_pix_',int2str(roi_bg_out(p)),'=NaN*ones(size(pixels,1),b-win);'])
            disp(['pixel #',int2str(p),' condition #',int2str(i),' trial #',int2str(h),' transforming data'])
            %eval(['load cond',int2str(i),'n_dt_bl'])
            eval(['cond',int2str(i),'n_dt_tr=cond',int2str(i),'n_dt_bl(:,2:end,h);'])
            
                for j=1:(b-win)
                   eval(['cc=sum((repmat(cond',int2str(i),'n_dt_tr(roi_bg_out(p),j:j+win-1),[size(pixels,1) 1])-repmat(mean(cond',int2str(i),'n_dt_tr(roi_bg_out(p),j:j+win-1),2),[size(pixels,1) win])).*(cond',int2str(i),'n_dt_tr(pixels,j:j+win-1)-repmat(mean(cond',int2str(i),'n_dt_tr(pixels,j:j+win-1),2),[1 win])),2)/(win-1);'])
                   eval(['var1=repmat(std(cond',int2str(i),'n_dt_tr(roi_bg_out(p),j:j+win-1),0,2).^2,[size(pixels,1) 1]);'])
                   eval(['var2=std(cond',int2str(i),'n_dt_tr(pixels,j:j+win-1),0,2).^2;'])
                   eval(['coeff_bg_out_cond',int2str(i),'_pix_',int2str(roi_bg_out(p)),'(:,j)=cc./sqrt(var1.*var2);']) 
                end;
            if z==1
                eval(['coeff_bg_out_cond',int2str(i),'(:,:,h)=coeff_bg_out_cond',int2str(i),'_pix_',int2str(roi_bg_out(p)),';'])    
            else
                eval(['coeff_bg_out_cond',int2str(i),'(:,:,h)=coeff_bg_out_cond',int2str(i),'(:,:,h)+coeff_bg_out_cond',int2str(i),'_pix_',int2str(roi_bg_out(p)),';'])
            end 
            eval(['clear coeff_bg_out_cond',int2str(i),'_pix_',int2str(roi_bg_out(p))])
        end;
    if ~(size(roi_bg_out,1)==0)
        eval(['coeff_bg_out_cond',int2str(i),'(:,:,h)=coeff_bg_out_cond',int2str(i),'(:,:,h)/size(roi_bg_out,1);'])    
    else
        eval(['coeff_bg_out_cond',int2str(i),'(:,:,h)=nan*ones(size(pixels,1),b-win);'])
    end
    end;
    cd pixels_eye
    eval(['save coeff_bg_out_cond',int2str(i),' coeff_bg_out_cond',int2str(i),' roi_bg_out pixels'])
    cd ..
    eval(['clear coeff_bg_out_cond',int2str(i)])
    eval(['clear cond',int2str(i),'n_dt_bl'])            
end






