function [tranformMatrix,newImage] = registerImages_MIRT(refim, im, varargin)
% wrapper for MIRT registration tools
% For the MIRT info visit the project website at
% https://sites.google.com/site/myronenko/research/mirt

% it is safer to add MIRT dynamicaly to the path because the toolbox
% shadows some native ML functions (e.g. nanmean)
% in the end, folders should be removed from path again
% balazsMIRTPath = 'C:\Users\laurenczy\Documents\MIRT';
% balazsMIRTPath = 'P:\matlab\dynamicPath\MIRT\';
% I changed the code so that you can specify config.balazsMIRTPath (line
% 28)

if nargin > 2
    if isstruct(varargin{1});
        config = varargin{1};
    else
        config = getDefaultConfig;
        config.main.single = varargin{1};
        if nargin > 3;
            config.main.saveName = varargin{2};
        end;
    end;
else
    config = getDefaultConfig;
end

% validate config
config2 = getDefaultConfig;
fields = fieldnames(config2);
for n = 1:numel(fields)
    if ~isfield(config,fields{n})
        config.(fields{n}) = config2.(fields{n});
    end
end

if isfield(config, 'balazsMIRTPath')
    addpath(genpath(config.balazsMIRTPath));
else
    folder2add = addMIRT2path('dynamicPath/MIRT');
end

% check if transformation matrix has been provided --> just apply transformation
if isstruct(refim);
    tranformMatrix = refim;
    newImage = mirt2D_transform(im, tranformMatrix);
    if ~isfield(config, 'balazsMIRTPath');
        rmpath(folder2add);
    else
        rmpath(genpath(config.balazsMIRTPath));
    end;
    return
end

% equilibrate brightness ranges for both images
refim = linScale(refim);
im = linScale(im);
try
    [tranformMatrix, newImage] = mirt2D_register(refim,im, config.main, config.optim);
    close(gcf);
    if ~isfield(config, 'balazsMIRTPath');
        rmpath(folder2add);
    else
        rmpath(genpath(config.balazsMIRTPath));
    end;
catch e
    fprintf('Registration failed. Cleaning up path ...\n')
    if ~isfield(config, 'balazsMIRTPath');
        rmpath(folder2add);
    else
        rmpath(genpath(config.balazsMIRTPath));
    end;
    rethrow(e)
end

%% Function - getDefaultConfig
function config = getDefaultConfig
% these are default settings of the most important MIRT parameters
% they may or may not give good results with a particular image
 % Main settings
main.similarity='SSD';  % similarity measure, e.g. SSD, CC, SAD, RC, CD2, MS, MI 
main.subdivide=3;       % use 3 hierarchical levels
main.okno=5;            % mesh window size
main.lambda = 0.005;    % transformation regularization weight, 0 for none
main.single=1;          % show mesh transformation at every iteration
main.saveName = [datestr(now, 'yyyy_mm_dd__HH_MM_SS') '__RegMesh']; % figure save name

% Optimization settings
optim.maxsteps = 200;   % maximum number of iterations at each hierarchical level
optim.fundif = 1e-5;    % tolerance (stopping criterion)
optim.gamma = 1;        % initial optimization step size 
optim.anneal=0.8;       % annealing rate on the optimization step   

config.main = main;
config.optim = optim;

%% Function - addMIRT2path
function folder2add = addMIRT2path(basePath)
% check for env MATLABLOCALPATH
envVarName = 'MATLABLOCALPATH'; % the name of the env var
try
    localPath = getenv(envVarName);
catch e
    error('Failed to load environement variable %s',envVarName)
end
folderList = {basePath};
folderList = strrep(folderList,'\',filesep);
folderList = strrep(folderList,'/',filesep);
folder2add = sprintf('%s%s%s',localPath,filesep,folderList{1});
if ~exist(folder2add,'dir')
    error('\nFolder %s not found.',folder2add)
end
folder2add = genpath(folder2add);
addpath(folder2add);
