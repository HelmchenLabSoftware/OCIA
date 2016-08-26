function unite_data_cond1_V1(p,i,date)

p = str2double(p);
i = str2double(i);

cd /home/ariel/data/1111c
load pixels_to_remove
t=ones(10000,1);
t(pixels_to_remove)=0;
pix=find(t);
clear t
k=0;
for d=1:118
    
    k=k+1;
    eval(['cd ',date,'cond',int2str(i),'_pix',int2str(p),'_',int2str(d)])
    eval(['load coher_cond',int2str(i),'_pix_',int2str(p),'_',int2str(d)])
    if k==1
        eval(['coher_cond',int2str(i),'_pix_',int2str(p),'=coher_cond',int2str(i),'_pix_',int2str(p),'_',int2str(ll),';'])
    else
        eval(['coher_cond',int2str(i),'_pix_',int2str(p),'=cat(3,coher_cond',int2str(i),'_pix_',int2str(p),',coher_cond',int2str(i),'_pix_',int2str(p),'_',int2str(ll),');'])
    end;
    eval(['clear coher_cond',int2str(i),'pix_',int2str(p),'_',int2str(d)])
    eval(['delete coher_cond',int2str(i),'_pix_',int2str(p),'_',int2str(d),'.mat'])
    cd ..
    eval(['rmdir ',date,'cond',int2str(i),'_pix',int2str(p),'_',int2str(d)])
end;
eval(['coher_cond',int2str(i),'_pix_',int2str(p),'=coher_cond',int2str(i),'_pix_',int2str(p),'/160;'])
eval(['save ',date,'coher_cond',int2str(i),'_pix_',int2str(p),' coher_cond',int2str(i),'_pix_',int2str(p)])











