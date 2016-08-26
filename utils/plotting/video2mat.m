function [movMat, audioMat, frameRate] = video2mat(videoFilePath)

% this file written by Henry Luetcke (hluetck@gmail.com)
% modified by B. Laurenczy (blaurenczy@gmail.com) 2014/02/21

% create the movie object
VFR = vision.VideoFileReader(videoFilePath);
VFR.AudioOutputDataType = 'double';
frameRate = VFR.info.VideoFrameRate;
vidDim = VFR.info.VideoSize;
VFR.AudioOutputPort = true;
% create target matrix (which may be very large)
movMat = zeros(vidDim(2), vidDim(1), 3, 1000);
audioMat = zeros(2, 10000);
iFrame = 1;
audioPos = 1;
while ~VFR.isDone();
    [frame, audio] = step(VFR);
    movMat(:, :, :, iFrame) = frame;
    nSamples = size(audio, 1);
    audioMat(:, audioPos : audioPos + nSamples - 1) = audio';
    audioPos = audioPos + nSamples;
    iFrame = iFrame + 1;
end;
end