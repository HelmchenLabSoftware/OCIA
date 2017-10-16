%% calculate derivative for VSDI
%clear all
cd F:\Data\VSDI\figure_figure\tolkin\25may2011\b
for i=[2 5] %condition count
    disp(['cond #',int2str(i)])
    eval(['load cond',int2str(i),'n_dt_bl'])
    w=4;  %pick width of derivative
    eval(['der_cond',int2str(i),'=zeros(size(cond',int2str(i),'n_dt_bl,1),size(cond',int2str(i),'n_dt_bl,2)-w-1,size(cond',int2str(i),'n_dt_bl,3));'])
    eval(['a=size(cond',int2str(i),'n_dt_bl,2)-w;'])
    for j=2:a
        eval(['der_cond',int2str(i),'(:,j-1,:)=(cond',int2str(i),'n_dt_bl(:,j+w,:)-cond',int2str(i),'n_dt_bl(:,j,:));'])  %calculate derivative
    end;
    eval(['clear cond',int2str(i),'n_dt_bl'])
    eval(['save  der_cond',int2str(i),'_',int2str(w),' der_cond',int2str(i)])
    eval(['clear der_cond',int2str(i)])
end;


   
   
   
   