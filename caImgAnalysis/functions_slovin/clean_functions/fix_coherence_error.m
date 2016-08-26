%% fix coherence error





cd /fat2/Ariel_Gilad/Matlab_analysis/experiments/test/1203/test
date='1203';   %choose date
load roi_V1new
b=size(roi_V1,1);


for cond=[4 3 2 6]
    load (['cond',int2str(cond),'n_dt_bl'])
    eval(['a=size(cond',int2str(cond),'n_dt_bl,3);'])   
    eval(['clear cond',int2str(cond),'n_dt_bl'])
    disp(['cond ',int2str(cond)])    
    load (['coher_V1_cond',int2str(cond)])
    eval(['coher_V1_cond',int2str(cond),'=coher_V1_cond',int2str(cond),'*b*a;'])
    eval(['c=zeros(10000,size(coher_V1_cond',int2str(cond),',2),size(coher_V1_cond',int2str(cond),',3));'])
    eval(['c=coher_V1_cond',int2str(cond),';']);
    eval(['clear coher_V1_cond',int2str(cond)])
    c(roi_V1,:,:)=c(roi_V1,:,:)-a;
    c=c/(b*a);
    eval(['coher_V1_cond',int2str(cond),'=c;']);
    eval(['save coher_V1_cond',int2str(cond),' coher_V1_cond',int2str(cond),' roi_V1 pixels'])
    eval(['clear coher_V1_cond',int2str(cond)])
    clear c
end




