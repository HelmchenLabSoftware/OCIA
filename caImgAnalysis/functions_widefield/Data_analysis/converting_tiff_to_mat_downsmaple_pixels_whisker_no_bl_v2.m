

cd C:\Users\WideField\Documents\LabVIEW Data\1601_behav\mou_bl_160105_02\2016_02_18\widefield_labiew\exp01_visual\Matt_files
load pixels_to_remove
cd ..
list1 = dir('20162101*');
fr0=7:9;
ds=2;


cd Tiff_files
aa=imread('Trial1frame2');
pix=size(aa,1);
list2 = dir('Trial1frame*');
kk=0;
tr_ave=nan*ones(ceil(pix/ds),ceil(pix/ds),size(list2,1),size(list1,1));
for j=1:size(list1,1) 
    kk=kk+1;
    k=0;
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
                        tr_ave(o,oo,i,kk)=nanmean(nanmean(b(ii:end,jj:end),1),2);
                    else
                        tr_ave(o,oo,i,kk)=nanmean(nanmean(b(ii:end,jj:jj+(ds-1)),1),2);
                    end
                else
                   if (pix-jj)<(ds-1)
                        tr_ave(o,oo,i,kk)=nanmean(nanmean(b(ii:ii+(ds-1),jj:end),1),2);
                   else
                        tr_ave(o,oo,i,kk)=nanmean(nanmean(b(ii:ii+(ds-1),jj:jj+(ds-1)),1),2);
                   end 
                end
            end
        end
    end   
end
% frame
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


