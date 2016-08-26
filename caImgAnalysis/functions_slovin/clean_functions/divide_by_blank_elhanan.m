%% divide by blank elhanan's data



load condz_correct3
blank=mean(condz_correct,3);
save blank blank
clear condz

for i=2:4    
    disp(['cond ',int2str(i)])
    eval(['load condz_correct',int2str(i)])
    eval(['cond',int2str(i),'n_dt_bl=(condz_correct)./repmat(blank,[1,1,size(condz_correct,3)]);'])
    eval(['clear condz_correct'])
    eval(['save cond',int2str(i),'n_dt_bl cond',int2str(i),'n_dt_bl'])
    eval(['clear cond',int2str(i),'n_dt_bl'])
end