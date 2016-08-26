
frameRateImaging = 77.76;

for j = 1 : 30;
%     totTic = tic;
    for i = 1 : 25;
        startTic = tic;
        BEETL(this, i, 'depth');
%         y = 0;
%         inTime = toc(startTic);
%         tDiff = (1 / frameRateImaging) - toc(startTic);
        while toc(startTic) < 1 / frameRateImaging; end;
%         o('i: %d, y = %d, tDiff = %.4f, inTime = %.4f, t = %.4f', i, y, 1000 * tDiff, ...
%             1000 * inTime, 1000 * toc(startTic), 0, 0);
    end;
%     o('totTic = %.4f', 1000 * toc(totTic), 0, 0);
end;