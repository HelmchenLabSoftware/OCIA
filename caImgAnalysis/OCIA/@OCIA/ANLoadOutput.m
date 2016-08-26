function ANLoadOutput(this, loadPath, varargin)
% ANLoadOutput - [no description]
%
%       ANLoadOutput(this, loadPath, varargin)
%
% [No description]
%
% 2013-2016 - Copyleft and programmed by Balazs Laurenczy (blaurenczy_at_gmail.com)

if isempty(loadPath);
    [loadName, loadPath] = uigetfile('*.*', 'Select a path from where to load the analysis output', this.path.OCIASave);
    if ischar(loadName);
        loadPath = [loadPath loadName];
    else % otherwise abort the saving
        return;
    end;
end;

% clean up path and show message
loadPath = strrep(loadPath, '\', '/');
showMessage(this, sprintf('Loading analyser output from "%s" ...', loadPath), 'yellow');

loadTic = tic; % for performance timing purposes
% create a save structure
loadDataStructMat = load(loadPath);
loadDataStruct = loadDataStructMat.savedDataStruct;

% get the field names of the analyser
analyserFields = fieldnames(this.an);
% go through them
for iField = 1 : numel(analyserFields);
    % if there is a dataHash field
    if isfield(loadDataStruct, analyserFields{iField});
        % get the data hash
        dataHash = loadDataStruct.(analyserFields{iField});
        % get the subfields
        subFields = fieldnames(dataHash);
        for iSubField = 1 : numel(subFields);
            subHash = dataHash.(subFields{iSubField});
            hashID = subHash.hashID;
            subHash = rmfield(subHash, 'hashID');
            this.an.(analyserFields{iField}).dataHash.(hashID) = subHash;
        end;
    end;
end;

showMessage(this, sprintf('Loading analyser output to "%s" done (%.3f sec).', loadPath, toc(loadTic)));
    
end
