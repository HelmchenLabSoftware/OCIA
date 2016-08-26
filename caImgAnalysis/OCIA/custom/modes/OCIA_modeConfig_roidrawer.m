function this = OCIA_modeConfig_roidrawer(this)
% add the ROI drawer mode to the OCIA

%% - properties: GUI: ROIDrawer
this.GUI.rd = struct();
% default size of the first empty left and right images
this.GUI.rd.defaultImDim = 200;
% the different tools for the ROIDRawer
this.GUI.rd.drawTools = cell2table({ ...
...     id              callback        tooltip
        'ellipse',      'imellipse',    'Ellipse';
        'freehand',     'imfreehand',   'Free-hand';
}, 'VariableNames', { 'id', 'callback', 'tooltip' });
this.GUI.rd.drawTools.Properties.RowNames = this.GUI.rd.drawTools.id;
% currently displayed image
this.GUI.rd.img = zeros(this.GUI.rd.defaultImDim, this.GUI.rd.defaultImDim, 3);
% currently applied image corrections
this.GUI.rd.applImCorr = { };
% current zoom level
this.GUI.rd.zoomLevel = 1;
% specifies which columns of the DataWatcher's table should be used for the row list display
this.GUI.rd.DWTableColumnsToUse = { 'rowNum', 'rowID', 'dim', 'rowType' };
% specifies whether to pre-load all images when launching the ROIDrawer mode
this.GUI.rd.preloadImages = false;

%% - properties: ROIDrawer
this.rd = struct();
% cell array containing the averaged frames for the rows loaded in the ROIDrawer
this.rd.avgImages = {};
% cell array containing the raw frames for the rows loaded in the ROIDrawer
this.rd.rawFrames = {};
% ROIMask mask defined by the drawn ROIs
this.rd.ROIMask = [];
% stores the selected rows that are currently used for 
this.rd.selectedTableRows = [];
% current number of ROIs
this.rd.nROIs = 0;
% cell-array containing the data for the drawn ROIS. Columns are: {handles of the drawn ROIs (imroi objects),
    % ROI IDs, ROI's position, ROI type (ellipse, freehand, etc.), text handles, modified flag.
this.rd.ROIs = {};
% ROISet comparator's temporary files
this.rd.rc = struct('ROISetIDs', [], 'ROISets', [], 'refImgs', [], 'ROINamesUnion', [], 'displayedRef', -1);
% vectors of displacement when moving all ROIs at the same time
this.rd.moveROIVects = struct('up', [0 -1 0 0], 'down', [0 1 0 0], 'left', [-1 0 0 0], 'right', [1 0 0 0]);
% number of pixels/units to move ROIs when adjusting the position of ROIs
this.rd.moveROIsStep = 2;
% angle in degrees to rotate ROIs when adjusting the position of ROIs
this.rd.rotateROIsStep = 1;
% ratio of pixels to scale relative to the ROI's position and the frame center
this.rd.scaleROIsStep = 1 / 50;
% possible image corrections
this.rd.imCorr = { 'imAdj', 'pseudFF', 'mask' };


end
