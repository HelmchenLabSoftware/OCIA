%% theta filter

load filters

for i=[4]
    disp(i)
    eval(['load cond',int2str(i),'n_dt_bl'])
    eval(['theta',int2str(i),'n_dt_bl=filter(theta,cond',int2str(i),'n_dt_bl(:,2:end,:)-repmat(cond',int2str(i),'n_dt_bl(:,2,:),[1 255 1]),2);'])
    eval(['clear cond',int2str(i),'n_dt_bl'])
    %eval(['theta',int2str(i),'n_dt_bl=abs(theta',int2str(i),'n_dt_bl);'])
    eval(['save theta',int2str(i),'n_dt_bl theta',int2str(i),'n_dt_bl'])
    eval(['clear theta',int2str(i),'n_dt_bl'])
end
    
    