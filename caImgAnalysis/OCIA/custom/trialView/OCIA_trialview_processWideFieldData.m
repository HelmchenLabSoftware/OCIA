function this = OCIA_trialview_processWideFieldData(this)
% OCIA_trialview_processBehaviorMovie - Extracts information about the widefield data
%
%       OCIA_trialview_processBehaviorMovie(this, pad)
%
% [No description]
%
% 2013-2016 - Copyleft and programmed by Balazs Laurenczy (blaurenczy_at_gmail.com)


%% 'reference image
% get files matching the pattern
refImgFiles = dir([ this.tv.params.WFDataPath, 'refImg.mat' ]);
% check number of files found
if numel(refImgFiles) > 0;    
    if numel(refImgFiles) > 1;
        showWarning(this, sprintf('OCIA:%s:MoreThanOneRefImgFile', mfilename()), ...
            sprintf('Found %d reference image files ("refImg.mat"), selecting first one ("%s").', ...
            numel(refImgFiles), refImgFiles(1).name));
        refImgFiles = refImgFiles(1);

    end;
    showMessage(this, sprintf('TrialView: processing "%s" ...', refImgFiles.name), 'yellow');
    % store path
    this.tv.params.refImgFilePath = [this.tv.params.WFDataPath, refImgFiles.name];
    % load file
    refImgMat = load(this.tv.params.refImgFilePath);
    % store refImg data
    this.tv.data.refImg = PseudoFlatfieldCorrect(PseudoFlatfieldCorrect(refImgMat.refImg));
   
% no refImg file found 
else    
    showWarning(this, sprintf('OCIA:%s:RefImgFileNotFound', mfilename()), ...
        'Could not find a reference image file ("refImg.mat").');
    
end;

%% get trials
% get files matching the pattern
wfDataFiles = dir([ this.tv.params.WFDataPath, '*.mat' ]);
wfDataFiles(arrayfun(@(i)isempty(regexp(wfDataFiles(i).name, '(stim|cond)\w+\.mat', 'once')), ...
    1 : numel(wfDataFiles))) = [];
% check number of files found
if numel(wfDataFiles) <= 0;
    showWarning(this, sprintf('OCIA:%s:WFDataNotFound', mfilename()), 'Could not find WF data ("(stim|cond)***.mat").');
    return;
    
end;

% collect the list of wide field data files
fileNames = arrayfun(@(iFile) wfDataFiles(iFile).name, 1 : numel(wfDataFiles), 'UniformOutput', false);
fileNamesToSort = fileNames;
fileNamesToSort = regexprep(fileNamesToSort, '_ave', '_trialx'); % trick to have average display first
% do the condition sorting
condNumbers = regexprep(fileNamesToSort, '^(cond_)?([^_]+)?_.+$', '$2');
uniqueConds = unique(condNumbers);
[~, condNumberInds] = ismember(condNumbers, uniqueConds);
% do the trial sorting (to remove the trial2 > trial20 artifact)
trialNumbers = str2double(regexprep(fileNamesToSort, '.+trial(\d+).+', '$1'));
[~, fileNamesSortInd] = sort(condNumberInds * 10000 + trialNumbers);
fileNames = fileNames(fileNamesSortInd);

% store names and display in GUI
this.tv.params.fileList = fileNames(1);
this.GUI.tv.paramPanConfig{'fileList', 'valueType'} = { fileNames };

% load first file
OCIA_trialview_loadWideFieldData(this);

end
