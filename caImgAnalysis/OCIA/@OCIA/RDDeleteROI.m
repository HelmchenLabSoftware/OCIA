function RDDeleteROI(this, ~, ~)
% RDDeleteROI - [no description]
%
%       RDDeleteROI(this, ~, ~)
%
% [No description]
%
% 2013-2016 - Copyleft and programmed by Balazs Laurenczy (blaurenczy_at_gmail.com)

o('#RDDeleteROI()', 3, this.verb);

% get the selected ROIs
selROIs = RDGetSelectedROIs(this);
% abort if no selection
if isempty(selROIs); return; end;

try
    warning('off', 'MATLAB:class:DestructorError');
    arrayfun(@(iROI) delete(this.rd.ROIs{iROI, 1}), selROIs);
    warning('on', 'MATLAB:class:DestructorError');
catch e; %#ok<NASGU>
end;
try
arrayfun(@(iROI) delete(this.rd.ROIs{iROI, 5}), selROIs);
catch e; %#ok<NASGU>
end;
this.rd.ROIs(selROIs, :) = [];
this.rd.nROIs = size(this.rd.ROIs, 1);

% clear the selection
RDSelROI(this, this.GUI.handles.rd.selROISetterClear);

% renumbering of the ROIs in the right order
if get(this.GUI.handles.rd.renum, 'Value');
    for iROI = 1 : this.rd.nROIs;
        this.rd.ROIs{iROI, 6} = true; % mark ROIs as modified
        this.rd.ROIs{iROI, 2} = sprintf('%03d', iROI); % change the name
    end
end;

% update the display
RDUpdateGUI(this);
    
end
