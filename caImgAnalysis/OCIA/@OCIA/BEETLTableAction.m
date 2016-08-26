function BEETLTableAction(this, ~, e, actionName, varargin)
% BEETLTableAction - [no description]
%
%       BEETLTableAction(this, ~, e, actionName, varargin)
%
% [No description]
%
% 2013-2016 - Copyleft and programmed by Balazs Laurenczy (blaurenczy_at_gmail.com)
      
tableData = get(this.GUI.handles.be.ETLTable, 'Data');

% get selected row
jTable = getJTable(this, 'BEETLTable');
selectedRowIndex = jTable.getSelectedRows() + 1;

toSelectRow = [];

doSaveTable = 0;

switch actionName;
    
    case 'add';
        
        currVolt = get(this.GUI.handles.be.ETLVoltSetter, 'String');
        currDepth = get(this.GUI.handles.be.ETLDepthSetter, 'String');
        
        tableData = [tableData; { sprintf('spot%02d', size(tableData, 1) + 1), currVolt, currDepth, '0.0' }];
        
        doSaveTable = 1;
        
    case 'remove';
        
        if ~isempty(selectedRowIndex);
            tableData(selectedRowIndex, :) = [];
        end;
        
        doSaveTable = 1;
        
    case 'clear';
        
        tableData = cell(0, size(tableData, 2));
        
        doSaveTable = 1;
        
    case 'create';
        minV = this.be.params.minETLV; maxV = this.be.params.maxETLV;
        minD = this.be.params.minETLDepth; maxD = this.be.params.maxETLDepth;
        midV = 0.5 * (maxV - minV) + minV;
        midD = 0.5 * (maxD - minD) + minD;
        tableData = {
            'spot01', sprintf('%.2f', minV), sprintf('%03d', minD), '0.0';
            'spot02', sprintf('%.2f', midV), sprintf('%03d', midD), '0.0';
            'spot03', sprintf('%.2f', maxV), sprintf('%03d', maxD), '0.0';
        };
    
        doSaveTable = 1;
    
    case 'go';
        
        if ~isempty(selectedRowIndex);
            [name, voltStr, depthStr, laserStr] = tableData{selectedRowIndex, :};
            BEETL(this, str2double(voltStr), 'volt'); % volt volt, de hol volt ?
            BELaserInt(this, str2double(laserStr));
            showMessage(this, sprintf('Behavior: ETL Z-focusing to "%s" (%sV, %sum, %s%% laser) done.', ...
                name, voltStr, depthStr, laserStr));            
        else
            showWarning(this, 'OCIA:BEETLTableAction:ETLTableNoRowSelected', 'Behavior: no row selected !');
        end;
        
        
    case 'edit';
        
        switch e.Indices(2);
            
            % changed name
            case 1;
            
                if ismember(e.NewData, tableData((1 : size(tableData, 1)) ~= e.Indices(1), 1));
                    showWarning(this, 'OCIA:BEETLTableAction:DuplicateName', 'Behavior: name already exists !');
                    tableData{e.Indices(1), 1} = e.PreviousData;
                end;
        
            % changed volt
            case 2;
            
                ETLVolt = str2double(e.NewData);
                if isnan(ETLVolt); ETLVolt = str2double(e.PreviousData); end;
                ETLVolt = min(max(ETLVolt, this.be.params.maxETLV), this.be.params.minETLV);
                tableData{e.Indices(1), 2} = sprintf('%.2f', ETLVolt);

                ETLState = (ETLVolt - this.be.params.minETLV) / (this.be.params.maxETLV - this.be.params.minETLV);
                ETLDepth = round(ETLState * (this.be.params.maxETLDepth - this.be.params.minETLDepth) + this.be.params.minETLDepth);            
                ETLDepth = max(min(ETLDepth, this.be.params.maxETLDepth), this.be.params.minETLDepth);
                tableData{e.Indices(1), 3} = sprintf('%03d', ETLDepth);
            
            % changed depth
            case 3;
            
                ETLDepth = round(str2double(e.NewData));
                if isnan(ETLDepth); ETLDepth = round(str2double(e.PreviousData)); end;
                ETLDepth = max(min(ETLDepth, this.be.params.maxETLDepth), this.be.params.minETLDepth);
                tableData{e.Indices(1), 3} = sprintf('%03d', ETLDepth);

                ETLState = (ETLDepth - this.be.params.minETLDepth) / (this.be.params.maxETLDepth - this.be.params.minETLDepth);
                ETLVolt = ETLState * (this.be.params.maxETLV - this.be.params.minETLV) + this.be.params.minETLV;
                ETLVolt = min(max(ETLVolt, this.be.params.maxETLV), this.be.params.minETLV);
                tableData{e.Indices(1), 2} = sprintf('%.2f', ETLVolt);
            
            % changed laser intensity
            case 4;
            
                laserInt = round(str2double(e.NewData));
                if isnan(laserInt); laserInt = round(str2double(e.PreviousData)); end;
                laserInt = max(min(laserInt, this.be.params.maxLaserInt), this.be.params.minLaserInt);
                tableData{e.Indices(1), 4} = sprintf('%.1f', laserInt);
        
        end;
        
        toSelectRow = e.Indices(1);
        
        % save table
        doSaveTable = 1;
        
    case 'select';
        
        if ~isempty(varargin) && isnumeric(varargin{1}) && varargin{1} <= size(tableData, 1) && varargin{1} >= 1;            
            % select the rows
            toSelectRow = varargin{1};
        else
            showWarning(this, 'OCIA:BEETLTableAction:SelectionActionBadInput', ...
                'Behavior: ETLTableAction: bad input for selection action !');
        end;
        
    case 'openRef';
        
        if ~isfield(this.be, 'animalID'); return; end;
        refPath = sprintf('%smou_bl_%s/ref/spots/', this.path.rawData, this.be.animalID);
        for iSpot = 1 : 3;
            figPath = sprintf('%smou_bl_%s__spot%02d.fig', refPath, this.be.animalID, iSpot);
            if ~exist(figPath, 'file'); continue; end;
            open(figPath);
            % enable key events
            baseX = 551; baseY = 81; baseW = 510; baseH = 510;
            pos = [baseX, baseY + baseH, baseW, baseH];
            set(gcf, 'Position', pos);
            set(gcf, 'KeyPressFcn', @(h, e)helioScanFigureKeyPressFcn(h, e, pos));
            helioScanFigureKeyPressFcn(gcf, struct('Key', 'r'), []);
            set(gcf, 'Position', pos + iff(iSpot == 2, [baseW + 15, 0 0 0], ...
                iff(iSpot == 3, [0, -baseH - 36, 0, 0], [0 0 0 0])));
            helioScanFigureKeyPressFcn(gcf, struct('Key', 'i'), []);
            helioScanFigureKeyPressFcn(gcf, struct('Key', 'o'), []);
            helioScanFigureKeyPressFcn(gcf, struct('Key', 'downarrow'), []);
            helioScanFigureKeyPressFcn(gcf, struct('Key', 'space', 'Modifier', {{ 'shift' }}), []);
        end;
        
        imgPath = sprintf('%svessels_intr_expr_spots.png', refPath);
        if exist(imgPath, 'file');
            img = imread(imgPath);
            figure();
            imagesc(img);
            set(gca, 'XTick', [], 'YTick', []);
            tightfig(gcf);
            set(gcf, 'Position', [337, 100, 1358, 992]);
        end;
        
    % unknown action
    otherwise
        showWarning(this, 'OCIA:BEETLTableAction:UnknownAction', 'Behavior: ETLTableAction: unknown action !');
    
end;
        
set(this.GUI.handles.be.ETLTable, 'Data', tableData);

if doSaveTable;
    save(sprintf('%sOCIA_BE_lastTable.mat', this.path.OCIASave), 'tableData');
end;

if ~isempty(toSelectRow);
    pause(0.1);
    % select the rows
    jTable.clearSelection();
    jTable.addRowSelectionInterval(toSelectRow - 1, toSelectRow - 1);
end;

end
