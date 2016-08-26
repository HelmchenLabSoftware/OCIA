


for i=1:17
    figure
    mimg(mfilt2(cond1n_dt_bl(:,28:68,i)-1,100,100,1,'lm'),100,100,0e-3,1.5e-3);colormap(mapgeog)
end

for i=1:17
    figure
    mimg(mfilt2(cond2n_dt_bl(:,28:68,i)-1,100,100,1,'lm'),100,100,0e-3,1.5e-3);colormap(mapgeog)
end

for i=1:16
    figure
    mimg(mfilt2(cond4n_dt_bl(:,28:68,i)-1,100,100,1,'lm'),100,100,.5e-3,1.5e-3);colormap(mapgeog)
end

for i=1:34
    figure
    mimg(mfilt2(mean(cond5n_dt_bl(:,49:51,i),2)-1,100,100,1,'lm'),100,100,0e-3,1.5e-3);colormap(mapgeog)
end

%cond1
tr_bad1=[12 17 18 23 26 28 31 32];
tr_good1=[1:11 13:16 19:22 24 25 27 29 30];

%cond2
tr_bad2=[1 2 3 5 6 9 15 16 21 23 24 26 27 28 29 30 32];
tr_good2=[4 7 8 10:14 17:20 22 25 31];


%cond4
tr_bad4=[6 15 25];
tr_good4=[1:5 7:14 16:24 26:28];


%cond5
tr_bad5=[6 7 15 22 27 28];
tr_good5=[1:5 8:14 16:21 23:26];





%% 1811d
%cond1
tr_bad1=[1 6 10];
tr_good1=[2:5 7:9 11:24];


%cond5
tr_bad5=[9 10 11 12 13 19 24 25];
tr_good5=[1:8 14:18 20:23];




%% 1203d
%cond1
tr_bad1=[1 2 5 7 9 10 11 27];
tr_good1=[3 4 6 8 12:26];


tr_bad5=[2 5 10 14 17 20 29 34];
tr_good5=[1 3 4 6:9 11:13 15 16 18 19 21:28 30:33];




%% 1711g smeg
%cond1

tr_good1=[3 4 5 6 15];

tr_good2=[2 3 4 9 14];

tr_good4=[1 2 4 7];








