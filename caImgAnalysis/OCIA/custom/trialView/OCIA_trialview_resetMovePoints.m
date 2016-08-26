function this = OCIA_trialview_resetMovePoints(this, varargin)
% OCIA_trialview_resetMovePoints - Reset the movement labeling
%
%       OCIA_trialview_resetMovePoints(this)
%       OCIA_trialview_resetMovePoints(this, 'all')
%
% [No description]
%
% 2013-2016 - Copyleft and programmed by Balazs Laurenczy (blaurenczy_at_gmail.com)

% get params and handles
params = this.tv.params;
tvH = this.GUI.handles.tv;

    
% all trials should be cleared
if numel(varargin) == 1 && ischar(varargin{1}) && strcmp(varargin{1}, 'all');
    % reset move points and move vector for all trial
    for iTrial = 1 : numel(this.tv.data.movePoints);
        this.tv.data.movePoints{iTrial} = {};
        if ~isempty(this.tv.data.moveVects{iTrial});
            this.tv.data.moveVects{iTrial}(this.tv.data.moveVects{iTrial} > 0) = 0;
        end;
    end;
    showMessage(this, 'TrialView: movement vector reset for all trials.');
end;
        
% if there is a current trial
if ~isempty(this.tv.iTrial);
    
    % only current trial should be cleared
    if isempty(varargin);
        % reset move points and move vector for current trial
        this.tv.data.movePoints{this.tv.iTrial} = [];
        this.tv.data.moveVects{this.tv.iTrial}(this.tv.data.moveVects{this.tv.iTrial} > 0) = 0;
        
    end;

    % reset elements in GUI
    for iElem = 1 : numel(tvH.tc.moveVectElems);
        delete(tvH.tc.moveVectElems{iElem});
    end;
    tvH.tc.moveVectElems = {};
    
    showMessage(this, sprintf('TrialView: movement vector reset for trial %03d.', this.tv.iTrial));
    
% no trial
elseif isempty(varargin);
    showWarning(this, sprintf('OCIA:%s:NoCurrentTrial', mfilename()), ...
        'Could not reset move vector since there is no current trial number.');
    
end;

% restore handles
this.GUI.handles.tv = tvH;
% restore params and handles
this.tv.params = params;

end
