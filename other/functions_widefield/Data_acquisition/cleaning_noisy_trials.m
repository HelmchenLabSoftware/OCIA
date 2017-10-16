
cd D:\intrinsic\20141111\b\Matt_files
load('stim_ave.mat')
m=reshape(tr_ave,2048*2048,50);
clear stim ave

load('stim_std.mat')
s=reshape(tr_std,2048*2048,50);
clear stim std

load('roi_s1.mat')

figure;errorbar(squeeze(nanmean(m(roi_s1,:),1))-1,squeeze(nanmean(s(roi_s1,:),1)),'Color','k','LineWidth',3)
hold on
figure;plot(squeeze(nanmean(m(roi_s1,:),1))-1,'Color','k','LineWidth',3)

cd D:\intrinsic\20141111\b\Tiff_files
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
    figure;errorbar(squeeze(nanmean(m(roi_s1,:),1))-1,squeeze(nanmean(s(roi_s1,:),1)))
    hold on
    tr=reshape(tr,2048*2048,50);
    plot(squeeze(nanmean(tr(roi_s1,:),1))-1,'r')
    title(['Trial #',int2str(j)])
    shg
    clear tr
end    

tr_good=[2 8 10 12 18 20 30 36 46 48 58];