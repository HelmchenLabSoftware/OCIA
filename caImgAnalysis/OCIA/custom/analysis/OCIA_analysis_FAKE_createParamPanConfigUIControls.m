function OCIA_analysis_FAKE_createParamPanConfigUIControls(this)
% OCIA_analysis_FAKE_createParamPanConfigUIControls - [no description]
%
%       OCIA_analysis_FAKE_createParamPanConfigUIControls(this)
%
% [No description]
%
% 2013-2016 - Copyleft and programmed by Balazs Laurenczy (blaurenczy_at_gmail.com)

this.an.A = [0 10];
this.an.B = 1 : 5;
this.an.C = 3;
this.an.D = 'gauss';
this.an.E = { '001', '002', '005' };
this.an.F = 3;
this.an.G = [];

%% plotting parameter UI controls
paramConf = cell2table({ ...
... categ  id   UIType      valueType                   UISize  isLabAbove  label               tooltip
    'an',  'F', 'slider',   { [], 1, 100, 2 / 100, 20 / 100 }, [1 0], false,    'Threshold',        'Number of bins for the pixel time course.';
    'an',  'A', 'text',     { 'array' },                [1 0],  false,      'Y Lim.',           'Number of bins for the pixel time course.';
    'an',  'B', 'text',     { 'cellarray' },            [1 0],  true,       'Stim. IDs',      'Rotation angle for all frames.';
    'an',  'C', 'text',     { 'numeric' },              [1 0],  false,      'Filter size',      'Rotation angle for all frames.';
    'an',  'D', 'dropdown', { 'none', 'gauss', 'median' }, [1 0], false,    'Filter type',      'Number of bins for the pixel time course.';
    'an',  'G', 'button',   {  },                       [1 0],  false,      'Re-run',           'Number of bins for the pixel time course.';
    'an',  'E', 'list',     { 'N 001', 'N 002', 'N 003', 'N 004', 'N 005', 'N 006' }, ...
                                                        [3.5 1],  false,      'Neurons',          'Number of bins for the pixel time course.';
    'an',  'H', 'text',     { 'array' },                [1 0],  false,      'Y Lim.',           'Number of bins for the pixel time course.';
    'an',  'I', 'text',     { 'array' },                [1 0],  false,      'Y Lim.',           'Number of bins for the pixel time course.';
    
}, 'VariableNames', this.GUI.an.paramPanConfig.Properties.VariableNames);
% append the new configuration to the table and update the row names using the ids
this.GUI.an.paramPanConfig = [this.GUI.an.paramPanConfig; paramConf];
this.GUI.an.paramPanConfig.Properties.RowNames = this.GUI.an.paramPanConfig.id;

end
