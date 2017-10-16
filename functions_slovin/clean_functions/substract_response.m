%% substract average response
mkdir pixels
mkdir no_stim
cd no_stim
for i=[1 2 4 5]
    disp(i)
    cd ..
    load (['cond',int2str(i),'n_dt_bl'])
    eval(['cond',int2str(i),'n_dt_bl=cond',int2str(i),'n_dt_bl-repmat(nanmean(cond',int2str(i),'n_dt_bl,3),[1 1 size(cond',int2str(i),'n_dt_bl,3)]);'])

    cd no_stim
    
    eval(['save cond',int2str(i),'n_dt_bl cond',int2str(i),'n_dt_bl'])
    eval(['clear cond',int2str(i),'n_dt_bl'])
end
mkdir pixels
