function OCIA_createWindow_discriminator(this, pad)
% OCIA_createWindow_discriminator - [no description]
%
%       OCIA_createWindow_discriminator(this, pad)
%
% [No description]
%
% 2013-2016 - Copyleft and programmed by Balazs Laurenczy (blaurenczy_at_gmail.com)

delete(get(this.GUI.handles.panels.DiscriminatorPanel, 'Child'));

BGWhite = {'Background', 'white'}; %#ok<*CCAT>
NormUnits = {'Units', 'normalized'};

%% - #OCIACreateWindow: panels
commons = {'Parent', this.GUI.handles.panels.DiscriminatorPanel, BGWhite{:}, NormUnits{:}, 'Visible', 'on', ...
    'FontSize', this.GUI.pos(4) / 55 };
MessPanW = 0.60 - 1.5 * pad;        MessPanH = 0.134 - 1.5 * pad;
TimePanW = 0.60 - 1.5 * pad;        TimePanH = 0.134 - 1.5 * pad;
RespPanW = 0.60 - 1.5 * pad;        RespPanH = 0.134 - 1.5 * pad;
PerfPanW = 0.40 - 1.5 * pad;        PerfPanH = 0.400 - 1.5 * pad;
CamePanW = 0.57 - 1.5 * pad;        CamePanH = 0.600 - 1.5 * pad;
ActiPanW = 0.43 - 1.5 * pad;        ActiPanH = 0.600 - 1.5 * pad;
this.GUI.handles.di.panels.mess = uipanel(commons{:}, 'Title', 'Message', 'Tag', 'DiscriminatorMess', ...
    'Position', [pad 1 - pad - MessPanH MessPanW MessPanH]);
this.GUI.handles.di.panels.time = uipanel(commons{:}, 'Title', 'Reponse time', 'Tag', 'DiscriminatorTime', ...
    'Position', [pad 1 - pad - MessPanH - pad - TimePanH TimePanW TimePanH], commons{:});
this.GUI.handles.di.panels.resp = uipanel(commons{:}, 'Title', 'Response rate', 'Tag', 'DiscriminatorResp', ...
    'Position', [pad 1 - pad - MessPanH - pad - RespPanH - pad - TimePanH RespPanW RespPanH], commons{:});
this.GUI.handles.di.panels.perf = uipanel(commons{:}, 'Title', 'Performance', 'Tag', 'DiscriminatorPerf', ...
    'Position', [pad + MessPanW + pad  1 - pad - PerfPanH PerfPanW PerfPanH]);
this.GUI.handles.di.panels.came = uipanel(commons{:}, 'Title', 'Camera', 'Tag', 'DiscriminatorCame', ...
    'Position', [pad pad CamePanW CamePanH]);
this.GUI.handles.di.panels.acti = uipanel(commons{:}, 'Title', 'Activity', 'Tag', 'DiscriminatorActi', ...
    'Position', [pad + CamePanW + pad pad ActiPanW ActiPanH]);

%% - #OCIACreateWindow: Discriminator: message box
labelCommons = [commons, 'Style', 'text', 'FontSize', this.GUI.pos(4) / 30, 'HorizontalAlignment', 'center'];
messBoxW = 1 - 2 * pad; messBoxH = 0.6; messBoxX = pad; messBoxY = (1 - messBoxH) * 0.50;
this.GUI.handles.di.messBoxBack = uicontrol(labelCommons{:}, 'Parent', this.GUI.handles.di.panels.mess, 'String', '', ...
    'Tag', 'DiscriminatorMessBox', 'Position', [0 0 1 1], 'Background', 'yellow');
this.GUI.handles.di.messBox = uicontrol(labelCommons{:}, 'Parent', this.GUI.handles.di.panels.mess, 'String', 'Trial start ...', ...
    'Tag', 'DiscriminatorMessBox', 'Position', [messBoxX messBoxY messBoxW messBoxH], 'Background', 'yellow');

%% - #OCIACreateWindow: Discriminator: reponse time axes
commons = {'Color', 'white', NormUnits{:}};
respTimeAxePadX = 0.005; respTimeAxePadY = 0.2;
respTimeAxeW = 1 - 2 * respTimeAxePadX - 2 * pad; respTimeAxeH = 1 - 2 * respTimeAxePadY - 2 * pad;
respTimeAxeX = respTimeAxePadX + pad; respTimeAxeY = respTimeAxePadY + pad;
this.GUI.handles.di.respTimeAxe = axes(commons{:}, 'Parent', this.GUI.handles.di.panels.time, 'XTick', [], 'YTick', [], ...
    'XColor', 'white', 'YColor', 'white', 'Tag', 'DiscriminatorRespTimeAxes', 'Position', [respTimeAxeX respTimeAxeY respTimeAxeW respTimeAxeH]);

%% - #OCIACreateWindow: Discriminator: response rate axes
commons = {'Color', 'white', NormUnits{:}};
respRateAxePadX = 0.005; respRateAxePadY = 0.2;
respRateAxeW = 1 - 2 * respRateAxePadX - 2 * pad; respRateAxeH = 1 - 2 * respRateAxePadY - 2 * pad;
respRateAxeX = respRateAxePadX + pad; respRateAxeY = respRateAxePadY + pad;
this.GUI.handles.di.respRateAxe = axes(commons{:}, 'Parent', this.GUI.handles.di.panels.resp, 'XTick', [], 'YTick', [], ...
    'Tag', 'DiscriminatorRespRateAxes', 'Position', [respRateAxeX respRateAxeY respRateAxeW respRateAxeH], ...
    'XColor', 'white', 'YColor', 'white');

%% - #OCIACreateWindow: Discriminator: performance axes
perfAxePadX = 0.1; perfAxePadY = 0.1;
perfAxeW = 1 - 2 * perfAxePadX - 2 * pad; perfAxeH = 1 - 2 * perfAxePadY - 2 * pad;
perfAxeX = perfAxePadX + pad; perfAxeY = perfAxePadY + pad;
this.GUI.handles.di.perfAxe = axes(commons{:}, 'Parent', this.GUI.handles.di.panels.perf, ...
    'Tag', 'DiscriminatorPerfAxes', 'Position', [perfAxeX perfAxeY perfAxeW perfAxeH]);

%% - #OCIACreateWindow: Discriminator: camera axes
camAxePadX = 0.000; camAxePadY = 0.000;
camAxeW = 1 - 2 * camAxePadX - 2 * pad; camAxeH = 1 - 2 * camAxePadY - 2 * pad;
camAxeX = camAxePadX + pad; camAxeY = camAxePadY + pad;
this.GUI.handles.di.camAxe = axes(commons{:}, 'Parent', this.GUI.handles.di.panels.came, ...
    'Tag', 'DiscriminatorcamAxes', 'Position', [camAxeX camAxeY camAxeW camAxeH], 'XTick', [], 'YTick', []);
axis(this.GUI.handles.di.camAxe, 'equal');

%% - #OCIACreateWindow: Discriminator: activity axes
actiAxePadX = 0.000; actiAxePadY = 0.000;
actiAxeW = 1 - 2 * actiAxePadX - 2 * pad; actiAxeH = 1 - 2 * actiAxePadY - 2 * pad;
actiAxeX = actiAxePadX + pad; actiAxeY = actiAxePadY + pad;
this.GUI.handles.di.actiAxe = axes(commons{:}, 'Parent', this.GUI.handles.di.panels.acti, ...
    'Tag', 'DiscriminatoractiAxes', 'Position', [actiAxeX actiAxeY actiAxeW actiAxeH]);
axis(this.GUI.handles.di.actiAxe, 'equal');

%{

%% - #OCIACreateWindow: Discriminator: Hardware panel: connect hardware and valve control buttons
bPad = 0.02;
commons = {'Parent', this.GUI.handles.di.panels.hw, NormUnits{:}, 'Style', 'togglebutton', ...
    'BackgroundColor', 'red', 'FontSize', this.GUI.pos(4) / 85};
connHWW = 0.5 - 1.5 * bPad; connHWH = 0.1; connHWX = bPad; connHWY = 1 - connHWH - bPad;
this.GUI.handles.di.connHW = uicontrol(commons{:}, 'String', 'Connect HW', ...
    'Position', [connHWX connHWY connHWW connHWH], 'Callback', @(h, e)BEConnHW(this, h, e));
valveCtrlW = connHWW; valveCtrlH = connHWH; valveCtrlX = connHWX; valveCtrlY = connHWY - bPad - valveCtrlH;
this.GUI.handles.di.valveCtrl = uicontrol(commons{:}, 'String', 'Valve Control', ...
    'Position', [valveCtrlX valveCtrlY valveCtrlW valveCtrlH], 'Callback', @(h, e)BEValveControl(this, h, e));
airPuffCtrlW = connHWW; airPuffCtrlH = connHWH; airPuffCtrlX = connHWX; airPuffCtrlY = valveCtrlY - bPad - airPuffCtrlH;
this.GUI.handles.di.airPuffCtrl = uicontrol(commons{:}, 'String', 'Air Puff Control', ...
    'Position', [airPuffCtrlX airPuffCtrlY airPuffCtrlW airPuffCtrlH], 'Callback', @(h, e)BEAirPuffControl(this, h, e));
imagTTLW = connHWW; imagTTLH = connHWH; imagTTLX = connHWX; imagTTLY = airPuffCtrlY - bPad - imagTTLH;
this.GUI.handles.di.imagTTL = uicontrol(commons{:}, 'String', 'Imaging TTL', ...
    'Position', [imagTTLX imagTTLY imagTTLW imagTTLH], 'Callback', @(h, e)BEImagingTTL(this, h, e));

commons = {'Parent', this.GUI.handles.di.panels.hw, NormUnits{:}, 'Style', 'pushbutton', ...
    'FontSize', this.GUI.pos(4) / 85};
givRewW = connHWW; givRewH = connHWH; givRewX = valveCtrlX + bPad + valveCtrlW; givRewY = valveCtrlY;
this.GUI.handles.di.givRew = uicontrol(commons{:}, 'String', 'Give reward', ...
    'Position', [givRewX givRewY givRewW givRewH], 'Callback', @(h, e)BEGiveReward(this, h, e));
givAirPuffW = connHWW; givAirPuffH = connHWH; givAirPuffX = airPuffCtrlX + bPad + airPuffCtrlW; givAirPuffY = airPuffCtrlY;
this.GUI.handles.di.givAirPuff = uicontrol(commons{:}, 'String', 'Give punishment', ...
    'Position', [givAirPuffX givAirPuffY givAirPuffW givAirPuffH], 'Callback', @(h, e)BEGiveAirPuff(this, h, e));

%% - #OCIACreateWindow: Discriminator: Hardware panel: reward duration and piezo threshold setter
commons = {'Parent', this.GUI.handles.di.panels.hw, NormUnits{:}, 'FontSize', this.GUI.pos(4) / 75, ...
    BGWhite{:}};
rewDurLabW = 0.7 - 1.5 * bPad; rewDurLabH = 0.07;
rewDurLabX = bPad; rewDurLabY = imagTTLY - rewDurLabH - bPad - 0.2 * bPad;
this.GUI.handles.di.rewDurLab = uicontrol(commons{:}, 'String', 'Reward duration [sec]', ...
    'Position', [rewDurLabX rewDurLabY rewDurLabW rewDurLabH], 'Style', 'text');
punishDurLabW = rewDurLabW; punishDurLabH = rewDurLabH;
punishDurLabX = bPad; punishDurLabY = rewDurLabY - punishDurLabH - bPad - 0.2 * bPad;
this.GUI.handles.di.punishDurLab = uicontrol(commons{:}, 'String', 'Punish duration [sec]', 'Style', 'text', ...
    'Position', [punishDurLabX punishDurLabY punishDurLabW punishDurLabH]);
piezoThreshLabW = rewDurLabW; piezoThreshLabH = rewDurLabH;
piezoThreshLabX = bPad; piezoThreshLabY = punishDurLabY - piezoThreshLabH - bPad - 0.2 * bPad;
this.GUI.handles.di.piezoThreshLab = uicontrol(commons{:}, 'String', 'Piezo threshold', 'Style', 'text', ...
    'Position', [piezoThreshLabX piezoThreshLabY piezoThreshLabW piezoThreshLabH]);
rewDurW = 0.3 - 1.5 * bPad; rewDurH = rewDurLabH; rewDurX = bPad + rewDurLabW + bPad; rewDurY = rewDurLabY;
this.GUI.handles.di.rewDurSetter = uicontrol(commons{:}, 'String', '0.02', 'Style', 'edit', ...
    'Position', [rewDurX rewDurY rewDurW rewDurH], 'Callback', @(h, e)BEChangeRewDur(this, h, e));
punishDurW = 0.3 - 1.5 * bPad; punishDurH = punishDurLabH; punishDurX = bPad + punishDurLabW + bPad; punishDurY = punishDurLabY;
this.GUI.handles.di.punishDurSetter = uicontrol(commons{:}, 'String', '0.4', 'Style', 'edit', ...
    'Position', [punishDurX punishDurY punishDurW punishDurH], 'Callback', @(h, e)BEChangePunishDur(this, h, e));
piezoThreshW = rewDurW; piezoThreshH = rewDurH;
piezoThreshX = bPad + piezoThreshLabW + bPad; piezoThreshY = piezoThreshLabY;
this.GUI.handles.di.piezoThreshSetter = uicontrol(commons{:}, 'String', '0.007', 'Style', 'edit', ...
    'Position', [piezoThreshX piezoThreshY piezoThreshW piezoThreshH], ...
    'Callback', @(h, e)BEChangePiezoThresh(this, h, e));

%% - #OCIACreateWindow: Discriminator: Hardware panel: Imaging enable radio group
imagEnableGroupW = (1 - 3 * bPad) * 0.3; imagEnableGroupH = 0.1;
imagEnableGroupX = bPad; imagEnableGroupY = piezoThreshY - bPad - imagEnableGroupH;
commons = {'Parent', this.GUI.handles.di.panels.hw, BGWhite{:}, NormUnits{:}};
this.GUI.handles.di.imageEnableGroup = uibuttongroup(commons{:}, 'Title', 'Imaging enabled', ...
    'Position', [imagEnableGroupX imagEnableGroupY imagEnableGroupW imagEnableGroupH]);
commons = {'Parent', this.GUI.handles.di.imageEnableGroup, BGWhite{:}, ...
    NormUnits{:}, 'Style', 'radiobutton'};
imagEnableRadioW = (1 - 3 * bPad) * 0.5; imagEnableRadioH = 1 - 2 * bPad;
imagEnableOnX = bPad; imagEnableOnY = bPad;
imagEnableOffX = bPad + imagEnableRadioW + bPad; imagEnableOffY = imagEnableOnY;
this.GUI.handles.di.imageEnableOn = uicontrol(commons{:}, 'String', 'On', ...
    'Position', [imagEnableOnX imagEnableOnY imagEnableRadioW imagEnableRadioH]);
this.GUI.handles.di.imageEnableOff = uicontrol(commons{:}, 'String', 'Off', ...
    'Position', [imagEnableOffX imagEnableOffY imagEnableRadioW imagEnableRadioH]);
% set the option to be selected 
set(this.GUI.handles.di.imageEnableGroup, 'SelectedObject', this.GUI.handles.di.imageEnableOn);

%% - #OCIACreateWindow: Discriminator: Hardware panel: Auto-reward mode radio group
autoRewGroupW = (1 - 3 * bPad) * 0.7; autoRewGroupH = 0.1;
autoRewGroupX = imagEnableGroupX + imagEnableGroupW + bPad; autoRewGroupY = imagEnableGroupY;
commons = {'Parent', this.GUI.handles.di.panels.hw, BGWhite{:}, NormUnits{:}};
this.GUI.handles.di.autoRewGroup = uibuttongroup(commons{:}, 'Title', 'Auto-reward mode', ...
    'Position', [autoRewGroupX autoRewGroupY autoRewGroupW autoRewGroupH]);
commons = {'Parent', this.GUI.handles.di.autoRewGroup, BGWhite{:}, ...
    NormUnits{:}, 'Style', 'radiobutton'};
nAutoRewModes = numel(this.GUI.di.autoRewModes);
%             autoRewRadioW = (1 - (nAutoRewModes + 1) * bPad) / nAutoRewModes;
autoRewRW = (1 - (nAutoRewModes + 1) * bPad) / nAutoRewModes;
autoRewRWs = [autoRewRW * 1.3 autoRewRW * 0.8 autoRewRW * 1 autoRewRW * 0.8]; autoRewRH = 1 - 2 * bPad;
autoRewRX = [bPad 2 * bPad + autoRewRWs(1) 3 * bPad + sum(autoRewRWs(1:2)) 4 * bPad + sum(autoRewRWs(1:3))];
for iMode = 1 : nAutoRewModes;
    this.GUI.handles.di.(sprintf('autoRew%sMode', this.GUI.di.autoRewModes{iMode})) = ...
        uicontrol(commons{:}, 'String', this.GUI.di.autoRewModes{iMode}, ...
        'Position', [autoRewRX(iMode), bPad, autoRewRWs(iMode), autoRewRH]);
end;
% set the option to be selected and the callback function
set(this.GUI.handles.di.autoRewGroup, 'SelectionChangeFcn', @(h, e)BEChangeAutoRewardMode(this, h, e), ...
    'SelectedObject', this.GUI.handles.di.(sprintf('autoRew%sMode', this.GUI.di.autoRewModes{3})));

%% - #OCIACreateWindow: Discriminator: monitoring axes
commons = {'Color', repmat(0.85, 1, 3), NormUnits{:}};
monAxePadX = 0.04; monAxePadY = 0.05;
monAxeW = 1 - 2 * monAxePadX - 2 * pad; monAxeH = 1 - 2 * monAxePadY - 2 * pad;
monAxeX = monAxePadX + pad; monAxeY = monAxePadY + pad;
this.GUI.handles.di.monAxes = axes(commons{:}, 'Parent', this.GUI.handles.di.panels.mon, ...
    'Tag', 'DiscriminatorMonAxes', 'Position', [monAxeX monAxeY monAxeW monAxeH]);


%% - #OCIACreateWindow: Discriminator: performance axes
commons = {'Color', 'white', NormUnits{:}};
actiAxePadX = 0.05; actiAxePadY = 0.05;
actiAxeW = 1 - 2 * actiAxePadX - 2 * pad; actiAxeH = 1 - 2 * actiAxePadY - 2 * pad;
actiAxeX = actiAxePadX + pad; actiAxeY = actiAxePadY + pad;
this.GUI.handles.di.actiAxes = axes(commons{:}, 'Parent', this.GUI.handles.di.panels.perf, ...
    'Tag', 'DiscriminatoractiAxes', 'Position', [actiAxeX actiAxeY actiAxeW actiAxeH]);

%% - #OCIACreateWindow: Discriminator: config table
commons = {NormUnits{:}};
tableW = 1 - 2 * bPad; tableH = 0.8 - 1.5 * bPad; tableX = bPad; tableY = 1 - tableH - bPad;
randomOffset = 15;
tableWPixel = tableW * ConfPanW * this.GUI.pos(3) - randomOffset;
tableColumnWidths = cellfun(@(x) x * tableWPixel, this.GUI.di.confTableColW);
if isGUI(this);
    this.GUI.handles.di.confTable = uitable('Parent', this.GUI.handles.di.panels.conf, ...
        commons{:}, 'Position', [tableX tableY tableW tableH], 'Tag', 'DiscriminatorConfTable', ...
        'Data', {}, 'RowName', [], 'ColumnName', this.GUI.di.confTableColNames, ...
        'ColumnW', num2cell(tableColumnWidths));
else
    this.GUI.handles.dw.table = uicontrol('Parent', this.GUI.handles.di.panels.conf, NormUnits{:}, ...
        'Position', [tableX tableY tableW tableH], 'Tag', 'DiscriminatorConfTable');
end;

%% - #OCIACreateWindow: Discriminator: config load buttons
commons = {'Parent', this.GUI.handles.di.panels.conf, NormUnits{:}, 'Style', 'togglebutton', ...
    'BackgroundColor', 'red', 'FontSize', this.GUI.pos(4) / 85};
loadConfW = 0.5 - 1.5 * bPad; loadConfH = 0.1;
loadConfX = bPad; loadConfY = 1 - tableH - bPad - loadConfH - bPad;
this.GUI.handles.di.loadConf = uicontrol(commons{:}, 'String', 'Load config', ...
    'Position', [loadConfX loadConfY loadConfW loadConfH], 'Callback', @(h, e)BELoadConfig(this, h, e));

%% - #OCIACreateWindow: Discriminator: experiment control buttons
commons = {'Parent', this.GUI.handles.di.panels.exp, NormUnits{:}, 'FontSize', this.GUI.pos(4) / 85};
startExpW = 0.2 - 1.5 * bPad; startExpH = 0.1;
startExpX = bPad; startExpY = 1 - startExpH - bPad;
this.GUI.handles.di.startExp = uicontrol(commons{:}, 'String', 'Start', 'Style', 'togglebutton', ...
    'BackgroundColor', 'red', 'Position', [startExpX startExpY startExpW startExpH], ...
    'Callback', @(h, e)BEStartExp(this, h, e));
pauseExpW = startExpW; pauseExpH = startExpH;
pauseExpX = startExpX + startExpW + bPad; pauseExpY = startExpY;
this.GUI.handles.di.pauseExp = uicontrol(commons{:}, 'String', 'Pause', 'Style', 'togglebutton', ...
    'BackgroundColor', 'red', 'Position', [pauseExpX pauseExpY pauseExpW pauseExpH], ...
    'Callback', @(h, e)BEPauseExp(this, h, e));
stopExpW = startExpW; stopExpH = startExpH;
stopExpX = pauseExpX + pauseExpW + bPad; stopExpY = startExpY;
this.GUI.handles.di.stopExp = uicontrol(commons{:}, 'String', 'Stop', 'Style', 'pushbutton', ...
    'Position', [stopExpX stopExpY stopExpW stopExpH], 'Callback', @(h, e)BEStopExp(this, h, e));

%% - #OCIACreateWindow: Discriminator: experiment table
commons = {'Parent', this.GUI.handles.di.panels.exp, NormUnits{:}, 'FontSize', this.GUI.pos(4) / 40};
tableW = 1 - 2 * bPad; tableH = 1 - 1.5 * bPad - startExpH - 1.5 * bPad;
tableX = bPad; tableY = 1 - bPad - startExpH - bPad - tableH; randomOffset = 0;
tableWPixel = tableW * ExpPanW * this.GUI.pos(3) - randomOffset;
%             tableHPixel = tableH * ExpPanH * this.GUI.pos(4) - randomOffset;
tableColumnWidths = cellfun(@(x) x * tableWPixel, this.GUI.di.expTableColW);
%             tableRowH = cellfun(@(x) x * tableHPixel, this.GUI.di.expTableRowH);
if isGUI(this);
    this.GUI.handles.di.expTable = uitable(commons{:}, 'Tag', 'DiscriminatorExpTable', ...
        'Data', {}, 'RowName', this.GUI.di.expTableRowNames, 'ColumnName', this.GUI.di.expTableColNames, ...
        'ColumnW', num2cell(tableColumnWidths), 'Position', [tableX tableY tableW tableH]);
else
    this.GUI.handles.dw.table = uicontrol('Parent', this.GUI.handles.di.panels.exp, NormUnits{:}, ...
        'Position', [tableX tableY tableW tableH], 'Tag', 'DiscriminatorExpTable');
end;
    
    %}

end
