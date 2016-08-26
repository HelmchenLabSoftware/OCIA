function [freqs] = generateRovingParadigmFreqs
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

nSameFreq = 0;
freq = randi(9);

for i = 1 : 100;
    if rand <= 0.1 && nSameFreq >= 6;
        freq = randi(9);
        nSameFreq = 0;
    end;
    freqs(i) = freq;
    nSameFreq = nSameFreq + 1;
end;

end

