function OCIA_analysis_wideField_changeIFrame2(this)
% OCIA_analysis_wideField_changeIFrame2 - [no description]
%
%       OCIA_analysis_wideField_changeIFrame2(this)
%
% [No description]
%
% 2013-2016 - Copyleft and programmed by Balazs Laurenczy (blaurenczy_at_gmail.com)


% only change frames if data exist
if isempty(this.an.wf.storeData); return; end;

if isfield(this.GUI.handles.an.paramPanElems, 'iFrame');
    iFrame = round(get(this.GUI.handles.an.paramPanElems.iFrame, 'Value'));
    this.an.wf.iFrame = iFrame;
else
    iFrame = round(this.an.wf.iFrame);
end;

powerMaps = this.an.wf.storeData.powerMaps;
phaseMaps = this.an.wf.storeData.phaseMaps;
axeHandles = this.an.wf.storeData.axeHandles;

%% update images
refImgTitle = sprintf('iFrame = %d (%d->%d)', iFrame, this.an.wf.storeData.fRanges(iFrame, 1), this.an.wf.storeData.fRanges(iFrame, end));
set(get(axeHandles(1), 'Title'), 'String', refImgTitle);
% power map combined
childHands = get(axeHandles(2), 'Child'); childHands(~arrayfun(@(h)isa(h, 'matlab.graphics.primitive.Image'), childHands)) = [];
set(childHands(1), 'CData', squeeze(powerMaps{3}(:, :, iFrame)));
% power map 1
childHands = get(axeHandles(3), 'Child'); childHands(~arrayfun(@(h)isa(h, 'matlab.graphics.primitive.Image'), childHands)) = [];
set(childHands(1), 'CData', squeeze(powerMaps{1}(:, :, iFrame)));
% power map 2
childHands = get(axeHandles(4), 'Child'); childHands(~arrayfun(@(h)isa(h, 'matlab.graphics.primitive.Image'), childHands)) = [];
set(childHands(1), 'CData', squeeze(powerMaps{2}(:, :, iFrame)));
% phase map 1
childHands = get(axeHandles(5), 'Child'); childHands(~arrayfun(@(h)isa(h, 'matlab.graphics.primitive.Image'), childHands)) = [];
set(childHands(1), 'CData', squeeze(phaseMaps{1}(:, :, iFrame)));
% phase map 2
childHands = get(axeHandles(6), 'Child'); childHands(~arrayfun(@(h)isa(h, 'matlab.graphics.primitive.Image'), childHands)) = [];
set(childHands(1), 'CData', squeeze(phaseMaps{2}(:, :, iFrame)));
% corr phase map
childHands = get(axeHandles(7), 'Child'); childHands(~arrayfun(@(h)isa(h, 'matlab.graphics.primitive.Image'), childHands)) = [];
set(childHands(1), 'CData', squeeze(phaseMaps{3}(:, :, iFrame)));
% delay phase map
childHands = get(axeHandles(8), 'Child'); childHands(~arrayfun(@(h)isa(h, 'matlab.graphics.primitive.Image'), childHands)) = [];
set(childHands(1), 'CData', squeeze(phaseMaps{4}(:, :, iFrame)));

end
    
