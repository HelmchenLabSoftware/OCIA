function o(varargin)
% function o : debuging function which prints out the inputs using fprintf/sprintf's syntax (%d and these 
%               stuff) with a line return at the end only if specDbgLvl <= refDbgLvl, where specDbgLvl and 
%               refDbgLvl are the before-last and last arguments, respectively.
%
%              Practically, you should declare a *reference* debug level at the begining of your script:
%               dbgLevel = 2;
%              And then call o with a specific debug level, depending on the importance of that debug line:
%               o('Some important text to display', 1, dbgLevel);
%               o('Some less important text to display', 3, dbgLevel);
%               o('Some very repetitive and annoying text', 4, dbgLevel);
%
%              Thus, only lines with a *specific* debug level *HIGHER OR EQUAL* to the reference would be
%               displayed. For the example above, the output with dbLevel = 2 will be only:
%               'Some important text to display'
%
%              But if dbLevel = 4, then the output will be:
%               Some important text to display
%               Some less important text to display
%               Some very repetitive and annoying text

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Originally created on           25 / 03 / 2013 %
%     in a galaxy far, far away... :D            %
% Written by B. Laurenczy (blaurenczy@gmail.com) %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% not enough input, abort
if nargin < 2; warning('o:NotEnoughArguments', 'Not enough input arguments!'); return; end;
if nargin < 3 && varargin{end - 1} <= varargin{end};
    fprintf('\n');
elseif varargin{end - 1} <= varargin{end};
    % defeat control character '\[a-z]' not valid bug
    if ~isempty(varargin{1});
        varargin{1} = regexprep(varargin{1}, '\\([^abfnrtvx0-9])', '\\\\\\\\$1');
    end;
    % create the text
    txt = sprintf(varargin{1 : end - 2});
    % reshape the text into a single line and add new line character
    if size(varargin{1}, 1) > 1 && numel(txt) == numel(varargin{1});
        txt = reshape(txt, size(varargin{1}))';
        txt = [txt; repmat('\', 1, size(txt, 2)); repmat('n', 1, size(txt, 2))];
        txt = txt(:)';
    % add new line character
    else
        txt = [txt '\n'];
    end;
    % display the text
    fprintf(regexprep(txt, '%', '%%'));
end;

end
