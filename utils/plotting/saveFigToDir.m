function saveFigToDir(fig, saveName, dirName, doSave, saveAsPNG, closeFig)
% SAVEFIGTODIR(fig, saveName, dirName, doSave, saveAsPNG, closeFig) 
% Saves a figure 'fig' to the file 'saveName' in the directory 'dirName' only if
% the conditional 'doSave' is bigger than 1. Also saves the figure in PNG format if
% 'saveAsPNG' is true. If 'fig' is an array of handles and 'doSave' is true, saves the
% figures as a figure group ('hgsave'). The directory 'dirName' is created if not present.

% B.Laurenczy 2013-11-11

if (numel(fig) == 1 && doSave > 1) || (numel(fig) > 1 && doSave);
    if exist(dirName, 'dir') ~= 7; mkdir(dirName); end;
    if numel(fig) == 1;
        saveas(fig, [dirName filesep saveName]);
        %Old version:
        %if saveAsPNG; saveas(fig, [dirName filesep saveName '.png']); end;
        %Fancy export fig:
        if saveAsPNG;
            export_fig([dirName filesep saveName], '-png', '-r150', fig);
        end;
        
        
        if closeFig; close(fig); end;
    elseif numel(fig) > 1;
        hgsave(fig, [dirName filesep saveName]);
        if closeFig; close(fig); end;
    end;
end;

end
