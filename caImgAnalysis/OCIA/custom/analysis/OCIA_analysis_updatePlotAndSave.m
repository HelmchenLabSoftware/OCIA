function anh = OCIA_analysis_updatePlotAndSave(this, savePath, varargin)
    ANUpdatePlot(this, 'force');
    anh = this.GUI.handles.an;
    % only save if there is no input 2 or if input 2 is positive
    if numel(varargin) < 2 || varargin{2} > 0;
        if numel(varargin) > 0 && ~isempty(varargin{1}) && varargin{1};
%             savePath = [savePath iff(iMask == 1, '_noMask', '_withMask')];
            savePath = [savePath iff(iMask == 1, '', '_withMotionMask')];
        end;
        ANSavePlot(this, savePath);
        ANSavePlot(this, [regexprep(savePath, '/fig/', '/png/'), '.png']);
    end;
end