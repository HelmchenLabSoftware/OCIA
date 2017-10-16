clear all
cd D:\intrinsic\20150514\mouse_tgg6fl23_4\b\Matt_files
load('whisker_envelope.mat')
%load('trials_ind_clean_205x205.mat')
load('trials_ind.mat')
for i=1:size(tr_100,2)
    whisk_env_100(:,i)=whisk_env(:,tr_100(i));
end
%for i=1:size(tr_100_clean,2)
%    whisk_env_100_clean(:,i)=whisk_env(:,tr_100_clean(i));
%end
for i=1:size(tr_1200,2)
    whisk_env_1200(:,i)=whisk_env(:,tr_1200(i));
end
%for i=1:size(tr_1200_clean,2)
%    whisk_env_1200_clean(:,i)=whisk_env(:,tr_1200_clean(i));
%end
%save whisker_envelope_100_clean whisk_env_100_clean
%save whisker_envelope_1200_clean whisk_env_1200_clean
save whisker_envelope_100 whisk_env_100
save whisker_envelope_1200 whisk_env_1200












