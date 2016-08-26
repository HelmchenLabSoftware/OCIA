function [out, bandpow1, bandpow2] = spectralDensityAnalysis(incolumn,windowsiz,overlap,nfft,fs, lowf1, highf1, lowf2, highf2)

% written by Fritjof Helmchen 2014-2015

[~, ~, ~, P] = spectrogram(incolumn,windowsiz,overlap,nfft,fs);  % downsampled 10x, 20 Hz, still need interp
tmp = abs(P);  % calculate abs
dim = size(tmp);
offset = round(overlap/(windowsiz-overlap));
out = zeros(dim(1),dim(2)+offset);
out(:,round(offset/2+1):dim(2)+round(offset/2))=tmp;

% calculate power in frequ band


f = 0:fs/nfft:fs/2;  % frequency range
    a = f>lowf1;
    low_idx = find(a, 1, 'first');
    a = f>highf1;
    high_idx = find(a, 1, 'first')-1;

bandpow1 = mean(out(low_idx:high_idx,:));
bandpow1 = resample(bandpow1,windowsiz-overlap,1);
%ze = zeros(1,round(overlap/2));
%bandpow1 = horzcat(ze,bandtmp,ze);

f = 0:fs/nfft:fs/2;  % frequency range
    a = f>lowf2;
    low_idx = find(a, 1, 'first');
    a = f>highf2;
    high_idx = find(a, 1, 'first')-1;

bandpow2 = mean(out(low_idx:high_idx,:));
bandpow2 = resample(bandpow2,windowsiz-overlap,1);
%ze = zeros(1,round(overlap/2));
%bandpow2 = horzcat(ze,bandtmp,ze);




