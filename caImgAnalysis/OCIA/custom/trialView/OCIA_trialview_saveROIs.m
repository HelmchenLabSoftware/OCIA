function this = OCIA_trialview_saveROIs(this, ~, ~)
% OCIA_trialview_saveROIs - Save parameters
%
%       OCIA_trialview_saveROIs(this)
%
% [No description]
%
% 2013-2016 - Copyleft and programmed by Balazs Laurenczy (blaurenczy_at_gmail.com)

savePath = [this.tv.params.saveLoadPath, 'ROIs.mat'];
ROIs = this.tv.ROI;
ROIs = rmfield(ROIs, 'ROIHandles'); %#ok<NASGU>
save(savePath, 'ROIs');

showMessage(this, sprintf('TrialView: ROIs saved under "%s".', savePath));

end
