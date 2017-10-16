%resampling


load cond1n_dt_bl
load cond4n_dt_bl

a=size(cond1n_dt_bl,3);
b=size(cond4n_dt_bl,3);
s=min(a,b);

cond41n_dt_bl=zeros(10000,256,floor(s/2)*2);

for i=1:floor(s/2)
    x=floor(rand*s)+1;
    cond41n_dt_bl(:,:,i)=cond1n_dt_bl(:,:,x);
end

for i=floor(s/2):floor(s/2)*2
    x=floor(rand*s)+1;
    cond41n_dt_bl(:,:,i)=cond4n_dt_bl(:,:,x);
end



save cond41n_dt_bl cond41n_dt_bl

 