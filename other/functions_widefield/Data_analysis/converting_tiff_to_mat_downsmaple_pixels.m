



cd D:\intrinsic\20160215\a\Matt_files
load('trials_ind.mat')
load pixels_to_remove
cd ..
list1 = dir('20161502*');
fr0=10:13;
ds=2;




cd Tiff_files
l = dir('Trial1frame*');
fr=size(l,1);

kk=0;
cond_100=nan*ones(256,256,fr,size(tr_100,2));
for j=tr_100 
    kk=kk+1;
    k=0;
    disp(j)
     
    eval(['list2 = dir(''Trial',int2str(j),'frame*'');'])
    for i=1:size(list2,1)       
        k=k+1;
        eval(['a=imread(''Trial',int2str(j),'frame',int2str(i),''');'])
        c=reshape(a,512*512,1);
        c(pixels_to_remove,:)=nan;
        a=reshape(c,512,512);
        b=im2double(a);
        o=0;
        for ii=1:ds:512
            %disp(ii)
            o=o+1;
            oo=0;
            for jj=1:ds:512
                oo=oo+1;
                
                if (512-ii)<(ds-1)
                    if (512-jj)<(ds-1)
                        cond_100(o,oo,i,kk)=nanmean(nanmean(b(ii:end,jj:end),1),2);
                    else
                        cond_100(o,oo,i,kk)=nanmean(nanmean(b(ii:end,jj:jj+(ds-1)),1),2);
                    end
                else
                   if (512-jj)<(ds-1)
                        cond_100(o,oo,i,kk)=nanmean(nanmean(b(ii:ii+(ds-1),jj:end),1),2);
                   else
                        cond_100(o,oo,i,kk)=nanmean(nanmean(b(ii:ii+(ds-1),jj:jj+(ds-1)),1),2);
                   end 
                end
            end
        end
    end   
end
fr_dev=nanmean(cond_100(:,:,fr0,:),3);
cond_100=cond_100./repmat(fr_dev,[1 1 fr 1]);
cd ..
cd Matt_files
for z=1:size(cond_100,4)
    disp(z)
    tr=cond_100(:,:,:,z);
    eval(['save cond_100_trial',int2str(z),' tr'])
end
cond_100_ave=nanmean(cond_100,4);
save cond_100_ave cond_100_ave 
save norm_frame_100 fr_dev fr0
clear cond_100
cd ..


cd Tiff_files 
kk=0;
cond_1200=nan*ones(256,256,fr,size(tr_1200,2));
for j=tr_1200 
    kk=kk+1;
    k=0;
    disp(j)
    
    eval(['list2 = dir(''Trial',int2str(j),'frame*'');'])
    for i=1:size(list2,1)       
        k=k+1;
        eval(['a=imread(''Trial',int2str(j),'frame',int2str(i),''');'])
        c=reshape(a,512*512,1);
        c(pixels_to_remove,:)=nan;
        a=reshape(c,512,512);
        b=im2double(a);
        o=0;
        for ii=1:ds:512
            %disp(ii)
            o=o+1;
            oo=0;
            for jj=1:ds:512
                oo=oo+1;
                
                if (512-ii)<(ds-1)
                    if (512-jj)<(ds-1)
                        cond_1200(o,oo,i,kk)=nanmean(nanmean(b(ii:end,jj:end),1),2);
                    else
                        cond_1200(o,oo,i,kk)=nanmean(nanmean(b(ii:end,jj:jj+(ds-1)),1),2);
                    end
                else
                   if (512-jj)<(ds-1)
                        cond_1200(o,oo,i,kk)=nanmean(nanmean(b(ii:ii+(ds-1),jj:end),1),2);
                   else
                        cond_1200(o,oo,i,kk)=nanmean(nanmean(b(ii:ii+(ds-1),jj:jj+(ds-1)),1),2);
                   end 
                end
            end
        end
    end   
end
fr_dev=nanmean(cond_1200(:,:,fr0,:),3);
cond_1200=cond_1200./repmat(fr_dev,[1 1 fr 1]);
cd ..
cd Matt_files
for z=1:size(cond_1200,4)
    disp(z)
    tr=cond_1200(:,:,:,z);
    eval(['save cond_1200_trial',int2str(z),' tr'])
end
cond_1200_ave=nanmean(cond_1200,4);
save cond_1200_ave cond_1200_ave 
save norm_frame_1200 fr_dev fr0
clear cond_1200



cd D:\intrinsic\20160215\b\Matt_files
load('trials_ind.mat')
load pixels_to_remove
cd ..
list1 = dir('20161502*');
fr0=10:13;
ds=2;



cd Tiff_files
l = dir('Trial1frame*');
fr=size(l,1);

kk=0;
cond_100=nan*ones(256,256,fr,size(tr_100,2));
for j=tr_100 
    kk=kk+1;
    k=0;
    disp(j)
     
    eval(['list2 = dir(''Trial',int2str(j),'frame*'');'])
    for i=1:size(list2,1)       
        k=k+1;
        eval(['a=imread(''Trial',int2str(j),'frame',int2str(i),''');'])
        c=reshape(a,512*512,1);
        c(pixels_to_remove,:)=nan;
        a=reshape(c,512,512);
        b=im2double(a);
        o=0;
        for ii=1:ds:512
            %disp(ii)
            o=o+1;
            oo=0;
            for jj=1:ds:512
                oo=oo+1;
                
                if (512-ii)<(ds-1)
                    if (512-jj)<(ds-1)
                        cond_100(o,oo,i,kk)=nanmean(nanmean(b(ii:end,jj:end),1),2);
                    else
                        cond_100(o,oo,i,kk)=nanmean(nanmean(b(ii:end,jj:jj+(ds-1)),1),2);
                    end
                else
                   if (512-jj)<(ds-1)
                        cond_100(o,oo,i,kk)=nanmean(nanmean(b(ii:ii+(ds-1),jj:end),1),2);
                   else
                        cond_100(o,oo,i,kk)=nanmean(nanmean(b(ii:ii+(ds-1),jj:jj+(ds-1)),1),2);
                   end 
                end
            end
        end
    end   
end
fr_dev=nanmean(cond_100(:,:,fr0,:),3);
cond_100=cond_100./repmat(fr_dev,[1 1 fr 1]);
cd ..
cd Matt_files
for z=1:size(cond_100,4)
    disp(z)
    tr=cond_100(:,:,:,z);
    eval(['save cond_100_trial',int2str(z),' tr'])
end
cond_100_ave=nanmean(cond_100,4);
save cond_100_ave cond_100_ave 
save norm_frame_100 fr_dev fr0
clear cond_100
cd ..


cd Tiff_files 
kk=0;
cond_1200=nan*ones(256,256,fr,size(tr_1200,2));
for j=tr_1200 
    kk=kk+1;
    k=0;
    disp(j)
    
    eval(['list2 = dir(''Trial',int2str(j),'frame*'');'])
    for i=1:size(list2,1)       
        k=k+1;
        eval(['a=imread(''Trial',int2str(j),'frame',int2str(i),''');'])
        c=reshape(a,512*512,1);
        c(pixels_to_remove,:)=nan;
        a=reshape(c,512,512);
        b=im2double(a);
        o=0;
        for ii=1:ds:512
            %disp(ii)
            o=o+1;
            oo=0;
            for jj=1:ds:512
                oo=oo+1;
                
                if (512-ii)<(ds-1)
                    if (512-jj)<(ds-1)
                        cond_1200(o,oo,i,kk)=nanmean(nanmean(b(ii:end,jj:end),1),2);
                    else
                        cond_1200(o,oo,i,kk)=nanmean(nanmean(b(ii:end,jj:jj+(ds-1)),1),2);
                    end
                else
                   if (512-jj)<(ds-1)
                        cond_1200(o,oo,i,kk)=nanmean(nanmean(b(ii:ii+(ds-1),jj:end),1),2);
                   else
                        cond_1200(o,oo,i,kk)=nanmean(nanmean(b(ii:ii+(ds-1),jj:jj+(ds-1)),1),2);
                   end 
                end
            end
        end
    end   
end
fr_dev=nanmean(cond_1200(:,:,fr0,:),3);
cond_1200=cond_1200./repmat(fr_dev,[1 1 fr 1]);
cd ..
cd Matt_files
for z=1:size(cond_1200,4)
    disp(z)
    tr=cond_1200(:,:,:,z);
    eval(['save cond_1200_trial',int2str(z),' tr'])
end
cond_1200_ave=nanmean(cond_1200,4);
save cond_1200_ave cond_1200_ave 
save norm_frame_1200 fr_dev fr0
clear cond_1200


cd D:\intrinsic\20160215\c\Matt_files
load('trials_ind.mat')
load pixels_to_remove
cd ..
list1 = dir('20161502*');
fr0=10:13;
ds=2;



cd Tiff_files
l = dir('Trial1frame*');
fr=size(l,1);

kk=0;
cond_100=nan*ones(256,256,fr,size(tr_100,2));
for j=tr_100 
    kk=kk+1;
    k=0;
    disp(j)
     
    eval(['list2 = dir(''Trial',int2str(j),'frame*'');'])
    for i=1:size(list2,1)       
        k=k+1;
        eval(['a=imread(''Trial',int2str(j),'frame',int2str(i),''');'])
        c=reshape(a,512*512,1);
        c(pixels_to_remove,:)=nan;
        a=reshape(c,512,512);
        b=im2double(a);
        o=0;
        for ii=1:ds:512
            %disp(ii)
            o=o+1;
            oo=0;
            for jj=1:ds:512
                oo=oo+1;
                
                if (512-ii)<(ds-1)
                    if (512-jj)<(ds-1)
                        cond_100(o,oo,i,kk)=nanmean(nanmean(b(ii:end,jj:end),1),2);
                    else
                        cond_100(o,oo,i,kk)=nanmean(nanmean(b(ii:end,jj:jj+(ds-1)),1),2);
                    end
                else
                   if (512-jj)<(ds-1)
                        cond_100(o,oo,i,kk)=nanmean(nanmean(b(ii:ii+(ds-1),jj:end),1),2);
                   else
                        cond_100(o,oo,i,kk)=nanmean(nanmean(b(ii:ii+(ds-1),jj:jj+(ds-1)),1),2);
                   end 
                end
            end
        end
    end   
end
fr_dev=nanmean(cond_100(:,:,fr0,:),3);
cond_100=cond_100./repmat(fr_dev,[1 1 fr 1]);
cd ..
cd Matt_files
for z=1:size(cond_100,4)
    disp(z)
    tr=cond_100(:,:,:,z);
    eval(['save cond_100_trial',int2str(z),' tr'])
end
cond_100_ave=nanmean(cond_100,4);
save cond_100_ave cond_100_ave 
save norm_frame_100 fr_dev fr0
clear cond_100
cd ..


cd Tiff_files 
kk=0;
cond_1200=nan*ones(256,256,fr,size(tr_1200,2));
for j=tr_1200 
    kk=kk+1;
    k=0;
    disp(j)
    
    eval(['list2 = dir(''Trial',int2str(j),'frame*'');'])
    for i=1:size(list2,1)       
        k=k+1;
        eval(['a=imread(''Trial',int2str(j),'frame',int2str(i),''');'])
        c=reshape(a,512*512,1);
        c(pixels_to_remove,:)=nan;
        a=reshape(c,512,512);
        b=im2double(a);
        o=0;
        for ii=1:ds:512
            %disp(ii)
            o=o+1;
            oo=0;
            for jj=1:ds:512
                oo=oo+1;
                
                if (512-ii)<(ds-1)
                    if (512-jj)<(ds-1)
                        cond_1200(o,oo,i,kk)=nanmean(nanmean(b(ii:end,jj:end),1),2);
                    else
                        cond_1200(o,oo,i,kk)=nanmean(nanmean(b(ii:end,jj:jj+(ds-1)),1),2);
                    end
                else
                   if (512-jj)<(ds-1)
                        cond_1200(o,oo,i,kk)=nanmean(nanmean(b(ii:ii+(ds-1),jj:end),1),2);
                   else
                        cond_1200(o,oo,i,kk)=nanmean(nanmean(b(ii:ii+(ds-1),jj:jj+(ds-1)),1),2);
                   end 
                end
            end
        end
    end   
end
fr_dev=nanmean(cond_1200(:,:,fr0,:),3);
cond_1200=cond_1200./repmat(fr_dev,[1 1 fr 1]);
cd ..
cd Matt_files
for z=1:size(cond_1200,4)
    disp(z)
    tr=cond_1200(:,:,:,z);
    eval(['save cond_1200_trial',int2str(z),' tr'])
end
cond_1200_ave=nanmean(cond_1200,4);
save cond_1200_ave cond_1200_ave 
save norm_frame_1200 fr_dev fr0
clear cond_1200




