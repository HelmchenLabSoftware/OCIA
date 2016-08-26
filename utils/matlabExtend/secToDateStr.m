function dateStrText = secToDateStr(secTime, varargin)
% Converts seconds into a nice format
    if isempty(varargin) || ~iscell(varargin) || ~ischar(varargin{1}) || isempty(varargin{1});
        varargin = {'dd:HH:MM:SS'};
    end;
    dateStrText = datestr(-datenum(num2str(0), 'SS') + datenum(num2str(secTime), 'SS'), varargin{1});
    dateStrText = regexp(dateStrText, ':', 'split');
    dateStrText = sprintf('%sd:%sh:%sm:%ss', dateStrText{:});
end
