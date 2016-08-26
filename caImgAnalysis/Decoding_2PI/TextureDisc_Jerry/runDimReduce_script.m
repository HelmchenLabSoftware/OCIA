function runDimReduce_script

% assume data has been imported using importData_textureDisc

load a115_allSessions.mat
content = whos('S_a115*');
for n = 1:numel(content)
    fprintf('\nRunning %s (%1.0f/%1.0f)\n',content(n).name,n,numel(content))
%     if n > 1, break, end
    currentVar = content(n).name;
    % run dimensionality reduction
    s = sprintf('textureDisc_dimensionReduce(%s)',currentVar);
    Sout = eval(s);
    SaveAndAssignInBase(Sout,currentVar,'AssignOnly')
end
