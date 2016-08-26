function anh = OCIA_analysis_updatePlotAndSaveNoMask(this, savePath, varargin)
    ANUpdatePlot(this, 'force');
    anh = this.GUI.handles.an;
    % only save if there is no input 1 or if input 1 is positive
    if numel(varargin) < 1 || varargin{1} > 0;        
%         ANSavePlot(this, savePath);
        ANSavePlot(this, [regexprep(savePath, '/fig/', '/png/'), '.png']);
    end;
end