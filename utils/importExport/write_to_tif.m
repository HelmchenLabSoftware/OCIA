function write_to_tif(varargin)
% write data fields in A to tif-files filename_field.tif
% (or filename.tif if only 1 field)
% in3 ... bit-depth of output (8 or 16; experimental)

% this file written by Henry Luetcke (hluetck@gmail.com)

dbgLevel = 0;
A = varargin{1};
filename = varargin{2};
compression = 'none';
if nargin == 3
    bit = varargin{3};
else
    bit = 16;
end
if ~isstruct(A);
    error('First input must be a structure!');
end;
if ~ischar(filename);
    error('Second input must be a string!');
end;
fields = fieldnames(A);
for n = 1:numel(fields);
    if isnumeric(A.(fields{n})) || islogical(A.(fields{n}));
        field_name = fields{n};
        data = A.(fields{n});
        if numel(fields) > 1;
            tif_name = sprintf('%s_%s.tif',filename,field_name);
        else
            tif_name = sprintf('%s.tif',filename);
        end
        if numel(size(data)) == 2;
            if isscalar(data) || isvector(data)
                o('Content of field "%s" is not a matrix. Skipping ...', field_name, 0, dbgLevel);
                continue
            end
            o('Writing content of field "%s" to image file %s...', field_name, tif_name, 2, dbgLevel);
            try
                if bit == 16;
                    data = uint16(data);
                elseif bit == 8;
                    data = uint8(data);
                end
                imwrite(data,tif_name,'Compression',compression);
            catch e
                fprintf('An error occured while writing to file %s\n',...
                    tif_name);
                rethrow(e);
            end
            o('Writing content of field "%s" to image file %s: done!', field_name, tif_name, 1, dbgLevel);
        elseif numel(size(data)) == 3;
            if size(data,3) == 3;
                o('Writing content of field "%s" to RGB image file %s...', field_name, tif_name, 2, dbgLevel);
                fid = fopen(tif_name,'w');
                fclose(fid);
                try
                    imwrite(data,tif_name,'Compression',compression);
                catch e
                    fprintf('An error occured while writing to file %s\n',...
                        tif_name);
                    rethrow(e);
                end
                o('Writing content of field "%s" to RGB image file %s: done!', field_name, tif_name, 1, dbgLevel);
            else
                fprintf('\nWriting content of field "%s" to stacked image file %s\n',...
                    field_name,tif_name);
                fid = fopen(tif_name,'w');
                fclose(fid);
                for m = 1:size(data,3)
                    try
                        if bit == 16
                            data = uint16(data);
                        elseif bit == 8
                            data = uint8(data);
                        end
                        imwrite(data(:,:,m),tif_name,'Compression',compression,...
                            'WriteMode','append');
                    catch e
                        fprintf('An error occured while writing to file %s (frame %s)\n',...
                            tif_name,int2str(m));
                        rethrow(e);
                    end
                end
            end
        elseif numel(size(data)) == 4;
            fprintf('\nWriting content of field "%s" to stacked RGB image file %s\n',...
                field_name,tif_name);
            fid = fopen(tif_name,'w');
            fclose(fid);
            for m = 1:size(data,4);
                try
                    imwrite(data(:,:,:,m),tif_name,'Compression',compression,...
                        'WriteMode','append');
                catch e
                    fprintf('An error occured while writing to file %s (frame %s)\n',...
                        tif_name,int2str(m));
                    rethrow(e);
                end
            end
        else
            fprintf('\nContent of field "%s" has %s dimensions. Skipping ...\n',...
                field_name,int2str(numel(size(data))));
        end
    else
        field_name = fields{n};
        fprintf('\nContent of field "%s" is not numeric. Skipping ...\n',...
            field_name);
    end
end


% e.o.f.


