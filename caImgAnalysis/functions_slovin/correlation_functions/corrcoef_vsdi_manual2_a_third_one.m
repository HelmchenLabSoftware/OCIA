

cd /fat2/Ariel_Gilad/Matlab_analysis/experiments/mask/legolas/right_hemisphere/psychophysics/2008_11_25/d

load pixels_to_remove
t=ones(10000,1);
t(pixels_to_remove)=0;
pixels=find(t);
clear t




load 2511


win=8;
for i=[2 4]%condition count
    z=0;
    eval(['load cond',int2str(i),'n_dt_bl'])
    eval(['a=size(cond',int2str(i),'n_dt_bl,3);'])    
    eval(['b=size(cond',int2str(i),'n_dt_bl,2)/2;'])
    for p=1:size(roi_contour,1)
        for h=1:a  %trial count
            
            z=z+1;
            disp(['pixel #',int2str(p),' condition #',int2str(i),' trial #',int2str(h),' transforming data'])
            %eval(['load cond',int2str(i),'n_dt_bl'])
            eval(['cond',int2str(i),'n_dt_tr=cond',int2str(i),'n_dt_bl(:,2:end,h);'])
            eval(['coeff_contour_cond',int2str(i),'_t=NaN*ones(size(pixels,1),b-win);'])
            
                for j=1:(b-win)
                   eval(['cc=sum((repmat(cond',int2str(i),'n_dt_tr(roi_contour(p),j:j+win-1),[size(pixels,1) 1])-repmat(mean(cond',int2str(i),'n_dt_tr(roi_contour(p),j:j+win-1),2),[size(pixels,1) win])).*(cond',int2str(i),'n_dt_tr(pixels,j:j+win-1)-repmat(mean(cond',int2str(i),'n_dt_tr(pixels,j:j+win-1),2),[1 win])),2)/(win-1);'])
                   eval(['v1=repmat(std(cond',int2str(i),'n_dt_tr(roi_contour(p),j:j+win-1),0,2).^2,[size(pixels,1) 1]);'])
                   eval(['v2=std(cond',int2str(i),'n_dt_tr(pixels,j:j+win-1),0,2).^2;'])
                   eval(['coeff_contour_cond',int2str(i),'_t(:,j)=cc./sqrt(v1.*v2);']) 
                end;
            eval(['clear cond',int2str(i),'n_dt_tr'])
            if z==1
                eval(['coeff_contour_cond',int2str(i),'=coeff_contour_cond',int2str(i),'_t;'])    
            else
                eval(['coeff_contour_cond',int2str(i),'=coeff_contour_cond',int2str(i),'+coeff_contour_cond',int2str(i),'_t;'])
            end
            eval(['clear coeff_contour_cond',int2str(i),'_t'])
           
        end;
    end;
    eval(['coeff_contour_cond',int2str(i),'=coeff_contour_cond',int2str(i),'/z;'])
    eval(['cd ./win_',int2str(win)])
    eval(['save coeff_contour_cond',int2str(i),' coeff_contour_cond',int2str(i),' roi_contour pixels'])
    cd ..
    eval(['clear coeff_contour_cond',int2str(i)])
    eval(['clear cond',int2str(i),'n_dt_bl'])
end





cd /fat2/Ariel_Gilad/Matlab_analysis/experiments/mask/legolas/right_hemisphere/psychophysics/2008_11_25/e

load pixels_to_remove
t=ones(10000,1);
t(pixels_to_remove)=0;
pixels=find(t);
clear t




load 2511


win=8;
for i=[2 4]%condition count
    z=0;
    eval(['load cond',int2str(i),'n_dt_bl'])
    eval(['a=size(cond',int2str(i),'n_dt_bl,3);'])    
    eval(['b=size(cond',int2str(i),'n_dt_bl,2)/2;'])
    for p=1:size(roi_contour,1)
        for h=1:a  %trial count
            
            z=z+1;
            disp(['pixel #',int2str(p),' condition #',int2str(i),' trial #',int2str(h),' transforming data'])
            %eval(['load cond',int2str(i),'n_dt_bl'])
            eval(['cond',int2str(i),'n_dt_tr=cond',int2str(i),'n_dt_bl(:,2:end,h);'])
            eval(['coeff_contour_cond',int2str(i),'_t=NaN*ones(size(pixels,1),b-win);'])
            
                for j=1:(b-win)
                   eval(['cc=sum((repmat(cond',int2str(i),'n_dt_tr(roi_contour(p),j:j+win-1),[size(pixels,1) 1])-repmat(mean(cond',int2str(i),'n_dt_tr(roi_contour(p),j:j+win-1),2),[size(pixels,1) win])).*(cond',int2str(i),'n_dt_tr(pixels,j:j+win-1)-repmat(mean(cond',int2str(i),'n_dt_tr(pixels,j:j+win-1),2),[1 win])),2)/(win-1);'])
                   eval(['v1=repmat(std(cond',int2str(i),'n_dt_tr(roi_contour(p),j:j+win-1),0,2).^2,[size(pixels,1) 1]);'])
                   eval(['v2=std(cond',int2str(i),'n_dt_tr(pixels,j:j+win-1),0,2).^2;'])
                   eval(['coeff_contour_cond',int2str(i),'_t(:,j)=cc./sqrt(v1.*v2);']) 
                end;
            eval(['clear cond',int2str(i),'n_dt_tr'])
            if z==1
                eval(['coeff_contour_cond',int2str(i),'=coeff_contour_cond',int2str(i),'_t;'])    
            else
                eval(['coeff_contour_cond',int2str(i),'=coeff_contour_cond',int2str(i),'+coeff_contour_cond',int2str(i),'_t;'])
            end
            eval(['clear coeff_contour_cond',int2str(i),'_t'])
           
        end;
    end;
    eval(['coeff_contour_cond',int2str(i),'=coeff_contour_cond',int2str(i),'/z;'])
    eval(['cd ./win_',int2str(win)])
    eval(['save coeff_contour_cond',int2str(i),' coeff_contour_cond',int2str(i),' roi_contour pixels'])
    cd ..
    eval(['clear coeff_contour_cond',int2str(i)])
    eval(['clear cond',int2str(i),'n_dt_bl'])
end


cd /fat2/Ariel_Gilad/Matlab_analysis/experiments/mask/legolas/right_hemisphere/psychophysics/2008_11_25/f

load pixels_to_remove
t=ones(10000,1);
t(pixels_to_remove)=0;
pixels=find(t);
clear t




load 2511


win=8;
for i=[2 4]%condition count
    z=0;
    eval(['load cond',int2str(i),'n_dt_bl'])
    eval(['a=size(cond',int2str(i),'n_dt_bl,3);'])    
    eval(['b=size(cond',int2str(i),'n_dt_bl,2)/2;'])
    for p=1:size(roi_contour,1)
        for h=1:a  %trial count
            
            z=z+1;
            disp(['pixel #',int2str(p),' condition #',int2str(i),' trial #',int2str(h),' transforming data'])
            %eval(['load cond',int2str(i),'n_dt_bl'])
            eval(['cond',int2str(i),'n_dt_tr=cond',int2str(i),'n_dt_bl(:,2:end,h);'])
            eval(['coeff_contour_cond',int2str(i),'_t=NaN*ones(size(pixels,1),b-win);'])
            
                for j=1:(b-win)
                   eval(['cc=sum((repmat(cond',int2str(i),'n_dt_tr(roi_contour(p),j:j+win-1),[size(pixels,1) 1])-repmat(mean(cond',int2str(i),'n_dt_tr(roi_contour(p),j:j+win-1),2),[size(pixels,1) win])).*(cond',int2str(i),'n_dt_tr(pixels,j:j+win-1)-repmat(mean(cond',int2str(i),'n_dt_tr(pixels,j:j+win-1),2),[1 win])),2)/(win-1);'])
                   eval(['v1=repmat(std(cond',int2str(i),'n_dt_tr(roi_contour(p),j:j+win-1),0,2).^2,[size(pixels,1) 1]);'])
                   eval(['v2=std(cond',int2str(i),'n_dt_tr(pixels,j:j+win-1),0,2).^2;'])
                   eval(['coeff_contour_cond',int2str(i),'_t(:,j)=cc./sqrt(v1.*v2);']) 
                end;
            eval(['clear cond',int2str(i),'n_dt_tr'])
            if z==1
                eval(['coeff_contour_cond',int2str(i),'=coeff_contour_cond',int2str(i),'_t;'])    
            else
                eval(['coeff_contour_cond',int2str(i),'=coeff_contour_cond',int2str(i),'+coeff_contour_cond',int2str(i),'_t;'])
            end
            eval(['clear coeff_contour_cond',int2str(i),'_t'])
           
        end;
    end;
    eval(['coeff_contour_cond',int2str(i),'=coeff_contour_cond',int2str(i),'/z;'])
    eval(['cd ./win_',int2str(win)])
    eval(['save coeff_contour_cond',int2str(i),' coeff_contour_cond',int2str(i),' roi_contour pixels'])
    cd ..
    eval(['clear coeff_contour_cond',int2str(i)])
    eval(['clear cond',int2str(i),'n_dt_bl'])
end



