function BESound(this, ~, ~)
% BESound - [no description]
%
%       BESound(this, h, ~)
%
% [No description]
%
% 2013-2016 - Copyleft and programmed by Balazs Laurenczy (blaurenczy_at_gmail.com)

if ~isfield(this.be, 'toneArray') || isempty(this.be.toneArray);
    showWarning(this, 'OCIA:Behavior:BESound:NoSoundToPlay', 'Behavior: no sound to play.');
    return;
end;

% load sound into the TDT if required
if this.be.useTDT;

    attenuation = 0;
    this.be.TDTRP = playTDTSound(this.be.toneArray{1}, attenuation, this.GUI.figH, 1);

% initialize a standard audio player
else

    this.be.audioplayer = audioplayer(this.be.toneArray{1}, toneConf.samplingFreq);

end;

% play sound using TDT
if this.be.useTDT;

    this.be.TDTRP.SoftTrg(1);

% play sound without TDT
else

    % play sound using standard audio player
    this.be.audioplayer.play();

end;

start(timer('Name', 'SoundStopTimer', 'TimerFcn', @(h, e)BEEndTrial(this), 'StartDelay', 1));

end
