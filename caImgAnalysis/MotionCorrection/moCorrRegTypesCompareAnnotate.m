function moCorrRegTypesCompareAnnotate(axeHands, regTypes, runIDs, xLab, figPos)
    nRegTypes = size(axeHands, 1);
    nRuns = size(axeHands, 2);
    linkaxes(axeHands, 'xy');
    i = 1;
    for iRegType = 1 : nRegTypes;
        for iRun = 1 : nRuns;
            subplot(nRegTypes, nRuns, i);
            % only plot Y axis on left-most plots
            if iRun ~= 1; set(gca, 'YTick', []);
            else ylabel(regTypes{iRegType}); end;
            % only plot X axis on bottom plots
            if mod(iRegType + nRegTypes, nRegTypes); set(gca, 'XTick', []);
            elseif ~isempty(xLab); xlabel(xLab); end
            % only plot title on top-most plots
            if ~mod(iRegType + nRuns - 1, nRuns); title(runIDs{iRun}, 'FontSize', 8); end
            i = i + 1; % counter
        end;
    end;
    if ~isempty(figPos);
        tightfig(gcf);
        pause(0.5);
        set(gcf, 'Position', figPos);
    end;
end
