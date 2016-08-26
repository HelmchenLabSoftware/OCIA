%% #OCIA_dataWatcherProcess_saveResults
function OCIA_dataWatcherProcess_saveResults(this, ~, ~)

% get imaging rows
% imgRows = DWFindTableRows(this, 'imgData', '', '', '', '', '', '');
imgRows = this.dw.selectedTableRows;

% loop trough all rows
for iRow = 1 : numel(imgRows);
    
    % get the run ID
    rowID = sprintf('%s__%s', this.dw.table{imgRows(iRow), 2 : 3});
%     rowIDWithUnderScoreX = sprintf('%s_X%s', rowID, this.dw.table{imgRows(iRow), 9});
    
    % get the path for this row and modify it
    fullFolderPath = DWGetFullPath(this, imgRows(iRow));
    targetDir = regexprep(fullFolderPath, '/$', sprintf('/%sh_MF/', rowID));
    
    % get the ROISet for this row
    ROISet = ANGetROISetForRow(this, imgRows(iRow));
    
    % get the data for this row
    caData = this.data.img.caTraces{imgRows(iRow)};
    
    % if there is some data
    if ~isempty(caData) && ~isempty(ROISet);
    
        % create the structure
        Ca = struct();
        Ca.roiLabel = ROISet(:, 1);
    
        % create the directory if needed
        if exist(targetDir, 'dir') ~= 7; mkdir(targetDir); end;
    
        % load the calcium data in the right format
        Ca.dRR = cell(numel(Ca.roiLabel), 1);
        for iROI = 1 : numel(Ca.roiLabel);
            Ca.dRR{iROI, 1} = repmat(caData(iROI, :), 2, 1);
        end;

        % save the data
        save(sprintf('%somlortest_%s.mat', targetDir, rowID), 'Ca');
        
        % copy the other files
        clickJointFolder = regexprep(targetDir, '_MF/$', '_ClickJoint/');
        clickJointFile = sprintf('%sMotor_Output_Parameters_%sh_Raw', clickJointFolder, this.dw.table{imgRows(iRow), 3});
        if exist(clickJointFolder, 'dir') && exist(clickJointFile, 'file');
            
            clickJointFileTarget = regexprep(clickJointFile, '_ClickJoint/', '_MF/');
            copyfile(clickJointFile, clickJointFileTarget);
            
            FID1 = fopen(clickJointFileTarget);
            FMOPs = textscan(FID1, '%f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %*[^\n]', ...
                'Delimiter', '\t', 'HeaderLines', 1);
            fclose(FID1);
            FMOPs = cell2mat(FMOPs);
            xlswrite([clickJointFileTarget '.xlsx'], FMOPs);
            
            delete(clickJointFileTarget);
        end;
        
        % csv file
        csvFileName = dir([fullFolderPath '*.csv']);
        if ~isempty(csvFileName);
            csvFileSource = [fullFolderPath csvFileName.name];
            csvFileTarget = [targetDir csvFileName.name];
            copyfile(csvFileSource, csvFileTarget);
            
            FID2 = fopen(csvFileTarget);
            MVs = textscan(FID2, '%f %f %*[^\n]', 'Delimiter', ';');
            fclose(FID2);
            MVs = cell2mat(MVs);
            xlswrite(strrep(csvFileTarget, '.csv', '.xlsx'), MVs);
            
            delete(csvFileTarget);
        end;
    end;
    
end;


o('#OCIA_dataWatcherProcess_saveResults(): saving results done.', 2, this.verb);

end
