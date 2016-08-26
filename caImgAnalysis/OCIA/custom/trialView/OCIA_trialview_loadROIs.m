function this = OCIA_trialview_loadROIs(this, ~, ~)
% OCIA_trialview_loadROIs - Load ROIs
%
%       OCIA_trialview_loadROIs(this)
%
% [No description]
%
% 2013-2016 - Copyleft and programmed by Balazs Laurenczy (blaurenczy_at_gmail.com)

loadPath = [this.tv.params.saveLoadPath, 'ROIs.mat'];
% no ROIs
if ~exist(loadPath, 'file');
    % try a different path
    loadPath = [this.tv.params.saveLoadPath, 'ROIs_registered.mat'];
    % no ROIs
    if ~exist(loadPath, 'file');
        showWarning(this, sprintf('OCIA:%s:FileNotFound', mfilename()), sprintf( ...
            'Could not load ROIs file from "%s": file not found. Aborting.', loadPath));
        return;
    end;
    
end;


% remove previous ROIs
nROIs = size(this.tv.ROI.ROIIDs, 2);
ROIIDs = this.tv.ROI.ROIIDs;
for iROI = 1 : nROIs;
    OCIA_trialview_deleteROI(this, ROIIDs(iROI));
end;

% load ROIs
ROIsMat = load(loadPath);
ROIs = ROIsMat.ROIs;

% cell array
if iscell(ROIs);
    nROIs = size(ROIs, 1);
    % create ROIs one by one
    for iROI = 1 : nROIs;
        ROIID = rand() * 10000000;
        while any(ROIID == this.tv.ROI.ROIIDs);
            ROIID = rand() * 10000000;
        end;
        if size(ROIs, 2) >= 4; axeH = ROIs{iROI, 4}; else axeH = 'wf'; end;
        OCIA_trialview_drawROI(this, { ROIID, ROIs{iROI, 1}, ROIs{iROI, 3}, axeH });
    end;
    
    
% structure array
else
    nROIs = numel(ROIs.ROIMasks);
    % create ROIs one by one
    for iROI = 1 : nROIs;
        if isfield(ROIs, 'axeH'); axeH = ROIs.axeH{iROI}; else axeH = 'wf'; end;
        OCIA_trialview_drawROI(this, { ROIs.ROIIDs(iROI), ROIs.ROINames{iROI}, ROIs.ROIMasks{iROI}, axeH });
    end;
end;

showMessage(this, sprintf('TrialView: ROIs loaded from "%s".', loadPath));

end
