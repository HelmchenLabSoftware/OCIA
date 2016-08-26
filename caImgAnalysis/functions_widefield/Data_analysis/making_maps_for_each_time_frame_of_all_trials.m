cd D:\intrinsic\20150127\c\Matt_files
load('trials_ind_clean.mat')


for j=1:60
    k=0;    
    for i=tr_100_clean
        disp(['Time frame ',int2str(j),' trial ',int2str(i)])
        k=k+1;
        eval(['load trial_',int2str(i)])
        if k==1
            eval(['resp_100_time',int2str(j),'=tr(:,:,j);'])
        else
            eval(['resp_100_time',int2str(j),'=cat(3,resp_100_time',int2str(j),',tr(:,:,j));'])
        end
    end
    eval(['save resp_100_time',int2str(j),' resp_100_time',int2str(j)])
    eval(['clear resp_100_time',int2str(j)])
end

for j=1:60
    k=0;    
    for i=tr_1200_clean
        disp(['Time frame ',int2str(j),' trial ',int2str(i)])
        k=k+1;
        eval(['load trial_',int2str(i)])
        if k==1
            eval(['resp_1200_time',int2str(j),'=tr(:,:,j);'])
        else
            eval(['resp_1200_time',int2str(j),'=cat(3,resp_1200_time',int2str(j),',tr(:,:,j));'])
        end
    end
    eval(['save resp_1200_time',int2str(j),' resp_1200_time',int2str(j)]) 
    eval(['clear resp_1200_time',int2str(j)])
end




