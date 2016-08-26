function this = OCIA_trialview_loadParams(this, ~, ~)
% OCIA_trialview_loadParams - Load parameters
%
%       OCIA_trialview_loadParams(this)
%
% [No description]
%
% 2013-2016 - Copyleft and programmed by Balazs Laurenczy (blaurenczy_at_gmail.com)

loadPath = [this.tv.params.saveLoadPath, 'params.mat'];
if ~exist(loadPath, 'file');
    showWarning(this, sprintf('OCIA:%s:FileNotFound', mfilename()), sprintf( ...
        'Could not load parameters file from "%s": file not found. Aborting.', loadPath));
    return;
end;

% load parameters
paramsMat = load(loadPath);
params = paramsMat.params;

% copy relevant fields from the parameters structure
paramFields = fieldnames(params);
for iField = 1 : numel(paramFields);
    fieldName = paramFields{iField};
    % do not load paths
    if ~isempty(regexp(fieldName, 'Path$', 'once')); continue; end;
    % do not load lists
    if ~isempty(regexp(fieldName, 'List$', 'once')); continue; end;
    % otherwise copy parameter
    this.tv.params.(fieldName) = params.(fieldName);
end;

% create config parameter panel
OCIACreateParamPanelControls(this, 'tv');
% enable the TrialView panel's GUI
OCIAToggleGUIEnableState(this, 'TrialView', 1);

showMessage(this, sprintf('TrialView: parameters loaded from "%s".', loadPath));

% clear previous move points and GUI
OCIA_trialview_resetMovePoints(this);
% load move vectors/points
this.tv.data.moveVects = paramsMat.moveVects;
this.tv.data.movePoints = paramsMat.movePoints;
% update GUI
OCIA_trialview_addMovePoint(this, 'updateGUI');

showMessage(this, sprintf('TrialView: move vectors loaded from "%s".', loadPath));

end
