


cd F:\Data\VSDI\Contour_integration\legolas\right_hemisphere\11_11_2008\c\elhanan_new\no_stim

load myrois

time=26:36;
win=8;


for i=[1 2 4 5] %condition count
    z=0;
    eval(['load cond',int2str(i),'n_dt_bl'])
    eval(['a=size(cond',int2str(i),'n_dt_bl,3);'])    
    b=size(time,2);
    eval(['coeff_maskin_contour2_cond',int2str(i),'=NaN*ones(size(roi_maskin,1),size(roi_contour2,1),b,a);'])
    for p=1:size(roi_maskin,1)
        z=z+1;
        disp(['pixel #',int2str(p),' condition #',int2str(i),' transforming data'])
        for h=1:a  %trial count
            %eval(['load cond',int2str(i),'n_dt_bl'])
            eval(['cond',int2str(i),'n_dt_tr=cond',int2str(i),'n_dt_bl(:,2:end,h);'])
            y=0;
                for j=time
                   y=y+1;
                   eval(['cc=sum((repmat(cond',int2str(i),'n_dt_tr(roi_maskin(p),j:j+win-1),[size(roi_contour2,1) 1])-repmat(mean(cond',int2str(i),'n_dt_tr(roi_maskin(p),j:j+win-1),2),[size(roi_contour2,1) win])).*(cond',int2str(i),'n_dt_tr(roi_contour2,j:j+win-1)-repmat(mean(cond',int2str(i),'n_dt_tr(roi_contour2,j:j+win-1),2),[1 win])),2)/(win-1);'])
                   eval(['var1=repmat(std(cond',int2str(i),'n_dt_tr(roi_maskin(p),j:j+win-1),0,2).^2,[size(roi_contour2,1) 1]);'])
                   eval(['var2=std(cond',int2str(i),'n_dt_tr(roi_contour2,j:j+win-1),0,2).^2;'])
                   eval(['coeff_maskin_contour2_cond',int2str(i),'(p,:,y,h)=cc./sqrt(var1.*var2);']) 
                end;
        end;
    end;
    cd pixelwise
    eval(['coeff_maskin_contour2_cond',int2str(i),'=mean(coeff_maskin_contour2_cond',int2str(i),',4);'])
    eval(['save coeff_maskin_contour2_cond',int2str(i),' coeff_maskin_contour2_cond',int2str(i),' roi_maskin time'])
    cd ..
    eval(['clear coeff_maskin_contour2_cond',int2str(i)])
    eval(['clear cond',int2str(i),'n_dt_bl'])            
end



cd F:\Data\VSDI\Contour_integration\legolas\right_hemisphere\11_11_2008\d\elhanan_new\no_stim

load myrois

time=26:36;
win=8;


for i=[1 2 4 5] %condition count
    z=0;
    eval(['load cond',int2str(i),'n_dt_bl'])
    eval(['a=size(cond',int2str(i),'n_dt_bl,3);'])    
    b=size(time,2);
    eval(['coeff_maskin_contour2_cond',int2str(i),'=NaN*ones(size(roi_maskin,1),size(roi_contour2,1),b,a);'])
    for p=1:size(roi_maskin,1)
        z=z+1;
        disp(['pixel #',int2str(p),' condition #',int2str(i),' transforming data'])
        for h=1:a  %trial count
            %eval(['load cond',int2str(i),'n_dt_bl'])
            eval(['cond',int2str(i),'n_dt_tr=cond',int2str(i),'n_dt_bl(:,2:end,h);'])
            y=0;
                for j=time
                   y=y+1;
                   eval(['cc=sum((repmat(cond',int2str(i),'n_dt_tr(roi_maskin(p),j:j+win-1),[size(roi_contour2,1) 1])-repmat(mean(cond',int2str(i),'n_dt_tr(roi_maskin(p),j:j+win-1),2),[size(roi_contour2,1) win])).*(cond',int2str(i),'n_dt_tr(roi_contour2,j:j+win-1)-repmat(mean(cond',int2str(i),'n_dt_tr(roi_contour2,j:j+win-1),2),[1 win])),2)/(win-1);'])
                   eval(['var1=repmat(std(cond',int2str(i),'n_dt_tr(roi_maskin(p),j:j+win-1),0,2).^2,[size(roi_contour2,1) 1]);'])
                   eval(['var2=std(cond',int2str(i),'n_dt_tr(roi_contour2,j:j+win-1),0,2).^2;'])
                   eval(['coeff_maskin_contour2_cond',int2str(i),'(p,:,y,h)=cc./sqrt(var1.*var2);']) 
                end;
        end;
    end;
    cd pixelwise
    eval(['coeff_maskin_contour2_cond',int2str(i),'=mean(coeff_maskin_contour2_cond',int2str(i),',4);'])
    eval(['save coeff_maskin_contour2_cond',int2str(i),' coeff_maskin_contour2_cond',int2str(i),' roi_maskin time'])
    cd ..
    eval(['clear coeff_maskin_contour2_cond',int2str(i)])
    eval(['clear cond',int2str(i),'n_dt_bl'])            
end




cd F:\Data\VSDI\Contour_integration\legolas\right_hemisphere\11_11_2008\h\no_stim

load myrois

time=26:36;
win=8;


for i=[1 2 4 5] %condition count
    z=0;
    eval(['load cond',int2str(i),'n_dt_bl'])
    eval(['a=size(cond',int2str(i),'n_dt_bl,3);'])    
    b=size(time,2);
    eval(['coeff_maskin_contour_cond',int2str(i),'=NaN*ones(size(roi_maskin,1),size(roi_contour,1),b,a);'])
    for p=1:size(roi_maskin,1)
        z=z+1;
        disp(['pixel #',int2str(p),' condition #',int2str(i),' transforming data'])
        for h=1:a  %trial count
            %eval(['load cond',int2str(i),'n_dt_bl'])
            eval(['cond',int2str(i),'n_dt_tr=cond',int2str(i),'n_dt_bl(:,2:end,h);'])
            y=0;
                for j=time
                   y=y+1;
                   eval(['cc=sum((repmat(cond',int2str(i),'n_dt_tr(roi_maskin(p),j:j+win-1),[size(roi_contour,1) 1])-repmat(mean(cond',int2str(i),'n_dt_tr(roi_maskin(p),j:j+win-1),2),[size(roi_contour,1) win])).*(cond',int2str(i),'n_dt_tr(roi_contour,j:j+win-1)-repmat(mean(cond',int2str(i),'n_dt_tr(roi_contour,j:j+win-1),2),[1 win])),2)/(win-1);'])
                   eval(['var1=repmat(std(cond',int2str(i),'n_dt_tr(roi_maskin(p),j:j+win-1),0,2).^2,[size(roi_contour,1) 1]);'])
                   eval(['var2=std(cond',int2str(i),'n_dt_tr(roi_contour,j:j+win-1),0,2).^2;'])
                   eval(['coeff_maskin_contour_cond',int2str(i),'(p,:,y,h)=cc./sqrt(var1.*var2);']) 
                end;
        end;
    end;
    cd pixelwise
    eval(['coeff_maskin_contour_cond',int2str(i),'=mean(coeff_maskin_contour_cond',int2str(i),',4);'])
    eval(['save coeff_maskin_contour_cond',int2str(i),' coeff_maskin_contour_cond',int2str(i),' roi_maskin time'])
    cd ..
    eval(['clear coeff_maskin_contour_cond',int2str(i)])
    eval(['clear cond',int2str(i),'n_dt_bl'])            
end


cd F:\Data\VSDI\Contour_integration\legolas\right_hemisphere\psychophysics\2008_11_25\d\correct_and_incorrect_together\no_stim
load myrois

time=26:36;
win=8;


for i=[1 5] %condition count
    z=0;
    eval(['load cond',int2str(i),'n_dt_bl'])
    eval(['a=size(cond',int2str(i),'n_dt_bl,3);'])    
    b=size(time,2);
    eval(['coeff_bg_in_circle_diff_cond',int2str(i),'=NaN*ones(size(roi_bg_in,1),size(roi_circle_diff,1),b,a);'])
    for p=1:size(roi_bg_in,1)
        z=z+1;
        disp(['pixel #',int2str(p),' condition #',int2str(i),' transforming data'])
        for h=1:a  %trial count
            %eval(['load cond',int2str(i),'n_dt_bl'])
            eval(['cond',int2str(i),'n_dt_tr=cond',int2str(i),'n_dt_bl(:,2:end,h);'])
            y=0;
                for j=time
                   y=y+1;
                   eval(['cc=sum((repmat(cond',int2str(i),'n_dt_tr(roi_bg_in(p),j:j+win-1),[size(roi_circle_diff,1) 1])-repmat(mean(cond',int2str(i),'n_dt_tr(roi_bg_in(p),j:j+win-1),2),[size(roi_circle_diff,1) win])).*(cond',int2str(i),'n_dt_tr(roi_circle_diff,j:j+win-1)-repmat(mean(cond',int2str(i),'n_dt_tr(roi_circle_diff,j:j+win-1),2),[1 win])),2)/(win-1);'])
                   eval(['var1=repmat(std(cond',int2str(i),'n_dt_tr(roi_bg_in(p),j:j+win-1),0,2).^2,[size(roi_circle_diff,1) 1]);'])
                   eval(['var2=std(cond',int2str(i),'n_dt_tr(roi_circle_diff,j:j+win-1),0,2).^2;'])
                   eval(['coeff_bg_in_circle_diff_cond',int2str(i),'(p,:,y,h)=cc./sqrt(var1.*var2);']) 
                end;
        end;
    end;
    cd pixelwise
    eval(['coeff_bg_in_circle_diff_cond',int2str(i),'=mean(coeff_bg_in_circle_diff_cond',int2str(i),',4);'])
    eval(['save coeff_bg_in_circle_diff_cond',int2str(i),' coeff_bg_in_circle_diff_cond',int2str(i),' roi_bg_in time'])
    cd ..
    eval(['clear coeff_bg_in_circle_diff_cond',int2str(i)])
    eval(['clear cond',int2str(i),'n_dt_bl'])            
end


cd F:\Data\VSDI\Contour_integration\legolas\right_hemisphere\psychophysics\2008_11_25\e\correct_and_incorrect_together\no_stim
load myrois

time=26:36;
win=8;


for i=[1 5] %condition count
    z=0;
    eval(['load cond',int2str(i),'n_dt_bl'])
    eval(['a=size(cond',int2str(i),'n_dt_bl,3);'])    
    b=size(time,2);
    eval(['coeff_bg_in_circle_diff_cond',int2str(i),'=NaN*ones(size(roi_bg_in,1),size(roi_circle_diff,1),b,a);'])
    for p=1:size(roi_bg_in,1)
        z=z+1;
        disp(['pixel #',int2str(p),' condition #',int2str(i),' transforming data'])
        for h=1:a  %trial count
            %eval(['load cond',int2str(i),'n_dt_bl'])
            eval(['cond',int2str(i),'n_dt_tr=cond',int2str(i),'n_dt_bl(:,2:end,h);'])
            y=0;
                for j=time
                   y=y+1;
                   eval(['cc=sum((repmat(cond',int2str(i),'n_dt_tr(roi_bg_in(p),j:j+win-1),[size(roi_circle_diff,1) 1])-repmat(mean(cond',int2str(i),'n_dt_tr(roi_bg_in(p),j:j+win-1),2),[size(roi_circle_diff,1) win])).*(cond',int2str(i),'n_dt_tr(roi_circle_diff,j:j+win-1)-repmat(mean(cond',int2str(i),'n_dt_tr(roi_circle_diff,j:j+win-1),2),[1 win])),2)/(win-1);'])
                   eval(['var1=repmat(std(cond',int2str(i),'n_dt_tr(roi_bg_in(p),j:j+win-1),0,2).^2,[size(roi_circle_diff,1) 1]);'])
                   eval(['var2=std(cond',int2str(i),'n_dt_tr(roi_circle_diff,j:j+win-1),0,2).^2;'])
                   eval(['coeff_bg_in_circle_diff_cond',int2str(i),'(p,:,y,h)=cc./sqrt(var1.*var2);']) 
                end;
        end;
    end;
    cd pixelwise
    eval(['coeff_bg_in_circle_diff_cond',int2str(i),'=mean(coeff_bg_in_circle_diff_cond',int2str(i),',4);'])
    eval(['save coeff_bg_in_circle_diff_cond',int2str(i),' coeff_bg_in_circle_diff_cond',int2str(i),' roi_bg_in time'])
    cd ..
    eval(['clear coeff_bg_in_circle_diff_cond',int2str(i)])
    eval(['clear cond',int2str(i),'n_dt_bl'])            
end

cd F:\Data\VSDI\Contour_integration\legolas\right_hemisphere\psychophysics\2008_11_25\f\correct_and_incorrect_together\no_stim
load myrois

time=26:36;
win=8;


for i=[1 5] %condition count
    z=0;
    eval(['load cond',int2str(i),'n_dt_bl'])
    eval(['a=size(cond',int2str(i),'n_dt_bl,3);'])    
    b=size(time,2);
    eval(['coeff_bg_in_circle_diff_cond',int2str(i),'=NaN*ones(size(roi_bg_in,1),size(roi_circle_diff,1),b,a);'])
    for p=1:size(roi_bg_in,1)
        z=z+1;
        disp(['pixel #',int2str(p),' condition #',int2str(i),' transforming data'])
        for h=1:a  %trial count
            %eval(['load cond',int2str(i),'n_dt_bl'])
            eval(['cond',int2str(i),'n_dt_tr=cond',int2str(i),'n_dt_bl(:,2:end,h);'])
            y=0;
                for j=time
                   y=y+1;
                   eval(['cc=sum((repmat(cond',int2str(i),'n_dt_tr(roi_bg_in(p),j:j+win-1),[size(roi_circle_diff,1) 1])-repmat(mean(cond',int2str(i),'n_dt_tr(roi_bg_in(p),j:j+win-1),2),[size(roi_circle_diff,1) win])).*(cond',int2str(i),'n_dt_tr(roi_circle_diff,j:j+win-1)-repmat(mean(cond',int2str(i),'n_dt_tr(roi_circle_diff,j:j+win-1),2),[1 win])),2)/(win-1);'])
                   eval(['var1=repmat(std(cond',int2str(i),'n_dt_tr(roi_bg_in(p),j:j+win-1),0,2).^2,[size(roi_circle_diff,1) 1]);'])
                   eval(['var2=std(cond',int2str(i),'n_dt_tr(roi_circle_diff,j:j+win-1),0,2).^2;'])
                   eval(['coeff_bg_in_circle_diff_cond',int2str(i),'(p,:,y,h)=cc./sqrt(var1.*var2);']) 
                end;
        end;
    end;
    cd pixelwise
    eval(['coeff_bg_in_circle_diff_cond',int2str(i),'=mean(coeff_bg_in_circle_diff_cond',int2str(i),',4);'])
    eval(['save coeff_bg_in_circle_diff_cond',int2str(i),' coeff_bg_in_circle_diff_cond',int2str(i),' roi_bg_in time'])
    cd ..
    eval(['clear coeff_bg_in_circle_diff_cond',int2str(i)])
    eval(['clear cond',int2str(i),'n_dt_bl'])            
end


cd F:\Data\VSDI\Contour_integration\legolas\right_hemisphere\psychophysics\2008_11_18\c\correct_and_incorrect_together\no_stim
load myrois

time=26:36;
win=8;


for i=[1 5] %condition count
    z=0;
    eval(['load cond',int2str(i),'n_dt_bl'])
    eval(['a=size(cond',int2str(i),'n_dt_bl,3);'])    
    b=size(time,2);
    eval(['coeff_bg_in_circle_diff_cond',int2str(i),'=NaN*ones(size(roi_bg_in,1),size(roi_circle_diff,1),b,a);'])
    for p=1:size(roi_bg_in,1)
        z=z+1;
        disp(['pixel #',int2str(p),' condition #',int2str(i),' transforming data'])
        for h=1:a  %trial count
            %eval(['load cond',int2str(i),'n_dt_bl'])
            eval(['cond',int2str(i),'n_dt_tr=cond',int2str(i),'n_dt_bl(:,2:end,h);'])
            y=0;
                for j=time
                   y=y+1;
                   eval(['cc=sum((repmat(cond',int2str(i),'n_dt_tr(roi_bg_in(p),j:j+win-1),[size(roi_circle_diff,1) 1])-repmat(mean(cond',int2str(i),'n_dt_tr(roi_bg_in(p),j:j+win-1),2),[size(roi_circle_diff,1) win])).*(cond',int2str(i),'n_dt_tr(roi_circle_diff,j:j+win-1)-repmat(mean(cond',int2str(i),'n_dt_tr(roi_circle_diff,j:j+win-1),2),[1 win])),2)/(win-1);'])
                   eval(['var1=repmat(std(cond',int2str(i),'n_dt_tr(roi_bg_in(p),j:j+win-1),0,2).^2,[size(roi_circle_diff,1) 1]);'])
                   eval(['var2=std(cond',int2str(i),'n_dt_tr(roi_circle_diff,j:j+win-1),0,2).^2;'])
                   eval(['coeff_bg_in_circle_diff_cond',int2str(i),'(p,:,y,h)=cc./sqrt(var1.*var2);']) 
                end;
        end;
    end;
    cd pixelwise
    eval(['coeff_bg_in_circle_diff_cond',int2str(i),'=mean(coeff_bg_in_circle_diff_cond',int2str(i),',4);'])
    eval(['save coeff_bg_in_circle_diff_cond',int2str(i),' coeff_bg_in_circle_diff_cond',int2str(i),' roi_bg_in time'])
    cd ..
    eval(['clear coeff_bg_in_circle_diff_cond',int2str(i)])
    eval(['clear cond',int2str(i),'n_dt_bl'])            
end

cd F:\Data\VSDI\Contour_integration\legolas\right_hemisphere\psychophysics\2008_11_18\d\correct_and_incorrect_together\no_stim
load myrois

time=26:36;
win=8;


for i=[1 5] %condition count
    z=0;
    eval(['load cond',int2str(i),'n_dt_bl'])
    eval(['a=size(cond',int2str(i),'n_dt_bl,3);'])    
    b=size(time,2);
    eval(['coeff_bg_in_circle_diff_cond',int2str(i),'=NaN*ones(size(roi_bg_in,1),size(roi_circle_diff,1),b,a);'])
    for p=1:size(roi_bg_in,1)
        z=z+1;
        disp(['pixel #',int2str(p),' condition #',int2str(i),' transforming data'])
        for h=1:a  %trial count
            %eval(['load cond',int2str(i),'n_dt_bl'])
            eval(['cond',int2str(i),'n_dt_tr=cond',int2str(i),'n_dt_bl(:,2:end,h);'])
            y=0;
                for j=time
                   y=y+1;
                   eval(['cc=sum((repmat(cond',int2str(i),'n_dt_tr(roi_bg_in(p),j:j+win-1),[size(roi_circle_diff,1) 1])-repmat(mean(cond',int2str(i),'n_dt_tr(roi_bg_in(p),j:j+win-1),2),[size(roi_circle_diff,1) win])).*(cond',int2str(i),'n_dt_tr(roi_circle_diff,j:j+win-1)-repmat(mean(cond',int2str(i),'n_dt_tr(roi_circle_diff,j:j+win-1),2),[1 win])),2)/(win-1);'])
                   eval(['var1=repmat(std(cond',int2str(i),'n_dt_tr(roi_bg_in(p),j:j+win-1),0,2).^2,[size(roi_circle_diff,1) 1]);'])
                   eval(['var2=std(cond',int2str(i),'n_dt_tr(roi_circle_diff,j:j+win-1),0,2).^2;'])
                   eval(['coeff_bg_in_circle_diff_cond',int2str(i),'(p,:,y,h)=cc./sqrt(var1.*var2);']) 
                end;
        end;
    end;
    cd pixelwise
    eval(['coeff_bg_in_circle_diff_cond',int2str(i),'=mean(coeff_bg_in_circle_diff_cond',int2str(i),',4);'])
    eval(['save coeff_bg_in_circle_diff_cond',int2str(i),' coeff_bg_in_circle_diff_cond',int2str(i),' roi_bg_in time'])
    cd ..
    eval(['clear coeff_bg_in_circle_diff_cond',int2str(i)])
    eval(['clear cond',int2str(i),'n_dt_bl'])            
end


cd F:\Data\VSDI\Contour_integration\legolas\right_hemisphere\psychophysics\2008_11_18\e\correct_and_incorrect_together\no_stim
load myrois

time=26:36;
win=8;


for i=[1 5] %condition count
    z=0;
    eval(['load cond',int2str(i),'n_dt_bl'])
    eval(['a=size(cond',int2str(i),'n_dt_bl,3);'])    
    b=size(time,2);
    eval(['coeff_bg_in_circle_diff_cond',int2str(i),'=NaN*ones(size(roi_bg_in,1),size(roi_circle_diff,1),b,a);'])
    for p=1:size(roi_bg_in,1)
        z=z+1;
        disp(['pixel #',int2str(p),' condition #',int2str(i),' transforming data'])
        for h=1:a  %trial count
            %eval(['load cond',int2str(i),'n_dt_bl'])
            eval(['cond',int2str(i),'n_dt_tr=cond',int2str(i),'n_dt_bl(:,2:end,h);'])
            y=0;
                for j=time
                   y=y+1;
                   eval(['cc=sum((repmat(cond',int2str(i),'n_dt_tr(roi_bg_in(p),j:j+win-1),[size(roi_circle_diff,1) 1])-repmat(mean(cond',int2str(i),'n_dt_tr(roi_bg_in(p),j:j+win-1),2),[size(roi_circle_diff,1) win])).*(cond',int2str(i),'n_dt_tr(roi_circle_diff,j:j+win-1)-repmat(mean(cond',int2str(i),'n_dt_tr(roi_circle_diff,j:j+win-1),2),[1 win])),2)/(win-1);'])
                   eval(['var1=repmat(std(cond',int2str(i),'n_dt_tr(roi_bg_in(p),j:j+win-1),0,2).^2,[size(roi_circle_diff,1) 1]);'])
                   eval(['var2=std(cond',int2str(i),'n_dt_tr(roi_circle_diff,j:j+win-1),0,2).^2;'])
                   eval(['coeff_bg_in_circle_diff_cond',int2str(i),'(p,:,y,h)=cc./sqrt(var1.*var2);']) 
                end;
        end;
    end;
    cd pixelwise
    eval(['coeff_bg_in_circle_diff_cond',int2str(i),'=mean(coeff_bg_in_circle_diff_cond',int2str(i),',4);'])
    eval(['save coeff_bg_in_circle_diff_cond',int2str(i),' coeff_bg_in_circle_diff_cond',int2str(i),' roi_bg_in time'])
    cd ..
    eval(['clear coeff_bg_in_circle_diff_cond',int2str(i)])
    eval(['clear cond',int2str(i),'n_dt_bl'])            
end


cd F:\Data\VSDI\Contour_integration\legolas\right_hemisphere\psychophysics\2008_12_03\d\correct_and_incorrect_together\no_stim
load myrois

time=26:36;
win=8;


for i=[1 5] %condition count
    z=0;
    eval(['load cond',int2str(i),'n_dt_bl'])
    eval(['a=size(cond',int2str(i),'n_dt_bl,3);'])    
    b=size(time,2);
    eval(['coeff_bg_in_circle_diff_cond',int2str(i),'=NaN*ones(size(roi_bg_in,1),size(roi_circle_diff,1),b,a);'])
    for p=1:size(roi_bg_in,1)
        z=z+1;
        disp(['pixel #',int2str(p),' condition #',int2str(i),' transforming data'])
        for h=1:a  %trial count
            %eval(['load cond',int2str(i),'n_dt_bl'])
            eval(['cond',int2str(i),'n_dt_tr=cond',int2str(i),'n_dt_bl(:,2:end,h);'])
            y=0;
                for j=time
                   y=y+1;
                   eval(['cc=sum((repmat(cond',int2str(i),'n_dt_tr(roi_bg_in(p),j:j+win-1),[size(roi_circle_diff,1) 1])-repmat(mean(cond',int2str(i),'n_dt_tr(roi_bg_in(p),j:j+win-1),2),[size(roi_circle_diff,1) win])).*(cond',int2str(i),'n_dt_tr(roi_circle_diff,j:j+win-1)-repmat(mean(cond',int2str(i),'n_dt_tr(roi_circle_diff,j:j+win-1),2),[1 win])),2)/(win-1);'])
                   eval(['var1=repmat(std(cond',int2str(i),'n_dt_tr(roi_bg_in(p),j:j+win-1),0,2).^2,[size(roi_circle_diff,1) 1]);'])
                   eval(['var2=std(cond',int2str(i),'n_dt_tr(roi_circle_diff,j:j+win-1),0,2).^2;'])
                   eval(['coeff_bg_in_circle_diff_cond',int2str(i),'(p,:,y,h)=cc./sqrt(var1.*var2);']) 
                end;
        end;
    end;
    cd pixelwise
    eval(['coeff_bg_in_circle_diff_cond',int2str(i),'=mean(coeff_bg_in_circle_diff_cond',int2str(i),',4);'])
    eval(['save coeff_bg_in_circle_diff_cond',int2str(i),' coeff_bg_in_circle_diff_cond',int2str(i),' roi_bg_in time'])
    cd ..
    eval(['clear coeff_bg_in_circle_diff_cond',int2str(i)])
    eval(['clear cond',int2str(i),'n_dt_bl'])            
end


cd F:\Data\VSDI\Contour_integration\legolas\right_hemisphere\psychophysics\2008_12_03\e\correct_and_incorrect_together\no_stim
load myrois

time=26:36;
win=8;


for i=[1 5] %condition count
    z=0;
    eval(['load cond',int2str(i),'n_dt_bl'])
    eval(['a=size(cond',int2str(i),'n_dt_bl,3);'])    
    b=size(time,2);
    eval(['coeff_bg_in_circle_diff_cond',int2str(i),'=NaN*ones(size(roi_bg_in,1),size(roi_circle_diff,1),b,a);'])
    for p=1:size(roi_bg_in,1)
        z=z+1;
        disp(['pixel #',int2str(p),' condition #',int2str(i),' transforming data'])
        for h=1:a  %trial count
            %eval(['load cond',int2str(i),'n_dt_bl'])
            eval(['cond',int2str(i),'n_dt_tr=cond',int2str(i),'n_dt_bl(:,2:end,h);'])
            y=0;
                for j=time
                   y=y+1;
                   eval(['cc=sum((repmat(cond',int2str(i),'n_dt_tr(roi_bg_in(p),j:j+win-1),[size(roi_circle_diff,1) 1])-repmat(mean(cond',int2str(i),'n_dt_tr(roi_bg_in(p),j:j+win-1),2),[size(roi_circle_diff,1) win])).*(cond',int2str(i),'n_dt_tr(roi_circle_diff,j:j+win-1)-repmat(mean(cond',int2str(i),'n_dt_tr(roi_circle_diff,j:j+win-1),2),[1 win])),2)/(win-1);'])
                   eval(['var1=repmat(std(cond',int2str(i),'n_dt_tr(roi_bg_in(p),j:j+win-1),0,2).^2,[size(roi_circle_diff,1) 1]);'])
                   eval(['var2=std(cond',int2str(i),'n_dt_tr(roi_circle_diff,j:j+win-1),0,2).^2;'])
                   eval(['coeff_bg_in_circle_diff_cond',int2str(i),'(p,:,y,h)=cc./sqrt(var1.*var2);']) 
                end;
        end;
    end;
    cd pixelwise
    eval(['coeff_bg_in_circle_diff_cond',int2str(i),'=mean(coeff_bg_in_circle_diff_cond',int2str(i),',4);'])
    eval(['save coeff_bg_in_circle_diff_cond',int2str(i),' coeff_bg_in_circle_diff_cond',int2str(i),' roi_bg_in time'])
    cd ..
    eval(['clear coeff_bg_in_circle_diff_cond',int2str(i)])
    eval(['clear cond',int2str(i),'n_dt_bl'])            
end


cd F:\Data\VSDI\Contour_integration\legolas\right_hemisphere\psychophysics\2008_12_03\f\correct_and_incorrect_together\no_stim
load myrois

time=26:36;
win=8;


for i=[1 5] %condition count
    z=0;
    eval(['load cond',int2str(i),'n_dt_bl'])
    eval(['a=size(cond',int2str(i),'n_dt_bl,3);'])    
    b=size(time,2);
    eval(['coeff_bg_in_circle_diff_cond',int2str(i),'=NaN*ones(size(roi_bg_in,1),size(roi_circle_diff,1),b,a);'])
    for p=1:size(roi_bg_in,1)
        z=z+1;
        disp(['pixel #',int2str(p),' condition #',int2str(i),' transforming data'])
        for h=1:a  %trial count
            %eval(['load cond',int2str(i),'n_dt_bl'])
            eval(['cond',int2str(i),'n_dt_tr=cond',int2str(i),'n_dt_bl(:,2:end,h);'])
            y=0;
                for j=time
                   y=y+1;
                   eval(['cc=sum((repmat(cond',int2str(i),'n_dt_tr(roi_bg_in(p),j:j+win-1),[size(roi_circle_diff,1) 1])-repmat(mean(cond',int2str(i),'n_dt_tr(roi_bg_in(p),j:j+win-1),2),[size(roi_circle_diff,1) win])).*(cond',int2str(i),'n_dt_tr(roi_circle_diff,j:j+win-1)-repmat(mean(cond',int2str(i),'n_dt_tr(roi_circle_diff,j:j+win-1),2),[1 win])),2)/(win-1);'])
                   eval(['var1=repmat(std(cond',int2str(i),'n_dt_tr(roi_bg_in(p),j:j+win-1),0,2).^2,[size(roi_circle_diff,1) 1]);'])
                   eval(['var2=std(cond',int2str(i),'n_dt_tr(roi_circle_diff,j:j+win-1),0,2).^2;'])
                   eval(['coeff_bg_in_circle_diff_cond',int2str(i),'(p,:,y,h)=cc./sqrt(var1.*var2);']) 
                end;
        end;
    end;
    cd pixelwise
    eval(['coeff_bg_in_circle_diff_cond',int2str(i),'=mean(coeff_bg_in_circle_diff_cond',int2str(i),',4);'])
    eval(['save coeff_bg_in_circle_diff_cond',int2str(i),' coeff_bg_in_circle_diff_cond',int2str(i),' roi_bg_in time'])
    cd ..
    eval(['clear coeff_bg_in_circle_diff_cond',int2str(i)])
    eval(['clear cond',int2str(i),'n_dt_bl'])            
end


cd F:\Data\VSDI\Contour_integration\legolas\right_hemisphere\06_10_2008\e\no_stim
load myrois

time=26:36;
win=8;


for i=[1 2 4 5] %condition count
    z=0;
    eval(['load cond',int2str(i),'n_dt_bl'])
    eval(['a=size(cond',int2str(i),'n_dt_bl,3);'])    
    b=size(time,2);
    eval(['coeff_bg_in_circle_diff_cond',int2str(i),'=NaN*ones(size(roi_bg_in,1),size(roi_circle_diff,1),b,a);'])
    for p=1:size(roi_bg_in,1)
        z=z+1;
        disp(['pixel #',int2str(p),' condition #',int2str(i),' transforming data'])
        for h=1:a  %trial count
            %eval(['load cond',int2str(i),'n_dt_bl'])
            eval(['cond',int2str(i),'n_dt_tr=cond',int2str(i),'n_dt_bl(:,2:end,h);'])
            y=0;
                for j=time
                   y=y+1;
                   eval(['cc=sum((repmat(cond',int2str(i),'n_dt_tr(roi_bg_in(p),j:j+win-1),[size(roi_circle_diff,1) 1])-repmat(mean(cond',int2str(i),'n_dt_tr(roi_bg_in(p),j:j+win-1),2),[size(roi_circle_diff,1) win])).*(cond',int2str(i),'n_dt_tr(roi_circle_diff,j:j+win-1)-repmat(mean(cond',int2str(i),'n_dt_tr(roi_circle_diff,j:j+win-1),2),[1 win])),2)/(win-1);'])
                   eval(['var1=repmat(std(cond',int2str(i),'n_dt_tr(roi_bg_in(p),j:j+win-1),0,2).^2,[size(roi_circle_diff,1) 1]);'])
                   eval(['var2=std(cond',int2str(i),'n_dt_tr(roi_circle_diff,j:j+win-1),0,2).^2;'])
                   eval(['coeff_bg_in_circle_diff_cond',int2str(i),'(p,:,y,h)=cc./sqrt(var1.*var2);']) 
                end;
        end;
    end;
    cd pixelwise
    eval(['coeff_bg_in_circle_diff_cond',int2str(i),'=mean(coeff_bg_in_circle_diff_cond',int2str(i),',4);'])
    eval(['save coeff_bg_in_circle_diff_cond',int2str(i),' coeff_bg_in_circle_diff_cond',int2str(i),' roi_bg_in time'])
    cd ..
    eval(['clear coeff_bg_in_circle_diff_cond',int2str(i)])
    eval(['clear cond',int2str(i),'n_dt_bl'])            
end


cd F:\Data\VSDI\Contour_integration\legolas\right_hemisphere\06_10_2008\f\no_stim
load myrois

time=26:36;
win=8;


for i=[1 2 4 5] %condition count
    z=0;
    eval(['load cond',int2str(i),'n_dt_bl'])
    eval(['a=size(cond',int2str(i),'n_dt_bl,3);'])    
    b=size(time,2);
    eval(['coeff_bg_in_circle_diff_cond',int2str(i),'=NaN*ones(size(roi_bg_in,1),size(roi_circle_diff,1),b,a);'])
    for p=1:size(roi_bg_in,1)
        z=z+1;
        disp(['pixel #',int2str(p),' condition #',int2str(i),' transforming data'])
        for h=1:a  %trial count
            %eval(['load cond',int2str(i),'n_dt_bl'])
            eval(['cond',int2str(i),'n_dt_tr=cond',int2str(i),'n_dt_bl(:,2:end,h);'])
            y=0;
                for j=time
                   y=y+1;
                   eval(['cc=sum((repmat(cond',int2str(i),'n_dt_tr(roi_bg_in(p),j:j+win-1),[size(roi_circle_diff,1) 1])-repmat(mean(cond',int2str(i),'n_dt_tr(roi_bg_in(p),j:j+win-1),2),[size(roi_circle_diff,1) win])).*(cond',int2str(i),'n_dt_tr(roi_circle_diff,j:j+win-1)-repmat(mean(cond',int2str(i),'n_dt_tr(roi_circle_diff,j:j+win-1),2),[1 win])),2)/(win-1);'])
                   eval(['var1=repmat(std(cond',int2str(i),'n_dt_tr(roi_bg_in(p),j:j+win-1),0,2).^2,[size(roi_circle_diff,1) 1]);'])
                   eval(['var2=std(cond',int2str(i),'n_dt_tr(roi_circle_diff,j:j+win-1),0,2).^2;'])
                   eval(['coeff_bg_in_circle_diff_cond',int2str(i),'(p,:,y,h)=cc./sqrt(var1.*var2);']) 
                end;
        end;
    end;
    cd pixelwise
    eval(['coeff_bg_in_circle_diff_cond',int2str(i),'=mean(coeff_bg_in_circle_diff_cond',int2str(i),',4);'])
    eval(['save coeff_bg_in_circle_diff_cond',int2str(i),' coeff_bg_in_circle_diff_cond',int2str(i),' roi_bg_in time'])
    cd ..
    eval(['clear coeff_bg_in_circle_diff_cond',int2str(i)])
    eval(['clear cond',int2str(i),'n_dt_bl'])            
end


cd F:\Data\VSDI\Contour_integration\legolas\right_hemisphere\22_10_2008\d\no_stim
load myrois

time=26:36;
win=8;


for i=[1 2 4 5] %condition count
    z=0;
    eval(['load cond',int2str(i),'n_dt_bl'])
    eval(['a=size(cond',int2str(i),'n_dt_bl,3);'])    
    b=size(time,2);
    eval(['coeff_bg_in_circle_diff_cond',int2str(i),'=NaN*ones(size(roi_bg_in,1),size(roi_circle_diff,1),b,a);'])
    for p=1:size(roi_bg_in,1)
        z=z+1;
        disp(['pixel #',int2str(p),' condition #',int2str(i),' transforming data'])
        for h=1:a  %trial count
            %eval(['load cond',int2str(i),'n_dt_bl'])
            eval(['cond',int2str(i),'n_dt_tr=cond',int2str(i),'n_dt_bl(:,2:end,h);'])
            y=0;
                for j=time
                   y=y+1;
                   eval(['cc=sum((repmat(cond',int2str(i),'n_dt_tr(roi_bg_in(p),j:j+win-1),[size(roi_circle_diff,1) 1])-repmat(mean(cond',int2str(i),'n_dt_tr(roi_bg_in(p),j:j+win-1),2),[size(roi_circle_diff,1) win])).*(cond',int2str(i),'n_dt_tr(roi_circle_diff,j:j+win-1)-repmat(mean(cond',int2str(i),'n_dt_tr(roi_circle_diff,j:j+win-1),2),[1 win])),2)/(win-1);'])
                   eval(['var1=repmat(std(cond',int2str(i),'n_dt_tr(roi_bg_in(p),j:j+win-1),0,2).^2,[size(roi_circle_diff,1) 1]);'])
                   eval(['var2=std(cond',int2str(i),'n_dt_tr(roi_circle_diff,j:j+win-1),0,2).^2;'])
                   eval(['coeff_bg_in_circle_diff_cond',int2str(i),'(p,:,y,h)=cc./sqrt(var1.*var2);']) 
                end;
        end;
    end;
    cd pixelwise
    eval(['coeff_bg_in_circle_diff_cond',int2str(i),'=mean(coeff_bg_in_circle_diff_cond',int2str(i),',4);'])
    eval(['save coeff_bg_in_circle_diff_cond',int2str(i),' coeff_bg_in_circle_diff_cond',int2str(i),' roi_bg_in time'])
    cd ..
    eval(['clear coeff_bg_in_circle_diff_cond',int2str(i)])
    eval(['clear cond',int2str(i),'n_dt_bl'])            
end


cd F:\Data\VSDI\Contour_integration\legolas\right_hemisphere\22_10_2008\e\no_stim
load myrois

time=26:36;
win=8;


for i=[1 2 4 5] %condition count
    z=0;
    eval(['load cond',int2str(i),'n_dt_bl'])
    eval(['a=size(cond',int2str(i),'n_dt_bl,3);'])    
    b=size(time,2);
    eval(['coeff_bg_in_circle_diff_cond',int2str(i),'=NaN*ones(size(roi_bg_in,1),size(roi_circle_diff,1),b,a);'])
    for p=1:size(roi_bg_in,1)
        z=z+1;
        disp(['pixel #',int2str(p),' condition #',int2str(i),' transforming data'])
        for h=1:a  %trial count
            %eval(['load cond',int2str(i),'n_dt_bl'])
            eval(['cond',int2str(i),'n_dt_tr=cond',int2str(i),'n_dt_bl(:,2:end,h);'])
            y=0;
                for j=time
                   y=y+1;
                   eval(['cc=sum((repmat(cond',int2str(i),'n_dt_tr(roi_bg_in(p),j:j+win-1),[size(roi_circle_diff,1) 1])-repmat(mean(cond',int2str(i),'n_dt_tr(roi_bg_in(p),j:j+win-1),2),[size(roi_circle_diff,1) win])).*(cond',int2str(i),'n_dt_tr(roi_circle_diff,j:j+win-1)-repmat(mean(cond',int2str(i),'n_dt_tr(roi_circle_diff,j:j+win-1),2),[1 win])),2)/(win-1);'])
                   eval(['var1=repmat(std(cond',int2str(i),'n_dt_tr(roi_bg_in(p),j:j+win-1),0,2).^2,[size(roi_circle_diff,1) 1]);'])
                   eval(['var2=std(cond',int2str(i),'n_dt_tr(roi_circle_diff,j:j+win-1),0,2).^2;'])
                   eval(['coeff_bg_in_circle_diff_cond',int2str(i),'(p,:,y,h)=cc./sqrt(var1.*var2);']) 
                end;
        end;
    end;
    cd pixelwise
    eval(['coeff_bg_in_circle_diff_cond',int2str(i),'=mean(coeff_bg_in_circle_diff_cond',int2str(i),',4);'])
    eval(['save coeff_bg_in_circle_diff_cond',int2str(i),' coeff_bg_in_circle_diff_cond',int2str(i),' roi_bg_in time'])
    cd ..
    eval(['clear coeff_bg_in_circle_diff_cond',int2str(i)])
    eval(['clear cond',int2str(i),'n_dt_bl'])            
end
