classdef Experiment

    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % Originally created on           20 / 11 / 2012 %
    % Written by B. Laurenczy (blaurenczy@gmail.com) %
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
    %% properties
    properties
        
        % the date in the yyyy_mm_dd format at which this experiment is done
        dateStr
        % the animal on which this experiment is done ('Animal'-class)
        animal
        % the license in which this experiment is
        license
        % the room where this experiment is done
        room
        % a short description of this expriment
        descr
        % some additional optional remarks about this experiment
        remarks
        % the base path where all data for this experiment are stored
        basePath
        % the path where all figures and analysis outputs are to be saved. By default, same as basePath
        outputPath
        
    end % properties

    %% methods
    methods
        
        %% constructor
        function experiment = Experiment(varargin)
            
            % parse inputs
            IP = inputParser;
            addRequired(IP, 'license',      @ischar);
            addRequired(IP, 'room',         @ischar);
            addRequired(IP, 'animal',       @(a) isa(a, 'Animal'));
            addRequired(IP, 'basePath',     @(p) ischar(p) && exist(p, 'dir'));
            addOptional(IP, 'descr',    '', @ischar);
            addOptional(IP, 'dateStr',  datestr(date, 'yyyy_mm_dd'), ...
                                            @(d) ischar(d) || isnumeric(d));
            addOptional(IP, 'remarks',  '', @ischar);
            addOptional(IP, 'outputPath','NOT_SPECIFIED', ...
                                            @(p) ischar(p) && exist(p, 'dir'));
            
            % extract the arguments from varargin
            parse(IP, varargin{:});
            % transfer the parsed arguments into the 'in' structure
            in = IP.Results;
            
            experiment.license  = in.license;
            experiment.room     = in.room;
            experiment.animal   = in.animal;
            experiment.descr    = in.descr;
            experiment.dateStr  = in.dateStr;
            experiment.remarks  = in.remarks;
            experiment.basePath = in.basePath;
            experiment.outputPath = in.outputPath;
            
            % set output path to basePath if not specified
            if strcmp(experiment.outputPath, 'NOT_SPECIFIED');
                experiment.outputPath = experiment.basePath;
            end;
            
        end % constructor
       
        %% saveAll
        % saves the whole experiment, includind the ephys if they are loaded
        function saveAll(experiment, varargin)
            
            % check if a backup name was provided
            IP = inputParser;
            
            % name that will be appended to the saved mat-file's name
            addOptional(IP, 'saveName', '', @ischar);
            % path where the file should be saved, default is the experiment's basepath
            addOptional(IP, 'savePath', experiment.basePath, @(p) ischar(p) && exist(p, 'dir'));
            parse(IP, varargin{:});
            
            % create the backup name if requested
            if IP.Results.saveName;
                saveName = [IP.Results.saveName '_'];
                fprintf('  - Saving experiment using "%s" ... ', IP.Results.saveName);
            else
                saveName = '';
                fprintf('  - Saving experiment... ');
            end;
            
            % create the name of the variable that will be stored
            name = 'experiment';
            if isa(experiment, 'SSAExperiment');
                eval('SSAExp = experiment;'); % avoids the 'SSAExp might be unused' warning
                name = 'SSAExp';
            elseif isa(experiment, 'CaImgExperiment');
                eval('CaImgExp = experiment;'); % avoids the 'SSAExp might be unused' warning
                name = 'CaImgExp';
            end;
            
            % save the current directory
            currentDir = cd;
            cd(IP.Results.savePath);
            
            tic; % save the file and measure the time it takes
            save([name '_' saveName experiment.dateStr '.mat'], name);
            fprintf('done. (%.3f sec)\n', toc);
            
            % return to the previous directory
            cd(currentDir);
           
       end % saveAll
       
        %% addRemark
        function experiment = addRemark(experiment, remark)
            
            experiment.remarks{end + 1} = remark;
            
       end % addRemark
       
       
        %% checkAbort
        function abort = checkAbort(experiment, text)
            
            abort = 0; % by default, no abort
            
            % stop point, check if everything ok and allow experimenter to exit
            % gracefully the experiment
            userInput = input([text ' ([a] = abort; [as] = abort and save): '], 's');
            % 'as' means experiment should be aborted and saved
            if strcmp(userInput, 'as');
                fprintf('Aborting and saving experiment.\n');
                experiment.saveAll('backup_abort'); % save a backup of the aborted experiment
                abort = 1;
            % 'a' means experiment should be aborted (and not saved)
            elseif strcmp(userInput, 'a');
                fprintf('Aborting experiment.\n');
                abort = 1;
            end;
            
       end % checkAbort
       
        %% checkSkip
        function skip = checkSkip(~, stepName)
            
            skip = -1;
            
            % check if next step of experiment should be skipped or not
            while skip < 0 || skip > 1;
                skip = str2double(input(sprintf('Press 0 to skip %s, or 1 to do it: ', stepName), 's'));
            end;
            if isnan(skip); skip = true; end;
       end % checkSkip
       

    end % methods

end % classdef
