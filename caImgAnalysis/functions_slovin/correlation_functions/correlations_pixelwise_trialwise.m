


cd F:\Data\VSDI\Contour_integration\legolas\right_hemisphere\psychophysics\2008_11_25\d\correct_and_incorrect_together
%load myrois
load('corr_map_bg_for_figure4_ci_paper.mat', 'roi_bg_in4')
time=26:36;
win=8;

for i=[1 5] %condition count
    z=0;
    eval(['load cond',int2str(i),'n_dt_bl'])
    eval(['a=size(cond',int2str(i),'n_dt_bl,3);'])    
    b=size(time,2);
    eval(['coeff_bg_in4_cond',int2str(i),'=NaN*ones(size(roi_bg_in4,1),size(roi_bg_in4,1),b,a);'])
    for p=1:size(roi_bg_in4,1)
        z=z+1;
        disp(['pixel #',int2str(p),' condition #',int2str(i),' transforming data'])
        for h=1:a  %trial count
            
            %eval(['load cond',int2str(i),'n_dt_bl'])
            eval(['cond',int2str(i),'n_dt_tr=cond',int2str(i),'n_dt_bl(:,2:end,h);'])
            y=0;
                for j=time
                   y=y+1;
                   eval(['cc=sum((repmat(cond',int2str(i),'n_dt_tr(roi_bg_in4(p),j:j+win-1),[size(roi_bg_in4,1) 1])-repmat(mean(cond',int2str(i),'n_dt_tr(roi_bg_in4(p),j:j+win-1),2),[size(roi_bg_in4,1) win])).*(cond',int2str(i),'n_dt_tr(roi_bg_in4,j:j+win-1)-repmat(mean(cond',int2str(i),'n_dt_tr(roi_bg_in4,j:j+win-1),2),[1 win])),2)/(win-1);'])
                   eval(['var1=repmat(std(cond',int2str(i),'n_dt_tr(roi_bg_in4(p),j:j+win-1),0,2).^2,[size(roi_bg_in4,1) 1]);'])
                   eval(['var2=std(cond',int2str(i),'n_dt_tr(roi_bg_in4,j:j+win-1),0,2).^2;'])
                   eval(['coeff_bg_in4_cond',int2str(i),'(:,p,y,h)=cc./sqrt(var1.*var2);']) 
                end;
        end;
    end;
    cd pixelwise
    eval(['coeff_bg_in4_cond',int2str(i),'=mean(coeff_bg_in4_cond',int2str(i),',4);'])
    eval(['save coeff_bg_in4_cond',int2str(i),' coeff_bg_in4_cond',int2str(i),' roi_bg_in4 time'])
    cd ..
    eval(['clear coeff_bg_in4_cond',int2str(i)])
    eval(['clear cond',int2str(i),'n_dt_bl'])            
end



cd F:\Data\VSDI\Contour_integration\legolas\right_hemisphere\11_11_2008\
%load myrois
load('time_rois_for_fig2_ci_after_cleanning_BETTER_wo_drifts.mat', 'roi_contour5')
cd F:\Data\VSDI\Contour_integration\legolas\right_hemisphere\11_11_2008\c\elhanan_new
time=26:36;
win=8;

for i=[1 2 4 5] %condition count
    z=0;
    eval(['load cond',int2str(i),'n_dt_bl'])
    eval(['a=size(cond',int2str(i),'n_dt_bl,3);'])    
    b=size(time,2);
    eval(['coeff_contour5_cond',int2str(i),'=NaN*ones(size(roi_contour5,1),size(roi_contour5,1),b,a);'])
    for p=1:size(roi_contour5,1)
        z=z+1;
        disp(['pixel #',int2str(p),' condition #',int2str(i),' transforming data'])
        for h=1:a  %trial count
            
            %eval(['load cond',int2str(i),'n_dt_bl'])
            eval(['cond',int2str(i),'n_dt_tr=cond',int2str(i),'n_dt_bl(:,2:end,h);'])
            y=0;
                for j=time
                   y=y+1;
                   eval(['cc=sum((repmat(cond',int2str(i),'n_dt_tr(roi_contour5(p),j:j+win-1),[size(roi_contour5,1) 1])-repmat(mean(cond',int2str(i),'n_dt_tr(roi_contour5(p),j:j+win-1),2),[size(roi_contour5,1) win])).*(cond',int2str(i),'n_dt_tr(roi_contour5,j:j+win-1)-repmat(mean(cond',int2str(i),'n_dt_tr(roi_contour5,j:j+win-1),2),[1 win])),2)/(win-1);'])
                   eval(['var1=repmat(std(cond',int2str(i),'n_dt_tr(roi_contour5(p),j:j+win-1),0,2).^2,[size(roi_contour5,1) 1]);'])
                   eval(['var2=std(cond',int2str(i),'n_dt_tr(roi_contour5,j:j+win-1),0,2).^2;'])
                   eval(['coeff_contour5_cond',int2str(i),'(:,p,y,h)=cc./sqrt(var1.*var2);']) 
                end;
        end;
    end;
    cd pixelwise
    eval(['coeff_contour5_cond',int2str(i),'=mean(coeff_contour5_cond',int2str(i),',4);'])
    eval(['save coeff_contour5_cond',int2str(i),' coeff_contour5_cond',int2str(i),' roi_contour5 time'])
    cd ..
    eval(['clear coeff_contour5_cond',int2str(i)])
    eval(['clear cond',int2str(i),'n_dt_bl'])            
end


cd F:\Data\VSDI\Contour_integration\legolas\right_hemisphere\11_11_2008\
%load myrois
load('time_rois_for_fig2_ci_after_cleanning_BETTER_wo_drifts.mat', 'roi_contour5')
cd F:\Data\VSDI\Contour_integration\legolas\right_hemisphere\11_11_2008\d\elhanan_new
time=26:36;
win=8;

for i=[1 2 4 5] %condition count
    z=0;
    eval(['load cond',int2str(i),'n_dt_bl'])
    eval(['a=size(cond',int2str(i),'n_dt_bl,3);'])    
    b=size(time,2);
    eval(['coeff_contour5_cond',int2str(i),'=NaN*ones(size(roi_contour5,1),size(roi_contour5,1),b,a);'])
    for p=1:size(roi_contour5,1)
        z=z+1;
        disp(['pixel #',int2str(p),' condition #',int2str(i),' transforming data'])
        for h=1:a  %trial count
            
            %eval(['load cond',int2str(i),'n_dt_bl'])
            eval(['cond',int2str(i),'n_dt_tr=cond',int2str(i),'n_dt_bl(:,2:end,h);'])
            y=0;
                for j=time
                   y=y+1;
                   eval(['cc=sum((repmat(cond',int2str(i),'n_dt_tr(roi_contour5(p),j:j+win-1),[size(roi_contour5,1) 1])-repmat(mean(cond',int2str(i),'n_dt_tr(roi_contour5(p),j:j+win-1),2),[size(roi_contour5,1) win])).*(cond',int2str(i),'n_dt_tr(roi_contour5,j:j+win-1)-repmat(mean(cond',int2str(i),'n_dt_tr(roi_contour5,j:j+win-1),2),[1 win])),2)/(win-1);'])
                   eval(['var1=repmat(std(cond',int2str(i),'n_dt_tr(roi_contour5(p),j:j+win-1),0,2).^2,[size(roi_contour5,1) 1]);'])
                   eval(['var2=std(cond',int2str(i),'n_dt_tr(roi_contour5,j:j+win-1),0,2).^2;'])
                   eval(['coeff_contour5_cond',int2str(i),'(:,p,y,h)=cc./sqrt(var1.*var2);']) 
                end;
        end;
    end;
    cd pixelwise
    eval(['coeff_contour5_cond',int2str(i),'=mean(coeff_contour5_cond',int2str(i),',4);'])
    eval(['save coeff_contour5_cond',int2str(i),' coeff_contour5_cond',int2str(i),' roi_contour5 time'])
    cd ..
    eval(['clear coeff_contour5_cond',int2str(i)])
    eval(['clear cond',int2str(i),'n_dt_bl'])            
end




cd F:\Data\VSDI\Contour_integration\Smeagol\29Dec2010\c
%load myrois
load('circ_corr_maps_for_figure4_ci.mat', 'roi_circle4')
time=26:36;
win=8;

for i=[1 2 4 5] %condition count
    z=0;
    eval(['load cond',int2str(i),'n_dt_bl'])
    eval(['a=size(cond',int2str(i),'n_dt_bl,3);'])    
    b=size(time,2);
    eval(['coeff_circle4_cond',int2str(i),'=NaN*ones(size(roi_circle4,1),size(roi_circle4,1),b,a);'])
    for p=1:size(roi_circle4,1)
        z=z+1;
        disp(['pixel #',int2str(p),' condition #',int2str(i),' transforming data'])
        for h=1:a  %trial count
            
            %eval(['load cond',int2str(i),'n_dt_bl'])
            eval(['cond',int2str(i),'n_dt_tr=cond',int2str(i),'n_dt_bl(:,2:end,h);'])
            y=0;
                for j=time
                   y=y+1;
                   eval(['cc=sum((repmat(cond',int2str(i),'n_dt_tr(roi_circle4(p),j:j+win-1),[size(roi_circle4,1) 1])-repmat(mean(cond',int2str(i),'n_dt_tr(roi_circle4(p),j:j+win-1),2),[size(roi_circle4,1) win])).*(cond',int2str(i),'n_dt_tr(roi_circle4,j:j+win-1)-repmat(mean(cond',int2str(i),'n_dt_tr(roi_circle4,j:j+win-1),2),[1 win])),2)/(win-1);'])
                   eval(['var1=repmat(std(cond',int2str(i),'n_dt_tr(roi_circle4(p),j:j+win-1),0,2).^2,[size(roi_circle4,1) 1]);'])
                   eval(['var2=std(cond',int2str(i),'n_dt_tr(roi_circle4,j:j+win-1),0,2).^2;'])
                   eval(['coeff_circle4_cond',int2str(i),'(:,p,y,h)=cc./sqrt(var1.*var2);']) 
                end;
        end;
    end;
    cd pixelwise
    eval(['coeff_circle4_cond',int2str(i),'=mean(coeff_circle4_cond',int2str(i),',4);'])
    eval(['save coeff_circle4_cond',int2str(i),' coeff_circle4_cond',int2str(i),' roi_circle4 time'])
    cd ..
    eval(['clear coeff_circle4_cond',int2str(i)])
    eval(['clear cond',int2str(i),'n_dt_bl'])            
end


cd F:\Data\VSDI\Contour_integration\Smeagol\29Dec2010\e
%load myrois
load('bg_corr_map_for_fig4_ci.mat', 'roi_bg_out4')
time=26:36;
win=8;

for i=[1 2 4 5] %condition count
    z=0;
    eval(['load cond',int2str(i),'n_dt_bl'])
    eval(['a=size(cond',int2str(i),'n_dt_bl,3);'])    
    b=size(time,2);
    eval(['coeff_bg_out4_cond',int2str(i),'=NaN*ones(size(roi_bg_out4,1),size(roi_bg_out4,1),b,a);'])
    for p=1:size(roi_bg_out4,1)
        z=z+1;
        disp(['pixel #',int2str(p),' condition #',int2str(i),' transforming data'])
        for h=1:a  %trial count
            
            %eval(['load cond',int2str(i),'n_dt_bl'])
            eval(['cond',int2str(i),'n_dt_tr=cond',int2str(i),'n_dt_bl(:,2:end,h);'])
            y=0;
                for j=time
                   y=y+1;
                   eval(['cc=sum((repmat(cond',int2str(i),'n_dt_tr(roi_bg_out4(p),j:j+win-1),[size(roi_bg_out4,1) 1])-repmat(mean(cond',int2str(i),'n_dt_tr(roi_bg_out4(p),j:j+win-1),2),[size(roi_bg_out4,1) win])).*(cond',int2str(i),'n_dt_tr(roi_bg_out4,j:j+win-1)-repmat(mean(cond',int2str(i),'n_dt_tr(roi_bg_out4,j:j+win-1),2),[1 win])),2)/(win-1);'])
                   eval(['var1=repmat(std(cond',int2str(i),'n_dt_tr(roi_bg_out4(p),j:j+win-1),0,2).^2,[size(roi_bg_out4,1) 1]);'])
                   eval(['var2=std(cond',int2str(i),'n_dt_tr(roi_bg_out4,j:j+win-1),0,2).^2;'])
                   eval(['coeff_bg_out4_cond',int2str(i),'(:,p,y,h)=cc./sqrt(var1.*var2);']) 
                end;
        end;
    end;
    cd pixelwise
    eval(['coeff_bg_out4_cond',int2str(i),'=mean(coeff_bg_out4_cond',int2str(i),',4);'])
    eval(['save coeff_bg_out4_cond',int2str(i),' coeff_bg_out4_cond',int2str(i),' roi_bg_out4 time'])
    cd ..
    eval(['clear coeff_bg_out4_cond',int2str(i)])
    eval(['clear cond',int2str(i),'n_dt_bl'])            
end


