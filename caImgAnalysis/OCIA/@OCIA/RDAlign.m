function RDAlign(this, varargin)
% RDAlign - [no description]
%
%       RDAlign(this, varargin)
%
% [No description]
%
% 2013-2016 - Copyleft and programmed by Balazs Laurenczy (blaurenczy_at_gmail.com)

alignTotTic = tic;

% get selected row
iRow = get(this.GUI.handles.rd.tableList, 'Value');
if isempty(iRow); return; end;
iRow = iRow(1);
iDWRow = this.rd.selectedTableRows(iRow);
rowID = DWGetRowID(this, iDWRow);

% align the images of the row to itself
try
    set(this.GUI.handles.rd.align, 'Enable', 'off', 'String', 'Align frames [...]');
    this.GUI.dw.isProcessingOnGoing = true;
    [isValid, unvalidReason] = OCIA_dataProcess_imgData_fJitt(this, iDWRow);
    [isValid, unvalidReason] = OCIA_dataProcess_imgData_fShift(this, iDWRow);
    [isValid, unvalidReason] = OCIA_dataProcess_imgData_moCorr(this, iDWRow);
    this.GUI.dw.isProcessingOnGoing = false;
    set(this.GUI.handles.rd.align, 'Enable', 'on', 'String', 'Align frames');
catch err;
    showWarning(this, 'OCIA:RDAlign:AlignFail1', sprintf('Alignment for %s (%03d) aborted ("%s"): %s', rowID, ...
        iDWRow, err.identifier, err.message));
    this.GUI.dw.isProcessingOnGoing = false;
    set(this.GUI.handles.rd.align, 'Enable', 'on', 'String', 'Align frames');
end;

% process errors
if ~isValid && ~isempty(unvalidReason);
    showWarning(this, 'OCIA:RDAlign:AlignFail1', sprintf('Alignment for %s (%03d) aborted: row is not valid: %s.', ...
        rowID, iDWRow, unvalidReason));
    return;
elseif ~isValid;
    showWarning(this, 'OCIA:RDAlign:AlignFail1', sprintf('Alignment for %s (%03d) aborted: unknown error', ...
        rowID, iDWRow));
end;


% delete the stored image
this.rd.avgImages{iRow} = [];
% delete the stored image
this.rd.rawFrames{iRow} = [];

% replace image
RDChangeRow(this, iRow);

o('#%s(): done (%5.3f sec).', mfilename, toc(alignTotTic), 3, this.verb);

end
