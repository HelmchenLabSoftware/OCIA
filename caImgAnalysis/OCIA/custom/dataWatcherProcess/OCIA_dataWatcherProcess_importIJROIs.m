%% #OCIA_dataWatcherProcess_importIJROIs
function OCIA_dataWatcherProcess_importIJROIs(this, ~, ~)

importIJROIsTic = tic; % for performance timing purposes

showMessage(this, 'Extracting and importing imageJ ROISet ...');
DWWaitBar(this, 0);

% get the index(es) of the ImageJ ROISet rows
ijROISetRows = DWFilterTable(this, 'rowType = IJ ROIs');
fullFolderPath = get(this, 1, 'path', ijROISetRows);

% check what's in the watchfolder and exclude irrelephant files
files = dir(fullFolderPath); % check out the content of the folder
files(arrayfun(@(x)x.isdir, files)) = []; % only keep files
% get the patterns for this watch type
patternsCell = this.dw.watchTypes{'ijroiset', 'subFilePatterns'};
patternsTable = patternsCell{1}; % extract the table from the cell
ijROISetPattern = patternsTable{strcmp(patternsTable.id, 'ijroisetFile'), 'pattern'};
ijROISetPattern = ijROISetPattern{1}; % extract the string from the cell
% exclude everything that is not an ImageJ ROISet
files(arrayfun(@(x) isempty(regexp(x.name, ijROISetPattern, 'once')), files)) = [];

nFiles = numel(files); % count the number of remaining files
o('#%s(): found %d roiset zip file(s).', mfilename(), nFiles, 3, this.verb);

% loop trough all existing files
for iFile = 1 : nFiles;
    % get the file name    
    fileName = files(iFile).name;
    o('  #%s(): processing file "%s".', mfilename(), fileName, 5, this.verb);
    
    % extract the spot number
    regexpHit = regexp(fileName, ijROISetPattern, 'names');
    % if no hit were found
    if isempty(regexpHit);
        showWarning(this, 'OCIA:OCIA_dataWatcherProcess_importIJROIs:UnknownSpot', ...
            sprintf('Could not extract the spot from file name "%s" using expression "%s". Skipping it.', ...
            fileName, ijROISetPattern));
        continue;
    end;
    
    showMessage(this, sprintf('Decoding ImageJ ROISet %02d/%02d ...', iFile, nFiles));

    % extract the ImageJ ROISet
    ijROISet = ij_roiDecoder(sprintf('%s%s', fullFolderPath, fileName), this.an.img.defaultImDim);
    nROIs = size(ijROISet, 1); % count the number of ROIs
    
    % pre-allocate a cell-array to store the imported/converted ROIs
    ROIs = cell(nROIs, 4);
    % pre-allocate a matrix for the ROI mask
    ROIMask = zeros(size(ijROISet{1, 4}));
    
    % go trough each ROI and convert it to the required form
    for iROI = 1 : nROIs;
        % create the ROI type
        ROIs{iROI, 4} = sprintf('im%s', ijROISet{iROI, 2});
        if this.dw.IJImportKeepROIName; % keep ROI's name but clean it up
            ROIs{iROI, 2} = regexprep(ijROISet{iROI, 1}, '[^A-Za-z0-9]', '');
        else % give a new name
            ROIs{iROI, 2} = sprintf('%03d', iROI); % give ROI a name
        end;
        % store the coordinates
        ROIs{iROI, 3} = ijROISet{iROI, 3};
        % update the mask
        ROIMask(ijROISet{iROI, 4}) = iROI;
    end;
    
    %% save using the ROIDrawer's save function
    % check that the spot name can be recreated
    if ~isfield(regexpHit, 'spot') && isfield(regexpHit, 'depth');
        showWarning(this, 'OCIA:OCIA_dataWatcherProcess_importIJROIs:BadSpotHit', ...
            sprintf('Could not extract the spot from regexp hit with expression "%s". Skipping it.', ...
            ijROISetPattern));
        continue;        
    end;
    
    % get the DataWatcher indexes of the imaging data rows of that spot: create the spot filter
    spotID = sprintf('Spot%s_%s', regexpHit.spot, regexpHit.depth);
    imagingDataRows = DWFilterTable(this, sprintf('rowType = Imaging data AND spot = %s', spotID));
    nImagingRows = size(imagingDataRows, 1);
    % check whether we have some imaging rows for this spot
    if isempty(imagingDataRows);
        showWarning(this, 'OCIA:OCIA_dataWatcherProcess_importIJROIs:NoImagingData', ...
            sprintf('Could not find any imaging data for file "%s" (spotID: %s). Skipping it.', ...
            fileName, spotID));
        continue;
    end;
    
    % set parameters
    set(this.GUI.handles.rd.refROISet, 'Value', 0); % not ROISet mode
    set(this.GUI.handles.rd.saveOpts.ROIs, 'Value', 1);
    set(this.GUI.handles.rd.saveOpts.runsVal, 'Value', 1);
    set(this.GUI.handles.rd.saveOpts.refIm, 'Value', 1);
    this.rd.selectedTableRows = str2double(get(this, 'all', 'rowNum', imagingDataRows)); % mark selected rows
    % put all rows in ROIDrawer's table, first row selected
    set(this.GUI.handles.rd.tableList, 'String', cell(1, nImagingRows), 'Value', 1);
    
    % copy ROIs, mask, etc.
    this.rd.ROIs = ROIs;
    this.rd.nROIs = size(ROIs, 1);
    this.rd.ROIMask = ROIMask;
    
    % save everything
    RDSaveROIs(this);
    
    % show message and update wait bar
    showMessage(this, sprintf('Saving ImageJ ROISet %02/%02d to MAT-format done.', iFile, nFiles));
    DWWaitBar(this, iFile * 100 / nFiles);
    pause(0.5);
    
end;

% clear ROIDrawer mode and update wait bar
RDClearROIs(this);
set(this.GUI.handles.rd.tableList, 'String', {}, 'Value', []);
DWWaitBar(this, 100);

o('#%s(): importing ImageJ ROIs done (%3.1f sec).', mfilename(), toc(importIJROIsTic), 2, this.verb);

end
