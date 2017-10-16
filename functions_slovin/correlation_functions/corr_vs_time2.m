

circ_cc=zeros(12,2);



circ_cc(1,1)=cc1111c(1,2);
circ_cc(1,2)=cc1111c(2,2);
circ_cc(2,1)=cc1111d(1,2);
circ_cc(2,2)=cc1111d(2,2);
circ_cc(3,1)=cc1111h(1,2);
circ_cc(3,2)=cc1111h(2,2);
circ_cc(4,1)=cc1811(1,2);
circ_cc(4,2)=cc1811(2,2);
circ_cc(5,1)=cc2511(1,2);
circ_cc(5,2)=cc2511(2,2);
circ_cc(6,1)=cc1203(1,2);
circ_cc(6,2)=cc1203(2,2);
circ_cc(7,1)=cc2210d(1,2);
circ_cc(7,2)=cc2210d(2,2);
circ_cc(8,1)=cc2210e(1,2);
circ_cc(8,2)=cc2210e(2,2);
circ_cc(9,1)=cc0610e(1,2);
circ_cc(9,2)=cc0610e(2,2);
circ_cc(10,1)=cc0610f(1,2);
circ_cc(10,2)=cc0610f(2,2);
circ_cc(11,1)=cc0601e(1,2);
circ_cc(11,2)=cc0601e(2,2);
circ_cc(12,1)=cc0601fg(1,2);
circ_cc(12,2)=cc0601fg(2,2);




back_cc=zeros(12,2);
back_time=zeros(12,2,13);


back_cc(1,1)=cc1111c(1,3);
back_cc(1,2)=cc1111c(2,3);
back_cc(2,1)=cc1111d(1,3);
back_cc(2,2)=cc1111d(2,3);
back_cc(3,1)=cc1111h(1,3);
back_cc(3,2)=cc1111h(2,3);
back_cc(4,1)=cc1811(1,3);
back_cc(4,2)=cc1811(2,3);
back_cc(5,1)=cc2511(1,3);
back_cc(5,2)=cc2511(2,3);
back_cc(6,1)=cc1203(1,3);
back_cc(6,2)=cc1203(2,3);
back_cc(7,1)=cc2210d(1,3);
back_cc(7,2)=cc2210d(2,3);
back_cc(8,1)=cc2210e(1,3);
back_cc(8,2)=cc2210e(2,3);
back_cc(9,1)=cc0610e(1,3);
back_cc(9,2)=cc0610e(2,3);
back_cc(10,1)=cc0610f(1,3);
back_cc(10,2)=cc0610f(2,3);
back_cc(11,1)=cc0601e(1,3);
back_cc(11,2)=cc0601e(2,3);
back_cc(12,1)=cc0601fg(1,3);
back_cc(12,2)=cc0601fg(2,3);


diff1=circ_cc(:,1)-circ_cc(:,2);
diff2=back_cc(:,1)-back_cc(:,2);



circ_time=zeros(12,2,44);


circ_time(1,1,:)=time1111c(1,2,:);
circ_time(1,2,:)=time1111c(2,2,:);
circ_time(2,1,:)=time1111d(1,2,:);
circ_time(2,2,:)=time1111d(2,2,:);
circ_time(3,1,:)=time1111h(1,2,:);
circ_time(3,2,:)=time1111h(2,2,:);
circ_time(4,1,:)=time1811(1,2,:);
circ_time(4,2,:)=time1811(2,2,:);
circ_time(5,1,:)=time2511(1,2,:);
circ_time(5,2,:)=time2511(2,2,:);
circ_time(6,1,:)=time1203(1,2,:);
circ_time(6,2,:)=time1203(2,2,:);
circ_time(7,1,:)=time2210d(1,2,:);
circ_time(7,2,:)=time2210d(2,2,:);
circ_time(8,1,:)=time2210e(1,2,:);
circ_time(8,2,:)=time2210e(2,2,:);
circ_time(9,1,:)=time0610e(1,2,:);
circ_time(9,2,:)=time0610e(2,2,:);
circ_time(10,1,:)=time0610f(1,2,:);
circ_time(10,2,:)=time0610f(2,2,:);
circ_time(11,1,:)=time0601e(1,2,:);
circ_time(11,2,:)=time0601e(2,2,:);
circ_time(12,1,:)=time0601fg(1,2,:);
circ_time(12,2,:)=time0601fg(2,2,:);






back_time=zeros(12,2,44);


back_time(1,1,:)=time1111c(1,3,:);
back_time(1,2,:)=time1111c(2,3,:);
back_time(2,1,:)=time1111d(1,3,:);
back_time(2,2,:)=time1111d(2,3,:);
back_time(3,1,:)=time1111h(1,3,:);
back_time(3,2,:)=time1111h(2,3,:);
back_time(4,1,:)=time1811(1,3,:);
back_time(4,2,:)=time1811(2,3,:);
back_time(5,1,:)=time2511(1,3,:);
back_time(5,2,:)=time2511(2,3,:);
back_time(6,1,:)=time1203(1,3,:);
back_time(6,2,:)=time1203(2,3,:);
back_time(7,1,:)=time2210d(1,3,:);
back_time(7,2,:)=time2210d(2,3,:);
back_time(8,1,:)=time2210e(1,3,:);
back_time(8,2,:)=time2210e(2,3,:);
back_time(9,1,:)=time0610e(1,3,:);
back_time(9,2,:)=time0610e(2,3,:);
back_time(10,1,:)=time0610f(1,3,:);
back_time(10,2,:)=time0610f(2,3,:);
back_time(11,1,:)=time0601e(1,3,:);
back_time(11,2,:)=time0601e(2,3,:);
back_time(12,1,:)=time0601fg(1,3,:);
back_time(12,2,:)=time0601fg(2,3,:);


high_time=zeros(5,2,44);


high_time(1,1,:)=time1111c(1,4,:);
high_time(1,2,:)=time1111c(2,4,:);
high_time(2,1,:)=time1111d(1,4,:);
high_time(2,2,:)=time1111d(2,4,:);
high_time(3,1,:)=time1811(1,4,:);
high_time(3,2,:)=time1811(2,4,:);
high_time(4,1,:)=time2511(1,4,:);
high_time(4,2,:)=time2511(2,4,:);
high_time(5,1,:)=time1203(1,4,:);
high_time(5,2,:)=time1203(2,4,:);



diff_time1=squeeze(circ_time(:,1,:))-squeeze(circ_time(:,2,:));

diff_time2=squeeze(back_time(:,1,:))-squeeze(back_time(:,2,:));

diff_time3=squeeze(high_time(:,1,:))-squeeze(high_time(:,2,:));

diff=[mean(diff_time1,1) ; mean(diff_time2,1) ; mean(diff_time3,1)];
%diff3=[mean(diff_time1(:,8:10),2)  mean(diff_time2(:,8:10),2)];


t1=squeeze(time1203(1,2,:))-squeeze(time1203(2,2,:));
t2=squeeze(time1203(1,3,:))-squeeze(time1203(2,3,:));
t3=squeeze(time1203(1,4,:))-squeeze(time1203(2,4,:));


for i=1:44
    [h p1(i)]=ttest(diff_time1(:,i));
    [h p2(i)]=ttest(diff_time2(:,i));
    [h p3(i)]=ttest(diff_time3(:,i));
    p4(i)=ranksum(diff_time1(:,i),diff_time2(:,i));
    p5(i)=ranksum(diff_time1(:,i),diff_time3(:,i));
    p6(i)=ranksum(diff_time2(:,i),diff_time3(:,i));
    
end

[h p7]=ttest(mean(diff_time1(:,8:18),2));
[h p8]=ttest(mean(diff_time2(:,8:18),2));
[h p9]=ttest(mean(diff_time3(:,8:18),2));
p10=ranksum(mean(diff_time1(:,8:18),2),mean(diff_time2(:,8:18),2));
p11=ranksum(mean(diff_time1(:,8:18),2),mean(diff_time3(:,8:18),2));
p12=ranksum(mean(diff_time3(:,8:18),2),mean(diff_time2(:,8:18),2));




