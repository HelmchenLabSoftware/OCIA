
% Clear command window:
clc;

% Close figures:
try
  close('all', 'hidden');
catch e; % do nothing
end;

% Closing figures might fail if the CloseRequestFcn of a figure blocks the execution. Fallback:
AllFig = allchild(0);
if ~isempty(AllFig);
   set(AllFig, 'CloseRequestFcn', '', 'DeleteFcn', '');
   delete(AllFig);
end;

warning('off', 'MATLAB:lang:cannotClearExecutingFunction');

% Clear loaded functions:
clear('functions');
warning('off', 'MATLAB:ClassInstanceExists');
clear('classes');
warning('on', 'MATLAB:ClassInstanceExists');
clear('java');
clear('global');
clear('import');  % Not from inside a function!
clear('variables');

% Stop and delete timers:
AllTimer = timerfindall;
if ~isempty(AllTimer)
   stop(AllTimer);
   delete(AllTimer);
end

% Unlock M-files:
LoadedM = inmem;
LoadedM(cellfun(@(n)~isempty(regexpi(n, '(gcp|pool|cluster)', 'once')), LoadedM)) = [];
for iLoadedM = 1:length(LoadedM)
   try
       % Use STRTOK to consider OO methods:
       aLoadedM = strtok(LoadedM{iLoadedM}, '.');
       munlock(aLoadedM);
       clear(aLoadedM);
   catch e;
   end;
end   

% Close open files:
fclose('all');

% Reset the warning status:
warning('on', 'all');

% clear created variables
clear ans e iLoadedM AllFig AllTimer aLoadedM LoadedM;

warning('on', 'MATLAB:lang:cannotClearExecutingFunction');

