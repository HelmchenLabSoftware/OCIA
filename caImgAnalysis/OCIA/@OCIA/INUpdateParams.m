function INUpdateParams(this, ~, ~)
% INUpdateParams - [no description]
%
%       INUpdateParams(this, ~, ~)
%
% [No description]
%
% 2013-2016 - Copyleft and programmed by Balazs Laurenczy (blaurenczy_at_gmail.com)

OCIAUpdateVariablesFromParamPanel(this, 'in');

showMessage(this, 'Intrinsic: parameters updated.');

INUpdateGUI(this);

if strcmp(this.in.expMode, 'fourier') && strcmp(this.in.common.stimMode, 'trigIn') && this.in.expRunning;
    this.in.expRunning = false;
    showMessage(this, 'Intrinsic: parameters updated => running interrupted.');
end;

if this.in.connected && any(this.in.common.ROIPosition ~= get(this.in.camH, 'ROIPosition'));
    set(this.in.camH, 'ROIPosition', this.in.common.ROIPosition);
end;

if this.in.connected && any(this.in.common.frameRate ~= 1 / get(get(this.in.camH, 'Source'), 'ExposureTime'));
    set(get(this.in.camH, 'Source'), 'ExposureTime', 1 / this.in.common.frameRate);
end;

end
