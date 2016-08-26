function INReset(this, ~, ~)
% INReset - [no description]
%
%       INReset(this, ~, ~)
%
% [No description]
%
% 2013-2016 - Copyleft and programmed by Balazs Laurenczy (blaurenczy_at_gmail.com)

% open a confirmation dialog
doFlush = questdlg('Intrinsic reset: are you sure you want to flush all data ?', '/!\ Warning !', 'Yes', 'No', 'No');

% if the decision is to not overwrite
if ~strcmp(doFlush, 'Yes');
    showMessage(this, 'Intrinsic: *NOT* flushing data !', 'red');        
    return;        
end;

showMessage(this, 'Intrinsic: flushing all data ...', 'yellow');
pause(0.1);

% keep the reference image
oldRefImg = this.in.data.refImg;

% flushing all data
this.in.data = struct();

% stores the *old* reference image
this.in.data.refImg = oldRefImg;

% stores the first baseline's frames
this.in.data.base1Frames = {};
% stores the second baseline' frames
this.in.data.base2Frames = {};
% stores the stimulus frames
this.in.data.stimFrames = {};
% stores the baseline DFF average images ((BL2 - BL1) / BL1)
this.in.data.baseDFFAvg = {};
% stores the stimulus DFF average images ((stim - BL1) / BL1)
this.in.data.stimDFFAvg = {};
% stores the include property of each run
this.in.data.includeInAvg = [];


% create the image handle
img = 0.5 * ones(this.GUI.in.imDim(1), this.GUI.in.imDim(2), 3);
set(this.GUI.handles.in.prevImg, 'CData', img);
set(this.GUI.handles.in.expLeftImg, 'CData', img);
set(this.GUI.handles.in.expRightImg, 'CData', img);

% clear previous ROI
if ~isempty(this.GUI.in.ROIHandle);
    showMessage(this, 'Intrinsic: clearing previous ROI ...', 'yellow');
    delete(this.GUI.in.ROIHandle{1});
    delete(this.GUI.in.ROIHandle{2});
    delete(this.GUI.in.ROIHandle{3});
    this.GUI.in.ROIHandle = {};
end;

showMessage(this, 'Intrinsic: flushing all data done.');

end
