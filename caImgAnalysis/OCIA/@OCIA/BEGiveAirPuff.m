function BEGiveAirPuff(this, ~, ~)
% BEGiveAirPuff - [no description]
%
%       BEGiveAirPuff(this, ~, ~)
%
% [No description]
%
% 2013-2016 - Copyleft and programmed by Balazs Laurenczy (blaurenczy_at_gmail.com)

if this.be.hw.connected && isfield(this.be.hw, 'airPuff') && this.be.params.punishDur >= 0.01;
    this.be.hw.airPuff.outputSingleScan(1);
    t0 = nowUNIXSec;
    % wait whith a paused-while loop to avoid full-speed looping
    while (nowUNIXSec - t0) < this.be.params.punishDur; pause(0.005); end;
    this.be.hw.airPuff.outputSingleScan(0);
    o('#%s(): punish !', mfilename, 2, this.verb);
elseif this.be.hw.connected && isfield(this.be.hw, 'airPuff');
    showMessage(this, sprintf('  #%s: No air puff: duration is smaller than 0.01: %.7f.', ...
        mfilename(), this.be.params.punishDur));
else
    showWarning(this, 'OCIA:Behavior:GiveAirPuffHardwareDisconnected', 'Hardware is disconnected.');
end;

end

