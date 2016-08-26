function tprintf(varargin)
%tprintf prints out data as table
%   spacing         number of character in each cell of the table
%   content         a 2D cell array containing the text of each cell
%   tableStyle      table border style (1 - 5)
%   headersToLeft   set to 1 if you want header text to stick to the left
%   Written by B.Laurenczy (blaurenczy@gmail.com) - 2013-05-15 - University of Zurich
    
    if nargin >= 2;
        spacing = varargin{1};
        content = varargin{2};
        style = 1;
        headersToLeft = 1;
    end;
    
    if nargin == 3;
        style = varargin{3};
    end;
    
    if nargin == 4;
        headersToLeft = varargin{4};
    end;
    
    if nargin < 2 || nargin > 4;
        error('tprintf:WrongArgumentNumberException', ['Number of arguments should be 2 ', ...
            '(spacing, content) or 3 (spacing, content, style). ', ...
            'Please see the help for this function.']);
    end;
    
    % set up the table border style
    switch style;
        case 2; horiChar = '~'; vertChar = '|'; intersectChar = 'o';    % wavy style
        case 3; horiChar = '-'; vertChar = 'I'; intersectChar = '*';    % ugly style
        case 4; horiChar = '*'; vertChar = '*'; intersectChar = '*';    % 'hurts-my-eyes' style
        case 5; horiChar = '1'; vertChar = '2'; intersectChar = '3';    % test style
        otherwise; horiChar = '-'; vertChar = '|'; intersectChar = '+'; % standard style
                                                                    % there is no Oppa-Gangam style
    end;
    
    nCol = size(content, 2);
    % /!\do not change these or things will be messed up :D
    if headersToLeft; headerPattern = '%%-%ds';
    else headerPattern = '%%%ds'; end;
    linePatternWithNewLine = sprintf([vertChar, headerPattern, ...
        repmat([vertChar, '%%%ds'], 1, nCol - 1), vertChar, '\n'], spacing * ones(1, nCol));
    horiLine = [repmat([intersectChar, repmat(horiChar, 1, spacing)], 1, nCol), intersectChar];
    
    for iRow = 1 : size(content, 1);
        fprintf('%s\n', horiLine);
        content(iRow, :) = cellfun(@(c)iff(isnumeric(c), sprintf('%d', c), c), content(iRow, :), 'UniformOutput', false);
        fprintf(linePatternWithNewLine, content{iRow, :});
    end;
    fprintf('%s\n', horiLine);

end

