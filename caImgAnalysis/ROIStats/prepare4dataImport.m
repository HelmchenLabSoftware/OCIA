function expInfo = prepare4dataImport(notebookFilename, spotList, refNamesWithRoiSet, ...
    includeZoomOut, includeSurface, includeMinistack)
% read the HS notebook and generate experiment info cell array
% experimenter: BL

dbgLevel = 1;
nbFileID = fopen(notebookFilename);
expInfo = cell(1, 9);
iRun = 1;
line = fgetl(nbFileID);
while ischar(line)
    if numel(line) < 4
        line = fgetl(nbFileID);
        continue
    end
    spotID = line(1:4);
    if ~isempty(find(strcmp(spotList(:, 2), spotID), 1))
        currentSpot = spotList{strcmp(spotList(:, 2), spotID), 1};
        currentExp = line(5:end);
        zoomedOut = 0;
        if ~isempty(strfind(lower(currentExp), 'bf_')) || ~isempty(strfind(lower(currentExp), 'odd10_'));
            currentExp = strtrim(currentExp);
        elseif ~includeZoomOut && ~isempty(strfind(currentExp, 'zoomed out'));
            line = fgetl(nbFileID);
            continue
        elseif strfind(currentExp, 'zoomed out');
            zoomedOut = 1;
        elseif strfind(currentExp, 'Ref256x');
            currentExp = 'Ref256x';
        elseif includeSurface && ~isempty(strfind(currentExp, 'surface'));
            currentExp = 'surface';
        elseif includeMinistack && ~isempty(strfind(currentExp, 'ministack'));
            currentExp = 'ministack';
        else
            line = fgetl(nbFileID);
            continue
        end
        
        fileID = fgetl(nbFileID);
        fileID = strtrim(strrep(fileID,':',''));
        imagingMode = fgetl(nbFileID);
        if ~isempty(strfind(imagingMode,'frame rate'))
            m = regexp(imagingMode, ['- ImagingMode: 2PM (?<imType>[^,]+), ' ...
                'XY(?<zOrT>[TZ])?=(?<x>\d+)x(?<y>\d+)x?(?<zt>\d+)?, frame rate=(?<rate>[\d\.]+) Hz'], 'names');
            rate = str2double(m.rate);
        else
            m = regexp(imagingMode, ['- ImagingMode: 2PM (?<imType>[^,]+), ' ...
                'XY(?<zOrT>[TZ])?=(?<x>\d+)x(?<y>\d+)x?(?<zt>\d+)?'], 'names');
            rate = NaN;
        end
        imType = strrep(m.imType, 'single ', ''); % transform 'single frame' to 'frame'
        
        scanHead = fgetl(nbFileID);
        m = regexp(scanHead, '- ScanHead: final intensity=(?<laserInt>[\d\.]+)%; zoom=(?<zoom>[\d\.]+)', 'names');
        laserInt = str2double(m.laserInt);
        zoom = str2double(m.zoom);
        
        % print out everything (for debug)
        strOut = sprintf('%s %s\n', currentSpot, currentExp);
        strOut = sprintf('%sFile: %s\nType: %s\n', strOut, fileID, imType);
        strOut = sprintf('%sRate: %1.2f\tLaser: %1.2f\tZoom: %1.2f\n', strOut, rate, laserInt, zoom);
        o('%s', strOut, 2, dbgLevel);
        expInfo{iRun,1} = currentSpot;
        expInfo{iRun,2} = currentExp;
        expInfo{iRun,3} = fileID;
        expInfo{iRun,4} = imType;
        expInfo{iRun,5} = rate;
        expInfo{iRun,6} = laserInt;
        expInfo{iRun,7} = zoom;
        % set to 1 if run is a reference with a RoiSet
        expInfo{iRun, 8} = ~isempty(strfind(currentExp, 'Ref256x')) ...
            & any(~cellfun(@isempty, strfind(refNamesWithRoiSet, fileID)));
        expInfo{iRun, 9} = zoomedOut;
        iRun = iRun + 1;
    end
    line = fgetl(nbFileID);
end

fclose(nbFileID);
