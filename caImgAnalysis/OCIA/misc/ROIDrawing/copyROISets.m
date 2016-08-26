function copyROISets
% copy ROI sets

allTic = tic; % for performance timing purposes
o('#copyROISets: timestamp: %s', datestr(now), 0, 0);

...%                   1                   2                    3                    4
animalsIDs = { 'mou_bl_140109_01', 'mou_bl_140109_02' , 'mou_bl_140110_01', 'mou_bl_140110_02' };

...%              1             2               3           4             5               6           7
dayIDs = {  '2014_02_03', '2014_02_04', '2014_02_06', '2014_02_07', '2014_02_08', '2014_02_09', '2014_02_10', ...
...%              8             9               10          11            12              13          14
            '2014_02_11', '2014_02_12', '2014_02_13', '2014_02_14', '2014_02_15', '2014_02_16', '2014_02_17', ...
...%              15            16              17          18            19              20          21
            '2014_02_18', '2014_02_19', '2014_02_20', '2014_02_21', '2014_02_22', '2014_02_23', '2014_02_24', ...
...%              22            23              24
            '2014_02_25', '2014_02_26', '2014_03_03' };

%{
% H30 => server
localPath = 'C:/Users/laurenczy/Documents/LabVIEW Data/2014_chronic/';
distantPath = 'W:/Scratch-02 no Backup/RawDataBalazs/2014_chronic/1402_chronic/';
%}

%{
% server => H30
distantPath = 'C:/Users/laurenczy/Documents/LabVIEW Data/2014_chronic/';
localPath = 'W:/Scratch-02 no Backup/RawDataBalazs/2014_chronic/1402_chronic/';
%}

%{
% server => H64
distantPath = 'F:/RawData/';
localPath = 'W:/Scratch-02 no Backup/RawDataBalazs/2014_chronic/1402_chronic/';
%}

%{
% H64 => server
localPath = 'F:/RawData/';
distantPath = 'W:/Scratch-02 no Backup/RawDataBalazs/2014_chronic/1402_chronic/';
%}

%{
% H64 => NAS
localPath = 'F:/RawData/';
distantPath = 'Z:/RawData/Balazs_Laurenczy/2014/2014_chronic/1402_chronic/';
%}

o('#copyROISets: localPath: "%s"', localPath, 0, 0);
o('#copyROISets: distantPath: "%s"', distantPath, 0, 0);

sStr = repmat(' ', 1, 67);

copiedROISets = 0;
replacedROISets = 0;

nAnimals = numel(animalsIDs);
o(repmat('*', 1, 170), 0, 0);
for iAnimal = 1 : nAnimals;
    animalID = animalsIDs{iAnimal};
    nDays = numel(dayIDs);
    o(repmat('-', 1, 170), 0, 0);
    for iDay = 1 : nDays;
        dayID = dayIDs{iDay};
        localROISetsDirPath = sprintf('%s%s/%s/ROISets/', localPath, animalID, dayID);
        distantROISetDirPath = regexprep(localROISetsDirPath, localPath, distantPath);
        
        % check distant
        distFiles = dir(distantROISetDirPath);
        distROISets = {};
        if ~isempty(distFiles);
            distFiles(1 : 2) = []; % remove '.' and '..';
            for iFile = 1 : numel(distFiles);
                if isempty(regexp(distFiles(iFile).name, 'ROISet_[\d_]+h.mat', 'once')); continue; end;
                distROISets{end + 1} = sprintf('%s%s', distantROISetDirPath, distFiles(iFile).name); %#ok<AGROW>
                o('Found distant ROISet: %s"%s" ...', sStr, regexprep(distROISets{end}, distantPath, '$DIST/'), 0, 0);
            end;
        end;
        
        % check local
        localFiles = dir(localROISetsDirPath);
        if isempty(localFiles); continue; end;
        localFiles(1 : 2) = []; % remove '.' and '..';
        for iFile = 1 : numel(localFiles);
            if isempty(regexp(localFiles(iFile).name, 'ROISet_[\d_]+h.mat', 'once')); continue; end;
            localROISetPath = sprintf('%s%s', localROISetsDirPath, localFiles(iFile).name);
            distantROISetPath = regexprep(localROISetPath, localPath, distantPath);
            o('Copying "%s" to "%s" ...', regexprep(localROISetPath, localPath, '$LOCAL/'), ...
                regexprep(distantROISetPath, distantPath, '$DIST/'), 0, 0);
            if exist(distantROISetPath, 'file');
                delete(distantROISetPath);
                replacedROISets = replacedROISets + 1;
            else
                copiedROISets = copiedROISets + 1;
            end;
            if exist(distantROISetDirPath, 'dir') ~= 7; mkdir(distantROISetDirPath); end;
            copyfile(localROISetPath, distantROISetPath);
        end;
        o(repmat('-', 1, 170), 0, 0);
    end;
    o(repmat('*', 1, 170), 0, 0);
end;
o('#copyROISets: done (copied: %d, replaced: %d, %.0f seconds).', copiedROISets, replacedROISets, toc(allTic), 0, 0);

end