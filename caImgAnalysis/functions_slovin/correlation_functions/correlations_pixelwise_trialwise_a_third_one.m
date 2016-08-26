

cd F:\Data\VSDI\Contour_integration\legolas\right_hemisphere\11_11_2008\c\elhanan_new
load v1

time=26:36;
win=8;

for i=3 %condition count
    z=0;
    eval(['load cond',int2str(i),'n_dt_bl'])
    eval(['a=size(cond',int2str(i),'n_dt_bl,3);'])    
    b=size(time,2);
    eval(['coeff_v1_cond',int2str(i),'=NaN*ones(size(roi_v1,1),size(roi_v1,1),b);'])
    eval(['tt=NaN*ones(size(roi_v1,1),size(roi_v1,1),b);'])
    for p=1:size(roi_v1,1)
        z=z+1;
        disp(['pixel #',int2str(p),' condition #',int2str(i),' transforming data'])
        for h=1:a  %trial count
            
            %eval(['load cond',int2str(i),'n_dt_bl'])
            eval(['cond',int2str(i),'n_dt_tr=cond',int2str(i),'n_dt_bl(:,2:end,h);'])
            y=0;
                for j=time
                   y=y+1;
                   eval(['cc=sum((repmat(cond',int2str(i),'n_dt_tr(roi_v1(p),j:j+win-1),[size(roi_v1,1) 1])-repmat(mean(cond',int2str(i),'n_dt_tr(roi_v1(p),j:j+win-1),2),[size(roi_v1,1) win])).*(cond',int2str(i),'n_dt_tr(roi_v1,j:j+win-1)-repmat(mean(cond',int2str(i),'n_dt_tr(roi_v1,j:j+win-1),2),[1 win])),2)/(win-1);'])
                   eval(['var1=repmat(std(cond',int2str(i),'n_dt_tr(roi_v1(p),j:j+win-1),0,2).^2,[size(roi_v1,1) 1]);'])
                   eval(['var2=std(cond',int2str(i),'n_dt_tr(roi_v1,j:j+win-1),0,2).^2;'])
                   eval(['tt(:,p,y)=cc./sqrt(var1.*var2);']) 
                end;
            if h==1
                eval(['coeff_v1_cond',int2str(i),'=tt;'])
            else
                eval(['coeff_v1_cond',int2str(i),'=coeff_v1_cond',int2str(i),'+tt;'])
            end
        end;
    end;
    cd pixelwise
    eval(['coeff_v1_cond',int2str(i),'=coeff_v1_cond',int2str(i),'/a;'])
    eval(['save coeff_v1_cond',int2str(i),' coeff_v1_cond',int2str(i),' roi_v1 time'])
    cd ..
    eval(['clear coeff_v1_cond',int2str(i)])
    clear tt
    eval(['clear cond',int2str(i),'n_dt_bl'])            
end


cd F:\Data\VSDI\Contour_integration\legolas\right_hemisphere\11_11_2008\d\elhanan_new
load v1

time=26:36;
win=8;

for i=3 %condition count
    z=0;
    eval(['load cond',int2str(i),'n_dt_bl'])
    eval(['a=size(cond',int2str(i),'n_dt_bl,3);'])    
    b=size(time,2);
    eval(['coeff_v1_cond',int2str(i),'=NaN*ones(size(roi_v1,1),size(roi_v1,1),b);'])
    eval(['tt=NaN*ones(size(roi_v1,1),size(roi_v1,1),b);'])
    for p=1:size(roi_v1,1)
        z=z+1;
        disp(['pixel #',int2str(p),' condition #',int2str(i),' transforming data'])
        for h=1:a  %trial count
            
            %eval(['load cond',int2str(i),'n_dt_bl'])
            eval(['cond',int2str(i),'n_dt_tr=cond',int2str(i),'n_dt_bl(:,2:end,h);'])
            y=0;
                for j=time
                   y=y+1;
                   eval(['cc=sum((repmat(cond',int2str(i),'n_dt_tr(roi_v1(p),j:j+win-1),[size(roi_v1,1) 1])-repmat(mean(cond',int2str(i),'n_dt_tr(roi_v1(p),j:j+win-1),2),[size(roi_v1,1) win])).*(cond',int2str(i),'n_dt_tr(roi_v1,j:j+win-1)-repmat(mean(cond',int2str(i),'n_dt_tr(roi_v1,j:j+win-1),2),[1 win])),2)/(win-1);'])
                   eval(['var1=repmat(std(cond',int2str(i),'n_dt_tr(roi_v1(p),j:j+win-1),0,2).^2,[size(roi_v1,1) 1]);'])
                   eval(['var2=std(cond',int2str(i),'n_dt_tr(roi_v1,j:j+win-1),0,2).^2;'])
                   eval(['tt(:,p,y)=cc./sqrt(var1.*var2);']) 
                end;
            if h==1
                eval(['coeff_v1_cond',int2str(i),'=tt;'])
            else
                eval(['coeff_v1_cond',int2str(i),'=coeff_v1_cond',int2str(i),'+tt;'])
            end
        end;
    end;
    cd pixelwise
    eval(['coeff_v1_cond',int2str(i),'=coeff_v1_cond',int2str(i),'/a;'])
    eval(['save coeff_v1_cond',int2str(i),' coeff_v1_cond',int2str(i),' roi_v1 time'])
    cd ..
    eval(['clear coeff_v1_cond',int2str(i)])
    clear tt
    eval(['clear cond',int2str(i),'n_dt_bl'])            
end

cd F:\Data\VSDI\Contour_integration\legolas\right_hemisphere\11_11_2008\h
load v1

time=26:36;
win=8;

for i=3 %condition count
    z=0;
    eval(['load cond',int2str(i),'n_dt_bl'])
    eval(['a=size(cond',int2str(i),'n_dt_bl,3);'])    
    b=size(time,2);
    eval(['coeff_v1_cond',int2str(i),'=NaN*ones(size(roi_v1,1),size(roi_v1,1),b);'])
    eval(['tt=NaN*ones(size(roi_v1,1),size(roi_v1,1),b);'])
    for p=1:size(roi_v1,1)
        z=z+1;
        disp(['pixel #',int2str(p),' condition #',int2str(i),' transforming data'])
        for h=1:a  %trial count
            
            %eval(['load cond',int2str(i),'n_dt_bl'])
            eval(['cond',int2str(i),'n_dt_tr=cond',int2str(i),'n_dt_bl(:,2:end,h);'])
            y=0;
                for j=time
                   y=y+1;
                   eval(['cc=sum((repmat(cond',int2str(i),'n_dt_tr(roi_v1(p),j:j+win-1),[size(roi_v1,1) 1])-repmat(mean(cond',int2str(i),'n_dt_tr(roi_v1(p),j:j+win-1),2),[size(roi_v1,1) win])).*(cond',int2str(i),'n_dt_tr(roi_v1,j:j+win-1)-repmat(mean(cond',int2str(i),'n_dt_tr(roi_v1,j:j+win-1),2),[1 win])),2)/(win-1);'])
                   eval(['var1=repmat(std(cond',int2str(i),'n_dt_tr(roi_v1(p),j:j+win-1),0,2).^2,[size(roi_v1,1) 1]);'])
                   eval(['var2=std(cond',int2str(i),'n_dt_tr(roi_v1,j:j+win-1),0,2).^2;'])
                   eval(['tt(:,p,y)=cc./sqrt(var1.*var2);']) 
                end;
            if h==1
                eval(['coeff_v1_cond',int2str(i),'=tt;'])
            else
                eval(['coeff_v1_cond',int2str(i),'=coeff_v1_cond',int2str(i),'+tt;'])
            end
        end;
    end;
    cd pixelwise
    eval(['coeff_v1_cond',int2str(i),'=coeff_v1_cond',int2str(i),'/a;'])
    eval(['save coeff_v1_cond',int2str(i),' coeff_v1_cond',int2str(i),' roi_v1 time'])
    cd ..
    eval(['clear coeff_v1_cond',int2str(i)])
    clear tt
    eval(['clear cond',int2str(i),'n_dt_bl'])            
end

cd F:\Data\VSDI\Contour_integration\legolas\right_hemisphere\psychophysics\2008_11_25\d\correct_and_incorrect_together
load v1

time=26:36;
win=8;

for i=3 %condition count
    z=0;
    eval(['load cond',int2str(i),'n_dt_bl'])
    eval(['a=size(cond',int2str(i),'n_dt_bl,3);'])    
    b=size(time,2);
    eval(['coeff_v1_cond',int2str(i),'=NaN*ones(size(roi_v1,1),size(roi_v1,1),b);'])
    eval(['tt=NaN*ones(size(roi_v1,1),size(roi_v1,1),b);'])
    for p=1:size(roi_v1,1)
        z=z+1;
        disp(['pixel #',int2str(p),' condition #',int2str(i),' transforming data'])
        for h=1:a  %trial count
            
            %eval(['load cond',int2str(i),'n_dt_bl'])
            eval(['cond',int2str(i),'n_dt_tr=cond',int2str(i),'n_dt_bl(:,2:end,h);'])
            y=0;
                for j=time
                   y=y+1;
                   eval(['cc=sum((repmat(cond',int2str(i),'n_dt_tr(roi_v1(p),j:j+win-1),[size(roi_v1,1) 1])-repmat(mean(cond',int2str(i),'n_dt_tr(roi_v1(p),j:j+win-1),2),[size(roi_v1,1) win])).*(cond',int2str(i),'n_dt_tr(roi_v1,j:j+win-1)-repmat(mean(cond',int2str(i),'n_dt_tr(roi_v1,j:j+win-1),2),[1 win])),2)/(win-1);'])
                   eval(['var1=repmat(std(cond',int2str(i),'n_dt_tr(roi_v1(p),j:j+win-1),0,2).^2,[size(roi_v1,1) 1]);'])
                   eval(['var2=std(cond',int2str(i),'n_dt_tr(roi_v1,j:j+win-1),0,2).^2;'])
                   eval(['tt(:,p,y)=cc./sqrt(var1.*var2);']) 
                end;
            if h==1
                eval(['coeff_v1_cond',int2str(i),'=tt;'])
            else
                eval(['coeff_v1_cond',int2str(i),'=coeff_v1_cond',int2str(i),'+tt;'])
            end
        end;
    end;
    cd pixelwise
    eval(['coeff_v1_cond',int2str(i),'=coeff_v1_cond',int2str(i),'/a;'])
    eval(['save coeff_v1_cond',int2str(i),' coeff_v1_cond',int2str(i),' roi_v1 time'])
    cd ..
    eval(['clear coeff_v1_cond',int2str(i)])
    clear tt
    eval(['clear cond',int2str(i),'n_dt_bl'])            
end

cd F:\Data\VSDI\Contour_integration\legolas\right_hemisphere\psychophysics\2008_11_25\e\correct_and_incorrect_together
load v1

time=26:36;
win=8;

for i=3 %condition count
    z=0;
    eval(['load cond',int2str(i),'n_dt_bl'])
    eval(['a=size(cond',int2str(i),'n_dt_bl,3);'])    
    b=size(time,2);
    eval(['coeff_v1_cond',int2str(i),'=NaN*ones(size(roi_v1,1),size(roi_v1,1),b);'])
    eval(['tt=NaN*ones(size(roi_v1,1),size(roi_v1,1),b);'])
    for p=1:size(roi_v1,1)
        z=z+1;
        disp(['pixel #',int2str(p),' condition #',int2str(i),' transforming data'])
        for h=1:a  %trial count
            
            %eval(['load cond',int2str(i),'n_dt_bl'])
            eval(['cond',int2str(i),'n_dt_tr=cond',int2str(i),'n_dt_bl(:,2:end,h);'])
            y=0;
                for j=time
                   y=y+1;
                   eval(['cc=sum((repmat(cond',int2str(i),'n_dt_tr(roi_v1(p),j:j+win-1),[size(roi_v1,1) 1])-repmat(mean(cond',int2str(i),'n_dt_tr(roi_v1(p),j:j+win-1),2),[size(roi_v1,1) win])).*(cond',int2str(i),'n_dt_tr(roi_v1,j:j+win-1)-repmat(mean(cond',int2str(i),'n_dt_tr(roi_v1,j:j+win-1),2),[1 win])),2)/(win-1);'])
                   eval(['var1=repmat(std(cond',int2str(i),'n_dt_tr(roi_v1(p),j:j+win-1),0,2).^2,[size(roi_v1,1) 1]);'])
                   eval(['var2=std(cond',int2str(i),'n_dt_tr(roi_v1,j:j+win-1),0,2).^2;'])
                   eval(['tt(:,p,y)=cc./sqrt(var1.*var2);']) 
                end;
            if h==1
                eval(['coeff_v1_cond',int2str(i),'=tt;'])
            else
                eval(['coeff_v1_cond',int2str(i),'=coeff_v1_cond',int2str(i),'+tt;'])
            end
        end;
    end;
    cd pixelwise
    eval(['coeff_v1_cond',int2str(i),'=coeff_v1_cond',int2str(i),'/a;'])
    eval(['save coeff_v1_cond',int2str(i),' coeff_v1_cond',int2str(i),' roi_v1 time'])
    cd ..
    eval(['clear coeff_v1_cond',int2str(i)])
    clear tt
    eval(['clear cond',int2str(i),'n_dt_bl'])            
end


cd F:\Data\VSDI\Contour_integration\legolas\right_hemisphere\psychophysics\2008_11_25\f\correct_and_incorrect_together
load v1

time=26:36;
win=8;

for i=3 %condition count
    z=0;
    eval(['load cond',int2str(i),'n_dt_bl'])
    eval(['a=size(cond',int2str(i),'n_dt_bl,3);'])    
    b=size(time,2);
    eval(['coeff_v1_cond',int2str(i),'=NaN*ones(size(roi_v1,1),size(roi_v1,1),b);'])
    eval(['tt=NaN*ones(size(roi_v1,1),size(roi_v1,1),b);'])
    for p=1:size(roi_v1,1)
        z=z+1;
        disp(['pixel #',int2str(p),' condition #',int2str(i),' transforming data'])
        for h=1:a  %trial count
            
            %eval(['load cond',int2str(i),'n_dt_bl'])
            eval(['cond',int2str(i),'n_dt_tr=cond',int2str(i),'n_dt_bl(:,2:end,h);'])
            y=0;
                for j=time
                   y=y+1;
                   eval(['cc=sum((repmat(cond',int2str(i),'n_dt_tr(roi_v1(p),j:j+win-1),[size(roi_v1,1) 1])-repmat(mean(cond',int2str(i),'n_dt_tr(roi_v1(p),j:j+win-1),2),[size(roi_v1,1) win])).*(cond',int2str(i),'n_dt_tr(roi_v1,j:j+win-1)-repmat(mean(cond',int2str(i),'n_dt_tr(roi_v1,j:j+win-1),2),[1 win])),2)/(win-1);'])
                   eval(['var1=repmat(std(cond',int2str(i),'n_dt_tr(roi_v1(p),j:j+win-1),0,2).^2,[size(roi_v1,1) 1]);'])
                   eval(['var2=std(cond',int2str(i),'n_dt_tr(roi_v1,j:j+win-1),0,2).^2;'])
                   eval(['tt(:,p,y)=cc./sqrt(var1.*var2);']) 
                end;
            if h==1
                eval(['coeff_v1_cond',int2str(i),'=tt;'])
            else
                eval(['coeff_v1_cond',int2str(i),'=coeff_v1_cond',int2str(i),'+tt;'])
            end
        end;
    end;
    cd pixelwise
    eval(['coeff_v1_cond',int2str(i),'=coeff_v1_cond',int2str(i),'/a;'])
    eval(['save coeff_v1_cond',int2str(i),' coeff_v1_cond',int2str(i),' roi_v1 time'])
    cd ..
    eval(['clear coeff_v1_cond',int2str(i)])
    clear tt
    eval(['clear cond',int2str(i),'n_dt_bl'])            
end




cd F:\Data\VSDI\Contour_integration\legolas\right_hemisphere\psychophysics\2008_11_18\c\correct_and_incorrect_together
load v1


time=26:36;
win=8;

for i=3 %condition count
    z=0;
    eval(['load cond',int2str(i),'n_dt_bl'])
    eval(['a=size(cond',int2str(i),'n_dt_bl,3);'])    
    b=size(time,2);
    eval(['coeff_v1_cond',int2str(i),'=NaN*ones(size(roi_v1,1),size(roi_v1,1),b);'])
    eval(['tt=NaN*ones(size(roi_v1,1),size(roi_v1,1),b);'])
    for p=1:size(roi_v1,1)
        z=z+1;
        disp(['pixel #',int2str(p),' condition #',int2str(i),' transforming data'])
        for h=1:a  %trial count
            
            %eval(['load cond',int2str(i),'n_dt_bl'])
            eval(['cond',int2str(i),'n_dt_tr=cond',int2str(i),'n_dt_bl(:,2:end,h);'])
            y=0;
                for j=time
                   y=y+1;
                   eval(['cc=sum((repmat(cond',int2str(i),'n_dt_tr(roi_v1(p),j:j+win-1),[size(roi_v1,1) 1])-repmat(mean(cond',int2str(i),'n_dt_tr(roi_v1(p),j:j+win-1),2),[size(roi_v1,1) win])).*(cond',int2str(i),'n_dt_tr(roi_v1,j:j+win-1)-repmat(mean(cond',int2str(i),'n_dt_tr(roi_v1,j:j+win-1),2),[1 win])),2)/(win-1);'])
                   eval(['var1=repmat(std(cond',int2str(i),'n_dt_tr(roi_v1(p),j:j+win-1),0,2).^2,[size(roi_v1,1) 1]);'])
                   eval(['var2=std(cond',int2str(i),'n_dt_tr(roi_v1,j:j+win-1),0,2).^2;'])
                   eval(['tt(:,p,y)=cc./sqrt(var1.*var2);']) 
                end;
            if h==1
                eval(['coeff_v1_cond',int2str(i),'=tt;'])
            else
                eval(['coeff_v1_cond',int2str(i),'=coeff_v1_cond',int2str(i),'+tt;'])
            end
        end;
    end;
    cd pixelwise
    eval(['coeff_v1_cond',int2str(i),'=coeff_v1_cond',int2str(i),'/a;'])
    eval(['save coeff_v1_cond',int2str(i),' coeff_v1_cond',int2str(i),' roi_v1 time'])
    cd ..
    eval(['clear coeff_v1_cond',int2str(i)])
    clear tt
    eval(['clear cond',int2str(i),'n_dt_bl'])            
end


cd F:\Data\VSDI\Contour_integration\legolas\right_hemisphere\psychophysics\2008_11_18\d\correct_and_incorrect_together
load v1

time=26:36;
win=8;

for i=3 %condition count
    z=0;
    eval(['load cond',int2str(i),'n_dt_bl'])
    eval(['a=size(cond',int2str(i),'n_dt_bl,3);'])    
    b=size(time,2);
    eval(['coeff_v1_cond',int2str(i),'=NaN*ones(size(roi_v1,1),size(roi_v1,1),b);'])
    eval(['tt=NaN*ones(size(roi_v1,1),size(roi_v1,1),b);'])
    for p=1:size(roi_v1,1)
        z=z+1;
        disp(['pixel #',int2str(p),' condition #',int2str(i),' transforming data'])
        for h=1:a  %trial count
            
            %eval(['load cond',int2str(i),'n_dt_bl'])
            eval(['cond',int2str(i),'n_dt_tr=cond',int2str(i),'n_dt_bl(:,2:end,h);'])
            y=0;
                for j=time
                   y=y+1;
                   eval(['cc=sum((repmat(cond',int2str(i),'n_dt_tr(roi_v1(p),j:j+win-1),[size(roi_v1,1) 1])-repmat(mean(cond',int2str(i),'n_dt_tr(roi_v1(p),j:j+win-1),2),[size(roi_v1,1) win])).*(cond',int2str(i),'n_dt_tr(roi_v1,j:j+win-1)-repmat(mean(cond',int2str(i),'n_dt_tr(roi_v1,j:j+win-1),2),[1 win])),2)/(win-1);'])
                   eval(['var1=repmat(std(cond',int2str(i),'n_dt_tr(roi_v1(p),j:j+win-1),0,2).^2,[size(roi_v1,1) 1]);'])
                   eval(['var2=std(cond',int2str(i),'n_dt_tr(roi_v1,j:j+win-1),0,2).^2;'])
                   eval(['tt(:,p,y)=cc./sqrt(var1.*var2);']) 
                end;
            if h==1
                eval(['coeff_v1_cond',int2str(i),'=tt;'])
            else
                eval(['coeff_v1_cond',int2str(i),'=coeff_v1_cond',int2str(i),'+tt;'])
            end
        end;
    end;
    cd pixelwise
    eval(['coeff_v1_cond',int2str(i),'=coeff_v1_cond',int2str(i),'/a;'])
    eval(['save coeff_v1_cond',int2str(i),' coeff_v1_cond',int2str(i),' roi_v1 time'])
    cd ..
    eval(['clear coeff_v1_cond',int2str(i)])
    clear tt
    eval(['clear cond',int2str(i),'n_dt_bl'])            
end


cd F:\Data\VSDI\Contour_integration\legolas\right_hemisphere\psychophysics\2008_11_18\e\correct_and_incorrect_together
load v1

time=26:36;
win=8;

for i=3 %condition count
    z=0;
    eval(['load cond',int2str(i),'n_dt_bl'])
    eval(['a=size(cond',int2str(i),'n_dt_bl,3);'])    
    b=size(time,2);
    eval(['coeff_v1_cond',int2str(i),'=NaN*ones(size(roi_v1,1),size(roi_v1,1),b);'])
    eval(['tt=NaN*ones(size(roi_v1,1),size(roi_v1,1),b);'])
    for p=1:size(roi_v1,1)
        z=z+1;
        disp(['pixel #',int2str(p),' condition #',int2str(i),' transforming data'])
        for h=1:a  %trial count
            
            %eval(['load cond',int2str(i),'n_dt_bl'])
            eval(['cond',int2str(i),'n_dt_tr=cond',int2str(i),'n_dt_bl(:,2:end,h);'])
            y=0;
                for j=time
                   y=y+1;
                   eval(['cc=sum((repmat(cond',int2str(i),'n_dt_tr(roi_v1(p),j:j+win-1),[size(roi_v1,1) 1])-repmat(mean(cond',int2str(i),'n_dt_tr(roi_v1(p),j:j+win-1),2),[size(roi_v1,1) win])).*(cond',int2str(i),'n_dt_tr(roi_v1,j:j+win-1)-repmat(mean(cond',int2str(i),'n_dt_tr(roi_v1,j:j+win-1),2),[1 win])),2)/(win-1);'])
                   eval(['var1=repmat(std(cond',int2str(i),'n_dt_tr(roi_v1(p),j:j+win-1),0,2).^2,[size(roi_v1,1) 1]);'])
                   eval(['var2=std(cond',int2str(i),'n_dt_tr(roi_v1,j:j+win-1),0,2).^2;'])
                   eval(['tt(:,p,y)=cc./sqrt(var1.*var2);']) 
                end;
            if h==1
                eval(['coeff_v1_cond',int2str(i),'=tt;'])
            else
                eval(['coeff_v1_cond',int2str(i),'=coeff_v1_cond',int2str(i),'+tt;'])
            end
        end;
    end;
    cd pixelwise
    eval(['coeff_v1_cond',int2str(i),'=coeff_v1_cond',int2str(i),'/a;'])
    eval(['save coeff_v1_cond',int2str(i),' coeff_v1_cond',int2str(i),' roi_v1 time'])
    cd ..
    eval(['clear coeff_v1_cond',int2str(i)])
    clear tt
    eval(['clear cond',int2str(i),'n_dt_bl'])            
end



cd F:\Data\VSDI\Contour_integration\legolas\right_hemisphere\psychophysics\2008_12_03\d\correct_and_incorrect_together
load v1

time=26:36;
win=8;

for i=3 %condition count
    z=0;
    eval(['load cond',int2str(i),'n_dt_bl'])
    eval(['a=size(cond',int2str(i),'n_dt_bl,3);'])    
    b=size(time,2);
    eval(['coeff_v1_cond',int2str(i),'=NaN*ones(size(roi_v1,1),size(roi_v1,1),b);'])
    eval(['tt=NaN*ones(size(roi_v1,1),size(roi_v1,1),b);'])
    for p=1:size(roi_v1,1)
        z=z+1;
        disp(['pixel #',int2str(p),' condition #',int2str(i),' transforming data'])
        for h=1:a  %trial count
            
            %eval(['load cond',int2str(i),'n_dt_bl'])
            eval(['cond',int2str(i),'n_dt_tr=cond',int2str(i),'n_dt_bl(:,2:end,h);'])
            y=0;
                for j=time
                   y=y+1;
                   eval(['cc=sum((repmat(cond',int2str(i),'n_dt_tr(roi_v1(p),j:j+win-1),[size(roi_v1,1) 1])-repmat(mean(cond',int2str(i),'n_dt_tr(roi_v1(p),j:j+win-1),2),[size(roi_v1,1) win])).*(cond',int2str(i),'n_dt_tr(roi_v1,j:j+win-1)-repmat(mean(cond',int2str(i),'n_dt_tr(roi_v1,j:j+win-1),2),[1 win])),2)/(win-1);'])
                   eval(['var1=repmat(std(cond',int2str(i),'n_dt_tr(roi_v1(p),j:j+win-1),0,2).^2,[size(roi_v1,1) 1]);'])
                   eval(['var2=std(cond',int2str(i),'n_dt_tr(roi_v1,j:j+win-1),0,2).^2;'])
                   eval(['tt(:,p,y)=cc./sqrt(var1.*var2);']) 
                end;
            if h==1
                eval(['coeff_v1_cond',int2str(i),'=tt;'])
            else
                eval(['coeff_v1_cond',int2str(i),'=coeff_v1_cond',int2str(i),'+tt;'])
            end
        end;
    end;
    cd pixelwise
    eval(['coeff_v1_cond',int2str(i),'=coeff_v1_cond',int2str(i),'/a;'])
    eval(['save coeff_v1_cond',int2str(i),' coeff_v1_cond',int2str(i),' roi_v1 time'])
    cd ..
    eval(['clear coeff_v1_cond',int2str(i)])
    clear tt
    eval(['clear cond',int2str(i),'n_dt_bl'])            
end


cd F:\Data\VSDI\Contour_integration\legolas\right_hemisphere\psychophysics\2008_12_03\e\correct_and_incorrect_together
load v1


time=26:36;
win=8;

for i=3 %condition count
    z=0;
    eval(['load cond',int2str(i),'n_dt_bl'])
    eval(['a=size(cond',int2str(i),'n_dt_bl,3);'])    
    b=size(time,2);
    eval(['coeff_v1_cond',int2str(i),'=NaN*ones(size(roi_v1,1),size(roi_v1,1),b);'])
    eval(['tt=NaN*ones(size(roi_v1,1),size(roi_v1,1),b);'])
    for p=1:size(roi_v1,1)
        z=z+1;
        disp(['pixel #',int2str(p),' condition #',int2str(i),' transforming data'])
        for h=1:a  %trial count
            
            %eval(['load cond',int2str(i),'n_dt_bl'])
            eval(['cond',int2str(i),'n_dt_tr=cond',int2str(i),'n_dt_bl(:,2:end,h);'])
            y=0;
                for j=time
                   y=y+1;
                   eval(['cc=sum((repmat(cond',int2str(i),'n_dt_tr(roi_v1(p),j:j+win-1),[size(roi_v1,1) 1])-repmat(mean(cond',int2str(i),'n_dt_tr(roi_v1(p),j:j+win-1),2),[size(roi_v1,1) win])).*(cond',int2str(i),'n_dt_tr(roi_v1,j:j+win-1)-repmat(mean(cond',int2str(i),'n_dt_tr(roi_v1,j:j+win-1),2),[1 win])),2)/(win-1);'])
                   eval(['var1=repmat(std(cond',int2str(i),'n_dt_tr(roi_v1(p),j:j+win-1),0,2).^2,[size(roi_v1,1) 1]);'])
                   eval(['var2=std(cond',int2str(i),'n_dt_tr(roi_v1,j:j+win-1),0,2).^2;'])
                   eval(['tt(:,p,y)=cc./sqrt(var1.*var2);']) 
                end;
            if h==1
                eval(['coeff_v1_cond',int2str(i),'=tt;'])
            else
                eval(['coeff_v1_cond',int2str(i),'=coeff_v1_cond',int2str(i),'+tt;'])
            end
        end;
    end;
    cd pixelwise
    eval(['coeff_v1_cond',int2str(i),'=coeff_v1_cond',int2str(i),'/a;'])
    eval(['save coeff_v1_cond',int2str(i),' coeff_v1_cond',int2str(i),' roi_v1 time'])
    cd ..
    eval(['clear coeff_v1_cond',int2str(i)])
    clear tt
    eval(['clear cond',int2str(i),'n_dt_bl'])            
end


cd F:\Data\VSDI\Contour_integration\legolas\right_hemisphere\psychophysics\2008_12_03\f\correct_and_incorrect_together
load v1

time=26:36;
win=8;

for i=3 %condition count
    z=0;
    eval(['load cond',int2str(i),'n_dt_bl'])
    eval(['a=size(cond',int2str(i),'n_dt_bl,3);'])    
    b=size(time,2);
    eval(['coeff_v1_cond',int2str(i),'=NaN*ones(size(roi_v1,1),size(roi_v1,1),b);'])
    eval(['tt=NaN*ones(size(roi_v1,1),size(roi_v1,1),b);'])
    for p=1:size(roi_v1,1)
        z=z+1;
        disp(['pixel #',int2str(p),' condition #',int2str(i),' transforming data'])
        for h=1:a  %trial count
            
            %eval(['load cond',int2str(i),'n_dt_bl'])
            eval(['cond',int2str(i),'n_dt_tr=cond',int2str(i),'n_dt_bl(:,2:end,h);'])
            y=0;
                for j=time
                   y=y+1;
                   eval(['cc=sum((repmat(cond',int2str(i),'n_dt_tr(roi_v1(p),j:j+win-1),[size(roi_v1,1) 1])-repmat(mean(cond',int2str(i),'n_dt_tr(roi_v1(p),j:j+win-1),2),[size(roi_v1,1) win])).*(cond',int2str(i),'n_dt_tr(roi_v1,j:j+win-1)-repmat(mean(cond',int2str(i),'n_dt_tr(roi_v1,j:j+win-1),2),[1 win])),2)/(win-1);'])
                   eval(['var1=repmat(std(cond',int2str(i),'n_dt_tr(roi_v1(p),j:j+win-1),0,2).^2,[size(roi_v1,1) 1]);'])
                   eval(['var2=std(cond',int2str(i),'n_dt_tr(roi_v1,j:j+win-1),0,2).^2;'])
                   eval(['tt(:,p,y)=cc./sqrt(var1.*var2);']) 
                end;
            if h==1
                eval(['coeff_v1_cond',int2str(i),'=tt;'])
            else
                eval(['coeff_v1_cond',int2str(i),'=coeff_v1_cond',int2str(i),'+tt;'])
            end
        end;
    end;
    cd pixelwise
    eval(['coeff_v1_cond',int2str(i),'=coeff_v1_cond',int2str(i),'/a;'])
    eval(['save coeff_v1_cond',int2str(i),' coeff_v1_cond',int2str(i),' roi_v1 time'])
    cd ..
    eval(['clear coeff_v1_cond',int2str(i)])
    clear tt
    eval(['clear cond',int2str(i),'n_dt_bl'])            
end


cd F:\Data\VSDI\Contour_integration\legolas\right_hemisphere\06_10_2008\e
load v1

time=26:36;
win=8;

for i=3 %condition count
    z=0;
    eval(['load cond',int2str(i),'n_dt_bl'])
    eval(['a=size(cond',int2str(i),'n_dt_bl,3);'])    
    b=size(time,2);
    eval(['coeff_v1_cond',int2str(i),'=NaN*ones(size(roi_v1,1),size(roi_v1,1),b);'])
    eval(['tt=NaN*ones(size(roi_v1,1),size(roi_v1,1),b);'])
    for p=1:size(roi_v1,1)
        z=z+1;
        disp(['pixel #',int2str(p),' condition #',int2str(i),' transforming data'])
        for h=1:a  %trial count
            
            %eval(['load cond',int2str(i),'n_dt_bl'])
            eval(['cond',int2str(i),'n_dt_tr=cond',int2str(i),'n_dt_bl(:,2:end,h);'])
            y=0;
                for j=time
                   y=y+1;
                   eval(['cc=sum((repmat(cond',int2str(i),'n_dt_tr(roi_v1(p),j:j+win-1),[size(roi_v1,1) 1])-repmat(mean(cond',int2str(i),'n_dt_tr(roi_v1(p),j:j+win-1),2),[size(roi_v1,1) win])).*(cond',int2str(i),'n_dt_tr(roi_v1,j:j+win-1)-repmat(mean(cond',int2str(i),'n_dt_tr(roi_v1,j:j+win-1),2),[1 win])),2)/(win-1);'])
                   eval(['var1=repmat(std(cond',int2str(i),'n_dt_tr(roi_v1(p),j:j+win-1),0,2).^2,[size(roi_v1,1) 1]);'])
                   eval(['var2=std(cond',int2str(i),'n_dt_tr(roi_v1,j:j+win-1),0,2).^2;'])
                   eval(['tt(:,p,y)=cc./sqrt(var1.*var2);']) 
                end;
            if h==1
                eval(['coeff_v1_cond',int2str(i),'=tt;'])
            else
                eval(['coeff_v1_cond',int2str(i),'=coeff_v1_cond',int2str(i),'+tt;'])
            end
        end;
    end;
    cd pixelwise
    eval(['coeff_v1_cond',int2str(i),'=coeff_v1_cond',int2str(i),'/a;'])
    eval(['save coeff_v1_cond',int2str(i),' coeff_v1_cond',int2str(i),' roi_v1 time'])
    cd ..
    eval(['clear coeff_v1_cond',int2str(i)])
    clear tt
    eval(['clear cond',int2str(i),'n_dt_bl'])            
end

cd F:\Data\VSDI\Contour_integration\legolas\right_hemisphere\06_10_2008\f
load v1

time=26:36;
win=8;

for i=3 %condition count
    z=0;
    eval(['load cond',int2str(i),'n_dt_bl'])
    eval(['a=size(cond',int2str(i),'n_dt_bl,3);'])    
    b=size(time,2);
    eval(['coeff_v1_cond',int2str(i),'=NaN*ones(size(roi_v1,1),size(roi_v1,1),b);'])
    eval(['tt=NaN*ones(size(roi_v1,1),size(roi_v1,1),b);'])
    for p=1:size(roi_v1,1)
        z=z+1;
        disp(['pixel #',int2str(p),' condition #',int2str(i),' transforming data'])
        for h=1:a  %trial count
            
            %eval(['load cond',int2str(i),'n_dt_bl'])
            eval(['cond',int2str(i),'n_dt_tr=cond',int2str(i),'n_dt_bl(:,2:end,h);'])
            y=0;
                for j=time
                   y=y+1;
                   eval(['cc=sum((repmat(cond',int2str(i),'n_dt_tr(roi_v1(p),j:j+win-1),[size(roi_v1,1) 1])-repmat(mean(cond',int2str(i),'n_dt_tr(roi_v1(p),j:j+win-1),2),[size(roi_v1,1) win])).*(cond',int2str(i),'n_dt_tr(roi_v1,j:j+win-1)-repmat(mean(cond',int2str(i),'n_dt_tr(roi_v1,j:j+win-1),2),[1 win])),2)/(win-1);'])
                   eval(['var1=repmat(std(cond',int2str(i),'n_dt_tr(roi_v1(p),j:j+win-1),0,2).^2,[size(roi_v1,1) 1]);'])
                   eval(['var2=std(cond',int2str(i),'n_dt_tr(roi_v1,j:j+win-1),0,2).^2;'])
                   eval(['tt(:,p,y)=cc./sqrt(var1.*var2);']) 
                end;
            if h==1
                eval(['coeff_v1_cond',int2str(i),'=tt;'])
            else
                eval(['coeff_v1_cond',int2str(i),'=coeff_v1_cond',int2str(i),'+tt;'])
            end
        end;
    end;
    cd pixelwise
    eval(['coeff_v1_cond',int2str(i),'=coeff_v1_cond',int2str(i),'/a;'])
    eval(['save coeff_v1_cond',int2str(i),' coeff_v1_cond',int2str(i),' roi_v1 time'])
    cd ..
    eval(['clear coeff_v1_cond',int2str(i)])
    clear tt
    eval(['clear cond',int2str(i),'n_dt_bl'])            
end

cd F:\Data\VSDI\Contour_integration\legolas\right_hemisphere\22_10_2008\d
load v1

time=26:36;
win=8;

for i=3 %condition count
    z=0;
    eval(['load cond',int2str(i),'n_dt_bl'])
    eval(['a=size(cond',int2str(i),'n_dt_bl,3);'])    
    b=size(time,2);
    eval(['coeff_v1_cond',int2str(i),'=NaN*ones(size(roi_v1,1),size(roi_v1,1),b);'])
    eval(['tt=NaN*ones(size(roi_v1,1),size(roi_v1,1),b);'])
    for p=1:size(roi_v1,1)
        z=z+1;
        disp(['pixel #',int2str(p),' condition #',int2str(i),' transforming data'])
        for h=1:a  %trial count
            
            %eval(['load cond',int2str(i),'n_dt_bl'])
            eval(['cond',int2str(i),'n_dt_tr=cond',int2str(i),'n_dt_bl(:,2:end,h);'])
            y=0;
                for j=time
                   y=y+1;
                   eval(['cc=sum((repmat(cond',int2str(i),'n_dt_tr(roi_v1(p),j:j+win-1),[size(roi_v1,1) 1])-repmat(mean(cond',int2str(i),'n_dt_tr(roi_v1(p),j:j+win-1),2),[size(roi_v1,1) win])).*(cond',int2str(i),'n_dt_tr(roi_v1,j:j+win-1)-repmat(mean(cond',int2str(i),'n_dt_tr(roi_v1,j:j+win-1),2),[1 win])),2)/(win-1);'])
                   eval(['var1=repmat(std(cond',int2str(i),'n_dt_tr(roi_v1(p),j:j+win-1),0,2).^2,[size(roi_v1,1) 1]);'])
                   eval(['var2=std(cond',int2str(i),'n_dt_tr(roi_v1,j:j+win-1),0,2).^2;'])
                   eval(['tt(:,p,y)=cc./sqrt(var1.*var2);']) 
                end;
            if h==1
                eval(['coeff_v1_cond',int2str(i),'=tt;'])
            else
                eval(['coeff_v1_cond',int2str(i),'=coeff_v1_cond',int2str(i),'+tt;'])
            end
        end;
    end;
    cd pixelwise
    eval(['coeff_v1_cond',int2str(i),'=coeff_v1_cond',int2str(i),'/a;'])
    eval(['save coeff_v1_cond',int2str(i),' coeff_v1_cond',int2str(i),' roi_v1 time'])
    cd ..
    eval(['clear coeff_v1_cond',int2str(i)])
    clear tt
    eval(['clear cond',int2str(i),'n_dt_bl'])            
end

cd F:\Data\VSDI\Contour_integration\legolas\right_hemisphere\22_10_2008\e
load v1

time=26:36;
win=8;

for i=3 %condition count
    z=0;
    eval(['load cond',int2str(i),'n_dt_bl'])
    eval(['a=size(cond',int2str(i),'n_dt_bl,3);'])    
    b=size(time,2);
    eval(['coeff_v1_cond',int2str(i),'=NaN*ones(size(roi_v1,1),size(roi_v1,1),b);'])
    eval(['tt=NaN*ones(size(roi_v1,1),size(roi_v1,1),b);'])
    for p=1:size(roi_v1,1)
        z=z+1;
        disp(['pixel #',int2str(p),' condition #',int2str(i),' transforming data'])
        for h=1:a  %trial count
            
            %eval(['load cond',int2str(i),'n_dt_bl'])
            eval(['cond',int2str(i),'n_dt_tr=cond',int2str(i),'n_dt_bl(:,2:end,h);'])
            y=0;
                for j=time
                   y=y+1;
                   eval(['cc=sum((repmat(cond',int2str(i),'n_dt_tr(roi_v1(p),j:j+win-1),[size(roi_v1,1) 1])-repmat(mean(cond',int2str(i),'n_dt_tr(roi_v1(p),j:j+win-1),2),[size(roi_v1,1) win])).*(cond',int2str(i),'n_dt_tr(roi_v1,j:j+win-1)-repmat(mean(cond',int2str(i),'n_dt_tr(roi_v1,j:j+win-1),2),[1 win])),2)/(win-1);'])
                   eval(['var1=repmat(std(cond',int2str(i),'n_dt_tr(roi_v1(p),j:j+win-1),0,2).^2,[size(roi_v1,1) 1]);'])
                   eval(['var2=std(cond',int2str(i),'n_dt_tr(roi_v1,j:j+win-1),0,2).^2;'])
                   eval(['tt(:,p,y)=cc./sqrt(var1.*var2);']) 
                end;
            if h==1
                eval(['coeff_v1_cond',int2str(i),'=tt;'])
            else
                eval(['coeff_v1_cond',int2str(i),'=coeff_v1_cond',int2str(i),'+tt;'])
            end
        end;
    end;
    cd pixelwise
    eval(['coeff_v1_cond',int2str(i),'=coeff_v1_cond',int2str(i),'/a;'])
    eval(['save coeff_v1_cond',int2str(i),' coeff_v1_cond',int2str(i),' roi_v1 time'])
    cd ..
    eval(['clear coeff_v1_cond',int2str(i)])
    clear tt
    eval(['clear cond',int2str(i),'n_dt_bl'])            
end












