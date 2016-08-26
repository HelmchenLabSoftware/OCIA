%get phase

% Parameters:
% vAngle is your whisker angle vector
% nFs is your sampling rate (e.g. 1000 or 500 frames/sec)
vAngle=sin(0:0.1:20);
% Step 1: Subtract set-point (< 2 Hz) **This is important**
vSetPoint = filter_series(vAngle, nFs, 2);
vSetPoint = filter(vAngle, nFs, 2);
vAngle = vAngle - vSetPoint;

% Hilbert transform
vHilb = hilbert(vAngle);

% Hilbert magnitude and phase
vAmp = abs(vHilb);
vPhase = angle(vHilb);

plot(vAngle+60);
hold all
plot(vPhase);

find(vPhase==0)