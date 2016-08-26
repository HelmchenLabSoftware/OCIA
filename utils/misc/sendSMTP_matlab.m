function status = sendSMTP_matlab(address,subject,varargin)
% all inputs as strings
% setup sendSMTP to send mail from command line using default settings
% status ... success (1) or fail (0)
% download sendSMTP from http://www.virtualobjectives.com.au/utilitiesprogs/sendsmtp.htm
% (this link was working on 2011-10-20)

% command line syntax for sendSMTP is:
% SendSMTP.exe /to address /subject "subject line" /body "body text"
% there are more options, this file just creates a system call with these
% three arguments

% this file written by Henry Luetcke (hluetck@gmail.com)

if ~ispc
    warning('sendSMTP only available for PC');
    status = 0;
    return
end

if nargin > 2
    body = varargin{1};
else
    body = '';
end

s = sprintf('SendSMTP.exe /to %s /subject "%s" /body "%s"',...
    address,subject,body);

err = system(s);

if err
    status = 0;
else
    status = 1;
end
