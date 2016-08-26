
cd F:\Data\VSDI\Contour_integration\legolas\right_hemisphere\psychophysics\2008_11_25\d\correct_and_incorrect_together

load pixels_to_remove
t=ones(10000,1);
t(pixels_to_remove)=0;
pixels=find(t);
clear t


load myrois


win=8;

for i=[1 5] %condition count
    z=0;
    eval(['load cond',int2str(i),'n_dt_bl'])
    eval(['a=size(cond',int2str(i),'n_dt_bl,3);'])
    sh=randperm(a);
    eval(['b=size(cond',int2str(i),'n_dt_bl,2)/2;'])
    for p=1:size(roi_circle_diff,1)
        z=z+1;
        eval(['coeff_circle_diff_cond',int2str(i),'_pix_',int2str(roi_circle_diff(p)),'=NaN*ones(size(pixels,1),b-win,a);'])
        for h=1:a  %trial count
            
            
            disp(['pixel #',int2str(p),' condition #',int2str(i),' trial #',int2str(h),' transforming data'])
            %eval(['load cond',int2str(i),'n_dt_bl'])
            eval(['cond',int2str(i),'n_dt_tr1=cond',int2str(i),'n_dt_bl(:,2:end,h);'])
            eval(['cond',int2str(i),'n_dt_tr2=cond',int2str(i),'n_dt_bl(:,2:end,sh(h));'])
                for j=1:(b-win)
                   eval(['cc=sum((repmat(cond',int2str(i),'n_dt_tr1(roi_circle_diff(p),j:j+win-1),[size(pixels,1) 1])-repmat(mean(cond',int2str(i),'n_dt_tr1(roi_circle_diff(p),j:j+win-1),2),[size(pixels,1) win])).*(cond',int2str(i),'n_dt_tr2(pixels,j:j+win-1)-repmat(mean(cond',int2str(i),'n_dt_tr2(pixels,j:j+win-1),2),[1 win])),2)/(win-1);'])
                   eval(['var1=repmat(std(cond',int2str(i),'n_dt_tr1(roi_circle_diff(p),j:j+win-1),0,2).^2,[size(pixels,1) 1]);'])
                   eval(['var2=std(cond',int2str(i),'n_dt_tr2(pixels,j:j+win-1),0,2).^2;'])
                   eval(['coeff_circle_diff_cond',int2str(i),'_pix_',int2str(roi_circle_diff(p)),'(:,j,h)=cc./sqrt(var1.*var2);']) 
                end;
            
        end;
        if z==1
            eval(['coeff_circle_diff_cond',int2str(i),'=coeff_circle_diff_cond',int2str(i),'_pix_',int2str(roi_circle_diff(p)),';'])    
        else
            eval(['coeff_circle_diff_cond',int2str(i),'=coeff_circle_diff_cond',int2str(i),'+coeff_circle_diff_cond',int2str(i),'_pix_',int2str(roi_circle_diff(p)),';'])
        end 
        eval(['clear coeff_circle_diff_cond',int2str(i),'_pix_',int2str(roi_circle_diff(p))])
    end;
    eval(['coeff_circle_diff_cond',int2str(i),'=coeff_circle_diff_cond',int2str(i),'/size(roi_circle_diff,1);'])
    cd pixels_SHUFFLE
    eval(['save coeff_circle_diff_cond',int2str(i),' coeff_circle_diff_cond',int2str(i),' roi_circle_diff pixels sh'])
    cd ..
    eval(['clear coeff_circle_diff_cond',int2str(i)])
    eval(['clear cond',int2str(i),'n_dt_bl'])            
end


for i=[1 5] %condition count
    z=0;
    eval(['load cond',int2str(i),'n_dt_bl'])
    eval(['a=size(cond',int2str(i),'n_dt_bl,3);'])
    sh=randperm(a);
    eval(['b=size(cond',int2str(i),'n_dt_bl,2)/2;'])
    for p=1:size(roi_bg_in,1)
        z=z+1;
        eval(['coeff_bg_in_cond',int2str(i),'_pix_',int2str(roi_bg_in(p)),'=NaN*ones(size(pixels,1),b-win,a);'])
        for h=1:a  %trial count
            
            
            disp(['pixel #',int2str(p),' condition #',int2str(i),' trial #',int2str(h),' transforming data'])
            %eval(['load cond',int2str(i),'n_dt_bl'])
            eval(['cond',int2str(i),'n_dt_tr1=cond',int2str(i),'n_dt_bl(:,2:end,h);'])
            eval(['cond',int2str(i),'n_dt_tr2=cond',int2str(i),'n_dt_bl(:,2:end,sh(h));'])
                for j=1:(b-win)
                   eval(['cc=sum((repmat(cond',int2str(i),'n_dt_tr1(roi_bg_in(p),j:j+win-1),[size(pixels,1) 1])-repmat(mean(cond',int2str(i),'n_dt_tr1(roi_bg_in(p),j:j+win-1),2),[size(pixels,1) win])).*(cond',int2str(i),'n_dt_tr2(pixels,j:j+win-1)-repmat(mean(cond',int2str(i),'n_dt_tr2(pixels,j:j+win-1),2),[1 win])),2)/(win-1);'])
                   eval(['var1=repmat(std(cond',int2str(i),'n_dt_tr1(roi_bg_in(p),j:j+win-1),0,2).^2,[size(pixels,1) 1]);'])
                   eval(['var2=std(cond',int2str(i),'n_dt_tr2(pixels,j:j+win-1),0,2).^2;'])
                   eval(['coeff_bg_in_cond',int2str(i),'_pix_',int2str(roi_bg_in(p)),'(:,j,h)=cc./sqrt(var1.*var2);']) 
                end;
            
        end;
        if z==1
            eval(['coeff_bg_in_cond',int2str(i),'=coeff_bg_in_cond',int2str(i),'_pix_',int2str(roi_bg_in(p)),';'])    
        else
            eval(['coeff_bg_in_cond',int2str(i),'=coeff_bg_in_cond',int2str(i),'+coeff_bg_in_cond',int2str(i),'_pix_',int2str(roi_bg_in(p)),';'])
        end 
        eval(['clear coeff_bg_in_cond',int2str(i),'_pix_',int2str(roi_bg_in(p))])
    end;
    eval(['coeff_bg_in_cond',int2str(i),'=coeff_bg_in_cond',int2str(i),'/size(roi_bg_in,1);'])
    cd pixels_SHUFFLE
    eval(['save coeff_bg_in_cond',int2str(i),' coeff_bg_in_cond',int2str(i),' roi_bg_in pixels sh'])
    cd ..
    eval(['clear coeff_bg_in_cond',int2str(i)])
    eval(['clear cond',int2str(i),'n_dt_bl'])            
end


cd F:\Data\VSDI\Contour_integration\Smeagol\29Dec2010\c
load pixels_to_remove
t=ones(10000,1);
t(pixels_to_remove)=0;
pixels=find(t);
clear t

load myrois


win=8;

for i=[1 2 4 5] %condition count
    z=0;
    eval(['load cond',int2str(i),'n_dt_bl'])
    eval(['a=size(cond',int2str(i),'n_dt_bl,3);'])
    sh=randperm(a);
    eval(['b=size(cond',int2str(i),'n_dt_bl,2)/2;'])
    for p=1:size(roi_circle,1)
        z=z+1;
        eval(['coeff_circle_cond',int2str(i),'_pix_',int2str(roi_circle(p)),'=NaN*ones(size(pixels,1),b-win,a);'])
        for h=1:a  %trial count
            
            
            disp(['pixel #',int2str(p),' condition #',int2str(i),' trial #',int2str(h),' transforming data'])
            %eval(['load cond',int2str(i),'n_dt_bl'])
            eval(['cond',int2str(i),'n_dt_tr1=cond',int2str(i),'n_dt_bl(:,2:end,h);'])
            eval(['cond',int2str(i),'n_dt_tr2=cond',int2str(i),'n_dt_bl(:,2:end,sh(h));'])
                for j=1:(b-win)
                   eval(['cc=sum((repmat(cond',int2str(i),'n_dt_tr1(roi_circle(p),j:j+win-1),[size(pixels,1) 1])-repmat(mean(cond',int2str(i),'n_dt_tr1(roi_circle(p),j:j+win-1),2),[size(pixels,1) win])).*(cond',int2str(i),'n_dt_tr2(pixels,j:j+win-1)-repmat(mean(cond',int2str(i),'n_dt_tr2(pixels,j:j+win-1),2),[1 win])),2)/(win-1);'])
                   eval(['var1=repmat(std(cond',int2str(i),'n_dt_tr1(roi_circle(p),j:j+win-1),0,2).^2,[size(pixels,1) 1]);'])
                   eval(['var2=std(cond',int2str(i),'n_dt_tr2(pixels,j:j+win-1),0,2).^2;'])
                   eval(['coeff_circle_cond',int2str(i),'_pix_',int2str(roi_circle(p)),'(:,j,h)=cc./sqrt(var1.*var2);']) 
                end;
            
        end;
        if z==1
            eval(['coeff_circle_cond',int2str(i),'=coeff_circle_cond',int2str(i),'_pix_',int2str(roi_circle(p)),';'])    
        else
            eval(['coeff_circle_cond',int2str(i),'=coeff_circle_cond',int2str(i),'+coeff_circle_cond',int2str(i),'_pix_',int2str(roi_circle(p)),';'])
        end 
        eval(['clear coeff_circle_cond',int2str(i),'_pix_',int2str(roi_circle(p))])
    end;
    eval(['coeff_circle_cond',int2str(i),'=coeff_circle_cond',int2str(i),'/size(roi_circle,1);'])
    cd pixels_SHUFFLE
    eval(['save coeff_circle_cond',int2str(i),' coeff_circle_cond',int2str(i),' roi_circle pixels sh'])
    cd ..
    eval(['clear coeff_circle_cond',int2str(i)])
    eval(['clear cond',int2str(i),'n_dt_bl'])            
end


for i=[1 2 4 5] %condition count
    z=0;
    eval(['load cond',int2str(i),'n_dt_bl'])
    eval(['a=size(cond',int2str(i),'n_dt_bl,3);'])
    sh=randperm(a);
    eval(['b=size(cond',int2str(i),'n_dt_bl,2)/2;'])
    for p=1:size(roi_bg_out,1)
        z=z+1;
        eval(['coeff_bg_out_cond',int2str(i),'_pix_',int2str(roi_bg_out(p)),'=NaN*ones(size(pixels,1),b-win,a);'])
        for h=1:a  %trial count
            
            
            disp(['pixel #',int2str(p),' condition #',int2str(i),' trial #',int2str(h),' transforming data'])
            %eval(['load cond',int2str(i),'n_dt_bl'])
            eval(['cond',int2str(i),'n_dt_tr1=cond',int2str(i),'n_dt_bl(:,2:end,h);'])
            eval(['cond',int2str(i),'n_dt_tr2=cond',int2str(i),'n_dt_bl(:,2:end,sh(h));'])
                for j=1:(b-win)
                   eval(['cc=sum((repmat(cond',int2str(i),'n_dt_tr1(roi_bg_out(p),j:j+win-1),[size(pixels,1) 1])-repmat(mean(cond',int2str(i),'n_dt_tr1(roi_bg_out(p),j:j+win-1),2),[size(pixels,1) win])).*(cond',int2str(i),'n_dt_tr2(pixels,j:j+win-1)-repmat(mean(cond',int2str(i),'n_dt_tr2(pixels,j:j+win-1),2),[1 win])),2)/(win-1);'])
                   eval(['var1=repmat(std(cond',int2str(i),'n_dt_tr1(roi_bg_out(p),j:j+win-1),0,2).^2,[size(pixels,1) 1]);'])
                   eval(['var2=std(cond',int2str(i),'n_dt_tr2(pixels,j:j+win-1),0,2).^2;'])
                   eval(['coeff_bg_out_cond',int2str(i),'_pix_',int2str(roi_bg_out(p)),'(:,j,h)=cc./sqrt(var1.*var2);']) 
                end;
            
        end;
        if z==1
            eval(['coeff_bg_out_cond',int2str(i),'=coeff_bg_out_cond',int2str(i),'_pix_',int2str(roi_bg_out(p)),';'])    
        else
            eval(['coeff_bg_out_cond',int2str(i),'=coeff_bg_out_cond',int2str(i),'+coeff_bg_out_cond',int2str(i),'_pix_',int2str(roi_bg_out(p)),';'])
        end 
        eval(['clear coeff_bg_out_cond',int2str(i),'_pix_',int2str(roi_bg_out(p))])
    end;
    eval(['coeff_bg_out_cond',int2str(i),'=coeff_bg_out_cond',int2str(i),'/size(roi_bg_out,1);'])
    cd pixels_SHUFFLE
    eval(['save coeff_bg_out_cond',int2str(i),' coeff_bg_out_cond',int2str(i),' roi_bg_out pixels sh'])
    cd ..
    eval(['clear coeff_bg_out_cond',int2str(i)])
    eval(['clear cond',int2str(i),'n_dt_bl'])            
end


cd F:\Data\VSDI\Contour_integration\Smeagol\29Dec2010\e
load pixels_to_remove
t=ones(10000,1);
t(pixels_to_remove)=0;
pixels=find(t);
clear t

load myrois


win=8;

for i=[1 2 4 5] %condition count
    z=0;
    eval(['load cond',int2str(i),'n_dt_bl'])
    eval(['a=size(cond',int2str(i),'n_dt_bl,3);'])
    sh=randperm(a);
    eval(['b=size(cond',int2str(i),'n_dt_bl,2)/2;'])
    for p=1:size(roi_circle,1)
        z=z+1;
        eval(['coeff_circle_cond',int2str(i),'_pix_',int2str(roi_circle(p)),'=NaN*ones(size(pixels,1),b-win,a);'])
        for h=1:a  %trial count
            
            
            disp(['pixel #',int2str(p),' condition #',int2str(i),' trial #',int2str(h),' transforming data'])
            %eval(['load cond',int2str(i),'n_dt_bl'])
            eval(['cond',int2str(i),'n_dt_tr1=cond',int2str(i),'n_dt_bl(:,2:end,h);'])
            eval(['cond',int2str(i),'n_dt_tr2=cond',int2str(i),'n_dt_bl(:,2:end,sh(h));'])
                for j=1:(b-win)
                   eval(['cc=sum((repmat(cond',int2str(i),'n_dt_tr1(roi_circle(p),j:j+win-1),[size(pixels,1) 1])-repmat(mean(cond',int2str(i),'n_dt_tr1(roi_circle(p),j:j+win-1),2),[size(pixels,1) win])).*(cond',int2str(i),'n_dt_tr2(pixels,j:j+win-1)-repmat(mean(cond',int2str(i),'n_dt_tr2(pixels,j:j+win-1),2),[1 win])),2)/(win-1);'])
                   eval(['var1=repmat(std(cond',int2str(i),'n_dt_tr1(roi_circle(p),j:j+win-1),0,2).^2,[size(pixels,1) 1]);'])
                   eval(['var2=std(cond',int2str(i),'n_dt_tr2(pixels,j:j+win-1),0,2).^2;'])
                   eval(['coeff_circle_cond',int2str(i),'_pix_',int2str(roi_circle(p)),'(:,j,h)=cc./sqrt(var1.*var2);']) 
                end;
            
        end;
        if z==1
            eval(['coeff_circle_cond',int2str(i),'=coeff_circle_cond',int2str(i),'_pix_',int2str(roi_circle(p)),';'])    
        else
            eval(['coeff_circle_cond',int2str(i),'=coeff_circle_cond',int2str(i),'+coeff_circle_cond',int2str(i),'_pix_',int2str(roi_circle(p)),';'])
        end 
        eval(['clear coeff_circle_cond',int2str(i),'_pix_',int2str(roi_circle(p))])
    end;
    eval(['coeff_circle_cond',int2str(i),'=coeff_circle_cond',int2str(i),'/size(roi_circle,1);'])
    cd pixels_SHUFFLE
    eval(['save coeff_circle_cond',int2str(i),' coeff_circle_cond',int2str(i),' roi_circle pixels sh'])
    cd ..
    eval(['clear coeff_circle_cond',int2str(i)])
    eval(['clear cond',int2str(i),'n_dt_bl'])            
end


for i=[1 2 4 5] %condition count
    z=0;
    eval(['load cond',int2str(i),'n_dt_bl'])
    eval(['a=size(cond',int2str(i),'n_dt_bl,3);'])
    sh=randperm(a);
    eval(['b=size(cond',int2str(i),'n_dt_bl,2)/2;'])
    for p=1:size(roi_bg_out,1)
        z=z+1;
        eval(['coeff_bg_out_cond',int2str(i),'_pix_',int2str(roi_bg_out(p)),'=NaN*ones(size(pixels,1),b-win,a);'])
        for h=1:a  %trial count
            
            
            disp(['pixel #',int2str(p),' condition #',int2str(i),' trial #',int2str(h),' transforming data'])
            %eval(['load cond',int2str(i),'n_dt_bl'])
            eval(['cond',int2str(i),'n_dt_tr1=cond',int2str(i),'n_dt_bl(:,2:end,h);'])
            eval(['cond',int2str(i),'n_dt_tr2=cond',int2str(i),'n_dt_bl(:,2:end,sh(h));'])
                for j=1:(b-win)
                   eval(['cc=sum((repmat(cond',int2str(i),'n_dt_tr1(roi_bg_out(p),j:j+win-1),[size(pixels,1) 1])-repmat(mean(cond',int2str(i),'n_dt_tr1(roi_bg_out(p),j:j+win-1),2),[size(pixels,1) win])).*(cond',int2str(i),'n_dt_tr2(pixels,j:j+win-1)-repmat(mean(cond',int2str(i),'n_dt_tr2(pixels,j:j+win-1),2),[1 win])),2)/(win-1);'])
                   eval(['var1=repmat(std(cond',int2str(i),'n_dt_tr1(roi_bg_out(p),j:j+win-1),0,2).^2,[size(pixels,1) 1]);'])
                   eval(['var2=std(cond',int2str(i),'n_dt_tr2(pixels,j:j+win-1),0,2).^2;'])
                   eval(['coeff_bg_out_cond',int2str(i),'_pix_',int2str(roi_bg_out(p)),'(:,j,h)=cc./sqrt(var1.*var2);']) 
                end;
            
        end;
        if z==1
            eval(['coeff_bg_out_cond',int2str(i),'=coeff_bg_out_cond',int2str(i),'_pix_',int2str(roi_bg_out(p)),';'])    
        else
            eval(['coeff_bg_out_cond',int2str(i),'=coeff_bg_out_cond',int2str(i),'+coeff_bg_out_cond',int2str(i),'_pix_',int2str(roi_bg_out(p)),';'])
        end 
        eval(['clear coeff_bg_out_cond',int2str(i),'_pix_',int2str(roi_bg_out(p))])
    end;
    eval(['coeff_bg_out_cond',int2str(i),'=coeff_bg_out_cond',int2str(i),'/size(roi_bg_out,1);'])
    cd pixels_SHUFFLE
    eval(['save coeff_bg_out_cond',int2str(i),' coeff_bg_out_cond',int2str(i),' roi_bg_out pixels sh'])
    cd ..
    eval(['clear coeff_bg_out_cond',int2str(i)])
    eval(['clear cond',int2str(i),'n_dt_bl'])            
end




cd F:\Data\VSDI\Contour_integration\legolas\right_hemisphere\psychophysics\2008_11_25\e\correct_and_incorrect_together

load pixels_to_remove
t=ones(10000,1);
t(pixels_to_remove)=0;
pixels=find(t);
clear t


load myrois


win=8;

for i=[1 5] %condition count
    z=0;
    eval(['load cond',int2str(i),'n_dt_bl'])
    eval(['a=size(cond',int2str(i),'n_dt_bl,3);'])
    sh=randperm(a);
    eval(['b=size(cond',int2str(i),'n_dt_bl,2)/2;'])
    for p=1:size(roi_circle_diff,1)
        z=z+1;
        eval(['coeff_circle_diff_cond',int2str(i),'_pix_',int2str(roi_circle_diff(p)),'=NaN*ones(size(pixels,1),b-win,a);'])
        for h=1:a  %trial count
            
            
            disp(['pixel #',int2str(p),' condition #',int2str(i),' trial #',int2str(h),' transforming data'])
            %eval(['load cond',int2str(i),'n_dt_bl'])
            eval(['cond',int2str(i),'n_dt_tr1=cond',int2str(i),'n_dt_bl(:,2:end,h);'])
            eval(['cond',int2str(i),'n_dt_tr2=cond',int2str(i),'n_dt_bl(:,2:end,sh(h));'])
                for j=1:(b-win)
                   eval(['cc=sum((repmat(cond',int2str(i),'n_dt_tr1(roi_circle_diff(p),j:j+win-1),[size(pixels,1) 1])-repmat(mean(cond',int2str(i),'n_dt_tr1(roi_circle_diff(p),j:j+win-1),2),[size(pixels,1) win])).*(cond',int2str(i),'n_dt_tr2(pixels,j:j+win-1)-repmat(mean(cond',int2str(i),'n_dt_tr2(pixels,j:j+win-1),2),[1 win])),2)/(win-1);'])
                   eval(['var1=repmat(std(cond',int2str(i),'n_dt_tr1(roi_circle_diff(p),j:j+win-1),0,2).^2,[size(pixels,1) 1]);'])
                   eval(['var2=std(cond',int2str(i),'n_dt_tr2(pixels,j:j+win-1),0,2).^2;'])
                   eval(['coeff_circle_diff_cond',int2str(i),'_pix_',int2str(roi_circle_diff(p)),'(:,j,h)=cc./sqrt(var1.*var2);']) 
                end;
            
        end;
        if z==1
            eval(['coeff_circle_diff_cond',int2str(i),'=coeff_circle_diff_cond',int2str(i),'_pix_',int2str(roi_circle_diff(p)),';'])    
        else
            eval(['coeff_circle_diff_cond',int2str(i),'=coeff_circle_diff_cond',int2str(i),'+coeff_circle_diff_cond',int2str(i),'_pix_',int2str(roi_circle_diff(p)),';'])
        end 
        eval(['clear coeff_circle_diff_cond',int2str(i),'_pix_',int2str(roi_circle_diff(p))])
    end;
    eval(['coeff_circle_diff_cond',int2str(i),'=coeff_circle_diff_cond',int2str(i),'/size(roi_circle_diff,1);'])
    cd pixels_SHUFFLE
    eval(['save coeff_circle_diff_cond',int2str(i),' coeff_circle_diff_cond',int2str(i),' roi_circle_diff pixels sh'])
    cd ..
    eval(['clear coeff_circle_diff_cond',int2str(i)])
    eval(['clear cond',int2str(i),'n_dt_bl'])            
end


for i=[1 5] %condition count
    z=0;
    eval(['load cond',int2str(i),'n_dt_bl'])
    eval(['a=size(cond',int2str(i),'n_dt_bl,3);'])
    sh=randperm(a);
    eval(['b=size(cond',int2str(i),'n_dt_bl,2)/2;'])
    for p=1:size(roi_bg_in,1)
        z=z+1;
        eval(['coeff_bg_in_cond',int2str(i),'_pix_',int2str(roi_bg_in(p)),'=NaN*ones(size(pixels,1),b-win,a);'])
        for h=1:a  %trial count
            
            
            disp(['pixel #',int2str(p),' condition #',int2str(i),' trial #',int2str(h),' transforming data'])
            %eval(['load cond',int2str(i),'n_dt_bl'])
            eval(['cond',int2str(i),'n_dt_tr1=cond',int2str(i),'n_dt_bl(:,2:end,h);'])
            eval(['cond',int2str(i),'n_dt_tr2=cond',int2str(i),'n_dt_bl(:,2:end,sh(h));'])
                for j=1:(b-win)
                   eval(['cc=sum((repmat(cond',int2str(i),'n_dt_tr1(roi_bg_in(p),j:j+win-1),[size(pixels,1) 1])-repmat(mean(cond',int2str(i),'n_dt_tr1(roi_bg_in(p),j:j+win-1),2),[size(pixels,1) win])).*(cond',int2str(i),'n_dt_tr2(pixels,j:j+win-1)-repmat(mean(cond',int2str(i),'n_dt_tr2(pixels,j:j+win-1),2),[1 win])),2)/(win-1);'])
                   eval(['var1=repmat(std(cond',int2str(i),'n_dt_tr1(roi_bg_in(p),j:j+win-1),0,2).^2,[size(pixels,1) 1]);'])
                   eval(['var2=std(cond',int2str(i),'n_dt_tr2(pixels,j:j+win-1),0,2).^2;'])
                   eval(['coeff_bg_in_cond',int2str(i),'_pix_',int2str(roi_bg_in(p)),'(:,j,h)=cc./sqrt(var1.*var2);']) 
                end;
            
        end;
        if z==1
            eval(['coeff_bg_in_cond',int2str(i),'=coeff_bg_in_cond',int2str(i),'_pix_',int2str(roi_bg_in(p)),';'])    
        else
            eval(['coeff_bg_in_cond',int2str(i),'=coeff_bg_in_cond',int2str(i),'+coeff_bg_in_cond',int2str(i),'_pix_',int2str(roi_bg_in(p)),';'])
        end 
        eval(['clear coeff_bg_in_cond',int2str(i),'_pix_',int2str(roi_bg_in(p))])
    end;
    eval(['coeff_bg_in_cond',int2str(i),'=coeff_bg_in_cond',int2str(i),'/size(roi_bg_in,1);'])
    cd pixels_SHUFFLE
    eval(['save coeff_bg_in_cond',int2str(i),' coeff_bg_in_cond',int2str(i),' roi_bg_in pixels sh'])
    cd ..
    eval(['clear coeff_bg_in_cond',int2str(i)])
    eval(['clear cond',int2str(i),'n_dt_bl'])            
end



cd F:\Data\VSDI\Contour_integration\legolas\right_hemisphere\psychophysics\2008_11_25\f\correct_and_incorrect_together

load pixels_to_remove
t=ones(10000,1);
t(pixels_to_remove)=0;
pixels=find(t);
clear t


load myrois


win=8;

for i=[1 5] %condition count
    z=0;
    eval(['load cond',int2str(i),'n_dt_bl'])
    eval(['a=size(cond',int2str(i),'n_dt_bl,3);'])
    sh=randperm(a);
    eval(['b=size(cond',int2str(i),'n_dt_bl,2)/2;'])
    for p=1:size(roi_circle_diff,1)
        z=z+1;
        eval(['coeff_circle_diff_cond',int2str(i),'_pix_',int2str(roi_circle_diff(p)),'=NaN*ones(size(pixels,1),b-win,a);'])
        for h=1:a  %trial count
            
            
            disp(['pixel #',int2str(p),' condition #',int2str(i),' trial #',int2str(h),' transforming data'])
            %eval(['load cond',int2str(i),'n_dt_bl'])
            eval(['cond',int2str(i),'n_dt_tr1=cond',int2str(i),'n_dt_bl(:,2:end,h);'])
            eval(['cond',int2str(i),'n_dt_tr2=cond',int2str(i),'n_dt_bl(:,2:end,sh(h));'])
                for j=1:(b-win)
                   eval(['cc=sum((repmat(cond',int2str(i),'n_dt_tr1(roi_circle_diff(p),j:j+win-1),[size(pixels,1) 1])-repmat(mean(cond',int2str(i),'n_dt_tr1(roi_circle_diff(p),j:j+win-1),2),[size(pixels,1) win])).*(cond',int2str(i),'n_dt_tr2(pixels,j:j+win-1)-repmat(mean(cond',int2str(i),'n_dt_tr2(pixels,j:j+win-1),2),[1 win])),2)/(win-1);'])
                   eval(['var1=repmat(std(cond',int2str(i),'n_dt_tr1(roi_circle_diff(p),j:j+win-1),0,2).^2,[size(pixels,1) 1]);'])
                   eval(['var2=std(cond',int2str(i),'n_dt_tr2(pixels,j:j+win-1),0,2).^2;'])
                   eval(['coeff_circle_diff_cond',int2str(i),'_pix_',int2str(roi_circle_diff(p)),'(:,j,h)=cc./sqrt(var1.*var2);']) 
                end;
            
        end;
        if z==1
            eval(['coeff_circle_diff_cond',int2str(i),'=coeff_circle_diff_cond',int2str(i),'_pix_',int2str(roi_circle_diff(p)),';'])    
        else
            eval(['coeff_circle_diff_cond',int2str(i),'=coeff_circle_diff_cond',int2str(i),'+coeff_circle_diff_cond',int2str(i),'_pix_',int2str(roi_circle_diff(p)),';'])
        end 
        eval(['clear coeff_circle_diff_cond',int2str(i),'_pix_',int2str(roi_circle_diff(p))])
    end;
    eval(['coeff_circle_diff_cond',int2str(i),'=coeff_circle_diff_cond',int2str(i),'/size(roi_circle_diff,1);'])
    cd pixels_SHUFFLE
    eval(['save coeff_circle_diff_cond',int2str(i),' coeff_circle_diff_cond',int2str(i),' roi_circle_diff pixels sh'])
    cd ..
    eval(['clear coeff_circle_diff_cond',int2str(i)])
    eval(['clear cond',int2str(i),'n_dt_bl'])            
end


for i=[1 5] %condition count
    z=0;
    eval(['load cond',int2str(i),'n_dt_bl'])
    eval(['a=size(cond',int2str(i),'n_dt_bl,3);'])
    sh=randperm(a);
    eval(['b=size(cond',int2str(i),'n_dt_bl,2)/2;'])
    for p=1:size(roi_bg_in,1)
        z=z+1;
        eval(['coeff_bg_in_cond',int2str(i),'_pix_',int2str(roi_bg_in(p)),'=NaN*ones(size(pixels,1),b-win,a);'])
        for h=1:a  %trial count
            
            
            disp(['pixel #',int2str(p),' condition #',int2str(i),' trial #',int2str(h),' transforming data'])
            %eval(['load cond',int2str(i),'n_dt_bl'])
            eval(['cond',int2str(i),'n_dt_tr1=cond',int2str(i),'n_dt_bl(:,2:end,h);'])
            eval(['cond',int2str(i),'n_dt_tr2=cond',int2str(i),'n_dt_bl(:,2:end,sh(h));'])
                for j=1:(b-win)
                   eval(['cc=sum((repmat(cond',int2str(i),'n_dt_tr1(roi_bg_in(p),j:j+win-1),[size(pixels,1) 1])-repmat(mean(cond',int2str(i),'n_dt_tr1(roi_bg_in(p),j:j+win-1),2),[size(pixels,1) win])).*(cond',int2str(i),'n_dt_tr2(pixels,j:j+win-1)-repmat(mean(cond',int2str(i),'n_dt_tr2(pixels,j:j+win-1),2),[1 win])),2)/(win-1);'])
                   eval(['var1=repmat(std(cond',int2str(i),'n_dt_tr1(roi_bg_in(p),j:j+win-1),0,2).^2,[size(pixels,1) 1]);'])
                   eval(['var2=std(cond',int2str(i),'n_dt_tr2(pixels,j:j+win-1),0,2).^2;'])
                   eval(['coeff_bg_in_cond',int2str(i),'_pix_',int2str(roi_bg_in(p)),'(:,j,h)=cc./sqrt(var1.*var2);']) 
                end;
            
        end;
        if z==1
            eval(['coeff_bg_in_cond',int2str(i),'=coeff_bg_in_cond',int2str(i),'_pix_',int2str(roi_bg_in(p)),';'])    
        else
            eval(['coeff_bg_in_cond',int2str(i),'=coeff_bg_in_cond',int2str(i),'+coeff_bg_in_cond',int2str(i),'_pix_',int2str(roi_bg_in(p)),';'])
        end 
        eval(['clear coeff_bg_in_cond',int2str(i),'_pix_',int2str(roi_bg_in(p))])
    end;
    eval(['coeff_bg_in_cond',int2str(i),'=coeff_bg_in_cond',int2str(i),'/size(roi_bg_in,1);'])
    cd pixels_SHUFFLE
    eval(['save coeff_bg_in_cond',int2str(i),' coeff_bg_in_cond',int2str(i),' roi_bg_in pixels sh'])
    cd ..
    eval(['clear coeff_bg_in_cond',int2str(i)])
    eval(['clear cond',int2str(i),'n_dt_bl'])            
end


cd F:\Data\VSDI\Contour_integration\legolas\right_hemisphere\psychophysics\2008_11_18\c\correct_and_incorrect_together

load pixels_to_remove
t=ones(10000,1);
t(pixels_to_remove)=0;
pixels=find(t);
clear t


load myrois


win=8;

for i=[1 5] %condition count
    z=0;
    eval(['load cond',int2str(i),'n_dt_bl'])
    eval(['a=size(cond',int2str(i),'n_dt_bl,3);'])
    sh=randperm(a);
    eval(['b=size(cond',int2str(i),'n_dt_bl,2)/2;'])
    for p=1:size(roi_circle_diff,1)
        z=z+1;
        eval(['coeff_circle_diff_cond',int2str(i),'_pix_',int2str(roi_circle_diff(p)),'=NaN*ones(size(pixels,1),b-win,a);'])
        for h=1:a  %trial count
            
            
            disp(['pixel #',int2str(p),' condition #',int2str(i),' trial #',int2str(h),' transforming data'])
            %eval(['load cond',int2str(i),'n_dt_bl'])
            eval(['cond',int2str(i),'n_dt_tr1=cond',int2str(i),'n_dt_bl(:,2:end,h);'])
            eval(['cond',int2str(i),'n_dt_tr2=cond',int2str(i),'n_dt_bl(:,2:end,sh(h));'])
                for j=1:(b-win)
                   eval(['cc=sum((repmat(cond',int2str(i),'n_dt_tr1(roi_circle_diff(p),j:j+win-1),[size(pixels,1) 1])-repmat(mean(cond',int2str(i),'n_dt_tr1(roi_circle_diff(p),j:j+win-1),2),[size(pixels,1) win])).*(cond',int2str(i),'n_dt_tr2(pixels,j:j+win-1)-repmat(mean(cond',int2str(i),'n_dt_tr2(pixels,j:j+win-1),2),[1 win])),2)/(win-1);'])
                   eval(['var1=repmat(std(cond',int2str(i),'n_dt_tr1(roi_circle_diff(p),j:j+win-1),0,2).^2,[size(pixels,1) 1]);'])
                   eval(['var2=std(cond',int2str(i),'n_dt_tr2(pixels,j:j+win-1),0,2).^2;'])
                   eval(['coeff_circle_diff_cond',int2str(i),'_pix_',int2str(roi_circle_diff(p)),'(:,j,h)=cc./sqrt(var1.*var2);']) 
                end;
            
        end;
        if z==1
            eval(['coeff_circle_diff_cond',int2str(i),'=coeff_circle_diff_cond',int2str(i),'_pix_',int2str(roi_circle_diff(p)),';'])    
        else
            eval(['coeff_circle_diff_cond',int2str(i),'=coeff_circle_diff_cond',int2str(i),'+coeff_circle_diff_cond',int2str(i),'_pix_',int2str(roi_circle_diff(p)),';'])
        end 
        eval(['clear coeff_circle_diff_cond',int2str(i),'_pix_',int2str(roi_circle_diff(p))])
    end;
    eval(['coeff_circle_diff_cond',int2str(i),'=coeff_circle_diff_cond',int2str(i),'/size(roi_circle_diff,1);'])
    cd pixels_SHUFFLE
    eval(['save coeff_circle_diff_cond',int2str(i),' coeff_circle_diff_cond',int2str(i),' roi_circle_diff pixels sh'])
    cd ..
    eval(['clear coeff_circle_diff_cond',int2str(i)])
    eval(['clear cond',int2str(i),'n_dt_bl'])            
end


for i=[1 5] %condition count
    z=0;
    eval(['load cond',int2str(i),'n_dt_bl'])
    eval(['a=size(cond',int2str(i),'n_dt_bl,3);'])
    sh=randperm(a);
    eval(['b=size(cond',int2str(i),'n_dt_bl,2)/2;'])
    for p=1:size(roi_bg_in,1)
        z=z+1;
        eval(['coeff_bg_in_cond',int2str(i),'_pix_',int2str(roi_bg_in(p)),'=NaN*ones(size(pixels,1),b-win,a);'])
        for h=1:a  %trial count
            
            
            disp(['pixel #',int2str(p),' condition #',int2str(i),' trial #',int2str(h),' transforming data'])
            %eval(['load cond',int2str(i),'n_dt_bl'])
            eval(['cond',int2str(i),'n_dt_tr1=cond',int2str(i),'n_dt_bl(:,2:end,h);'])
            eval(['cond',int2str(i),'n_dt_tr2=cond',int2str(i),'n_dt_bl(:,2:end,sh(h));'])
                for j=1:(b-win)
                   eval(['cc=sum((repmat(cond',int2str(i),'n_dt_tr1(roi_bg_in(p),j:j+win-1),[size(pixels,1) 1])-repmat(mean(cond',int2str(i),'n_dt_tr1(roi_bg_in(p),j:j+win-1),2),[size(pixels,1) win])).*(cond',int2str(i),'n_dt_tr2(pixels,j:j+win-1)-repmat(mean(cond',int2str(i),'n_dt_tr2(pixels,j:j+win-1),2),[1 win])),2)/(win-1);'])
                   eval(['var1=repmat(std(cond',int2str(i),'n_dt_tr1(roi_bg_in(p),j:j+win-1),0,2).^2,[size(pixels,1) 1]);'])
                   eval(['var2=std(cond',int2str(i),'n_dt_tr2(pixels,j:j+win-1),0,2).^2;'])
                   eval(['coeff_bg_in_cond',int2str(i),'_pix_',int2str(roi_bg_in(p)),'(:,j,h)=cc./sqrt(var1.*var2);']) 
                end;
            
        end;
        if z==1
            eval(['coeff_bg_in_cond',int2str(i),'=coeff_bg_in_cond',int2str(i),'_pix_',int2str(roi_bg_in(p)),';'])    
        else
            eval(['coeff_bg_in_cond',int2str(i),'=coeff_bg_in_cond',int2str(i),'+coeff_bg_in_cond',int2str(i),'_pix_',int2str(roi_bg_in(p)),';'])
        end 
        eval(['clear coeff_bg_in_cond',int2str(i),'_pix_',int2str(roi_bg_in(p))])
    end;
    eval(['coeff_bg_in_cond',int2str(i),'=coeff_bg_in_cond',int2str(i),'/size(roi_bg_in,1);'])
    cd pixels_SHUFFLE
    eval(['save coeff_bg_in_cond',int2str(i),' coeff_bg_in_cond',int2str(i),' roi_bg_in pixels sh'])
    cd ..
    eval(['clear coeff_bg_in_cond',int2str(i)])
    eval(['clear cond',int2str(i),'n_dt_bl'])            
end



cd F:\Data\VSDI\Contour_integration\legolas\right_hemisphere\psychophysics\2008_11_18\d\correct_and_incorrect_together

load pixels_to_remove
t=ones(10000,1);
t(pixels_to_remove)=0;
pixels=find(t);
clear t


load myrois


win=8;

for i=[1 5] %condition count
    z=0;
    eval(['load cond',int2str(i),'n_dt_bl'])
    eval(['a=size(cond',int2str(i),'n_dt_bl,3);'])
    sh=randperm(a);
    eval(['b=size(cond',int2str(i),'n_dt_bl,2)/2;'])
    for p=1:size(roi_circle_diff,1)
        z=z+1;
        eval(['coeff_circle_diff_cond',int2str(i),'_pix_',int2str(roi_circle_diff(p)),'=NaN*ones(size(pixels,1),b-win,a);'])
        for h=1:a  %trial count
            
            
            disp(['pixel #',int2str(p),' condition #',int2str(i),' trial #',int2str(h),' transforming data'])
            %eval(['load cond',int2str(i),'n_dt_bl'])
            eval(['cond',int2str(i),'n_dt_tr1=cond',int2str(i),'n_dt_bl(:,2:end,h);'])
            eval(['cond',int2str(i),'n_dt_tr2=cond',int2str(i),'n_dt_bl(:,2:end,sh(h));'])
                for j=1:(b-win)
                   eval(['cc=sum((repmat(cond',int2str(i),'n_dt_tr1(roi_circle_diff(p),j:j+win-1),[size(pixels,1) 1])-repmat(mean(cond',int2str(i),'n_dt_tr1(roi_circle_diff(p),j:j+win-1),2),[size(pixels,1) win])).*(cond',int2str(i),'n_dt_tr2(pixels,j:j+win-1)-repmat(mean(cond',int2str(i),'n_dt_tr2(pixels,j:j+win-1),2),[1 win])),2)/(win-1);'])
                   eval(['var1=repmat(std(cond',int2str(i),'n_dt_tr1(roi_circle_diff(p),j:j+win-1),0,2).^2,[size(pixels,1) 1]);'])
                   eval(['var2=std(cond',int2str(i),'n_dt_tr2(pixels,j:j+win-1),0,2).^2;'])
                   eval(['coeff_circle_diff_cond',int2str(i),'_pix_',int2str(roi_circle_diff(p)),'(:,j,h)=cc./sqrt(var1.*var2);']) 
                end;
            
        end;
        if z==1
            eval(['coeff_circle_diff_cond',int2str(i),'=coeff_circle_diff_cond',int2str(i),'_pix_',int2str(roi_circle_diff(p)),';'])    
        else
            eval(['coeff_circle_diff_cond',int2str(i),'=coeff_circle_diff_cond',int2str(i),'+coeff_circle_diff_cond',int2str(i),'_pix_',int2str(roi_circle_diff(p)),';'])
        end 
        eval(['clear coeff_circle_diff_cond',int2str(i),'_pix_',int2str(roi_circle_diff(p))])
    end;
    eval(['coeff_circle_diff_cond',int2str(i),'=coeff_circle_diff_cond',int2str(i),'/size(roi_circle_diff,1);'])
    cd pixels_SHUFFLE
    eval(['save coeff_circle_diff_cond',int2str(i),' coeff_circle_diff_cond',int2str(i),' roi_circle_diff pixels sh'])
    cd ..
    eval(['clear coeff_circle_diff_cond',int2str(i)])
    eval(['clear cond',int2str(i),'n_dt_bl'])            
end


for i=[1 5] %condition count
    z=0;
    eval(['load cond',int2str(i),'n_dt_bl'])
    eval(['a=size(cond',int2str(i),'n_dt_bl,3);'])
    sh=randperm(a);
    eval(['b=size(cond',int2str(i),'n_dt_bl,2)/2;'])
    for p=1:size(roi_bg_in,1)
        z=z+1;
        eval(['coeff_bg_in_cond',int2str(i),'_pix_',int2str(roi_bg_in(p)),'=NaN*ones(size(pixels,1),b-win,a);'])
        for h=1:a  %trial count
            
            
            disp(['pixel #',int2str(p),' condition #',int2str(i),' trial #',int2str(h),' transforming data'])
            %eval(['load cond',int2str(i),'n_dt_bl'])
            eval(['cond',int2str(i),'n_dt_tr1=cond',int2str(i),'n_dt_bl(:,2:end,h);'])
            eval(['cond',int2str(i),'n_dt_tr2=cond',int2str(i),'n_dt_bl(:,2:end,sh(h));'])
                for j=1:(b-win)
                   eval(['cc=sum((repmat(cond',int2str(i),'n_dt_tr1(roi_bg_in(p),j:j+win-1),[size(pixels,1) 1])-repmat(mean(cond',int2str(i),'n_dt_tr1(roi_bg_in(p),j:j+win-1),2),[size(pixels,1) win])).*(cond',int2str(i),'n_dt_tr2(pixels,j:j+win-1)-repmat(mean(cond',int2str(i),'n_dt_tr2(pixels,j:j+win-1),2),[1 win])),2)/(win-1);'])
                   eval(['var1=repmat(std(cond',int2str(i),'n_dt_tr1(roi_bg_in(p),j:j+win-1),0,2).^2,[size(pixels,1) 1]);'])
                   eval(['var2=std(cond',int2str(i),'n_dt_tr2(pixels,j:j+win-1),0,2).^2;'])
                   eval(['coeff_bg_in_cond',int2str(i),'_pix_',int2str(roi_bg_in(p)),'(:,j,h)=cc./sqrt(var1.*var2);']) 
                end;
            
        end;
        if z==1
            eval(['coeff_bg_in_cond',int2str(i),'=coeff_bg_in_cond',int2str(i),'_pix_',int2str(roi_bg_in(p)),';'])    
        else
            eval(['coeff_bg_in_cond',int2str(i),'=coeff_bg_in_cond',int2str(i),'+coeff_bg_in_cond',int2str(i),'_pix_',int2str(roi_bg_in(p)),';'])
        end 
        eval(['clear coeff_bg_in_cond',int2str(i),'_pix_',int2str(roi_bg_in(p))])
    end;
    eval(['coeff_bg_in_cond',int2str(i),'=coeff_bg_in_cond',int2str(i),'/size(roi_bg_in,1);'])
    cd pixels_SHUFFLE
    eval(['save coeff_bg_in_cond',int2str(i),' coeff_bg_in_cond',int2str(i),' roi_bg_in pixels sh'])
    cd ..
    eval(['clear coeff_bg_in_cond',int2str(i)])
    eval(['clear cond',int2str(i),'n_dt_bl'])            
end


cd F:\Data\VSDI\Contour_integration\legolas\right_hemisphere\psychophysics\2008_11_18\e\correct_and_incorrect_together

load pixels_to_remove
t=ones(10000,1);
t(pixels_to_remove)=0;
pixels=find(t);
clear t


load myrois


win=8;

for i=[1 5] %condition count
    z=0;
    eval(['load cond',int2str(i),'n_dt_bl'])
    eval(['a=size(cond',int2str(i),'n_dt_bl,3);'])
    sh=randperm(a);
    eval(['b=size(cond',int2str(i),'n_dt_bl,2)/2;'])
    for p=1:size(roi_circle_diff,1)
        z=z+1;
        eval(['coeff_circle_diff_cond',int2str(i),'_pix_',int2str(roi_circle_diff(p)),'=NaN*ones(size(pixels,1),b-win,a);'])
        for h=1:a  %trial count
            
            
            disp(['pixel #',int2str(p),' condition #',int2str(i),' trial #',int2str(h),' transforming data'])
            %eval(['load cond',int2str(i),'n_dt_bl'])
            eval(['cond',int2str(i),'n_dt_tr1=cond',int2str(i),'n_dt_bl(:,2:end,h);'])
            eval(['cond',int2str(i),'n_dt_tr2=cond',int2str(i),'n_dt_bl(:,2:end,sh(h));'])
                for j=1:(b-win)
                   eval(['cc=sum((repmat(cond',int2str(i),'n_dt_tr1(roi_circle_diff(p),j:j+win-1),[size(pixels,1) 1])-repmat(mean(cond',int2str(i),'n_dt_tr1(roi_circle_diff(p),j:j+win-1),2),[size(pixels,1) win])).*(cond',int2str(i),'n_dt_tr2(pixels,j:j+win-1)-repmat(mean(cond',int2str(i),'n_dt_tr2(pixels,j:j+win-1),2),[1 win])),2)/(win-1);'])
                   eval(['var1=repmat(std(cond',int2str(i),'n_dt_tr1(roi_circle_diff(p),j:j+win-1),0,2).^2,[size(pixels,1) 1]);'])
                   eval(['var2=std(cond',int2str(i),'n_dt_tr2(pixels,j:j+win-1),0,2).^2;'])
                   eval(['coeff_circle_diff_cond',int2str(i),'_pix_',int2str(roi_circle_diff(p)),'(:,j,h)=cc./sqrt(var1.*var2);']) 
                end;
            
        end;
        if z==1
            eval(['coeff_circle_diff_cond',int2str(i),'=coeff_circle_diff_cond',int2str(i),'_pix_',int2str(roi_circle_diff(p)),';'])    
        else
            eval(['coeff_circle_diff_cond',int2str(i),'=coeff_circle_diff_cond',int2str(i),'+coeff_circle_diff_cond',int2str(i),'_pix_',int2str(roi_circle_diff(p)),';'])
        end 
        eval(['clear coeff_circle_diff_cond',int2str(i),'_pix_',int2str(roi_circle_diff(p))])
    end;
    eval(['coeff_circle_diff_cond',int2str(i),'=coeff_circle_diff_cond',int2str(i),'/size(roi_circle_diff,1);'])
    cd pixels_SHUFFLE
    eval(['save coeff_circle_diff_cond',int2str(i),' coeff_circle_diff_cond',int2str(i),' roi_circle_diff pixels sh'])
    cd ..
    eval(['clear coeff_circle_diff_cond',int2str(i)])
    eval(['clear cond',int2str(i),'n_dt_bl'])            
end


for i=[1 5] %condition count
    z=0;
    eval(['load cond',int2str(i),'n_dt_bl'])
    eval(['a=size(cond',int2str(i),'n_dt_bl,3);'])
    sh=randperm(a);
    eval(['b=size(cond',int2str(i),'n_dt_bl,2)/2;'])
    for p=1:size(roi_bg_in,1)
        z=z+1;
        eval(['coeff_bg_in_cond',int2str(i),'_pix_',int2str(roi_bg_in(p)),'=NaN*ones(size(pixels,1),b-win,a);'])
        for h=1:a  %trial count
            
            
            disp(['pixel #',int2str(p),' condition #',int2str(i),' trial #',int2str(h),' transforming data'])
            %eval(['load cond',int2str(i),'n_dt_bl'])
            eval(['cond',int2str(i),'n_dt_tr1=cond',int2str(i),'n_dt_bl(:,2:end,h);'])
            eval(['cond',int2str(i),'n_dt_tr2=cond',int2str(i),'n_dt_bl(:,2:end,sh(h));'])
                for j=1:(b-win)
                   eval(['cc=sum((repmat(cond',int2str(i),'n_dt_tr1(roi_bg_in(p),j:j+win-1),[size(pixels,1) 1])-repmat(mean(cond',int2str(i),'n_dt_tr1(roi_bg_in(p),j:j+win-1),2),[size(pixels,1) win])).*(cond',int2str(i),'n_dt_tr2(pixels,j:j+win-1)-repmat(mean(cond',int2str(i),'n_dt_tr2(pixels,j:j+win-1),2),[1 win])),2)/(win-1);'])
                   eval(['var1=repmat(std(cond',int2str(i),'n_dt_tr1(roi_bg_in(p),j:j+win-1),0,2).^2,[size(pixels,1) 1]);'])
                   eval(['var2=std(cond',int2str(i),'n_dt_tr2(pixels,j:j+win-1),0,2).^2;'])
                   eval(['coeff_bg_in_cond',int2str(i),'_pix_',int2str(roi_bg_in(p)),'(:,j,h)=cc./sqrt(var1.*var2);']) 
                end;
            
        end;
        if z==1
            eval(['coeff_bg_in_cond',int2str(i),'=coeff_bg_in_cond',int2str(i),'_pix_',int2str(roi_bg_in(p)),';'])    
        else
            eval(['coeff_bg_in_cond',int2str(i),'=coeff_bg_in_cond',int2str(i),'+coeff_bg_in_cond',int2str(i),'_pix_',int2str(roi_bg_in(p)),';'])
        end 
        eval(['clear coeff_bg_in_cond',int2str(i),'_pix_',int2str(roi_bg_in(p))])
    end;
    eval(['coeff_bg_in_cond',int2str(i),'=coeff_bg_in_cond',int2str(i),'/size(roi_bg_in,1);'])
    cd pixels_SHUFFLE
    eval(['save coeff_bg_in_cond',int2str(i),' coeff_bg_in_cond',int2str(i),' roi_bg_in pixels sh'])
    cd ..
    eval(['clear coeff_bg_in_cond',int2str(i)])
    eval(['clear cond',int2str(i),'n_dt_bl'])            
end





