function OCIA_loadData_ROISetMatFile(this, iDWRow, loadType)
% OCIA_loadData_ROISetMatFile - [no description]
%
%       OCIA_loadData_ROISetMatFile(this, iDWRow, loadType)
%
% [No description]
%
% 2013-2016 - Copyleft and programmed by Balazs Laurenczy (blaurenczy_at_gmail.com)

loadTic = tic; % for performance timing purposes
o('#%s: iDWRow: %d, loadType: %s.', mfilename, iDWRow, loadType, 3, this.verb);

% get the load status
loadStatus = get(this, iDWRow, 'ROISets', 'loadStatus');

% only load the data if not already loaded
if ~strcmp(loadStatus, 'full');
    
    % load the ROISet
    [ROISet, runsValidity, refImage] = DWLoadROISetFromMat(this, get(this, iDWRow, 'path'));

    % store the data
    ROISetData = struct();
    ROISetData.ROISet = ROISet;
    ROISetData.runsValidity = runsValidity;
    ROISetData.refImage = refImage;
    setData(this, iDWRow, 'ROISets', 'data', ROISetData);

    % set the loading status
    isFullyLoaded = all([~isempty(ROISet), ~isempty(runsValidity), ~isempty(refImage)]);
    isPartiallyLoaded = any([~isempty(ROISet), ~isempty(runsValidity), ~isempty(refImage)]);
    setData(this, iDWRow, 'ROISets', 'loadStatus', iff(isFullyLoaded, 'full', iff(isPartiallyLoaded, 'partial', '')));
    
    % annotate the row using a delete tag to be able to remove these fields upon unloading
    set(this, iDWRow, 'ROISet', [this.GUI.dw.deleteTag DWGetRowID(this, iDWRow)]);
    set(this, iDWRow, 'dim', [this.GUI.dw.deleteTag sprintf('%02d ROI, %02d run', size(ROISet, 1), numel(runsValidity))]);
    
    % update the required columns
    DWUpdateColumnsDisplay(this, iDWRow, { 'ROISet', 'dim' }, false);
end;

o('  #%s: %s done (%3.1f sec).', mfilename, toc(loadTic), 4, this.verb);

end
