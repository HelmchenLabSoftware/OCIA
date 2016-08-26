cd D:\intrinsic\20150320\a\Matt_files
load pixels_to_remove

fr0=4:5;

kk=0;
for j=2:2:60
    tr=nan*ones(2048,2048,50);
    k=0;
    disp(j)
    for i=1:10:500       
        k=k+1;
        cd D:\intrinsic\20150320\a\Tiff_files 
        eval(['a=imread(''Trial',int2str(j),'frame',int2str(i),''');'])
        c=reshape(a,2048*2048,1);
        c(pixels_to_remove,:)=nan;
        a=reshape(c,2048,2048);
        b=im2double(a');
        tr(:,:,k)=b;
    end
    tr=tr./repmat(nanmean(tr(:,:,fr0),3),[1 1 50]);
    kk=kk+1;
    cd D:\intrinsic\20150320\a\Matt_files
    eval(['save trial_stim_',int2str(kk),' tr fr0'])
    clear tr
end    
 

%%


kk=0;
for j=1:2:60
    tr=nan*ones(2048,2048,50);
    k=0;
    disp(j)
    for i=1:10:500       
        k=k+1;
        cd D:\intrinsic\20150107\b\Tiff_files 
        eval(['a=imread(''Trial',int2str(j),'frame',int2str(i),''');'])
        c=reshape(a,2048*2048,1);
        c(pixels_to_remove,:)=nan;
        a=reshape(c,2048,2048);
        b=im2double(a');
        tr(:,:,k)=b;
    end
    tr=tr./repmat(nanmean(tr(:,:,fr0),3),[1 1 50]);
    kk=kk+1;
    cd D:\intrinsic\20150107\b\Matt_files
    eval(['save trial_bl_',int2str(kk),' tr fr0'])
    clear tr
end    
 
    