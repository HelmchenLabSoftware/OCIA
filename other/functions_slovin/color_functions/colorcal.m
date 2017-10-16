cd /fat2/Data/luminance
fid = fopen('Red255_06Oct2010.txt','r');
c = textscan(fid,'%s');
count = 0;
for i = 0:6:420
    count = count+1;
    R(count,1) = str2num(c{1}{41+i});
end
R = sort(R,'ascend');
R([70,67,63,60,57,53,50,47,43,40,37,33,30,27,23,20,1:9]) = [];
figure;plot(linspace(0,255,length(R)),R,'r');hold on

fid = fopen('Green255_06Oct2010.txt','r');
c = textscan(fid,'%s');
count = 0;
for i = 0:6:420
    count = count+1;
    G(count,1) = str2num(c{1}{41+i});
end
G = sort(G(7:end),'ascend');
G([64,61,57,54,51,47,44,41,37,34,31,27,24,21,17,14,1:3]) = [];
plot(linspace(0,255,length(G)),G,'g');

fid = fopen('Blue255_06Oct2010.txt','r');
c = textscan(fid,'%s');
count = 0;
for i = 0:6:420
    count = count+1;
    B(count,1) = str2num(c{1}{41+i});
end
B = sort(B(4:end),'ascend');
B([66,63,59,56,53,49,46,43,39,36,33,29,26,23,19,16,13,1:6]) = [];
plot(linspace(0,255,length(B)),B,'b');
%%

m(1) = max(B);m(2) = max(G);m(3) = max(R);
x = 0:1:255;
y_temp = power(x,2.2);
d(1) = max(y_temp)/m(1); d(2) = max(y_temp)/m(2); d(3) = max(y_temp)/m(3);
y(:,1) = y_temp/d(1);y(:,2) = y_temp/d(2); y(:,3) = y_temp/d(3);
% y_norm = y/max(y)*100;
figure; plot(x,y);ylabel('Cd/m2');ylim([0 50]);xlim([0 255]);

% to find the numbers in gray scal
% y = 50+50; %percent
% yFix = y*max(y1)/100;
% x = round(nthroot((yFix*a)/255,2.2));


