cd D:\intrinsic\20141111\b\Matt_files
load('stim_ave.mat')
cd D:\intrinsic\20141111\b\Tiff_files 

kk=0;
for j=2:2:60
    tr=nan*ones(2048,2048,50);
    k=0;
    disp(j)
    for i=1:10:500
        
        k=k+1;
        
        eval(['a=imread(''Trial',int2str(j),'frame',int2str(i),''');'])
        b=im2double(a);
        tr(:,:,k)=b;
    end
    tr=tr./repmat(nanmean(tr(:,:,1:5),3),[1 1 50]);
    kk=kk+1;
    if kk==1
        tr_std=(tr-tr_ave).^2;
    else
        tr_std=tr_std+(tr-tr_ave).^2;
    end
    clear tr
end    
tr_std=sqrt(tr_std/(kk-1));    
cd D:\intrinsic\20141111\b\Matt_files    
save stim_std tr_std    
%%

cd D:\intrinsic\20141111\b\Matt_files
load('blank_ave.mat')
cd D:\intrinsic\20141111\b\Tiff_files 

kk=0;
for j=1:2:60
    tr=nan*ones(2048,2048,50);
    k=0;
    disp(j)
    for i=1:10:500
        
        k=k+1;
        
        eval(['a=imread(''Trial',int2str(j),'frame',int2str(i),''');'])
        b=im2double(a);
        tr(:,:,k)=b;
    end
    tr=tr./repmat(nanmean(tr(:,:,1:5),3),[1 1 50]);
    kk=kk+1;
    if kk==1
        tr_std_bl=(tr-tr_ave_bl).^2;
    else
        tr_std_bl=tr_std_bl+(tr-tr_ave_bl).^2;
    end
    clear tr
end    
tr_std_bl=sqrt(tr_std_bl/(kk-1));    
cd D:\intrinsic\20141111\b\Matt_files    
save blank_std tr_std_bl    
    