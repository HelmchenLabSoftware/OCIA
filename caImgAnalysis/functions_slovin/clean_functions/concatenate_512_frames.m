%%concatenate two mat files to make one 512 ms mat file and create cond
%%data
clear all
for i=1:6 %condition count
    k=0;
    date='1003';
    cd /fat2/Ariel_Gilad/Matlab_analysis/LED_test/2008_03_10/CrossNormalPattern45Degrees10ms
    a=dir([date,'_',int2str(i),'*']); %list of trials
    eval(['cond',int2str(i),' = zeros(10000,512,size(a,1)/2);']);
    eval(['cond',int2str(i),'n = zeros(10000,512,size(a,1)/2);']); 
    for j=0:2:size(a,1)-2
        k=k+1;
        disp(['cond #',int2str(i),' trial #',int2str(k)]);
        cd /fat2/Ariel_Gilad/Matlab_analysis/LED_test/2008_03_10/CrossNormalPattern45Degrees10ms
        load (a(j+1).name)
        FRMpre1=FRMpre;
        load (a(j+2).name)
        FRMpre=cat(2,FRMpre1,FRMpre);
        cd /fat2/Ariel_Gilad/Matlab_analysis/LED_test/2008_03_10/CrossNormalPattern45Degrees10ms/conds
        eval(['save ',date,'_',int2str(i),'0',int2str(k),' FRMpre']);
        condz = mean(FRMpre(:,25:27),2);
        eval(['cond',int2str(i),'(:,:,',int2str(k),')=FRMpre;'])
        eval(['cond',int2str(i),'n(:,:,',int2str(k),')=FRMpre./repmat(condz,1,size(FRMpre,2));'])
    end;
    cd /fat2/Ariel_Gilad/Matlab_analysis/LED_test/2008_03_10/CrossNormalPattern45Degrees10ms/conds
    eval(['save cond',int2str(i),' cond',int2str(i)]); 
    eval(['save cond',int2str(i),'n cond',int2str(i),'n']);
    clear all
end;
 