function BigCellArray = ConcatenateCellArrays(varargin)
% concatenate list of cell array variables in ws into 1 big cell array of
% cell arrays
% who(varargin{1}) should return a list of the desired variables in base
% workspace
% if no input is provided --> GUI selection

% this file written by Henry Luetcke (hluetck@gmail.com)

if ~nargin
    vars = evalin('base','who');
    [var_no status] = listdlg('PromptString','Select variables:',...
        'ListString',vars,'ListSize',[300 400]);
    if status
        for n = 1:length(var_no)
            BigCellArray{n,1} =  evalin('base',vars{var_no(n)});
        end
    else
        return
    end
else
    identStr = varargin{1};
    evalStr = ['who(''',identStr,''')'];
    vars = evalin('base',evalStr);
    for n = 1:length(vars)
        BigCellArray{n,1} =  evalin('base',vars{n});
    end
end


