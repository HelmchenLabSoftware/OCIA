function saveName = INGetSaveName(this)
% INGetSaveName - [no description]
%
%       saveName = INGetSaveName(this)
%
% [No description]
%
% 2013-2016 - Copyleft and programmed by Balazs Laurenczy (blaurenczy_at_gmail.com)

saveName = this.in.([this.in.expMode '_saveName']);
regexpPattern = '\[([\w\.\+\-\/\* \^\(\)]+)\]';
while strfind(saveName, '[');
    try
        toReplace = cell2mat(regexp(saveName, regexpPattern, 'tokens', 'once'));
        replaceVal = eval(toReplace);
        if strfind(toReplace, 'expNumber');
            replaceVal = sprintf('%02d', replaceVal);
        elseif isnumeric(replaceVal) && numel(replaceVal) > 1;
            replaceVal = '';
        elseif isnumeric(replaceVal) && mod(replaceVal, 1);
            replaceVal = regexprep(sprintf('%.2f', replaceVal), '\.', 'p');
        elseif isnumeric(replaceVal);
            replaceVal = sprintf('%d', replaceVal);
        end;
        saveName = regexprep(saveName, regexpPattern, replaceVal, 'once');
    catch err;
        showWarning(this, 'OCIA:INGetSaveName:SaveNameCreationFailed', ...
            sprintf('Failed at creating save name ("%s") ("%s"): %s ...', saveName, err.identifier, err.message));
        saveName = '';
    end;
end;

end
