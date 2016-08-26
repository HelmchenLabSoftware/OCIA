function DWSelTableRows(this, toSelectRows)
% DWSelTableRows - [no description]
%
%       DWSelTableRows(this, toSelectRows)
%
% [No description]
%
% 2013-2016 - Copyleft and programmed by Balazs Laurenczy (blaurenczy_at_gmail.com)

% set the selection
this.dw.selectedTableRows = toSelectRows;

% if there is a GUI, select the rows in the uitable
if isGUI(this);
    jTable = getJTable(this, 'DWTable');
    jTable.clearSelection();
    
    % if no rows selected empty preview and abort
    if isempty(toSelectRows);
        % use a black image
        RGBIm = zeros([100, 100 3]);
        % set the image in the preview window
        set(this.GUI.handles.dw.prevIm, 'CData', RGBIm);
        % adjust the display
        set(this.GUI.handles.dw.prevImAx, ...
            'XLim', [-size(RGBIm, 2) * 0.05 size(RGBIm, 2) * 1.05], ...
            'YLim', [-size(RGBIm, 1) * 0.05 size(RGBIm, 1) * 1.05]);
        return;
    end;

    for iSelRow = 1 : numel(toSelectRows);
        selRow = toSelectRows(iSelRow);
        if selRow > jTable.getRowCount; break; end;
        jTable.addRowSelectionInterval(selRow - 1, selRow - 1);
    end;

    % get the first row's type ID
    rowTypeID = DWGetRowTypeID(this, toSelectRows(1));
    
    % if a thumbnail preview must be shown, call the custom function for it
    if this.GUI.dw.showThumbnailPreview && ~isempty(toSelectRows) && ~isempty(rowTypeID);
        % call the custom function without warnings
        warning('off', 'OCIA:getPreviewFunctionNotFound');
        [~, RGBIm] = OCIAGetCallCustomFile(this, 'getPreview', rowTypeID, true, ...
            { this, toSelectRows(1), 'preview' }, false);
        warning('on', 'OCIA:getPreviewFunctionNotFound');
        
        % if no image was return, use a black square
        if isempty(RGBIm); RGBIm = zeros([100, 100, 3]); end;        

        % average if necessary
        if size(RGBIm, 3) > 3;
            RGBIm = nanmean(RGBIm, 3);
        end;
        
        % scale the image
        RGBIm = linScale(RGBIm);
        RGBIm(RGBIm < 0) = 0;
        RGBIm(RGBIm > 1) = 1;

        % set the image in the preview window
        set(this.GUI.handles.dw.prevIm, 'CData', RGBIm);
        % adjust the display
        set(this.GUI.handles.dw.prevImAx, ...
            'XLim', [-size(RGBIm, 2) * 0.05 size(RGBIm, 2) * 1.05], ...
            'YLim', [-size(RGBIm, 1) * 0.05 size(RGBIm, 1) * 1.05]);
    end;
    
end;

end
