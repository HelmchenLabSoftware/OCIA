function [recordedValues, allData] = stopWhenExceedThreshold(src, event, threshold)
    debugLevel = 0;
    normAbsData = abs(event.Data - mean(event.Data));
    allData = event.Data;
    supThreshData = normAbsData(normAbsData > threshold);
    recordedValues = [min(supThreshData), mean(supThreshData), max(supThreshData)];
    if any(normAbsData > threshold);
        o('\nDetected signal exceeding %1.2f, stoppping acquisition', threshold, 1, debugLevel);
        % Continuous acquisitions need to be stopped explicitly.
        src.stop()
%         plot(event.TimeStamps, event.Data)
    else
        o('Mean Data: %1.3f\n', mean(event.Data), 1, debugLevel);
    end;
end
