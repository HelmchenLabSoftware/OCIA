function procFrames = OCIA_onlineAnalysis_behavExp_getProcessedData(this, iDWRow, varargin)
% procFrames = OCIA_onlineAnalysis_behavExp_getProcessedData - [no description]
%
%       procFrames = OCIA_onlineAnalysis_behavExp_getProcessedData(this, iDWRow, varargin)
%
% [No description]
%
% 2013-2016 - Copyleft and programmed by Balazs Laurenczy (blaurenczy_at_gmail.com)

if isnan(iDWRow); procFrames = []; return; end;

% set processing parameters
set(this.GUI.handles.dw.procOptsList, 'Value', [1, 3, 5 : 6]);
% set(this.GUI.handles.dw.procOptsList, 'Value', [1, 3 : 6]);

% if specifig processing list has been requested, use it
if ~isempty(varargin) && isnumeric(varargin{1}) && ~isempty(varargin{1});
    set(this.GUI.handles.dw.procOptsList, 'Value', varargin{1});
end;
    
% process row
oldVerb = this.verb; this.verb = 0;
OCIA_dataWatcherProcess_processRows(this, [], iDWRow);
this.verb = oldVerb;

% extract the frames from the pre-processing channel
procData = getData(this, iDWRow, 'procImg', 'data');
% get the pre-processing channel
procChan = this.an.img.preProcChan;
% if not enough elements to get that channel, use the last available channel
if numel(procData) < procChan; procChan = numel(procData); end;
% extract the selected channel
procFrames = procData{procChan};
    
end