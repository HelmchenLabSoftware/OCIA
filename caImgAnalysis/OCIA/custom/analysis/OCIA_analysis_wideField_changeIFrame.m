function OCIA_analysis_wideField_changeIFrame(this)
% OCIA_analysis_wideField_changeIFrame - [no description]
%
%       OCIA_analysis_wideField_changeIFrame(this)
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

allTrialsCell = this.an.wf.storeData.allTrialsCell;
allTrialsAverageCell = this.an.wf.storeData.allTrialsAverageCell;
axeHandles = this.an.wf.storeData.axeHandles;
tPS = this.an.wf.storeData.tPS;
nStims = numel(allTrialsCell);
noTrials = isempty(allTrialsCell{1});

title(axeHandles(2), sprintf('%+.2f sec (frame %d)', tPS(iFrame), iFrame));
set(this.an.wf.storeData.lineHandle, 'XData', repmat((iFrame / numel(tPS)) * size(allTrialsAverageCell{1}, 2), 1, 2));

% update images
for iStim = 1 : nStims;

    baseNum = 3 + (iStim - 1) * 2;
    if noTrials;
        baseNum = 2 + (iStim - 1);
    end;
    
    if ~noTrials;
        childHands = get(axeHandles(baseNum), 'Child');
        childHands(arrayfun(@(h)isa(h, 'matlab.graphics.primitive.Text'), childHands)) = [];
        set(childHands(1), 'CData', squeeze(allTrialsCell{iStim}(:, :, iFrame))');
    end;

    imgH = get(axeHandles(baseNum + 1), 'Child');
%     avgMapAllFrames = allTrialsAverageCell{iStim};
%     avgMapAllFrames(avgMapAllFrames < 0) = 0;
%     avgMapAllFrames = linScale(avgMapAllFrames);
%     avgMap = squeeze(avgMapAllFrames(:, :, iFrame))';
%     set(imgH(end), 'CData', avgMap);
    set(imgH(end), 'CData', allTrialsAverageCell{iStim}(:, :, iFrame));
    
    % ugly hard coding with eval and try catch :-)
    try
        cLimStr = get(this.GUI.handles.an.paramPanElems.powerMapCLim, 'String');
        eval(['set(axeHandles(baseNum + 1), ''CLim'',  ', cLimStr, ');']);
    catch
    end;

end;


end
    
