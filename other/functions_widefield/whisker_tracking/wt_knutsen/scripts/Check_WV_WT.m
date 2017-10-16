function Check_WV_WT(WT, whiskVector_tina)
%run in data/animalID/Day folder after opening the whiskTracker and
%whiskVector
%will generate a plot with both to check, whether data looks sensible
c=figure; hold all
if length(WT)<17
    ma=length(WT);
    for n=1:ma
        subplot (ma,1,n)
        %subplot (14,1,n-12)
        hold on
        plot([1:300],(whiskVector_tina{n}*50)-80,'r')
        
        t=1:1/length(WT{n})*300:310;
         plot(t(1:length(WT{n})),gradient(WT{n})-60,'color', [1 0.7 0])
        plot(t(1:length(WT{n})),WT{n},'k')
        xlim ([0 300])
         
    end
    hgsave(c, 'CheckWV_WT1','all')
else
    ma=10;
    for n=1:ma
        subplot (ma,1,n)
        %subplot (14,1,n-12)
        hold on
        plot([1:300],(whiskVector_tina{n}*50)-80,'r')
       
        t=1:1/length(WT{n})*300:310;
        plot(t(1:length(WT{n})),gradient(WT{n})-60,'color', [1 0.7 0])
        plot(t(1:length(WT{n})),WT{n},'k')
          xlim ([0 300])
    end
    hgsave(c, 'CheckWV_WT1','all')
    close
    d=figure; hold all
    ma=length(WT)
    for n=11:ma
        subplot (16,1,n-10)
        %subplot (14,1,n-12)
        hold on
        plot([1:300],(whiskVector_tina{n}*50)-80,'r')
        t=1:1/length(WT{n})*300:310;
        plot(t(1:length(WT{n})),gradient(WT{n})-60,'color', [1 0.7 0])
        plot(t(1:length(WT{n})),WT{n},'k')
         xlim ([0 300])
    end
    hgsave(c, 'CheckWV_WT2','all')
end


%close all
    