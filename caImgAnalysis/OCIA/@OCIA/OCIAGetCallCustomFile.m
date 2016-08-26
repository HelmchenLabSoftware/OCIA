function [funcHandle, argsOut] = OCIAGetCallCustomFile(this, rootName, fileName, doCallFunction, argsIn, useDefaultIfNotFound)
% OCIAGetCallCustomFile - Call a custom functions related to the OCIA
%
%       [funcHandle, argsOut] = OCIAGetCallCustomFile(this, rootName, fileName, doCallFunction, argsIn, useDefaultIfNotFound)
%
% Returns the handle of the custom function "OCIA_[rootName]_[fileName].m". Both 'rootName' and 'fileName' must be
%   specified as strings. If 'doCallFunction' (logical) is set to true, the custom function is called with the
%   input arguments 'argsIn' (cell-array). The outpus of the call are returned in 'argsOut' (cell-array or single
%   value if only one output argument). If 'useDefaultIfNotFound' (logical) is set to true, the default custom
%   function "OCIA_[rootName]_default.m" is used.

% 2013-2016 - Copyleft and programmed by Balazs Laurenczy (blaurenczy_at_gmail.com)

% get the file's name
funcName = sprintf('OCIA_%s_%s', rootName, fileName);
% create the error message's ID
errorMessageID = sprintf('OCIA:%sFunctionNotFound', rootName);

% by default, return nothing
argsOut = {};
funcHandle = [];

% if the file cannot be found
if ~exist(funcName, 'file');
    % if the default function should be used
    if useDefaultIfNotFound;
        % display a warning message
        showWarning(this, errorMessageID, sprintf('"%s" function "%s" not found ("%s"), using default.', ...
            rootName, fileName, funcName));
        % get the default file's name
        fileName = 'default';
        funcName = sprintf('OCIA_%s_%s', rootName, fileName);
    end;
        
    % if the default file should not be used or cannot be found
    if ~useDefaultIfNotFound || ~exist(funcName, 'file');
        % display a warning message and abort
        showWarning(this, errorMessageID, sprintf('"%s" function "%s" not found ("%s"), aborting.', ...
            rootName, fileName, funcName));
        return;
    end;
end;

% get the function's handle
funcHandle = str2func(funcName);

% if the function needs to be called, try to call it
if doCallFunction;
    
    % create the error message's ID
    errorMessageID = sprintf('OCIA:%sExecutionError', rootName);
    
    try
        
        nArgsOut = nargout(funcName);
        % if the function has not outputs, simply call it
        if nArgsOut == 0;
            funcHandle(argsIn{:}); %#ok<NOEFF>
            
        % if only one output, store it in argsOut
        elseif nArgsOut == 1;
                argsOut = funcHandle(argsIn{:});
                
        % if multiple outputs, store them in a cell-array
        else
            % get the comma-separated list of output arguments as a string: 'argOut_1, argOut_2, ...'
            argsOutString = regexprep(cell2mat(arrayfun(@(iArg) sprintf('argOut_%d, ', iArg), 1 : nArgsOut, ...
                'UniformOutput', false)), ', $', '');
            % call the function and get the outputs
            eval(sprintf('[%s] = funcHandle(argsIn{:});', argsOutString));
            % store the outputs in the argsOut cell array
            eval(sprintf('argsOut = { %s };', argsOutString));
            
        end;
        
    % if an error was thrown, capture it and show a warning message
    catch err;
        
        showWarning(this, errorMessageID, sprintf('"%s" function "%s" ("%s") run into an error: %s (%s)\n%s.', ...
            rootName, fileName, funcName, err.message, err.identifier, getStackText(err)));
    end;
end;

end
