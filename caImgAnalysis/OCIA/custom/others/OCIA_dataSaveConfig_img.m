function dataConf = OCIA_dataConfig_img(this, iDWRow, dataConf)
% generate a configuration that specifies how the data should be saved as a cell-array with 7 columns:
%   { data field name, data to save set/get function, sub-cells save name, names of the attributes to save,
%       attributes to save, display name, data's size, the data save options }
preProcType = this.data.preProcType{iDWRow};
if ~isempty(preProcType); preProcType = regexprep(sprintf('%s,', preProcType{:}), ',$', ''); end;
dataConf = [ dataConf ; { ...
    'raw',        @setGetData_img,     'chan%02d', { 'rawLoadType' },   @setGetData_img, ...
                                                                                'raw images',           [],     [];
    'preProc',    @setGetData_img,     'chan%02d', { 'preProcType' },   @setGetData_img, ...
                                                                                'pre-processed images', [],     [];
    'caTraces',   @setGetData_img,     [],         {},                  {},     'calcium traces',       [],     [];
    'stim',       @setGetData_img,     [],         {},                  {},     'stimulus vector',      [],     [];
    'exclMask',   @setGetData_img,     [],         {},                  {},     'exclusion mask',       [],     [];
}];

% small function specifying which fields should be updated
function out = setGetData_img(fieldName, in)
    switch fieldName;
        case 'raw';         if isempty(in); in = this.data.raw{iDWRow};                 else this.data.raw{iDWRow} = in;            end;
        case 'rawLoadType'; if isempty(in); in = this.data.rawLoadType{iDWRow};         else this.data.rawLoadType{iDWRow} = in;    end;
        case 'preProc';     if isempty(in); in = this.data.preProc{iDWRow};             else this.data.preProc{iDWRow} = in;        end;
        case 'preProcType'; if isempty(in); in = preProcType;                           else
            this.data.preProcType{iDWRow} = regexp(in, ',', 'split'); end;
        case 'caTraces';    if isempty(in); in = this.data.img.caTraces{iDWRow};        else this.data.img.caTraces{iDWRow} = in;   end;
        case 'stim';        if isempty(in); in = this.data.img.stim{iDWRow};            else this.data.img.stim{iDWRow} = in;       end;
        case 'exclMask';    if isempty(in); in = this.data.img.exclMask{iDWRow};        else this.data.img.exclMask{iDWRow} = in;   end;
    end;
    out = in;
end

end
