%% unite pixels for coherence (cluster)


date='2011';
cond='2';
load (date)
for i=roi_V2'
    p=int2str(i);
    unite_data_cond1_V1(p,cond,date);
end