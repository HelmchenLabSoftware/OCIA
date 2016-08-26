function OCIA_startFunction_trialView(this)
% OCIA_startFunction_trialView - [no description]
%
%       OCIA_startFunction_trialView(this)
%
% [No description]
%
% 2013-2016 - Copyleft and programmed by Balazs Laurenczy (blaurenczy_at_gmail.com)

% go to TrialView mode
OCIAChangeMode(this, 'TrialView');

% show welcome message
showMessage(this, sprintf('Welcome to the OCIA v%s ! :-)', this.main.version));

% check directory paths
paramFields = fieldnames(this.tv.params);
for iField = 1 : numel(paramFields);
    fieldName = paramFields{iField};
    % if current field is a directory path
    if ~isempty(regexp(fieldName, 'Path$', 'once')) && isempty(regexp(fieldName, '(File|Movie)Path$', 'once'));
        currPath = this.tv.params.(fieldName);            
        % make sure path exists
        if exist(currPath, 'dir') ~= 7
            showWarning(this, sprintf('OCIA:%s:DataPathNotFound', mfilename()), ...
                sprintf('Could not find/read path "%s" at "%s". Aborting.', fieldName, currPath));
            return;
        end;
    end;
end;

%% clear all elements from axes
for iElem = 1 : numel(this.GUI.handles.tv.tc.timeLineInfoElems);
    delete(this.GUI.handles.tv.tc.timeLineInfoElems{iElem});
end;
this.GUI.handles.tv.tc.timeLineInfoElems = {};

for iElem = 1 : numel(this.GUI.handles.tv.tc.ROITimeCourses);
    delete(this.GUI.handles.tv.tc.ROITimeCourses{iElem});
end;
this.GUI.handles.tv.tc.ROITimeCourses = {};

this.GUI.handles.tv.tc.moveVectElems = {};
for iElem = 1 : numel(this.GUI.handles.tv.tc.moveVectElems);
    delete(this.GUI.handles.tv.tc.moveVectElems{iElem});
end;
this.GUI.handles.tv.tc.moveVectElems = {};

%% clear whisk and lick traces
set(this.GUI.handles.tv.tc.lickTrace, 'Color', 'black', 'XData', [], 'YData', []);   
set(this.GUI.handles.tv.tc.whiskTrace, 'Color', 'black', 'XData', [], 'YData', []);   

%% reset variables
this.tv.iTrial = [];
this.tv.iFrame = 1;
this.tv.behavFrame = 1;
this.tv.trialZeroTimes = [];

%% try to load parameters
OCIA_trialview_loadParams(this);

%% process content of data path folder
OCIA_trialview_processBehaviorData(this);
OCIA_trialview_processWideFieldData(this);

            
end
