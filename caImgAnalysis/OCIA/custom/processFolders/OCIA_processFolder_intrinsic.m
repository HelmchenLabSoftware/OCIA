function tableRow = OCIA_processFolder_intrinsic(this, tableRow, fullPath, patternName, ~)
% tableRow = OCIA_processFolder_intrinsic - [no description]
%
%       tableRow = OCIA_processFolder_intrinsic(this, tableRow, fullPath, patternName, ~)
%
% [No description]
%
% 2013-2016 - Copyleft and programmed by Balazs Laurenczy (blaurenczy_at_gmail.com)

processTic = tic; % for performance timing purposes
o('#%s: in "%s", full path: %s.', mfilename, fullPath, 3, this.verb);

% fill in the table's variable that are independant on the match type
tableRow = set(this, 1, 'path', fullPath, tableRow);

fileInfo = dir(fullPath); % get the file's information
tableRow = set(this, 1, 'dim',  sprintf('%.1f MB', fileInfo.bytes / 1E6),  tableRow);
tableRow = set(this, 1, 'time', regexprep(fileInfo.date(end - 7 : end), ':', '_'), tableRow);

% process the different match types differently
switch patternName;

    % intrinsic binary data from standard intrinsic
    case 'intrBinary';

    % intrinsic binary data from Fourier imaging
    case 'intrFourier';

    % intrinsic screenshot
    case 'intrScreen';

    % intrinsic vessels pattern reference image
    case 'intrVessel';

end;

o('  #%s: %s done (%3.1f sec).', mfilename, fullPath, toc(processTic), 4, this.verb);

end
