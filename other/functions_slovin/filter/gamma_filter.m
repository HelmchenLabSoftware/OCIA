%% gamma filter

load filters

win=4;

for i=[4 3 6]
    disp(i)
    eval(['load cond',int2str(i),'n_dt_bl'])
    eval(['a=size(cond',int2str(i),'n_dt_bl,3);'])    
    eval(['gamma',int2str(i),'n_dt_bl=filter(gamma,cond',int2str(i),'n_dt_bl(:,2:end,:)-1,2);'])
    eval(['clear cond',int2str(i),'n_dt_bl'])
    %eval(['gamma',int2str(i),'n_dt_bl=abs(gamma',int2str(i),'n_dt_bl);'])
%     eval(['gammaRMS',int2str(i),'n_dt_bl=zeros(10000,255-win,a);'])
%     for j=1:255-win
%         eval(['gammaRMS',int2str(i),'n_dt_bl(:,j,:)=squeeze(sqrt(mean(gamma',int2str(i),'n_dt_bl(:,j:j+win-1,:).^2,2)));'])
%     end
     eval(['save gamma',int2str(i),'n_dt_bl gamma',int2str(i),'n_dt_bl'])
%     eval(['clear gamma',int2str(i),'n_dt_bl'])
%     eval(['clear gammaRMS',int2str(i),'n_dt_bl'])
end
    
    