function OCIA_analysis_wideField_drawCropRect(this, ~, ~)
% OCIA_analysis_wideField_drawCropRect - [no description]
%
%       OCIA_analysis_wideField_drawCropRect(this)
%
% [No description]
%
% 2013-2016 - Copyleft and programmed by Balazs Laurenczy (blaurenczy_at_gmail.com)

% remove previous rectangle
axeChilds = get(this.GUI.handles.an.axe, 'Children');
delete(axeChilds(strcmp(get(axeChilds, 'Tag'), 'imrect')));

% draw the ROI
hROI = imrect(this.GUI.handles.an.axe);
hROI.addNewPositionCallback(@(h)updateCropRect(this, h));

% get position and store it
pos = roundn(hROI.getPosition(), 1);
this.an.wf.cropRect = pos;

% update parameters
ANUpdatePlot(this, 'params');


end

function updateCropRect(this, newCropRect)
    this.an.wf.cropRect = roundn(newCropRect, 1);
    ANUpdatePlot(this, 'params');
end
    
