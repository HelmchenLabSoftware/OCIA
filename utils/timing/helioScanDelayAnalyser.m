folderNames = ls;
folderNames = folderNames(10 : 10, :);

fileNames = cell(size(folderNames, 1), 1);
c = lines(5);
avgYI = zeros(1, 50 * 1000);
diffsAll = [];
avgCounter = 0;
for i = 1 : numel(fileNames);
    folderName = regexprep(folderNames(i, :), '\s+', '');
    fileNames{i} = [folderName '\' folderName '__channel01.tif'];
    img = tiffread2(fileNames{i});
    fileNames{i} = [folderName '\' folderName '__channel02.tif'];
    soundImg = tiffread2(fileNames{i});
    
    data = uint16(zeros(img(1).width, img(1).height, size(img, 2)));
    for z = 1 : size(img, 2);
        data(:, :, z) = img(z).data;
    end;
    
    y = double(img2vector(data, 100, 0));
    
    soundData = uint16(zeros(soundImg(1).width, soundImg(1).height, size(soundImg, 2)));
    for z = 1 : size(soundImg, 2);
        soundData(:, :, z) = soundImg(z).data;
    end;
    
    sound = double(img2vector(soundData, 100, 0));
    
    baseSampFreq = 1E5;
    lowSampFreq = 1E3;
    
    t = (1 : numel(y)) ./ baseSampFreq;
    tI = 1 / lowSampFreq : 1 / lowSampFreq : max(t);
    yI = interp1(t, y, tI);
    yI = yI - min(yI);
    
    soundI = interp1(t, sound, tI);
    soundI = soundI - min(soundI);
    figure('Name', sprintf('Run %d - %s traces', i, fileNames{i}), 'WindowStyle', 'docked');
    plot(tI, yI);
    hold on;
    plot(tI, soundI, 'r');
    hold off;
    
    localAPs = findAPs(yI, tI', 60, 10, -1, 2, 0);
    if numel(localAPs) > 0;
        o('Run %d ("%s") has %d spikes...', i, fileNames{i}, numel(localAPs), 0, 0);
        localDiffs = diff(localAPs);
        figure('Name', sprintf('Run %d - %s', i, fileNames{i}), 'WindowStyle', 'docked');
        hist(localDiffs, 30);
        title(sprintf('Initial delay: %1.3fms', localAPs(1)));

        diffsAll = [diffsAll localDiffs];
        avgYI = avgYI + yI;
        avgCounter = avgCounter + 1;
    else
        o('Run %d ("%s") has no spikes...', i, fileNames{i}, 0, 0);
    end;
    
%     plot(tI, yI, 'Color', c(i, :));
%     hold on;
    
end;

% avgYI = avgYI ./ avgCounter;
% APs = findAPs(avgYI, tI', 60, 10, -1, 2, 0);
% avgDiffs = diff(APs);
% figure('Name', 'avgDiffs', 'WindowStyle', 'docked');
% hist(avgDiffs, 30);
% 
% figure('Name', 'diffsAll', 'WindowStyle', 'docked');
% hist(diffsAll, 30);