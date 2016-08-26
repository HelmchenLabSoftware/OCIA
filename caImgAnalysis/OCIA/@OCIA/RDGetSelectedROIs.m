function selROIs = RDGetSelectedROIs(this, varargin)

h = []; % no handle by default
% get the handle if there is any
if nargin > 1; h = varargin{1}; end;

selROIs = []; % empty selection as default

% get selection from the edit field
if ~isempty(h) && (h == this.GUI.handles.rd.selROISetter || h == this.GUI.handles.rd.selROI);
    
    % get the base selection from the edit field
    selROIsText = get(this.GUI.handles.rd.selROISetter, 'String');
    o('#RDGetROISelection(): selROIText: %s', selROIsText, 3, this.verb);
    if ~isempty(selROIsText);
        if strcmp(selROIsText, 'all');
            selROIs = cellfun(@(x)str2double(x), this.rd.ROIs(:, 2))';
        else
            try
                eval(sprintf('selROIs = [%s];', selROIsText));
            catch e; %#ok<NASGU>
                showWarning(this, 'OCIA:RD:RDGetROISelection:InvalidROISelText', 'Invalid ROI selection text !');
            end;
        end;
    end;
    
    % get the indexes corresponding to the ROI numbers
    ROINames = get(this.GUI.handles.rd.selROIsList, 'String');
    selROIs = find(ismember(ROINames(1 : end), arrayfun(@(x)sprintf('%03d', x), selROIs, 'UniformOutput', false)));
    
% get selection using the ROI selection list
else
    selROIs = get(this.GUI.handles.rd.selROIsList, 'Value');
end

o('#RDGetROISelection(): selROIs: %s', sprintf('%03d ', selROIs), 3, this.verb);

end