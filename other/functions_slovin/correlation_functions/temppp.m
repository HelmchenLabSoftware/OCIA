clear all
cd F:\Data\VSDI\Contour_integration\Smeagol\29Dec2010\c\pixelwise
load corr_circ_circ

h=zeros(10000,1);
h(roi_circle)=1;
m=reshape(h,100,100);
[r c]=find(m);
for i=1:size(roi_circle,1)
    for j=1:size(roi_circle,1)
       dist_mat(i,j)=sqrt((r(i)-r(j))^2+(c(i)-c(j))^2);
    end
end
diff=cont_circ_circ-non_circ_circ;
[d_sort,dist_ind]=sort(reshape(dist_mat,1,size(dist_mat,1)*size(dist_mat,1)));

u=unique(d_sort);
for i=1:size(u,2)
    for j=1:size(diff,2)
        ddd(i,j)=mean(diff(dist_ind(d_sort==u(i)),j),1);
        dddc(i,j)=mean(cont_circ_circ(dist_ind(d_sort==u(i)),j),1);
        dddn(i,j)=mean(non_circ_circ(dist_ind(d_sort==u(i)),j),1);
    end
end

dist_vec=0:0.5/0.17:floor(max(u));
kkk=0;
for i=2:size(dist_vec,2)
    kkk=kkk+1;
    for j=1:size(diff,2)
        ttt=find((dist_vec(i-1)<u)&(u<=dist_vec(i)));
        dist_cont(kkk,j)=mean(dddc(ttt,j),1);
        dist_non(kkk,j)=mean(dddn(ttt,j),1);
        dist_diff(kkk,j)=mean(ddd(ttt,j),1);
    end
end
figure;plot(dist_vec(2:end)*0.17,mean(dist_cont,2));
hold on
plot(dist_vec(2:end)*0.17,mean(dist_non,2),'r');
xlim([0 8])
figure;plot(dist_vec(2:end)*0.17,mean(dist_diff,2));
xlim([0 8])

st=50;
for jj=1:size(diff,2)
    k=-st;
    for j=1:floor((size(ddd,1)-st)/st)
        k=k+st;
        us(j)=mean(u(j+k:j+k+st));
        dist_diff2(j,jj)=mean(ddd(j+k:j+k+st,jj),1);
        dist_cont2(j,jj)=mean(dddc(j+k:j+k+st,jj),1);
        dist_non2(j,jj)=mean(dddn(j+k:j+k+st,jj),1);
    end
end
dist_vec=us*0.17;
figure;plot(dist_vec,mean(dist_diff2,2))
xlim([0 13])
hold on
plot(dist_vec,zeros(1,size(us,2)),'k')
figure;plot(us*0.17,mean(dist_cont2,2))
hold on
plot(dist_vec,mean(dist_non2,2),'r')
xlim([0 13])








