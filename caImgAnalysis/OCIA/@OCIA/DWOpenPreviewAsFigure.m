function DWOpenPreviewAsFigure(this, varargin)
% DWOpenPreviewAsFigure - [no description]
%
%       DWOpenPreviewAsFigure(this, varargin)
%
% [No description]
%
% 2013-2016 - Copyleft and programmed by Balazs Laurenczy (blaurenczy_at_gmail.com)
    
    % if nothing is selected, abort
    if isempty(this.dw.selectedTableRows); 
        showWarning(this, 'OCIA:DWOpenPreviewAsFigure:NoRowsSelected', 'No rows selected! Aborting.');
        return;
    end;
    
    allRows = this.dw.selectedTableRows;
    nRows = numel(allRows);
    d = min(max(50 / nRows, 10), 20);
    for iRow = 1 : nRows;
    
        % get the selected row and it's rowID
        rowID = DWGetRowID(this, allRows(iRow));

        % create the figure
        prevFigH = figure('Name', sprintf('%s - preview', rowID), 'NumberTitle', 'off', 'Position', ...
            [1 1 repmat(max(get(0, 'ScreenSize')) * 0.5, 1, 2)]);
        imagesc(get(this.GUI.handles.dw.prevIm, 'CData'));
        set(gca, 'XTick', [], 'YTick', []);
        tightfig();
        movegui(prevFigH, 'center');
        pause(0.1);
        pos = get(prevFigH, 'Position');
        set(prevFigH, 'Position', pos + 3 * [(iRow - 1) * d -(iRow - 1) * d 0 0]);
        
        if iRow < nRows;
            % select next row
            DWSelTableRows(this, allRows(iRow + 1));
        else
            DWSelTableRows(this, allRows);
        end;
    end;
    
end
