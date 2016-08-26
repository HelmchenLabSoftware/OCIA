function SaveAndAssignInBase(varargin)
% save variable in1 as in2.mat and assign in base workspace as in2
% optional command argument: 'SaveOnly', 'AssignOnly' or 'both' (default)
var_name = varargin{1};
save_string = varargin{2};
[path,name,ext] = fileparts(save_string);
if ~isempty(path) || ~isempty(ext)
    save_string = name;
end
% make sure this is a valid variable name
if ~isvarname(save_string)
   save_string_var = genvarname(save_string);
else
    save_string_var = save_string;
end
todo = 1;
if nargin == 3
    switch lower(varargin{3})
        case 'saveonly'
            todo = 3;
        case 'assignonly'
            todo = 2;
    end
end
struct_name = save_string_var;
if todo == 1 || todo == 2
    assignin('base',struct_name,var_name);
end
if todo == 1 || todo == 3
    if isempty(path)
       path = pwd;
    end
    savename = fullfile(path,[save_string '.mat']);
    evalc([struct_name ' = var_name']);
    save(savename,struct_name);
end

