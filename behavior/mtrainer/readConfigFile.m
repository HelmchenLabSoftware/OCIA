function config = readConfigFile(varargin)

%% Load structure
if nargin
   configFile = varargin{1};
else
    [file,path] = uigetfile({'*.mat'},'Select config file');
    configFile = fullfile(path,file);
end

S = load(configFile);

fieldID = fieldnames(S);

if numel(fieldID) > 1
   warning('Selecting variable %s from file %s',fieldID{1},configFile) 
end
config = S.(fieldID{1});

%% Check structure integrity
requiredFields = { ...
    'sf', ...
    'sf', ...
    };
