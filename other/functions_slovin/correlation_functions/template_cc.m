for t=1:27
    a(:,:,t)=a(:,:,t)./repmat(max(a([roi_f2;roi_f1late;roi_circle{t};roi_maskout;roi_maskout],:,t)),[10000 1]);
end

template1=zeros(10000,1);
template1(roi_maskin)=1;
template1(roi_maskout)=1;

ind=popout_index-popout_index2;
time=46:110;

for j=1:27
    
    figure;
    
    title(['trial #',int2str(j),': bg is max at ',int2str(find(popout_index(:,j)==max(popout_index(time,j)))),' circle is max at ',int2str(find(popout_index2(:,j)==max(popout_index2(time,j))))])
end

