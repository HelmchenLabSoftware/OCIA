function INChangeCameraFormat(this, ~, ~)
% INChangeCameraFormat - [no description]
%
%       INChangeCameraFormat(this, h, ~)
%
% [No description]
%
% 2013-2016 - Copyleft and programmed by Balazs Laurenczy (blaurenczy_at_gmail.com)

% select the right camera format
this.in.common.camFormat = this.in.availableCamFormats{get(this.GUI.handles.in.camFormat, 'Value')};

% disconnect if connected
if this.in.connected;
    INConnect(this);
end;

end

