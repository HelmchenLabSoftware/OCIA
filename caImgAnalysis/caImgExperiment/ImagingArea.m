classdef ImagingArea
    % ImagingArea object
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % Originally created on               2013-03-19 %
    % Written by B. Laurenczy (blaurenczy@gmail.com) %
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
    %% properties
    properties
        
        % id of the imaging area, composed of the experiment date, the animal id and
        % the imaging area's index in the experiment
        id
        % depth in micrometer at which this imaging area was found
        depth

        % best frequency chosen by the experimenter based on BFTest's graphs
        BFreqIndex = -1
        
        % array of structure objects containing the stimulations inputs and stimuli
        stims
        % cell array containing the calcium data, each cell corresponding to another run
        caData
        % ROI: TO_DEFINE exactly what this should be
        roi
        % structure containing the results of the pre-processing of this imaging area's data, meaning:
        % - TO_DEFINE
        preProc
        % cell array containing the parameters used for the analysis (including pre-processing and analysis)
        analysisParams
        % structure containing the results of the analysis of this imaging area's data, meaning:
        % - TO_DEFINE
        analysis

    end % properties
   
    %% methods
    methods
        
        %% constructor
        function imagingArea = ImagingArea(varargin)
            
            % parse inputs
            IP = inputParser;
            addOptional(IP, 'depth',            -1, @isnumeric);
            
            % extract the arguments from varargin
            parse(IP, varargin{:});

            % transfer the parsed arguments into the 'in' structure
            in = IP.Results;
            
            imagingArea.depth            = in.depth;
            
            if imagingArea.depth == -1;
                imagingArea.depth = input('Depth in micrometer for this imaging area? ');
            end;
            
            % initialize the cell arrays
            imagingArea.stims = {};
            imagingArea.caData = {};
            imagingArea.preProc = struct();
            imagingArea.preProc.done = 0;
            imagingArea.analysis = struct();
            
        end % constructor
   
    end % methods
   
end % classdef
