function RGBIm = OCIA_getPreview_wfTr(this, iDWRow, ~)
% RGBIm = OCIA_getPreview_wfTr - [no description]
%
%       RGBIm = OCIA_getPreview_wfTr(this, iDWRow, previewType)
%
% [No description]
%
% 2013-2016 - Copyleft and programmed by Balazs Laurenczy (blaurenczy_at_gmail.com)

loadTic = tic; % for performance timing purposes
o('#%s: iDWRow: %d.', mfilename, iDWRow, 3, this.verb);

% load the data in partial mode (only first couple frames)
DWLoadRow(this, iDWRow, 'partial');

% convert loaded data to double
RGBIm = double(getData(this, iDWRow, 'wfTrIm', 'data'));
            
o('#%s: iDWRow: %d done (%3.1f sec)', mfilename, iDWRow, toc(loadTic), 3, this.verb);

end
