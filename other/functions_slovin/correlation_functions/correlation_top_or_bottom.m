

x=(20:10:1130)-240;


diff_V2_V2=cc_V2_V2_cont-cc_V2_V2_non;

diff_circ_V2=cc_circ_V2_cont-cc_circ_V2_non;

diff_circ_V22=cc_circ_V22_cont-cc_circ_V22_non;

diff_circ_circ=cc_circ_circ_cont-cc_circ_circ_non;


diff_top=(diff_V2_V2-diff_circ_V22)';

diff_bottom=(diff_circ_circ-diff_circ_V2)';

figure;plot(x,mean(diff_bottom,2))
xlim([-100 250])

figure;plot(x,mean(diff_top,2))
xlim([-100 250])


for i=1:112
    p1(i)=signrank(diff_bottom(i,:));
    p2(i)=signrank(diff_top(i,:));
    %p3(i)=signrank(diff_top(i,:)-diff_bottom(i,:));
end

x(p1<0.01)
x(p2<0.05)
x(p3<0.05)


signrank(mean(diff_bottom(31:34,:),1))
signrank(mean(diff_bottom(42:45,:),1))

signrank(mean(diff_top(31:34,:),1))
signrank(mean(diff_top(42:45,:),1))


for i=1:13
    figure;plot(x,diff_bottom(:,i))
    hold on
    xlim([-100 250])
    plot(x,diff_top(:,i),'r')
end



for i=1:13
    figure;plot(x,diff_bottom(:,i))
    hold on
    xlim([-100 250])
    plot(x,diff_top(:,i),'r')
end



for i=1:13
    figure;plot(x,diff_top(:,i)-diff_bottom(:,i))
    xlim([-100 250])
end


lim=-.2:0.01:0.2;
n1=hist(mean(diff_bottom(31:34,:),1),lim);
n2=hist(mean(diff_top(31:34,:),1),lim);
n3=hist(mean(diff_bottom(42:45,:),1),lim);
n4=hist(mean(diff_top(42:45,:),1),lim);


figure;bar(lim,[n1/size(diff_bottom,2);n2/size(diff_top,2)]')
figure;bar(lim,[n3/size(diff_bottom,2);n4/size(diff_top,2)]')





diff_V2_V2=cc_V2_V2_1811e_cont - cc_V2_V2_1811e_non;

diff_circ_V2=cc_circ_V2_1811e_cont - cc_circ_V2_1811e_non;

diff_circ_V22=cc_circ_V22_1811e_cont -cc_circ_V22_1811e_non;

diff_circ_circ=cc_circ_circ_1811e_cont -cc_circ_circ_1811e_non;


diff_top=(diff_V2_V2-diff_circ_V22)';

diff_bottom=(diff_circ_circ-diff_circ_V2)';

figure;plot(x,mean(diff_bottom,2))
xlim([-100 250])

figure;plot(x,mean(diff_top,2))
xlim([-100 250])






p=roi_contour(mean(diff_bottom(31:34,:),1)<0);
h=zeros(10000,1);
h(p)=1;
figure;mimg(h,100,100,0,1)

p=roi_contour(mean(diff_bottom(31:34,:),1)>0);
h=zeros(10000,1);
h(p)=1;
figure;mimg(h,100,100,0,1)

h=zeros(10000,1);
h(roi_contour)=1;
figure;mimg(h,100,100,0,1)

%

p=roi_V2(mean(diff_top(31:34,:),1)<0);
h=zeros(10000,1);
h(p)=1;
figure;mimg(h,100,100,0,1)

p=roi_V2(mean(diff_top(31:34,:),1)>0);
h=zeros(10000,1);
h(p)=1;
figure;mimg(h,100,100,0,1)

h=zeros(10000,1);
h(roi_V2)=1;
figure;mimg(h,100,100,0,1)





