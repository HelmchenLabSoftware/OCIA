classdef CaImgExperiment < Experiment
    % CaImgExperiment, subclass of Experiment
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % Originally created on               2013-03-18 %
    % Written by B. Laurenczy (blaurenczy@gmail.com) %
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
    %% properties
    properties

        % cell array of 'Spot'-class objects, representing the spot (imaging area) recorded in this
        % experiment. Each Spot contains its own stimulation
        spots
        % current count of spots, also used as the currently used spot's index
        nSpots
        % indicator: 'OGB', 'YCN140', etc.
        indicator
        % use or not the TDT
        noTDT = 1
        
        debugMode = 0
        
    end % properties
    
   
    %% methods
    methods
        
        %% constructor
        % dateStr and title are optional
        function CaImgExp = CaImgExperiment(indicator, varargin)
            
            % call superclass's constructor
            CaImgExp = CaImgExp@Experiment(varargin{:});
            
            CaImgExp.indicator = indicator;
            CaImgExp.spots = {};
            CaImgExp.nSpots = 0; % no spots at the begining
            
            fprintf('  - Created new CaImg experiment on %s with animal %s (lic. %s)\n', ...
                CaImgExp.dateStr, CaImgExp.animal.id, CaImgExp.license);
            
        end % constructor
        
        %% newSpot
        % function that adds a new spot to the experiment. The new spot becomes the current spot.
        function CaImgExp = newSpot(CaImgExp, spot)
            
            if ~isa(spot, 'Spot');
                fprintf('/!\\ ERROR: spot given as input is not of class ''Spot''!\n');
                return;
            end;
            
            % increment the number of spots
            CaImgExp.nSpots = CaImgExp.nSpots + 1;
            
            % create the spot's id, which will look like :
            % '2012_11_21.mou_bl_2012_11_21_01.spot01'
            spot.id = sprintf('%s.%s.spot%02d', CaImgExp.dateStr, CaImgExp.animal.id, CaImgExp.nSpots);
            
            % add the new spot to the list
            CaImgExp.spots{CaImgExp.nSpots} = spot;
            
            fprintf('  - Added new spot: %s, at depth: %d\n', CaImgExp.spots{CaImgExp.nSpots}.id, ...
                CaImgExp.spots{CaImgExp.nSpots}.depth);
            
        end % newSpot
        
        
        %% loadEphyData
        function CaImgExp = loadEphysData(CaImgExp, varargin)
        % use '*' character to load all spots
            
            %% parse inputs
            IP = inputParser;
            addOptional(IP, 'iSpot',            '*',    @(x) isnumeric(x) || strcmp(x, '*'));
            addOptional(IP, 'stimTypeToLoad',   '*',    @ischar);
            addOptional(IP, 'stimProbaToLoad',  -1,     @isnumeric);
            addOptional(IP, 'stimStartIndex',   1,      @isnumeric);
            addOptional(IP, 'stimEndIndex',     -1,     @isnumeric);
            parse(IP, varargin{:});
            % copy out the variable...
            iSpot = IP.Results.iSpot;
            stimTypeToLoad = IP.Results.stimTypeToLoad;
            stimProbaToLoad = IP.Results.stimProbaToLoad;
            stimStartIndex = IP.Results.stimStartIndex;
            stimEndIndex = IP.Results.stimEndIndex;
            
            % if all spots loading requested, load all with given inputs
            if strcmp(iSpot, '*');
                for i = 1:size(CaImgExp.spots, 2);
                    CaImgExp = CaImgExp.loadEphysData(i, stimTypeToLoad, stimProbaToLoad, ...
                        stimStartIndex, stimEndIndex);
                end;
                return;
            end;
            
            fprintf('  - Loading spot %d...\n', iSpot);
            
            if iSpot > size(CaImgExp.spots, 2);
                error('There is only %d spot(s) and spot no %d was requested!', ...
                    size(CaImgExp.spots, 2), iSpot);
            end;
            
            % load all by default
            if stimEndIndex == -1; stimEndIndex = size(CaImgExp.spots{iSpot}.stims, 2); end;
            
            tic; % measure the time taken to load the ephys
            % go through all stimulations and for the ones that match the requested stimulation type (or
            % all of them if stimTypeToLoad is empty or '*'), load the ephy data from the Igor file
            for i = 1 : size(CaImgExp.spots{iSpot}.stims, 2);
                
                % do not reload the data if it's already there : 
                if size(CaImgExp.spots{iSpot}.ephys, 2) >= i && ... % size of ephys is big enoug
                        size(CaImgExp.spots{iSpot}.ephys{i}, 1) > 1; % ephys is not empty nor -1
%                     fprintf('    - Skipping stim %d as it''s already loaded.\n', i);
                    continue;
                end;
                
                % do not load the data if it's not in the required range
                if i < stimStartIndex || i > stimEndIndex;
                    CaImgExp.spots{iSpot}.ephys{i} = -1;
                    continue;
                end;
                
                stim = CaImgExp.spots{iSpot}.stims{i};
                
                % gets the 'n1Odd10F2_5' stim name
                stimName = CaImgExp.getStimName(iSpot, i);
                
                % extracts the 'Odd' from 'n1Odd10F2_5'
                stimShortType = regexprep(stimName, 'n\d+([^\d_]+).+', '$1');
        
                % if a specific stimulation type is requested for loading (stimTypeToLoad not '*' or empty,
                % and if the requested type doesn't match the type of this stimulation, go to next
                if ~strcmp(stimTypeToLoad, '*') && ~strcmp(stimTypeToLoad, '') && ...
                        ~strcmp(stimShortType, stimTypeToLoad);
%                      fprintf('    - Skipping stim %d as it''s type is "%s"...\n', i, stimShortType);
                    CaImgExp.spots{iSpot}.caRawData{i} = -1;
                    continue;
                end;
                
                % if a specific stimulation probability is requested for loading (stimProbaToLoad not -1)
                % and if the requested proba doesn't match the proba of this stimulation, go to next
                if stimProbaToLoad ~= -1 && stimProbaToLoad ~= stim.proba;
%                     fprintf('    - Skipping stim %d as it''s proba is %d%%...\n', i, stim.proba);
                    CaImgExp.spots{iSpot}.caRawData{i} = -1;
                    continue;
                end;
                
                % standardize the path, use only slash and no backslashes
                CaImgExp.basePath = regexprep(CaImgExp.basePath, '\\', '/');
                
                % check for the presence of a slash at the end of the base path
                if  ~size(regexp(CaImgExp.basePath, '\/$'), 1);
                    CaImgExp.basePath = [CaImgExp.basePath '/'];
                end;
                
%                 % choose the right file name depending on the stimulation type and parameters
%                 igorFilesBaseName = sprintf('%s%sSoma', CaImgExp.basePath, stimName);
%                 if igorFilesBaseName == -1; % if something went wrong in finding the name, skip this
% %                     fprintf('    - Skipping stim %d as no name was found (%d)...\n', i, igorFilesBaseName);
%                     CaImgExp.spots{iSpot}.caRawData{i} = -1;
%                     continue;
%                 end;
%                 
%                 ephysConversion = 4.85; % convert to mV./ephysConversion;
%                 fprintf('    - Reading "%s"...\n', igorFilesBaseName);
%                 
%                 % try to load the ephys from the Igor file
%                 warning('off', 'ReadIgorDatFile:FileNotFound');
%                 loadedEphys = ReadIgorDatFile(igorFilesBaseName);
%                 
%                 % if no data was loaded, show warning
%                 if loadedEphys == -1;
%                     warning('CaImgExperiment:loadEphyData:IgorFileNotFound', ...
%                         ['No Igor file at "%s". Consider changing the base path of the ' ...
%                         'CaImgExperiment to the folder where your raw data ' ...
%                         'is stored (for example, use ''CaImgExp.basePath = cd;''). Currently, ' ...
%                         'CaImgExp.basePath = "%s".'], igorFilesBaseName, CaImgExp.basePath);
%                     continue;
%                 end;
%                 
%                 % if data was sucessufully loaded, normalise it
%                 CaImgExp.spots{iSpot}.ephys{i} = loadedEphys ./ ephysConversion;
                
            end;
            
            fprintf('  - Loaded caRawData data. (%.3f sec)\n', toc);
            
        end % loadEphyData
        
        %% changeSpot
        function CaImgExp = changeSpot(CaImgExp, iSpot)
            CaImgExp.nSpots = iSpot;
        end % changeSpot
        
        %% getStimName
        function stimName = getStimName(CaImgExp, iSpot, iStim)
            
            stim = CaImgExp.spots{iSpot}.stims{iStim};
            neurBF = CaImgExp.spots{iSpot}.BFreqIndex;
            stimName = -1;
            % choose the right name depending on the stimulation type and parameters
            switch(stim.stimType)
                case 'BF' % best frequency characterization
                    stimName = sprintf('n%dBF_%d', iSpot, iStim);
                case 'SSA_DEV' % CaImg with a deviant frequency
                    stimName = sprintf('n%dOdd%dF%d_%d', ...
                        iSpot, stim.proba, 1.5 - (stim.swap / 2), iStim);
                case 'SSA_OMI' % CaImg with an omission as deviant or deviant alone control
                    if stim.swap == 1; % deviant alone control
                        if stim.BFreqIndex == neurBF + 1;
                            stimName = sprintf('n%dDevAl%dF1_%d', iSpot, stim.proba, iStim);
                        elseif  stim.BFreqIndex == neurBF - 1;
                            stimName = sprintf('n%dDevAl%dF2_%d', iSpot, stim.proba, iStim);
                        else
                            warning('CaImgExperiment:getStimName:BadDevAl', ...
                                ['Found a deviant alone control which was done ' ...
                                'with the BF... (neur %d, run %d)\n            spot''s BF: %d, ' ...
                                'stimulation''s BF: %d.'], iSpot, iStim, stim.BFreqIndex, neurBF);
                        end
                    elseif stim.swap == -1; % omission paradigm
                        stimName = sprintf('n%dOmi%d_%d', iSpot, stim.proba, iStim);
                    end;
                otherwise;
                    warning('CaImgExperiment:getStimName:UnknownStimType', ...
                        'unknown stimType: %s', stim.stimType);
            end;
            
        end % getStimName
        
        %% saveAllWithOptions
        function saveAllWithOptions(CaImgExp, varargin)
            
            % check if a backup name was provided
            IP = inputParser;
            
            % save original ephys
            addRequired(IP, 'saveRawData',                      @isnumeric);
%             % save ephysNoAP, corrected ephys
%             addRequired(IP, 'savePreProcEphys',                 @isnumeric);
%             % save spike times
%             addRequired(IP, 'savePreProcSpikeTimes',            @isnumeric);
            % save analysis results and params
            addRequired(IP, 'saveAnalysis',                     @isnumeric);
            % name that will be appended to the saved mat-file's name
            addOptional(IP, 'saveName',             '',         @ischar);
            % path where the file should be saved, default is the experiment's basepath
            addOptional(IP, 'savePath', CaImgExp.basePath,    @(p) ischar(p) && exist(p, 'dir'));
            
            parse(IP, varargin{:});
            in = IP.Results;
            
            for iSpot = 1:size(CaImgExp.spots, 2);
                % discard original ephys if saving of raw data is not requested
                if ~in.saveRawData;
                    CaImgExp.spots{iSpot}.ephys = [];
                end;
%                 % discard ephysNoAP, corrected ephys if saving of pre-processed ephys data is not requested
%                 if ~in.savePreProcEphys;
%                     CaImgExp.spots{iSpot}.preProc.ephys = {};
%                     CaImgExp.spots{iSpot}.preProc.ephysNoAP = {};
%                 end;
%                 % discard spike times if saving of pre-processed ephys data is not requested
%                 if ~in.savePreProcSpikeTimes;
%                     CaImgExp.spots{iSpot}.preProc.spikeTimes = {};
%                 end;
                % discard analysis results and params if saving of analysis is not requested
                if ~in.saveAnalysis;
                    CaImgExp.spots{iSpot}.analysis = {};
                    CaImgExp.spots{iSpot}.analysisParams = {};
                end;
            end;
            
            CaImgExp.saveAll(in.saveName, in.savePath);
            
        end; % saveAllWithOptions
        
        %% saveAndCloseFigures
        function saveAndCloseFigures(CaImgExp, saveAsPNG, doCalcTime)
            
            if doCalcTime; plotSave_time = tic; end;
            while numel(findobj) > 1;
                saveName = strrep([CaImgExp.outputPath get(gcf, 'Name')], ' ', '');
                fprintf('  - Saving figure as "%s"\n', saveName);
                % if output folder does not exists, create it
                if ~exist(CaImgExp.outputPath, 'dir');
                    mkdir(CaImgExp.outputPath);
                    if saveAsPNG; % if PNG also requested, create it too !
                        mkdir(strrep(CaImgExp.outputPath, 'fig/', 'png/'));
                    end;
                end;
                saveas(gcf, saveName);
                if saveAsPNG;
                    saveName = strrep(saveName, 'fig/', 'png/');
                    fprintf('    - Also saving as ''%s.png''\n', saveName);
                    saveas(gcf, saveName, 'png');
                end;
                close(gcf);
            end;
            if doCalcTime; fprintf('        ** plotSave_time: (%.3f sec)\n', toc(plotSave_time)); end;
        end % saveAndCloseFigures
        
    end % methods
   
end % classdef
