% calculate time to half height

load myrois
%normalize to peak
load cond1n_dt_bl
cond1_maxn=(mean(cond1n_dt_bl,3)-1)./repmat(max(mean(cond1n_dt_bl(:,28:53,:),3)-1,[],2),[1 256]);
for i=1:10000
    tm1(i)=find(cond1_maxn(i,1:53)==1);
end
for i=1:10000
    hh1(i)=find(cond1_maxn(i,1:tm1(i))<0.1,1,'last');
end
clear cond1n_dt_bl
load cond2n_dt_bl
cond2_maxn=(mean(cond2n_dt_bl,3)-1)./repmat(max(mean(cond2n_dt_bl(:,28:53,:),3)-1,[],2),[1 256]);
for i=1:10000
    tm2(i)=find(cond2_maxn(i,1:53)==1);
end
for i=1:10000
    hh2(i)=find(cond2_maxn(i,1:tm2(i))<0.1,1,'last');
end
clear cond2n_dt_bl
load cond4n_dt_bl
cond4_maxn=(mean(cond4n_dt_bl,3)-1)./repmat(max(mean(cond4n_dt_bl(:,28:53,:),3)-1,[],2),[1 256]);
for i=1:10000
    tm4(i)=find(cond4_maxn(i,1:53)==1);
end
for i=1:10000
    hh4(i)=find(cond4_maxn(i,1:tm4(i))<0.1,1,'last');
end
clear cond4n_dt_bl
load cond5n_dt_bl
cond5_maxn=(mean(cond5n_dt_bl,3)-1)./repmat(max(mean(cond5n_dt_bl(:,28:53,:),3)-1,[],2),[1 256]);
for i=1:10000
    tm5(i)=find(cond5_maxn(i,1:53)==1);
end
for i=1:10000
    hh5(i)=find(cond5_maxn(i,1:tm5(i))<0.1,1,'last');
end
clear cond5n_dt_bl

%%
x=(10:10:1120)-280;
hh1111d1_time_cont_circ=[x(hh1(roi_contour2))]'+5;
hh1111d2_time_cont_circ=[x(hh2(roi_contour2))]'+5;
hh1111d4_time_non_circ=[x(hh4(roi_contour2))]'+5;
hh1111d5_time_non_circ=[x(hh5(roi_contour2))]'+5;
hh1111d1_time_cont_V2=[x(hh1(roi_V2))]'+5;
hh1111d2_time_cont_V2=[x(hh1(roi_V2))]'+5;
hh1111d4_time_non_V2=[x(hh4(roi_V2))]'+5;
hh1111d5_time_non_V2=[x(hh5(roi_V2))]'+5;
hh1111d1_time_cont_bg=[x(hh1(roi_maskin))]'+5;
hh1111d2_time_cont_bg=[x(hh2(roi_maskin))]'+5;
hh1111d4_time_non_bg=[x(hh4(roi_maskin))]'+5;
hh1111d5_time_non_bg=[x(hh5(roi_maskin))]'+5;

cont_time1111d1=(x(hh1));
cont_time1111d2=(x(hh2));
non_time1111d4=(x(hh4));
non_time1111d5=(x(hh5));



%%

load myrois
%normalize to peak
load cond1n_dt_bl
cond1_maxn=(mean(cond1n_dt_bl,3)-1)./repmat(max(mean(cond1n_dt_bl(:,28:53,:),3)-1,[],2),[1 256]);
for i=1:10000
    tm1(i)=find(cond1_maxn(i,1:53)==1);
end
for i=1:10000
    hh1(i)=find(cond1_maxn(i,1:tm1(i))<0.1,1,'last');
end
clear cond1n_dt_bl

load cond5n_dt_bl
cond5_maxn=(mean(cond5n_dt_bl,3)-1)./repmat(max(mean(cond5n_dt_bl(:,28:53,:),3)-1,[],2),[1 256]);
for i=1:10000
    tm5(i)=find(cond5_maxn(i,1:53)==1);
end
for i=1:10000
    hh5(i)=find(cond5_maxn(i,1:tm5(i))<0.1,1,'last');
end
clear cond5n_dt_bl

%%
x=(10:10:1120)-280;
hh1203f_time_cont_circ=[x(hh1(roi_contour))]'+5;
hh1203f_time_non_circ=[x(hh5(roi_contour))]'+5;
hh1203f_time_cont_V2=[x(hh1(roi_V2))]'+5;
hh1203f_time_non_V2=[x(hh5(roi_V2))]'+5;
hh1203f_time_cont_bg=[x(hh1(roi_bg_in))]'+5;
hh1203f_time_non_bg=[x(hh5(roi_bg_in))]'+5;
cont_time1203f=x(hh1)+5;
non_time1203f=x(hh5)+5;





cont_V2=[hh1111c1_time_cont_V2;hh1111c2_time_cont_V2;hh1111d1_time_cont_V2;hh1111d2_time_cont_V2; ...
    hh1811c_time_cont_V2; hh1811d_time_cont_V2; hh1811e_time_cont_V2; ...
    hh2511d_time_cont_V2; hh2511e_time_cont_V2; hh2511f_time_cont_V2; ...
    hh1203d_time_cont_V2; hh1203e_time_cont_V2; hh1203f_time_cont_V2];

non_V2=[hh1111c4_time_non_V2;hh1111c5_time_non_V2;hh1111d4_time_non_V2;hh1111d5_time_non_V2; ...
    hh1811c_time_non_V2; hh1811d_time_non_V2; hh1811e_time_non_V2; ...
    hh2511d_time_non_V2; hh2511e_time_non_V2; hh2511f_time_non_V2; ...
    hh1203d_time_non_V2; hh1203e_time_non_V2; hh1203f_time_non_V2];


[n1]=hist(cont_V2);

[n2]=hist(non_V2);

figure;bar([n1;n2]')


diff_V2=non_V2-cont_V2;
figure;hist(diff_V2,100)



cont_circ=[hh1111c1_time_cont_circ;hh1111c2_time_cont_circ;hh1111d1_time_cont_circ;hh1111d2_time_cont_circ; ...
    hh1811c_time_cont_circ; hh1811d_time_cont_circ; hh1811e_time_cont_circ; ...
    hh2511d_time_cont_circ; hh2511e_time_cont_circ; hh2511f_time_cont_circ; ...
    hh1203d_time_cont_circ; hh1203e_time_cont_circ; hh1203f_time_cont_circ];

non_circ=[hh1111c4_time_non_circ;hh1111c5_time_non_circ;hh1111d4_time_non_circ;hh1111d5_time_non_circ; ...
    hh1811c_time_non_circ; hh1811d_time_non_circ; hh1811e_time_non_circ; ...
    hh2511d_time_non_circ; hh2511e_time_non_circ; hh2511f_time_non_circ; ...
    hh1203d_time_non_circ; hh1203e_time_non_circ; hh1203f_time_non_circ];

[n1]=hist(cont_circ);

[n2]=hist(non_circ);

figure;bar([n1;n2]')


diff_circ=non_circ-cont_circ;
figure;hist(diff_circ,100)




cont_bg=[hh1111c1_time_cont_bg;hh1111c2_time_cont_bg;hh1111d1_time_cont_bg;hh1111d2_time_cont_bg; ...
    hh1811c_time_cont_bg; hh1811d_time_cont_bg; hh1811e_time_cont_bg; ...
    hh2511d_time_cont_bg; hh2511e_time_cont_bg; hh2511f_time_cont_bg; ...
    hh1203d_time_cont_bg; hh1203e_time_cont_bg; hh1203f_time_cont_bg];

non_bg=[hh1111c4_time_non_bg;hh1111c5_time_non_bg;hh1111d4_time_non_bg;hh1111d5_time_non_bg; ...
    hh1811c_time_non_bg; hh1811d_time_non_bg; hh1811e_time_non_bg; ...
    hh2511d_time_non_bg; hh2511e_time_non_bg; hh2511f_time_non_bg; ...
    hh1203d_time_non_bg; hh1203e_time_non_bg; hh1203f_time_non_bg];

[n1]=hist(cont_bg);

[n2]=hist(non_bg);

figure;bar([n1;n2]')


diff_bg=non_bg-cont_bg;
figure;hist(diff_bg,100)





cont_V2=[mean(hh1111c1_time_cont_V2);mean(hh1111c2_time_cont_V2);mean(hh1111d1_time_cont_V2);mean(hh1111d2_time_cont_V2); ...
    mean(hh1811c_time_cont_V2); mean(hh1811d_time_cont_V2); mean(hh1811e_time_cont_V2); ...
    mean(hh2511d_time_cont_V2); mean(hh2511e_time_cont_V2); mean(hh2511f_time_cont_V2); ...
    mean(hh1203d_time_cont_V2); mean(hh1203e_time_cont_V2); mean(hh1203f_time_cont_V2)];

non_V2=[mean(hh1111c4_time_non_V2);mean(hh1111c5_time_non_V2);mean(hh1111d4_time_non_V2);mean(hh1111d5_time_non_V2); ...
    mean(hh1811c_time_non_V2); mean(hh1811d_time_non_V2); mean(hh1811e_time_non_V2); ...
    mean(hh2511d_time_non_V2); mean(hh2511e_time_non_V2); mean(hh2511f_time_non_V2); ...
    mean(hh1203d_time_non_V2); mean(hh1203e_time_non_V2); mean(hh1203f_time_non_V2)];

cont_circ=[mean(hh1111c1_time_cont_circ);mean(hh1111c2_time_cont_circ);mean(hh1111d1_time_cont_circ);mean(hh1111d2_time_cont_circ); ...
    mean(hh1811c_time_cont_circ); mean(hh1811d_time_cont_circ); mean(hh1811e_time_cont_circ); ...
    mean(hh2511d_time_cont_circ); mean(hh2511e_time_cont_circ); mean(hh2511f_time_cont_circ); ...
    mean(hh1203d_time_cont_circ); mean(hh1203e_time_cont_circ); mean(hh1203f_time_cont_circ)];

non_circ=[mean(hh1111c4_time_non_circ);mean(hh1111c5_time_non_circ);mean(hh1111d4_time_non_circ);mean(hh1111d5_time_non_circ); ...
    mean(hh1811c_time_non_circ); mean(hh1811d_time_non_circ); mean(hh1811e_time_non_circ); ...
    mean(hh2511d_time_non_circ); mean(hh2511e_time_non_circ); mean(hh2511f_time_non_circ); ...
    mean(hh1203d_time_non_circ); mean(hh1203e_time_non_circ); mean(hh1203f_time_non_circ)];


cont_bg=[mean(hh1111c1_time_cont_bg);mean(hh1111c2_time_cont_bg);mean(hh1111d1_time_cont_bg);mean(hh1111d2_time_cont_bg); ...
    mean(hh1811c_time_cont_bg); mean(hh1811d_time_cont_bg); mean(hh1811e_time_cont_bg); ...
    mean(hh2511d_time_cont_bg); mean(hh2511e_time_cont_bg); mean(hh2511f_time_cont_bg); ...
    mean(hh1203d_time_cont_bg); mean(hh1203e_time_cont_bg); mean(hh1203f_time_cont_bg)];

non_bg=[mean(hh1111c4_time_non_bg);mean(hh1111c5_time_non_bg);mean(hh1111d4_time_non_bg);mean(hh1111d5_time_non_bg); ...
    mean(hh1811c_time_non_bg); mean(hh1811d_time_non_bg); mean(hh1811e_time_non_bg); ...
    mean(hh2511d_time_non_bg); mean(hh2511e_time_non_bg); mean(hh2511f_time_non_bg); ...
    mean(hh1203d_time_non_bg); mean(hh1203e_time_non_bg); mean(hh1203f_time_non_bg)];



figure;bar([mean(cont_circ) mean(non_circ) mean(cont_bg) mean(non_bg) mean(cont_V2) mean(non_V2)])
hold on
errorbar([mean(cont_circ) mean(non_circ) mean(cont_bg) mean(non_bg) mean(cont_V2) mean(non_V2)],[std(cont_circ) std(non_circ) std(cont_bg) std(non_bg) std(cont_V2) std(non_V2)]/sqrt(13))
ttest2(cont_circ,non_circ)
ranksum(cont_bg,non_bg)
ranksum(cont_V2,non_V2)

ranksum(cont_circ,cont_bg)
ranksum(cont_circ,cont_V2)
ranksum(cont_V2,cont_bg)

ranksum(non_circ,non_bg)
ranksum(non_circ,non_V2)
ranksum(non_V2,non_bg)



figure;bar([mean(non_circ-cont_circ) mean(non_bg-cont_bg) mean(non_V2-cont_V2)])
signtest(non_circ-cont_circ)
signtest(non_bg-cont_bg)
signtest(non_V2-cont_V2)



y=mfilt2((((non_time1111d4+non_time1111d5)/2)-((cont_time1111d1+cont_time1111d2))/2)',100,100,1.5,'lm');
y(pixels_to_remove)=100;
figure;mimg(y,100,100,-20,20);colormap(mapgeog)


y=mfilt2((non_time1203f-cont_time1203f)',100,100,1.5,'lm');
y(pixels_to_remove)=100;
figure;mimg(y,100,100,-10,35);colormap(mapgeog)

figure;hist([hh1203f_time_cont_V2 hh1203f_time_non_V2]);
figure;hist([hh1203f_time_cont_circ hh1203f_time_non_circ]);
figure;hist([hh1203f_time_cont_bg hh1203f_time_non_bg]);

ranksum(hh1203f_time_cont_V2,hh1203f_time_non_V2)
ranksum(hh1203f_time_cont_circ,hh1203f_time_non_circ)
ranksum(hh1203f_time_cont_bg,hh1203f_time_non_bg)








