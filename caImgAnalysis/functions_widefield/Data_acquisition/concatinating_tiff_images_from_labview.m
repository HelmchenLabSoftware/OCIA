

cd D:\intrinsic\20141111\b\tiff
tr4=nan*ones(2048,2048,50);
k=0;
for i=1:10:500
    k=k+1;
    disp(i)
    eval(['a=imread(''frame',int2str(i),''');'])
    b=im2double(a);
    tr4(:,:,k)=b;
end

%%

cd D:\intrinsic\20141111\b\tiff3\
tr3=nan*ones(2048,2048,50);
k=0;
for i=1:10:500
    k=k+1;
    disp(i)
    eval(['a=imread(''frame',int2str(i),''');'])
    b=im2double(a);
    tr3(:,:,k)=b;
end
