function puretone(frequency, duration, channels)
% PURETONE(frequency, duration, channels) plays a sinusoidal pure tone
% given the frequency in
% Hz, duration in seconds.
% channels = 2 means stereo sound
% = 0 means left
% = 1 means right

sf = 22050; % sampling frequency
Tdur = 10; % total duration of waveform
t = 0:1/sf:Tdur;
N = length(t);

start_time = 0; % burst start time
rt = 0.010; % burst rise-time
duration_hp = duration; % burst duration at half-power points


% cosine-squared switch
tcos1 = 0:1/sf:rt;
fcos1 = 1/4/rt;
ycos1 = cos(2 * pi * fcos1 * tcos1-pi/2) .^ 2;
dur_st = acos((2 ^ 0.25) / sqrt(2)) / (2 * pi * fcos1);

tcos2 = 0:1/sf:rt;
fcos2 = 1/4/rt;
ycos2 = cos(2*pi*fcos2*tcos2) .^ 2;
dur_sp = acos((2^0.25) / sqrt(2)) / (2*pi*fcos2);


% temporal window
w = zeros(1,N);

ix1 = round(start_time * sf) + 1;
ix2 = ix1 + length(tcos1) - 1;
ix3 = ix2 + round((duration_hp - dur_st - dur_sp) * sf) - 1;
ix4 = ix3 + length(tcos2) - 1;

w(ix1:ix2) = ycos1;
w(ix2:ix3) = 1;
w(ix3:ix4) = ycos2;

cf = frequency;

% Apply the cos^2 window:
y_raw = sin(2 * pi * cf * (t - start_time));
s = y_raw .* w;

silence = zeros(1, length(s)); % silence vector

soundLeft = horzcat(s', silence');
soundRight = horzcat(silence', s');

ao = analogoutput('winsound', 0);
addchannel(ao, [1]);
set(ao, 'SampleRate', sf);
putdata(ao, soundLeft(:,1));

% startindex = 1;
% increment = 500;
% start_time = clock;
start(ao);

% switch channels
%     case 2
%         sound(s, sf); % sound presentation
%     case 0
%         sound(soundLeft, sf);
%     case 1
%         sound(soundRight, sf);
%     otherwise
%         error('Please state which channel(s) you want to use,stereo = 2, left = 0, right = 1')
% end

