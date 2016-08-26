function daq_continuousAcquire

ai=analoginput('nidaq','Dev1');

disp('done create device')

addchannel(ai, 0);
disp('done add channel')

% set some properties
set(ai,'InputType','SingleEnded')
set(ai, 'TriggerType', 'immediate');
set(ai, 'SampleRate', 10000)
set(ai, 'SamplesPerTrigger', 10000);
set(ai, 'TriggerRepeat', 20);
set(ai, 'TimerPeriod', 0.01);
% set(ai, 'TimerFcn', @daqtimerplot_HL);
ai.TimerFcn = {@daqtimerAnalysis};
set(ai, {'StartFcn', 'StopFcn', 'TriggerFcn'}, {'', '', ''});

disp('Press any key to start')
pause

% The analog input object is started.  Wait for up to 6 seconds for the
% acquisition to complete
start(ai)
wait(ai,30);

delete(ai);

% sample rate [Hz]
% updateSamples = 100;
% plotWindow = 20000; % samples to plot
% maxTime = 30; % in s
% 
% % open figure window
% dataFig = figure('Name','Continuous in','NumberTitle','off');
% tPlot = 1:plotWindow;
% plotData = nan(1,plotWindow);
% plotStart = 1;
% 
% disp('Press any key to start')
% pause
% % start acquisition
% start(ai);
% try
%     tStart = tic;
%     % get data
%     data = getdata(ai,updateSamples);
%     plotData(plotStart:plotStart+updateSamples-1) = data;
%     h = plot(tPlot,plotData); plotStart = plotStart + updateSamples;
%     set(gca,'ylim',[-0.5 5.5]) % expected range
%     set(h,'YDataSource','plotData')
%     while true
%         if toc(tStart) > maxTime
%             break
%         end
%         data = getdata(ai,updateSamples);
%         plotData(plotStart:plotStart+updateSamples-1) = data;
%         if (plotStart+updateSamples-1) < plotWindow
%             plotStart = plotStart + updateSamples;
%         else
%             plotStart = 1;
%         end
%         refreshdata(h,'caller')
%     end
%     disp('Execution finished. Closing device(s) ...')
%     stop(ai), delete(ai)
% catch
%     disp('Execution failed! Closing device(s) ...')
%     stop(ai), delete(ai)
%     rethrow(lasterror)
% end
