function plotData(src,event)
plot(event.TimeStamps, event.Data), hold on
set(gca,'xlim',[0 src.DurationInSeconds],'ylim',[-5 10])
end