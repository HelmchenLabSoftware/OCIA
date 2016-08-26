function [doAbort, isValid, unvalidReason] = DWCheckProcessAbort(this, isValid, unvalidReason)
% DWCheckProcessAbort - [no description]
%
%       [doAbort, isValid, unvalidReason] = DWCheckProcessAbort(this, isValid, unvalidReason)
%
% [No description]
%
% 2013-2016 - Copyleft and programmed by Balazs Laurenczy (blaurenczy_at_gmail.com)

% if processing is not going on anymore, abort and returned cancelled message
if ~this.GUI.dw.isProcessingOnGoing;
    doAbort = true;
    isValid = false;
    unvalidReason = 'cancelled by user';

% otherwise do not abort and go on with unchanged validity and unvalidity reason
else
    doAbort = false;
end;

end
