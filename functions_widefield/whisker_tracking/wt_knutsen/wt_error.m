function wt_error( sErrString, varargin )
% WT_ERROR
% Display error message dialog.
%
% Usage:
%  wt_error(MSG, 'warn')     Issue a warning
%  wt_error(MSG, 'err')      Issue an error
%

global g_tWT

if ~isempty(varargin), sOpt = varargin{1};
else, sOpt = 'err'; end

[St, I] = dbstack;

switch lower(sOpt)
    case 'warn'
        warndlg( { sprintf('Error in %s', St(I+1,1).name), '', sprintf('%s', sErrString) }, 'WT Error' );
    case 'err'
        errordlg( { sprintf('Error in %s', St(I+1,1).name), '', sprintf('%s', sErrString) }, 'WT Error' );
        error('Stopped in wt_error.')
end


return
