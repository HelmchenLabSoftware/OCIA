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

[n x1]=hist(mean(mean(a(roi_f3,4:9,24:30),2),3),0.35:0.005:1);

[m x2]=hist(mean(mean(b(roi_f3,4:9,24:30),2),3),0.35:0.005:1);

p=max(max(find(m)),max(find(n)));

x=x1(1:p+3);

subplot(2,2,1);bar(x,[n(1:p+3);m(1:p+3)]',1.5,'group');xlabel('Coherence');ylabel('Number of pixels');title('V1 target ROI');xlim([0.35 x(max(max(find(n)),max(find(m)))+1)]);

M(1,1) = mean(mean(mean(a(roi_V1,4:9,20:30),2),3));
M(1,2) = std(mean(mean(a(roi_V1,4:9,20:30),2),3));
M(1,3) = median(mean(mean(a(roi_V1,4:9,20:30),2),3));
M(1,4) = mean(mean(mean(b(roi_V1,4:9,20:30),2),3));
M(1,5) = std(mean(mean(b(roi_V1,4:9,20:30),2),3));
M(1,6) = median(mean(mean(b(roi_V1,4:9,20:30),2),3));
M(1,7) = ranksum(mean(mean(a(roi_V1,4:9,20:30),2),3),mean(mean(b(roi_V1,4:9,20:30),2),3));

%% roi V1_2

[n x1]=hist(mean(mean(a(roi_V1_2,4:9,20:30),2),3),0:0.0035:1);

[m x2]=hist(mean(mean(b(roi_V1_2,4:9,20:30),2),3),0:0.0035:1);

p=max(max(find(m)),max(find(n)));

x=x1(1:p+3);

subplot(2,2,2);bar(x,[n(1:p+3);m(1:p+3)]',1.5,'group');xlabel('Coherence');ylabel('Number of pixels');title('V1 flanker ROI');xlim([0 x(max(max(find(n)),max(find(m)))+1)]);

M(2,1) = mean(mean(mean(a(roi_V1_2,4:9,20:30),2),3));
M(2,2) = std(mean(mean(a(roi_V1_2,4:9,20:30),2),3));
M(2,3) = median(mean(mean(a(roi_V1_2,4:9,20:30),2),3));
M(2,4) = mean(mean(mean(b(roi_V1_2,4:9,20:30),2),3));
M(2,5) = std(mean(mean(b(roi_V1_2,4:9,20:30),2),3));
M(2,6) = median(mean(mean(b(roi_V1_2,4:9,20:30),2),3));
M(2,7) = ranksum(mean(mean(a(roi_V1_2,4:9,20:30),2),3),mean(mean(b(roi_V1_2,4:9,20:30),2),3));

%% roi V2

[n x1]=hist(mean(mean(a(roi_V2,4:9,20:30),2),3),0:0.0035:1);

[m x2]=hist(mean(mean(b(roi_V2,4:9,20:30),2),3),0:0.0035:1);

p=max(max(find(m)),max(find(n)));

x=x1(1:p+3);

subplot(2,2,3);bar(x,[n(1:p+3);m(1:p+3)]',1.5,'group');xlabel('Coherence');ylabel('Number of pixels');title('V2 ROI');xlim([0 x(max(max(find(n)),max(find(m)))+1)]);

M(3,1) = mean(mean(mean(a(roi_V2,4:9,20:30),2),3));
M(3,2) = std(mean(mean(a(roi_V2,4:9,20:30),2),3));
M(3,3) = median(mean(mean(a(roi_V2,4:9,20:30),2),3));
M(3,4) = mean(mean(mean(b(roi_V2,4:9,20:30),2),3));
M(3,5) = std(mean(mean(b(roi_V2,4:9,20:30),2),3));
M(3,6) = median(mean(mean(b(roi_V2,4:9,20:30),2),3));
M(3,7) = ranksum(mean(mean(a(roi_V2,4:9,20:30),2),3),mean(mean(b(roi_V2,4:9,20:30),2),3));

%% roi V4

[n x1]=hist(mean(mean(a(roi_V4,4:9,20:30),2),3),0:0.001:1);

[m x2]=hist(mean(mean(b(roi_V4,4:9,20:30),2),3),0:0.001:1);

p=max(max(find(m)),max(find(n)));

x=x1(1:p+3);

subplot(2,2,4);bar(x,[n(1:p+3);m(1:p+3)]',1.5,'group');xlabel('Coherence');ylabel('Number of pixels');title('V4 ROI');xlim([0 x(max(max(find(n)),max(find(m)))+1)]);

M(4,1) = mean(mean(mean(a(roi_V4,4:9,20:30),2),3));
M(4,2) = std(mean(mean(a(roi_V4,4:9,20:30),2),3));
M(4,3) = median(mean(mean(a(roi_V4,4:9,20:30),2),3));
M(4,4) = mean(mean(mean(b(roi_V4,4:9,20:30),2),3));
M(4,5) = std(mean(mean(b(roi_V4,4:9,20:30),2),3));
M(4,6) = median(mean(mean(b(roi_V4,4:9,20:30),2),3));
M(4,7) = ranksum(mean(mean(a(roi_V4,4:9,20:30),2),3),mean(mean(b(roi_V4,4:9,20:30),2),3));

%% BETA
%% roi V1

[n x1]=hist(mean(mean(a(roi_V1,10:15,20:30),2),3),0:0.0005:1);

[m x2]=hist(mean(mean(b(roi_V1,10:15,20:30),2),3),0:0.0005:1);

p=max(max(find(m)),max(find(n)));

x=x1(1:p+3);
figure;
subplot(2,2,1);bar(x,[n(1:p+3);m(1:p+3)]',1.5,'group');xlabel('Coherence');ylabel('Number of pixels');title('V1 target ROI');xlim([0 x(max(max(find(n)),max(find(m)))+1)]);

M(5,1) = mean(mean(mean(a(roi_V1,10:15,20:30),2),3));
M(5,2) = std(mean(mean(a(roi_V1,10:15,20:30),2),3));
M(5,3) = median(mean(mean(a(roi_V1,10:15,20:30),2),3));
M(5,4) = mean(mean(mean(b(roi_V1,10:15,20:30),2),3));
M(5,5) = std(mean(mean(b(roi_V1,10:15,20:30),2),3));
M(5,6) = median(mean(mean(b(roi_V1,10:15,20:30),2),3));
M(5,7) = ranksum(mean(mean(a(roi_V1,10:15,20:30),2),3),mean(mean(b(roi_V1,10:15,20:30),2),3));

%% roi V1_2

[n x1]=hist(mean(mean(a(roi_V1_2,10:15,20:30),2),3),0:0.00025:1);

[m x2]=hist(mean(mean(b(roi_V1_2,10:15,20:30),2),3),0:0.00025:1);

p=max(max(find(m)),max(find(n)));

x=x1(1:p+3);

subplot(2,2,2);bar(x,[n(1:p+3);m(1:p+3)]',1.5,'group');xlabel('Coherence');ylabel('Number of pixels');title('V1 flanker ROI');xlim([0 x(max(max(find(n)),max(find(m)))+1)]);

M(6,1) = mean(mean(mean(a(roi_V1_2,10:15,20:30),2),3));
M(6,2) = std(mean(mean(a(roi_V1_2,10:15,20:30),2),3));
M(6,3) = median(mean(mean(a(roi_V1_2,10:15,20:30),2),3));
M(6,4) = mean(mean(mean(b(roi_V1_2,10:15,20:30),2),3));
M(6,5) = std(mean(mean(b(roi_V1_2,10:15,20:30),2),3));
M(6,6) = median(mean(mean(b(roi_V1_2,10:15,20:30),2),3));
M(6,7) = ranksum(mean(mean(a(roi_V1_2,10:15,20:30),2),3),mean(mean(b(roi_V1_2,10:15,20:30),2),3));

%% roi V2

[n x1]=hist(mean(mean(a(roi_V2,10:15,20:30),2),3),0:0.00035:1);

[m x2]=hist(mean(mean(b(roi_V2,10:15,20:30),2),3),0:0.00035:1);

p=max(max(find(m)),max(find(n)));

x=x1(1:p+3);

subplot(2,2,3);bar(x,[n(1:p+3);m(1:p+3)]',1.5,'group');xlabel('Coherence');ylabel('Number of pixels');title('V2 ROI');xlim([0 x(max(max(find(n)),max(find(m)))+1)]);

M(7,1) = mean(mean(mean(a(roi_V2,10:15,20:30),2),3));
M(7,2) = std(mean(mean(a(roi_V2,10:15,20:30),2),3));
M(7,3) = median(mean(mean(a(roi_V2,10:15,20:30),2),3));
M(7,4) = mean(mean(mean(b(roi_V2,10:15,20:30),2),3));
M(7,5) = std(mean(mean(b(roi_V2,10:15,20:30),2),3));
M(7,6) = median(mean(mean(b(roi_V2,10:15,20:30),2),3));
M(7,7) = ranksum(mean(mean(a(roi_V2,10:15,20:30),2),3),mean(mean(b(roi_V2,10:15,20:30),2),3));

%% roi V4

[n x1]=hist(mean(mean(a(roi_V4,10:15,20:30),2),3),0:0.00025:1);

[m x2]=hist(mean(mean(b(roi_V4,10:15,20:30),2),3),0:0.00025:1);

p=max(max(find(m)),max(find(n)));

x=x1(1:p+3);

subplot(2,2,4);bar(x,[n(1:p+3);m(1:p+3)]',1.5,'group');xlabel('Coherence');ylabel('Number of pixels');title('V4 ROI');xlim([0 x(max(max(find(n)),max(find(m)))+1)]);

M(8,1) = mean(mean(mean(a(roi_V4,10:15,20:30),2),3));
M(8,2) = std(mean(mean(a(roi_V4,10:15,20:30),2),3));
M(8,3) = median(mean(mean(a(roi_V4,10:15,20:30),2),3));
M(8,4) = mean(mean(mean(b(roi_V4,10:15,20:30),2),3));
M(8,5) = std(mean(mean(b(roi_V4,10:15,20:30),2),3));
M(8,6) = median(mean(mean(b(roi_V4,10:15,20:30),2),3));
M(8,7) = ranksum(mean(mean(a(roi_V4,10:15,20:30),2),3),mean(mean(b(roi_V4,10:15,20:30),2),3));



%% 12-24 Hz
% roi V1

[n x1]=hist(mean(mean(abs(a(roi_V1,8:15,20:30)).^2,2),3),0:0.00001:1);

[m x2]=hist(mean(mean(abs(b(roi_V1,8:15,20:30)).^2,2),3),0:0.00001:1);

p=max(max(find(m)),max(find(n)));

x=x1(1:p+3);
figure;
subplot(2,2,1);bar(x,[n(1:p+3);m(1:p+3)]',1.5,'group');xlabel('coherence');ylabel('number of pixels');title('pixel coherence distribution over ROI target');

M(5,1) = mean(mean(mean(abs(a(roi_V1,8:15,20:30)).^2,2),3));
M(5,2) = std(mean(mean(abs(a(roi_V1,8:15,20:30)).^2,2),3));
M(5,3) = median(mean(mean(abs(a(roi_V1,8:15,20:30)).^2,2),3));
M(5,4) = mean(mean(mean(abs(b(roi_V1,8:15,20:30)).^2,2),3));
M(5,5) = std(mean(mean(abs(b(roi_V1,8:15,20:30)).^2,2),3));
M(5,6) = median(mean(mean(abs(b(roi_V1,8:15,20:30)).^2,2),3));
M(5,7) = ranksum(mean(mean(abs(a(roi_V1,8:15,20:30)).^2,2),3),mean(mean(abs(b(roi_V1,8:15,20:30)).^2,2),3));

% roi V1_2
% 
% [n x1]=hist(mean(mean(abs(a(roi_V1_2,8:15,20:30)).^2,2),3),0:0.0001:1);
% 
% [m x2]=hist(mean(mean(abs(b(roi_V1_2,8:15,20:30)).^2,2),3),0:0.0001:1);
% 
% p=max(max(find(m)),max(find(n)));
% 
% x=x1(1:p+3);
% 
% subplot(2,2,2);bar(x,[n(1:p+3);m(1:p+3)]',1.5,'group');xlabel('coherence');ylabel('number of pixels');title('pixel coherence distribution over ROI flanker');
% 
% M(6,1) = mean(mean(mean(abs(a(roi_V1_2,8:15,20:30)).^2,2),3));
% M(6,2) = std(mean(mean(abs(a(roi_V1_2,8:15,20:30)).^2,2),3));
% M(6,3) = median(mean(mean(abs(a(roi_V1_2,8:15,20:30)).^2,2),3));
% M(6,4) = mean(mean(mean(abs(b(roi_V1_2,8:15,20:30)).^2,2),3));
% M(6,5) = std(mean(mean(abs(b(roi_V1_2,8:15,20:30)).^2,2),3));
% M(6,6) = median(mean(mean(abs(b(roi_V1_2,8:15,20:30)).^2,2),3));
% M(6,7) = ranksum(mean(mean(abs(a(roi_V1_2,8:15,20:30)).^2,2),3),mean(mean(abs(b(roi_V1_2,8:15,20:30)).^2,2),3));

% roi V2

[n x1]=hist(mean(mean(abs(a(roi_V2,8:15,20:30)).^2,2),3),0:0.00001:1);

[m x2]=hist(mean(mean(abs(b(roi_V2,8:15,20:30)).^2,2),3),0:0.00001:1);

p=max(max(find(m)),max(find(n)));

x=x1(1:p+3);

subplot(2,2,3);bar(x,[n(1:p+3);m(1:p+3)]',1.5,'group');xlabel('coherence');ylabel('number of pixels');title('pixel coherence distribution over ROI V2');

M(7,1) = mean(mean(mean(abs(a(roi_V2,8:15,20:30)).^2,2),3));
M(7,2) = std(mean(mean(abs(a(roi_V2,8:15,20:30)).^2,2),3));
M(7,3) = median(mean(mean(abs(a(roi_V2,8:15,20:30)).^2,2),3));
M(7,4) = mean(mean(mean(abs(b(roi_V2,8:15,20:30)).^2,2),3));
M(7,5) = std(mean(mean(abs(b(roi_V2,8:15,20:30)).^2,2),3));
M(7,6) = median(mean(mean(abs(b(roi_V2,8:15,20:30)).^2,2),3));
M(7,7) = ranksum(mean(mean(abs(a(roi_V2,8:15,20:30)).^2,2),3),mean(mean(abs(b(roi_V2,8:15,20:30)).^2,2),3));

% roi V4

[n x1]=hist(mean(mean(abs(a(roi_V4,8:15,20:30)).^2,2),3),0:0.00001:1);

[m x2]=hist(mean(mean(abs(b(roi_V4,8:15,20:30)).^2,2),3),0:0.00001:1);

p=max(max(find(m)),max(find(n)));

x=x1(1:p+3);

subplot(2,2,4);bar(x,[n(1:p+3);m(1:p+3)]',1.5,'group');xlabel('coherence');ylabel('number of pixels');title('pixel coherence distribution over ROI V4');

M(8,1) = mean(mean(mean(abs(a(roi_V4,8:15,20:30)).^2,2),3));
M(8,2) = std(mean(mean(abs(a(roi_V4,8:15,20:30)).^2,2),3));
M(8,3) = median(mean(mean(abs(a(roi_V4,8:15,20:30)).^2,2),3));
M(8,4) = mean(mean(mean(abs(b(roi_V4,8:15,20:30)).^2,2),3));
M(8,5) = std(mean(mean(abs(b(roi_V4,8:15,20:30)).^2,2),3));
M(8,6) = median(mean(mean(abs(b(roi_V4,8:15,20:30)).^2,2),3));
M(8,7) = ranksum(mean(mean(abs(a(roi_V4,8:15,20:30)).^2,2),3),mean(mean(abs(b(roi_V4,8:15,20:30)).^2,2),3));



