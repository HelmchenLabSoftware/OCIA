

cond=[6 6 2 6];    %choose conditions
roi='V1';          %choose region of interest
time=112;          %choose time frames (starting from the begining)

eval(['load coher_',roi,'_cond',int2str(cond(1))])
disp(['cond ',int2str(cond(1))])
a=zeros(10000,32,time);
eval(['a(pixels,:,:)=coher_',roi,'_cond',int2str(cond(1)),';'])
a(isnan(a))=0;
eval(['clear coher_',roi,'_cond',int2str(cond(1))])

eval(['load power_cond',int2str(cond(1))])
disp(['cond ',int2str(cond(1))])
c=zeros(32,time,10000);
eval(['c(:,:,pixels)=power_cond',int2str(cond(1)),';'])
c=shiftdim(c,2);
c(isnan(c))=0;
eval(['clear power_cond',int2str(cond(1))])


b=(abs(a).^2)./(c.*repmat(mean(c(roi_V1,:,:),1),[10000 1 1]));
clear a c
b(isnan(b))=0;

eval(['load coher_',roi,'_cond',int2str(cond(2))])  
disp(['cond ',int2str(cond(2))])
a=zeros(10000,32,time);
eval(['a(pixels,:,:)=coher_',roi,'_cond',int2str(cond(2)),';'])
a(isnan(a))=0;
eval(['clear coher_',roi,'_cond',int2str(cond(2))])


figure;plotspconds(cat(3,abs(squeeze(mean(a(:,4:9,:),2))).^2,squeeze(mean(b(:,4:9,:),2))),100,100,10);

figure;plot((10:10:1120),cat(2,squeeze(mean(abs(mean(a(roi_V2,4:9,:),2)).^2,1)),squeeze(mean(mean(b(roi_V2,4:9,:),2),1))))

figure;plot(cat(2,squeeze(mean(abs(mean(a(roi_V2,:,20:30),3)).^2,1)).',squeeze(mean(mean(b(roi_V2,:,20:30),3),1)).'))



