%% coherence discrimination

% create coherence conditions

cond=[4 3];    %choose conditions
roi='V1';          %choose region of interest
time=112;          %choose time frames (starting from the begining)

eval(['load coher_',roi,'_cond',int2str(cond(1))])
disp(['cond ',int2str(cond(1))])
a=zeros(10000,32,time);
eval(['a(pixels,:,:)=coher_',roi,'_cond',int2str(cond(1)),';'])
a(isnan(a))=0;
eval(['clear coher_',roi,'_cond',int2str(cond(1))])

eval(['load coher_',roi,'_cond',int2str(cond(2))])  
disp(['cond ',int2str(cond(2))])
b=zeros(10000,32,time);
eval(['b(pixels,:,:)=coher_',roi,'_cond',int2str(cond(2)),';'])
b(isnan(b))=0;
eval(['clear coher_',roi,'_cond',int2str(cond(2))])

%% ALPHA
%% roi V1

[n x1]=hist(mean(mean(abs(a(roi_V1,4:9,20:30)).^2,2),3),0:0.001:1);

[m x2]=hist(mean(mean(abs(b(roi_V1,4:9,20:30)).^2,2),3),0:0.001:1);

p=max(max(find(m)),max(find(n)));

x=x1(1:p+3);

subplot(2,2,1);bar(x,[n(1:p+3);m(1:p+3)]',1.5,'group');xlabel('coherence');ylabel('number of pixels');title('pixel coherence distribution over ROI target');

M(1,1) = ranksum(mean(mean(abs(a(roi_V1,4:9,20:30)).^2,2),3),mean(mean(abs(b(roi_V1,4:9,20:30)).^2,2),3));
[ht1 M(1,2)] = ttest2(mean(mean(abs(a(roi_V1,4:9,20:30)).^2,2),3),mean(mean(abs(b(roi_V1,4:9,20:30)).^2,2),3));

%% roi V1_2

[n x1]=hist(mean(mean(abs(a(roi_V1_2,4:9,20:30)).^2,2),3),0:0.001:1);

[m x2]=hist(mean(mean(abs(b(roi_V1_2,4:9,20:30)).^2,2),3),0:0.001:1);

p=max(max(find(m)),max(find(n)));

x=x1(1:p+3);

subplot(2,2,2);bar(x,[n(1:p+3);m(1:p+3)]',1.5,'group');xlabel('coherence');ylabel('number of pixels');title('pixel coherence distribution over ROI flanker');

M(2,1)= ranksum(mean(mean(abs(a(roi_V1_2,4:9,20:30)).^2,2),3),mean(mean(abs(b(roi_V1_2,4:9,20:30)).^2,2),3));
[ht2 M(2,2)] = ttest2(mean(mean(abs(a(roi_V1_2,4:9,20:30)).^2,2),3),mean(mean(abs(b(roi_V1_2,4:9,20:30)).^2,2),3));

%% roi V2


[n x1]=hist(mean(mean(abs(a(roi_V2,4:9,20:30)).^2,2),3),0:0.001:1);

[m x2]=hist(mean(mean(abs(b(roi_V2,4:9,20:30)).^2,2),3),0:0.001:1);

p=max(max(find(m)),max(find(n)));

x=x1(1:p+3);

subplot(2,2,3);bar(x,[n(1:p+3);m(1:p+3)]',1.5,'group');xlabel('coherence');ylabel('number of pixels');title('pixel coherence distribution over ROI V2');

M(3,1) = ranksum(mean(mean(abs(a(roi_V2,4:9,20:30)).^2,2),3),mean(mean(abs(b(roi_V2,4:9,20:30)).^2,2),3));
[ht3 M(3,2)] = ttest2(mean(mean(abs(a(roi_V2,4:9,20:30)).^2,2),3),mean(mean(abs(b(roi_V2,4:9,20:30)).^2,2),3));

%% roi V4


[n x1]=hist(mean(mean(abs(a(roi_V4,4:9,20:30)).^2,2),3),0:0.001:1);

[m x2]=hist(mean(mean(abs(b(roi_V4,4:9,20:30)).^2,2),3),0:0.001:1);

p=max(max(find(m)),max(find(n)));

x=x1(1:p+3);

subplot(2,2,4);bar(x,[n(1:p+3);m(1:p+3)]',1.5,'group');xlabel('coherence');ylabel('number of pixels');title('pixel coherence distribution over ROI V4');

 M(4,1)= ranksum(mean(mean(abs(a(roi_V4,4:9,20:30)).^2,2),3),mean(mean(abs(b(roi_V4,4:9,20:30)).^2,2),3));
[ht4 M(4,2)] = ttest2(mean(mean(abs(a(roi_V4,4:9,20:30)).^2,2),3),mean(mean(abs(b(roi_V4,4:9,20:30)).^2,2),3));



%% BETA
%% roi V1

[n x1]=hist(mean(mean(abs(a(roi_V1,10:15,20:30)).^2,2),3),0:0.0001:1);

[m x2]=hist(mean(mean(abs(b(roi_V1,10:15,20:30)).^2,2),3),0:0.0001:1);

p=max(max(find(m)),max(find(n)));

x=x1(1:p+3);

figure;
subplot(2,2,1);bar(x,[n(1:p+3);m(1:p+3)]',1.5,'group');xlabel('coherence');ylabel('number of pixels');title('pixel coherence distribution over ROI target');

N(1,1) = ranksum(mean(mean(abs(a(roi_V1,10:15,20:30)).^2,2),3),mean(mean(abs(b(roi_V1,10:15,20:30)).^2,2),3));
[ht1 N(1,2)] = ttest2(mean(mean(abs(a(roi_V1,10:15,20:30)).^2,2),3),mean(mean(abs(b(roi_V1,10:15,20:30)).^2,2),3));

%% roi V1_2

[n x1]=hist(mean(mean(abs(a(roi_V1_2,10:15,20:30)).^2,2),3),0:0.0001:1);

[m x2]=hist(mean(mean(abs(b(roi_V1_2,10:15,20:30)).^2,2),3),0:0.0001:1);

p=max(max(find(m)),max(find(n)));

x=x1(1:p+3);

subplot(2,2,2);bar(x,[n(1:p+3);m(1:p+3)]',1.5,'group');xlabel('coherence');ylabel('number of pixels');title('pixel coherence distribution over ROI flanker');

N(2,1)= ranksum(mean(mean(abs(a(roi_V1_2,10:15,20:30)).^2,2),3),mean(mean(abs(b(roi_V1_2,10:15,20:30)).^2,2),3));
[ht2 N(2,2)] = ttest2(mean(mean(abs(a(roi_V1_2,10:15,20:30)).^2,2),3),mean(mean(abs(b(roi_V1_2,10:15,20:30)).^2,2),3));

%% roi V2


[n x1]=hist(mean(mean(abs(a(roi_V2,10:15,20:30)).^2,2),3),0:0.0001:1);

[m x2]=hist(mean(mean(abs(b(roi_V2,10:15,20:30)).^2,2),3),0:0.0001:1);

p=max(max(find(m)),max(find(n)));

x=x1(1:p+3);

subplot(2,2,3);bar(x,[n(1:p+3);m(1:p+3)]',1.5,'group');xlabel('coherence');ylabel('number of pixels');title('pixel coherence distribution over ROI V2');

N(3,1) = ranksum(mean(mean(abs(a(roi_V2,10:15,20:30)).^2,2),3),mean(mean(abs(b(roi_V2,10:15,20:30)).^2,2),3));
[ht3 N(3,2)] = ttest2(mean(mean(abs(a(roi_V2,10:15,20:30)).^2,2),3),mean(mean(abs(b(roi_V2,10:15,20:30)).^2,2),3));

%% roi V4


[n x1]=hist(mean(mean(abs(a(roi_V4,10:15,20:30)).^2,2),3),0:0.0001:1);

[m x2]=hist(mean(mean(abs(b(roi_V4,10:15,20:30)).^2,2),3),0:0.0001:1);

p=max(max(find(m)),max(find(n)));

x=x1(1:p+3);

subplot(2,2,4);bar(x,[n(1:p+3);m(1:p+3)]',1.5,'group');xlabel('coherence');ylabel('number of pixels');title('pixel coherence distribution over ROI V4');

N(4,1)= ranksum(mean(mean(abs(a(roi_V4,10:15,20:30)).^2,2),3),mean(mean(abs(b(roi_V4,10:15,20:30)).^2,2),3));
[ht4 N(4,2)] = ttest2(mean(mean(abs(a(roi_V4,10:15,20:30)).^2,2),3),mean(mean(abs(b(roi_V4,10:15,20:30)).^2,2),3));


