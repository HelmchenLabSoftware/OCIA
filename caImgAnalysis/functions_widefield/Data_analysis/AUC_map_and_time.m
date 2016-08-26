cd D:\intrinsic\20150127\c\Matt_files
load('pixels_to_remove.mat')

AUC_map_time=nan*ones(2048*2048,60);
for i=1:60
    eval(['load resp_100_time',int2str(i)])
    eval(['d=reshape(resp_100_time',int2str(i),',2048*2048,size(resp_100_time',int2str(i),',3));'])
    eval(['clear resp_100_time',int2str(i)])
    eval(['load resp_1200_time',int2str(i)])
    eval(['d2=reshape(resp_1200_time',int2str(i),',2048*2048,size(resp_1200_time',int2str(i),',3));'])
    eval(['clear resp_1200_time',int2str(i)])
    l=0;
    for j=chamber'
        l=l+1;
        if rem(l,10000)==0
            disp(['Time frame ',int2str(i),' pixel ',int2str(l)])
        end
        scores=[nanmean(d(j,:),1),nanmean(d2(j,:),1)];
        labels=ones(1,size(scores,2));
        labels(size(d,2)+1:end)=0;
        [X,Y,THRE,AUC_map_time(j,i),OPTROCPT,SUBY,SUBYNAMES] = perfcurve(labels,scores,1);
    end
end
AUC_map_time=reshape(AUC_map_time(j,i),2048,2048,60);
save AUC_map_time AUC_map_time