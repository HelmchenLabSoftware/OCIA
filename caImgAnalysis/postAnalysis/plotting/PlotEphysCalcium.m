function PlotEphysCalcium(varargin)

%% Select variables and Rois

SaveFigs = 0;

vars = evalin('base','who');
if ~isempty(vars)
    [choice,status] = listdlg('PromptString','Select a variable:',...
        'SelectionMode','single',...
        'ListString',vars);
    if ~status return; end
else
    warndlg('No variables in base workspace!');return
end
target_var = vars{choice};
config = evalin('base',target_var);

% vector of stim times (in s)
stims = [6.27 12.68 19.08 25.48 31.88 38.28 44.69];

if ~isfield(config,'roi_dff_trace')
   config.roi_dff_trace = config.roi_stats;
end

if ~iscell(config.roi_dff_trace)
    roi_number = 1;
    roi_trace = {config.roi_dff_trace};
    roi_names{1} = '1';
else
    if length(config.roi_dff_trace) > 1
        % multiple ROIs have been encoded
        roi_number = length(config.roi_dff_trace);
        % ask user which ROI to choose
        if isfield(config,'roi_id')
            list_str = config.roi_id;
        else
            list_str = {'1'};
            for n = 2:roi_number
                list_str{length(list_str)+1} = int2str(n);
            end
        end
        [selection,status] = listdlg('PromptString','Select a ROI:',...
            'ListString',list_str);
        if ~status return; end
        roi_number = length(selection);
        for n = 1:roi_number
            roi_trace{n} = config.roi_dff_trace{selection(n)};
            roi_names{n} = config.roi_id{selection(n)};
        end
    else
        roi_number = 1;
        roi_trace{1} = config.roi_dff_trace{1};
        roi_names{1} = '1';
    end
end
spikes = config.ephys;
freq_ap = config.freq_ap;
freq_ca = config.freq_ca;

% filter traces and spike train
% spikes = mpi_BandPassFilterTimeSeries(spikes,1/freq_ap,100,1000);
for n = 1:length(roi_trace)
   roi_trace{n} = mpi_BandPassFilterTimeSeries(roi_trace{n},1/freq_ca,0.1,50);
end

%% Calculate and adjust time axis
[dur_ca time_ca] = gui_CalculateTimeVector(roi_trace{1},freq_ca,[]);
[dur_ap time_ap] = gui_CalculateTimeVector(spikes,freq_ap,[]);
% correct Ca-trace for ROI acquisition time
if isfield(config,'ca_shift')
    dur_ca = dur_ca - config.ca_shift;
    time_ca = time_ca - config.ca_shift;
    fprintf('\nCorrected Ca-trace for Roi acquisition time (%1.4f s)\n',...
        config.ca_shift);
end

%% Plot
figure('Name',target_var,'NumberTitle','off'), hold all
min_roi = 10000;
for n = 1:length(roi_trace)
    if min(roi_trace{n}) < min_roi
       min_roi = min(roi_trace{n});
    end
end
spikes = linScale(spikes,min(roi_trace{1}),max(roi_trace{1}));
% offset spikes such that max(spikes) = min_roi
if max(spikes) > min_roi
   spikes = spikes - (abs(max(spikes)-min_roi));
end
% plot spikes first
plot(time_ap,spikes)
legendstr{1} = 'ephys';
% plot Ca-traces
for n = 1:length(roi_trace)
    plot(time_ca,roi_trace{n});
    legendstr{n+1} = roi_names{n};
end
% plot stims
for n = 1:length(stims)
    ypos = [max(roi_trace{1}) max(roi_trace{1})+abs(max(roi_trace{1})/10)];
    line([stims(n) stims(n)],ypos,'Color','k');
    if n == 1
        legendstr{length(legendstr)+1} = 'Stim';
        legend(legendstr)
    end
end
% set(gca,'xlim',[min([min(time_ca) min(time_ap)]) ...
%     max([max(time_ca) max(time_ap)])]);

set(gca,'xlim',[0 51.5]);
% set(gca,'ylim',[-5 10]);

if SaveFigs
    savename = strrep(target_var,'_config','_CellsNpil.fig');
    saveas(gcf,savename);
end

%% old
% ephys_freq = 10000; % frequency for ephys in Hz
% ca_freq = 7.81; % frequency for calcium signal in Hz
% 
% % estimate duration from Ca trace
% ca_dur = 1/ca_freq*numel(ca_trace);
% % estimate duration from Ephys trace
% ephys_dur = 1/ephys_freq*numel(ephys);
% 
% % make time axis for ephys
% ephys_time = (1/ephys_freq):(1/ephys_freq):ephys_dur;
% % if numel(ephys_time) > numel(ephys)
% %     ephys((numel(ephys)+1):numel(ephys_time)) = NaN;
% % elseif numel(ephys_time) < numel(ephys)
% %     ephys((numel(ephys_time))+1:numel(ephys)) = [];
% % end
% ephys_time = reshape(ephys_time,size(ephys));
% 
% 
% % make time axis for calcium
% ca_time = (1/ca_freq):(1/ca_freq):ca_dur;
% % if numel(ca_time) > numel(ca_trace)
% %     ca_trace((numel(ca_trace)+1):numel(ca_time)) = NaN;
% % elseif numel(ca_time) < numel(ca_trace)
% %     ca_trace((numel(ca_time))+1:numel(ca_trace)) = [];
% % end
% ca_time = reshape(ca_time,size(ca_trace));
% 
% ca_trace = ca_trace - mean(ca_trace);
% 
% ca_trace = ScaleTo8bit(ca_trace);
% ephys = ScaleTo8bit(ephys);
% FrameClock = ScaleTo8bit(FrameClock);
% 
% % plot
% % plot(ephys_time,FrameClock,'k'); hold on
% plot(ephys_time,ephys); hold on
% plot(ca_time,ca_trace,'r'); hold off