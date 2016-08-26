function this = OCIA_trialview_saveParams(this, ~, ~)
% OCIA_trialview_saveParams - Save parameters
%
%       OCIA_trialview_saveParams(this)
%
% [No description]
%
% 2013-2016 - Copyleft and programmed by Balazs Laurenczy (blaurenczy_at_gmail.com)

savePath = [this.tv.params.saveLoadPath, 'params.mat'];
params = this.tv.params; %#ok<*NASGU>
moveVects = this.tv.data.moveVects;
movePoints = this.tv.data.movePoints;
save(savePath, 'params', 'moveVects', 'movePoints');

showMessage(this, sprintf('TrialView: parameters saved under "%s".', savePath));

end
