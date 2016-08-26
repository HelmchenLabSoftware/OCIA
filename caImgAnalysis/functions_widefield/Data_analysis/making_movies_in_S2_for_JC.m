
cd D:\intrinsic\20150127\c\Matt_files
load('cond_100_ave_clean.mat')
cond_100_ave=reshape(cond_100_ave,205,205,180);
x=(1:180)*0.05-2.7;
close all
k=0;
for i=30:66
    k=k+1;
    disp(i)
    y=fliplr(smoothn(cond_100_ave(:,:,i)-1,[5 5],'Gauss')');
    y(isnan(y))=10000;
    imagesc(y(94:134,47:80),[.5e-2 3.2e-2]);colormap(mapgeog)
    axis off
    axis square
    title([int2str(x(i)*1000)])
    hold on
    M(:,k)=getframe(gcf);
end;
movie2avi(M,'cond_100_S2','fps',5);    



%% M2
cd D:\intrinsic\20150127\d\Matt_files
load('cond_100_ave_clean.mat')
cond_100_ave=reshape(cond_100_ave,205,205,180);
x=(1:180)*0.05-2.7;
close all
k=0;
for i=30:66
    k=k+1;
    disp(i)
    y=fliplr(smoothn(cond_100_ave(:,:,i)-1,[5 5],'Gauss')');
    y(isnan(y))=10000;
    imagesc(y(57:90,118:145),[-.5e-2 5e-2]);colormap(mapgeog)
    axis off
    axis square
    title([int2str(x(i)*1000)])
    hold on
    M(:,k)=getframe(gcf);
end;
movie2avi(M,'cond_100_M2','fps',5);    
  



