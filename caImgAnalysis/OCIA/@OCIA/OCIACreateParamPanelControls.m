
function OCIACreateParamPanelControls(this, modeID, varargin)
% OCIACreateParamPanelControls - Creates a parameter pannel menu
%
%       OCIACreateParamPanelControls(this, modeID, optionalHandleOfNavButtons)
%
% Creates a parameter panel menu from a parameter panel configuration ("this.GUI.(modeID).paramPanConfig") and a
%   data structure ("this.(modeID).(categ).(id)"). If "optionalHandleOfNavButtons" exists and is a handle to the
%   parameter panel navigation buttons, the panel is not re-created but just updated to display the right page
%   ("this.GUI.(modeID).paramPage").
%
% 2013-2016 - Copyleft and programmed by Balazs Laurenczy (blaurenczy_at_gmail.com)

% abort if no configuration provided
if isempty(this.GUI.(modeID).paramPanConfig); return; end;

%% init
fontSizeAdjust = 1;
labelFontSizeAdjust = 1;
switch modeID;
    
    % Analyser mode
    case 'an';
        
        % define the updating function
        updateFunction = @ANUpdatePlot;
        % define the max number of rows and the number of items to place
        nMaxRows = 5; nMinRows = 5; nMaxCols = 2; nMinCols = 2; pad = 0.02; inPad = 0.01;
%         nMaxRows = 4; nMinRows = 4; nMaxCols = 4; nMinCols = 3; pad = 0.02; inPad = 0.01;
%         fontSizeAdjust = 3.0;
        
    % Intrinsic mode
    case 'in';
    
        % define the updating function
        updateFunction = @INUpdateParams;
        % define the max number of rows and the number of items to place
        nMaxRows = 10; nMinRows = 8; nMaxCols = 4; nMinCols = 3; pad = 0.025; inPad = 0.02;
        
    % Behavior mode
    case 'be';
    
        % define the updating function
        updateFunction = @BEUpdateParams;
        % define the max number of rows and the number of items to place
        nMaxRows = 15; nMinRows = 15; nMaxCols = 2; nMinCols = 2; pad = 0.02; inPad = 0.015;
        
        fontSizeAdjust = 0.5;
        
    % TrialView mode
    case 'tv';
    
        % define the updating function
        updateFunction = @TVUpdateParams;
        % define the max number of rows and the number of items to place
        nMaxRows = 10; nMinRows = 10; nMaxCols = 2; nMinCols = 2; pad = 0.02; inPad = 0.015;
        
        labelFontSizeAdjust = 1.1;
        fontSizeAdjust = 0.7;
        
    otherwise
        return;
end;

%% init the parameter pannel dimensions
% common inputs
commons = { 'Parent', this.GUI.handles.(modeID).paramPan, 'Units', 'normalized', 'Enable', 'off' };
UICommons = struct();
callBackFcn = { 'Callback', @(h, e) updateFunction(this, h, e) };
UICommons.text = [ commons, { 'Background', 'white', 'Style', 'edit' }, callBackFcn ];
UICommons.dropdown = [ commons, { 'Background', 'white', 'Style', 'popupmenu' }, callBackFcn ];
UICommons.list = [ commons, { 'Background', 'white', 'Style', 'list', 'Min', 0, 'Max', 2 }, callBackFcn ];
UICommons.button = [ commons, { 'Style', 'pushbutton' } ];
UICommons.slider = [ commons, { 'Style', 'slider' } ];
UICommons.lab = [ commons, { 'Background', 'white', 'Style', 'text' } ];
UICommons.paramNav = [ commons, { 'Style', 'pushbutton', 'Enable', 'off', 'FontSize', ...
    round(this.GUI.pos(4) / 55 * fontSizeAdjust), 'Callback', @(h, e)OCIACreateParamPanelControls(this, modeID, h) } ];

% define the max number of rows and the number of items to place
nUICtrl = size(this.GUI.(modeID).paramPanConfig, 1);
UISizes = this.GUI.(modeID).paramPanConfig{:, 5};
nUICtrlRows = sum(UISizes(:, 1));

% calculate the number of acutal columns and rows to use
nRows = min(max(ceil(nUICtrlRows / nMaxCols), nMinRows), nMaxRows);
nCols = min(max(ceil((nUICtrlRows / nRows)), nMinCols), nMaxCols) + 0.15;
elemW = (1 - (nCols + 1) * pad) / nCols; % width depends on the number of columns
elemH = (1 - (nRows + 1) * pad) / nRows; % height depends on the number of rows
iRow = 0; iCol = 0; %#ok<NASGU>, init the row and column indexes

% part of the width that is allocated for the label if it is on the side
labelWidthRatio = 0.5;
% height that is allocated for the label if it is on the top
labelHeight = 0.5;

% if call was made by one of the navigate buttons
if ~isempty(varargin) && (varargin{1} == this.GUI.handles.(modeID).nextParams...
        || varargin{1} == this.GUI.handles.(modeID).prevParams);
    % get all UI elements except the arrows
    UIElems = this.GUI.handles.(modeID).paramPanElems;
    % compute the minimum and maximum positions of the UIControls to desactivate the next/prev buttons
    minPos = Inf; maxPos = -Inf;
    % get the move direction
    direction = iff(varargin{1} == this.GUI.handles.(modeID).prevParams, 1, -1);
    % get the IDs and go through each elements
    UIIDs = fieldnames(UIElems);
    for iElem = 1 : numel(UIIDs);
        % get the position of this element 
        pos = get(this.GUI.handles.(modeID).paramPanElems.(UIIDs{iElem}), 'Position');
        % update the position
        pos = pos + [nMaxCols * (elemW + pad) 0 0 0] .* direction;
        % move the element
        set(this.GUI.handles.(modeID).paramPanElems.(UIIDs{iElem}), 'Position', pos);
        % if the control is outside the visible area, hide them
        isOut = pos(1) > 0 && (pos(1) + pos(3)) < 1;
        set(this.GUI.handles.(modeID).paramPanElems.(UIIDs{iElem}), 'Visible', iff(isOut, 'on', 'off'));
        minPos = min(minPos, pos(1));
        maxPos = max(maxPos, pos(1) + pos(3));
    end;
    % enable/disable the navigating buttons
    set(this.GUI.handles.(modeID).prevParams, 'Enable', iff(minPos > 0, 'off', 'on'));
    set(this.GUI.handles.(modeID).nextParams, 'Enable', iff(maxPos < 1, 'off', 'on'));

    % update the page number
    this.GUI.(modeID).paramPage = this.GUI.(modeID).paramPage + direction;
    return;
end;

%% clear the parameters area
paramPanChildren = get(this.GUI.handles.(modeID).paramPan, 'Children');
% do not remove the navigating buttons
if isfield(this.GUI.handles.(modeID), 'nextParams');
    paramPanChildren(paramPanChildren == this.GUI.handles.(modeID).nextParams) = [];
    paramPanChildren(paramPanChildren == this.GUI.handles.(modeID).prevParams) = [];
end;
delete(paramPanChildren);
this.GUI.handles.(modeID).paramPanElems = struct();

%% create the next previous settings buttons
% calculate X and Y base positions
prevButPosX = 0.25 * pad;
prevButPosY = pad;
this.GUI.handles.(modeID).prevParams = uicontrol(UICommons.paramNav{:}, 'String', '<', ...
    'Tag', sprintf('%sParamPrevParams', upper(modeID)), ...
    'Position', [prevButPosX prevButPosY elemW * 0.1 (elemH + pad) * nRows - pad], ...
    'ToolTipString', 'Previous parameter controls');
iRow = iRow + nRows;
iCol = 0.05 + pad;
nextButPosX = (nCols - 0.1) * (pad + elemW) + 0.75 * pad;
this.GUI.handles.(modeID).nextParams = uicontrol(UICommons.paramNav{:}, 'String', '>', ...
    'Tag', sprintf('%sParamNextParams', upper(modeID)), ...
    'Position', [nextButPosX prevButPosY elemW * 0.1 (elemH + pad) * nRows], ...
    'ToolTipString', 'Next parameter controls');
    
%% create the UI elements with their labels
% go through all elements, create them and place them
for iUICtrl = 1 : nUICtrl;
    
    % get the variables of the current control element
    rowParams = table2cell(this.GUI.(modeID).paramPanConfig(iUICtrl, :));
    [categ, id, UIType, valueType, UISize, isLabelAbove, label, tooltip] = rowParams{:};
    
    % adjust element height for multiple rows
    elemHLocal = (1 - (nRows - UISize(1) + 2) * pad) / nRows; % height depends on the number of rows
    
    % adjacent buttons
    if strcmp(UIType, 'button') && UISize(2) > 0 && iUICtrl > 1;
        rowParamsBef = table2cell(this.GUI.(modeID).paramPanConfig(iUICtrl - 1, :));
        [~, ~, UITypeBef, ~, UISizeBef] = rowParamsBef{:};
        % if this is the second button element that is not full width and total width is not exceeding 1
        if strcmp(UITypeBef, 'button') && UISizeBef(2) > 0 && UISize(2) + UISizeBef(2) <= 1;
            % put this button at the same row
            iRow = iRow - 1;
        end;
    end;
        
    % update row/column index
    iRow = iRow + UISize(1);
    % if max number of rows is reached, go to the next column update rows/columns
    if iRow > nRows;
        iRow = UISize(1);
        iCol = iCol + 1;
    end;

    % calculate X and Y base positions
    elemPosX = (iCol - 1) * (pad + elemW) + pad;
    if UISize(1) == nRows;
        elemPosY = 1 - iRow * elemHLocal - pad;
    elseif UISize(1) > 1;
        elemPosY = 1 - iRow * (elemHLocal + pad * (UISize(1) / nRows)) - pad;
    else
        elemPosY = 1 - iRow * (elemHLocal + pad) + pad;
    end;
    
    % font sizes
    ctrlElemFontSize = round(this.GUI.pos(4) / (105 - 3 * nRows)) * fontSizeAdjust;
    labFontSize = round(this.GUI.pos(4) / (115 - 3 * nRows + 0.1 * numel(label))) * fontSizeAdjust * labelFontSizeAdjust;
    
    % calculate positions, depending on whether the label is above or not:
    % if label is above
    if isLabelAbove;
        % position and size for label
        labElemX = elemPosX;
%         labElemY = elemPosY + (UISize(1)) * elemHLocal + (UISize(1) - 1) * pad;
        labElemY = elemPosY + (UISize(1) - labelHeight) * elemHLocal + 0.5 * pad;
        labElemW = elemW;
        labelemHLocal = labelHeight * elemHLocal;
        % position and size for GUI element
        ctrlElemX = elemPosX;
        ctrlElemW = elemW;
        ctrlElemY = elemPosY;
        ctrlelemHLocal = (UISize(1) - labelHeight) * elemHLocal + pad;
        labFontSize = round(this.GUI.pos(4) / (125 - 3 * nRows + 0.1 * numel(label))) * fontSizeAdjust * labelFontSizeAdjust;
        
    % if label is not above
    else
        % position and size for label
        labElemX = elemPosX;
        labElemY = elemPosY + (UISize(1) * 0.5 - 0.25) * elemHLocal;
        labElemW = elemW * (labelWidthRatio - inPad);
        labelemHLocal = elemHLocal * 0.5;
        % position and size for GUI element
        ctrlElemX = elemPosX + elemW * (labelWidthRatio + inPad);
        ctrlElemW = elemW * (1 - labelWidthRatio - inPad);
        ctrlElemY = elemPosY;
        ctrlelemHLocal = UISize(1) * elemHLocal + (UISize(1) - 1) * pad;
        
    end;
    
    % reduce a bit the size of the dropdown menus
    if strcmp(UIType, 'dropdown');
        labFontSize = round(labFontSize * 0.8);
        ctrlElemFontSize = round(ctrlElemFontSize * 0.8);
        labElemY = elemPosY + (UISize(1) * 0.5 - 0.1) * elemHLocal;
        
    % no label for buttons
    elseif strcmp(UIType, 'button');
        ctrlElemX = ctrlElemX - labElemW;
        ctrlElemW = ctrlElemW + labElemW;
        labElemW = 0;
        
        % special case of two buttons next to each other
        if UISize(2) > 0;
            ctrlElemW = ctrlElemW * UISize(2);
            
            % adjacent buttons
            if iUICtrl > 1;
                rowParamsBef = table2cell(this.GUI.(modeID).paramPanConfig(iUICtrl - 1, :));
                [~, ~, UITypeBef, ~, UISizeBef] = rowParamsBef{:};
                % if this is the second button element that is not full width and total width is not exceeding 1
                if strcmp(UITypeBef, 'button') && UISizeBef(2) > 0 && UISize(2) + UISizeBef(2) <= 1;
                    % put this button to the right
                    ctrlElemX = ctrlElemX + ctrlElemW;
                end;
            end;
        end;
        
    % process differently big lists
    elseif strcmp(UIType, 'list') && UISize(1) == nRows && isLabelAbove;
        labelHeightLocal = 0.8;
        % position and size for label
        labElemY = elemPosY + (UISize(1) - labelHeightLocal * 0.9) * elemHLocal + 0.5 * pad;
        labelemHLocal = labelHeightLocal * elemHLocal;
        % position and size for GUI element
        ctrlelemHLocal = (UISize(1) - labelHeightLocal) * elemHLocal + pad;
        labFontSize = round(this.GUI.pos(4) / (125 - 3 * nRows + 0.1 * numel(label))) * 1.5;
        
        
    % process differently big lists
    elseif strcmp(UIType, 'list') && UISize(1) > 1 && isLabelAbove;
        labelHeightLocal = 0.8;
        labElemY = elemPosY + (UISize(1) - labelHeightLocal * 0.5) * elemHLocal + 0.5 * pad;
        labFontSize = round(this.GUI.pos(4) / (125 - 3 * nRows + 0.1 * numel(label))) * 1.5;
                
    end;
    
    % create the label
    this.GUI.handles.(modeID).paramPanElems.([id '_label']) = uicontrol(UICommons.lab{:}, 'String', label, ...
        'Position', [labElemX labElemY labElemW labelemHLocal], 'ToolTipString', tooltip, ... 'BackgroundColor', 'red', ...
        'Tag', sprintf('%sParam%s', upper(modeID), id), 'FontSize', labFontSize);
    
        
    % get category parts
    categParts = regexp(categ, '\.', 'split');
    if numel(categParts) > 1;
        categ = categParts{1};
        subCateg = categParts{2};
    else
        subCateg = [];
    end;
    % if the field does not exist, create it
    if (~isempty(subCateg) && ~isfield(this.(modeID).(categ).(subCateg), id)) ...
            || (isempty(subCateg) && ~isfield(this.(modeID).(categ), id));
        this.(modeID).(categ).(id) = '';
    end;
    
    callbackFcn = [];
            
    % process the different UI types
    switch UIType;
        
        % text controls
        case 'text';       
            % get the value from the storage variable
            if isempty(subCateg);
                storedValue = this.(modeID).(categ).(id);
            else
                storedValue = this.(modeID).(categ).(subCateg).(id);
            end;
            % if the value is not text and its an array, display as an array between brackets
            if numel(storedValue) > 1 && ~strcmp(valueType, 'text') && ~strcmp(valueType, 'cellArray');                
                % add semi colon at each line end
                stringValue = [ num2str(storedValue), repmat(';', size(storedValue, 1), 1)];
                % reshape as a single line
                stringValue = reshape(stringValue', 1, numel(stringValue));
                % replace all spaces by single space
                stringValue = regexprep(stringValue, '\s+', ' ');
                % remove all starting spaces
                stringValue = regexprep(stringValue, '^\s', '');
                stringValue = regexprep(stringValue, '; ', ';');
                % remove all empty spaces and replace them by commas
                stringValue = ['[', regexprep(stringValue, '\s+', ','), ']'];
                % clean up: remove last semi colon
                stringValue = regexprep(stringValue, ';\]$', ']');
                % clean up: remove starting comas
                stringValue = regexprep(stringValue, '[\[;]$', ']');
                % clean up: add space after each colon or semi colon
                stringValue = regexprep(stringValue, '([,;])', '$1 ');
                
            % if the value is a text, keep it as a string so do nothing
            elseif numel(storedValue) > 1 && strcmp(valueType, 'text');  
                
                stringValue = storedValue;
                
            % if the value is a text, keep it as a cell array string so do nothing
            elseif iscell(storedValue) && strcmp(valueType, 'cellArray');
                
                % process each cell and transform it into a string
                for iCell = 1 : numel(storedValue);
                    
                    % if cell is already a string, skip
                    if ischar(storedValue{iCell});
                        continue;
                        
                    % if cell is an array, transform it into a string
                    elseif isnumeric(storedValue{iCell});
                        % add semi colon at each line end
                        stringValue = [ num2str(storedValue{iCell}), repmat(';', size(storedValue{iCell}, 1), 1)];
                        % reshape as a single line
                        stringValue = reshape(stringValue', 1, numel(stringValue));
                        % replace all spaces by single space
                        stringValue = regexprep(stringValue, '\s+', ' ');
                        % remove all starting spaces
                        stringValue = regexprep(stringValue, '^\s', '');
                        stringValue = regexprep(stringValue, '; ', ';');
                        % remove all empty spaces and replace them by commas
                        stringValue = ['[', regexprep(stringValue, '\s+', ','), ']'];
                        % clean up: remove last semi colon
                        stringValue = regexprep(stringValue, ';\]$', ']');
                        % clean up: remove starting comas
                        stringValue = regexprep(stringValue, '[\[;]$', ']');
                        % clean up: add space after each colon or semi colon
                        storedValue{iCell} = regexprep(stringValue, '([,;])', '$1 ');
                        
                    % if just an empty cell
                    elseif ~isempty(storedValue{iCell});
                        storedValue{iCell} = '';
                        
                    % otherwise if not just and empty, abort conversion
                    else
                        storedValue{iCell} = 'unknownDataType';
                        showWarning(this, 'OCIA:OCIACreateParamPanelControls:UnkownDataTypeInCellArray', sprintf( ...
                            ['An unknown data type has been found in the cell array of the parameter control ', ...
                            '"%s" of the mode "%s", class: %s! Skipping.'], id, modeID, class(storedValue)));
                        
                    end;
                end;
                
                % non-empty cell array
                if ~isempty(storedValue) && numel(storedValue) >= 1 && ~isempty(storedValue{1});
                    % add a semi colon after each last cell
                    storedValue(:, end) = arrayfun(@(iCell) [storedValue{iCell, end}, ';'], 1 : size(storedValue, 1), ...
                        'UniformOutput', false);
                    % rearrange cell-array
                    storedValue = storedValue';
                    % add a coma after each cell
                    storedValue = arrayfun(@(iCell) [storedValue{iCell}, ','], 1 : numel(storedValue), ...
                        'UniformOutput', false);
                    % remove the useless commas
                    storedValue = regexprep(storedValue, ';,$', ';');
                    % create the string
                    stringValue = ['{ ', regexprep(sprintf('%s ', storedValue{:}), ' $', '') ' }'];
                    
                % cell-array is empty
                else
                    stringValue = '';
                end;
            % otherwise the value is just a number
            else
                stringValue = num2str(storedValue);
            end;
            % leave value empty
            value = [];
            
            % substitue pi
            stringValue = regexprep(stringValue, '3\.14', 'pi');
            stringValue = regexprep(stringValue, '6\.28', '2pi');
            
        % drop down menu elements  
        case 'dropdown';
            % if the value from the storage variable is empty
            if (isempty(subCateg) && isempty(this.(modeID).(categ).(id))) ...
                    || (~isempty(subCateg) && isempty(this.(modeID).(categ).(subCateg).(id)));
                value = 1; % select the first item   
                
            % otherwise if it is a boolean drop-down and there is a value in the storage variable
            elseif numel(valueType) == 2 && all(ismember(valueType, { 'true', 'false' }));
                % get the values to select
                if isempty(subCateg);
                    valueString = iff(this.(modeID).(categ).(id), 'true', 'false');
                else
                    valueString = iff(this.(modeID).(categ).(subCateg).(id), 'true', 'false');
                end;
                value = find(strcmp(valueType, valueString));
                
            % otherwise if there is a value in the storage variable
            else
                % get the values to select
                if isempty(subCateg);
                    value = find(strcmp(valueType, this.(modeID).(categ).(id)));
                else
                    value = find(strcmp(valueType, this.(modeID).(categ).(subCateg).(id)));
                end;
            end;
            % use a string the cell-array from the configuration
            stringValue = valueType;
            
        % list elements  
        case 'list';
            % get the stored variable
            if isempty(subCateg);
                storedVariable = this.(modeID).(categ).(id);
            else
                storedVariable = this.(modeID).(categ).(subCateg).(id);
            end;
            % if the value from the storage variable is empty
            if isempty(storedVariable);
                value = []; % select nothing                
            % otherwise if there is a value in the storage variable
            else
                % make sure the stored variable is a cell
                if ~iscell(storedVariable); storedVariable = { storedVariable }; end;
                % make sure the valueType is a cell
                if ~iscell(valueType); valueType = { valueType }; end;
                % make sure the valueType is a cell
                if ~isempty(valueType) && numel(valueType) == 1 && iscell(valueType{1});
                    valueType = valueType{1};
                end;
                % get the values to select
                value = find(arrayfun(@(i)ismember(valueType{i}, storedVariable), 1 : numel(valueType)));
            end;
            % use a string the cell-array from the configuration
            stringValue = valueType;
            
        % buttons
        case 'button';
            stringValue = label;
            if iscell(valueType) && ~isempty(valueType) && isa(valueType{1}, 'function_handle');
                callbackFcn = valueType{1};
            elseif ~isempty(valueType) && isa(valueType, 'function_handle');
                callbackFcn = valueType;
            end;
            
        % sliders
        case 'slider';
            stringValue = label;
            if isempty(subCateg);
                value = this.(modeID).(categ).(id);
            else
                value = this.(modeID).(categ).(subCateg).(id);
            end;
            if iscell(valueType) && ~isempty(valueType) && isa(valueType{1}, 'function_handle');
                callbackFcn = valueType{1};

            elseif ~isempty(valueType) && isa(valueType(1), 'function_handle');
                callbackFcn = valueType;
            end;
            
    end; % end of GUI type switch
    
    
    % reduce a bit the size of the lists if there are a lot elements inside
    if strcmp(UIType, 'list') && ~strcmp(id, 'fileList');
        nElems = numel(stringValue);
        ctrlElemFontSize = min(max(round(ctrlElemFontSize * 1.2 - 0.07 * nElems), 6), 25);
    end;
    
%     % extract cell in cell
%     if iscell(stringValue) && ~isempty(stringValue) && numel(stringValue) == 1 && iscell(stringValue{1});
%         stringValue = stringValue{1};
%     end;
            
    % create the GUI element
    this.GUI.handles.(modeID).paramPanElems.(id) = uicontrol(UICommons.(UIType){:}, ...
        'String', stringValue, 'Value', value, 'Tag', sprintf('%sParam%s', upper(modeID), id), ...
        'Position', [ctrlElemX ctrlElemY ctrlElemW ctrlelemHLocal], 'ToolTipString', tooltip, ...
        'FontSize', ctrlElemFontSize);

    % set a minimum and a maximum
    if strcmp(UIType, 'slider');
        set(this.GUI.handles.(modeID).paramPanElems.(id), 'Min', valueType{2}, 'Max', valueType{3}, 'SliderStep', ...
            [valueType{4}, valueType{5}]);
    end;
    
    % pushbuttons should not be presset
    if strcmp(UIType, 'button');
        set(this.GUI.handles.(modeID).paramPanElems.(id), 'Value', 0);
    end;
    
    if ~isempty(callbackFcn);
        % pass input arguments
        if strcmp(UIType, 'button') && numel(valueType) > 1;
            set(this.GUI.handles.(modeID).paramPanElems.(id), 'Callback', @(h, e) callbackFcn(this, valueType{2 : end}));
        else
            set(this.GUI.handles.(modeID).paramPanElems.(id), 'Callback', @(h, e) callbackFcn(this));
        end;
        % add a callback for the frame setter
        if strcmp(UIType, 'slider');
            jObj = findjobj(this.GUI.handles.(modeID).paramPanElems.(id));
            set(jObj, 'AdjustmentValueChangedCallback', @(h, e) callbackFcn(this));
        end;
    end;

    % if the controls are outside the visible area, hide them
    if iCol > nCols;
        set(this.GUI.handles.(modeID).paramPanElems.(id), 'Visible', 'off');
        set(this.GUI.handles.(modeID).paramPanElems.([id '_label']), 'Visible', 'off');
        % enable the navigating buttons
        set(this.GUI.handles.(modeID).nextParams, 'Enable', 'on');
    end;
    
end;

% refresh the GUI
drawnow();
    
% go through all elements, to update those that need a Java-based update
for iUICtrl = 1 : nUICtrl;    
    % get the variables of the current control element
    rowParams = table2cell(this.GUI.(modeID).paramPanConfig(iUICtrl, :));
    [~, id, UIType, valueType, UISize] = rowParams{:};
    % if the element is a list and the UISize setting requires some Java-based updating of the uicontrol
    if strcmp(UIType, 'list') && UISize(2) > 0;
        % launch a timer to update the control
        start(timer('StartDelay', 0.15, 'TimerFcn', @(~, ~) javaUpdateUIControl( ...
            this.GUI.handles.(modeID).paramPanElems.(id), round(numel(valueType) / UISize(2)))));
    end;
end;

% only show the parameter panel if there are some controls to display
set(this.GUI.handles.(modeID).paramPan, 'Visible', iff(nUICtrl > 0, 'on', 'off'));

% change the parameter page
if this.GUI.(modeID).paramPage ~= 1;
    % reset to page 1
    this.GUI.(modeID).paramPage = 1;
    % update the pages
    for iPage = 1 : this.GUI.(modeID).paramPage;
        OCIACreateParamPanelControls(this, modeID, this.GUI.handles.(modeID).nextParams);
    end;
end;

end

% little function to update an uicontrol
function javaUpdateUIControl(handle, nRows)
    try       
        visState = get(handle, 'Visible'); % get visibility state
        pos = get(handle, 'Position'); % get position
        % make visible
        set(handle, 'Position', pos + iff(strcmp(visState, 'off'), [10E5 10E5 0 0], [0 0 0 0]), 'Visible', 'on');
        jObj = findjobj(handle);
        jListbox = jObj.getViewport().getView();
        jListbox.setLayoutOrientation(jListbox.HORIZONTAL_WRAP);
        jListbox.setVisibleRowCount(nRows);
        set(handle, 'Visible', visState, 'Position', pos);
    catch err; %#ok<NASGU>        
        % Nobody cares if this fails. At least not me >.<
    end;
end