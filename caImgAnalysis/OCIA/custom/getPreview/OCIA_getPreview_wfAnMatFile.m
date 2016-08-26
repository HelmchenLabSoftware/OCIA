function RGBIm = OCIA_getPreview_wfAnMatFile(this, iDWRow, ~)
% RGBIm = OCIA_getPreview_wfAnMatFile - [no description]
%
%       RGBIm = OCIA_getPreview_wfAnMatFile(this, iDWRow, previewType)
%
% [No description]
%
% 2013-2016 - Copyleft and programmed by Balazs Laurenczy (blaurenczy_at_gmail.com)

loadTic = tic; % for performance timing purposes
o('#%s: iDWRow: %d.', mfilename, iDWRow, 3, this.verb);

% load the data in partial mode (only first couple frames)
DWLoadRow(this, iDWRow, 'partial');

% convert loaded data to double
wfAnData = getData(this, iDWRow, 'wfAn', 'data');
phaseMap = wfAnData.WFCorrPowerAndPhaseMaps_01.phaseMaps{3};
RGBIm = gray2rgb(phaseMap, 100);
            
o('#%s: iDWRow: %d done (%3.1f sec)', mfilename, iDWRow, toc(loadTic), 3, this.verb);

end
