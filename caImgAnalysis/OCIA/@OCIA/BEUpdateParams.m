function BEUpdateParams(this, ~, ~)
% BEUpdateParams - [no description]
%
%       BEUpdateParams(this, ~, ~)
%
% [No description]
%
% 2013-2016 - Copyleft and programmed by Balazs Laurenczy (blaurenczy_at_gmail.com)

OCIAUpdateVariablesFromParamPanel(this, 'be');

set(this.GUI.handles.be.loadConf, 'BackgroundColor', 'yellow');
pause(0.01);

showMessage(this, 'Behavior: parameters updated.');

end
