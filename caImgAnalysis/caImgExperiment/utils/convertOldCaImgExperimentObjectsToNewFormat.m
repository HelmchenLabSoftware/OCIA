%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Converting script                              %
% Originally created on           01 / 01 / 2013 %
% Modified to CaImgExp on         26 / 03 / 2013 %
% Written by B. Laurenczy (blaurenczy@gmail.com) %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
% convert old CaImgExp objects to new form

exps = {}; % experiments found

basePath = 'E:\rawData\AuditoryLearning\';

% go to basePath
cd(basePath);

% get all files and directories in this basePath
dirs = dir;

% check all directories for "yyyy_mm_dd/yyyy_mm_dd_caImg/CaImgExp_yyy_mm_dd.mat" path
for iDir = 1:numel(dirs);
    
    % return to basepath if moved
    cd(basePath);

    % exclude non directories
    if ~dirs(iDir).isdir; continue; end;
    % exclude '.' and '..' directories
    if regexp(dirs(iDir).name, '^\.+$'); continue; end;
    
    % directory name including the "yyy_mm_dd_ephys" folder
    fullDirName = sprintf('%s\\%s_caImg', dirs(iDir).name, dirs(iDir).name);
    
    % check if ephys directory exists
    fprintf('Checking if directory "%s" exists... ', fullDirName);
    if ~exist(fullDirName, 'dir'); fprintf('NO.\n'); continue; end;
    fprintf('YES!\n');
    
    % go to the ephys dir
    cd(fullDirName);
    files = dir;
    
    foundCaImgExp = 0;
    % check all files for being a CaImgExp****.mat file
    for iFile = 1:numel(files);
    
        if regexp(files(iFile).name, '^CaImgExp_\d{4}_\d{2}_\d{2}.mat$');
            foundCaImgExp = 1;
            break;
        end;
        
    end;
    
    % skip if no CaImgExp found
    fprintf('Checking if CaImgExp_yyyy_mm_dd file exists... ');
    if ~foundCaImgExp; fprintf('NO.\n'); continue; end;
    fprintf('YES!\n');
    
    o('  - Found CaImgExp : %s/%s', dirs(iDir).name, files(iFile).name, 0, 0);
    
    % load the .mat file
    load(files(iFile).name);
    o('    - exp of date: %s.', CaImgExp.dateStr, 0, 0);
    
    % back up the spots and recreate them without the pre-allocation
    spotsBackup = CaImgExp.imagingAreas;
    CaImgExp.spots = {};
    % correct/convert all imagingAreas to spots
    for iSpot = 1 : CaImgExp.nImagingAreas;
        
        CaImgExp.spots{iSpot} = Spot(spotsBackup{iSpot}.depth);
        CaImgExp.spots{iSpot}.id = regexprep(spotsBackup{iSpot}.id, 'ImArea', 'sp');
        CaImgExp.spots{iSpot}.stims = spotsBackup{iSpot}.stims;
        
        o('    - spot %s created.', CaImgExp.spots{iSpot}.id, 0, 0);
        
    end;
    
    CaImgExp.nSpots = CaImgExp.nImagingAreas;
    CaImgExp.nImagingAreas = 0;
    CaImgExp.imagingAreas = {};
    
    % set the new path for the experiment
    CaImgExp.basePath = cd;
    
    % save the new mat tagged with 'updated'
    CaImgExp.saveAll('updated');
    
end
