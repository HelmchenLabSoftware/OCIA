function tableRow = OCIA_processFolder_img(this, tableRow, fullPath, patternName, hits)
% tableRow = OCIA_processFolder_img - [no description]
%
%       tableRow = OCIA_processFolder_img(this, tableRow, fullPath, patternName, hits)
%
% [No description]
%
% 2013-2016 - Copyleft and programmed by Balazs Laurenczy (blaurenczy_at_gmail.com)

processTic = tic; % for performance timing purposes
o('#%s: in "%s", full path: %s.', mfilename, fullPath, 3, this.verb);

% fill in the table's variable that are independant on the match type
tableRow = set(this, 1, 'day', hits.day, tableRow);
tableRow = set(this, 1, 'time', hits.time, tableRow);

% process the different match types differently
switch patternName;

    % imaging file
    case 'imgData';
        
        % get the file's type (extension) and process accordingly
        fileType = char(regexp(fullPath, '[^\.]+$', 'match'));
        switch fileType;
            
            % imaging data in .tif files
            case 'tif';
                    
                tableRow = set(this, 1, 'rowType', 'Imaging data', tableRow);
                
                % skip meta-data processing if not requested
                if ~get(this.GUI.handles.dw.skipMeta, 'Value');

                    % get the file's dimension information
                    imInfo = imfinfo(fullPath);
                    dims = [imInfo(1).Width imInfo(1).Height numel(imInfo)];

                    % skip the 3rd dimension if it's 1 (display '256x256' and not '256x256x1')
                    if dims(3) == 1; dims = dims(1 : 2); end;

                    % create and store a dimension tag like : '256x256' or '100x100x3'
                    dimTag = regexprep(sprintf(repmat('%dx', 1, numel(dims)), dims), 'x$', '');
                    tableRow = set(this, 1, 'dim', dimTag, tableRow);

                end;

            % imaging data in .bin (binary) files
            case 'bin';
                    
                tableRow = set(this, 1, 'rowType', 'Imaging data', tableRow);

                % if the image dimension is specified in the config and meta-data processing is requested
                if isfield(this.an, 'img') && isfield(this.an.img, 'defaultImDim') ...
                        && ~get(this.GUI.handles.dw.skipMeta, 'Value');

                    fileInfo = dir(fullPath); % get the file's information
                    imgDims = this.an.img.defaultImDim; % get the default image's dimension from the configuration

                    % calculate the file's dimensions in terms of pixels and number of frames
                    dimTag = sprintf('%dx%dx%d', imgDims, floor(fileInfo.bytes / (prod(imgDims) * 2)));
                    tableRow = set(this, 1, 'dim', dimTag, tableRow);

                end;
        end;
        
    % imaging data in .tif files
    case 'imgMeta';
        
        % skip meta-data processing if not requested
        if ~get(this.GUI.handles.dw.skipMeta, 'Value');
            
            % get the parent folder's path
            parentFolderPath = regexprep(fullPath, '/[^/]+$', '');
            [~, metaData] = loadData(parentFolderPath, 'nMaxFrameLoad', 0, 'skipMeta', false);

            % copy the meta-data in the the table
            tableRow = set(this, 1, 'laserInt',     metaData{1}.laserInt,   tableRow);
            tableRow = set(this, 1, 'zoom',         metaData{1}.zoom,       tableRow);
            tableRow = set(this, 1, 'frameRate',    metaData{1}.frameRate,  tableRow);
            tableRow = set(this, 1, 'zStep',        metaData{1}.zStep,      tableRow);
            tableRow = set(this, 1, 'dim',          metaData{1}.dimTag,     tableRow);
            
        end;
        
end;

o('  #%s: %s done (%3.1f sec).', mfilename, fullPath, toc(processTic), 4, this.verb);

end
