%%  #OCIA:RD:RDSelROI
function RDSelROI(this, varargin)

o('#RDSelROI()', 4, this.verb);

h = []; % no handle by default
% get the handle if there is any
if nargin > 1; h = varargin{1}; end;

% if change was requested by a number, overwrite the selection
if ~isempty(h) && isnumeric(h) && ~ishandle(h);
    selROIs = h;
% if change was requested by a string or cell-array of strings, overwrite the selection
elseif ~isempty(h) && (ischar(h) || iscellstr(h));
    if ischar(h); h = { h }; end;
    if strcmp(get(this.GUI.figH, 'SelectionType'), 'extend');
        selROIs = [str2double(h), RDGetSelectedROIs(this, this.GUI.handles.rd.selROIsList)];
    else
        selROIs = str2double(h);
    end;
    selROIs(isnan(selROIs)) = [];
% if a clearing of the selection was requested, empty selection    
elseif ~isempty(h) && h == this.GUI.handles.rd.selROISetterClear;
    selROIs = [];
% if selection was requested by the edit field
elseif ~isempty(h) && ((h == this.GUI.handles.rd.selROI) || (h == this.GUI.handles.rd.selROISetter));
    selROIs = RDGetSelectedROIs(this, h);
% otherwise use selection with the list
else
    selROIs = RDGetSelectedROIs(this, this.GUI.handles.rd.selROIsList);
end;

o('#RDSelROI(): h: %d, selectedROIs: %s .', h, num2str(selROIs), 3, this.verb);

% update the color of the ROIs
for iROI = 1 : this.rd.nROIs;
    if ismember(iROI, selROIs);
        this.rd.ROIs{iROI, 1}.setColor('red');
        if ishandle(this.rd.ROIs{iROI, 5}) && strcmp(get(this.rd.ROIs{iROI, 1}, 'Visible'), 'off');
            set(this.rd.ROIs{iROI, 5}, 'Color', 'blue');
        end;
    else
       this.rd.ROIs{iROI, 1}.setColor('blue');
        if ishandle(this.rd.ROIs{iROI, 5}) && strcmp(get(this.rd.ROIs{iROI, 1}, 'Visible'), 'off');
            set(this.rd.ROIs{iROI, 5}, 'Color', 'red');
        end;
    end;
end;

% if no ROIs, no selection text
if isempty(selROIs);
    selROIsText = '';
% otherwise create the selection text
else
    % start with the first number
    selROIsText = sprintf('%s', this.rd.ROIs{selROIs(1), 2});
    inRange = false; % determines if we are currently in a range display (1 : ...)
    for iSel = 2 : numel(selROIs); % go through all numbers starting from the second
        
        % get the ROI numbers
        currROI = this.rd.ROIs{selROIs(iSel), 2};
        prevROI = this.rd.ROIs{selROIs(iSel - 1), 2};
        
        % if we are not in range and next number is just previous + 1, then start a range display
        if str2double(currROI) - 1 == str2double(prevROI) && ~inRange;
            selROIsText = sprintf('%s:', selROIsText);
            inRange = true;
        % if we are in range and next number is just previous + 1, do not display number and continue range
        elseif str2double(currROI) - 1 == str2double(prevROI) && inRange;
            % skip number
        % if next number is not just previous + 1, then eventually finish range display and display number
        else
        	% if we were in range, finish range display of last number
            if inRange;
                selROIsText = sprintf('%s%s', selROIsText, prevROI);
            end
            % display next number
            selROIsText = sprintf('%s,%s', selROIsText, currROI);
            inRange = false;
        end;
    end;
    
    % if we are still in range display, it means last number could not be displayed, so display it
    if inRange;
        selROIsText = sprintf('%s%s', selROIsText, currROI);
    end;
    
    
end;

% re-update the selection
set(this.GUI.handles.rd.selROISetter, 'String', strrep(selROIsText, '00', ''));
set(this.GUI.handles.rd.selROIsList, 'Value', selROIs);

end