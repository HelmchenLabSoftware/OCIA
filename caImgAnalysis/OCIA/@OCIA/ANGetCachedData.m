function cachedData = ANGetCachedData(this, modeName, hashParamStruct)
% ANGetCachedData - [no description]
%
%       ANGetCachedData(this, modeName, hashParamStruct)
%
% [No description]
%
% 2013-2016 - Copyleft and programmed by Balazs Laurenczy (blaurenczy_at_gmail.com)

% get the "hash" ID of the parameter structure
selectedRowsHashID = [hashParamStruct.dataType, '_', matlab.lang.makeValidName(DataHash(hashParamStruct))];
% store this key as being the last one used
this.an.(modeName).dataHash.lastHashID = selectedRowsHashID;
% by default, return nothing meaning that there is nothing in cache
cachedData = [];

%% direct find
% if the data is already in memory, just fetch it
if isfield(this.an.(modeName).dataHash, selectedRowsHashID);
    cachedData = this.an.(modeName).dataHash.(selectedRowsHashID);
    return;
end;

%{

%% combined search
% try to go through all the hash IDs and try to find a combination of hash contents that would give the requested data
%   when combined together, using the 'iDWRows' (DataWatcher rows indexes) parameter

% if no "iDWRows" field, abort
if ~isfield(hashParamStruct, 'iDWRows'); return; end;

% get all the current stored hash IDs
dataHash = this.an.(modeName).dataHash;
hashIDs = fieldnames(dataHash);
hashIDs(strcmp(hashIDs, 'lastHashID')) = []; % remove the 'lastHashID' field
nHashIDs = numel(hashIDs);

% conviniency variable for "'UniformOutput', false" argument
UF = {'UniformOutput', false};

% if less than 2 hash IDs, no combinations possible so abort
if nHashIDs < 2; return; end;

% get the subfields that need to match
subfieldNames = fieldnames(hashParamStruct);
% remove the 'iDWRows' field since it is the one we try to recombine
subfieldNames(strcmp(subfieldNames, 'iDWRows')) = [];
% get the hash IDs corresponding to the searched data type and parameters
targetHashIDs = {};
% go through each hash
for iHash = 1 : nHashIDs;
    % go through each field
    for iSubField = 1 : numel(subfieldNames);
        % get the value we should find for the current field
        targetValue = hashParamStruct.(subfieldNames{iSubField});
        % if the current hash does not have the current field, abort
        if ~isfield(dataHash.(hashIDs{iHash}).params, subfieldNames{iSubField}); break; end;
        % get the current hash's value for the current field
        hashValue = dataHash.(hashIDs{iHash}).params.(subfieldNames{iSubField});
        % check that the values match
        if      (ischar(targetValue) && ~all(strcmp(targetValue, hashValue))) ... % string field
            ||  (isnumeric(targetValue) && ~all(targetValue(:) == hashValue(:))); % numeric field
            break;
        end;
        
        % if all values matched and we did not break out so far, keep this hash by storing its ID
        if iSubField == numel(subfieldNames);
            targetHashIDs{end + 1} = hashIDs{iHash}; %#ok<AGROW>
        end;
    end;
end;
nTargHashIDs = numel(targetHashIDs);
% if less than 2 target hash IDs found, no combinations possible so abort
if nTargHashIDs < 2 ; return; end;

% get the possible combinations of hash IDs:
% create the inputs for the allcomb function
vars = repmat({regexp(regexprep(sprintf('%d,', 1 : nTargHashIDs), ',$', ''), ',', 'split')}, 1, nTargHashIDs);
% get all possible combinatinos
allCombinationsMat = allcomb(vars{:});
% remove duplicates within a row: [1 1 2] => [1 2]
allCombinations = arrayfun(@(i)unique(allCombinationsMat(i, :), 'stable'), 1 : size(allCombinationsMat, 1), UF{:});
% remove unique number rows : [1] => deleted
allCombinations(cellfun(@(cont)numel(cont) < 2, allCombinations)) = [];
% turn the cell array of cells into a cell array of strings: { '1', '2', '3' } => { '1,2,3,' }
allCombinationsConcat = arrayfun(@(i)sprintf('%s,', allCombinations{i}{:}), 1 : size(allCombinations, 2), UF{:});
% remove duplicated elements
allCombinationsConcat = unique(allCombinationsConcat);
% transform the strings back into indexes
allCombinations = arrayfun(@(i)str2double(regexp(regexprep(allCombinationsConcat{i}, ',$', ''), ',', 'split')), 1 : size(allCombinationsConcat, 2), UF{:});
nCombs = numel(allCombinations);

% get the DW rows for the selected combinations
targetIDWRows = hashParamStruct.iDWRows;
% go through all combinations
for iComb = 1 : nCombs;
    % get the hash IDs of the current combinations
    combHashIDs = targetHashIDs(allCombinations{iComb});
    % get the DW rows for the current combinations
    iDWRowsComb = cell2mat(arrayfun(@(iID)dataHash.(combHashIDs{iID}).params.iDWRows, 1 : numel(combHashIDs), UF{:})');
    % if the DW rows match, return a cell-array with the selected cached data that can be combined together
    if all(iDWRowsComb == targetIDWRows);
        cachedData = arrayfun(@(iID)dataHash.(combHashIDs{iID}), 1 : numel(combHashIDs), UF{:});
        return;
    end;
end;

%}

end