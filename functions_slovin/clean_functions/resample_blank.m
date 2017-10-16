%resampling


load cond3n_dt_bl
a=size(cond3n_dt_bl,3);

for i=1:a
    x=floor(rand*a)+1;
    y=floor(rand*a)+1;
    cond33n_dt_bl(:,:,i)=cond3n_dt_bl(:,:,x);
    cond34n_dt_bl(:,:,i)=cond3n_dt_bl(:,:,y);
end

save cond33n_dt_bl cond33n_dt_bl
save cond34n_dt_bl cond34n_dt_bl

clear  cond3n_dt_bl
    
    
    
    