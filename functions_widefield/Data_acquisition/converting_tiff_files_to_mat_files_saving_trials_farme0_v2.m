
cd D:\intrinsic\20150128\e\Matt_files
load pixels_to_remove
cd ..
list1 = dir('20152801*');
fr0=9:11;

kk=0;
for j=1:size(list1,1) 
    tr=nan*ones(2048,2048,60);
    k=0;
    disp(j)
    cd D:\intrinsic\20150128\e\Tiff_files 
    eval(['list2 = dir(''Trial',int2str(j),'frame*'');'])
    for i=1:3:size(list2,1)       
        k=k+1;
        
        eval(['a=imread(''Trial',int2str(j),'frame',int2str(i),''');'])
        c=reshape(a,2048*2048,1);
        c(pixels_to_remove,:)=nan;
        a=reshape(c,2048,2048);
        b=im2double(a);
        tr(:,:,k)=b;
    end
    fr_dev=nanmean(tr(:,:,fr0),3);
    tr=tr./repmat(fr_dev,[1 1 60]);
    kk=kk+1;
    cd D:\intrinsic\20150128\e\Matt_files
    eval(['save trial_',int2str(kk),' tr fr0 fr_dev'])
    clear tr
end    


