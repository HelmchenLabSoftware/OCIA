function exportAsNicePDFFigure(outputSizeInCentimeters, fontScale)

figFiles = dir('*.fig');

% figHandles = findobj('Type', 'Figure');

for iFigFile = 1 : numel(figFiles);

    
    %% export current figure
    % open file and get handle
    open(figFiles(iFigFile).name);
    figH = gcf;

    % set the figure size
    set(figH, 'Units', 'centimeters');
    figSize = get(figH, 'Position');
    scaleFactor = nanmean(outputSizeInCentimeters(1:2) ./ figSize(3:4)) * fontScale;
    set(figH, 'Units', 'centimeters', 'Position', [0 0 outputSizeInCentimeters]);
    
    % get all axes and text opbject
    axeHandles = findobj('Type', 'axes');
    for iAxe = 1 : numel(axeHandles);
        % set the font size
        set(axeHandles(iAxe), 'FontSize', get(axeHandles(iAxe), 'FontSize') * scaleFactor, 'FontName', 'Arial');
        % set the font size of title
        set(get(axeHandles(iAxe), 'Title'), 'FontSize', get(get(axeHandles(iAxe), 'Title'), 'FontSize') * scaleFactor);
        % set the font size of axe labels
        set(get(axeHandles(iAxe), 'XLabel'), 'FontSize', get(get(axeHandles(iAxe), 'XLabel'), 'FontSize') * scaleFactor);
        set(get(axeHandles(iAxe), 'YLabel'), 'FontSize', get(get(axeHandles(iAxe), 'YLabel'), 'FontSize') * scaleFactor);
        
%         % custom setting
%         hold(axeHandles(iAxe), 'on');
%         plot(axeHandles(iAxe), [-1 -0.5], [1  1], 'LineWidth', 3, 'Color', 'black');
%         plot(axeHandles(iAxe), [-1  -1], [1 6], 'LineWidth', 3, 'Color', 'black');
        
%         delete(get(axeHandles(iAxe), 'Title'));
%         delete(legend(axeHandles(iAxe)));
        
        % hide axis
        axis(axeHandles(iAxe), 'off');
    end;
    
%     % custom setting
%     delete(findobj(gcf,'Type','axes','Tag','legend'));
    delete(findobj(gcf,'Type','axes','Tag','colorbar'));
    
    % get all axes and text opbject
    textHandles = findobj('Type', 'text');
    for iText = 1 : numel(textHandles);
        % set the font size
        set(textHandles(iText), 'FontSize', get(textHandles(iText), 'FontSize') * scaleFactor);      
    end;
    
    % save as PDF
    export_fig(regexprep(figFiles(iFigFile).name, '\.fig$', '.pdf'), figH);
%     export_fig('14100101_spot01_caTraces_allPhases_ROI1_4_9_40_44_NPil_inline.pdf', figH);

    
    % close figure
    close(figH);
    
end;

end

