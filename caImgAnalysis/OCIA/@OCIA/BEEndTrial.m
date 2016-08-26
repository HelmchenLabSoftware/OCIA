function BEEndTrial(this)
% BEEndTrial - [no description]
%
%       BEEndTrial(this)
%
% [No description]
%
% 2013-2016 - Copyleft and programmed by Balazs Laurenczy (blaurenczy_at_gmail.com)

%% - #BEEndTrial: stop tasks
% stop TDT
if ~isempty(this.be.TDTRP) && ishandle(this.be.TDTRP);
    this.be.TDTRP.Halt();
    delete(this.be.TDTRP);
end;

if ~this.be.iTrial; return; end;

%% - #BEEndTrial: record end time
iTrial = this.be.iTrial;
this.be.times.end(iTrial) = roundn(nowUNIXSec(), -3) - this.be.times.start(iTrial);
o('Times:end: %.4f', this.be.times.end(iTrial), 3, this.verb);

%% - #BEEndTrial: stop imaging
BEImagingTTL(this, 0); % make sure imaging is stopped
% BESpoutPos(this, 0); % make sure spout is low
BELight(this, 0); % make light is off

% show performance plot if required
if this.GUI.be.showPerformance;
    BEUpdatePerformance(this);
end;

% store the recorded and eventually filtered data
for iAnIn = 1 : size(this.be.hw.analogIns, 2);
    anInName = this.be.hw.analogIns{iAnIn};
    this.be.rawRecord.(anInName){iTrial} = this.be.anInData.(anInName);
    this.be.record.(anInName){iTrial} = this.be.procAnInData.(anInName);
end;

% compensate water pipe's air bubble backflow effect
% BEGiveReward(this);

% copy the last output as backup
if exist(this.be.savePath, 'file');
    copyOK = false;
    while ~copyOK;
        try
            copyfile(this.be.savePath, [this.be.savePath '_backup']);
            copyOK = true;
        catch err;
            o('#%s(): copy failed (%s): %s ...', mfilename(), err.identifier, err.message, 1, this.verb);
            pause(1);
        end;
    end;
end;

% save the output every trial
saveOK = false;
while ~saveOK;
    try
        BESaveOutput(this);
        saveOK = true;
    catch err;
        o('#%s(): save failed (%s): %s ...', mfilename(), err.identifier, err.message, 1, this.verb);
        pause(1);
    end;
end;

end

