cond=[1 1 4 4];    %choose conditions
roi='dip';       %choose region of interest
pix1=8239;
pix2=8535;
time=112;          %choose time frames (starting from the begining)
pix=10000;

% condition 1


eval(['load coeff_',roi,'_cond',int2str(cond(1)),'_pix_',int2str(pix1)])
eval(['s=size(coeff_',roi,'_cond',int2str(cond(1)),'_pix_',int2str(pix1),',3);'])
disp(['cond ',int2str(cond(1))])
a=zeros(pix,time,s);
eval(['a(pixels,:,:)=coeff_',roi,'_cond',int2str(cond(1)),'_pix_',int2str(pix1),'(:,1:time,:);'])
a(isnan(a))=0;
eval(['clear coeff_',roi,'_cond',int2str(cond(1)),'_pix_',int2str(pix1)])

% condition 2

eval(['load coeff_',roi,'_cond',int2str(cond(2)),'_pix_',int2str(pix2)])
eval(['s=size(coeff_',roi,'_cond',int2str(cond(2)),'_pix_',int2str(pix2),',3);'])
disp(['cond ',int2str(cond(2))])
b=zeros(pix,time,s);
eval(['b(pixels,:,:)=coeff_',roi,'_cond',int2str(cond(2)),'_pix_',int2str(pix2),'(:,1:time,:);'])
b(isnan(b))=0;
eval(['clear coeff_',roi,'_cond',int2str(cond(2)),'_pix_',int2str(pix2)])


% condition 3

eval(['load coeff_',roi,'_cond',int2str(cond(3)),'_pix_',int2str(pix1)])
eval(['s=size(coeff_',roi,'_cond',int2str(cond(3)),'_pix_',int2str(pix1),',3);'])
disp(['cond ',int2str(cond(3))])
c=zeros(pix,time,s);
eval(['c(pixels,:,:)=coeff_',roi,'_cond',int2str(cond(3)),'_pix_',int2str(pix1),'(:,1:time,:);'])
c(isnan(c))=0;
eval(['clear coeff_',roi,'_cond',int2str(cond(3)),'_pix_',int2str(pix1)])


% condition 4

eval(['load coeff_',roi,'_cond',int2str(cond(4)),'_pix_',int2str(pix2)])
eval(['s=size(coeff_',roi,'_cond',int2str(cond(4)),'_pix_',int2str(pix2),',3);'])
disp(['cond ',int2str(cond(4))])
d=zeros(pix,time,s);
eval(['d(pixels,:,:)=coeff_',roi,'_cond',int2str(cond(4)),'_pix_',int2str(pix2),'(:,1:time,:);'])
d(isnan(d))=0;
eval(['clear coeff_',roi,'_cond',int2str(cond(4)),'_pix_',int2str(pix2)])

