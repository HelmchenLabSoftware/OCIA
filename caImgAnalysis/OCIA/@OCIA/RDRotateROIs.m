function RDRotateROIs(this, thetaInDegrees)
% RDRotateROIs - [no description]
%
%       RDRotateROIs(this, thetaInDegrees)
%
% [No description]
%
% 2013-2016 - Copyleft and programmed by Balazs Laurenczy (blaurenczy_at_gmail.com)

selROIs = RDGetSelectedROIs(this);
o('#RDRotateROIs(): nROIs: %d, selectedROIs: %s', this.rd.nROIs, num2str(selROIs), 4, this.verb);

cent = round(size(this.GUI.rd.img(:, :, 1)) * 0.5);

thetaInRadians = thetaInDegrees * (pi / 180);
cosTheta = cos(thetaInRadians);
sinTheta = sin(thetaInRadians);

% move all ROIs one by one
for iSel = 1 : numel(selROIs);
    iROI = selROIs(iSel);
    ROIPos = this.rd.ROIs{iROI, 1}.getPosition();
    if numel(ROIPos) == 4; % non-polygons
        newXPos = cosTheta * (ROIPos(1) - cent(1)) - sinTheta * (ROIPos(2) - cent(2)) + cent(1);
        newYPos = sinTheta * (ROIPos(1) - cent(1)) + cosTheta * (ROIPos(2) - cent(2)) + cent(2);
        newROIPos = [newXPos newYPos ROIPos(3:4)];
    else % polygons
        newXPos = cosTheta * (ROIPos(:, 1) - cent(1)) - sinTheta * (ROIPos(:, 2) - cent(2)) + cent(1);
        newYPos = sinTheta * (ROIPos(:, 1) - cent(1)) + cosTheta * (ROIPos(:, 2) - cent(2)) + cent(2);
        newROIPos = [newXPos newYPos];
    end;
    this.rd.ROIs{iROI, 1}.setPosition(newROIPos);
    this.rd.ROIs{iROI, 6} = true; % mark as modified

end;

% update the display
RDUpdateGUI(this);
    
end
