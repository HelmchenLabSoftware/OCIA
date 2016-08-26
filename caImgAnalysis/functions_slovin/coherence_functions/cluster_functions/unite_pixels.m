function unite_pixels(r,i,date)


i = str2double(i);
load (date)
eval(['a=size(roi_',r,',1);'])

cd /home/ariel/data/111c
load pixels_to_remove
t=ones(10000,1);
t(pixels_to_remove)=0;
pix=find(t);
clear t
k=0;
for d=1:a
    
    eval(['p=roi_',r,'(',int2str(d),');'])
    eval(['load ',date,'coher_cond',int2str(i),'_pix_',int2str(p)])
    if d==1
        eval(['coher_',r,'_cond',int2str(i),'=coher_cond',int2str(i),'_pix_',int2str(p),';'])
    else
        eval(['coher_',r,'_cond',int2str(i),'=coher_',r,'_cond',int2str(i),'+coher_cond',int2str(i),'_pix_',int2str(p),';'])
    end;
    eval(['clear coher_cond',int2str(i),'_pix_',int2str(p)])
    eval(['delete coher_cond',int2str(i),'_pix_',int2str(p),'.mat'])    
end;
eval(['coher_',r,'_cond',int2str(i),'=shiftdim(coher_',r,'_cond',int2str(i),'/a);'])
eval(['save tcoher_',r,'_cond',int2str(i),' coher_',r,'_cond',int2str(i)])
