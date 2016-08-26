%% beta filter


load filters


for i=[4 3 6]
    disp(i)
    eval(['load cond',int2str(i),'n_dt_bl'])
    eval(['beta',int2str(i),'n_dt_bl=filter(beta,cond',int2str(i),'n_dt_bl-1,2);'])
    eval(['clear cond',int2str(i),'n_dt_bl'])
    eval(['beta',int2str(i),'n_dt_bl=abs(beta',int2str(i),'n_dt_bl);'])
    eval(['save beta',int2str(i),'n_dt_bl beta',int2str(i),'n_dt_bl'])
    eval(['clear beta',int2str(i),'n_dt_bl'])
end
   