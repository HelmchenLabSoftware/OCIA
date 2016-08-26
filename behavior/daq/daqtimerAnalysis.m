function daqtimerAnalysis(obj, event,stats)
%DAQTIMERANALYSIS Calculates descriptive stats for the data acquired.
%   stats is cell array with stats functions to calculate (e.g. 'mean',
%   'std' etc.)
%
%    DAQTIMERPLOT can be used with any analog input object.
%
%    See also DEMODAQ_CALLBACK. 
%


if nargin == 0 
   error(['This function may not be called with 0 inputs.\n',...
         'Type ''daqhelp daqtimerplot'' for an example using DAQTIMERPLOT.']);
elseif nargin == 1
   error('Type ''daqhelp daqtimerplot'' for an example using DAQTIMERPLOT.');
end
size = min([obj.SamplesAvailable 100]);
data = peekdata(obj, size);
fprintf('Max data: %1.2f\n',max(data))
if max(data) > 1
    stop(obj)
end