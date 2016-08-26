function ANSaveOutput(this, savePath, varargin)
% ANSaveOutput - [no description]
%
%       ANSaveOutput(this, savePath, varargin)
%
% [No description]
%
% 2013-2016 - Copyleft and programmed by Balazs Laurenczy (blaurenczy_at_gmail.com)

if isempty(savePath);
    if exist(this.path.OCIASave, 'dir') ~= 7; mkdir(this.path.OCIASave); end;
    [saveName, savePath] = uiputfile('*.*', 'Select a path where to save the analysis output', this.path.OCIASave);
    if ischar(saveName)
        savePath = [savePath saveName];
    else % otherwise abort the saving
        return;
    end;
end;

% clean up path and show message
savePath = strrep(savePath, '\', '/');
showMessage(this, sprintf('Saving analyser output to "%s" ...', savePath), 'yellow');

saveTic = tic; % for performance timing purposes
% create a save structure
savedDataStruct = struct();

% get the field names of the analyser
analyserFields = fieldnames(this.an);
% go through them
for iField = 1 : numel(analyserFields);
    % if there is a dataHash field
    if isfield(this.an.(analyserFields{iField}), 'dataHash');
        % get the data hash
        dataHash = this.an.(analyserFields{iField}).dataHash;
        % create a structure to count redundant data types
        dataTypeCounts = struct();
        % get the subfields
        subFields = fieldnames(dataHash);
        for iSubField = 1 : numel(subFields);
            subHash = dataHash.(subFields{iSubField});
            if isstruct(subHash) && isfield(subHash, 'dataType');
                if isfield(dataTypeCounts, subHash.dataType);
                    dataTypeCounts.(subHash.dataType) = dataTypeCounts.(subHash.dataType) + 1;
                else
                    dataTypeCounts.(subHash.dataType) = 1;
                end;
                subHash.hashID = subFields{iSubField};
                dataTypeID = sprintf('%s_%02d', subHash.dataType, dataTypeCounts.(subHash.dataType));
                savedDataStruct.(analyserFields{iField}).(dataTypeID) = subHash;
            end;
        end;
    end;
end;

% make sur that the folder exists
saveFolder = regexprep(savePath, '/[\w\.]+$', '');
if exist(saveFolder, 'dir') ~= 7; mkdir(saveFolder); end;

% save the data
save(savePath, 'savedDataStruct');

showMessage(this, sprintf('Saving analyser output to "%s" done (%.3f sec).', savePath, toc(saveTic)));
    
end
