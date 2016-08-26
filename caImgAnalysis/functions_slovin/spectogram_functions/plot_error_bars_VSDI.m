%% plot error bars for vsdi bands
cd /fat2/Ariel_Gilad/Matlab_analysis/2008_01_15/frequency_bands
color=['b';'r';'g';'c';'m';'y'];
for i=2:4:6 %condition count
       for k=1:6 %band count
          disp(['cond #',int2str(i),'band #',int2str(k)]);
          eval(['load cond',int2str(i),'_band_',int2str((1+5*(k-1))*2),'_',int2str((5+5*(k-1))*2)])
          eval(['ste=nanstd(cond',int2str(i),'_band_',int2str((1+5*(k-1))*2),'_',int2str((5+5*(k-1))*2),',0,3)./sqrt(size(cond',int2str(i),'_band_',int2str((1+5*(k-1))*2),'_',int2str((5+5*(k-1))*2),',3));']); 
          figure(10);h = gcf;set(h,'Name','frequency bands V1');
          subplot(3,3,k)
          eval(['errorbar(mean(mean(cond',int2str(i),'_band_',int2str((1+5*(k-1))*2),'_',int2str((5+5*(k-1))*2),'(:,roi_V1,:),3),2),mean(ste(:,roi_V1),2),color(i))']);xlim([0 223]);
          hold on;
          figure(11);h = gcf;set(h,'Name','frequency bands V2');
          subplot(3,3,k)
          eval(['errorbar(mean(mean(cond',int2str(i),'_band_',int2str((1+5*(k-1))*2),'_',int2str((5+5*(k-1))*2),'(:,roi_V2,:),3),2),mean(ste(:,roi_V2),2),color(i))']);xlim([0 223]);
          hold on;
          figure(12);h = gcf;set(h,'Name','frequency bands V4');
          subplot(3,3,k)
          eval(['errorbar(mean(mean(cond',int2str(i),'_band_',int2str((1+5*(k-1))*2),'_',int2str((5+5*(k-1))*2),'(:,roi_V4,:),3),2),mean(ste(:,roi_V4),2),color(i))']);xlim([0 223]);
          hold on;
          eval(['clear cond',int2str(i),'_band_',int2str((1+5*(k-1))*2),'_',int2str((5+5*(k-1))*2)]);
       end;
       for k=7:9 %band count
          disp(['band #',int2str(k)]);
          eval(['load cond',int2str(i),'_band_',int2str((1+5*(k-1))*2),'_',int2str((10+5*(k-1))*2)])
          eval(['ste=nanstd(cond',int2str(i),'_band_',int2str((1+5*(k-1))*2),'_',int2str((10+5*(k-1))*2),',0,3)./sqrt(size(cond',int2str(i),'_band_',int2str((1+5*(k-1))*2),'_',int2str((10+5*(k-1))*2),',3));']); 
          figure(10);h = gcf;set(h,'Name','frequency bands V1');
          subplot(3,3,k)
          eval(['errorbar(mean(mean(cond',int2str(i),'_band_',int2str((1+5*(k-1))*2),'_',int2str((10+5*(k-1))*2),'(:,roi_V1,:),3),2),mean(ste(:,roi_V1),2),color(i))']);xlim([0 223]);
          hold on;
          figure(11);h = gcf;set(h,'Name','frequency bands V2');
          subplot(3,3,k)
          eval(['errorbar(mean(mean(cond',int2str(i),'_band_',int2str((1+5*(k-1))*2),'_',int2str((10+5*(k-1))*2),'(:,roi_V2,:),3),2),mean(ste(:,roi_V2),2),color(i))']);xlim([0 223]);
          hold on;
          figure(12);h = gcf;set(h,'Name','frequency bands V4');
          subplot(3,3,k)
          eval(['errorbar(mean(mean(cond',int2str(i),'_band_',int2str((1+5*(k-1))*2),'_',int2str((10+5*(k-1))*2),'(:,roi_V4,:),3),2),mean(ste(:,roi_V4),2),color(i))']);xlim([0 223]);
          hold on;
          eval(['clear cond',int2str(i),'_band_',int2str((1+5*(k-1))*2),'_',int2str((10+5*(k-1))*2)]);
       end;
end;
figure(10);
%legend('co-linear','non co-linear');
%legend('target','flankers');
legend('cond1','cond2','cond3','cond4','cond5','cond6');
figure(11);
%legend('co-linear','non co-linear');
%legend('target','flankers');
legend('cond1','cond2','cond3','cond4','cond5','cond6');
figure(12);
%legend('co-linear','non co-linear');
%legend('target','flankers');
legend('cond1','cond2','cond3','cond4','cond5','cond6');
       
       
