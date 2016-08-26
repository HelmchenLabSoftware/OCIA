function RGBIm = OCIA_getPreview_behavData(this, iDWRow, ~)
% RGBIm = OCIA_getPreview_behavData - [no description]
%
%       RGBIm = OCIA_getPreview_behavData(this, iDWRow, ~)
%
% [No description]
%
% 2013-2016 - Copyleft and programmed by Balazs Laurenczy (blaurenczy_at_gmail.com)

loadTic = tic; % for performance timing purposes
o('#%s: iDWRow: %03d', mfilename, iDWRow, 3, this.verb);

% load the data in partial mode (only first couple frames)
DWLoadRow(this, iDWRow, 'partial');

% get the data
behavData = get(this, iDWRow, 'data');
behavData = behavData.behav.data;

% if there is some data, draw an image
if ~isempty(behavData);
    nTrials = numel(behavData.resps);
    RGBIm = zeros(2, nTrials, 3);
    RGBIm(1, :, 1) = behavData.resps(1 : nTrials);
    RGBIm(2, :, 2) = behavData.respTypes(1 : nTrials);
% otherwise return nothing
else
    RGBIm = [];
end;

o('  #%s: iDWRow %03d done (%3.1f sec).', mfilename, iDWRow, toc(loadTic), 4, this.verb);

end
