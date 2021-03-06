

cd D:\intrinsic\20150504\mouse_tgg6fl23_5\b\Matt_files
load pixels_to_remove
cd ..
list1 = dir('20150405*');
fr0=40:50;
ds=10;

cd Tiff_files
kk=0;
tr_ave=nan*ones(205,205,500,size(list1,1)/2);
for j=2:2:size(list1,1) 
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
tr_ave=tr_ave./repmat(fr_dev,[1 1 500 1]);
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


cd ..
cd Tiff_files
kk=0;
tr_ave=nan*ones(205,205,500,size(list1,1)/2);
for j=1:2:size(list1,1) 
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
tr_ave=tr_ave./repmat(fr_dev,[1 1 500 1]);
cd ..
cd Matt_files
for z=1:size(tr_ave,4)
    disp(z)
    tr=tr_ave(:,:,:,z);
    eval(['save blank_trial',int2str(z),' tr'])
end
tr_ave=nanmean(tr_ave,4);
save blank_ave tr_ave 
save norm_frame_bl fr_dev fr0
clear tr_ave


cd D:\intrinsic\20150420\f\Matt_files
load pixels_to_remove
cd ..
list1 = dir('20152004*');
fr0=40:50;
ds=10;

cd Tiff_files
kk=0;
tr_ave=nan*ones(205,205,500,size(list1,1)/2);
for j=2:2:size(list1,1) 
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
tr_ave=tr_ave./repmat(fr_dev,[1 1 500 1]);
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


cd ..
cd Tiff_files
kk=0;
tr_ave=nan*ones(205,205,500,size(list1,1)/2);
for j=1:2:size(list1,1) 
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
tr_ave=tr_ave./repmat(fr_dev,[1 1 500 1]);
cd ..
cd Matt_files
for z=1:size(tr_ave,4)
    disp(z)
    tr=tr_ave(:,:,:,z);
    eval(['save blank_trial',int2str(z),' tr'])
end
tr_ave=nanmean(tr_ave,4);
save blank_ave tr_ave 
save norm_frame_bl fr_dev fr0
clear tr_ave


cd D:\intrinsic\20150420\h\Matt_files
load pixels_to_remove
cd ..
list1 = dir('20152004*');
fr0=40:50;
ds=10;

cd Tiff_files
kk=0;
tr_ave=nan*ones(205,205,500,size(list1,1)/2);
for j=2:2:size(list1,1) 
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
tr_ave=tr_ave./repmat(fr_dev,[1 1 500 1]);
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


cd ..
cd Tiff_files
kk=0;
tr_ave=nan*ones(205,205,500,size(list1,1)/2);
for j=1:2:size(list1,1) 
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
tr_ave=tr_ave./repmat(fr_dev,[1 1 500 1]);
cd ..
cd Matt_files
for z=1:size(tr_ave,4)
    disp(z)
    tr=tr_ave(:,:,:,z);
    eval(['save blank_trial',int2str(z),' tr'])
end
tr_ave=nanmean(tr_ave,4);
save blank_ave tr_ave 
save norm_frame_bl fr_dev fr0
clear tr_ave


cd D:\intrinsic\20150420\i\Matt_files
load pixels_to_remove
cd ..
list1 = dir('20152004*');
fr0=40:50;
ds=10;

cd Tiff_files
kk=0;
tr_ave=nan*ones(205,205,500,size(list1,1)/2);
for j=2:2:size(list1,1) 
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
tr_ave=tr_ave./repmat(fr_dev,[1 1 550 1]);
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


cd ..
cd Tiff_files
kk=0;
tr_ave=nan*ones(205,205,550,size(list1,1)/2);
for j=1:2:size(list1,1) 
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
tr_ave=tr_ave./repmat(fr_dev,[1 1 550 1]);
cd ..
cd Matt_files
for z=1:size(tr_ave,4)
    disp(z)
    tr=tr_ave(:,:,:,z);
    eval(['save blank_trial',int2str(z),' tr'])
end
tr_ave=nanmean(tr_ave,4);
save blank_ave tr_ave 
save norm_frame_bl fr_dev fr0
clear tr_ave


cd D:\intrinsic\20150420\j\Matt_files
load pixels_to_remove
cd ..
list1 = dir('20152004*');
fr0=40:50;
ds=10;

cd Tiff_files
kk=0;
tr_ave=nan*ones(205,205,550,size(list1,1)/2);
for j=2:2:size(list1,1) 
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
tr_ave=tr_ave./repmat(fr_dev,[1 1 550 1]);
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


cd ..
cd Tiff_files
kk=0;
tr_ave=nan*ones(205,205,550,size(list1,1)/2);
for j=1:2:size(list1,1) 
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
tr_ave=tr_ave./repmat(fr_dev,[1 1 550 1]);
cd ..
cd Matt_files
for z=1:size(tr_ave,4)
    disp(z)
    tr=tr_ave(:,:,:,z);
    eval(['save blank_trial',int2str(z),' tr'])
end
tr_ave=nanmean(tr_ave,4);
save blank_ave tr_ave 
save norm_frame_bl fr_dev fr0
clear tr_ave





