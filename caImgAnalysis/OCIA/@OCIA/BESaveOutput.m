function BESaveOutput(this)
% BESaveOutput - [no description]
%
%       BESaveOutput(this)
%
% [No description]
%
% 2013-2016 - Copyleft and programmed by Balazs Laurenczy (blaurenczy_at_gmail.com)

nTrials = 0;
try
    nTrials = this.be.config.training.nTrials;
catch
end;

% showMessage(this, sprintf('%s | Trial %03d/%03d - saving output ... ', ...
%     datestr(now(), this.be.logDateFormat), this.be.iTrial, nTrials), 'red');
out = this.be;
out.sampToRec = this.be.hw.sampToRec;
out.anInSampRate = this.be.hw.anInSampRate;
out.anOutSampRate = this.be.hw.anOutSampRate;
out.anInFilt = this.GUI.be.anInFilt;
out.anInDoAbs = this.GUI.be.anInDoAbs;

removeFields = {'TDTRP', 'procAnInData', 'anInData', 'toneArray', 'hw', 'configLoaded', 'logDateFormat'};
for iRemField = 1 : size(removeFields, 2);
    fieldName = removeFields{iRemField};
    if isfield(out, fieldName); out = rmfield(out, fieldName); end;
end;

saveFolder = sprintf('%s/behav/', this.path.behavSave);
if exist(saveFolder, 'dir') ~= 7; mkdir(saveFolder); end;
save(out.savePath, 'out');
showMessage(this, sprintf('%s | Trial %03d/%03d - output saved.', ...
    datestr(now(), this.be.logDateFormat), this.be.iTrial, nTrials));

end

