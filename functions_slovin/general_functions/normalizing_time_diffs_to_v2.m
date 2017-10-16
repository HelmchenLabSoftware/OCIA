


max_V2=max(time_V2(28:48,:),[],1);

time_V2n=time_V2./repmat(max_V2,256,1)*100;
time_circn=time_circ(:,1:13)./repmat(max_V2,256,1)*100;
time_bgin=time_bgi(:,1:13)./repmat(max_V2,256,1)*100;



figure
bar(x,mean(time_V2n,2),'r')
hold on
xlim([-100 350])
bar(x,mean(time_circn,2),'b')
bar(x,mean(time_bgin,2),'g')





figure
bar(x,[mean(time_V2n,2) mean(time_circn,2) mean(time_bgin,2)])
xlim([-100 350])


for i=1:256
    p1(i)=signrank(time_V2n(i,:));
    p2(i)=signrank(time_circn(i,:));
    p3(i)=signrank(time_bgin(i,:));
end

t=find(p1<0.05);
x(t)
p1(t)
t=find(p2<0.05);
x(t)
p2(t)
t=find(p3<0.05);
x(t)
p3(t)




figure;plot(x,time_circn)
xlim([-100 350])



for i=1:13
    figure
    bar(x,[time_V2n(:,i) time_circn(:,i) time_bgin(:,i)])
    xlim([-100 350])
end





