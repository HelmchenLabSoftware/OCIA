function simple_sounds(data,Fs,dur)
% data ... between -1 and 1
% Fs ... sampling rate
% dur ... sound duration in s

ao = analogoutput('winsound', 0);
addchannel(ao, [1]);
set(ao, 'SampleRate', Fs);
putdata(ao, data);

startindex = 1;
increment = 500;
start_time = clock;
start(ao);

while true
    if isrunning(ao)
        if etime(clock,start_time) >= dur
            stop(ao);
            break
        end
    else
        putdata(ao, data);
        start(ao);
    end
end

% stop(ao);



% while isrunning(ao)
%     while (ao.SamplesOutput < startindex + increment -1), end
%     try
%         x = ao.SamplesOutput;
%         plot(data(x:x+increment-1));
%         set(gca, 'YLim', [-0.8 0.8], 'XLim',[1 increment])
%         drawnow;
%         startindex =  startindex+increment;
%     end
% end