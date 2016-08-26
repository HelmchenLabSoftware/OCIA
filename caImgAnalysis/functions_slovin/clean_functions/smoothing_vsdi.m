

w=16;
a=zeros(10000,255-w,27);
for i = 1:(255-16)
    a(:,i,:)=mean((cond1n_dt_bl(:,i:i+w-1,:)-1).*repmat(hamming(w)',[10000 1 27]),2);
end