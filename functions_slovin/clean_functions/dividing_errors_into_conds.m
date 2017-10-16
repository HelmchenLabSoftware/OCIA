%load rsd_and_cortex_list
error_ind=ttt(cond_cam==7);
k=0;
for i=error_ind'
    k=k+1;
    cond_error(k)=list4data{i,2};
end

load cond7n.mat
cond1n=cond7n(:,:,cond_error==1);
cond2n=cond7n(:,:,cond_error==2);
cond3n=cond7n(:,:,cond_error==3);
cond4n=cond7n(:,:,cond_error==4);
cond5n=cond7n(:,:,cond_error==5);
save cond1n_error cond1n
save cond2n_error cond2n
save cond3n_error cond3n
save cond4n_error cond4n
save cond5n_error cond5n
clear cond*n







