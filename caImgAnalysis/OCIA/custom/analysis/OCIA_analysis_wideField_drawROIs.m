function OCIA_analysis_wideField_drawROIs(this, ~, ~)
% OCIA_analysis_wideField_drawROIs - [no description]
%
%       OCIA_analysis_wideField_drawROIs(this)
%
% [No description]
%
% 2013-2016 - Copyleft and programmed by Balazs Laurenczy (blaurenczy_at_gmail.com)

% remove previous ROIs

if isfield(this.an.wf, 'axeHandles') && ~isempty(this.an.wf.axeHandles) && numel(this.an.wf.axeHandles) >= 3;    
    axeH = this.an.wf.axeHandles(3);
    try
        get(axeH);
    catch
        axeH = this.GUI.handles.an.axe;
    end;
    
else
    axeH = this.GUI.handles.an.axe;
    
end;

imH = get(axeH, 'Child');
imH = imH(end);
imDim = size(get(imH, 'CData'));

axeChilds = get(axeH, 'Children');
delete(axeChilds(strcmp(get(axeChilds, 'Tag'), 'imfreehand')));

% init masks
this.an.wf.ROIMasks = nan([imDim(1 : 2), 0]);

% draw the ROIs
ROIH = imfreehand(axeH);
while ~isempty(ROIH);
    this.an.wf.ROIMasks(:, :, end + 1) = ROIH.createMask();
    ROIH = imfreehand(axeH);    
end;

end
    
