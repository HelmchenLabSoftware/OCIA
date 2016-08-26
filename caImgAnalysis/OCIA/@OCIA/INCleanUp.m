function INCleanUp(this, ~, ~)
% INCleanUp - [no description]
%
%       INCleanUp(this)
%
% [No description]
%
% 2013-2016 - Copyleft and programmed by Balazs Laurenczy (blaurenczy_at_gmail.com)

% update GUI
this.in.expRunning = false;
set(this.GUI.handles.in.testStimBut, 'Value', 0, 'Enable', 'on', 'BackgroundColor', ones(3, 1) * 0.941);
set(this.GUI.handles.in.runExpBut, 'Value', 0, 'Enable', 'on', 'BackgroundColor', 'red');
diary('off')

% stop camera
if ~isempty(this.in.camH);
    stop(this.in.camH);
    flushdata(this.in.camH);
end;

% stop TDT if it exists
if ~isempty(this.in.RP);
    this.in.RP.Halt();
    delete(this.in.RP);
    this.in.RP = [];
end;

% stop DAQ session
if ~isempty(this.in.daq.sessHandle);
    if ~iscell(this.in.daq.sessHandle);
        this.in.daq.sessHandle = { this.in.daq.sessHandle };
    end;
    for iDaq = 1 : numel(this.in.daq.sessHandle);
        if ishandle(this.in.daq.sessHandle{1});
            this.in.daq.sessHandle{iDaq}.stop();
            this.in.daq.sessHandle{iDaq}.release();
        end;
        delete(this.in.daq.sessHandle{iDaq});
        this.in.daq.sessHandle{iDaq} = [];
    end;
    this.in.daq.sessHandle = [];
end;

% stop audioplayer
if ~isempty(this.in.audioplayer);
    this.in.audioplayer.stop();
    delete(this.in.audioplayer);
    this.in.audioplayer = [];
end;

% % HACK
% try
%     delete(this.GUI.in.freeHandROIHandle);
% catch err;
%     
% end;

end
