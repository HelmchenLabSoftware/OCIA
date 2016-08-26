function hashStruct = OCIA_analysis_widefield_getHashStruct(this, iFile, dataType, exclParamIDs, addParamsStruct)
% OCIA_analysis_widefield_getHashStruct - [no description]
%
%       hashStruct = OCIA_analysis_widefield_getHashStruct(this, iFile, dataType)
%       hashStruct = OCIA_analysis_widefield_getHashStruct(this, iFile, dataType, exclParamIDs)
%       hashStruct = OCIA_analysis_widefield_getHashStruct(this, iFile, dataType, exclParamIDs, addParamsStruct)
%
% [No description]
%
% 2013-2016 - Copyleft and programmed by Balazs Laurenczy (blaurenczy_at_gmail.com)
    
% create file IDs structure
fileIDStruct = struct();
    
% get information from selected file(s)
if numel(iFile) >= 1;    
    % go through each file
    for iFileLoop = 1 : numel(iFile);
        % single file case
        if iFileLoop == 1 && numel(iFile) == 1;
            [filePath, ~, ~, ~, framesDim, frameRate] = OCIA_analysis_widefield_getFileInfo(this, iFile(iFileLoop), true);
            fileID = regexprep(filePath, '.+/([^/]+)\.[^\.]+$', '$1');
            fileIDStruct.fileID = fileID;
            
        % first file of multi-file case
        elseif iFileLoop == 1;
            [filePath, ~, ~, ~, framesDim, frameRate] = OCIA_analysis_widefield_getFileInfo(this, iFile(iFileLoop), true);
            fileID = regexprep(filePath, '.+/([^/]+)\.[^\.]+$', '$1');
            fileIDStruct.fileID1 = fileID;
            
        % other files of multi-file case
        else
            filePath = OCIA_analysis_widefield_getFileInfo(this, iFile(iFileLoop), true);
            fileID = regexprep(filePath, '.+/([^/]+)\.[^\.]+$', '$1');
            fileIDStruct.(sprintf('fileID%d', iFileLoop)) = fileID;
        end;
    end;    
end;

% parameters from widefield
p = this.an.wf;

% limit frame range
if numel(framesDim) >= 3;
    frameRange = p.frameRange;
    if frameRange(2) == -1; frameRange(2) = Inf; end;
    if frameRange(2) == -2; frameRange = [1, 1]; end;
    frameRange(1 : 2) = [max(1, frameRange(1)), min(framesDim(3), frameRange(end))];
    framesDim(3) = diff(frameRange(1 : 2)) + 1;
    
else
    frameRange = [];
    
end;

% create structure with relevant parameters
hashStruct = struct('dataType', dataType, ...
    'nBins', p.nBins, ...
    'framesDim', framesDim, ...
    'frameRange', frameRange, ...
    'frameRate', frameRate, ...
    'cropRect', p.cropRect, ...
    'imRotationAngle', p.imRotationAngle, ...
    'BLCorrMethod', p.BLCorrMethod, ...
    'BLCorrParam', p.BLCorrParam, ...
    'stimFreq', p.stimFreq, ...
    'stimFreqInterval', p.stimFreqInterval, ...
    'powerMapFilt', p.powerMapFilt, ...
    'phaseMapFilt', p.phaseMapFilt, ...
    'powerMapThresh', p.powerMapThresh, ...
    'phaseShift', p.phaseShift, ...
    'evokedFrames', p.evokedFrames, ...
    'baseFrames', p.baseFrames ...
);

% remove all params if requested
if exist('exclParamIDs', 'var') && ~isempty(exclParamIDs) && ischar(exclParamIDs) && strcmp(exclParamIDs, '_none_');
   hashStruct = struct('dataType', dataType);
end;

% add file IDs
IDs = fieldnames(fileIDStruct);
for iID = 1 : numel(IDs);
    hashStruct.(IDs{iID}) = fileIDStruct.(IDs{iID});
end; 

% remove unwanted IDs
if exist('exclParamIDs', 'var') && ~isempty(exclParamIDs);
    
    % cell-array of strings with IDs
    if iscellstr(exclParamIDs);
        hashStruct = rmfield(hashStruct, exclParamIDs);
        
    % regexp exclude
    elseif ischar(exclParamIDs);
        IDs = fieldnames(hashStruct);
        for iID = 1 : numel(IDs);
            ID = IDs{iID};
            if ~isempty(regexp(ID, exclParamIDs, 'once'));
                hashStruct = rmfield(hashStruct, ID);
            end;
        end;
        
    end;
end;

% append the input structure to the hash structure
if exist('addParamsStruct', 'var') && ~isempty(addParamsStruct);
    IDs = fieldnames(addParamsStruct);
    for iID = 1 : numel(IDs);
        hashStruct.(IDs{iID}) = addParamsStruct.(IDs{iID});
    end;
end;

end
