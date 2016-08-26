function [regMat, targetPoints, sourcePoints, regTimes] = turboReg(srcMat, targetImage, transf, cropSize, ...
    refPoints, doPlots)
% turboReg

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%% GENERATE COMMAND STRING FOR DO ALIGN JAVA METHOD %%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% CROPPING COMMAND SUBSTRING
% We are going to crop each of the images along each side to allow images to be shifted over cropped regions
imageHeight = size(targetImage, 1);
imageWidth = size(targetImage, 2);
cropStr = sprintf('%d %d %d %d', cropSize, cropSize, imageWidth - cropSize, imageHeight - cropSize);

% SET REFERENCE POINTS SUBSTRING FOR REGISTRATION
% the coordinates should be in source-target pairs: src1X src1Y targ1X targ1Y src2X src2Y targ2X targ2Y ...
% construct full refPoints command string :
% if no arguments provided, use the center of the image as refPoints for registration
if isempty(refPoints) && ~isempty(regexp(transf, 'translation', 'once'));
    centerX = fix(imageWidth / 2) - 1 - cropSize;
    centerY = fix(imageHeight / 2) - 1 - cropSize;
    refPointsStr = sprintf('%d %d %d %d', centerX, centerY, centerX, centerY);
% if array provided, use the coordinates as refPoints for registration
elseif ~isempty(refPoints) && isnumeric(refPoints);
    % store the refPoints as spaced-separated string
    refPointsStr = regexprep(sprintf('%d ', refPoints), '\s+$', '');
% if a string was provided, keep it as such
elseif ~isempty(refPoints) && ischar(refPoints);
    refPointsStr = refPoints;
% otherwise throw an error
else
    error('MotionCorrection_TurboReg:NoValidRefPoints', 'No valid refPoints');
end;

% CONSTRUCT THE FULL COMMAND STRING FROM SUBSTRINGS
cmdstr = ['-align -window s ', cropStr,' -window t ', cropStr,' -', transf, ' ', refPointsStr,' -hideOutput'];
% cmdstr = ['-align -window s ', cropStr,' -window t ', cropStr,' -', transf, ' ', refPointsStr,' -showOutput'];

regMat = zeros(size(srcMat), 'uint16');
targetPoints = nan(size(srcMat, 3), 4, 2);
sourcePoints = nan(size(srcMat, 3), 4, 2);
regTimes = nan(1, size(srcMat, 3));

% remove NaNs
targetImage(isnan(targetImage)) = min(targetImage(:));
srcMat(isnan(srcMat)) = min(srcMat(:));

% add the java path to every worker of the pool
OCIAPath = regexprep(which('OCIA'), '\\', '/');
OCIAPath = regexprep(OCIAPath, '/@OCIA/OCIA.m$', '');
warning('off', 'MATLAB:Java:DuplicateClass');
% if there is a parallel pool, add the java path to every worker of the pool
if ~isempty(gcp) && ~isempty(OCIAPath);
    poolHandle = gcp;
    parfor iFrame = 1 : poolHandle.NumWorkers;
        javaaddpath([OCIAPath '/java/ij.jar']);
        javaaddpath([OCIAPath '/java/TurboRegJava']);
    end;
% otherwise just add the java path
elseif ~isempty(OCIAPath);
    javaaddpath([OCIAPath '/java/ij.jar']);
    javaaddpath([OCIAPath '/java/TurboRegJava']);
end;
warning('on', 'MATLAB:Java:DuplicateClass');

% import java classes/methods
import IJAlign_BL.*;
import ij.*;

% go through all frames and register them one by one
for iFrame = 1 : size(srcMat, 3);

    ticAlign = tic; % for performance timing purposes
    
    % CONVERT TARGET IMAGE TO AN IMAGEJ IMAGE
    ijTargetImage = array2ijStack(targetImage);

    % CONVERT TO IJSOURCE IMAGE
    ijSource = array2ijStack(srcMat(:, :, iFrame));

    % call an instance of the customized ImageJ TurboReg plugin
    al = IJAlign_BL();
    
    % Perform image registration calling doAlign method on al object
    ijRegistered = al.doAlign(cmdstr, ijSource, ijTargetImage);
    
    % get the source and target points for applying the registration on other channels
    targetPoints(iFrame, :, :) = al.targetPoints;
    sourcePoints(iFrame, :, :) = al.sourcePoints;
    
    % convert registered image back to matlab array and store it
    regMat(:, :, iFrame) = ij2array(ijRegistered);
    
    regTimes(iFrame) = toc(ticAlign);
                    
end;

% convert to double
regMat = double(regMat);
% replace zeros by NaNs
regMat(regMat == 0) = NaN;

% if requested, do plots illustrating the registration
if doPlots > 0;

    % go through all frames
    for iFrame = 1 : size(srcMat, 3);
%         figCommons = {'NumberTitle', 'off'};
        figCommons = {'NumberTitle', 'off', 'WindowStyle', 'docked'};

        % convert to double and replace zeros by NaNs
        regFrame = double(regMat(:, :, iFrame));
        regFrame(regFrame == 0) = NaN;
        sourceFrame = double(srcMat(:, :, iFrame));
        sourceFrame(sourceFrame == 0) = NaN;

        figure('Name', sprintf('Frame %d - averages', iFrame), figCommons{:});
        subplot(2, 2, 1); imagesc(sourceFrame);    title('Source (to register)');
        subplot(2, 2, 2); imagesc(regFrame);        title('Registered (corrected)');
        subplot(2, 2, 3); imagesc(targetImage);     title('Target (reference)');

        % show refPoints if there are any
        if ~isempty(refPoints) && isnumeric(refPoints);
            for iPlot = 1 : 3;
                subplot(2, 2, iPlot);
                hold on;
                nRefPoints = numel(refPoints) / 4;
                cols = lines(nRefPoints);
                for iMark = 1 : nRefPoints;
                    i = (iMark - 1) * nRefPoints;
                    plot(repmat(refPoints(i + 1), 1, 2), [0 imageHeight], 'Color', cols(iMark, :));
                    plot([0 imageWidth], repmat(refPoints(i + 2), 1, 2), 'Color', cols(iMark, :));
                end;
            end;
        end;
    end;

end;


end

