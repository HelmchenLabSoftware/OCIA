function eliminateLastSegment(dirname)

fnames = dir(dirname);
for i=3:numel(fnames)
    if(strfind(fnames(i).name,'-02.avi'))
        delete(fullfile(dirname,fnames(i).name))
    end
end