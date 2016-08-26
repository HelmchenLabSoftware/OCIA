function [ROISet, runsValidity, refImage, nROIs, nRuns] = DWLoadROISetFromMat(this, loadPath)
% DWLoadROISetFromMat - [no description]
%
%       [ROISet, runsValidity, refImage, nROIs, nRuns] = DWLoadROISetFromMat(this, loadPath)
%
% [No description]
%
% 2013-2016 - Copyleft and programmed by Balazs Laurenczy (blaurenczy_at_gmail.com)

    % init variables
    ROISet = [];
    runsValidity = [];
    refImage = [];
    nROIs = 0;
    nRuns = 0;

    % load the ROISet
    ROISetMatStruct = load(loadPath);
    % extract variables
    try
        ROIs = ROISetMatStruct.ROIs;
        runsValidity = ROISetMatStruct.runsValidity;
        refImage = ROISetMatStruct.refImage;
        ROIMask = ROISetMatStruct.ROIMask;
    catch err;
        if strcmp(err.identifier, 'MATLAB:nonExistentField');
            showWarning(this, 'OCIA:DWLoadROISetFromMat:MissingField', ...
                sprintf('ROISet file at "%s" is incomplete: %s Aborting loading.', loadPath, err.message));
            return;
        end;
        rethrow(err);
    end;
    
    % get the number of ROIs and runs of this ROISet
    nROIs = size(ROIs, 1);
    nRuns = size(runsValidity, 1);

    % create the ROISet cell-array
    ROISet = cell(nROIs, 2);
    % copy the names
    ROISet(:, 1) = ROIs(:, 2);
    % create the masks
    ROISet(:, 2) = arrayfun(@(x) ROIMask == x, 1 : nROIs, 'UniformOutput', false);
    % if no neuropil ROI yet, add it to the ROISet
    if ~ismember('npil', lower(ROISet(:, 1)));
        [ROISet, nROIs] = addNPilROIToROISet(ROISet, this.an.an.nPilMaskBord);
    end;
    
end
