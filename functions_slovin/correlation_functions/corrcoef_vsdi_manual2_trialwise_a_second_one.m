

cd F:\Data\VSDI\figure_figure\tolkin\16june2011\e

load pixels_to_remove
t=ones(10000,1);
t(pixels_to_remove)=0;
pixels=find(t);
clear t

load myrois3

win=8;

for i=[1 2 4 5] %condition count
    z=0;
    eval(['load cond',int2str(i),'n_dt_bl'])
    eval(['a=size(cond',int2str(i),'n_dt_bl,3);'])    
    eval(['b=size(cond',int2str(i),'n_dt_bl,2)/2;'])
    for p=1:size(roi_top_clean,1)
        z=z+1;
        eval(['coeff_top_clean_cond',int2str(i),'_pix_',int2str(roi_top_clean(p)),'=NaN*ones(size(pixels,1),b-win,a);'])
        for h=1:a  %trial count
            
            
            disp(['pixel #',int2str(p),' condition #',int2str(i),' trial #',int2str(h),' transforming data'])
            %eval(['load cond',int2str(i),'n_dt_bl'])
            eval(['cond',int2str(i),'n_dt_tr=cond',int2str(i),'n_dt_bl(:,2:end,h);'])
            
                for j=1:(b-win)
                   eval(['cc=sum((repmat(cond',int2str(i),'n_dt_tr(roi_top_clean(p),j:j+win-1),[size(pixels,1) 1])-repmat(mean(cond',int2str(i),'n_dt_tr(roi_top_clean(p),j:j+win-1),2),[size(pixels,1) win])).*(cond',int2str(i),'n_dt_tr(pixels,j:j+win-1)-repmat(mean(cond',int2str(i),'n_dt_tr(pixels,j:j+win-1),2),[1 win])),2)/(win-1);'])
                   eval(['var1=repmat(std(cond',int2str(i),'n_dt_tr(roi_top_clean(p),j:j+win-1),0,2).^2,[size(pixels,1) 1]);'])
                   eval(['var2=std(cond',int2str(i),'n_dt_tr(pixels,j:j+win-1),0,2).^2;'])
                   eval(['coeff_top_clean_cond',int2str(i),'_pix_',int2str(roi_top_clean(p)),'(:,j,h)=cc./sqrt(var1.*var2);']) 
                end;
            
        end;
        if z==1
            eval(['coeff_top_clean_cond',int2str(i),'=coeff_top_clean_cond',int2str(i),'_pix_',int2str(roi_top_clean(p)),';'])    
        else
            eval(['coeff_top_clean_cond',int2str(i),'=coeff_top_clean_cond',int2str(i),'+coeff_top_clean_cond',int2str(i),'_pix_',int2str(roi_top_clean(p)),';'])
        end 
        eval(['clear coeff_top_clean_cond',int2str(i),'_pix_',int2str(roi_top_clean(p))])
    end;
    eval(['coeff_top_clean_cond',int2str(i),'=coeff_top_clean_cond',int2str(i),'/size(roi_top_clean,1);'])
    cd pixels
    eval(['save coeff_top_clean_cond',int2str(i),' coeff_top_clean_cond',int2str(i),' roi_top_clean pixels'])
    cd ..
    eval(['clear coeff_top_clean_cond',int2str(i)])
    eval(['clear cond',int2str(i),'n_dt_bl'])            
end




cd F:\Data\VSDI\figure_figure\tolkin\16june2011\e

load pixels_to_remove
t=ones(10000,1);
t(pixels_to_remove)=0;
pixels=find(t);
clear t

load myrois3

win=8;

for i=[1 2 4 5] %condition count
    z=0;
    eval(['load cond',int2str(i),'n_dt_bl'])
    eval(['a=size(cond',int2str(i),'n_dt_bl,3);'])    
    eval(['b=size(cond',int2str(i),'n_dt_bl,2)/2;'])
    for p=1:size(roi_bottom_clean,1)
        z=z+1;
        eval(['coeff_bottom_clean_cond',int2str(i),'_pix_',int2str(roi_bottom_clean(p)),'=NaN*ones(size(pixels,1),b-win,a);'])
        for h=1:a  %trial count
            
            
            disp(['pixel #',int2str(p),' condition #',int2str(i),' trial #',int2str(h),' transforming data'])
            %eval(['load cond',int2str(i),'n_dt_bl'])
            eval(['cond',int2str(i),'n_dt_tr=cond',int2str(i),'n_dt_bl(:,2:end,h);'])
            
                for j=1:(b-win)
                   eval(['cc=sum((repmat(cond',int2str(i),'n_dt_tr(roi_bottom_clean(p),j:j+win-1),[size(pixels,1) 1])-repmat(mean(cond',int2str(i),'n_dt_tr(roi_bottom_clean(p),j:j+win-1),2),[size(pixels,1) win])).*(cond',int2str(i),'n_dt_tr(pixels,j:j+win-1)-repmat(mean(cond',int2str(i),'n_dt_tr(pixels,j:j+win-1),2),[1 win])),2)/(win-1);'])
                   eval(['var1=repmat(std(cond',int2str(i),'n_dt_tr(roi_bottom_clean(p),j:j+win-1),0,2).^2,[size(pixels,1) 1]);'])
                   eval(['var2=std(cond',int2str(i),'n_dt_tr(pixels,j:j+win-1),0,2).^2;'])
                   eval(['coeff_bottom_clean_cond',int2str(i),'_pix_',int2str(roi_bottom_clean(p)),'(:,j,h)=cc./sqrt(var1.*var2);']) 
                end;
            
        end;
        if z==1
            eval(['coeff_bottom_clean_cond',int2str(i),'=coeff_bottom_clean_cond',int2str(i),'_pix_',int2str(roi_bottom_clean(p)),';'])    
        else
            eval(['coeff_bottom_clean_cond',int2str(i),'=coeff_bottom_clean_cond',int2str(i),'+coeff_bottom_clean_cond',int2str(i),'_pix_',int2str(roi_bottom_clean(p)),';'])
        end 
        eval(['clear coeff_bottom_clean_cond',int2str(i),'_pix_',int2str(roi_bottom_clean(p))])
    end;
    eval(['coeff_bottom_clean_cond',int2str(i),'=coeff_bottom_clean_cond',int2str(i),'/size(roi_bottom_clean,1);'])
    cd pixels
    eval(['save coeff_bottom_clean_cond',int2str(i),' coeff_bottom_clean_cond',int2str(i),' roi_bottom_clean pixels'])
    cd ..
    eval(['clear coeff_bottom_clean_cond',int2str(i)])
    eval(['clear cond',int2str(i),'n_dt_bl'])            
end


cd F:\Data\VSDI\figure_figure\tolkin\16june2011\e\no_stim

load pixels_to_remove
t=ones(10000,1);
t(pixels_to_remove)=0;
pixels=find(t);
clear t

load myrois3

win=8;

for i=[1 2 4 5] %condition count
    z=0;
    eval(['load cond',int2str(i),'n_dt_bl'])
    eval(['a=size(cond',int2str(i),'n_dt_bl,3);'])    
    eval(['b=size(cond',int2str(i),'n_dt_bl,2)/2;'])
    for p=1:size(roi_top_clean,1)
        z=z+1;
        eval(['coeff_top_clean_cond',int2str(i),'_pix_',int2str(roi_top_clean(p)),'=NaN*ones(size(pixels,1),b-win,a);'])
        for h=1:a  %trial count
            
            
            disp(['pixel #',int2str(p),' condition #',int2str(i),' trial #',int2str(h),' transforming data'])
            %eval(['load cond',int2str(i),'n_dt_bl'])
            eval(['cond',int2str(i),'n_dt_tr=cond',int2str(i),'n_dt_bl(:,2:end,h);'])
            
                for j=1:(b-win)
                   eval(['cc=sum((repmat(cond',int2str(i),'n_dt_tr(roi_top_clean(p),j:j+win-1),[size(pixels,1) 1])-repmat(mean(cond',int2str(i),'n_dt_tr(roi_top_clean(p),j:j+win-1),2),[size(pixels,1) win])).*(cond',int2str(i),'n_dt_tr(pixels,j:j+win-1)-repmat(mean(cond',int2str(i),'n_dt_tr(pixels,j:j+win-1),2),[1 win])),2)/(win-1);'])
                   eval(['var1=repmat(std(cond',int2str(i),'n_dt_tr(roi_top_clean(p),j:j+win-1),0,2).^2,[size(pixels,1) 1]);'])
                   eval(['var2=std(cond',int2str(i),'n_dt_tr(pixels,j:j+win-1),0,2).^2;'])
                   eval(['coeff_top_clean_cond',int2str(i),'_pix_',int2str(roi_top_clean(p)),'(:,j,h)=cc./sqrt(var1.*var2);']) 
                end;
            
        end;
        if z==1
            eval(['coeff_top_clean_cond',int2str(i),'=coeff_top_clean_cond',int2str(i),'_pix_',int2str(roi_top_clean(p)),';'])    
        else
            eval(['coeff_top_clean_cond',int2str(i),'=coeff_top_clean_cond',int2str(i),'+coeff_top_clean_cond',int2str(i),'_pix_',int2str(roi_top_clean(p)),';'])
        end 
        eval(['clear coeff_top_clean_cond',int2str(i),'_pix_',int2str(roi_top_clean(p))])
    end;
    eval(['coeff_top_clean_cond',int2str(i),'=coeff_top_clean_cond',int2str(i),'/size(roi_top_clean,1);'])
    cd pixels
    eval(['save coeff_top_clean_cond',int2str(i),' coeff_top_clean_cond',int2str(i),' roi_top_clean pixels'])
    cd ..
    eval(['clear coeff_top_clean_cond',int2str(i)])
    eval(['clear cond',int2str(i),'n_dt_bl'])            
end




cd F:\Data\VSDI\figure_figure\tolkin\16june2011\e\no_stim

load pixels_to_remove
t=ones(10000,1);
t(pixels_to_remove)=0;
pixels=find(t);
clear t

load myrois3

win=8;

for i=[1 2 4 5] %condition count
    z=0;
    eval(['load cond',int2str(i),'n_dt_bl'])
    eval(['a=size(cond',int2str(i),'n_dt_bl,3);'])    
    eval(['b=size(cond',int2str(i),'n_dt_bl,2)/2;'])
    for p=1:size(roi_bottom_clean,1)
        z=z+1;
        eval(['coeff_bottom_clean_cond',int2str(i),'_pix_',int2str(roi_bottom_clean(p)),'=NaN*ones(size(pixels,1),b-win,a);'])
        for h=1:a  %trial count
            
            
            disp(['pixel #',int2str(p),' condition #',int2str(i),' trial #',int2str(h),' transforming data'])
            %eval(['load cond',int2str(i),'n_dt_bl'])
            eval(['cond',int2str(i),'n_dt_tr=cond',int2str(i),'n_dt_bl(:,2:end,h);'])
            
                for j=1:(b-win)
                   eval(['cc=sum((repmat(cond',int2str(i),'n_dt_tr(roi_bottom_clean(p),j:j+win-1),[size(pixels,1) 1])-repmat(mean(cond',int2str(i),'n_dt_tr(roi_bottom_clean(p),j:j+win-1),2),[size(pixels,1) win])).*(cond',int2str(i),'n_dt_tr(pixels,j:j+win-1)-repmat(mean(cond',int2str(i),'n_dt_tr(pixels,j:j+win-1),2),[1 win])),2)/(win-1);'])
                   eval(['var1=repmat(std(cond',int2str(i),'n_dt_tr(roi_bottom_clean(p),j:j+win-1),0,2).^2,[size(pixels,1) 1]);'])
                   eval(['var2=std(cond',int2str(i),'n_dt_tr(pixels,j:j+win-1),0,2).^2;'])
                   eval(['coeff_bottom_clean_cond',int2str(i),'_pix_',int2str(roi_bottom_clean(p)),'(:,j,h)=cc./sqrt(var1.*var2);']) 
                end;
            
        end;
        if z==1
            eval(['coeff_bottom_clean_cond',int2str(i),'=coeff_bottom_clean_cond',int2str(i),'_pix_',int2str(roi_bottom_clean(p)),';'])    
        else
            eval(['coeff_bottom_clean_cond',int2str(i),'=coeff_bottom_clean_cond',int2str(i),'+coeff_bottom_clean_cond',int2str(i),'_pix_',int2str(roi_bottom_clean(p)),';'])
        end 
        eval(['clear coeff_bottom_clean_cond',int2str(i),'_pix_',int2str(roi_bottom_clean(p))])
    end;
    eval(['coeff_bottom_clean_cond',int2str(i),'=coeff_bottom_clean_cond',int2str(i),'/size(roi_bottom_clean,1);'])
    cd pixels
    eval(['save coeff_bottom_clean_cond',int2str(i),' coeff_bottom_clean_cond',int2str(i),' roi_bottom_clean pixels'])
    cd ..
    eval(['clear coeff_bottom_clean_cond',int2str(i)])
    eval(['clear cond',int2str(i),'n_dt_bl'])            
end







cd F:\Data\VSDI\figure_figure\tolkin\27july2011\g

load pixels_to_remove
t=ones(10000,1);
t(pixels_to_remove)=0;
pixels=find(t);
clear t

load myrois3

win=8;

for i=[1 2 4 5] %condition count
    z=0;
    eval(['load cond',int2str(i),'n_dt_bl'])
    eval(['a=size(cond',int2str(i),'n_dt_bl,3);'])    
    eval(['b=size(cond',int2str(i),'n_dt_bl,2)/2;'])
    for p=1:size(roi_top_clean,1)
        z=z+1;
        eval(['coeff_top_clean_cond',int2str(i),'_pix_',int2str(roi_top_clean(p)),'=NaN*ones(size(pixels,1),b-win,a);'])
        for h=1:a  %trial count
            
            
            disp(['pixel #',int2str(p),' condition #',int2str(i),' trial #',int2str(h),' transforming data'])
            %eval(['load cond',int2str(i),'n_dt_bl'])
            eval(['cond',int2str(i),'n_dt_tr=cond',int2str(i),'n_dt_bl(:,2:end,h);'])
            
                for j=1:(b-win)
                   eval(['cc=sum((repmat(cond',int2str(i),'n_dt_tr(roi_top_clean(p),j:j+win-1),[size(pixels,1) 1])-repmat(mean(cond',int2str(i),'n_dt_tr(roi_top_clean(p),j:j+win-1),2),[size(pixels,1) win])).*(cond',int2str(i),'n_dt_tr(pixels,j:j+win-1)-repmat(mean(cond',int2str(i),'n_dt_tr(pixels,j:j+win-1),2),[1 win])),2)/(win-1);'])
                   eval(['var1=repmat(std(cond',int2str(i),'n_dt_tr(roi_top_clean(p),j:j+win-1),0,2).^2,[size(pixels,1) 1]);'])
                   eval(['var2=std(cond',int2str(i),'n_dt_tr(pixels,j:j+win-1),0,2).^2;'])
                   eval(['coeff_top_clean_cond',int2str(i),'_pix_',int2str(roi_top_clean(p)),'(:,j,h)=cc./sqrt(var1.*var2);']) 
                end;
            
        end;
        if z==1
            eval(['coeff_top_clean_cond',int2str(i),'=coeff_top_clean_cond',int2str(i),'_pix_',int2str(roi_top_clean(p)),';'])    
        else
            eval(['coeff_top_clean_cond',int2str(i),'=coeff_top_clean_cond',int2str(i),'+coeff_top_clean_cond',int2str(i),'_pix_',int2str(roi_top_clean(p)),';'])
        end 
        eval(['clear coeff_top_clean_cond',int2str(i),'_pix_',int2str(roi_top_clean(p))])
    end;
    eval(['coeff_top_clean_cond',int2str(i),'=coeff_top_clean_cond',int2str(i),'/size(roi_top_clean,1);'])
    cd pixels
    eval(['save coeff_top_clean_cond',int2str(i),' coeff_top_clean_cond',int2str(i),' roi_top_clean pixels'])
    cd ..
    eval(['clear coeff_top_clean_cond',int2str(i)])
    eval(['clear cond',int2str(i),'n_dt_bl'])            
end




cd F:\Data\VSDI\figure_figure\tolkin\27july2011\g

load pixels_to_remove
t=ones(10000,1);
t(pixels_to_remove)=0;
pixels=find(t);
clear t

load myrois3

win=8;

for i=[1 2 4 5] %condition count
    z=0;
    eval(['load cond',int2str(i),'n_dt_bl'])
    eval(['a=size(cond',int2str(i),'n_dt_bl,3);'])    
    eval(['b=size(cond',int2str(i),'n_dt_bl,2)/2;'])
    for p=1:size(roi_bottom_clean,1)
        z=z+1;
        eval(['coeff_bottom_clean_cond',int2str(i),'_pix_',int2str(roi_bottom_clean(p)),'=NaN*ones(size(pixels,1),b-win,a);'])
        for h=1:a  %trial count
            
            
            disp(['pixel #',int2str(p),' condition #',int2str(i),' trial #',int2str(h),' transforming data'])
            %eval(['load cond',int2str(i),'n_dt_bl'])
            eval(['cond',int2str(i),'n_dt_tr=cond',int2str(i),'n_dt_bl(:,2:end,h);'])
            
                for j=1:(b-win)
                   eval(['cc=sum((repmat(cond',int2str(i),'n_dt_tr(roi_bottom_clean(p),j:j+win-1),[size(pixels,1) 1])-repmat(mean(cond',int2str(i),'n_dt_tr(roi_bottom_clean(p),j:j+win-1),2),[size(pixels,1) win])).*(cond',int2str(i),'n_dt_tr(pixels,j:j+win-1)-repmat(mean(cond',int2str(i),'n_dt_tr(pixels,j:j+win-1),2),[1 win])),2)/(win-1);'])
                   eval(['var1=repmat(std(cond',int2str(i),'n_dt_tr(roi_bottom_clean(p),j:j+win-1),0,2).^2,[size(pixels,1) 1]);'])
                   eval(['var2=std(cond',int2str(i),'n_dt_tr(pixels,j:j+win-1),0,2).^2;'])
                   eval(['coeff_bottom_clean_cond',int2str(i),'_pix_',int2str(roi_bottom_clean(p)),'(:,j,h)=cc./sqrt(var1.*var2);']) 
                end;
            
        end;
        if z==1
            eval(['coeff_bottom_clean_cond',int2str(i),'=coeff_bottom_clean_cond',int2str(i),'_pix_',int2str(roi_bottom_clean(p)),';'])    
        else
            eval(['coeff_bottom_clean_cond',int2str(i),'=coeff_bottom_clean_cond',int2str(i),'+coeff_bottom_clean_cond',int2str(i),'_pix_',int2str(roi_bottom_clean(p)),';'])
        end 
        eval(['clear coeff_bottom_clean_cond',int2str(i),'_pix_',int2str(roi_bottom_clean(p))])
    end;
    eval(['coeff_bottom_clean_cond',int2str(i),'=coeff_bottom_clean_cond',int2str(i),'/size(roi_bottom_clean,1);'])
    cd pixels
    eval(['save coeff_bottom_clean_cond',int2str(i),' coeff_bottom_clean_cond',int2str(i),' roi_bottom_clean pixels'])
    cd ..
    eval(['clear coeff_bottom_clean_cond',int2str(i)])
    eval(['clear cond',int2str(i),'n_dt_bl'])            
end


cd F:\Data\VSDI\figure_figure\tolkin\27july2011\g\no_stim

load pixels_to_remove
t=ones(10000,1);
t(pixels_to_remove)=0;
pixels=find(t);
clear t

load myrois3

win=8;

for i=[1 2 4 5] %condition count
    z=0;
    eval(['load cond',int2str(i),'n_dt_bl'])
    eval(['a=size(cond',int2str(i),'n_dt_bl,3);'])    
    eval(['b=size(cond',int2str(i),'n_dt_bl,2)/2;'])
    for p=1:size(roi_top_clean,1)
        z=z+1;
        eval(['coeff_top_clean_cond',int2str(i),'_pix_',int2str(roi_top_clean(p)),'=NaN*ones(size(pixels,1),b-win,a);'])
        for h=1:a  %trial count
            
            
            disp(['pixel #',int2str(p),' condition #',int2str(i),' trial #',int2str(h),' transforming data'])
            %eval(['load cond',int2str(i),'n_dt_bl'])
            eval(['cond',int2str(i),'n_dt_tr=cond',int2str(i),'n_dt_bl(:,2:end,h);'])
            
                for j=1:(b-win)
                   eval(['cc=sum((repmat(cond',int2str(i),'n_dt_tr(roi_top_clean(p),j:j+win-1),[size(pixels,1) 1])-repmat(mean(cond',int2str(i),'n_dt_tr(roi_top_clean(p),j:j+win-1),2),[size(pixels,1) win])).*(cond',int2str(i),'n_dt_tr(pixels,j:j+win-1)-repmat(mean(cond',int2str(i),'n_dt_tr(pixels,j:j+win-1),2),[1 win])),2)/(win-1);'])
                   eval(['var1=repmat(std(cond',int2str(i),'n_dt_tr(roi_top_clean(p),j:j+win-1),0,2).^2,[size(pixels,1) 1]);'])
                   eval(['var2=std(cond',int2str(i),'n_dt_tr(pixels,j:j+win-1),0,2).^2;'])
                   eval(['coeff_top_clean_cond',int2str(i),'_pix_',int2str(roi_top_clean(p)),'(:,j,h)=cc./sqrt(var1.*var2);']) 
                end;
            
        end;
        if z==1
            eval(['coeff_top_clean_cond',int2str(i),'=coeff_top_clean_cond',int2str(i),'_pix_',int2str(roi_top_clean(p)),';'])    
        else
            eval(['coeff_top_clean_cond',int2str(i),'=coeff_top_clean_cond',int2str(i),'+coeff_top_clean_cond',int2str(i),'_pix_',int2str(roi_top_clean(p)),';'])
        end 
        eval(['clear coeff_top_clean_cond',int2str(i),'_pix_',int2str(roi_top_clean(p))])
    end;
    eval(['coeff_top_clean_cond',int2str(i),'=coeff_top_clean_cond',int2str(i),'/size(roi_top_clean,1);'])
    cd pixels
    eval(['save coeff_top_clean_cond',int2str(i),' coeff_top_clean_cond',int2str(i),' roi_top_clean pixels'])
    cd ..
    eval(['clear coeff_top_clean_cond',int2str(i)])
    eval(['clear cond',int2str(i),'n_dt_bl'])            
end




cd F:\Data\VSDI\figure_figure\tolkin\27july2011\g\no_stim

load pixels_to_remove
t=ones(10000,1);
t(pixels_to_remove)=0;
pixels=find(t);
clear t

load myrois3

win=8;

for i=[1 2 4 5] %condition count
    z=0;
    eval(['load cond',int2str(i),'n_dt_bl'])
    eval(['a=size(cond',int2str(i),'n_dt_bl,3);'])    
    eval(['b=size(cond',int2str(i),'n_dt_bl,2)/2;'])
    for p=1:size(roi_bottom_clean,1)
        z=z+1;
        eval(['coeff_bottom_clean_cond',int2str(i),'_pix_',int2str(roi_bottom_clean(p)),'=NaN*ones(size(pixels,1),b-win,a);'])
        for h=1:a  %trial count
            
            
            disp(['pixel #',int2str(p),' condition #',int2str(i),' trial #',int2str(h),' transforming data'])
            %eval(['load cond',int2str(i),'n_dt_bl'])
            eval(['cond',int2str(i),'n_dt_tr=cond',int2str(i),'n_dt_bl(:,2:end,h);'])
            
                for j=1:(b-win)
                   eval(['cc=sum((repmat(cond',int2str(i),'n_dt_tr(roi_bottom_clean(p),j:j+win-1),[size(pixels,1) 1])-repmat(mean(cond',int2str(i),'n_dt_tr(roi_bottom_clean(p),j:j+win-1),2),[size(pixels,1) win])).*(cond',int2str(i),'n_dt_tr(pixels,j:j+win-1)-repmat(mean(cond',int2str(i),'n_dt_tr(pixels,j:j+win-1),2),[1 win])),2)/(win-1);'])
                   eval(['var1=repmat(std(cond',int2str(i),'n_dt_tr(roi_bottom_clean(p),j:j+win-1),0,2).^2,[size(pixels,1) 1]);'])
                   eval(['var2=std(cond',int2str(i),'n_dt_tr(pixels,j:j+win-1),0,2).^2;'])
                   eval(['coeff_bottom_clean_cond',int2str(i),'_pix_',int2str(roi_bottom_clean(p)),'(:,j,h)=cc./sqrt(var1.*var2);']) 
                end;
            
        end;
        if z==1
            eval(['coeff_bottom_clean_cond',int2str(i),'=coeff_bottom_clean_cond',int2str(i),'_pix_',int2str(roi_bottom_clean(p)),';'])    
        else
            eval(['coeff_bottom_clean_cond',int2str(i),'=coeff_bottom_clean_cond',int2str(i),'+coeff_bottom_clean_cond',int2str(i),'_pix_',int2str(roi_bottom_clean(p)),';'])
        end 
        eval(['clear coeff_bottom_clean_cond',int2str(i),'_pix_',int2str(roi_bottom_clean(p))])
    end;
    eval(['coeff_bottom_clean_cond',int2str(i),'=coeff_bottom_clean_cond',int2str(i),'/size(roi_bottom_clean,1);'])
    cd pixels
    eval(['save coeff_bottom_clean_cond',int2str(i),' coeff_bottom_clean_cond',int2str(i),' roi_bottom_clean pixels'])
    cd ..
    eval(['clear coeff_bottom_clean_cond',int2str(i)])
    eval(['clear cond',int2str(i),'n_dt_bl'])            
end











