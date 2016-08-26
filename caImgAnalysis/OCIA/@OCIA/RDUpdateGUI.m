function RDUpdateGUI(this, varargin)
% RDUpdateGUI - [no description]
%
%       RDUpdateGUI(this, varargin)
%
% [No description]
%
% 2013-2016 - Copyleft and programmed by Balazs Laurenczy (blaurenczy_at_gmail.com)


RDUpdateGUITic = tic; % for performance timing purposes
o('#%s()', mfilename, 4, this.verb);

% get axe limits
axeLims = [get(this.GUI.handles.rd.axe, 'XLim'); get(this.GUI.handles.rd.axe, 'YLim')];

% create a tag for updating all ROIs
updateAll = false;

% if ROIs storing structure has 6 columns
if size(this.rd.ROIs, 2) >= 6;
    
    % make sure no cell is empty
    this.rd.ROIs(cellfun(@isempty, this.rd.ROIs(:, 6)), 6) = { false };

    % if no ROI is marked to be updated, update all of them
    if ~any(cell2mat(this.rd.ROIs(:, 6)));
        updateAll = true;
    end;
end;

% update the ROIs
ROIUpdateTic = tic; % for performance timing purposes
for iROI = 1 : this.rd.nROIs;

    if size(this.rd.ROIs, 2) >= 6 && ~updateAll && ~this.rd.ROIs{iROI, 6};
        o('  #%s(): skipping ROI%03d.', mfilename, iROI, 4, this.verb);
        continue;
    end;
    this.rd.ROIs{iROI, 6} = false; % remove the modified tag
    
    if ~updateAll && strcmp(get(this.GUI.figH, 'SelectionType'), 'extend');
        ROISelHandle = this.GUI.handles.rd.selROIsList;
        set(ROISelHandle, 'Value', [get(ROISelHandle, 'Value'), iROI]);
        RDSelROI(this, []);
        o('  #%s(): Selecting ROI %03d !', mfilename, iROI, 1, this.verb);
        showMessage(this, sprintf('Selected ROI %s.', this.rd.ROIs{iROI, 2}));
    end;

    this.rd.ROIs{iROI, 3} = this.rd.ROIs{iROI, 1}.getPosition(); % update the position
    ROIPos = this.rd.ROIs{iROI, 3};
    o('  #%s(): ROI%03d position: [%.2f, %.2f, %.2f, %.2f]', mfilename, iROI, ROIPos, 4, this.verb);

    switch class(this.rd.ROIs{iROI, 1});
        case {'impoly', 'imfreehand'};
            meanROIPos = mean(ROIPos, 1);
        otherwise;
            meanROIPos = ROIPos(1 : 2) + 0.5 * ROIPos(3 : 4);
    end

    xOffset = 3 / this.GUI.rd.zoomLevel;
    if size(this.rd.ROIs, 2) > 4 && ~isempty(this.rd.ROIs{iROI, 5}) && ishandle(this.rd.ROIs{iROI, 5});
        delete(this.rd.ROIs{iROI, 5}); % remove the text handles
    end;

    % check that this ROI is not outside of the image
    if meanROIPos(1) > axeLims(1, 1) && meanROIPos(1) < axeLims(1, 2) ...
            && meanROIPos(2) > axeLims(2, 1) && meanROIPos(2) < axeLims(2, 2);
         
        % choose the color of the ID
        col = 'red';
        if strcmp(get(this.rd.ROIs{iROI, 1}, 'Visible'), 'off') && all(this.rd.ROIs{iROI, 1}.getColor() == [1 0 0]);
            col = 'blue';
        end;
        
        % choose the visibility of the ID
        visib = 'off';
        if get(this.GUI.handles.rd.showHideROIsLab, 'Value'); visib = 'on'; end;
        
        % add the ROIID as text label and store the handle
        this.rd.ROIs{iROI, 5} = text(meanROIPos(1) - xOffset, meanROIPos(2), this.rd.ROIs{iROI, 2}, ...
            'Color', col, 'FontWeight', 'bold', 'Visible', visib, 'Tag', sprintf('ROIID_%s', this.rd.ROIs{iROI, 2}), ...
            'Parent', this.GUI.handles.rd.axe, 'ButtonDownFcn', @(h, e)RDSelROI(this, sprintf('%03d', iROI)));
    end;
end;
o('#%s(): updated text handles (%5.3f sec).', mfilename, toc(ROIUpdateTic), 3, this.verb);

% update the mask
updateMaskTic = tic; % for performance timing purposes
RDUpdateMask(this);
o('#%s(): updated mask (%5.3f sec).', mfilename, toc(updateMaskTic), 3, this.verb);

% update the ROI selection list
if ~isempty(this.rd.ROIs);
    set(this.GUI.handles.rd.selROIsList, 'String', this.rd.ROIs(:, 2));
else
    set(this.GUI.handles.rd.selROIsList, 'String', {}, 'Value', []);
end;

% give back the focus
if ~isempty(varargin) && numel(varargin{1}) == 1 && ishandle(varargin{1}) && strcmp(get(varargin{1}, 'Type'), 'uicontrol');
    set(findobj(this.GUI.figH, 'Type', 'uicontrol'), 'Enable', 'off');
    drawnow();
    set(findobj(this.GUI.figH, 'Type', 'uicontrol'), 'Enable', 'on');
end;

o('#%s(): done (%5.3f sec).', mfilename, toc(RDUpdateGUITic), 3, this.verb);

end
