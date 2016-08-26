

cd D:\intrinsic\20150210\mouse_tgg6fl23_1\c\Matt_files
load pixels_to_remove 
cd D:\intrinsic\20150210\mouse_tgg6fl23_1\c\Tiff_files
fr0=4:5;
kk=0; 
for j=2:2:20
    tr=nan*ones(2048,2048,50);
    k=0;
    disp(j)
    for i=1:10:500
        
        k=k+1;
        
        eval(['a=imread(''Trial',int2str(j),'frame',int2str(i),''');'])
        c=reshape(a,2048*2048,1);
        c(pixels_to_remove,:)=nan;
        a=reshape(c,2048,2048);
        b=im2double(a);
        tr(:,:,k)=b;
    end
    tr=tr./repmat(nanmean(tr(:,:,fr0),3),[1 1 50]);
    kk=kk+1;
    if kk==1
        tr_ave=tr;
    else
        tr_ave=tr_ave+tr;
    end
    clear tr
end    
tr_ave=tr_ave/kk;    
cd D:\intrinsic\20150210\mouse_tgg6fl23_1\c\Matt_files
save stim_ave_2048x2048 tr_ave
    
%%
cd D:\intrinsic\20150210\mouse_tgg6fl23_1\c\Tiff_files
kk=0;
for j=1:2:20
    tr=nan*ones(2048,2048,50);
    k=0;
    disp(j)
    for i=1:10:500
        k=k+1;
        
        eval(['a=imread(''Trial',int2str(j),'frame',int2str(i),''');'])
        c=reshape(a,2048*2048,1);
        c(pixels_to_remove,:)=nan;
        a=reshape(c,2048,2048);
        b=im2double(a);
        tr(:,:,k)=b;
    end
    tr=tr./repmat(nanmean(tr(:,:,fr0),3),[1 1 50]);
    kk=kk+1;
    if kk==1
        tr_ave_bl=tr;
    else
        tr_ave_bl=tr_ave_bl+tr;
    end
    clear tr
end    
tr_ave_bl=tr_ave_bl/kk;    
cd D:\intrinsic\20150210\mouse_tgg6fl23_1\c\Matt_files
save blank_ave_2048x2048 tr_ave_bl    
    