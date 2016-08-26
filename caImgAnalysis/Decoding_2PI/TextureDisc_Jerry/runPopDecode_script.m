function pooledPerf = runPopDecode_script

% assume data has been imported using importData_textureDisc

load a115_allSessions.mat
content = whos('S_a115*');
pooledPerf = zeros(numel(content),4);
for n = 1:numel(content)
    fprintf('\nRunning %s (%1.0f/%1.0f)\n',content(n).name,n,numel(content))
    Sin = eval(content(n).name);
    pooledPerf(n,:) = textureDisc_popDecodeSingleSession(Sin);
end

pooledPlot = pplot(pooledPerf,'sd','none',1,1:4,...
    {'All' 'S' 'M' 'N'});
