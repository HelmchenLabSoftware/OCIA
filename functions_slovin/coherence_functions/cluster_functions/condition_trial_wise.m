%% save condition trial wise

for i=1:6
    eval(['load cond',int2str(i),'n_dt_bl'])
    eval(['a=size(cond',int2str(i),'n_dt_bl,3);'])
    eval(['b=size(cond',int2str(i),'n_dt_bl,2);'])
    for j=1:a
        eval(['cond',int2str(i),'n_dt_hb_trial_',int2str(j),'=zeros(10000,b);'])
        disp(['cond ',int2str(i),' trial ',int2str(j)])
        eval(['cond',int2str(i),'n_dt_hb_trial_',int2str(j),'=cond',int2str(i),'n_dt_bl(:,:,j);'])
        eval(['save cond',int2str(i),'n_dt_hb_trial_',int2str(j),' cond',int2str(i),'n_dt_hb_trial_',int2str(j)])
        eval(['clear cond',int2str(i),'n_dt_hb_trial_',int2str(j)])
    end
    eval(['clear cond',int2str(i),'n_dt_bl'])
end
        
        
        