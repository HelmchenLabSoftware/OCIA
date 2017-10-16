



cd D:\intrinsic\20150603\mouse_balazs\c\Matt_files
load pixels_to_remove
cd ..
list1 = dir('20150306*');
fr0=7:9;
ds=10;

cd Tiff_files
list2 = dir('Trial1frame*');
kk=0;
tr_ave=nan*ones(205,205,size(list2,1),size(list1,1));
for j=1:size(list1,1) 
    kk=kk+1;
    k=0;
    disp(j)
    eval(['list2 = dir(''Trial',int2str(j),'frame*'');'])
    for i=1:size(list2,1)       
        k=k+1;
        eval(['a=imread(''Trial',int2str(j),'frame',int2str(i),''');'])
        c=reshape(a,2048*2048,1);
        c(pixels_to_remove,:)=nan;
        a=reshape(c,2048,2048);
        b=im2double(a);
        o=0;
        for ii=1:ds:2048
            %disp(ii)
            o=o+1;
            oo=0;
            for jj=1:ds:2048
                oo=oo+1;
                
                if (2048-ii)<(ds-1)
                    if (2048-jj)<(ds-1)
                        tr_ave(o,oo,i,kk)=nanmean(nanmean(b(ii:end,jj:end),1),2);
                    else
                        tr_ave(o,oo,i,kk)=nanmean(nanmean(b(ii:end,jj:jj+(ds-1)),1),2);
                    end
                else
                   if (2048-jj)<(ds-1)
                        tr_ave(o,oo,i,kk)=nanmean(nanmean(b(ii:ii+(ds-1),jj:end),1),2);
                   else
                        tr_ave(o,oo,i,kk)=nanmean(nanmean(b(ii:ii+(ds-1),jj:jj+(ds-1)),1),2);
                   end 
                end
            end
        end
    end   
end
fr_dev=nanmean(tr_ave(:,:,fr0,:),3);
tr_ave=tr_ave./repmat(fr_dev,[1 1 size(list2,1) 1]);
cd ..
cd Matt_files
for z=1:size(tr_ave,4)
    disp(z)
    tr=tr_ave(:,:,:,z);
    eval(['save stim_trial',int2str(z),' tr'])
end
tr_ave=nanmean(tr_ave,4);
save stim_ave tr_ave 
save norm_frame fr_dev fr0
clear tr_ave


