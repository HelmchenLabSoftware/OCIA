function status = BatchRename(varargin)
% rename all files in directory
% renames all instances of string in1 with string in2
% e.g. status = BatchRename('.tiff','.tif')
% status is 1 (ok) or 0 (error)
% directories are not renamed

dir_content = dir;
status = 1;
for n = 1:numel(dir_content)
    if ~dir_content(n).isdir
        file = dir_content(n).name;
        if ~isempty(strfind(file,varargin{1}))
            new_file = strrep(file,varargin{1},varargin{2});
            try
                movefile(file,new_file,'f');
            catch
                fprintf('\nFailed to rename file %s to file %s\n\n',...
                    file,new_file);
                status = 0;
                rethrow(lasterror);
            end
            fprintf('\nMoved file %s to file %s\n\n',...
                    file,new_file);
        end
    end
end

fprintf('\nFinished!\n');


