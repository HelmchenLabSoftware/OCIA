%% divide by blank inbal's data


cd cond3
load cond3n
blank=mean(cond3n,3);
cd ..
save blank blank
clear cond3n

for i=1:5
    eval(['cd cond',int2str(i)])
    disp(['cond ',int2str(i)])
    eval(['load cond',int2str(i),'n'])
    eval(['cond',int2str(i),'n_dt_bl=(cond',int2str(i),'n)./repmat(blank,[1,1,size(cond',int2str(i),'n,3)]);'])
    eval(['clear cond',int2str(i),'n'])
    cd ..
    eval(['save cond',int2str(i),'n_dt_bl cond',int2str(i),'n_dt_bl'])
    eval(['clear cond',int2str(i),'n_dt_bl'])
end