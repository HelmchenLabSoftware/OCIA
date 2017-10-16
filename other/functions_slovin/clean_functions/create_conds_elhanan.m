%% create conds through elhanan's data
clear all
for i=1:6 %condition count
    date='2011';
    cd /fat2/Ariel_Gilad/Matlab_analysis/vsdi_coVnon_path/coVnon/aragon/2007_11_20
    a=dir([date,'_',int2str(i),'*']); %list of trials
    eval(['load data',int2str(i)]);
    sz = size(a,1) - size(errorM,2);
    eval(['cond',int2str(i),' = zeros(10000,256,sz);']);
    eval(['cond',int2str(i),'n = zeros(10000,256,sz);']);
    true=ones(1,size(a,1));
    true(errorM)=0;
    p=0;
    for j=0:size(a)-1 %trial count
        if true(j+1)==1
            p=p+1;
            disp(['cond #',int2str(i),' trial #',int2str(j),' is correct']);
            load (a(j+1).name)
            condz = mean(FRMpre(:,25:27),2);
            eval(['cond',int2str(i),'(:,:,',int2str(p),')=FRMpre;'])
            eval(['cond',int2str(i),'n(:,:,',int2str(p),')=FRMpre./repmat(condz,1,size(FRMpre,2));'])
        end;
    end;
    cd /fat2/Ariel_Gilad/Matlab_analysis/vsdi_coVnon_path/coVnon/aragon/2007_11_20
    eval(['save cond',int2str(i),' cond',int2str(i)]); 
    eval(['save cond',int2str(i),'n cond',int2str(i),'n']);
    clear all
end;
    