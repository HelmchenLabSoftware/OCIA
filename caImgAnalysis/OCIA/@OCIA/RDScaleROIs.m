function RDScaleROIs(this, horiScale, vertScale)
% RDScaleROIs - [no description]
%
%       RDScaleROIs(this, horiScale, vertScale)
%
% [No description]
%
% 2013-2016 - Copyleft and programmed by Balazs Laurenczy (blaurenczy_at_gmail.com)

selROIs = RDGetSelectedROIs(this);
o('#%s(): nROIs: %d, selectedROIs: %s', mfilename, this.rd.nROIs, num2str(selROIs), 4, this.verb);

% move all ROIs one by one
for iSel = 1 : numel(selROIs);
    iROI = selROIs(iSel);
    ROIPos = this.rd.ROIs{iROI, 1}.getPosition();
    allImSizes = cell2mat(cellfun(@(cont)iff(isempty(cont), [0 0 0], size(cont)), this.rd.avgImages, ...
        'UniformOutput', false));
    imDim = max(allImSizes);
    % for non-polygons
    if numel(ROIPos) == 4;
        ROICent = [imDim(1 : 2) / 2 0 0];
        ROIDiff = ROICent - ROIPos;
        newROIPos = ROIPos + ROIDiff .* [horiScale vertScale 0 0];
    else % for polygons
        ROICent = imDim(1 : 2) / 2;
        ROIDiff = ROICent - nanmean(ROIPos);
        newROIPos = ROIPos + repmat(ROIDiff .* [horiScale vertScale], size(ROIPos, 1), 1);
    end;
    this.rd.ROIs{iROI, 1}.setPosition(newROIPos);
    this.rd.ROIs{iROI, 6} = true; % mark as modified 

end;

% update the display
RDUpdateGUI(this);
    
end
