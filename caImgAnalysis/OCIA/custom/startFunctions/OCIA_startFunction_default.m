function OCIA_startFunction_default(this)
% OCIA_startFunction_default - [no description]
%
%       OCIA_startFunction_default(this)
%
% [No description]
%
% 2013-2016 - Copyleft and programmed by Balazs Laurenczy (blaurenczy_at_gmail.com)

    OCIAChangeMode(this, 'DataWatcher');
    showMessage(this, sprintf('Welcome to the OCIA v%s !', this.main.version));
            
end
