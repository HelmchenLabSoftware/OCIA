function INSaveImages(this, savePath)
% INSaveImages - [no description]
%
%       INSaveImages(this, savePath)
%
% [No description]
%
% 2013-2016 - Copyleft and programmed by Balazs Laurenczy (blaurenczy_at_gmail.com)

% if no save path provided, generate it
if isempty(savePath);
    % get the save path
    savePath = sprintf('%s%s_', this.path.intrSave, INGetSaveName(this));
end;

%% standard mode
if strcmp(this.in.expMode, 'standard');

    refSavePath = sprintf('%sreference.png', savePath);
    refROISavePath = sprintf('%sreferenceWithROI.png', savePath);
    baselineAvgSavePath = sprintf('%sbaseline.png', savePath);
    stimulusAvgSavePath = sprintf('%sstimulus.png', savePath);
    compareAvgSavePath = sprintf('%scompare.png', savePath);

    set(this.GUI.handles.in.standard.showAvg, 'Value', 1);
    INUpdateGUI(this);

    % check if a file already exists
    if exist(refSavePath, 'file') || exist(refROISavePath, 'file') || exist(baselineAvgSavePath, 'file') ...
            || exist(stimulusAvgSavePath, 'file') || exist(compareAvgSavePath, 'file');
        % open a confirmation dialog
        doOverWrite = questdlg(sprintf('Intrinsic saving: existing files has been found at "%s***". Do you want to overwrite them?', ...
            savePath), '/!\ Warning !', 'Yes', 'No', 'No');    
        % if the decision is to not overwrite
        if ~strcmp(doOverWrite, 'Yes');
            showMessage(this, sprintf('Intrinsic: *NOT* overwriting file at "%s***". Saving aborted !', savePath), 'red');        
            return;        
        end;

        showMessage(this, sprintf('Intrinsic: overwriting file at "%s*" ...', savePath), 'yellow');
        pause(0.1);
    end;

    % create directory if it does not exist
    if exist(this.path.intrSave, 'dir') ~= 7; mkdir(this.path.intrSave); end;

    showMessage(this, sprintf('Intrinsic: saving reference image to "%s" ...', refSavePath), 'yellow'); pause(0.05);
    refImg = this.in.data.refImg;
    imwrite(this.in.data.refImg, refSavePath);

    if ~isempty(this.GUI.in.ROIHandle);

        showMessage(this, sprintf('Intrinsic: saving reference image with ROI to "%s" ...', refROISavePath), 'yellow'); pause(0.05);
        % get a copy of the image
        refImgROI = refImg;
        refImgROI = repmat(refImgROI, [1 1 3]);
        % get the position of the ROI
        ROIPos = this.GUI.in.ROIHandle{1}.getPosition();
        % set drawing parameters
        r = 1; % size of the point
        colMask = logical(this.GUI.in.refROIOutlineColor);
        % draw the countour by going through each coordinate and marking the path from the previous coordinate
        for iCoord = 2 : size(ROIPos, 1);
            % get the current and previous coordinates
            xCurr = ROIPos(iCoord, 2);
            yCurr = ROIPos(iCoord, 1);
            xPrev = ROIPos(iCoord - 1, 2);
            yPrev = ROIPos(iCoord - 1, 1); 
            % get the distance between coordinates
            coordsDist = round(sqrt((xCurr - xPrev) ^ 2 + (yCurr - yPrev) ^ 2));
            % walk back from current to previous by steps of 1 pixel
            for iDist = 1 : coordsDist;
                for iR = 1 : r;
                    % get the currently drawn coordinate as the current coordinate minus a ratio of the distance
                    y0 = round(yCurr - iDist * ((yCurr - yPrev) / coordsDist));
                    x0 = round(xCurr - iDist * ((xCurr - xPrev) / coordsDist));
                    % get the list of x coordinates
                    xRange = round(x0 - iR) : round(x0 + iR);
                    xRange(xRange < 1 | xRange > size(refImgROI, 2)) = []; % make sure they do not exceed the limits

                    % get the list of y coordinates as a circle
                    yRange = round([sqrt(iR ^ 2 - (xRange - x0) .^ 2) + y0, -sqrt(iR ^ 2 - (xRange - x0).^ 2) + y0]);
                    xRange = [xRange, fliplr(xRange)]; %#ok<AGROW>
                    % draw the path with selected colors
                    refImgROI(xRange, yRange, colMask) = 1;
                    refImgROI(xRange, yRange, ~colMask) = 0;
                end;
            end;        
        end;
        % save image
        imwrite(refImgROI, refROISavePath);
    end;


    showMessage(this, sprintf('Intrinsic: saving baseline image to "%s" ...', baselineAvgSavePath), 'yellow'); pause(0.05);
    baselineImg = get(this.GUI.handles.in.expLeftImg, 'CData');
    [H, W] = size(baselineImg);
    cLim = get(this.GUI.handles.in.expAxeLeft, 'CLim');
    baselineImg(baselineImg < cLim(1)) = cLim(1);
    baselineImg(baselineImg > cLim(2)) = cLim(2);
    baselineImg = linScale([baselineImg(:)', cLim]);
    baselineImg = reshape(baselineImg(1 : end - 2), H, W);
    imwrite(baselineImg, baselineAvgSavePath);

    showMessage(this, sprintf('Intrinsic: saving stimulus image to "%s" ...', stimulusAvgSavePath), 'yellow'); pause(0.05);
    stimImg = get(this.GUI.handles.in.expRightImg, 'CData');
    cLim = get(this.GUI.handles.in.expAxeRight, 'CLim');
    [H, W] = size(stimImg);
    stimImg(stimImg < cLim(1)) = cLim(1);
    stimImg(stimImg > cLim(2)) = cLim(2);
    stimImg = linScale([stimImg(:)', cLim]);
    stimImg = reshape(stimImg(1 : end - 2), H, W);
    imwrite(stimImg, stimulusAvgSavePath);

    showMessage(this, sprintf('Intrinsic: saving comparison image to "%s" ...', compareAvgSavePath), 'yellow'); pause(0.05);
    compareImg = [baselineImg, stimImg];
    imwrite(compareImg, compareAvgSavePath);

%% fourier mode
elseif strcmp(this.in.expMode, 'fourier');

    refSavePath = sprintf('%sreference.png', savePath);
    pixTimeCoursePath = sprintf('%spixTimeCourse.png', savePath);
    spectrogramPath = sprintf('%sspectrogram.png', savePath);
    powMapPath = sprintf('%spowerMap.png', savePath);
    phaseMapPath = sprintf('%sphaseMap.png', savePath);
    
    % check if a file already exists
    if exist(refSavePath, 'file') || exist(powMapPath, 'file') || exist(phaseMapPath, 'file') ...
            || exist(pixTimeCoursePath, 'file') || exist(spectrogramPath, 'file');
        % open a confirmation dialog
        doOverWrite = questdlg(sprintf(...
            'Intrinsic saving: existing files has been found at "%s***". Do you want to overwrite them?', ...
            savePath), '/!\ Warning !', 'Yes', 'No', 'No');    
        % if the decision is to not overwrite
        if ~strcmp(doOverWrite, 'Yes');
            showMessage(this, sprintf('Intrinsic: *NOT* overwriting file at "%s***". Saving aborted !', savePath), 'red');        
            return;        
        end;

        showMessage(this, sprintf('Intrinsic: overwriting file at "%s*" ...', savePath), 'yellow');
        pause(0.1);
    end;

    % create directory if it does not exist
    if exist(this.path.intrSave, 'dir') ~= 7; mkdir(this.path.intrSave); end;
    
    showMessage(this, sprintf('Intrinsic: saving reference image to "%s" ...', refSavePath), 'yellow'); pause(0.05);
    refImg = linScale(this.in.data.refImg);
    imwrite(refImg, refSavePath);
    
end;

showMessage(this, sprintf('Intrinsic: saving intrinsic images to "%s***" done !', savePath));


end
