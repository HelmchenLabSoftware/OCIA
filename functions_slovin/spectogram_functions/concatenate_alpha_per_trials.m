cd F:\Data\VSDI\collinear\three_flankers\legolas\2007_04_18\no_stim\way2

load pixels_to_remove
t=ones(10000,1);
t(pixels_to_remove)=0;
pixels=find(t);
clear t



for i=[2 4] %condition count
    z=0;
    eval(['load cond',int2str(i),'n_dt_bl'])
    eval(['a=size(cond',int2str(i),'n_dt_bl,3);'])    
    eval(['b=size(cond',int2str(i),'n_dt_bl,2);'])
    %cd win320
    cd trials
        for h=1:a  %trial count 
            eval(['load power_alpha_cond',int2str(i),'_trial_',int2str(h)])
            if h==1
                eval(['power_alpha_cond',int2str(i),'=power_alpha_cond',int2str(i),'_trial_',int2str(h),';'])
            else
                eval(['power_alpha_cond',int2str(i),'=cat(3,power_alpha_cond',int2str(i),',power_alpha_cond',int2str(i),'_trial_',int2str(h),');'])
            end    
            eval(['clear power_alpha_cond',int2str(i),'_trial_',int2str(h)])
        end;
    eval(['save power_alpha_cond',int2str(i),' power_alpha_cond',int2str(i),' pixels'])
    eval(['clear power_alpha_cond',int2str(i)])
    %cd ..
    cd ..
    eval(['clear cond',int2str(i),'n_dt_bl'])
end;



