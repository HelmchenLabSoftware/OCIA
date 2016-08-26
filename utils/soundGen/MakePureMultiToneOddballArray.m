function outTones = MakePureMultiToneOddballArray(uniqueFreqs, stims, odds, oddPos, nTones, duration, ISI, sampleFreq)
% generate a pure tone
%
% uniqueFreqs   ... vector of frequencies in Hz
% stims         ... std stimulus indexes specifying the frequency of the standard tone
% odds          ... oddball stimulus indexes specifying the frequency of the oddball tone
% oddPos        ... oddball position indexes specifying the position of the oddball in the tone series
% nTones        ... number of tones
% duration      ... duration in s (each tone)
% ISI           ... inter tone/stimulus interval (ISI)
% sampleFreq    ... sampling frequency in Hz {44100}
% 
% out1          ... cell array of tone vectors (outTones)

dbgLevel = 0;

outTones = cell(numel(stims), 1);
silence = zeros(1, ISI * sampleFreq);

o('#MakePureMultiToneOddballArray: start...', 1, dbgLevel);

for iTrial = 1 : numel(stims);
    isOddTrial = stims(iTrial) ~= odds(iTrial);
    o('  #Make...Array: trial %d/%d, stim: %d, odd: %d, oddball? %d, oddball pos: %d ...', ...
        iTrial, numel(stims), stims(iTrial), odds(iTrial), ...
        isOddTrial, oddPos(iTrial), 2, dbgLevel);
    soundForTrial = [];
    for iTone = 1 : nTones;
        if isOddTrial && iTone == oddPos(iTrial); % insert an oddball tone
            o('    #Make...Array: trial %d/%d, tone %d/%d, inserting oddball tone.', ...
                iTrial, numel(stims), iTone, nTones, 3, dbgLevel);
            tone = makePureTone(uniqueFreqs(odds(iTrial)), duration, sampleFreq);
        else % insert a standard tone
            o('    #Make...Array: trial %d/%d, tone %d/%d, inserting standard tone.', ...
                iTrial, numel(stims), iTone, nTones, 3, dbgLevel);
            tone = makePureTone(uniqueFreqs(stims(iTrial)), duration, sampleFreq);
        end
        if iTone == nTones; % do not add ending silence
            o('    #MakePureMultiToneOddballArray: no silence', 4, dbgLevel);
            soundForTrial = [soundForTrial tone]; %#ok<AGROW>
        else
            o('    #MakePureMultiToneOddballArray: inserting silence', 4, dbgLevel);
            soundForTrial = [soundForTrial tone silence]; %#ok<AGROW>
        end;
    end;
    outTones{iTrial} = soundForTrial;
    
%     sound(outTones{iTrial}, sampleFreq);
%     pause(1);
end


