function trials = import_trial_log_with_output(fileName)

% begin
contents = tdfread(fileName);
Event = cellstr(contents.Event);
Time = cellstr(contents.Time);
Trial = contents.Trial;
Date = contents.Date;

a = size(Event);
a = a(1);
id = 1;
trials = [];

for i = 1:a
    if strcmp(Event(i),'Begin Trial / Recording') 
        trial.id = id;
        trial.no = Trial(i);
        time = Time{i};
        trial.time_stamp = time;
        start_time = get_time(time);
        trial.puff = [];
        trial.auto_reward = NaN;
    elseif strcmp(Event(i),'End Trial') 
        time = Time{i};
        end_time = get_time(time);
        trial.end_time = calc_time(end_time, start_time);
        trials = [trials; trial]; %#ok<*AGROW>
        id = id + 1;
        if strcmp(Event(i-1),'Delay')       
            trial.report = 'Early'
        else
            trial.report = 'Report'
        end
    elseif findstr('Texture', Event{i}) == 1 
        trial.stimulus = Event{i} 
    elseif findstr('Stimulus', Event{i}) == 1 
        time = Time{i};
        stim_time = get_time(time);
        trial.stimulus_time = calc_time(stim_time, start_time);
    elseif findstr('Auto Reward', Event{i}) == 1
        trial.auto_reward = 1;
    elseif findstr('Reward', Event{i}) == 1
        time = Time{i};
        reward_time = get_time(time);
        trial.reward_time = calc_time(reward_time, start_time);
    elseif findstr('Go', Event{i}) == 1
        trial.decision = Event{i};
        time = Time{i};
        dec_time = get_time(time);
        trial.decision_time = calc_time(dec_time, start_time);
    elseif findstr('Re', Event{i}) == 4
        trial.decision = Event{i};
        time = Time{i};
        dec_time = get_time(time);
        trial.decision_time = calc_time(dec_time, start_time);
        trial.reward_time = NaN;
    elseif findstr('No', Event{i}) == 1
        trial.decision = Event{i};
        time = Time{i};
        dec_time = get_time(time);
        trial.decision_time = calc_time(dec_time, start_time);
        trial.reward_time = NaN;
    elseif findstr('In', Event{i}) == 1
        trial.decision = Event{i};
        time = Time{i};
        dec_time = get_time(time);
        trial.decision_time = calc_time(dec_time, start_time);
        trial.reward_time = NaN;
    elseif findstr('Puff', Event{i}) == 1
        time = Time{i};
        puff_time_stamp = get_time(time);
        puff_time = calc_time(puff_time_stamp, start_time);
        trial.puff = [trial.puff, puff_time];
    elseif findstr('Z-Plane', Event{i}) == 1
        trial.z_plane = str2num(Event{i}(9:end));
    end
end
