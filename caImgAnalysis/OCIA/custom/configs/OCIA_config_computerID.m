function this = OCIA_config_computerID(this)
% OCIA_config_computerID - "computerID" OCIA configuration file
%
%       this = OCIA('computerID')
%
% Configuration file for OCIA using the "computerID" configuration. This function should not be called directly
%   but rather using the "this = OCIA('computerID');" syntax to launch the software with this configuration.
%
% 2013-2016 - Copyleft and programmed by Balazs Laurenczy (blaurenczy_at_gmail.com)

% get computer name
[~, computerID] = system('hostname');
computerID = regexprep(computerID, '\n$', '');

% add compiled tag if necessary
if isdeployed();
    computerID = sprintf('%s_compiled', computerID);
end;

% get the computer's ID
OCIAConfigFileName = sprintf('OCIA_config_%s', computerID);

% check whether the file exists
if ~exist(OCIAConfigFileName, 'file');
    warning('OCIA_config_computerID:ComputerIDNotFound', ...
        'Computer ID "%s" was not found, switching to default.', computerID);
    computerID = 'default';
    OCIAConfigFileName = sprintf('OCIA_config_%s', computerID);
    
    % check whether the file exists
    if ~exist(OCIAConfigFileName, 'file');
        warning('OCIA_config_computerID:ComputerIDNotFound', ...
            'Default config file "%s" was not found, aborting.', OCIAConfigFileName);
        return;
    end;
end;


% get the handle and call the function
OCIAConfigHandle = str2func(OCIAConfigFileName);
this = OCIAConfigHandle(this);

end
