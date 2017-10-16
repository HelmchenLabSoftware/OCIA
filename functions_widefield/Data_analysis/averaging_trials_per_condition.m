

cd D:\intrinsic\20150422\b\Matt_files
load('trials_ind.mat')

k=zeros(1,60);
ave_100=nan*ones(2048,2048,60);
for i=tr_100
    disp(i)
    k=k+1;
    eval(['load trial_',int2str(i)])
    temp=find(squeeze(isnan(tr(1000,1000,:))),1,'first');
    if isempty(temp)
        if k(1)==1
            ave_100=tr;
        else
            ave_100=ave_100+tr;
        end
    else
        if k(1)==1
            ave_100(:,:,1:(temp-1))=tr(:,:,1:(temp-1));
            k(temp:end)=k(temp:end)-1;
        else
            ave_100(:,:,1:(temp-1))=ave_100(:,:,1:(temp-1))+tr(:,:,1:(temp-1));
            k(temp:end)=k(temp:end)-1;
        end
    end
end
ave_100=ave_100./shiftdim(repmat(k,[2048,1,2048]),2);


k=zeros(1,60);
ave_1200=nan*ones(2048,2048,60);
for i=tr_1200
    disp(i)
    k=k+1;
    eval(['load trial_',int2str(i)])
    temp=find(squeeze(isnan(tr(1000,1000,:))),1,'first');
    if isempty(temp)
        if k==1
            ave_1200=tr;
        else
            ave_1200=ave_1200+tr;
        end
    else
        if k==1
            ave_1200(:,:,1:(temp-1))=tr(:,:,1:(temp-1));
            k(temp:end)=k(temp:end)-1;
        else
            ave_1200=ave_1200(:,:,1:(temp-1))+tr(:,:,1:(temp-1));
            k(temp:end)=k(temp:end)-1;
        end
    end
end
ave_1200=ave_1200./shiftdim(repmat(k,[2048,1,2048]),2);

save ave_100_2048x2048 ave_100
save ave_1200_2048x2048 ave_1200







