function dataConf = OCIA_dataSaveConfig_behav(this, iDWRow, dataConf)
% generate a configuration that specifies how the data should be saved as a cell-array with 7 columns:
%   { data field name, data to save set/get function, sub-cells save name, names of the attributes to save, attributes to save,
%     display name, data's size, the data save options }
dataConf = [ dataConf; { ...
    'behav',      @setGetData_behav,            [],         {},                 {},   'behavior data',    [],     [];
}];

% small function specifying which fields should be updated
function out = setGetData_behav(fieldName, in)
    switch fieldName;
        case 'behav';
            if isempty(in);
                in = this.data.behav(iDWRow);
            else % load each attribute field by field
                fNames = fieldnames(in);
                for iField = 1 : numel(fNames);
                    this.data.behav(iDWRow).(fNames{iField}) = in.(fNames{iField});
                end;
            end;
    end;
    out = in;
end

end
