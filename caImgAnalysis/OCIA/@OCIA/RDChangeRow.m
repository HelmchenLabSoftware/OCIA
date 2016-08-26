function RDChangeRow(this, h, ~)
% RDChangeRow - [no description]
%
%       RDChangeRow(this, h, ~)
%
% [No description]
%
% 2013-2016 - Copyleft and programmed by Balazs Laurenczy (blaurenczy_at_gmail.com)

% if change was requested by a number
if h ~= this.GUI.handles.rd.tableList && h ~= this.GUI.handles.rd.selFrameRange && h ~= this.GUI.handles.rd.dimReducFcn;
    selRows = h;

% if change was requested by a callback
else
    selRows = get(this.GUI.handles.rd.tableList, 'Value');
end;

if h == this.GUI.handles.rd.dimReducFcn;
    this.rd.avgImages = cell(numel(this.rd.avgImages), 1);
end;

% get the selected rows
nSelRows = numel(selRows);
nValues = size(get(this.GUI.handles.rd.tableList, 'String'), 1);
selRows(selRows > nValues) = nValues; % set boundaries for iRow so that it does not exceed the range
selRows(selRows < 1) = 1; % set boundaries for iRow so that it does not exceed the range
selRows = unique(selRows); % make sure there are no duplicated values
set(this.GUI.handles.rd.tableList, 'Value', selRows);

o('#%s(): h: %d, selRows: %s.', mfilename(), h, num2str(selRows), 3, this.verb);

% set the right number of steps for the ROI comparator
if nSelRows > 1; % if more than one row loaded
    set(this.GUI.handles.rd.refROISetASetter, 'Value', 1, 'String', num2cell(selRows));
    set(this.GUI.handles.rd.refROISetBSetter, 'Value', 1, 'String', num2cell(selRows));
else % if only one row is loaded
    set(this.GUI.handles.rd.refROISetASetter, 'Value', 1, 'String', num2cell(1));
    set(this.GUI.handles.rd.refROISetBSetter, 'Value', 1, 'String', num2cell(1));
end;

% clear the ROIComparator annotations from the image
try
    childHands = get(this.GUI.handles.rd.axe, 'Children');
    childTags = get(childHands, 'Tag');
    delete(childHands(strcmp('ROICompareLine', childTags)));
    delete(childHands(strcmp('ROICompareText', childTags)));
    delete(childHands(strcmp('ROICompareScatter', childTags)));
catch e; %#ok<NASGU>
end;

% disable the frame setter
set(this.GUI.handles.rd.frameSetter, 'Enable', 'off');

% if the data for this image was not loaded yet
for iSelRow = 1 : numel(selRows);

    % get the information about the current row
    iRow = selRows(iSelRow);
    iDWRow = this.rd.selectedTableRows(iRow); % get the DataWatcher's row number

    % load the data for this row, either all the frames or just the first "couple" as preview
    DWLoadRow(this, iDWRow, iff(get(this.GUI.handles.rd.useAllFrames, 'Value'), 'full', 'partial'));

    % get the data of the row, depending on what type of row it is
    switch get(this, iDWRow, 'rowType');        
        % ROISets: get the reference image
        case 'ROISet';
            ROISetData = getData(this, iDWRow, 'ROISets', 'data');
            if iscell(ROISetData.refImage);
                data = ROISetData.refImage;
            else
                data = { ROISetData.refImage };
            end;
            imgDim = size(data{1});           
        % imaging data: get the processed images
        case 'Imaging data';
            data = getData(this, iDWRow, 'procImg', 'data');
            imgDim = size(data{this.an.img.preProcChan});
        % unknown row type
        otherwise;
            showWarning(this, 'OCIA:RDChangeRow:UnknownRowType', ...
                sprintf('Unknown row type (%s), cannot load the data.', get(this, iDWRow, 'rowType')));
            continue;
    end;
    
    % make sure the 3rd dimension describes the number of frames   
    if numel(imgDim) < 3; imgDim(3) = 1; end;     

    % create the average if not available or if number of frames has changed
    if isempty(this.rd.avgImages{iRow}) || (imgDim(3) ~= size(this.rd.rawFrames{iRow}, 3) ...
            && (isempty(this.rd.rawFrames{iRow}) && ~get(this.GUI.handles.rd.showAvg, 'Value'))) ...
            || h == this.GUI.handles.rd.selFrameRange || h == this.GUI.handles.rd.dimReducFcn;  
        
        % get the data to use for the averaging
        dataForAverage = data; 
        % get the frame range for the averaging
        frameRangeStr = regexprep(get(this.GUI.handles.rd.selFrameRange, 'String'), '-', ':');
        % if a specific range of frames should be used, restrict the data to that range
        if ~isempty(frameRangeStr);
            % evaluate the frame range
            frameRange = eval(frameRangeStr);
            % for each channel, restrict the range
            for iChan = 1 : numel(dataForAverage);
                frameRangeChan = frameRange; % get the range
                % make sure the range does not exceed the limits
                frameRangeChan(frameRangeChan < 1 | frameRangeChan > size(dataForAverage{iChan}, 3)) = [];
                % restrict the data to the specified frames
                dataForAverage{iChan} = dataForAverage{iChan}(:, :, frameRangeChan);
            end;
        end;

        % create the averaged RGB image with the data
        dimReducFunctions = get(this.GUI.handles.rd.dimReducFcn, 'String');
        dimReducFcn = dimReducFunctions{get(this.GUI.handles.rd.dimReducFcn, 'Value')};
        RGBImAvg = cell2RGB(dataForAverage, this.an.img.colVect, true, dimReducFcn);
        % store the average image image
        this.rd.avgImages{iRow} = RGBImAvg;
        % store the average image image
        this.rd.avgImages{iRow} = RGBImAvg;
    end;

    % only create/update the images if frames should be showed (not average) and if number of frames has changed
    %   or if filtering was enabled/disabled
    if ~get(this.GUI.handles.rd.showAvg, 'Value') && (imgDim(3) ~= size(this.rd.rawFrames{iRow}, 3) ...
            || (ishandle(h) && this.GUI.handles.rd.filtFrames));

        % if required, apply a filter
        if get(this.GUI.handles.rd.filtFrames, 'Value');
            showMessage(this, 'Filtering frames ...', 'yellow');
            % filter each channel ony by one
            parfor iChan = 1 : size(data, 1);
                dataChan = data{iChan};
                dataChanFilt = zeros(imgDim);
                f = fspecial('gaussian', 2, 1.5);
                for iFrame = 1 : imgDim(3);
                    dataChanFilt(:, :, iFrame) = imfilter(dataChan(:, :, iFrame), f, 'replicate');
%                         dataChanFilt(:, :, iFrame) = medfilt2(dataChan(:, :, iFrame), [3 3], 'symmetric');
                end;
                data{iChan} = dataChanFilt; % copy back the filtered data
            end;
            showMessage(this, 'Filtering frames done.');
        end;


        showMessage(this, 'Preparing frames ...', 'yellow');
        % calculate the RGB image for each (eventually filtered) frame
        RGBIm = cell2RGB(data, this.an.img.colVect, false);
        showMessage(this, 'Preparing frames done.');

        % store the frames
        this.rd.rawFrames{iRow} = RGBIm;

    end;

    % if an average image is requested, disable frame setter
    if get(this.GUI.handles.rd.showAvg, 'Value');
        set(this.GUI.handles.rd.frameSetter, 'Enable', 'off', 'Value', 0, 'Min', 0, 'Max', 1, ...
            'SliderStep', [0 1]);
    % otherwise, set the appropriate values for the frame setter
    else
        set(this.GUI.handles.rd.frameSetter, 'Enable', 'on', 'Value', 1, 'Min', 1, 'Max', imgDim(3), ...
            'SliderStep', [1 / imgDim(3) 3 / imgDim(3)]);
    end;

end;

% set the right frame
RDChangeFrame(this, -1);

% set back image correction filters to 0
set(this.GUI.handles.rd.mask, 'Value', 0);
set(this.GUI.handles.rd.imAdj, 'Value', 0);
set(this.GUI.handles.rd.pseudFF, 'Value', 0);
set(this.GUI.handles.rd.refROISet, 'Value', 0);
% remove the applied image corrections
this.GUI.rd.applImCorr = {};
    
end
