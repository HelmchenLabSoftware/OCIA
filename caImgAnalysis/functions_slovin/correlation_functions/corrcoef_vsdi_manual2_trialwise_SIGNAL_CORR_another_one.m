
cd F:\Data\VSDI\Contour_integration\Smeagol\24Nov2010\d

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
    a=1;    
    eval(['b=size(cond',int2str(i),'n_dt_bl,2)/2;'])
    for p=1:size(roi_circle,1)
        z=z+1;
        eval(['coeff_circle_cond',int2str(i),'_pix_',int2str(roi_circle(p)),'=NaN*ones(size(pixels,1),b-win,a);'])
        for h=1:a  %trial count
            
            
            disp(['pixel #',int2str(p),' condition #',int2str(i),' trial #',int2str(h),' transforming data'])
            %eval(['load cond',int2str(i),'n_dt_bl'])
            eval(['cond',int2str(i),'n_dt_tr=mean(cond',int2str(i),'n_dt_bl(:,2:end,:),3);'])
            
                for j=1:(b-win)
                   eval(['cc=sum((repmat(cond',int2str(i),'n_dt_tr(roi_circle(p),j:j+win-1),[size(pixels,1) 1])-repmat(mean(cond',int2str(i),'n_dt_tr(roi_circle(p),j:j+win-1),2),[size(pixels,1) win])).*(cond',int2str(i),'n_dt_tr(pixels,j:j+win-1)-repmat(mean(cond',int2str(i),'n_dt_tr(pixels,j:j+win-1),2),[1 win])),2)/(win-1);'])
                   eval(['var1=repmat(std(cond',int2str(i),'n_dt_tr(roi_circle(p),j:j+win-1),0,2).^2,[size(pixels,1) 1]);'])
                   eval(['var2=std(cond',int2str(i),'n_dt_tr(pixels,j:j+win-1),0,2).^2;'])
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
    mkdir signal_corr
    cd signal_corr
    eval(['save coeff_circle_cond',int2str(i),' coeff_circle_cond',int2str(i),' roi_circle pixels'])
    cd ..
    eval(['clear coeff_circle_cond',int2str(i)])
    eval(['clear cond',int2str(i),'n_dt_bl'])            
end

for i=[1 2 4 5] %condition count
    z=0;
    eval(['load cond',int2str(i),'n_dt_bl'])
    a=1;    
    eval(['b=size(cond',int2str(i),'n_dt_bl,2)/2;'])
    for p=1:size(roi_bg_in,1)
        z=z+1;
        eval(['coeff_bg_in_cond',int2str(i),'_pix_',int2str(roi_bg_in(p)),'=NaN*ones(size(pixels,1),b-win,a);'])
        for h=1:a  %trial count
            
            
            disp(['pixel #',int2str(p),' condition #',int2str(i),' trial #',int2str(h),' transforming data'])
            %eval(['load cond',int2str(i),'n_dt_bl'])
            eval(['cond',int2str(i),'n_dt_tr=mean(cond',int2str(i),'n_dt_bl(:,2:end,:),3);'])
            
                for j=1:(b-win)
                   eval(['cc=sum((repmat(cond',int2str(i),'n_dt_tr(roi_bg_in(p),j:j+win-1),[size(pixels,1) 1])-repmat(mean(cond',int2str(i),'n_dt_tr(roi_bg_in(p),j:j+win-1),2),[size(pixels,1) win])).*(cond',int2str(i),'n_dt_tr(pixels,j:j+win-1)-repmat(mean(cond',int2str(i),'n_dt_tr(pixels,j:j+win-1),2),[1 win])),2)/(win-1);'])
                   eval(['var1=repmat(std(cond',int2str(i),'n_dt_tr(roi_bg_in(p),j:j+win-1),0,2).^2,[size(pixels,1) 1]);'])
                   eval(['var2=std(cond',int2str(i),'n_dt_tr(pixels,j:j+win-1),0,2).^2;'])
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
    mkdir signal_corr
    cd signal_corr
    eval(['save coeff_bg_in_cond',int2str(i),' coeff_bg_in_cond',int2str(i),' roi_bg_in pixels'])
    cd ..
    eval(['clear coeff_bg_in_cond',int2str(i)])
    eval(['clear cond',int2str(i),'n_dt_bl'])            
end

cd F:\Data\VSDI\Contour_integration\Smeagol\24Nov2010\f

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
    a=1;    
    eval(['b=size(cond',int2str(i),'n_dt_bl,2)/2;'])
    for p=1:size(roi_circle,1)
        z=z+1;
        eval(['coeff_circle_cond',int2str(i),'_pix_',int2str(roi_circle(p)),'=NaN*ones(size(pixels,1),b-win,a);'])
        for h=1:a  %trial count
            
            
            disp(['pixel #',int2str(p),' condition #',int2str(i),' trial #',int2str(h),' transforming data'])
            %eval(['load cond',int2str(i),'n_dt_bl'])
            eval(['cond',int2str(i),'n_dt_tr=mean(cond',int2str(i),'n_dt_bl(:,2:end,:),3);'])
            
                for j=1:(b-win)
                   eval(['cc=sum((repmat(cond',int2str(i),'n_dt_tr(roi_circle(p),j:j+win-1),[size(pixels,1) 1])-repmat(mean(cond',int2str(i),'n_dt_tr(roi_circle(p),j:j+win-1),2),[size(pixels,1) win])).*(cond',int2str(i),'n_dt_tr(pixels,j:j+win-1)-repmat(mean(cond',int2str(i),'n_dt_tr(pixels,j:j+win-1),2),[1 win])),2)/(win-1);'])
                   eval(['var1=repmat(std(cond',int2str(i),'n_dt_tr(roi_circle(p),j:j+win-1),0,2).^2,[size(pixels,1) 1]);'])
                   eval(['var2=std(cond',int2str(i),'n_dt_tr(pixels,j:j+win-1),0,2).^2;'])
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
    mkdir signal_corr
    cd signal_corr
    eval(['save coeff_circle_cond',int2str(i),' coeff_circle_cond',int2str(i),' roi_circle pixels'])
    cd ..
    eval(['clear coeff_circle_cond',int2str(i)])
    eval(['clear cond',int2str(i),'n_dt_bl'])            
end

for i=[1 2 4 5] %condition count
    z=0;
    eval(['load cond',int2str(i),'n_dt_bl'])
    a=1;    
    eval(['b=size(cond',int2str(i),'n_dt_bl,2)/2;'])
    for p=1:size(roi_bg_in,1)
        z=z+1;
        eval(['coeff_bg_in_cond',int2str(i),'_pix_',int2str(roi_bg_in(p)),'=NaN*ones(size(pixels,1),b-win,a);'])
        for h=1:a  %trial count
            
            
            disp(['pixel #',int2str(p),' condition #',int2str(i),' trial #',int2str(h),' transforming data'])
            %eval(['load cond',int2str(i),'n_dt_bl'])
            eval(['cond',int2str(i),'n_dt_tr=mean(cond',int2str(i),'n_dt_bl(:,2:end,:),3);'])
            
                for j=1:(b-win)
                   eval(['cc=sum((repmat(cond',int2str(i),'n_dt_tr(roi_bg_in(p),j:j+win-1),[size(pixels,1) 1])-repmat(mean(cond',int2str(i),'n_dt_tr(roi_bg_in(p),j:j+win-1),2),[size(pixels,1) win])).*(cond',int2str(i),'n_dt_tr(pixels,j:j+win-1)-repmat(mean(cond',int2str(i),'n_dt_tr(pixels,j:j+win-1),2),[1 win])),2)/(win-1);'])
                   eval(['var1=repmat(std(cond',int2str(i),'n_dt_tr(roi_bg_in(p),j:j+win-1),0,2).^2,[size(pixels,1) 1]);'])
                   eval(['var2=std(cond',int2str(i),'n_dt_tr(pixels,j:j+win-1),0,2).^2;'])
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
    mkdir signal_corr
    cd signal_corr
    eval(['save coeff_bg_in_cond',int2str(i),' coeff_bg_in_cond',int2str(i),' roi_bg_in pixels'])
    cd ..
    eval(['clear coeff_bg_in_cond',int2str(i)])
    eval(['clear cond',int2str(i),'n_dt_bl'])            
end

cd F:\Data\VSDI\Contour_integration\Smeagol\14Dec2010\b

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
    a=1;    
    eval(['b=size(cond',int2str(i),'n_dt_bl,2)/2;'])
    for p=1:size(roi_circle,1)
        z=z+1;
        eval(['coeff_circle_cond',int2str(i),'_pix_',int2str(roi_circle(p)),'=NaN*ones(size(pixels,1),b-win,a);'])
        for h=1:a  %trial count
            
            
            disp(['pixel #',int2str(p),' condition #',int2str(i),' trial #',int2str(h),' transforming data'])
            %eval(['load cond',int2str(i),'n_dt_bl'])
            eval(['cond',int2str(i),'n_dt_tr=mean(cond',int2str(i),'n_dt_bl(:,2:end,:),3);'])
            
                for j=1:(b-win)
                   eval(['cc=sum((repmat(cond',int2str(i),'n_dt_tr(roi_circle(p),j:j+win-1),[size(pixels,1) 1])-repmat(mean(cond',int2str(i),'n_dt_tr(roi_circle(p),j:j+win-1),2),[size(pixels,1) win])).*(cond',int2str(i),'n_dt_tr(pixels,j:j+win-1)-repmat(mean(cond',int2str(i),'n_dt_tr(pixels,j:j+win-1),2),[1 win])),2)/(win-1);'])
                   eval(['var1=repmat(std(cond',int2str(i),'n_dt_tr(roi_circle(p),j:j+win-1),0,2).^2,[size(pixels,1) 1]);'])
                   eval(['var2=std(cond',int2str(i),'n_dt_tr(pixels,j:j+win-1),0,2).^2;'])
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
    mkdir signal_corr
    cd signal_corr
    eval(['save coeff_circle_cond',int2str(i),' coeff_circle_cond',int2str(i),' roi_circle pixels'])
    cd ..
    eval(['clear coeff_circle_cond',int2str(i)])
    eval(['clear cond',int2str(i),'n_dt_bl'])            
end

for i=[1 2 4 5] %condition count
    z=0;
    eval(['load cond',int2str(i),'n_dt_bl'])
    a=1;    
    eval(['b=size(cond',int2str(i),'n_dt_bl,2)/2;'])
    for p=1:size(roi_bg_in,1)
        z=z+1;
        eval(['coeff_bg_in_cond',int2str(i),'_pix_',int2str(roi_bg_in(p)),'=NaN*ones(size(pixels,1),b-win,a);'])
        for h=1:a  %trial count
            
            
            disp(['pixel #',int2str(p),' condition #',int2str(i),' trial #',int2str(h),' transforming data'])
            %eval(['load cond',int2str(i),'n_dt_bl'])
            eval(['cond',int2str(i),'n_dt_tr=mean(cond',int2str(i),'n_dt_bl(:,2:end,:),3);'])
            
                for j=1:(b-win)
                   eval(['cc=sum((repmat(cond',int2str(i),'n_dt_tr(roi_bg_in(p),j:j+win-1),[size(pixels,1) 1])-repmat(mean(cond',int2str(i),'n_dt_tr(roi_bg_in(p),j:j+win-1),2),[size(pixels,1) win])).*(cond',int2str(i),'n_dt_tr(pixels,j:j+win-1)-repmat(mean(cond',int2str(i),'n_dt_tr(pixels,j:j+win-1),2),[1 win])),2)/(win-1);'])
                   eval(['var1=repmat(std(cond',int2str(i),'n_dt_tr(roi_bg_in(p),j:j+win-1),0,2).^2,[size(pixels,1) 1]);'])
                   eval(['var2=std(cond',int2str(i),'n_dt_tr(pixels,j:j+win-1),0,2).^2;'])
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
    mkdir signal_corr
    cd signal_corr
    eval(['save coeff_bg_in_cond',int2str(i),' coeff_bg_in_cond',int2str(i),' roi_bg_in pixels'])
    cd ..
    eval(['clear coeff_bg_in_cond',int2str(i)])
    eval(['clear cond',int2str(i),'n_dt_bl'])            
end

cd F:\Data\VSDI\Contour_integration\Smeagol\14Dec2010\c

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
    a=1;    
    eval(['b=size(cond',int2str(i),'n_dt_bl,2)/2;'])
    for p=1:size(roi_circle,1)
        z=z+1;
        eval(['coeff_circle_cond',int2str(i),'_pix_',int2str(roi_circle(p)),'=NaN*ones(size(pixels,1),b-win,a);'])
        for h=1:a  %trial count
            
            
            disp(['pixel #',int2str(p),' condition #',int2str(i),' trial #',int2str(h),' transforming data'])
            %eval(['load cond',int2str(i),'n_dt_bl'])
            eval(['cond',int2str(i),'n_dt_tr=mean(cond',int2str(i),'n_dt_bl(:,2:end,:),3);'])
            
                for j=1:(b-win)
                   eval(['cc=sum((repmat(cond',int2str(i),'n_dt_tr(roi_circle(p),j:j+win-1),[size(pixels,1) 1])-repmat(mean(cond',int2str(i),'n_dt_tr(roi_circle(p),j:j+win-1),2),[size(pixels,1) win])).*(cond',int2str(i),'n_dt_tr(pixels,j:j+win-1)-repmat(mean(cond',int2str(i),'n_dt_tr(pixels,j:j+win-1),2),[1 win])),2)/(win-1);'])
                   eval(['var1=repmat(std(cond',int2str(i),'n_dt_tr(roi_circle(p),j:j+win-1),0,2).^2,[size(pixels,1) 1]);'])
                   eval(['var2=std(cond',int2str(i),'n_dt_tr(pixels,j:j+win-1),0,2).^2;'])
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
    mkdir signal_corr
    cd signal_corr
    eval(['save coeff_circle_cond',int2str(i),' coeff_circle_cond',int2str(i),' roi_circle pixels'])
    cd ..
    eval(['clear coeff_circle_cond',int2str(i)])
    eval(['clear cond',int2str(i),'n_dt_bl'])            
end

for i=[1 5] %condition count
    z=0;
    eval(['load cond',int2str(i),'n_dt_bl'])
    a=1;    
    eval(['b=size(cond',int2str(i),'n_dt_bl,2)/2;'])
    for p=1:size(roi_bg_in,1)
        z=z+1;
        eval(['coeff_bg_in_cond',int2str(i),'_pix_',int2str(roi_bg_in(p)),'=NaN*ones(size(pixels,1),b-win,a);'])
        for h=1:a  %trial count
            
            
            disp(['pixel #',int2str(p),' condition #',int2str(i),' trial #',int2str(h),' transforming data'])
            %eval(['load cond',int2str(i),'n_dt_bl'])
            eval(['cond',int2str(i),'n_dt_tr=mean(cond',int2str(i),'n_dt_bl(:,2:end,:),3);'])
            
                for j=1:(b-win)
                   eval(['cc=sum((repmat(cond',int2str(i),'n_dt_tr(roi_bg_in(p),j:j+win-1),[size(pixels,1) 1])-repmat(mean(cond',int2str(i),'n_dt_tr(roi_bg_in(p),j:j+win-1),2),[size(pixels,1) win])).*(cond',int2str(i),'n_dt_tr(pixels,j:j+win-1)-repmat(mean(cond',int2str(i),'n_dt_tr(pixels,j:j+win-1),2),[1 win])),2)/(win-1);'])
                   eval(['var1=repmat(std(cond',int2str(i),'n_dt_tr(roi_bg_in(p),j:j+win-1),0,2).^2,[size(pixels,1) 1]);'])
                   eval(['var2=std(cond',int2str(i),'n_dt_tr(pixels,j:j+win-1),0,2).^2;'])
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
    mkdir signal_corr
    cd signal_corr
    eval(['save coeff_bg_in_cond',int2str(i),' coeff_bg_in_cond',int2str(i),' roi_bg_in pixels'])
    cd ..
    eval(['clear coeff_bg_in_cond',int2str(i)])
    eval(['clear cond',int2str(i),'n_dt_bl'])            
end

cd F:\Data\VSDI\Contour_integration\Smeagol\14Dec2010\d

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
    a=1;    
    eval(['b=size(cond',int2str(i),'n_dt_bl,2)/2;'])
    for p=1:size(roi_circle,1)
        z=z+1;
        eval(['coeff_circle_cond',int2str(i),'_pix_',int2str(roi_circle(p)),'=NaN*ones(size(pixels,1),b-win,a);'])
        for h=1:a  %trial count
            
            
            disp(['pixel #',int2str(p),' condition #',int2str(i),' trial #',int2str(h),' transforming data'])
            %eval(['load cond',int2str(i),'n_dt_bl'])
            eval(['cond',int2str(i),'n_dt_tr=mean(cond',int2str(i),'n_dt_bl(:,2:end,:),3);'])
            
                for j=1:(b-win)
                   eval(['cc=sum((repmat(cond',int2str(i),'n_dt_tr(roi_circle(p),j:j+win-1),[size(pixels,1) 1])-repmat(mean(cond',int2str(i),'n_dt_tr(roi_circle(p),j:j+win-1),2),[size(pixels,1) win])).*(cond',int2str(i),'n_dt_tr(pixels,j:j+win-1)-repmat(mean(cond',int2str(i),'n_dt_tr(pixels,j:j+win-1),2),[1 win])),2)/(win-1);'])
                   eval(['var1=repmat(std(cond',int2str(i),'n_dt_tr(roi_circle(p),j:j+win-1),0,2).^2,[size(pixels,1) 1]);'])
                   eval(['var2=std(cond',int2str(i),'n_dt_tr(pixels,j:j+win-1),0,2).^2;'])
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
    mkdir signal_corr
    cd signal_corr
    eval(['save coeff_circle_cond',int2str(i),' coeff_circle_cond',int2str(i),' roi_circle pixels'])
    cd ..
    eval(['clear coeff_circle_cond',int2str(i)])
    eval(['clear cond',int2str(i),'n_dt_bl'])            
end

for i=[1 5] %condition count
    z=0;
    eval(['load cond',int2str(i),'n_dt_bl'])
    a=1;    
    eval(['b=size(cond',int2str(i),'n_dt_bl,2)/2;'])
    for p=1:size(roi_bg_in,1)
        z=z+1;
        eval(['coeff_bg_in_cond',int2str(i),'_pix_',int2str(roi_bg_in(p)),'=NaN*ones(size(pixels,1),b-win,a);'])
        for h=1:a  %trial count
            
            
            disp(['pixel #',int2str(p),' condition #',int2str(i),' trial #',int2str(h),' transforming data'])
            %eval(['load cond',int2str(i),'n_dt_bl'])
            eval(['cond',int2str(i),'n_dt_tr=mean(cond',int2str(i),'n_dt_bl(:,2:end,:),3);'])
            
                for j=1:(b-win)
                   eval(['cc=sum((repmat(cond',int2str(i),'n_dt_tr(roi_bg_in(p),j:j+win-1),[size(pixels,1) 1])-repmat(mean(cond',int2str(i),'n_dt_tr(roi_bg_in(p),j:j+win-1),2),[size(pixels,1) win])).*(cond',int2str(i),'n_dt_tr(pixels,j:j+win-1)-repmat(mean(cond',int2str(i),'n_dt_tr(pixels,j:j+win-1),2),[1 win])),2)/(win-1);'])
                   eval(['var1=repmat(std(cond',int2str(i),'n_dt_tr(roi_bg_in(p),j:j+win-1),0,2).^2,[size(pixels,1) 1]);'])
                   eval(['var2=std(cond',int2str(i),'n_dt_tr(pixels,j:j+win-1),0,2).^2;'])
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
    mkdir signal_corr
    cd signal_corr
    eval(['save coeff_bg_in_cond',int2str(i),' coeff_bg_in_cond',int2str(i),' roi_bg_in pixels'])
    cd ..
    eval(['clear coeff_bg_in_cond',int2str(i)])
    eval(['clear cond',int2str(i),'n_dt_bl'])            
end

cd F:\Data\VSDI\Contour_integration\Smeagol\14Dec2010\e

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
    a=1;    
    eval(['b=size(cond',int2str(i),'n_dt_bl,2)/2;'])
    for p=1:size(roi_circle,1)
        z=z+1;
        eval(['coeff_circle_cond',int2str(i),'_pix_',int2str(roi_circle(p)),'=NaN*ones(size(pixels,1),b-win,a);'])
        for h=1:a  %trial count
            
            
            disp(['pixel #',int2str(p),' condition #',int2str(i),' trial #',int2str(h),' transforming data'])
            %eval(['load cond',int2str(i),'n_dt_bl'])
            eval(['cond',int2str(i),'n_dt_tr=mean(cond',int2str(i),'n_dt_bl(:,2:end,:),3);'])
            
                for j=1:(b-win)
                   eval(['cc=sum((repmat(cond',int2str(i),'n_dt_tr(roi_circle(p),j:j+win-1),[size(pixels,1) 1])-repmat(mean(cond',int2str(i),'n_dt_tr(roi_circle(p),j:j+win-1),2),[size(pixels,1) win])).*(cond',int2str(i),'n_dt_tr(pixels,j:j+win-1)-repmat(mean(cond',int2str(i),'n_dt_tr(pixels,j:j+win-1),2),[1 win])),2)/(win-1);'])
                   eval(['var1=repmat(std(cond',int2str(i),'n_dt_tr(roi_circle(p),j:j+win-1),0,2).^2,[size(pixels,1) 1]);'])
                   eval(['var2=std(cond',int2str(i),'n_dt_tr(pixels,j:j+win-1),0,2).^2;'])
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
    mkdir signal_corr
    cd signal_corr
    eval(['save coeff_circle_cond',int2str(i),' coeff_circle_cond',int2str(i),' roi_circle pixels'])
    cd ..
    eval(['clear coeff_circle_cond',int2str(i)])
    eval(['clear cond',int2str(i),'n_dt_bl'])            
end

for i=[1 5] %condition count
    z=0;
    eval(['load cond',int2str(i),'n_dt_bl'])
    a=1;    
    eval(['b=size(cond',int2str(i),'n_dt_bl,2)/2;'])
    for p=1:size(roi_bg_in,1)
        z=z+1;
        eval(['coeff_bg_in_cond',int2str(i),'_pix_',int2str(roi_bg_in(p)),'=NaN*ones(size(pixels,1),b-win,a);'])
        for h=1:a  %trial count
            
            
            disp(['pixel #',int2str(p),' condition #',int2str(i),' trial #',int2str(h),' transforming data'])
            %eval(['load cond',int2str(i),'n_dt_bl'])
            eval(['cond',int2str(i),'n_dt_tr=mean(cond',int2str(i),'n_dt_bl(:,2:end,:),3);'])
            
                for j=1:(b-win)
                   eval(['cc=sum((repmat(cond',int2str(i),'n_dt_tr(roi_bg_in(p),j:j+win-1),[size(pixels,1) 1])-repmat(mean(cond',int2str(i),'n_dt_tr(roi_bg_in(p),j:j+win-1),2),[size(pixels,1) win])).*(cond',int2str(i),'n_dt_tr(pixels,j:j+win-1)-repmat(mean(cond',int2str(i),'n_dt_tr(pixels,j:j+win-1),2),[1 win])),2)/(win-1);'])
                   eval(['var1=repmat(std(cond',int2str(i),'n_dt_tr(roi_bg_in(p),j:j+win-1),0,2).^2,[size(pixels,1) 1]);'])
                   eval(['var2=std(cond',int2str(i),'n_dt_tr(pixels,j:j+win-1),0,2).^2;'])
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
    mkdir signal_corr
    cd signal_corr
    eval(['save coeff_bg_in_cond',int2str(i),' coeff_bg_in_cond',int2str(i),' roi_bg_in pixels'])
    cd ..
    eval(['clear coeff_bg_in_cond',int2str(i)])
    eval(['clear cond',int2str(i),'n_dt_bl'])            
end

cd F:\Data\VSDI\Contour_integration\Smeagol\22Dec2010\b

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
    a=1;    
    eval(['b=size(cond',int2str(i),'n_dt_bl,2)/2;'])
    for p=1:size(roi_circle,1)
        z=z+1;
        eval(['coeff_circle_cond',int2str(i),'_pix_',int2str(roi_circle(p)),'=NaN*ones(size(pixels,1),b-win,a);'])
        for h=1:a  %trial count
            
            
            disp(['pixel #',int2str(p),' condition #',int2str(i),' trial #',int2str(h),' transforming data'])
            %eval(['load cond',int2str(i),'n_dt_bl'])
            eval(['cond',int2str(i),'n_dt_tr=mean(cond',int2str(i),'n_dt_bl(:,2:end,:),3);'])
            
                for j=1:(b-win)
                   eval(['cc=sum((repmat(cond',int2str(i),'n_dt_tr(roi_circle(p),j:j+win-1),[size(pixels,1) 1])-repmat(mean(cond',int2str(i),'n_dt_tr(roi_circle(p),j:j+win-1),2),[size(pixels,1) win])).*(cond',int2str(i),'n_dt_tr(pixels,j:j+win-1)-repmat(mean(cond',int2str(i),'n_dt_tr(pixels,j:j+win-1),2),[1 win])),2)/(win-1);'])
                   eval(['var1=repmat(std(cond',int2str(i),'n_dt_tr(roi_circle(p),j:j+win-1),0,2).^2,[size(pixels,1) 1]);'])
                   eval(['var2=std(cond',int2str(i),'n_dt_tr(pixels,j:j+win-1),0,2).^2;'])
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
    mkdir signal_corr
    cd signal_corr
    eval(['save coeff_circle_cond',int2str(i),' coeff_circle_cond',int2str(i),' roi_circle pixels'])
    cd ..
    eval(['clear coeff_circle_cond',int2str(i)])
    eval(['clear cond',int2str(i),'n_dt_bl'])            
end

for i=[1 2 4 5] %condition count
    z=0;
    eval(['load cond',int2str(i),'n_dt_bl'])
    a=1;    
    eval(['b=size(cond',int2str(i),'n_dt_bl,2)/2;'])
    for p=1:size(roi_bg_in,1)
        z=z+1;
        eval(['coeff_bg_in_cond',int2str(i),'_pix_',int2str(roi_bg_in(p)),'=NaN*ones(size(pixels,1),b-win,a);'])
        for h=1:a  %trial count
            
            
            disp(['pixel #',int2str(p),' condition #',int2str(i),' trial #',int2str(h),' transforming data'])
            %eval(['load cond',int2str(i),'n_dt_bl'])
            eval(['cond',int2str(i),'n_dt_tr=mean(cond',int2str(i),'n_dt_bl(:,2:end,:),3);'])
            
                for j=1:(b-win)
                   eval(['cc=sum((repmat(cond',int2str(i),'n_dt_tr(roi_bg_in(p),j:j+win-1),[size(pixels,1) 1])-repmat(mean(cond',int2str(i),'n_dt_tr(roi_bg_in(p),j:j+win-1),2),[size(pixels,1) win])).*(cond',int2str(i),'n_dt_tr(pixels,j:j+win-1)-repmat(mean(cond',int2str(i),'n_dt_tr(pixels,j:j+win-1),2),[1 win])),2)/(win-1);'])
                   eval(['var1=repmat(std(cond',int2str(i),'n_dt_tr(roi_bg_in(p),j:j+win-1),0,2).^2,[size(pixels,1) 1]);'])
                   eval(['var2=std(cond',int2str(i),'n_dt_tr(pixels,j:j+win-1),0,2).^2;'])
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
    mkdir signal_corr
    cd signal_corr
    eval(['save coeff_bg_in_cond',int2str(i),' coeff_bg_in_cond',int2str(i),' roi_bg_in pixels'])
    cd ..
    eval(['clear coeff_bg_in_cond',int2str(i)])
    eval(['clear cond',int2str(i),'n_dt_bl'])            
end


cd F:\Data\VSDI\Contour_integration\Smeagol\22Dec2010\c

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
    a=1;    
    eval(['b=size(cond',int2str(i),'n_dt_bl,2)/2;'])
    for p=1:size(roi_circle,1)
        z=z+1;
        eval(['coeff_circle_cond',int2str(i),'_pix_',int2str(roi_circle(p)),'=NaN*ones(size(pixels,1),b-win,a);'])
        for h=1:a  %trial count
            
            
            disp(['pixel #',int2str(p),' condition #',int2str(i),' trial #',int2str(h),' transforming data'])
            %eval(['load cond',int2str(i),'n_dt_bl'])
            eval(['cond',int2str(i),'n_dt_tr=mean(cond',int2str(i),'n_dt_bl(:,2:end,:),3);'])
            
                for j=1:(b-win)
                   eval(['cc=sum((repmat(cond',int2str(i),'n_dt_tr(roi_circle(p),j:j+win-1),[size(pixels,1) 1])-repmat(mean(cond',int2str(i),'n_dt_tr(roi_circle(p),j:j+win-1),2),[size(pixels,1) win])).*(cond',int2str(i),'n_dt_tr(pixels,j:j+win-1)-repmat(mean(cond',int2str(i),'n_dt_tr(pixels,j:j+win-1),2),[1 win])),2)/(win-1);'])
                   eval(['var1=repmat(std(cond',int2str(i),'n_dt_tr(roi_circle(p),j:j+win-1),0,2).^2,[size(pixels,1) 1]);'])
                   eval(['var2=std(cond',int2str(i),'n_dt_tr(pixels,j:j+win-1),0,2).^2;'])
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
    mkdir signal_corr
    cd signal_corr
    eval(['save coeff_circle_cond',int2str(i),' coeff_circle_cond',int2str(i),' roi_circle pixels'])
    cd ..
    eval(['clear coeff_circle_cond',int2str(i)])
    eval(['clear cond',int2str(i),'n_dt_bl'])            
end

for i=[1 5] %condition count
    z=0;
    eval(['load cond',int2str(i),'n_dt_bl'])
    a=1;    
    eval(['b=size(cond',int2str(i),'n_dt_bl,2)/2;'])
    for p=1:size(roi_bg_in,1)
        z=z+1;
        eval(['coeff_bg_in_cond',int2str(i),'_pix_',int2str(roi_bg_in(p)),'=NaN*ones(size(pixels,1),b-win,a);'])
        for h=1:a  %trial count
            
            
            disp(['pixel #',int2str(p),' condition #',int2str(i),' trial #',int2str(h),' transforming data'])
            %eval(['load cond',int2str(i),'n_dt_bl'])
            eval(['cond',int2str(i),'n_dt_tr=mean(cond',int2str(i),'n_dt_bl(:,2:end,:),3);'])
            
                for j=1:(b-win)
                   eval(['cc=sum((repmat(cond',int2str(i),'n_dt_tr(roi_bg_in(p),j:j+win-1),[size(pixels,1) 1])-repmat(mean(cond',int2str(i),'n_dt_tr(roi_bg_in(p),j:j+win-1),2),[size(pixels,1) win])).*(cond',int2str(i),'n_dt_tr(pixels,j:j+win-1)-repmat(mean(cond',int2str(i),'n_dt_tr(pixels,j:j+win-1),2),[1 win])),2)/(win-1);'])
                   eval(['var1=repmat(std(cond',int2str(i),'n_dt_tr(roi_bg_in(p),j:j+win-1),0,2).^2,[size(pixels,1) 1]);'])
                   eval(['var2=std(cond',int2str(i),'n_dt_tr(pixels,j:j+win-1),0,2).^2;'])
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
    mkdir signal_corr
    cd signal_corr
    eval(['save coeff_bg_in_cond',int2str(i),' coeff_bg_in_cond',int2str(i),' roi_bg_in pixels'])
    cd ..
    eval(['clear coeff_bg_in_cond',int2str(i)])
    eval(['clear cond',int2str(i),'n_dt_bl'])            
end

cd F:\Data\VSDI\Contour_integration\Smeagol\22Dec2010\d

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
    a=1;    
    eval(['b=size(cond',int2str(i),'n_dt_bl,2)/2;'])
    for p=1:size(roi_circle,1)
        z=z+1;
        eval(['coeff_circle_cond',int2str(i),'_pix_',int2str(roi_circle(p)),'=NaN*ones(size(pixels,1),b-win,a);'])
        for h=1:a  %trial count
            
            
            disp(['pixel #',int2str(p),' condition #',int2str(i),' trial #',int2str(h),' transforming data'])
            %eval(['load cond',int2str(i),'n_dt_bl'])
            eval(['cond',int2str(i),'n_dt_tr=mean(cond',int2str(i),'n_dt_bl(:,2:end,:),3);'])
            
                for j=1:(b-win)
                   eval(['cc=sum((repmat(cond',int2str(i),'n_dt_tr(roi_circle(p),j:j+win-1),[size(pixels,1) 1])-repmat(mean(cond',int2str(i),'n_dt_tr(roi_circle(p),j:j+win-1),2),[size(pixels,1) win])).*(cond',int2str(i),'n_dt_tr(pixels,j:j+win-1)-repmat(mean(cond',int2str(i),'n_dt_tr(pixels,j:j+win-1),2),[1 win])),2)/(win-1);'])
                   eval(['var1=repmat(std(cond',int2str(i),'n_dt_tr(roi_circle(p),j:j+win-1),0,2).^2,[size(pixels,1) 1]);'])
                   eval(['var2=std(cond',int2str(i),'n_dt_tr(pixels,j:j+win-1),0,2).^2;'])
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
    mkdir signal_corr
    cd signal_corr
    eval(['save coeff_circle_cond',int2str(i),' coeff_circle_cond',int2str(i),' roi_circle pixels'])
    cd ..
    eval(['clear coeff_circle_cond',int2str(i)])
    eval(['clear cond',int2str(i),'n_dt_bl'])            
end

for i=[1 5] %condition count
    z=0;
    eval(['load cond',int2str(i),'n_dt_bl'])
    a=1;    
    eval(['b=size(cond',int2str(i),'n_dt_bl,2)/2;'])
    for p=1:size(roi_bg_in,1)
        z=z+1;
        eval(['coeff_bg_in_cond',int2str(i),'_pix_',int2str(roi_bg_in(p)),'=NaN*ones(size(pixels,1),b-win,a);'])
        for h=1:a  %trial count
            
            
            disp(['pixel #',int2str(p),' condition #',int2str(i),' trial #',int2str(h),' transforming data'])
            %eval(['load cond',int2str(i),'n_dt_bl'])
            eval(['cond',int2str(i),'n_dt_tr=mean(cond',int2str(i),'n_dt_bl(:,2:end,:),3);'])
            
                for j=1:(b-win)
                   eval(['cc=sum((repmat(cond',int2str(i),'n_dt_tr(roi_bg_in(p),j:j+win-1),[size(pixels,1) 1])-repmat(mean(cond',int2str(i),'n_dt_tr(roi_bg_in(p),j:j+win-1),2),[size(pixels,1) win])).*(cond',int2str(i),'n_dt_tr(pixels,j:j+win-1)-repmat(mean(cond',int2str(i),'n_dt_tr(pixels,j:j+win-1),2),[1 win])),2)/(win-1);'])
                   eval(['var1=repmat(std(cond',int2str(i),'n_dt_tr(roi_bg_in(p),j:j+win-1),0,2).^2,[size(pixels,1) 1]);'])
                   eval(['var2=std(cond',int2str(i),'n_dt_tr(pixels,j:j+win-1),0,2).^2;'])
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
    mkdir signal_corr
    cd signal_corr
    eval(['save coeff_bg_in_cond',int2str(i),' coeff_bg_in_cond',int2str(i),' roi_bg_in pixels'])
    cd ..
    eval(['clear coeff_bg_in_cond',int2str(i)])
    eval(['clear cond',int2str(i),'n_dt_bl'])            
end



cd F:\Data\VSDI\Contour_integration\Smeagol\29Dec2010\b

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
    a=1;    
    eval(['b=size(cond',int2str(i),'n_dt_bl,2)/2;'])
    for p=1:size(roi_circle,1)
        z=z+1;
        eval(['coeff_circle_cond',int2str(i),'_pix_',int2str(roi_circle(p)),'=NaN*ones(size(pixels,1),b-win,a);'])
        for h=1:a  %trial count
            
            
            disp(['pixel #',int2str(p),' condition #',int2str(i),' trial #',int2str(h),' transforming data'])
            %eval(['load cond',int2str(i),'n_dt_bl'])
            eval(['cond',int2str(i),'n_dt_tr=mean(cond',int2str(i),'n_dt_bl(:,2:end,:),3);'])
            
                for j=1:(b-win)
                   eval(['cc=sum((repmat(cond',int2str(i),'n_dt_tr(roi_circle(p),j:j+win-1),[size(pixels,1) 1])-repmat(mean(cond',int2str(i),'n_dt_tr(roi_circle(p),j:j+win-1),2),[size(pixels,1) win])).*(cond',int2str(i),'n_dt_tr(pixels,j:j+win-1)-repmat(mean(cond',int2str(i),'n_dt_tr(pixels,j:j+win-1),2),[1 win])),2)/(win-1);'])
                   eval(['var1=repmat(std(cond',int2str(i),'n_dt_tr(roi_circle(p),j:j+win-1),0,2).^2,[size(pixels,1) 1]);'])
                   eval(['var2=std(cond',int2str(i),'n_dt_tr(pixels,j:j+win-1),0,2).^2;'])
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
    mkdir signal_corr
    cd signal_corr
    eval(['save coeff_circle_cond',int2str(i),' coeff_circle_cond',int2str(i),' roi_circle pixels'])
    cd ..
    eval(['clear coeff_circle_cond',int2str(i)])
    eval(['clear cond',int2str(i),'n_dt_bl'])            
end

for i=[1 2 4 5] %condition count
    z=0;
    eval(['load cond',int2str(i),'n_dt_bl'])
    a=1;    
    eval(['b=size(cond',int2str(i),'n_dt_bl,2)/2;'])
    for p=1:size(roi_bg_in,1)
        z=z+1;
        eval(['coeff_bg_in_cond',int2str(i),'_pix_',int2str(roi_bg_in(p)),'=NaN*ones(size(pixels,1),b-win,a);'])
        for h=1:a  %trial count
            
            
            disp(['pixel #',int2str(p),' condition #',int2str(i),' trial #',int2str(h),' transforming data'])
            %eval(['load cond',int2str(i),'n_dt_bl'])
            eval(['cond',int2str(i),'n_dt_tr=mean(cond',int2str(i),'n_dt_bl(:,2:end,:),3);'])
            
                for j=1:(b-win)
                   eval(['cc=sum((repmat(cond',int2str(i),'n_dt_tr(roi_bg_in(p),j:j+win-1),[size(pixels,1) 1])-repmat(mean(cond',int2str(i),'n_dt_tr(roi_bg_in(p),j:j+win-1),2),[size(pixels,1) win])).*(cond',int2str(i),'n_dt_tr(pixels,j:j+win-1)-repmat(mean(cond',int2str(i),'n_dt_tr(pixels,j:j+win-1),2),[1 win])),2)/(win-1);'])
                   eval(['var1=repmat(std(cond',int2str(i),'n_dt_tr(roi_bg_in(p),j:j+win-1),0,2).^2,[size(pixels,1) 1]);'])
                   eval(['var2=std(cond',int2str(i),'n_dt_tr(pixels,j:j+win-1),0,2).^2;'])
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
    mkdir signal_corr
    cd signal_corr
    eval(['save coeff_bg_in_cond',int2str(i),' coeff_bg_in_cond',int2str(i),' roi_bg_in pixels'])
    cd ..
    eval(['clear coeff_bg_in_cond',int2str(i)])
    eval(['clear cond',int2str(i),'n_dt_bl'])            
end




cd F:\Data\VSDI\Contour_integration\Smeagol\29Dec2010\d

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
    a=1;    
    eval(['b=size(cond',int2str(i),'n_dt_bl,2)/2;'])
    for p=1:size(roi_circle,1)
        z=z+1;
        eval(['coeff_circle_cond',int2str(i),'_pix_',int2str(roi_circle(p)),'=NaN*ones(size(pixels,1),b-win,a);'])
        for h=1:a  %trial count
            
            
            disp(['pixel #',int2str(p),' condition #',int2str(i),' trial #',int2str(h),' transforming data'])
            %eval(['load cond',int2str(i),'n_dt_bl'])
            eval(['cond',int2str(i),'n_dt_tr=mean(cond',int2str(i),'n_dt_bl(:,2:end,:),3);'])
            
                for j=1:(b-win)
                   eval(['cc=sum((repmat(cond',int2str(i),'n_dt_tr(roi_circle(p),j:j+win-1),[size(pixels,1) 1])-repmat(mean(cond',int2str(i),'n_dt_tr(roi_circle(p),j:j+win-1),2),[size(pixels,1) win])).*(cond',int2str(i),'n_dt_tr(pixels,j:j+win-1)-repmat(mean(cond',int2str(i),'n_dt_tr(pixels,j:j+win-1),2),[1 win])),2)/(win-1);'])
                   eval(['var1=repmat(std(cond',int2str(i),'n_dt_tr(roi_circle(p),j:j+win-1),0,2).^2,[size(pixels,1) 1]);'])
                   eval(['var2=std(cond',int2str(i),'n_dt_tr(pixels,j:j+win-1),0,2).^2;'])
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
    mkdir signal_corr
    cd signal_corr
    eval(['save coeff_circle_cond',int2str(i),' coeff_circle_cond',int2str(i),' roi_circle pixels'])
    cd ..
    eval(['clear coeff_circle_cond',int2str(i)])
    eval(['clear cond',int2str(i),'n_dt_bl'])            
end

for i=[1 2 4 5] %condition count
    z=0;
    eval(['load cond',int2str(i),'n_dt_bl'])
    a=1;    
    eval(['b=size(cond',int2str(i),'n_dt_bl,2)/2;'])
    for p=1:size(roi_bg_in,1)
        z=z+1;
        eval(['coeff_bg_in_cond',int2str(i),'_pix_',int2str(roi_bg_in(p)),'=NaN*ones(size(pixels,1),b-win,a);'])
        for h=1:a  %trial count
            
            
            disp(['pixel #',int2str(p),' condition #',int2str(i),' trial #',int2str(h),' transforming data'])
            %eval(['load cond',int2str(i),'n_dt_bl'])
            eval(['cond',int2str(i),'n_dt_tr=mean(cond',int2str(i),'n_dt_bl(:,2:end,:),3);'])
            
                for j=1:(b-win)
                   eval(['cc=sum((repmat(cond',int2str(i),'n_dt_tr(roi_bg_in(p),j:j+win-1),[size(pixels,1) 1])-repmat(mean(cond',int2str(i),'n_dt_tr(roi_bg_in(p),j:j+win-1),2),[size(pixels,1) win])).*(cond',int2str(i),'n_dt_tr(pixels,j:j+win-1)-repmat(mean(cond',int2str(i),'n_dt_tr(pixels,j:j+win-1),2),[1 win])),2)/(win-1);'])
                   eval(['var1=repmat(std(cond',int2str(i),'n_dt_tr(roi_bg_in(p),j:j+win-1),0,2).^2,[size(pixels,1) 1]);'])
                   eval(['var2=std(cond',int2str(i),'n_dt_tr(pixels,j:j+win-1),0,2).^2;'])
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
    mkdir signal_corr
    cd signal_corr
    eval(['save coeff_bg_in_cond',int2str(i),' coeff_bg_in_cond',int2str(i),' roi_bg_in pixels'])
    cd ..
    eval(['clear coeff_bg_in_cond',int2str(i)])
    eval(['clear cond',int2str(i),'n_dt_bl'])            
end


cd F:\Data\VSDI\Contour_integration\Smeagol\05Jan2011\e

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
    a=1;    
    eval(['b=size(cond',int2str(i),'n_dt_bl,2)/2;'])
    for p=1:size(roi_circle,1)
        z=z+1;
        eval(['coeff_circle_cond',int2str(i),'_pix_',int2str(roi_circle(p)),'=NaN*ones(size(pixels,1),b-win,a);'])
        for h=1:a  %trial count
            
            
            disp(['pixel #',int2str(p),' condition #',int2str(i),' trial #',int2str(h),' transforming data'])
            %eval(['load cond',int2str(i),'n_dt_bl'])
            eval(['cond',int2str(i),'n_dt_tr=mean(cond',int2str(i),'n_dt_bl(:,2:end,:),3);'])
            
                for j=1:(b-win)
                   eval(['cc=sum((repmat(cond',int2str(i),'n_dt_tr(roi_circle(p),j:j+win-1),[size(pixels,1) 1])-repmat(mean(cond',int2str(i),'n_dt_tr(roi_circle(p),j:j+win-1),2),[size(pixels,1) win])).*(cond',int2str(i),'n_dt_tr(pixels,j:j+win-1)-repmat(mean(cond',int2str(i),'n_dt_tr(pixels,j:j+win-1),2),[1 win])),2)/(win-1);'])
                   eval(['var1=repmat(std(cond',int2str(i),'n_dt_tr(roi_circle(p),j:j+win-1),0,2).^2,[size(pixels,1) 1]);'])
                   eval(['var2=std(cond',int2str(i),'n_dt_tr(pixels,j:j+win-1),0,2).^2;'])
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
    mkdir signal_corr
    cd signal_corr
    eval(['save coeff_circle_cond',int2str(i),' coeff_circle_cond',int2str(i),' roi_circle pixels'])
    cd ..
    eval(['clear coeff_circle_cond',int2str(i)])
    eval(['clear cond',int2str(i),'n_dt_bl'])            
end

for i=[1 2 4 5] %condition count
    z=0;
    eval(['load cond',int2str(i),'n_dt_bl'])
    a=1;    
    eval(['b=size(cond',int2str(i),'n_dt_bl,2)/2;'])
    for p=1:size(roi_bg_in,1)
        z=z+1;
        eval(['coeff_bg_in_cond',int2str(i),'_pix_',int2str(roi_bg_in(p)),'=NaN*ones(size(pixels,1),b-win,a);'])
        for h=1:a  %trial count
            
            
            disp(['pixel #',int2str(p),' condition #',int2str(i),' trial #',int2str(h),' transforming data'])
            %eval(['load cond',int2str(i),'n_dt_bl'])
            eval(['cond',int2str(i),'n_dt_tr=mean(cond',int2str(i),'n_dt_bl(:,2:end,:),3);'])
            
                for j=1:(b-win)
                   eval(['cc=sum((repmat(cond',int2str(i),'n_dt_tr(roi_bg_in(p),j:j+win-1),[size(pixels,1) 1])-repmat(mean(cond',int2str(i),'n_dt_tr(roi_bg_in(p),j:j+win-1),2),[size(pixels,1) win])).*(cond',int2str(i),'n_dt_tr(pixels,j:j+win-1)-repmat(mean(cond',int2str(i),'n_dt_tr(pixels,j:j+win-1),2),[1 win])),2)/(win-1);'])
                   eval(['var1=repmat(std(cond',int2str(i),'n_dt_tr(roi_bg_in(p),j:j+win-1),0,2).^2,[size(pixels,1) 1]);'])
                   eval(['var2=std(cond',int2str(i),'n_dt_tr(pixels,j:j+win-1),0,2).^2;'])
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
    mkdir signal_corr
    cd signal_corr
    eval(['save coeff_bg_in_cond',int2str(i),' coeff_bg_in_cond',int2str(i),' roi_bg_in pixels'])
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
    a=1;    
    eval(['b=size(cond',int2str(i),'n_dt_bl,2)/2;'])
    for p=1:size(roi_circle,1)
        z=z+1;
        eval(['coeff_circle_cond',int2str(i),'_pix_',int2str(roi_circle(p)),'=NaN*ones(size(pixels,1),b-win,a);'])
        for h=1:a  %trial count
            
            
            disp(['pixel #',int2str(p),' condition #',int2str(i),' trial #',int2str(h),' transforming data'])
            %eval(['load cond',int2str(i),'n_dt_bl'])
            eval(['cond',int2str(i),'n_dt_tr=mean(cond',int2str(i),'n_dt_bl(:,2:end,:),3);'])
            
                for j=1:(b-win)
                   eval(['cc=sum((repmat(cond',int2str(i),'n_dt_tr(roi_circle(p),j:j+win-1),[size(pixels,1) 1])-repmat(mean(cond',int2str(i),'n_dt_tr(roi_circle(p),j:j+win-1),2),[size(pixels,1) win])).*(cond',int2str(i),'n_dt_tr(pixels,j:j+win-1)-repmat(mean(cond',int2str(i),'n_dt_tr(pixels,j:j+win-1),2),[1 win])),2)/(win-1);'])
                   eval(['var1=repmat(std(cond',int2str(i),'n_dt_tr(roi_circle(p),j:j+win-1),0,2).^2,[size(pixels,1) 1]);'])
                   eval(['var2=std(cond',int2str(i),'n_dt_tr(pixels,j:j+win-1),0,2).^2;'])
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
    mkdir signal_corr
    cd signal_corr
    eval(['save coeff_circle_cond',int2str(i),' coeff_circle_cond',int2str(i),' roi_circle pixels'])
    cd ..
    eval(['clear coeff_circle_cond',int2str(i)])
    eval(['clear cond',int2str(i),'n_dt_bl'])            
end

for i=[1 2 4 5] %condition count
    z=0;
    eval(['load cond',int2str(i),'n_dt_bl'])
    a=1;    
    eval(['b=size(cond',int2str(i),'n_dt_bl,2)/2;'])
    for p=1:size(roi_bg_out,1)
        z=z+1;
        eval(['coeff_bg_out_cond',int2str(i),'_pix_',int2str(roi_bg_out(p)),'=NaN*ones(size(pixels,1),b-win,a);'])
        for h=1:a  %trial count
            
            
            disp(['pixel #',int2str(p),' condition #',int2str(i),' trial #',int2str(h),' transforming data'])
            %eval(['load cond',int2str(i),'n_dt_bl'])
            eval(['cond',int2str(i),'n_dt_tr=mean(cond',int2str(i),'n_dt_bl(:,2:end,:),3);'])
            
                for j=1:(b-win)
                   eval(['cc=sum((repmat(cond',int2str(i),'n_dt_tr(roi_bg_out(p),j:j+win-1),[size(pixels,1) 1])-repmat(mean(cond',int2str(i),'n_dt_tr(roi_bg_out(p),j:j+win-1),2),[size(pixels,1) win])).*(cond',int2str(i),'n_dt_tr(pixels,j:j+win-1)-repmat(mean(cond',int2str(i),'n_dt_tr(pixels,j:j+win-1),2),[1 win])),2)/(win-1);'])
                   eval(['var1=repmat(std(cond',int2str(i),'n_dt_tr(roi_bg_out(p),j:j+win-1),0,2).^2,[size(pixels,1) 1]);'])
                   eval(['var2=std(cond',int2str(i),'n_dt_tr(pixels,j:j+win-1),0,2).^2;'])
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
    mkdir signal_corr
    cd signal_corr
    eval(['save coeff_bg_out_cond',int2str(i),' coeff_bg_out_cond',int2str(i),' roi_bg_out pixels'])
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
    a=1;    
    eval(['b=size(cond',int2str(i),'n_dt_bl,2)/2;'])
    for p=1:size(roi_circle,1)
        z=z+1;
        eval(['coeff_circle_cond',int2str(i),'_pix_',int2str(roi_circle(p)),'=NaN*ones(size(pixels,1),b-win,a);'])
        for h=1:a  %trial count
            
            
            disp(['pixel #',int2str(p),' condition #',int2str(i),' trial #',int2str(h),' transforming data'])
            %eval(['load cond',int2str(i),'n_dt_bl'])
            eval(['cond',int2str(i),'n_dt_tr=mean(cond',int2str(i),'n_dt_bl(:,2:end,:),3);'])
            
                for j=1:(b-win)
                   eval(['cc=sum((repmat(cond',int2str(i),'n_dt_tr(roi_circle(p),j:j+win-1),[size(pixels,1) 1])-repmat(mean(cond',int2str(i),'n_dt_tr(roi_circle(p),j:j+win-1),2),[size(pixels,1) win])).*(cond',int2str(i),'n_dt_tr(pixels,j:j+win-1)-repmat(mean(cond',int2str(i),'n_dt_tr(pixels,j:j+win-1),2),[1 win])),2)/(win-1);'])
                   eval(['var1=repmat(std(cond',int2str(i),'n_dt_tr(roi_circle(p),j:j+win-1),0,2).^2,[size(pixels,1) 1]);'])
                   eval(['var2=std(cond',int2str(i),'n_dt_tr(pixels,j:j+win-1),0,2).^2;'])
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
    mkdir signal_corr
    cd signal_corr
    eval(['save coeff_circle_cond',int2str(i),' coeff_circle_cond',int2str(i),' roi_circle pixels'])
    cd ..
    eval(['clear coeff_circle_cond',int2str(i)])
    eval(['clear cond',int2str(i),'n_dt_bl'])            
end

for i=[1 2 4 5] %condition count
    z=0;
    eval(['load cond',int2str(i),'n_dt_bl'])
    a=1;    
    eval(['b=size(cond',int2str(i),'n_dt_bl,2)/2;'])
    for p=1:size(roi_bg_out,1)
        z=z+1;
        eval(['coeff_bg_out_cond',int2str(i),'_pix_',int2str(roi_bg_out(p)),'=NaN*ones(size(pixels,1),b-win,a);'])
        for h=1:a  %trial count
            
            
            disp(['pixel #',int2str(p),' condition #',int2str(i),' trial #',int2str(h),' transforming data'])
            %eval(['load cond',int2str(i),'n_dt_bl'])
            eval(['cond',int2str(i),'n_dt_tr=mean(cond',int2str(i),'n_dt_bl(:,2:end,:),3);'])
            
                for j=1:(b-win)
                   eval(['cc=sum((repmat(cond',int2str(i),'n_dt_tr(roi_bg_out(p),j:j+win-1),[size(pixels,1) 1])-repmat(mean(cond',int2str(i),'n_dt_tr(roi_bg_out(p),j:j+win-1),2),[size(pixels,1) win])).*(cond',int2str(i),'n_dt_tr(pixels,j:j+win-1)-repmat(mean(cond',int2str(i),'n_dt_tr(pixels,j:j+win-1),2),[1 win])),2)/(win-1);'])
                   eval(['var1=repmat(std(cond',int2str(i),'n_dt_tr(roi_bg_out(p),j:j+win-1),0,2).^2,[size(pixels,1) 1]);'])
                   eval(['var2=std(cond',int2str(i),'n_dt_tr(pixels,j:j+win-1),0,2).^2;'])
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
    mkdir signal_corr
    cd signal_corr
    eval(['save coeff_bg_out_cond',int2str(i),' coeff_bg_out_cond',int2str(i),' roi_bg_out pixels'])
    cd ..
    eval(['clear coeff_bg_out_cond',int2str(i)])
    eval(['clear cond',int2str(i),'n_dt_bl'])            
end

cd F:\Data\VSDI\Contour_integration\Smeagol\29Dec2010\k

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
    a=1;    
    eval(['b=size(cond',int2str(i),'n_dt_bl,2)/2;'])
    for p=1:size(roi_circle,1)
        z=z+1;
        eval(['coeff_circle_cond',int2str(i),'_pix_',int2str(roi_circle(p)),'=NaN*ones(size(pixels,1),b-win,a);'])
        for h=1:a  %trial count
            
            
            disp(['pixel #',int2str(p),' condition #',int2str(i),' trial #',int2str(h),' transforming data'])
            %eval(['load cond',int2str(i),'n_dt_bl'])
            eval(['cond',int2str(i),'n_dt_tr=mean(cond',int2str(i),'n_dt_bl(:,2:end,:),3);'])
            
                for j=1:(b-win)
                   eval(['cc=sum((repmat(cond',int2str(i),'n_dt_tr(roi_circle(p),j:j+win-1),[size(pixels,1) 1])-repmat(mean(cond',int2str(i),'n_dt_tr(roi_circle(p),j:j+win-1),2),[size(pixels,1) win])).*(cond',int2str(i),'n_dt_tr(pixels,j:j+win-1)-repmat(mean(cond',int2str(i),'n_dt_tr(pixels,j:j+win-1),2),[1 win])),2)/(win-1);'])
                   eval(['var1=repmat(std(cond',int2str(i),'n_dt_tr(roi_circle(p),j:j+win-1),0,2).^2,[size(pixels,1) 1]);'])
                   eval(['var2=std(cond',int2str(i),'n_dt_tr(pixels,j:j+win-1),0,2).^2;'])
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
    mkdir signal_corr
    cd signal_corr
    eval(['save coeff_circle_cond',int2str(i),' coeff_circle_cond',int2str(i),' roi_circle pixels'])
    cd ..
    eval(['clear coeff_circle_cond',int2str(i)])
    eval(['clear cond',int2str(i),'n_dt_bl'])            
end

for i=[1 2 4 5] %condition count
    z=0;
    eval(['load cond',int2str(i),'n_dt_bl'])
    a=1;    
    eval(['b=size(cond',int2str(i),'n_dt_bl,2)/2;'])
    for p=1:size(roi_bg_out,1)
        z=z+1;
        eval(['coeff_bg_out_cond',int2str(i),'_pix_',int2str(roi_bg_out(p)),'=NaN*ones(size(pixels,1),b-win,a);'])
        for h=1:a  %trial count
            
            
            disp(['pixel #',int2str(p),' condition #',int2str(i),' trial #',int2str(h),' transforming data'])
            %eval(['load cond',int2str(i),'n_dt_bl'])
            eval(['cond',int2str(i),'n_dt_tr=mean(cond',int2str(i),'n_dt_bl(:,2:end,:),3);'])
            
                for j=1:(b-win)
                   eval(['cc=sum((repmat(cond',int2str(i),'n_dt_tr(roi_bg_out(p),j:j+win-1),[size(pixels,1) 1])-repmat(mean(cond',int2str(i),'n_dt_tr(roi_bg_out(p),j:j+win-1),2),[size(pixels,1) win])).*(cond',int2str(i),'n_dt_tr(pixels,j:j+win-1)-repmat(mean(cond',int2str(i),'n_dt_tr(pixels,j:j+win-1),2),[1 win])),2)/(win-1);'])
                   eval(['var1=repmat(std(cond',int2str(i),'n_dt_tr(roi_bg_out(p),j:j+win-1),0,2).^2,[size(pixels,1) 1]);'])
                   eval(['var2=std(cond',int2str(i),'n_dt_tr(pixels,j:j+win-1),0,2).^2;'])
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
    mkdir signal_corr
    cd signal_corr
    eval(['save coeff_bg_out_cond',int2str(i),' coeff_bg_out_cond',int2str(i),' roi_bg_out pixels'])
    cd ..
    eval(['clear coeff_bg_out_cond',int2str(i)])
    eval(['clear cond',int2str(i),'n_dt_bl'])            
end

cd F:\Data\VSDI\Contour_integration\Smeagol\05Jan2011\b

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
    a=1;    
    eval(['b=size(cond',int2str(i),'n_dt_bl,2)/2;'])
    for p=1:size(roi_circle,1)
        z=z+1;
        eval(['coeff_circle_cond',int2str(i),'_pix_',int2str(roi_circle(p)),'=NaN*ones(size(pixels,1),b-win,a);'])
        for h=1:a  %trial count
            
            
            disp(['pixel #',int2str(p),' condition #',int2str(i),' trial #',int2str(h),' transforming data'])
            %eval(['load cond',int2str(i),'n_dt_bl'])
            eval(['cond',int2str(i),'n_dt_tr=mean(cond',int2str(i),'n_dt_bl(:,2:end,:),3);'])
            
                for j=1:(b-win)
                   eval(['cc=sum((repmat(cond',int2str(i),'n_dt_tr(roi_circle(p),j:j+win-1),[size(pixels,1) 1])-repmat(mean(cond',int2str(i),'n_dt_tr(roi_circle(p),j:j+win-1),2),[size(pixels,1) win])).*(cond',int2str(i),'n_dt_tr(pixels,j:j+win-1)-repmat(mean(cond',int2str(i),'n_dt_tr(pixels,j:j+win-1),2),[1 win])),2)/(win-1);'])
                   eval(['var1=repmat(std(cond',int2str(i),'n_dt_tr(roi_circle(p),j:j+win-1),0,2).^2,[size(pixels,1) 1]);'])
                   eval(['var2=std(cond',int2str(i),'n_dt_tr(pixels,j:j+win-1),0,2).^2;'])
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
    mkdir signal_corr
    cd signal_corr
    eval(['save coeff_circle_cond',int2str(i),' coeff_circle_cond',int2str(i),' roi_circle pixels'])
    cd ..
    eval(['clear coeff_circle_cond',int2str(i)])
    eval(['clear cond',int2str(i),'n_dt_bl'])            
end

for i=[1 2 4 5] %condition count
    z=0;
    eval(['load cond',int2str(i),'n_dt_bl'])
    a=1;    
    eval(['b=size(cond',int2str(i),'n_dt_bl,2)/2;'])
    for p=1:size(roi_bg_out,1)
        z=z+1;
        eval(['coeff_bg_out_cond',int2str(i),'_pix_',int2str(roi_bg_out(p)),'=NaN*ones(size(pixels,1),b-win,a);'])
        for h=1:a  %trial count
            
            
            disp(['pixel #',int2str(p),' condition #',int2str(i),' trial #',int2str(h),' transforming data'])
            %eval(['load cond',int2str(i),'n_dt_bl'])
            eval(['cond',int2str(i),'n_dt_tr=mean(cond',int2str(i),'n_dt_bl(:,2:end,:),3);'])
            
                for j=1:(b-win)
                   eval(['cc=sum((repmat(cond',int2str(i),'n_dt_tr(roi_bg_out(p),j:j+win-1),[size(pixels,1) 1])-repmat(mean(cond',int2str(i),'n_dt_tr(roi_bg_out(p),j:j+win-1),2),[size(pixels,1) win])).*(cond',int2str(i),'n_dt_tr(pixels,j:j+win-1)-repmat(mean(cond',int2str(i),'n_dt_tr(pixels,j:j+win-1),2),[1 win])),2)/(win-1);'])
                   eval(['var1=repmat(std(cond',int2str(i),'n_dt_tr(roi_bg_out(p),j:j+win-1),0,2).^2,[size(pixels,1) 1]);'])
                   eval(['var2=std(cond',int2str(i),'n_dt_tr(pixels,j:j+win-1),0,2).^2;'])
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
    mkdir signal_corr
    cd signal_corr
    eval(['save coeff_bg_out_cond',int2str(i),' coeff_bg_out_cond',int2str(i),' roi_bg_out pixels'])
    cd ..
    eval(['clear coeff_bg_out_cond',int2str(i)])
    eval(['clear cond',int2str(i),'n_dt_bl'])            
end

cd F:\Data\VSDI\Contour_integration\Smeagol\05Jan2011\c

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
    a=1;    
    eval(['b=size(cond',int2str(i),'n_dt_bl,2)/2;'])
    for p=1:size(roi_circle,1)
        z=z+1;
        eval(['coeff_circle_cond',int2str(i),'_pix_',int2str(roi_circle(p)),'=NaN*ones(size(pixels,1),b-win,a);'])
        for h=1:a  %trial count
            
            
            disp(['pixel #',int2str(p),' condition #',int2str(i),' trial #',int2str(h),' transforming data'])
            %eval(['load cond',int2str(i),'n_dt_bl'])
            eval(['cond',int2str(i),'n_dt_tr=mean(cond',int2str(i),'n_dt_bl(:,2:end,:),3);'])
            
                for j=1:(b-win)
                   eval(['cc=sum((repmat(cond',int2str(i),'n_dt_tr(roi_circle(p),j:j+win-1),[size(pixels,1) 1])-repmat(mean(cond',int2str(i),'n_dt_tr(roi_circle(p),j:j+win-1),2),[size(pixels,1) win])).*(cond',int2str(i),'n_dt_tr(pixels,j:j+win-1)-repmat(mean(cond',int2str(i),'n_dt_tr(pixels,j:j+win-1),2),[1 win])),2)/(win-1);'])
                   eval(['var1=repmat(std(cond',int2str(i),'n_dt_tr(roi_circle(p),j:j+win-1),0,2).^2,[size(pixels,1) 1]);'])
                   eval(['var2=std(cond',int2str(i),'n_dt_tr(pixels,j:j+win-1),0,2).^2;'])
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
    mkdir signal_corr
    cd signal_corr
    eval(['save coeff_circle_cond',int2str(i),' coeff_circle_cond',int2str(i),' roi_circle pixels'])
    cd ..
    eval(['clear coeff_circle_cond',int2str(i)])
    eval(['clear cond',int2str(i),'n_dt_bl'])            
end

for i=[1 5] %condition count
    z=0;
    eval(['load cond',int2str(i),'n_dt_bl'])
    a=1;    
    eval(['b=size(cond',int2str(i),'n_dt_bl,2)/2;'])
    for p=1:size(roi_bg_out,1)
        z=z+1;
        eval(['coeff_bg_out_cond',int2str(i),'_pix_',int2str(roi_bg_out(p)),'=NaN*ones(size(pixels,1),b-win,a);'])
        for h=1:a  %trial count
            
            
            disp(['pixel #',int2str(p),' condition #',int2str(i),' trial #',int2str(h),' transforming data'])
            %eval(['load cond',int2str(i),'n_dt_bl'])
            eval(['cond',int2str(i),'n_dt_tr=mean(cond',int2str(i),'n_dt_bl(:,2:end,:),3);'])
            
                for j=1:(b-win)
                   eval(['cc=sum((repmat(cond',int2str(i),'n_dt_tr(roi_bg_out(p),j:j+win-1),[size(pixels,1) 1])-repmat(mean(cond',int2str(i),'n_dt_tr(roi_bg_out(p),j:j+win-1),2),[size(pixels,1) win])).*(cond',int2str(i),'n_dt_tr(pixels,j:j+win-1)-repmat(mean(cond',int2str(i),'n_dt_tr(pixels,j:j+win-1),2),[1 win])),2)/(win-1);'])
                   eval(['var1=repmat(std(cond',int2str(i),'n_dt_tr(roi_bg_out(p),j:j+win-1),0,2).^2,[size(pixels,1) 1]);'])
                   eval(['var2=std(cond',int2str(i),'n_dt_tr(pixels,j:j+win-1),0,2).^2;'])
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
    mkdir signal_corr
    cd signal_corr
    eval(['save coeff_bg_out_cond',int2str(i),' coeff_bg_out_cond',int2str(i),' roi_bg_out pixels'])
    cd ..
    eval(['clear coeff_bg_out_cond',int2str(i)])
    eval(['clear cond',int2str(i),'n_dt_bl'])            
end

cd F:\Data\VSDI\Contour_integration\Smeagol\05Jan2011\d

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
    a=1;    
    eval(['b=size(cond',int2str(i),'n_dt_bl,2)/2;'])
    for p=1:size(roi_circle,1)
        z=z+1;
        eval(['coeff_circle_cond',int2str(i),'_pix_',int2str(roi_circle(p)),'=NaN*ones(size(pixels,1),b-win,a);'])
        for h=1:a  %trial count
            
            
            disp(['pixel #',int2str(p),' condition #',int2str(i),' trial #',int2str(h),' transforming data'])
            %eval(['load cond',int2str(i),'n_dt_bl'])
            eval(['cond',int2str(i),'n_dt_tr=mean(cond',int2str(i),'n_dt_bl(:,2:end,:),3);'])
            
                for j=1:(b-win)
                   eval(['cc=sum((repmat(cond',int2str(i),'n_dt_tr(roi_circle(p),j:j+win-1),[size(pixels,1) 1])-repmat(mean(cond',int2str(i),'n_dt_tr(roi_circle(p),j:j+win-1),2),[size(pixels,1) win])).*(cond',int2str(i),'n_dt_tr(pixels,j:j+win-1)-repmat(mean(cond',int2str(i),'n_dt_tr(pixels,j:j+win-1),2),[1 win])),2)/(win-1);'])
                   eval(['var1=repmat(std(cond',int2str(i),'n_dt_tr(roi_circle(p),j:j+win-1),0,2).^2,[size(pixels,1) 1]);'])
                   eval(['var2=std(cond',int2str(i),'n_dt_tr(pixels,j:j+win-1),0,2).^2;'])
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
    mkdir signal_corr
    cd signal_corr
    eval(['save coeff_circle_cond',int2str(i),' coeff_circle_cond',int2str(i),' roi_circle pixels'])
    cd ..
    eval(['clear coeff_circle_cond',int2str(i)])
    eval(['clear cond',int2str(i),'n_dt_bl'])            
end

for i=[1 5] %condition count
    z=0;
    eval(['load cond',int2str(i),'n_dt_bl'])
    a=1;    
    eval(['b=size(cond',int2str(i),'n_dt_bl,2)/2;'])
    for p=1:size(roi_bg_out,1)
        z=z+1;
        eval(['coeff_bg_out_cond',int2str(i),'_pix_',int2str(roi_bg_out(p)),'=NaN*ones(size(pixels,1),b-win,a);'])
        for h=1:a  %trial count
            
            
            disp(['pixel #',int2str(p),' condition #',int2str(i),' trial #',int2str(h),' transforming data'])
            %eval(['load cond',int2str(i),'n_dt_bl'])
            eval(['cond',int2str(i),'n_dt_tr=mean(cond',int2str(i),'n_dt_bl(:,2:end,:),3);'])
            
                for j=1:(b-win)
                   eval(['cc=sum((repmat(cond',int2str(i),'n_dt_tr(roi_bg_out(p),j:j+win-1),[size(pixels,1) 1])-repmat(mean(cond',int2str(i),'n_dt_tr(roi_bg_out(p),j:j+win-1),2),[size(pixels,1) win])).*(cond',int2str(i),'n_dt_tr(pixels,j:j+win-1)-repmat(mean(cond',int2str(i),'n_dt_tr(pixels,j:j+win-1),2),[1 win])),2)/(win-1);'])
                   eval(['var1=repmat(std(cond',int2str(i),'n_dt_tr(roi_bg_out(p),j:j+win-1),0,2).^2,[size(pixels,1) 1]);'])
                   eval(['var2=std(cond',int2str(i),'n_dt_tr(pixels,j:j+win-1),0,2).^2;'])
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
    mkdir signal_corr
    cd signal_corr
    eval(['save coeff_bg_out_cond',int2str(i),' coeff_bg_out_cond',int2str(i),' roi_bg_out pixels'])
    cd ..
    eval(['clear coeff_bg_out_cond',int2str(i)])
    eval(['clear cond',int2str(i),'n_dt_bl'])            
end


