function RGBIm = OCIA_getPreview_imgData(this, iDWRow, previewType)
% RGBIm = OCIA_getPreview_imgData - [no description]
%
%       RGBIm = OCIA_getPreview_imgData(this, iDWRow, previewType)
%
% [No description]
%
% 2013-2016 - Copyleft and programmed by Balazs Laurenczy (blaurenczy_at_gmail.com)

loadTic = tic; % for performance timing purposes
o('#%s: iDWRow: %d.', mfilename, iDWRow, 3, this.verb);

% default is empty
RGBIm = [];

% load the data in partial mode (only first couple frames)
DWLoadRow(this, iDWRow, 'partial');

% get the processed images
imgData = get(this, iDWRow, 'data');
preProcData = imgData.procImg.data;

% if some data was loaded
if ~isempty(preProcData);
    % compensate absent pre-processed data with raw data
    for iChan = 1 : numel(preProcData);
        if isempty(preProcData{iChan});
            preProcData{iChan} = imgData.rawImg.data{iChan};
        end;
    end;
    
    % get the color vector
    colVect = 1 : numel(preProcData);
    try colVect = this.an.img.colVect; catch err; end; %#ok<NASGU>
    % little "hack" so that if the comments say that the image was with a red/green filter cube, alter the color vector
    if ~isempty(get(this, iDWRow, 'comments')) && ~isempty(regexp(get(this, iDWRow, 'comments'), 'red/green', 'once'));
        colVect = [1 2 0];
    end;
    
    % create the RGB image, averaged or not depending on the preview type
    RGBIm = cell2RGB(preProcData, colVect, strcmp(previewType, 'preview'));
    
    % modify image according to runType
    runType = get(this, iDWRow, 'runType');
    if ~isempty(runType) && ischar(runType);
        switch runType;

            case 'ministack';

                nFrames = size(RGBIm, 3);
                nFramesPerAvg = 100;
                nFramesStack = nFrames / nFramesPerAvg;
                nRemFrames = mod(nFrames, nFramesPerAvg);
                if nRemFrames == 0;
                    RGBImStack = nan(size(RGBIm, 1), size(RGBIm, 2), nFramesStack, 3);
                    for i = 1 : nFramesStack;
                        frameRange = ((i - 1) * nFramesPerAvg + 1) : i * nFramesPerAvg;
                        RGBImStack(:, :, i, :) = nanmean(RGBIm(:, :, frameRange, :), 3);
                    end;
                    RGBIm = RGBImStack;
                end;

        end;
    end;
end;
            
o('#%s: iDWRow: %d done (%3.1f sec)', mfilename, iDWRow, toc(loadTic), 3, this.verb);

end
