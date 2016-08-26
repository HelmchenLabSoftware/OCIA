function dataConf = OCIA_dataConfig_whisk(this, iDWRow, dataConf)
% generate a configuration that specifies how the data should be saved as a cell-array with 7 columns:
%   { data field name, data to save set/get function, sub-cells save name, names of the attributes to save, attributes to save,
%     display name, data's size, the data save options }
dataConf = [ dataConf; { ...
    'whisk',      @setGetData_whisk,            [],         {},                 {},   'whisker data',    [],     [];
}];

% small function specifying which fields should be updated
function out = setGetData_whisk(fieldName, in)
    switch fieldName;
        case 'whisk';
            if isempty(in);
                in = this.data.whisk(iDWRow);
            else % load each attribute field by field
                fNames = fieldnames(in);
                for iField = 1 : numel(fNames);
                    this.data.whisk(iDWRow).(fNames{iField}) = in.(fNames{iField});
                end;
            end;
    end;
    out = in;
end

end
