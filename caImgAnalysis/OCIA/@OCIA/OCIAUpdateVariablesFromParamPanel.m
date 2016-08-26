function OCIAUpdateVariablesFromParamPanel(this, modeID)
% OCIAUpdateVariablesFromParamPanel - [no description]
%
%       OCIAUpdateVariablesFromParamPanel(this, modeID)
%
% [No description]
%
% 2013-2016 - Copyleft and programmed by Balazs Laurenczy (blaurenczy_at_gmail.com)

% update the parameter panel depending on the plot using the paramPanConfig
nUICtrl = size(this.GUI.(modeID).paramPanConfig, 1);

% go through all elements and update their associated parameters
for iUICtrl = 1 : nUICtrl;
    
    % extract the elements of the parameter config
    rowParams = table2cell(this.GUI.(modeID).paramPanConfig(iUICtrl, 1 : 4));
    [categ, id, UIType, valueType] = rowParams{:};
    
    % get category parts
    categParts = regexp(categ, '\.', 'split');
    if numel(categParts) > 1;
        categ = categParts{1};
        subCateg = categParts{2};
    else
        subCateg = [];
    end;
    
    % if no field corresponds to the id, skip this element
    if ~isfield(this.GUI.handles.(modeID).paramPanElems, id); continue; end;
    
    % process the different UI types
    switch UIType;
        
        % text input elements
        case 'text';
            
            % get the text
            txt = get(this.GUI.handles.(modeID).paramPanElems.(id), 'String');            
            % make sure we do not have a cell here
            if iscell(valueType); valueType = valueType{1}; end;
            
            % process the different value types
            switch valueType;
                
                case 'numeric'; % single number
                    txt = regexprep(txt, '2pi', '6\.28'); % substitue 2pi
                    txt = regexprep(txt, 'pi', '3\.14'); % substitue pi
                    dblValue = str2double(txt); % get the value as double
                    % unless the value is a NaN, store it in the right variable
                    if ~isnan(dblValue);
                        if isempty(subCateg);
                            this.(modeID).(categ).(id) = dblValue; 
                        else
                            this.(modeID).(categ).(subCateg).(id) = dblValue; 
                        end;
                    end;
                    
                case 'text'; % string
                    % unless the value is a empty, store it in the right variable
                    if ~isempty(txt);
                        if isempty(subCateg);
                            this.(modeID).(categ).(id) = txt;
                        else
                            this.(modeID).(categ).(subCateg).(id) = txt; 
                        end;
                    end;
                    
                case 'array'; % array of numbers
                    txt = regexprep(txt, '2pi', '6\.28'); % substitue 2pi
                    txt = regexprep(txt, 'pi', '3\.14'); % substitue pi
                    % remove anything that is not a number, a comma, an 'e' or 'E', a colon, a dot, a minus, 
                    %   a space or square brackets
                    val = regexprep(txt, '[^\[\]\deE ,:;\.-]', '');
                    % single dash means leave empty
                    if strcmp(val, '-');
                        if isempty(subCateg);
                            this.(modeID).(categ).(id) = '';
                        else
                            this.(modeID).(categ).(subCateg).(id) = ''; 
                        end;
                        continue;
                    end;
                    % if the text is not empty, evaluate the text to get the actual array, 
                    %   using try-catch to catch the eval errors
                    if ~isempty(val); try val = eval(val); catch e; val = []; end; end; %#ok<NASGU>
                    % if the array is not empty and does not contains NaNs, store its value
                    if ~isempty(val) && ~any(isnan(val(:)));
                        if isempty(subCateg);
                            this.(modeID).(categ).(id) = val;
                        else
                            this.(modeID).(categ).(subCateg).(id) = val; 
                        end;
                    end;
                    
                case 'cellArray'; % cell array of strings
                    % remove anything that is not a number, a comma, a colon, a dot, a minus, a space or square brackets
                    val = regexprep(txt, '^\{ (.+)\ }$', '$1');
                    % single dash means leave empty
                    if numel(val) == 1 && strcmp(val, '-');
                        if isempty(subCateg);
                            this.(modeID).(categ).(id) = { };
                        else
                            this.(modeID).(categ).(subCateg).(id) = { }; 
                        end;
                        continue;
                    end;
                    % split by columns
                    rowSplitVal = regexp(regexprep(val, ';$', ''), '; ', 'split')';
                    % make sure val is a cell
                    if ~iscell(rowSplitVal); rowSplitVal = { rowSplitVal }; end;
                    nRows = numel(rowSplitVal);
                    % split each row
                    colSplitVal = regexp(rowSplitVal, ', ', 'split');
                    % split each row
                    nColsForEachRow = arrayfun(@(i)size(colSplitVal{i}, 2), 1 : nRows);
                    % if all columns do not have the same number of rows, show a warning and abort
                    if any(nColsForEachRow ~= nColsForEachRow(1));
                        showWarning(this, 'OCIA:OCIAUpdateVariablesFromParamPanel:BadNumOfRowsForColsCellArray', sprintf( ...
                            'Param. control "%s" of mode "%s": all columns do not have the same number of rows. Aborting.', modeID, id));
                        continue;
                    end;
                    val = cell(nRows, nColsForEachRow(1));
                    % reshape values into a cell-array
                    for iRow = 1 : nRows;
                        val(iRow, :) = colSplitVal{iRow};
                    end;
                    % re-cast values as numbers if required
                    for iCell = 1 : numel(val);
                        % if cell is a number between brackets
                        if regexp(val{iCell}, '^\[[-\.\d]+\]$');
                            val{iCell} = eval(val{iCell});
                        end;
                    end;
                    % if the array is a cell array of strings, store it
                    if ~isempty(val) && iscell(val);
                        if isempty(subCateg);
                            this.(modeID).(categ).(id) = val;
                        else
                            this.(modeID).(categ).(subCateg).(id) = val; 
                        end;
                    end;
                    
            end; % end of valueType switch
            
        % drop down elements
        case 'dropdown';
            % get the possible values
            values = get(this.GUI.handles.(modeID).paramPanElems.(id), 'String');
            
            % check if we have true/false drop-down
            if numel(values) == 2 && all(ismember(values, { 'true', 'false' }));
                if isempty(subCateg);
                    this.(modeID).(categ).(id) ...
                        = strcmp(values{get(this.GUI.handles.(modeID).paramPanElems.(id), 'Value')}, 'true');
                else
                    this.(modeID).(categ).(subCateg).(id) ...
                        = strcmp(values{get(this.GUI.handles.(modeID).paramPanElems.(id), 'Value')}, 'true');
                end;
                
            % not a true/false drop-down
            else
                % store the selected value
                if isempty(subCateg);
                    this.(modeID).(categ).(id) = values{get(this.GUI.handles.(modeID).paramPanElems.(id), 'Value')};
                else
                    this.(modeID).(categ).(subCateg).(id) ...
                        = values{get(this.GUI.handles.(modeID).paramPanElems.(id), 'Value')};
                end;
                
            end;
            
            
        % list elements
        case 'list';
            % get the possible values
            values = get(this.GUI.handles.(modeID).paramPanElems.(id), 'String');
            % if no values, leave field empty
            if isempty(values);
                if isempty(subCateg);
                    this.(modeID).(categ).(id) = { };
                else
                    this.(modeID).(categ).(subCateg).(id) = { };
                end;
            % otherwise if there are some values in the list
            elseif get(this.GUI.handles.(modeID).paramPanElems.(id), 'Value') <= numel(values);
                % store the selected value
                if isempty(subCateg);
                    this.(modeID).(categ).(id) = values(get(this.GUI.handles.(modeID).paramPanElems.(id), 'Value'));
                else
                    this.(modeID).(categ).(subCateg).(id) ...
                        = values(get(this.GUI.handles.(modeID).paramPanElems.(id), 'Value'));
                end;
            end;
            
            
        % nothing to do
        case 'button';
            
        % get value
        case 'slider';
            if isempty(subCateg);
                this.(modeID).(categ).(id) = get(this.GUI.handles.(modeID).paramPanElems.(id), 'Value');
            else
                this.(modeID).(categ).(subCateg).(id) = get(this.GUI.handles.(modeID).paramPanElems.(id), 'Value');
            end;
            
    end; % end of UIType switch
    
end; % end of control element loop

end