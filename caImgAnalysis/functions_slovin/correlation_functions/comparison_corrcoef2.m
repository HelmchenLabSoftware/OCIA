cond=[1 2 4 5];    %choose conditions
roi='maskin';       %choose region of interest
time=112;          %choose time frames (starting from the begining)
pix=10000;

% condition 1

eval(['load coeff_',roi,'_cond',int2str(cond(1))])
disp(['cond ',int2str(cond(1)),' roi ',roi])
eval(['s=size(coeff_',roi,'_cond',int2str(cond(1)),',3);'])
a=zeros(pix,time,s);
eval(['a(pixels,:,:)=coeff_',roi,'_cond',int2str(cond(1)),'(:,1:time,:);'])
a(isnan(a))=0;
eval(['clear coeff_',roi,'_cond',int2str(cond(1))])

% condition 2


eval(['load coeff_',roi,'_cond',int2str(cond(2))])
disp(['cond ',int2str(cond(2)),' roi ',roi])
eval(['s=size(coeff_',roi,'_cond',int2str(cond(2)),',3);'])
b=zeros(pix,time,s);
eval(['b(pixels,:,:)=coeff_',roi,'_cond',int2str(cond(2)),'(:,1:time,:);'])
b(isnan(b))=0;
eval(['clear coeff_',roi,'_cond',int2str(cond(2))])

% condition 3


eval(['load coeff_',roi,'_cond',int2str(cond(3))])
disp(['cond ',int2str(cond(3)),' roi ',roi])
eval(['s=size(coeff_',roi,'_cond',int2str(cond(3)),',3);'])
c=zeros(pix,time,s);
eval(['c(pixels,:,:)=coeff_',roi,'_cond',int2str(cond(3)),'(:,1:time,:);'])
c(isnan(c))=0;
eval(['clear coeff_',roi,'_cond',int2str(cond(3))])

% condition 4


eval(['load coeff_',roi,'_cond',int2str(cond(4))])
disp(['cond ',int2str(cond(4)),' roi ',roi])
eval(['s=size(coeff_',roi,'_cond',int2str(cond(4)),',3);'])
d=zeros(pix,time,s);
eval(['d(pixels,:,:)=coeff_',roi,'_cond',int2str(cond(4)),'(:,1:time,:);'])
d(isnan(d))=0;
eval(['clear coeff_',roi,'_cond',int2str(cond(4))])
