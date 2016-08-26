function INSendTTLOutTrigger(this, inputVect, nPulses, ITI, BLDur)
% INSendTTLOutTrigger - [no description]
%
%       INSendTTLOutTrigger(this, inputVect, nPulses, ITI)
%
% [No description]
%
% 2013-2016 - Copyleft and programmed by Balazs Laurenczy (blaurenczy_at_gmail.com)

if isempty(this.in.daq.sessHandle) || ~iscell(this.in.daq.sessHandle); return; end;

% wait baseline
pauseTicToc(BLDur);
% send trigger
for iPulse = 1 : nPulses;
    outputSingleScan(this.in.daq.sessHandle{2}, [1 1] .* inputVect); % TTL high
    pauseTicToc(ITI(1));
    outputSingleScan(this.in.daq.sessHandle{2}, [0 0] .* inputVect); % back to TTL low
    if iPulse ~= nPulses;
        pauseTicToc(ITI(1));
    end;
end;
    
end
