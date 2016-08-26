function RGBIm = OCIA_getPreview_ROISetMatFile(this, iDWRow, ~)
% RGBIm = OCIA_getPreview_ROISetMatFile - [no description]
%
%       RGBIm = OCIA_getPreview_ROISetMatFile(this, iDWRow, ~)
%
% [No description]
%
% 2013-2016 - Copyleft and programmed by Balazs Laurenczy (blaurenczy_at_gmail.com)

loadTic = tic; % for performance timing purposes
o('#%s: iDWRow: %d ...', mfilename, iDWRow, 3, this.verb);

% load the data in partial mode (only first couple frames)
DWLoadRow(this, iDWRow, 'partial');

% get the data
ROISetData = get(this, iDWRow, 'data');
ROISetData = ROISetData.ROISets.data;

% if there is any data loaded, return the reference image
if ~isempty(ROISetData)    
    RGBIm = ROISetData.refImage;
    if iscell(RGBIm);
%         RGBIm = RGBIm{this.an.img.preProcChan};
        RGBIm = cell2RGB(RGBIm, this.an.img.colVect, 1);
    end;
    % make sur image is RGB
    if ismatrix(RGBIm);
        RGBIm = repmat(RGBIm, [1 1 3]);
    end;
    
% if no data, return nothing
else
    RGBIm = [];
    
end;

o('  #%s: %s done (%3.1f sec).', mfilename, toc(loadTic), 4, this.verb);

end
