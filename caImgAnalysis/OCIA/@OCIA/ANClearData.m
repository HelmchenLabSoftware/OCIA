function ANClearData(this, varargin)
% ANClearData - [no description]
%
%       ANClearData(this, varargin)
%
% [No description]
%
% 2013-2016 - Copyleft and programmed by Balazs Laurenczy (blaurenczy_at_gmail.com)

% get the field names of the analyser
analyserFields = fieldnames(this.an);
% go through them
for iField = 1 : numel(analyserFields);
    % if there is a dataHash field, reset it
    if isfield(this.an.(analyserFields{iField}), 'dataHash');
        this.an.(analyserFields{iField}).dataHash = struct();
    end;
end;


showMessage(this, 'Cleared cached data.');
    
end
