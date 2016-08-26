function stimIDs = OCIA_analysis_renameStimIDs(stimIDs)

% rename stimulus IDs if possible
stimIDs = regexprep(stimIDs, 'targ resp', 'hit');
stimIDs = regexprep(stimIDs, 'targ noResp', 'miss');
stimIDs = regexprep(stimIDs, 'distr resp', 'falseAlarm');
stimIDs = regexprep(stimIDs, 'distr noResp', 'corrRej');

stimIDs = regexprep(stimIDs, ' all', '');
stimIDs = regexprep(stimIDs, ' on', '-on');
stimIDs = regexprep(stimIDs, ' off', '-off');

end