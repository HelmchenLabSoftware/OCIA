%cd D:\intrinsic\20150423\green\Tiff_files

pix=512;
a=imread('Trial1frame2');
green=im2double(a);
figure(100);imagesc(green,[-0.1 0.9]);colormap(gray)
chamber = choose_polygon_imagesc(pix);      

t=zeros(pix*pix,1);
t(chamber)=1;
pixels_to_remove=find(t==0);


%% down sampling
ds=2;
pix=512;
green_ds=nan*ones(256,256,1);
k=0;
for i=1:ds:pix
    k=k+1;
    kk=0;
    for j=1:ds:pix
        kk=kk+1;
        disp(i)
        if (pix-i)<(ds-1)
            if (pix-j)<(ds-1)
                green_ds(k,kk,:)=nanmean(nanmean(green(i:end,j:end,:),1),2);
            else
                green_ds(k,kk,:)=nanmean(nanmean(green(i:end,j:j+(ds-1),:),1),2);
            end
        else
           if (pix-j)<(ds-1)
                green_ds(k,kk,:)=nanmean(nanmean(green(i:i+(ds-1),j:end,:),1),2);
           else
                green_ds(k,kk,:)=nanmean(nanmean(green(i:i+(ds-1),j:j+(ds-1),:),1),2);
           end 
        end
    end
end
figure;imagesc(green_ds,[0 0.3]);colormap(gray)
cd ..
save green_ds green_ds