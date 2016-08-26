function tu = nowUNIX(varargin)
% Returns the time in milliseconds since UNIX epoch (1970-01-01@00:00)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Originally created on           30 / 01 / 2014 %
%     in a galaxy far, far away... :D            %
% Written by B. Laurenczy (blaurenczy@gmail.com) %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

tu = round(864e5 * (now - datenum('1970', 'yyyy')));

end