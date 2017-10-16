%% substract average response

mkdir no_stim2
cd no_stim2

cd ..
load cond1n_dt_bl
load cond4n_dt_bl
cond1n_dt_bl=cond1n_dt_bl-repmat(nanmean(cond4n_dt_bl,3),[1 1 size(cond1n_dt_bl,3)]);
cond4n_dt_bl=cond4n_dt_bl-repmat(nanmean(cond4n_dt_bl,3),[1 1 size(cond4n_dt_bl,3)]);
cd no_stim2  
save cond1n_dt_bl cond1n_dt_bl
clear cond1n_dt_bl
save cond4n_dt_bl cond4n_dt_bl
clear cond4n_dt_bl

cd ..
load cond2n_dt_bl
load cond5n_dt_bl
cond2n_dt_bl=cond2n_dt_bl-repmat(nanmean(cond5n_dt_bl,3),[1 1 size(cond2n_dt_bl,3)]);
cond5n_dt_bl=cond5n_dt_bl-repmat(nanmean(cond5n_dt_bl,3),[1 1 size(cond5n_dt_bl,3)]);
cd no_stim2    
save cond2n_dt_bl cond2n_dt_bl
clear cond2n_dt_bl
save cond5n_dt_bl cond5n_dt_bl
clear cond5n_dt_bl

mkdir pixels
