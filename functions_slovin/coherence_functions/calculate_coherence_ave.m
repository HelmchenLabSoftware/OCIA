% calculating average coherence 

cd /fat2/Ariel_Gilad/Matlab_analysis/2301_coherence_data

for i=5 %condition count
    eval(['a=dir(''2301coher_V1_cond',int2str(i),'_pix_*'');'])
    for j=1:size(a,1)
        load (a(j).name)
        disp(['pixel #',int2str(j)])
        pix=a(j).name(end-7:end-4);
        if j==1
            eval(['coher_V1_cond',int2str(i),'=coher_V1_ave_pix_',pix,';'])
        else
            eval(['coher_V1_cond',int2str(i),'=coher_V1_cond',int2str(i),'+coher_V1_ave_pix_',pix,';'])
        end
        eval(['clear coher_V1_ave_pix_',pix])
    end
    eval(['coher_V1_cond',int2str(i),'=coher_V1_cond',int2str(i),'/j;'])
    eval(['save coher_V1_cond',int2str(i),' coher_V1_cond',int2str(i),' pixels roi_V1'])
end
            