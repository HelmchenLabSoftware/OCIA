function RDMoveROIs(this, direction, step)
% RDMoveROIs - [no description]
%
%       RDMoveROIs(this, direction, step)
%
% [No description]
%
% 2013-2016 - Copyleft and programmed by Balazs Laurenczy (blaurenczy_at_gmail.com)

selROIs = RDGetSelectedROIs(this);
o('#RDMoveROIs(): nROIs: %d, selectedROIs: %s', this.rd.nROIs, num2str(selROIs), 4, this.verb);

% move all ROIs one by one
for iSel = 1 : numel(selROIs);
    iROI = selROIs(iSel);
    ROIPos = this.rd.ROIs{iROI, 1}.getPosition();
    if numel(ROIPos) == 4; % for non-polygons
        newROIPos = ROIPos + step * this.rd.moveROIVects.(direction);
    else % for polygons
        newROIPos = ROIPos + repmat(step * this.rd.moveROIVects.(direction)(1 : 2), size(ROIPos, 1), 1);
    end;
    this.rd.ROIs{iROI, 1}.setPosition(newROIPos);
    this.rd.ROIs{iROI, 6} = true; % mark as modified 

end;

% update the display
RDUpdateGUI(this);
    
end
