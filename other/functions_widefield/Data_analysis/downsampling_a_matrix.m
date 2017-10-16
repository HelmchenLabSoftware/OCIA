
ds=10;
ave_100_ds=nan*ones(205,205,60);
k=0;
for i=1:ds:2048
    k=k+1;
    kk=0;
    for j=1:ds:2048
        kk=kk+1;
        disp(i)
        if (2048-i)<(ds-1)
            if (2048-j)<(ds-1)
                ave_100_ds(k,kk,:)=nanmean(nanmean(ave_100(i:end,j:end,:),1),2);
            else
                ave_100_ds(k,kk,:)=nanmean(nanmean(ave_100(i:end,j:j+(ds-1),:),1),2);
            end
        else
           if (2048-j)<(ds-1)
                ave_100_ds(k,kk,:)=nanmean(nanmean(ave_100(i:i+(ds-1),j:end,:),1),2);
           else
                ave_100_ds(k,kk,:)=nanmean(nanmean(ave_100(i:i+(ds-1),j:j+(ds-1),:),1),2);
           end 
        end
    end
end




