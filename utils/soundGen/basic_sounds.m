%% pure tone

% cf = 1000;                  % carrier frequency (Hz)
% sf = 44100;                 % sample frequency (Hz)
% d = 1.0;                    % duration (s)
% n = sf * d;                 % number of samples
% s = (1:n) / sf;             % sound data preparation
% s = sin(2 * pi * cf * s);   % sinusoidal modulation
% sound(s, sf);               % sound presentation
% pause(d + 0.5);             % waiting for sound end


%% cosine ramp

% prepare tone
cf = 2000;                  % carrier frequency (Hz)
sf = 44100;                 % sample frequency (Hz)
d = 1.0;                    % duration (s)
n = sf * d;                 % number of samples
s = (1:n) / sf;             % sound data preparation
s = sin(2 * pi * cf * s);   % sinusoidal modulation

% prepare ramp
dr = d / 10;
nr = floor(sf * dr);
r = sin(linspace(0, pi/2, nr));
r = [r, ones(1, n - nr * 2), fliplr(r)];
% make ramped sound
s = s .* r;
sound(s, sf);               % sound presentation
pause(d + 0.5);             % waiting for sound end
plot(s);
%% frequency modulation
% sin(2?ft - ? cos 2?gt)
% ? modulation index, gt: modulation frequency, ft: carrier frequency

sf = 44100;                    % sample frequency (Hz)
d = 1.0;                       % duration (s)
n = sf * d;                    % number of samples

% set carrier
cf = 5000;                     % carrier frequency (Hz)
c = (1:n) / sf;                % carrier data preparation
c = 2 * pi * cf * c;
% set modulator
mf = 5;                        % modulator frequency (Hz)
mi = 0.5;                      % modulator index
m = (1:n) / sf;                % modulator data preparation
m = mi * cos(2 * pi * mf * m); % sinusoidal modulation

% frequency modulation
s = sin(c + m);                % frequency modulation

% sound presentation
sound(s, sf);                  % sound presentation
pause(d + 0.5);                % wating for sound end

plot(s)


%% amplitude modulation
% (1 + m sin 2?gt) sin 2?ft
% m: modulation index, gt: modulation frequency, ft: carrier frequency

sf = 44100;                        % sample frequency (Hz)
d = 1;                           % durati0n (s)
n = sf * d;                        % number of samples

% set carrier
cf = 1000;                         % carrier frequency (Hz)
c = (1:n) / sf;                    % carrier data preparation
c = sin(2 * pi * cf * c);          % sinusoidal modulation

% set modulator
mf = 5;                            % modulator frequency (Hz)
mi = 0.5;                          % modulator index
m = (1:n) / sf;                    % modulator data preparation
m = 1 + mi * sin(2 * pi * mf * m); % sinusoidal modulation

% amplitude modulation
s = m .* c;                        % amplitude modulation

% sound presentation
sound(s, sf);                      % sound presentation
pause(d + 0.5);                    % waiting for sound end
plot(s);

%% filtered noise

% set general variables
sf = 44100;  % sample frequency
nf = sf / 2; % nyquist frequency
d = 1.0;     % duration
n = sf * d;  % number of samples
nh = n / 2;  % half number of samples

% =========================================================================
% select filter
while 1
    clc;
    v = input('lowpass(1), highpass(2), bandpass(3), notch(4) ? ');
    if v >= 1 & v <= 4;
        break
    end
end

% =========================================================================
% set variables for filter
lf = 2000;   % lowest frequency
hf = 4000;   % highest frequency
lp = lf * d; % ls point in frequency domain    
hp = hf * d; % hf point in frequency domain

% design filter
clc;
switch v
    case 1
    a = ['LOWPASS'];
    filter = zeros(1, n);           % initializaiton by 0
    filter(1, 1 : lp) = 1;          % filter design in real number
    filter(1, n - lp : n) = 1;      % filter design in imaginary number
    case 2        
    a = ['HIGHPASS'];
    filter = ones(1, n);            % initializaiton by 1
    filter(1, 1 : hp) = 0;          % filter design in real number
    filter(1, n - hp : n) = 0;      % filter design in imaginary number
    case 3
    a = ['BANDPASS'];
    filter = zeros(1, n);           % initializaiton by 0
    filter(1, lp : hp) = 1;         % filter design in real number
    filter(1, n - hp : n - lp) = 1; % filter design in imaginary number
    case 4
    a = ['NOTCH'];
    filter = ones(1, n);
    filter(1, lp : hp) = 0;
    filter(1, n - hp : n - lp) = 0;
end

% =========================================================================
% make noise
rand('state',sum(100 * clock));  % initialize random seed
noise = randn(1, n);             % Gausian noise
noise = noise / max(abs(noise)); % -1 to 1 normalization

% do filter
s = fft(noise);                  % FFT
s = s .* filter;                 % filtering
s = ifft(s);                     % inverse FFT
s = real(s);
% =========================================================================
% play noise
disp('WHITE noise');
sound(noise, sf);                % playing sound
pause(d + 0.5);                  % waiting for sound end

% play filtered noise
clc;
disp([a, ' noise']);
sound(s, sf);              % playing sound
pause(d + 0.5);                  % waiting for sound end

% =========================================================================
% plot sound
x = linspace(0, d, n);
subplot(2,2,1); plot(x, noise); xlabel('time (s)'); title('sound: noise');
subplot(2,2,2); plot(x, s); xlabel('time (s)'); title('sound: filtered noise');
% plot Fourier spectrum
x = linspace(0, nf, nh);
t = fft(noise);
t = t .* conj(t);
subplot(2,2,3); semilogy(x, t(1,1:nh) ./ max(t));  xlabel('frequency (Hz)'); title('spectrum: noise');
t = fft(s);
t = t .* conj(t);
subplot(2,2,4); semilogy(x, t(1,1:nh) ./ max(t));  xlabel('frequency (Hz)');  title('spectrum: filtered noise');

figure(1);
