function OCIA_analysis_behavFrac(this, iDWRows)
% OCIA_analysis_behavFrac - [no description]
%
%       OCIA_analysis_behavFrac(this, iDWRows)
%
% [No description]
%
% 2013-2016 - Copyleft and programmed by Balazs Laurenczy (blaurenczy_at_gmail.com)

%% plotting parameter UI controls
paramConf = cell2table({ ...
... categ  id                   UIType      valueType               UISize      isLabAbove      label           tooltip
    'img', 'plotLimits',        'text',     { 'array' },            [0.75 0],      false,          'Plot limits',  'Adjust the limits of the plot (color limit).';
    'img', 'colormap',          'dropdown', { 'gray', 'hot', 'gray_reverse', 'red_white_blue', 'jet' }', ...
                                                                    [0.75 0],      false,          'Colormap',     'Changes the coloring scheme (color map).';
}, 'VariableNames', this.GUI.an.paramPanConfig.Properties.VariableNames);
% append the new configuration to the table and update the row names using the ids
this.GUI.an.paramPanConfig = [this.GUI.an.paramPanConfig; paramConf];
this.GUI.an.paramPanConfig.Properties.RowNames = this.GUI.an.paramPanConfig.id;



plotCaTracesHeatMap(this.GUI.handles.an.axe, 0, '', [], concatCaTracesSGFilt, concatStims, ...
    stimIDs, ROINames, t, [], this.an.img.plotLimits, this.an.img.colormap);
    
end
