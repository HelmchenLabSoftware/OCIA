function stackText = getStackText(err)

% get additional stack info
stackText = '>';
doAdd = true;
for iStack = 1 : numel(err.stack);
    stack = err.stack(iStack);
    if strcmp(mfilename, stack.name); doAdd = false; end;
    if doAdd; stackText = sprintf('%s In %s at %d\n ', stackText, stack.name, stack.line); end;
end;
stackText = regexprep(stackText, '\n $', '');
                    
end