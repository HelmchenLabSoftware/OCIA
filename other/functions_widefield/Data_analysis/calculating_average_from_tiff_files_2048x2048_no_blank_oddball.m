cd D:\SimonData\Matt_files
load pixels_to_remove
cd .. 
%list1 = dir('20152804*');
list1 = dir('Session*');



cd Tiff_files
fr0=5:15;
jump=1;
kk=0; 
for j=1:size(list1,1)
    tr=nan*ones(2048,2048,100);
    k=0;
    disp(j)
    eval(['list2 = dir(''Trial',int2str(j),'frame*'');'])
    for i=1:jump:size(list2,1)      
        k=k+1;
        eval(['a=imread(''Trial',int2str(j),'frame',int2str(i),''');'])
        c=reshape(a,2048*2048,1);
        c(pixels_to_remove,:)=nan;
        a=reshape(c,2048,2048);
        b=im2double(a);
        tr(:,:,k)=b;
    end
    tr=tr./repmat(nanmean(tr(:,:,fr0),3),[1 1 100]);
    kk=kk+1;
    if kk==1
        tr_ave=tr;
    else
        tr_ave=tr_ave+tr;
    end
    clear tr
end    
tr_ave=tr_ave/kk; 
cd ..
cd Matt_files
save stim_ave_2048x2048 tr_ave
    


%%
cd D:\SimonData\Matt_files
load pixels_to_remove
cd .. 
%list1 = dir('20152804*');
list1 = dir('Session*');



cd Tiff_files
fr0=55:65;
jump=1;
kk=0; 
for j=1:size(list1,1)
    tr=nan*ones(2048,2048,100);
    k=0;
    disp(j)
    eval(['list2 = dir(''Trial',int2str(j),'frame*'');'])
    for i=1:jump:size(list2,1)      
        k=k+1;
        eval(['a=imread(''Trial',int2str(j),'frame',int2str(i),''');'])
        c=reshape(a,2048*2048,1);
        c(pixels_to_remove,:)=nan;
        a=reshape(c,2048,2048);
        b=im2double(a);
        tr(:,:,k)=b;
    end
    tr=tr./repmat(nanmean(tr(:,:,fr0),3),[1 1 100]);
    kk=kk+1;
    if kk==1
        tr_ave=tr;
    else
        tr_ave=tr_ave+tr;
    end
    clear tr
end    
tr_ave=tr_ave/kk; 
cd ..
cd Matt_files
save stim_ave_2048x2048_fr0_2 tr_ave
    
