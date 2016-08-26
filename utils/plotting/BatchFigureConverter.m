function BatchFigureConverter(output_type)
% convert all figure files in directory (.fig) to graphics files with
% file type output_type
% specify output type as extension string (e.g. provide '.eps' for EPS)
% see doc saveas for supported file formats
% TODO: regexp support for input

% this file written by Henry Luetcke (hluetck@gmail.com)

files = dir('*.fig');

% check if user forgot the . in the extension
if isempty(strfind(output_type,'.'))
   output_type = ['.' output_type];
end

fprintf('\n');
for n = 1:length(files)
    file = files(n).name;
    h = open(file);
    outname = strrep(file,'.fig',output_type);
    saveas(h,outname);
    close(h)
    fprintf('Done %s >> %s\n',file,outname);
end
