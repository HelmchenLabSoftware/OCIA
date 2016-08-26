function RDClearROIs(this, ~, ~)
% RDClearROIs - [no description]
%
%       RDClearROIs(this, ~, ~)
%
% [No description]
%
% 2013-2016 - Copyleft and programmed by Balazs Laurenczy (blaurenczy_at_gmail.com)

    o('#RDClearROIs(): nROIs: %d', this.rd.nROIs, 4, this.verb);
    % select all ROIs
    set(this.GUI.handles.rd.selROIsList, 'Value', 1 : this.rd.nROIs);
    % delete them
    RDDeleteROI(this);
    
    % clear the annotations
    try
        childHands = get(this.GUI.handles.rd.axe, 'Children');
        childTags = get(childHands, 'Tag');
        delete(childHands(strcmp('ROICompareLine', childTags)));
        delete(childHands(strcmp('ROICompareText', childTags)));
        delete(childHands(strcmp('ROICompareScatter', childTags)));
    catch e; %#ok<NASGU>        
    end;
    
    % clear the annotations
    try
        childHands = get(this.GUI.handles.rd.axe, 'Children');
        childTags = get(childHands, 'Tag');
        delete(childHands(~cellfun(@isempty, regexp(childTags, 'ROIID_', 'once'))));
    catch e; %#ok<NASGU>        
    end;
    
    % reset the setters
    set(this.GUI.handles.rd.selROIsList, 'Value', []);

end
