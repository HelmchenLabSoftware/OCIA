
cd /fat2/Ariel_Gilad/Matlab_analysis/experiments/mask/legolas/right_hemisphere/11_11_2008/h

load pixels_to_remove
t=ones(10000,1);
t(pixels_to_remove)=0;
pixels=find(t);
clear t


load myrois


win=8;
for i=1:5 %condition count
    z=0;
    eval(['load cond',int2str(i),'n_dt_bl'])
    eval(['cond',int2str(i),'n_dt_bl=mean(cond',int2str(i),'n_dt_bl,3);'])
    eval(['a=size(cond',int2str(i),'n_dt_bl,3);'])    
    eval(['b=size(cond',int2str(i),'n_dt_bl,2)/2;'])
    for p=1:size(roi_f3,1)
        z=z+1;
        eval(['coeff_f3_cond',int2str(i),'_pix_',int2str(roi_f3(p)),'=NaN*ones(size(pixels,1),b-win,a);'])
        for h=1:a  %trial count
            
            
            disp(['pixel #',int2str(p),' condition #',int2str(i),' trial #',int2str(h),' transforming data'])
            %eval(['load cond',int2str(i),'n_dt_bl'])
            eval(['cond',int2str(i),'n_dt_tr=cond',int2str(i),'n_dt_bl(:,2:end,h);'])
            
                for j=1:(b-win)
                   eval(['cc=sum((repmat(cond',int2str(i),'n_dt_tr(roi_f3(p),j:j+win-1),[size(pixels,1) 1])-repmat(mean(cond',int2str(i),'n_dt_tr(roi_f3(p),j:j+win-1),2),[size(pixels,1) win])).*(cond',int2str(i),'n_dt_tr(pixels,j:j+win-1)-repmat(mean(cond',int2str(i),'n_dt_tr(pixels,j:j+win-1),2),[1 win])),2)/(win-1);'])
                   eval(['var1=repmat(std(cond',int2str(i),'n_dt_tr(roi_f3(p),j:j+win-1),0,2).^2,[size(pixels,1) 1]);'])
                   eval(['var2=std(cond',int2str(i),'n_dt_tr(pixels,j:j+win-1),0,2).^2;'])
                   eval(['coeff_f3_cond',int2str(i),'_pix_',int2str(roi_f3(p)),'(:,j,h)=cc./sqrt(var1.*var2);']) 
                end;
            
        end;
        if z==1
            eval(['coeff_f3_cond',int2str(i),'=coeff_f3_cond',int2str(i),'_pix_',int2str(roi_f3(p)),';'])    
        else
            eval(['coeff_f3_cond',int2str(i),'=coeff_f3_cond',int2str(i),'+coeff_f3_cond',int2str(i),'_pix_',int2str(roi_f3(p)),';'])
        end 
        eval(['clear coeff_f3_cond',int2str(i),'_pix_',int2str(roi_f3(p))])
    end;
    eval(['coeff_f3_cond',int2str(i),'=coeff_f3_cond',int2str(i),'/size(roi_f3,1);'])
    cd pixels
    eval(['save coeff_f3_ave_cond',int2str(i),' coeff_f3_cond',int2str(i),' roi_f3 pixels'])
    cd ..
    eval(['clear coeff_f3_cond',int2str(i)])
    eval(['clear cond',int2str(i),'n_dt_bl'])            
end



cd /fat2/Ariel_Gilad/Matlab_analysis/experiments/mask/legolas/right_hemisphere/11_11_2008/h

load pixels_to_remove
t=ones(10000,1);
t(pixels_to_remove)=0;
pixels=find(t);
clear t


load myrois


win=8;
for i=1:5 %condition count
    z=0;
    eval(['load cond',int2str(i),'n_dt_bl'])
    eval(['cond',int2str(i),'n_dt_bl=mean(cond',int2str(i),'n_dt_bl,3);'])
    eval(['a=size(cond',int2str(i),'n_dt_bl,3);'])    
    eval(['b=size(cond',int2str(i),'n_dt_bl,2)/2;'])
    for p=1:size(roi_f6,1)
        z=z+1;
        eval(['coeff_f6_cond',int2str(i),'_pix_',int2str(roi_f6(p)),'=NaN*ones(size(pixels,1),b-win,a);'])
        for h=1:a  %trial count
            
            
            disp(['pixel #',int2str(p),' condition #',int2str(i),' trial #',int2str(h),' transforming data'])
            %eval(['load cond',int2str(i),'n_dt_bl'])
            eval(['cond',int2str(i),'n_dt_tr=cond',int2str(i),'n_dt_bl(:,2:end,h);'])
            
                for j=1:(b-win)
                   eval(['cc=sum((repmat(cond',int2str(i),'n_dt_tr(roi_f6(p),j:j+win-1),[size(pixels,1) 1])-repmat(mean(cond',int2str(i),'n_dt_tr(roi_f6(p),j:j+win-1),2),[size(pixels,1) win])).*(cond',int2str(i),'n_dt_tr(pixels,j:j+win-1)-repmat(mean(cond',int2str(i),'n_dt_tr(pixels,j:j+win-1),2),[1 win])),2)/(win-1);'])
                   eval(['var1=repmat(std(cond',int2str(i),'n_dt_tr(roi_f6(p),j:j+win-1),0,2).^2,[size(pixels,1) 1]);'])
                   eval(['var2=std(cond',int2str(i),'n_dt_tr(pixels,j:j+win-1),0,2).^2;'])
                   eval(['coeff_f6_cond',int2str(i),'_pix_',int2str(roi_f6(p)),'(:,j,h)=cc./sqrt(var1.*var2);']) 
                end;
            
        end;
        if z==1
            eval(['coeff_f6_cond',int2str(i),'=coeff_f6_cond',int2str(i),'_pix_',int2str(roi_f6(p)),';'])    
        else
            eval(['coeff_f6_cond',int2str(i),'=coeff_f6_cond',int2str(i),'+coeff_f6_cond',int2str(i),'_pix_',int2str(roi_f6(p)),';'])
        end 
        eval(['clear coeff_f6_cond',int2str(i),'_pix_',int2str(roi_f6(p))])
    end;
    eval(['coeff_f6_cond',int2str(i),'=coeff_f6_cond',int2str(i),'/size(roi_f6,1);'])
    cd pixels
    eval(['save coeff_f6_ave_cond',int2str(i),' coeff_f6_cond',int2str(i),' roi_f6 pixels'])
    cd ..
    eval(['clear coeff_f6_cond',int2str(i)])
    eval(['clear cond',int2str(i),'n_dt_bl'])            
end


cd /fat2/Ariel_Gilad/Matlab_analysis/experiments/mask/legolas/right_hemisphere/11_11_2008/h

load pixels_to_remove
t=ones(10000,1);
t(pixels_to_remove)=0;
pixels=find(t);
clear t


load myrois


win=8;
for i=1:5 %condition count
    z=0;
    eval(['load cond',int2str(i),'n_dt_bl'])
    eval(['cond',int2str(i),'n_dt_bl=mean(cond',int2str(i),'n_dt_bl,3);'])
    eval(['a=size(cond',int2str(i),'n_dt_bl,3);'])    
    eval(['b=size(cond',int2str(i),'n_dt_bl,2)/2;'])
    for p=1:size(roi_f1,1)
        z=z+1;
        eval(['coeff_f1_cond',int2str(i),'_pix_',int2str(roi_f1(p)),'=NaN*ones(size(pixels,1),b-win,a);'])
        for h=1:a  %trial count
            
            
            disp(['pixel #',int2str(p),' condition #',int2str(i),' trial #',int2str(h),' transforming data'])
            %eval(['load cond',int2str(i),'n_dt_bl'])
            eval(['cond',int2str(i),'n_dt_tr=cond',int2str(i),'n_dt_bl(:,2:end,h);'])
            
                for j=1:(b-win)
                   eval(['cc=sum((repmat(cond',int2str(i),'n_dt_tr(roi_f1(p),j:j+win-1),[size(pixels,1) 1])-repmat(mean(cond',int2str(i),'n_dt_tr(roi_f1(p),j:j+win-1),2),[size(pixels,1) win])).*(cond',int2str(i),'n_dt_tr(pixels,j:j+win-1)-repmat(mean(cond',int2str(i),'n_dt_tr(pixels,j:j+win-1),2),[1 win])),2)/(win-1);'])
                   eval(['var1=repmat(std(cond',int2str(i),'n_dt_tr(roi_f1(p),j:j+win-1),0,2).^2,[size(pixels,1) 1]);'])
                   eval(['var2=std(cond',int2str(i),'n_dt_tr(pixels,j:j+win-1),0,2).^2;'])
                   eval(['coeff_f1_cond',int2str(i),'_pix_',int2str(roi_f1(p)),'(:,j,h)=cc./sqrt(var1.*var2);']) 
                end;
            
        end;
        if z==1
            eval(['coeff_f1_cond',int2str(i),'=coeff_f1_cond',int2str(i),'_pix_',int2str(roi_f1(p)),';'])    
        else
            eval(['coeff_f1_cond',int2str(i),'=coeff_f1_cond',int2str(i),'+coeff_f1_cond',int2str(i),'_pix_',int2str(roi_f1(p)),';'])
        end 
        eval(['clear coeff_f1_cond',int2str(i),'_pix_',int2str(roi_f1(p))])
    end;
    eval(['coeff_f1_cond',int2str(i),'=coeff_f1_cond',int2str(i),'/size(roi_f1,1);'])
    cd pixels
    eval(['save coeff_f1_ave_cond',int2str(i),' coeff_f1_cond',int2str(i),' roi_f1 pixels'])
    cd ..
    eval(['clear coeff_f1_cond',int2str(i)])
    eval(['clear cond',int2str(i),'n_dt_bl'])            
end


