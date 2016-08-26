function RDShowHideROIs(this, h, varargin)
% RDShowHideROIs - [no description]
%
%       RDShowHideROIs(this, h, varargin)
%
% [No description]
%
% 2013-2016 - Copyleft and programmed by Balazs Laurenczy (blaurenczy_at_gmail.com)

    o('#RDShowHideROIs()', 4, this.verb);
    
    % if no ROIs, abort
    if ~this.rd.nROIs; return; end;
    
    % in case of char input, toggle the checkbox
    if ~isempty(h) && ischar(h) && ~isempty(regexpi(h, 'ROIs?'));
        set(this.GUI.handles.rd.showHideROIs, 'Value', ~get(this.GUI.handles.rd.showHideROIs, 'Value'));
    end;
    
    % in case of char input, toggle the checkbox
    if ~isempty(h) && ischar(h) && ~isempty(regexpi(h, '(IDs?|Labe?l?)'));
        set(this.GUI.handles.rd.showHideROIsLab, 'Value', ~get(this.GUI.handles.rd.showHideROIsLab, 'Value'));
    end;
    
    % show hide ROIs themselves
    for iROI = 1 : this.rd.nROIs;
        % if ROI is shown, hide it
        if ~get(this.GUI.handles.rd.showHideROIs, 'Value');
            set(this.rd.ROIs{iROI, 1}, 'Visible', 'off');
        % otherwise show ROI
        elseif get(this.GUI.handles.rd.showHideROIs, 'Value');
            set(this.rd.ROIs{iROI, 1}, 'Visible', 'on');
            if isa(this.rd.ROIs{iROI, 1}, 'impoly') || isa(this.rd.ROIs{iROI, 1}, 'imfreehand');
                this.rd.ROIs{iROI, 1}.setVerticesDraggable(false);
            end;
        end;
    end;
    
    RDUpdateGUI(this, h);
    
end
