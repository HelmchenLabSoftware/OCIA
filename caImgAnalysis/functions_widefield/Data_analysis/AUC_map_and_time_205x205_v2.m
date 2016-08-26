



cd D:\intrinsic\20150610\mouse_tgg6fl23_4\c\Matt_files
load('trials_ind_clean_205x205.mat')
list100 = dir('cond_100_trial*');
tr_100_c=ones(1,size(list100,1));
tr_100_c(tr_bad_100)=0;
ff=find(tr_100_c==1);
k=0;
for i=ff
    k=k+1;
    disp(i)
    eval(['load cond_100_trial',int2str(i)])
    if k==1
        cond_100=tr;
    else
        cond_100=cat(4,cond_100,tr);
    end
end
cond_100=reshape(cond_100,205*205,180,size(cond_100,4));

list1200 = dir('cond_1200_trial*');
tr_1200_c=ones(1,size(list1200,1));
tr_1200_c(tr_bad_1200)=0;
gg=find(tr_1200_c==1);
k=0;
for i=gg
    k=k+1;
    disp(i)
    eval(['load cond_1200_trial',int2str(i)])
    if k==1
        cond_1200=tr;
    else
        cond_1200=cat(4,cond_1200,tr);
    end
end
cond_1200=reshape(cond_1200,205*205,180,size(cond_1200,4));

chamber=find(~isnan(cond_100(:,1,1)));

AUC_map_time=nan*ones(205*205,180);
for i=1:180
    l=0;
    for j=chamber'
        l=l+1;
        if rem(l,10000)==0
            disp(['Time frame ',int2str(i),' pixel ',int2str(l)])
        end
        scores=[squeeze(nanmean(cond_100(j,i,:),1))',squeeze(nanmean(cond_1200(j,i,:),1))'];
        if sum(isnan(scores))==size(scores,2)
            AUC_map_time(j,i)=nan;
        else
            labels=ones(1,size(scores,2));
            labels(size(cond_100,3)+1:end)=0;
            [X,Y,THRE,AUC_map_time(j,i),OPTROCPT,SUBY,SUBYNAMES] = perfcurve(labels,scores,1);
        end
    end
end
AUC_map_time=reshape(AUC_map_time,205,205,180);
save AUC_map_time_clean AUC_map_time

