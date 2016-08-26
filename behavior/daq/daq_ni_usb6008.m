function daq_ni_usb6008

ai=analoginput('nidaq','Dev1');
ao=analogoutput('nidaq','Dev1');
dio=digitalio('nidaq','Dev1');

disp('done create device')

testMode = 'analogIn'; % analogOut or analogIn or digital


switch lower(testMode)
    case 'analogin'
        %% Collect analog input
        % analog input channel
        addchannel(ai, 0);
        disp('done add channel')
        % get available properties
%         get(ai);
        % set some properties
        set(ai,'InputType','SingleEnded')
        % sample rate and recording duration
        ai.SampleRate = 10000;
        ai.SamplesPerTrigger = 50000; % can be Inf for continuous acquisition
        disp('Press any key to start')
        pause
        % start acquisition
        start(ai);
        % get data
        data = getdata(ai);
        plot(data)
        stop(ai), delete(ai)
        
    case 'analogout'
        %% Write analog output
        % analog output channel
        addchannel(ao, 1)
        % get available properties
        get(ao);
        % sample rate and recording duration
        samplingInterval = 0.005; % in s
        tMax = 100; n = tMax ./samplingInterval;
        a = [0 1]; a = repmat(a,1,n./2);
        startDelay = 0.5; % in s
        % have to send each sample separately (USB-6008 does not support
        % putdata / start combination)
        % use a timer object
        % create the timer
        t = timer('period',samplingInterval,'startDelay',startDelay,...
            'TasksToExecute',numel(a),'ExecutionMode','fixedRate');
        % callback functions
        t.StartFcn = @timerStartFcn;
        t.StopFcn = @timerStopFcn;
        t.TimerFcn = {@timerFcn,a,ao};
        % start timer
        start(t)
        
    case 'digital'
        %% Digital IO
        % digital io
        digital_out = addline(dio,0:7,'out');
        digital_in = addline(dio,8:11,'in');
        
        % output loop
        value = [0 0 0 0 0 0 0 0];
        for n = 1:50
            if value(1) == 0 % only change line 1
                value(1) = 1;
            else
                value(1) = 0;
            end
            % change digital out
            putvalue(digital_out,value)
            % get digital in
            io1 = getvalue(dio.Line(9));
            fprintf('\nDigital in is %1.0f\n',io1)
            pause(0.5)
        end
        % switch off
        value = [1 0 0 0 0 0 0 0];
        putvalue(digital_out,value)
        
end


function timerFcn(t,event,data,ao)
putsample(ao,data(t.TasksExecuted))

function timerStartFcn(t,event)
disp('Timer started')

function timerStopFcn(t,event)
disp('Timer stopped')
delete(t)

