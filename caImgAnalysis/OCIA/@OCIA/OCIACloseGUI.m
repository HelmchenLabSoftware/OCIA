function OCIACloseGUI(this, ~, ~)
% OCIACloseGUI - [no description]
%
%       OCIACloseGUI(this, ~, ~)
%
% [No description]
%
% 2013-2016 - Copyleft and programmed by Balazs Laurenczy (blaurenczy_at_gmail.com)

o('#OCIACloseGUI()', 4, this.verb);

% disconnect the behavior mode if it exist and is connected
if isfield(this.be, 'hw') && this.be.hw.connected;
    BEConnHW(this);
end;

% stop the GUI update timer if it exists
if isfield(this.GUI, 'be') && ~isempty(this.GUI.be.updateTimer);
    stop(this.GUI.be.updateTimer);
    delete(this.GUI.be.updateTimer);
end;

% stop the GUI update timer if it exists
if isfield(this.GUI, 'di') && ~isempty(this.GUI.di.updateTimer);
    stop(this.GUI.di.updateTimer);
    delete(this.GUI.di.updateTimer);
end;

% stop the camera if it records
if isfield(this.GUI, 'di') && ~isempty(this.GUI.di.camHandle);
    stop(this.GUI.di.camHandle);
    delete(this.GUI.di.camHandle);
end;

delete(this);
    
end