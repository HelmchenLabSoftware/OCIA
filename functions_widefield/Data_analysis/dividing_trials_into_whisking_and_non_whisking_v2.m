cd D:\intrinsic\20150520\a\Matt_files
load('whisker_envelope_100.mat')

load('trials_ind.mat')
load('whisker_envelope.mat', 'x_env')

th=0.5;


for i=1:size(tr_100,2)
    t=smooth(whisk_env_100(:,i),3,'Gauss');
    wh_ind=t>th;
    r=find(wh_ind);
    y=find(wh_ind(1:end))-1;
    r=[r;y(2:end)];
    r=[r;find(wh_ind(1:end-1))+1];
    r=[r;find(wh_ind(1:end-2))+2];
    r=[r;find(wh_ind(1:end-3))+3];
    r=[r;find(wh_ind(1:end-4))+4];
    wh_ind=unique(r);
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




%%
cd D:\intrinsic\20150519\c\Matt_files
load('whisker_envelope_1200.mat')

load('trials_ind.mat')
load('whisker_envelope.mat', 'x_env')

th=0.5;


for i=1:size(tr_1200,2)
    t=smooth(whisk_env_1200(:,i),3,'Gauss');
    wh_ind=t>th;
    r=find(wh_ind);
    y=find(wh_ind(1:end))-1;
    r=[r;y(2:end)];
    r=[r;find(wh_ind(1:end-1))+1];
    r=[r;find(wh_ind(1:end-2))+2];
    r=[r;find(wh_ind(1:end-3))+3];
    r=[r;find(wh_ind(1:end-4))+4];
    wh_ind=unique(r);
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



