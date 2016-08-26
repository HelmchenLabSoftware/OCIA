cd D:\intrinsic\20141111
load('pixels_to_remove.mat')

cd D:\intrinsic\20141111\b\Matt_files
stim=zeros(2048,2048,30);
blank=zeros(2048,2048,30);
hyp=nan*ones(2048*2048,50);
pval=nan*ones(2048*2048,50);
for i=1:50
    disp(i)
    k=0;
    for j=1:30
        %disp(j)
        k=k+1;
        eval(['load trial_stim_',int2str(j)])
        stim(:,:,j)=tr(:,:,i);
        clear tr
    end
    kk=0;
    for j=1:30
        %disp(j)
        kk=kk+1;
        eval(['load trial_bl_',int2str(j)])
        blank(:,:,j)=tr(:,:,i);
        clear tr
    end
    stim2=reshape(stim,2048*2048,30);
    blank2=reshape(blank,2048*2048,30);
    
    for px=chamber'
        %disp(px)
        [p,h]=ranksum(stim2(px,:),blank2(px,:));
        pval(px,i)=p;
        hyp(px,i)=h;
    end
end
pval2=reshape(pval,[2048,2048,50]);
hyp2=reshape(hyp,[2048,2048,50]);
    
    
    
    
    
    