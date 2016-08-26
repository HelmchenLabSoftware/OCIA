function sampleData_runScript

% assume data has been imported using importData_textureDisc

addpath('../')

load a115_allSessions.mat
content = whos('S_a115*');
for n = 1:numel(content)
%     if n > 1, break, end
    currentVar = content(n).name;
    % run dimensionality reduction
    s = sprintf('textureDisc_dimensionReduce(%s)',currentVar);
    Sout = eval(s);
%     textureDisc_mvpaSingleSession(Sout);
end

rmpath('../')
