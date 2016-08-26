cd /fat/Ariel/matlab_analysis/vsdi/vsdi_coVnon_path/Path/legolas/2007_04_18/way2

load pixels_to_remove
t=ones(10000,1);
t(pixels_to_remove)=0;
pixels=find(t);
clear t




load 1804


win=8;
for i=[4 3 6]%condition count
    z=0;
    eval(['load alphadiff',int2str(i),'n_dt_bl'])
    eval(['a=size(alphadiff',int2str(i),'n_dt_bl,3);'])    
    eval(['b=112;'])
    for p=1:size(roi_V1,1)
        for h=1:a  %trial count
            
            z=z+1;
            disp(['pixel #',int2str(p),' condition #',int2str(i),' trial #',int2str(h),' transforming data'])
            %eval(['load alphadiff',int2str(i),'n_dt_bl'])
            eval(['alphadiff',int2str(i),'n_dt_tr=alphadiff',int2str(i),'n_dt_bl(:,:,h);'])
            eval(['coeff_V1_alphadiff',int2str(i),'_t=NaN*ones(size(pixels,1),b-win);'])
            
                for j=1:(b-win)
                   eval(['cc=sum((repmat(alphadiff',int2str(i),'n_dt_tr(roi_V1(p),j:j+win-1),[size(pixels,1) 1])-repmat(mean(alphadiff',int2str(i),'n_dt_tr(roi_V1(p),j:j+win-1),2),[size(pixels,1) win])).*(alphadiff',int2str(i),'n_dt_tr(pixels,j:j+win-1)-repmat(mean(alphadiff',int2str(i),'n_dt_tr(pixels,j:j+win-1),2),[1 win])),2)/(win-1);'])
                   eval(['v1=repmat(std(alphadiff',int2str(i),'n_dt_tr(roi_V1(p),j:j+win-1),0,2).^2,[size(pixels,1) 1]);'])
                   eval(['v2=std(alphadiff',int2str(i),'n_dt_tr(pixels,j:j+win-1),0,2).^2;'])
                   eval(['coeff_V1_alphadiff',int2str(i),'_t(:,j)=cc./sqrt(v1.*v2);']) 
                end;
            eval(['clear alphadiff',int2str(i),'n_dt_tr'])
            if z==1
                eval(['coeff_V1_alphadiff',int2str(i),'=coeff_V1_alphadiff',int2str(i),'_t;'])    
            else
                eval(['coeff_V1_alphadiff',int2str(i),'=coeff_V1_alphadiff',int2str(i),'+coeff_V1_alphadiff',int2str(i),'_t;'])
            end
            eval(['clear coeff_V1_alphadiff',int2str(i),'_t'])
           
        end;
    end;
    eval(['coeff_V1_alphadiff',int2str(i),'=coeff_V1_alphadiff',int2str(i),'/z;'])
    eval(['cd ./win_',int2str(win)])
    eval(['save coeff_V1_alphadiff',int2str(i),' coeff_V1_alphadiff',int2str(i),' roi_V1 pixels'])
    cd ..
    eval(['clear coeff_V1_alphadiff',int2str(i)])
    eval(['clear alphadiff',int2str(i),'n_dt_bl'])
end




