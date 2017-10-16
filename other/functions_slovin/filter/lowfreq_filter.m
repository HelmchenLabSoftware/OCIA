%% lowfreq filter

load filters


for i=[4 3 6]
    disp(i)
    eval(['load cond',int2str(i),'n_dt_bl'])
    eval(['delta',int2str(i),'n_dt_bl=filter(delta,cond',int2str(i),'n_dt_bl(:,2:end,:)-1,2);'])
    eval(['clear cond',int2str(i),'n_dt_bl'])
    eval(['delta',int2str(i),'n_dt_bl=abs(delta',int2str(i),'n_dt_bl);'])
    eval(['save delta',int2str(i),'n_dt_bl delta',int2str(i),'n_dt_bl'])
    eval(['clear delta',int2str(i),'n_dt_bl'])
end
  