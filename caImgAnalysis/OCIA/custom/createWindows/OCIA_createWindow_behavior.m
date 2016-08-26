function OCIA_createWindow_behavior(this, pad)
% OCIA_createWindow_behavior - [no description]
%
%       OCIA_createWindow_behavior(this, pad)
%
% [No description]
%
% 2013-2016 - Copyleft and programmed by Balazs Laurenczy (blaurenczy_at_gmail.com)

BGWhite = {'Background', 'white'}; %#ok<*CCAT>
NormUnits = {'Units', 'normalized'};
%% - #OCIACreateWindow: Behavior panels
commons = {'Parent', this.GUI.handles.panels.BehaviorPanel, BGWhite{:}, 'Units', ...
    'normalized', 'Visible', 'on', 'FontSize', this.GUI.pos(4) / 95};
% HWPanW = 0.3 - 3/2 * pad; HWPanH = 0.4 - 4/3 * pad; % with ETL pan
HWPanW = 0.3 - 3/2 * pad; HWPanH = 0.3 - 4/3 * pad;
% ETLPanW = 0.3 - 3/2 * pad; ETLPanH = 0.25 - 4/3 * pad;
ExpPanW = 0.3 - 3/2 * pad; ExpPanH = 0.5 - 3/2 * pad;
MonPanW = 0.7 - 3/2 * pad; MonPanH = 0.5 - 3/2 * pad;
ConfPanW = 0.3 - 3/2 * pad; ConfPanH = 0.7 - 4/3 * pad;
% ConfPanW = 0.3 - 3/2 * pad; ConfPanH = 0.35 - 4/3 * pad;
PerfPanW = 0.4 - 3/2 * pad; PerfPanH = 0.5 - 3/2 * pad;
this.GUI.handles.be.panels.hw = uipanel(commons{:}, 'Title', 'Hardware', 'Tag', 'BEHW', ...
    'Position', [pad 1 - pad - HWPanH HWPanW HWPanH]);
% this.GUI.handles.be.panels.ETL = uipanel(commons{:}, 'Title', 'ETL', 'Tag', 'BEETL', ...
%     'Position', [pad 1 - pad - HWPanH - pad - ETLPanH ETLPanW ETLPanH]);
this.GUI.handles.be.panels.exp = uipanel(commons{:}, 'Title', 'Experiment', 'Tag', 'BEExp', ...
        'Position', [pad + HWPanW + pad 1 - pad - ExpPanH ExpPanW ExpPanH], commons{:});
this.GUI.handles.be.panels.perf = uipanel(commons{:}, 'Title', 'Performance', 'Tag', 'BEPerf', ...
    'Position', [pad + HWPanW + pad + ExpPanW + pad  1 - pad - PerfPanH PerfPanW PerfPanH]);
this.GUI.handles.be.panels.mon = uipanel(commons{:}, 'Title', 'Monitor', 'Tag', 'BEMon', ...
    'Position', [pad + ConfPanW + pad pad MonPanW MonPanH]);
this.GUI.handles.be.panels.conf = uipanel(commons{:}, 'Title', 'Config', 'Tag', 'BEConf', ...
    'Position', [pad pad ConfPanW ConfPanH]);

%% - #OCIACreateWindow: Behavior: Hardware panel: connect hardware and valve control buttons
bPad = 0.02;
commons = {'Parent', this.GUI.handles.be.panels.hw, NormUnits{:}, 'Style', 'togglebutton', ...
    'BackgroundColor', 'red', 'FontSize', this.GUI.pos(4) / 75};
connHWW = 0.25; connHWH = 0.15; connHWX = bPad; connHWY = 1 - connHWH - bPad;
this.GUI.handles.be.connHW = uicontrol(commons{:}, 'String', 'Connect', ...
    'Position', [connHWX connHWY connHWW connHWH], 'Callback', @(h, e)BEConnHW(this, h, e));
valveCtrlW = 0.3 - 1.5 * bPad; valveCtrlH = connHWH; valveCtrlX = connHWX; valveCtrlY = connHWY - bPad - valveCtrlH;
this.GUI.handles.be.valveCtrl = uicontrol(commons{:}, 'String', 'Valve', ...
    'Position', [valveCtrlX valveCtrlY valveCtrlW valveCtrlH], 'Callback', @(h, e)BEValveControl(this, h, e));
% airPuffCtrlW = valveCtrlW; airPuffCtrlH = connHWH; airPuffCtrlX = connHWX; airPuffCtrlY = valveCtrlY - bPad - airPuffCtrlH;
% this.GUI.handles.be.airPuffCtrl = uicontrol(commons{:}, 'String', 'Air Puff', ...
%     'Position', [airPuffCtrlX airPuffCtrlY airPuffCtrlW airPuffCtrlH], 'Callback', @(h, e)BEAirPuffControl(this, h, e));
imagTTLW = (1 - 4 * bPad) / 3; imagTTLH = connHWH; imagTTLX = connHWX; imagTTLY = valveCtrlY - bPad - imagTTLH;
this.GUI.handles.be.imagTTL = uicontrol(commons{:}, 'String', 'Imaging TTL', ...
    'Position', [imagTTLX imagTTLY imagTTLW imagTTLH], 'Callback', @(h, e)BEImagingTTL(this, h, e));
% spoutPosW = imagTTLW * 1.1; spoutPosH = connHWH; spoutPosX = imagTTLX + bPad + imagTTLW; spoutPosY = imagTTLY;
% this.GUI.handles.be.spoutPos = uicontrol(commons{:}, 'String', 'Spout position', ...
%     'Position', [spoutPosX spoutPosY spoutPosW spoutPosH], 'Callback', @(h, e)BESpoutPos(this, h, e));
soundW = imagTTLW * 1.0; soundH = connHWH; soundX = imagTTLX + bPad + imagTTLW; soundY = imagTTLY;
lightW = imagTTLW * 1.0; lightH = connHWH; lightX = soundX + bPad + soundW; lightY = imagTTLY;
this.GUI.handles.be.light = uicontrol(commons{:}, 'String', 'Light', ...
    'Position', [lightX lightY lightW lightH], 'Callback', @(h, e)BELight(this, h, e));

commons = {'Parent', this.GUI.handles.be.panels.hw, NormUnits{:}, 'Style', 'pushbutton', 'FontSize', this.GUI.pos(4) / 85};
givRewW = connHWW; givRewH = connHWH; givRewX = valveCtrlX + bPad + valveCtrlW; givRewY = valveCtrlY;
this.GUI.handles.be.givRew = uicontrol(commons{:}, 'String', 'Give reward', ...
    'Position', [givRewX givRewY givRewW givRewH], 'Callback', @(h, e)BEGiveReward(this, h, e));
this.GUI.handles.be.sound = uicontrol(commons{:}, 'String', 'Sound', ...
    'Position', [soundX soundY soundW soundH], 'Callback', @(h, e)BESound(this, h, e));
% givAirPuffW = connHWW; givAirPuffH = connHWH; givAirPuffX = airPuffCtrlX + bPad + airPuffCtrlW; givAirPuffY = airPuffCtrlY;
% this.GUI.handles.be.givAirPuff = uicontrol(commons{:}, 'String', 'Give punish', ...
%     'Position', [givAirPuffX givAirPuffY givAirPuffW givAirPuffH], 'Callback', @(h, e)BEGiveAirPuff(this, h, e));

%% - #OCIACreateWindow: Behavior: Hardware panel: reward duration and piezo threshold setter
commons = {'Parent', this.GUI.handles.be.panels.hw, NormUnits{:}, 'FontSize', this.GUI.pos(4) / 95, BGWhite{:}};
commonFonts = {'Parent', this.GUI.handles.be.panels.hw, NormUnits{:}, 'FontSize', this.GUI.pos(4) / 130, BGWhite{:}};
labW = 0.22; labH = 0.07; setW = 0.2 - 1.5 * bPad; setH = labH * 1.3;

piezoThreshLabW = labW * 0.8; piezoThreshLabH = labH;
piezoThreshLabX = connHWX + connHWW + bPad; piezoThreshLabY = connHWY;
this.GUI.handles.be.piezoThreshLab = uicontrol(commonFonts{:}, 'String', 'Piezo thresh.', 'Style', 'text', ...
    'Position', [piezoThreshLabX piezoThreshLabY piezoThreshLabW piezoThreshLabH]);
piezoThreshW = setW * 0.7; piezoThreshH = setH;
piezoThreshX = piezoThreshLabX + piezoThreshLabW + bPad; piezoThreshY = piezoThreshLabY;
this.GUI.handles.be.piezoThreshSetter = uicontrol(commonFonts{:}, 'String', this.be.params.piezoThresh, 'Style', 'edit', ...
    'Position', [piezoThreshX piezoThreshY piezoThreshW piezoThreshH], ...
    'Callback', @(h, e)BEChangePiezoThresh(this, h, e));

% spoutDelayLabW = labW; spoutDelayLabH = labH;
% spoutDelayLabX = piezoThreshX + piezoThreshW + bPad; spoutDelayLabY = piezoThreshLabY;
% this.GUI.handles.be.spoutDelayLab = uicontrol(commonFonts{:}, 'String', 'Spout adj. delay', 'Style', 'text', ...
%     'Position', [spoutDelayLabX spoutDelayLabY spoutDelayLabW spoutDelayLabH]);
% spoutDelayW = setW * 0.75; spoutDelayH = setH;
% spoutDelayX = spoutDelayLabX + spoutDelayLabW + bPad; spoutDelayY = spoutDelayLabY;
% this.GUI.handles.be.spoutDelaySetter = uicontrol(commons{:}, 'String', ...
%     sprintf('[%.1f, %.1f]', this.be.params.spoutDelay), 'Style', 'edit', ...
%     'Position', [spoutDelayX spoutDelayY spoutDelayW spoutDelayH], ...
%     'Callback', @(h, e)BEChangeSpoutDelay(this, h, e));


rewDurLabW = labW; rewDurLabH = labH;
rewDurLabX = givRewX + givRewW + bPad; rewDurLabY = givRewY;
this.GUI.handles.be.rewDurLab = uicontrol(commonFonts{:}, 'String', 'Reward dur. [s]', ...
    'Position', [rewDurLabX rewDurLabY rewDurLabW rewDurLabH], 'Style', 'text');
% punishDurLabW = labW; punishDurLabH = labH;
% punishDurLabX = givAirPuffX + givAirPuffW + bPad; punishDurLabY = givAirPuffY;
% this.GUI.handles.be.punishDurLab = uicontrol(commonFonts{:}, 'String', 'Punish dur. [s]', 'Style', 'text', ...
%     'Position', [punishDurLabX punishDurLabY punishDurLabW punishDurLabH]);

rewDurW = setW; rewDurH = setH; rewDurX = rewDurLabX + labW + bPad; rewDurY = rewDurLabY;
this.GUI.handles.be.rewDurSetter = uicontrol(commons{:}, 'String', this.be.params.rewDur, 'Style', 'edit', ...
    'Position', [rewDurX rewDurY rewDurW rewDurH], 'Callback', @(h, e)BEChangeRewDur(this, h, e));
% punishDurW = setW; punishDurH = setH; punishDurX = punishDurLabX + labW + bPad; punishDurY = punishDurLabY;
% this.GUI.handles.be.punishDurSetter = uicontrol(commons{:}, 'String', this.be.params.punishDur, 'Style', 'edit', ...
%     'Position', [punishDurX punishDurY punishDurW punishDurH], 'Callback', @(h, e)BEChangePunishDur(this, h, e));

%% - #OCIACreateWindow: Behavior: Hardware panel: Imaging enable radio group
imagEnableGroupW = (1 - 3 * bPad) * 0.3; imagEnableGroupH = 0.15; 
imagEnableGroupX = bPad; imagEnableGroupY = imagTTLY - bPad - imagEnableGroupH;
commons = {'Parent', this.GUI.handles.be.panels.hw, BGWhite{:}, NormUnits{:}};
this.GUI.handles.be.imageEnableGroup = uibuttongroup(commons{:}, 'Title', 'Imaging enabled', ...
    'Position', [imagEnableGroupX imagEnableGroupY imagEnableGroupW imagEnableGroupH]);
commons = {'Parent', this.GUI.handles.be.imageEnableGroup, BGWhite{:}, NormUnits{:}, 'Style', 'radiobutton'};
imagEnableRadioW = (1 - 3 * bPad) * 0.5; imagEnableRadioH = 1 - 2 * bPad; 
imagEnableOnX = bPad; imagEnableOnY = bPad;
imagEnableOffX = bPad + imagEnableRadioW + bPad; imagEnableOffY = imagEnableOnY;
this.GUI.handles.be.imageEnableOn = uicontrol(commons{:}, 'String', 'On', ...
    'Position', [imagEnableOnX imagEnableOnY imagEnableRadioW imagEnableRadioH]);
this.GUI.handles.be.imageEnableOff = uicontrol(commons{:}, 'String', 'Off', ...
    'Position', [imagEnableOffX imagEnableOffY imagEnableRadioW imagEnableRadioH]);
% set the option to be selected 
set(this.GUI.handles.be.imageEnableGroup, 'SelectedObject', this.GUI.handles.be.imageEnableOn);

%% - #OCIACreateWindow: Behavior: Hardware panel: Reward mode radio group
autoRewGroupW = (1 - 3 * bPad) * 0.7; autoRewGroupH = imagEnableGroupH; 
autoRewGroupX = imagEnableGroupX + imagEnableGroupW + bPad; autoRewGroupY = imagEnableGroupY;
commons = {'Parent', this.GUI.handles.be.panels.hw, BGWhite{:}, NormUnits{:}};
this.GUI.handles.be.autoRewGroup = uibuttongroup(commons{:}, 'Title', 'Reward mode', ...
    'Position', [autoRewGroupX autoRewGroupY autoRewGroupW autoRewGroupH]);
commons = {'Parent', this.GUI.handles.be.autoRewGroup, BGWhite{:}, NormUnits{:}, 'Style', 'radiobutton'};
nAutoRewModes = numel(this.GUI.be.autoRewModes);
%             autoRewRadioW = (1 - (nAutoRewModes + 1) * bPad) / nAutoRewModes;
autoRewRW = (1 - (nAutoRewModes + 1) * bPad) / nAutoRewModes;
autoRewRWs = [autoRewRW * 1.3 autoRewRW * 0.8 autoRewRW * 1 autoRewRW * 0.8]; autoRewRH = 1 - 2 * bPad;
autoRewRX = [bPad 2 * bPad + autoRewRWs(1) 3 * bPad + sum(autoRewRWs(1:2)) 4 * bPad + sum(autoRewRWs(1:3))];
for iMode = 1 : nAutoRewModes;
    this.GUI.handles.be.(sprintf('autoRew%sMode', this.GUI.be.autoRewModes{iMode})) = ...
        uicontrol(commons{:}, 'String', this.GUI.be.autoRewModes{iMode}, ...
        'Position', [autoRewRX(iMode), bPad, autoRewRWs(iMode), autoRewRH]);
end;
% set the option to be selected and the callback function
set(this.GUI.handles.be.autoRewGroup, 'SelectionChangeFcn', @(h, e)BEChangeAutoRewardMode(this, h, e), ...
    'SelectedObject', this.GUI.handles.be.(sprintf('autoRew%sMode', this.be.params.autoRewardMode)));

% %% - #OCIACreateWindow: Behavior: Hardware panel: Video recording enable radio group
% vidRecEnableGroupW = (1 - 3 * bPad) * 0.3; vidRecEnableGroupH = imagEnableGroupH; 
% vidRecEnableGroupX = bPad; vidRecEnableGroupY = imagEnableGroupY - bPad - vidRecEnableGroupH;
% % create a context menu for the reset option
% this.GUI.handles.be.vidRecContextMenu = uicontextmenu('Parent', this.GUI.figH);
% this.GUI.handles.be.resetContextMenu = uimenu(this.GUI.handles.be.vidRecContextMenu, 'Label', 'Reset', ...
%     'Callback', @(h, e)BEChangeVidRecState(this, 'reset', []));
% commons = {'Parent', this.GUI.handles.be.panels.hw, BGWhite{:}, NormUnits{:}};
% this.GUI.handles.be.vidRecEnableGroup = uibuttongroup(commons{:}, 'Title', 'Video recording', ...
%     'Position', [vidRecEnableGroupX vidRecEnableGroupY vidRecEnableGroupW vidRecEnableGroupH], ...
%     'uicontextmenu', this.GUI.handles.be.vidRecContextMenu);
% commons = {'Parent', this.GUI.handles.be.vidRecEnableGroup, BGWhite{:}, NormUnits{:}, 'Style', 'radiobutton'};
% vidRecEnableRadioW = (1 - 3 * bPad) * 0.5; vidRecEnableRadioH = 1 - 2 * bPad; 
% vidRecEnableOnX = bPad; vidRecEnableOnY = bPad;
% vidRecEnableOffX = bPad + vidRecEnableRadioW + bPad; vidRecEnableOffY = vidRecEnableOnY;
% this.GUI.handles.be.vidRecEnableOn = uicontrol(commons{:}, 'String', 'On', ...
%     'Position', [vidRecEnableOnX vidRecEnableOnY vidRecEnableRadioW vidRecEnableRadioH]);
% this.GUI.handles.be.vidRecEnableOff = uicontrol(commons{:}, 'String', 'Off', ...
%     'Position', [vidRecEnableOffX vidRecEnableOffY vidRecEnableRadioW vidRecEnableRadioH]);
% % set the option to be selected and the callback function
% set(this.GUI.handles.be.vidRecEnableGroup, 'SelectedObject', this.GUI.handles.be.vidRecEnableOff, ...
%     'SelectionChangeFcn', @(h, e)BEChangeVidRecState(this, h, e));

% %% - #OCIACreateWindow: Behavior: Hardware panel: Video recording delay setter
% commons = {'Parent', this.GUI.handles.be.panels.hw, NormUnits{:}, 'FontSize', this.GUI.pos(4) / 115, BGWhite{:}};
% commonFonts = {'Parent', this.GUI.handles.be.panels.hw, NormUnits{:}, 'FontSize', this.GUI.pos(4) / 145, BGWhite{:}};
% vidRecDelayLabW = labW * 0.5; vidRecDelayLabH = labH * 1.2;
% vidRecDelayLabX = vidRecEnableGroupX + vidRecEnableGroupW + bPad; vidRecDelayLabY = vidRecEnableGroupY + 0.115 * labH;
% this.GUI.handles.be.vidRecDelayLab = uicontrol(commonFonts{:}, 'String', 'Vid. delay [s]', 'Style', 'text', ...
%     'Position', [vidRecDelayLabX vidRecDelayLabY vidRecDelayLabW vidRecDelayLabH]);
% 
% vidRecDelayW = setW; vidRecDelayH = setH; vidRecDelayX = vidRecDelayLabX + vidRecDelayLabW + bPad; vidRecDelayY = vidRecDelayLabY;
% this.GUI.handles.be.vidRecDelaySetter = uicontrol(commons{:}, 'String', ...
%     sprintf('[%.1f, %.1f]', this.be.params.vidRecDelay), 'Style', 'edit', ...
%     'Position', [vidRecDelayX vidRecDelayY vidRecDelayW vidRecDelayH], 'Callback', @(h, e)BEChangeVidRecDelay(this, h, e));

%% - #OCIACreateWindow: Behavior: Hardware panel: loop behavior radio group
loopBehavGroupW = (1 - 3 * bPad) * 0.3; loopBehavGroupH = imagEnableGroupH; 
loopBehavGroupX = bPad; loopBehavGroupY = imagEnableGroupY - bPad - loopBehavGroupH;
commons = {'Parent', this.GUI.handles.be.panels.hw, BGWhite{:}, NormUnits{:}};
this.GUI.handles.be.loopBehavGroup = uibuttongroup(commons{:}, 'Title', 'Loop behavior', ...
    'Position', [loopBehavGroupX loopBehavGroupY loopBehavGroupW loopBehavGroupH]);
commons = {'Parent', this.GUI.handles.be.loopBehavGroup, BGWhite{:}, NormUnits{:}, 'Style', 'radiobutton'};
loopBehavRadioW = (1 - 3 * bPad) * 0.5; loopBehavRadioH = 1 - 2 * bPad; 
loopBehavOnX = bPad; loopBehavOnY = bPad;
loopBehavOffX = bPad + loopBehavRadioW + bPad; loopBehavOffY = loopBehavOnY;
this.GUI.handles.be.loopBehavOn = uicontrol(commons{:}, 'String', 'On', ...
    'Position', [loopBehavOnX loopBehavOnY loopBehavRadioW loopBehavRadioH]);
this.GUI.handles.be.loopBehavOff = uicontrol(commons{:}, 'String', 'Off', ...
    'Position', [loopBehavOffX loopBehavOffY loopBehavRadioW loopBehavRadioH]);

%% - #OCIACreateWindow: Behavior: Hardware panel: loop behav delay setter
commons = {'Parent', this.GUI.handles.be.panels.hw, NormUnits{:}, 'FontSize', this.GUI.pos(4) / 115, BGWhite{:}};
commonFonts = {'Parent', this.GUI.handles.be.panels.hw, NormUnits{:}, 'FontSize', this.GUI.pos(4) / 145, BGWhite{:}};
loopBehavDelayLabW = labW * 0.5; loopBehavDelayLabH = labH * 1.2;
loopBehavDelayLabX = loopBehavGroupX + loopBehavGroupW + bPad; loopBehavDelayLabY = loopBehavGroupY + 0.115 * labH;
this.GUI.handles.be.loopBehavDelayLab = uicontrol(commonFonts{:}, 'String', 'Loop delay [s]', 'Style', 'text', ...
    'Position', [loopBehavDelayLabX loopBehavDelayLabY loopBehavDelayLabW loopBehavDelayLabH]);

loopBehavDelayW = setW; loopBehavDelayH = setH; loopBehavDelayX = loopBehavDelayLabX + loopBehavDelayLabW + bPad; ...
    loopBehavDelayY = loopBehavDelayLabY;
this.GUI.handles.be.loopBehavDelaySetter = uicontrol(commons{:}, 'String', ...
    sprintf('%.1f', this.be.params.loopBehavDelay), 'Style', 'edit', 'Callback', @(h, e)BEChangeLoopDelay(this, h, e), ...
    'Position', [loopBehavDelayX loopBehavDelayY loopBehavDelayW loopBehavDelayH]);

%% - #OCIACreateWindow: Behavior: Hardware panel: 'EarlyOn' reward fraction setter
EORewDelayLabW = labW * 0.5; EORewDelayLabH = labH * 1.3;
EORewDelayLabX = loopBehavDelayX + loopBehavDelayW + bPad; EORewDelayLabY = loopBehavGroupY;
this.GUI.handles.be.EORewDelayLab = uicontrol(commonFonts{:}, 'String', 'EO frac', 'Style', 'text', ...
    'Position', [EORewDelayLabX EORewDelayLabY EORewDelayLabW EORewDelayLabH]);

EORewDelayW = setW; EORewDelayH = setH; EORewDelayX = EORewDelayLabX + EORewDelayLabW + bPad;
EORewDelayY = EORewDelayLabY + 0.125 * labH;
this.GUI.handles.be.EORewDelaySetter = uicontrol(commons{:}, 'String', ...
    sprintf('%.2f', this.be.params.autoRewardEarlyOnTimeFraction), 'Style', 'edit', ...
    'Position', [EORewDelayX EORewDelayY EORewDelayW EORewDelayH], 'Callback', @(h, e)BEChangeEOFrac(this, h, e));

%% - #OCIACreateWindow: Behavior: Hardware panel: piezo baseline slider
piezoBLW = 1 - 4 * bPad - labW - setW; piezoBLH = connHWH * 0.8; piezoBLX = bPad; piezoBLY = loopBehavGroupY - 2 * pad - piezoBLH;
this.GUI.handles.be.piezoBL = uicontrol('Parent', this.GUI.handles.be.panels.hw, NormUnits{:}, 'Style', 'slider', ...
    'Min', 0, 'Max', 0.015, 'Position', [piezoBLX piezoBLY piezoBLW piezoBLH], 'Callback', @(h, e)BEPiezoBL(this, h, e), ...
    'SliderStep', [0.0001, 0.001]);

%% - #OCIACreateWindow: Behavior: Hardware panel: piezo baseline setter
piezoBLMedLabW = labW; piezoBLMedLabH = labH;
piezoBLMedLabX = piezoBLX + piezoBLW + bPad; piezoBLMedLabY = piezoBLY;
this.GUI.handles.be.piezoBLMedLab = uicontrol(commonFonts{:}, 'String', sprintf('Med = %0.8f', this.be.params.piezoBLMed), ...
    'Style', 'text', 'Position', [piezoBLMedLabX piezoBLMedLabY piezoBLMedLabW piezoBLMedLabH], ...
    'ButtonDownFcn', @(h, e)BEClearData(this));

piezoBLSetW = setW; piezoBLSetH = setH; piezoBLSetX = piezoBLMedLabX + piezoBLMedLabW + bPad;
piezoBLSetY = piezoBLMedLabY;
this.GUI.handles.be.piezoBLSetter = uicontrol(commons{:}, 'String', sprintf('%.2f', this.be.params.piezoBL), ...
    'Style', 'edit', 'Position', [piezoBLSetX piezoBLSetY piezoBLSetW piezoBLSetH], 'Callback', @(h, e)BEPiezoBL(this, h, e));

%{
%% - #OCIACreateWindow: Behavior: ETL panel: ETL slider and setters
ETLW = 1 - 2 * bPad; ETLH = connHWH * 0.8; ETLX = bPad; ETLY = 1 - ETLH - bPad;
this.GUI.handles.be.ETL = uicontrol('Parent', this.GUI.handles.be.panels.ETL, NormUnits{:}, 'Style', 'slider', ...
    'Min', 0, 'Max', 1, 'Position', [ETLX ETLY ETLW ETLH], 'Callback', @(h, e)BEETL(this, h, e), ...
    'SliderStep', [0.005, 0.01]);

%% - #OCIACreateWindow: Behavior: ETL panel: ETL volt and depth setter
commons = {'Parent', this.GUI.handles.be.panels.ETL, NormUnits{:}, 'FontSize', this.GUI.pos(4) / 95, BGWhite{:}};
labW = 0.15; labH = 0.1; setW = 0.12; setH = labH * 1.2;

ETLVoltLabW = labW * 0.9; ETLVoltLabH = labH;
ETLVoltLabX = ETLX; ETLVoltLabY = ETLY - ETLVoltLabH - 2 * bPad - labH * 0.1;
this.GUI.handles.be.ETLVoltLab = uicontrol(commons{:}, 'String', 'ETL [V]', 'Style', 'text', ...
    'Position', [ETLVoltLabX ETLVoltLabY ETLVoltLabW ETLVoltLabH]);
ETLVoltW = setW; ETLVoltH = setH;
ETLVoltX = ETLVoltLabX + ETLVoltLabW + bPad; ETLVoltY = ETLVoltLabY;
this.GUI.handles.be.ETLVoltSetter = uicontrol(commons{:}, 'String', sprintf('%.2f', this.be.params.minETLV), ...
    'Style', 'edit', 'Position', [ETLVoltX ETLVoltY ETLVoltW ETLVoltH], 'Callback', @(h, e)BEETL(this, h, e));

ETLDepthLabW = labW * 0.9; ETLDepthLabH = labH;
ETLDepthLabX = ETLVoltX + ETLVoltW + bPad; ETLDepthLabY = ETLVoltLabY;
this.GUI.handles.be.ETLDepthLab = uicontrol(commons{:}, 'String', 'ETL [um]', 'Style', 'text', ...
    'Position', [ETLDepthLabX ETLDepthLabY ETLDepthLabW ETLDepthLabH]);
ETLDepthW = setW; ETLDepthH = setH;
ETLDepthX = ETLDepthLabX + ETLDepthLabW + bPad; ETLDepthY = ETLDepthLabY;
this.GUI.handles.be.ETLDepthSetter = uicontrol(commons{:}, 'String', sprintf('%03d', this.be.params.minETLDepth), ...
    'Style', 'edit', 'Position', [ETLDepthX ETLDepthY ETLDepthW ETLDepthH], 'Callback', @(h, e)BEETL(this, h, e));

% create a context menu for the reset option
this.GUI.handles.be.ETLContextMenu = uicontextmenu('Parent', this.GUI.figH);
this.GUI.handles.be.clearETLTableContextMenu = uimenu(this.GUI.handles.be.ETLContextMenu, 'Label', 'Clear', ...
    'Callback', @(h, e)BEETLTableAction(this, [], [], 'clear'));
this.GUI.handles.be.createETLTableContextMenu = uimenu(this.GUI.handles.be.ETLContextMenu, 'Label', 'Create', ...
    'Callback', @(h, e)BEETLTableAction(this, [], [], 'create'));
this.GUI.handles.be.createETLTableContextMenu = uimenu(this.GUI.handles.be.ETLContextMenu, 'Label', 'Open ref.', ...
    'Callback', @(h, e)BEETLTableAction(this, [], [], 'openRef'));


%% - #OCIACreateWindow: Behavior: ETL table buttons
commons = {'Parent', this.GUI.handles.be.panels.ETL, NormUnits{:}, 'Style', 'pushbutton', 'FontSize', this.GUI.pos(4) / 45};
smallButW = 0.07; smallButH = setH; addRowX = ETLDepthX + ETLDepthW + 3 * bPad; addRowY = ETLVoltLabY;
this.GUI.handles.be.ETLAddRow = uicontrol(commons{:}, 'String', '+', ...
    'Position', [addRowX addRowY smallButW smallButH], 'Callback', @(h, e)BEETLTableAction(this, h, e, 'add'));
remRowX = addRowX + smallButW + bPad; remRowY = addRowY;
this.GUI.handles.be.ETLRemRow = uicontrol(commons{:}, 'String', '-', ...
    'Position', [remRowX remRowY smallButW smallButH], 'Callback', @(h, e)BEETLTableAction(this, h, e, 'remove'));
goRowX = remRowX + smallButW + bPad; goRowY = addRowY;
this.GUI.handles.be.ETLGoRow = uicontrol(commons{:}, 'String', 'GO', 'FontSize', this.GUI.pos(4) / 75, ...
    'Position', [goRowX goRowY smallButW * 2 smallButH], 'Callback', @(h, e)BEETLTableAction(this, h, e, 'go'));

%{
%% - #OCIACreateWindow: Behavior: ETL table
commons = {'Parent', this.GUI.handles.be.panels.ETL, NormUnits{:}, 'FontSize', this.GUI.pos(4) / 85};
tableW = 1 - 2 * bPad; tableH = ETLDepthY - 2 * bPad;
tableX = bPad; tableY = ETLDepthY - bPad - tableH;
tableWPixel = tableW * ETLPanW * this.GUI.pos(3);
tableColW = cellfun(@(x) x * tableWPixel, this.GUI.be.ETLTableColW);
if isGUI(this);
    this.GUI.handles.be.ETLTable = uitable(commons{:}, 'Tag', 'BEETLTable', 'Data', {}, ...
        'RowName', [], 'ColumnName', this.GUI.be.ETLTableColNames, 'ColumnW', num2cell(tableColW), ...
        'ColumnEditable', true(1, numel(tableColW)), 'Position', [tableX tableY tableW tableH], ...
        'CellEditCallback', @(h, e)BEETLTableAction(this, h, e, 'edit'),  ...
        'uicontextmenu', this.GUI.handles.be.ETLContextMenu);
else
    this.GUI.handles.be.ETLTable = uicontrol('Parent', this.GUI.handles.be.panels.ETL, NormUnits{:}, ...
        'Position', [tableX tableY tableW tableH], 'Tag', 'BEETLTable');
end;
%}
    
%}

%% - #OCIACreateWindow: Behavior: monitoring axes
commons = {'Color', repmat(0.85, 1, 3), NormUnits{:}};
monAxePadX = 0.04; monAxePadY = 0.05;
monAxeW = 1 - 2 * monAxePadX - 2 * pad; monAxeH = 1 - 3 * monAxePadY - 2 * pad;
monAxeX = monAxePadX + pad; monAxeY = monAxePadY + pad;
this.GUI.handles.be.monAxes = axes(commons{:}, 'Parent', this.GUI.handles.be.panels.mon, ...
    'Tag', 'BEMonAxes', 'Position', [monAxeX monAxeY monAxeW monAxeH]);


%% - #OCIACreateWindow: Behavior: performance axes
commons = {'Color', 'white', NormUnits{:}};
perfAxePadX = 0.05; perfAxePadY = 0.05;
perfAxeW = 1 - 2 * perfAxePadX - 2 * pad; perfAxeH = 1 - 2 * perfAxePadY - 2 * pad;
perfAxeX = perfAxePadX + pad; perfAxeY = perfAxePadY + pad;
this.GUI.handles.be.perfAxes = axes(commons{:}, 'Parent', this.GUI.handles.be.panels.perf, ...
    'Tag', 'BEPerfAxes', 'Position', [perfAxeX perfAxeY perfAxeW perfAxeH]);

%% - #OCIACreateWindow: Behavior: config table
commons = { NormUnits{:} }; %#ok<CCAT1>
tableW = 1 - 2 * bPad; tableH = 0.2 - 1.5 * bPad; tableX = bPad; tableY = 1 - tableH - bPad;
randomOffset = 15;
tableWPixel = tableW * ConfPanW * this.GUI.pos(3) - randomOffset;
tableColW = cellfun(@(x) x * tableWPixel, this.GUI.be.confTableColW);
if isGUI(this);
    this.GUI.handles.be.confTable = uitable('Parent', this.GUI.handles.be.panels.conf, ...
        commons{:}, 'Position', [tableX tableY tableW tableH], 'Tag', 'BEConfTable', ...
        'Data', {}, 'RowName', [], 'ColumnName', this.GUI.be.confTableColNames, ...
        'ColumnW', num2cell(tableColW));
else
    this.GUI.handles.be.confTable = uicontrol('Parent', this.GUI.handles.be.panels.conf, NormUnits{:}, ...
        'Position', [tableX tableY tableW tableH], 'Tag', 'BEConfTable');
end;

%% - #OCIACreateWindow: Behavior: config load button
commons = {'Parent', this.GUI.handles.be.panels.conf, NormUnits{:}, 'Style', 'togglebutton', ...
    'BackgroundColor', 'red', 'FontSize', this.GUI.pos(4) / 85};
loadConfW = 0.33 - 2.5 * bPad; loadConfH = 0.05;
loadConfX = bPad; loadConfY = 1 - tableH - bPad - loadConfH - bPad;
this.GUI.handles.be.loadConf = uicontrol(commons{:}, 'String', 'Load config', 'Tag', 'BELoadConf', ...
    'Position', [loadConfX loadConfY loadConfW loadConfH], 'Callback', @(h, e)BELoadConfig(this, h, e));

%% - #OCIACreateWindow: Behavior: config apply button
commons = {'Parent', this.GUI.handles.be.panels.conf, NormUnits{:}, 'FontSize', this.GUI.pos(4) / 85, ...
    'Style', 'pushbutton'};
applyConfW = loadConfW; applyConfH = loadConfH;
applyConfX = loadConfX + loadConfW + bPad; applyConfY = loadConfY;
this.GUI.handles.be.applyConf = uicontrol(commons{:}, 'String', 'Apply config', 'Tag', 'BEApplyConf', ...
    'Position', [applyConfX applyConfY applyConfW applyConfH], 'Callback', @(h, e)BEApplyConfig(this, h, e));

%% - #OCIACreateWindow: Behavior: config reset button
resetConfW = loadConfW; resetConfH = loadConfH;
resetConfX = applyConfX + applyConfW + bPad; resetConfY = loadConfY;
this.GUI.handles.be.resetConf = uicontrol(commons{:}, 'String', 'Reset configs', 'Tag', 'BEResetConf', ...
    'Position', [resetConfX resetConfY resetConfW resetConfH], 'Callback', @(h, e)BEResetConfig(this, h, e));

%% - #OCIACreateWindow: Behavior: config parameter panels
commons = {'Parent', this.GUI.handles.be.panels.conf, BGWhite{:}, NormUnits{:}, 'FontSize', this.GUI.pos(4) / 125};
paramPanPanW = 1 - 2 * bPad; paramPanPanH = 0.78 - 3 * bPad; paramPanPanX = bPad; paramPanPanY = bPad;
this.GUI.handles.be.paramPan = uipanel(commons{:}, 'Title', 'Config parameters', 'Tag', 'BEParamPan', ...
    'Position', [paramPanPanX paramPanPanY paramPanPanW paramPanPanH]);

%% - #OCIACreateWindow: Behavior: experiment control buttons
commons = {'Parent', this.GUI.handles.be.panels.exp, NormUnits{:}, 'FontSize', this.GUI.pos(4) / 85};
startExpW = 0.2 - 1.5 * bPad; startExpH = 0.1;
startExpX = bPad; startExpY = 1 - startExpH - bPad;
this.GUI.handles.be.startExp = uicontrol(commons{:}, 'String', 'Start', 'Style', 'togglebutton', ...
    'BackgroundColor', 'red', 'Position', [startExpX startExpY startExpW startExpH], ...
    'Callback', @(h, e)BEStartExp(this, h, e));
pauseExpW = startExpW; pauseExpH = startExpH;
pauseExpX = startExpX + startExpW + bPad; pauseExpY = startExpY;
this.GUI.handles.be.pauseExp = uicontrol(commons{:}, 'String', 'Pause', 'Style', 'togglebutton', ...
    'BackgroundColor', 'red', 'Position', [pauseExpX pauseExpY pauseExpW pauseExpH], ...
    'Callback', @(h, e)BEPauseExp(this, h, e));
stopExpW = startExpW; stopExpH = startExpH;
stopExpX = pauseExpX + pauseExpW + bPad; stopExpY = startExpY;
this.GUI.handles.be.stopExp = uicontrol(commons{:}, 'String', 'Stop', 'Style', 'pushbutton', ...
    'Position', [stopExpX stopExpY stopExpW stopExpH], 'Callback', @(h, e)BEStopExp(this, h, e));

%% - #OCIACreateWindow: Behavior: experiment table
commons = {'Parent', this.GUI.handles.be.panels.exp, NormUnits{:}, 'FontSize', this.GUI.pos(4) / 55};
tableW = 1 - 2 * bPad; tableH = 1 - 1.5 * bPad - startExpH - 1.5 * bPad;
tableX = bPad; tableY = 1 - bPad - startExpH - bPad - tableH; randomOffset = 0;
tableWPixel = tableW * ExpPanW * this.GUI.pos(3) - randomOffset;
tableColW = cellfun(@(x) x * tableWPixel, this.GUI.be.expTableColW);
if isGUI(this);
    this.GUI.handles.be.expTable = uitable(commons{:}, 'Tag', 'BEExpTable', ...
        'Data', {}, 'RowName', this.GUI.be.expTableRowNames, 'ColumnName', this.GUI.be.expTableColNames, ...
        'ColumnW', num2cell(tableColW), 'Position', [tableX tableY tableW tableH]);
else
    this.GUI.handles.be.expTable = uicontrol('Parent', this.GUI.handles.be.panels.exp, NormUnits{:}, ...
        'Position', [tableX tableY tableW tableH], 'Tag', 'BEExpTable');
end;

end
