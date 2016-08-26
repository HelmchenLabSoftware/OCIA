function varargout = getGlobalParameters(varargin)
% retrieve the value (as string) in varargout for each of the (string)
% key words in varargin
% creates the file .config in matlabroot\work if it does not exist
% if the key word is not found, offers to write it into the file with
% user-specified value

% License: nobody is allowed to use this file

% this file written by Henry Luetcke (hluetck@gmail.com)

% current version: 2009-12-10

config_file = fullfile(matlabroot,'work','.config');
success = 1;
if exist(config_file,'file') ~= 2
    button = questdlg('Would you like to create it?',...
        'Global config file not found','Sure','No way','Sure');
    switch button
        case 'Sure'
            try
                fid = fopen(config_file,'w');
                fclose(fid);
            catch
                fprintf('\nFailed to create global config file!\n');
                success = 0;
            end
        otherwise
            success = 0;
    end
end
if ~success
    varargout{1} = 0;
    return
end

fid = fopen(config_file);
C = textscan(fid,'%s %s','commentStyle','%','Delimiter','\t');
fclose(fid);
config.key = C{1};
config.par = C{2};

for n = 1:length(varargin)
    current_key = varargin{n};
    if sum(strcmp(config.key,current_key))
        varargout{n} = cell2mat(config.par(strcmp(config.key,current_key)));
    else
        title_str = sprintf('Key %s not found',current_key);
        button = questdlg('Would you like to add it?',...
            title_str,'Sure','No way','Sure');
        switch button
            case 'Sure'
                prompt = sprintf('Enter value for key %s',current_key);
                answer = inputdlg(prompt,'Provide parameter value');
                varargout{n} = answer{1};
                fid = fopen(config_file,'a');
                fprintf(fid,'\n%s\t%s\n',current_key,varargout{n});
                fclose(fid);
            otherwise
                varargout{n} = 0;
        end
    end
end











