function BrowseXMLstruct(S)

storeNext = 0;
ParamName = '';
global Sout

fields = fieldnames(S);
paramList = {'SizeX' 'SizeY' 'SizeZ' 'SizeT' 'TimeIncrement' ...
    'PhysicalSizeX' 'PhysicalSizeY' 'Zoom' 'Intensity' 'AngleZ' 'AngleX' ...
    'OffsetX' 'OffsetY' 'OffsetZ'};
for currentField = 1:length(fields)
    if isstruct(S.(fields{currentField}))
        for n = 1:length(S.(fields{currentField}))
            BrowseXMLstruct(S.(fields{currentField})(n))
        end
    else
        if storeNext && ~isempty(ParamName)
            Sout.(ParamName) = S.(fields{currentField});
            storeNext = 0;
        end
        if strcmp(fields{currentField},'Name') && ...
                sum(strcmp(S.(fields{currentField}),paramList))
            ParamName = S.(fields{currentField});
            storeNext = 1;
        end
%         disp(fields{currentField});
%         disp(S.(fields{currentField}))
    end
end
SaveAndAssignInBase(Sout,'Sout','AssignOnly')
clear Sout
% fclose(fid);