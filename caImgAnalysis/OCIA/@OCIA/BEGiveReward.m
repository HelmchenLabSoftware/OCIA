function BEGiveReward(this, ~, ~)
% BEGiveReward - [no description]
%
%       BEGiveReward(this, ~, ~)
%
% [No description]
%
% 2013-2016 - Copyleft and programmed by Balazs Laurenczy (blaurenczy_at_gmail.com)

if this.be.hw.connected && this.be.params.rewDur > 0;
    this.be.hw.valve.outputSingleScan(1);
    t0 = nowUNIXSec;
    % wait whith a paused-while loop to avoid full-speed looping
    while (nowUNIXSec - t0) < this.be.params.rewDur; pause(0.005); end;
    this.be.hw.valve.outputSingleScan(0);
    o('#BEGiveReward(): reward !', 2, this.verb);
elseif this.be.hw.connected;
    showWarning(this, 'OCIA:Behavior:GiveRewardDurationNull', ...
        'Reward duration is 0.');
else
    showWarning(this, 'OCIA:Behavior:GiveRewardHardwareDisconnected', ...
        'Hardware is disconnected.');
end;

end

