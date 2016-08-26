
% figPos = [305 45 1125 985];
figPos = [305 45 1085 985];
    
if doSave;
    saveName = sprintf('averageAndTrialMaps/%s_averageMaps_%s%s', sessID, trialType, ...
        iff(doExclTrials, '_exclTrials', '')); %#ok<*UNRCH>
    export_fig(sprintf('%s.png', saveName), exportArgsPNG{:}, gcf);
    export_fig(sprintf('%s.fig', saveName), gcf);
end;