function TVUpdateParams(this, ~, ~)
% TVUpdateParams - [no description]
%
%       TVUpdateParams(this, ~, ~)
%
% [No description]
%
% 2013-2016 - Copyleft and programmed by Balazs Laurenczy (blaurenczy_at_gmail.com)

OCIAUpdateVariablesFromParamPanel(this, 'tv');
showMessage(this, 'TrialView: parameters updated.');

OCIA_trialview_changeFrame(this);

end
