
cd /fat2/Ariel_Gilad/Matlab_analysis/experiments/mask/legolas/right_hemisphere/psychophysics/2008_11_25/d

load pixels_to_remove
t=ones(10000,1);
t(pixels_to_remove)=0;
pixels=find(t);
clear t

win=8;
for i=[1]%condition count
    eval(['load rois_cond',int2str(i),'_trials'])
    eval(['load cond',int2str(i),'n_dt_bl'])
    eval(['a=size(cond',int2str(i),'n_dt_bl,3);'])    
    eval(['b=size(cond',int2str(i),'n_dt_bl,2)/2;'])
    z=zeros(a,1);
    for h=1:a  %trial count
        for p=1:size(roi_circle{2,h},1)
            z(h)=z(h)+1;
            eval(['coeff_circle_cond',int2str(i),'_pix_',int2str(roi_circle{2,h}(p)),'=NaN*ones(size(pixels,1),b-win,a);'])
            disp(['pixel #',int2str(p),' condition #',int2str(i),' trial #',int2str(h),' transforming data'])
            %eval(['load cond',int2str(i),'n_dt_bl'])
            eval(['cond',int2str(i),'n_dt_tr=cond',int2str(i),'n_dt_bl(:,2:end,h);'])
                for j=1:(b-win)
                   eval(['cc=sum((repmat(cond',int2str(i),'n_dt_tr(roi_circle{2,h}(p),j:j+win-1),[size(pixels,1) 1])-repmat(mean(cond',int2str(i),'n_dt_tr(roi_circle{2,h}(p),j:j+win-1),2),[size(pixels,1) win])).*(cond',int2str(i),'n_dt_tr(pixels,j:j+win-1)-repmat(mean(cond',int2str(i),'n_dt_tr(pixels,j:j+win-1),2),[1 win])),2)/(win-1);'])
                   eval(['var1=repmat(std(cond',int2str(i),'n_dt_tr(roi_circle{2,h}(p),j:j+win-1),0,2).^2,[size(pixels,1) 1]);'])
                   eval(['var2=std(cond',int2str(i),'n_dt_tr(pixels,j:j+win-1),0,2).^2;'])
                   eval(['coeff_circle_cond',int2str(i),'_pix_',int2str(roi_circle{2,h}(p)),'(:,j,h)=cc./sqrt(var1.*var2);']) 
                end;
        if z(h)==1
            eval(['coeff_circle_cond',int2str(i),'(:,:,h)=coeff_circle_cond',int2str(i),'_pix_',int2str(roi_circle{2,h}(p)),'(:,:,h);'])    
        else
            eval(['coeff_circle_cond',int2str(i),'(:,:,h)=coeff_circle_cond',int2str(i),'(:,:,h)+coeff_circle_cond',int2str(i),'_pix_',int2str(roi_circle{2,h}(p)),'(:,:,h);'])
        end

        eval(['clear coeff_circle_cond',int2str(i),'_pix_',int2str(roi_circle{2,h}(p))])
        end;
    end;
    eval(['coeff_circle_cond',int2str(i),'=coeff_circle_cond',int2str(i),'./shiftdim(repmat(z,[1,size(pixels,1),b-win]),1);'])
    cd trialwise_rois
    eval(['save coeff_circle_cond',int2str(i),' coeff_circle_cond',int2str(i),' roi_circle pixels'])
    cd ..
    eval(['clear coeff_circle_cond',int2str(i)])
    eval(['clear cond',int2str(i),'n_dt_bl'])            
end



cd /fat2/Ariel_Gilad/Matlab_analysis/experiments/mask/legolas/right_hemisphere/22_10_2008/d

load pixels_to_remove
t=ones(10000,1);
t(pixels_to_remove)=0;
pixels=find(t);
clear t

win=8;
for i=[1]%condition count
    eval(['load rois_cond',int2str(i),'_trials'])
    eval(['load cond',int2str(i),'n_dt_bl'])
    eval(['a=size(cond',int2str(i),'n_dt_bl,3);'])    
    eval(['b=size(cond',int2str(i),'n_dt_bl,2)/2;'])
    z=zeros(a,1);
    for h=1:a  %trial count
        for p=1:size(roi_circle{2,h},1)
            z(h)=z(h)+1;
            eval(['coeff_circle_cond',int2str(i),'_pix_',int2str(roi_circle{2,h}(p)),'=NaN*ones(size(pixels,1),b-win,a);'])
            disp(['pixel #',int2str(p),' condition #',int2str(i),' trial #',int2str(h),' transforming data'])
            %eval(['load cond',int2str(i),'n_dt_bl'])
            eval(['cond',int2str(i),'n_dt_tr=cond',int2str(i),'n_dt_bl(:,2:end,h);'])
                for j=1:(b-win)
                   eval(['cc=sum((repmat(cond',int2str(i),'n_dt_tr(roi_circle{2,h}(p),j:j+win-1),[size(pixels,1) 1])-repmat(mean(cond',int2str(i),'n_dt_tr(roi_circle{2,h}(p),j:j+win-1),2),[size(pixels,1) win])).*(cond',int2str(i),'n_dt_tr(pixels,j:j+win-1)-repmat(mean(cond',int2str(i),'n_dt_tr(pixels,j:j+win-1),2),[1 win])),2)/(win-1);'])
                   eval(['var1=repmat(std(cond',int2str(i),'n_dt_tr(roi_circle{2,h}(p),j:j+win-1),0,2).^2,[size(pixels,1) 1]);'])
                   eval(['var2=std(cond',int2str(i),'n_dt_tr(pixels,j:j+win-1),0,2).^2;'])
                   eval(['coeff_circle_cond',int2str(i),'_pix_',int2str(roi_circle{2,h}(p)),'(:,j,h)=cc./sqrt(var1.*var2);']) 
                end;
        if z(h)==1
            eval(['coeff_circle_cond',int2str(i),'(:,:,h)=coeff_circle_cond',int2str(i),'_pix_',int2str(roi_circle{2,h}(p)),'(:,:,h);'])    
        else
            eval(['coeff_circle_cond',int2str(i),'(:,:,h)=coeff_circle_cond',int2str(i),'(:,:,h)+coeff_circle_cond',int2str(i),'_pix_',int2str(roi_circle{2,h}(p)),'(:,:,h);'])
        end

        eval(['clear coeff_circle_cond',int2str(i),'_pix_',int2str(roi_circle{2,h}(p))])
        end;
    end;
    eval(['coeff_circle_cond',int2str(i),'=coeff_circle_cond',int2str(i),'./shiftdim(repmat(z,[1,size(pixels,1),b-win]),1);'])
    cd trialwise_rois
    eval(['save coeff_circle_cond',int2str(i),' coeff_circle_cond',int2str(i),' roi_circle pixels'])
    cd ..
    eval(['clear coeff_circle_cond',int2str(i)])
    eval(['clear cond',int2str(i),'n_dt_bl'])            
end

