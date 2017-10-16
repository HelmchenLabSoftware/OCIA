cd E:\data_for_israel_july_2015\20150520\a\Matt_files\
load('whisker_envelope_1200_clean.mat')
load('whisker_envelope_100_clean.mat')

load('trials_ind_clean_205x205.mat')
load('whisker_envelope.mat', 'x_env')

th=0.5;

for i=1:size(tr_1200_clean,2)
    t=smooth(whisk_env_1200_clean(:,i),3,'Gauss');
    wh_ind=t>th;
    tt=t;
    tt(wh_ind)=nan;
    t(~wh_ind)=nan;
    figure;
    plot(x_env,t)
    hold on
    plot(x_env,tt,'r')
    xlim([-2.5 5.5])
    ylim([-5 10])
end



for i=1:size(tr_100_clean,2)
    t=smooth(whisk_env_100_clean(:,i),3,'Gauss');
    wh_ind=t>th;
    tt=t;
    tt(wh_ind)=nan;
    t(~wh_ind)=nan;
    figure;
    plot(x_env,t)
    hold on
    plot(x_env,tt,'r')
    xlim([-2.5 5.5])
    ylim([-5 10])
end







