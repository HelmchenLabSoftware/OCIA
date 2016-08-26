

cd D:\intrinsic\20150211\d\Matt_files
tr_ave=nan*ones(2048,2048,60);
k=0;
for i=1:10
    disp(i)
    k=k+1;
    eval(['load trial_',int2str(i)])
    if k==1
        tr_ave=tr;
    else
        tr_ave=tr_ave+tr;
    end
end
tr_ave=tr_ave/k;
save average_of_all_trials tr_ave
    




