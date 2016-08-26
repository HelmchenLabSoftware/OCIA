%% calculate 2nd derivative for VSDI


clear all
for i=1:6 %condition count
    disp(['cond #',int2str(i)])
    cd /fat2/Ariel_Gilad/Matlab_analysis/25oct2006/cond_data_b/derivative
    eval(['load der_cond',int2str(i)])
    w=4;  %pick width of derivative
    eval(['der2_cond',int2str(i),'=zeros(size(der_cond',int2str(i),',1),size(der_cond',int2str(i),',2)-w-1,size(der_cond',int2str(i),',3));'])
    eval(['a=size(der_cond',int2str(i),',2)-w;'])
    for j=2:a
        eval(['der2_cond',int2str(i),'(:,j-1,:)=(der_cond',int2str(i),'(:,j+w,:)-der_cond',int2str(i),'(:,j,:))/w;'])  %calculate derivative
    end;
    eval(['clear der_cond',int2str(i)])
    eval(['save  der2_cond',int2str(i),' der2_cond',int2str(i)])
    eval(['clear der2_cond',int2str(i)])
end;
