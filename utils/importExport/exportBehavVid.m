function exportBehavVid(inPath, outPath)

% inVRH = VideoReader('D:\Users\BaL\PhD\RawData\1410_chronic\mou_bl_141001_01\2014_10_26\behav\20141026_160500_trial01.avi');
inVRH = VideoReader(inPath);

inFrames = inVRH.read();
inFrames = squeeze(nanmean(inFrames, 3));

% outVRH = VideoWriter('D:\Users\BaL\PhD\Presentations\20141115_SFNPoster\Material\Methods\20141026_160500_trial01_unc.avi');
outVRH = VideoWriter(outPath);
outVRH.open();

for iFrame = 1 : size(inFrames, 3);
    outVRH.writeVideo(linScale(squeeze(inFrames(:, :, iFrame))));
    fprintf('%03d/%03d\n', iFrame, size(inFrames, 3));
end;
outVRH.close();

end

