



cd D:\intrinsic\20160104\e\Matt_files
load pixels_to_remove
cd ..
list1 = dir('20160401*');
fr0=10:13;
ds=2;


cd Tiff_files
l = dir('Trial1frame*');
fr=size(l,1);

aa=imread('Trial1frame2');
pix=size(aa,1);
list2 = dir('Trial1frame*');
kk=0;
tr_ave=nan*ones(ceil(pix/ds),ceil(pix/ds),fr);
for j=1:size(list1,1) 
    kk=kk+1;
    k=0;
    tr=nan*ones(ceil(pix/ds),ceil(pix/ds),fr);
    disp(j)
    eval(['list2 = dir(''Trial',int2str(j),'frame*'');'])
    for i=1:size(list2,1)       
        k=k+1;
        eval(['a=imread(''Trial',int2str(j),'frame',int2str(i),''');'])
        c=reshape(a,pix*pix,1);
        c(pixels_to_remove,:)=nan;
        a=reshape(c,pix,pix);
        b=im2double(a);
        o=0;
        for ii=1:ds:pix
            %disp(ii)
            o=o+1;
            oo=0;
            for jj=1:ds:pix
                oo=oo+1;
                
                if (pix-ii)<(ds-1)
                    if (pix-jj)<(ds-1)
                        tr(o,oo,i)=nanmean(nanmean(b(ii:end,jj:end),1),2);
                    else
                        tr(o,oo,i)=nanmean(nanmean(b(ii:end,jj:jj+(ds-1)),1),2);
                    end
                else
                   if (pix-jj)<(ds-1)
                        tr(o,oo,i)=nanmean(nanmean(b(ii:ii+(ds-1),jj:end),1),2);
                   else
                        tr(o,oo,i)=nanmean(nanmean(b(ii:ii+(ds-1),jj:jj+(ds-1)),1),2);
                   end 
                end
            end
        end
    end
    fr_dev=nanmean(tr(:,:,fr0),3);
    tr=tr./repmat(fr_dev,[1 1 fr]);
    cd ..
    cd Matt_files
    eval(['save stim_trial',int2str(kk),' tr'])
    cd ..
    cd Tiff_files
    if kk==1
        tr_ave=tr;
    else
        tr_ave=tr_ave+tr;
    end
end
tr_ave=tr_ave/kk;
cd ..
cd Matt_files
save stim_ave tr_ave 
save norm_frame fr_dev fr0
clear tr_ave








