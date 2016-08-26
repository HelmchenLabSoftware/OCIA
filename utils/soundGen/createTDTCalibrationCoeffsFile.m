% import freq_list, gain_list

nTaps = 250;
TDTSampFreq = 195312.5;
nyquist = TDTSampFreq / 2;
filtCoefs = fir2(nTaps, freq_list, 10 .^ (gain_list / 20));
FID = fopen('E:\Experiments\TuckerDavis\20151019_calibration\20151019_H42_FIRCoefs.txt', 'wt+');
fprintf(FID, '%6f\n', filtCoefs);
fclose(FID);

subplot(2, 1, 1);
filtResp = fft(filtCoefs, 1000);
plot(freq_list * nyquist, gain_list, 'b-o', ...
    linspace(0, nyquist, length(filtResp) / 2), 20 * log10(abs(filtResp(1 : length(filtResp) /2))), 'r');
xlabel('Frequency (Hz)'); ylabel('Gain (dB)');
subplot(2, 1, 2)
plot(filtCoefs);
xlabel('Coefficient number'); ylabel('Coefficient value');