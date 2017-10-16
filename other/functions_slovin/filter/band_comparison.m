cond=[4 3 6 5];    %choose conditions
roi='V1';       %choose region of interest
time=96;          %choose time frames (starting from the begining)
pix=10000;

% condition 1


eval(['load coeff_',roi,'_alpha',int2str(cond(1))])
disp(['cond ',int2str(cond(1))])
a=zeros(pix,time);
eval(['a(pixels,:)=coeff_',roi,'_alpha',int2str(cond(1)),'(:,1:time);'])
a(isnan(a))=0;
eval(['clear coeff_',roi,'_alpha',int2str(cond(1))])

% condition 2

eval(['load coeff_',roi,'_alpha',int2str(cond(2))])
disp(['cond ',int2str(cond(2))])
b=zeros(pix,time);
eval(['b(pixels,:)=coeff_',roi,'_alpha',int2str(cond(2)),'(:,1:time);'])
b(isnan(b))=0;
eval(['clear coeff_',roi,'_alpha',int2str(cond(2))])

% condition 3

eval(['load coeff_',roi,'_alpha',int2str(cond(3))])
disp(['cond ',int2str(cond(3))])
c=zeros(pix,time);
eval(['c(pixels,:)=coeff_',roi,'_alpha',int2str(cond(3)),'(:,1:time);'])
c(isnan(c))=0;
eval(['clear coeff_',roi,'_alpha',int2str(cond(3))])


% condition 4

eval(['load coeff_',roi,'_alpha',int2str(cond(4))])
disp(['cond ',int2str(cond(4))])
d=zeros(pix,time);
eval(['d(pixels,:)=coeff_',roi,'_alpha',int2str(cond(4)),'(:,1:time);'])
d(isnan(d))=0;
eval(['clear coeff_',roi,'_alpha',int2str(cond(4))])

