%Concat_WT_Segments
%load list
kk=0;
for k=1:5:length(list)%/5
    m=0;kk=kk+1;
    for n=k:k+4;
        m=m+1;
        load ([list{n}(1:end-7),list{n}(end-5: end-4),'_Whisker_Tracking'])
        WT_t{m}=MovieInfo.AvgWhiskerAngle;
    end
    AvgWhiskerAngle=[WT_t{1} WT_t{2} WT_t{3} WT_t{4} WT_t{5}];
    save (list{n}(1:end-10),'AvgWhiskerAngle')
    WT{kk}=AvgWhiskerAngle;
    WT_short{kk}=mean(AvgWhiskerAngle);
end
save (list{n}(1:end-13),'WT','WT_short')


% time=0:1/700.0035:39; %this assumes that the movie is exactly downsampled to 60fps!!!
% WT_time=[time(1:length(AvgWhiskerAngle))' AvgWhiskerAngle'];
% % Helioscan sampling is actually faster than 128ms/frame binning thing needs to be modified accordingly!!!
% time_2p=.1275067:.1275067:300*.1275067;
% quiet=2; whisk=1;
% 
% k=1; %counter for 300 frame whisk vector
% m=1; %start frame for binning
% for n=1:length(WT_time)
%     if WT_time(n,1)>time_2p(k) %wenn Zeit grösser als bin in 2p wird
%        %m is counter for last bin
%        frame{k}=WT_time(m:n-1,2);
%        WV(k)=mean(frame{k})
%        k=k+1;
%        m=n; 
%      end
%        
% end
