%get phase

% Parameters:
% vAngle is your whisker angle vector
% nFs is your sampling rate (e.g. 1000 or 500 frames/sec)
vAngle=Ephys(:,2);
vAngle=sin(0:0.01:90);
nFs=0.0001;
% Step 1: Subtract set-point (< 2 Hz) **This is important**

% Hilbert transform
vHilb = hilbert(vAngle);

% Hilbert magnitude and phase
vAmp = abs(vHilb);
vPhase = angle(vHilb); %angle in radians
d=180/pi*vPhase; %wandle in 360 grad um
d=d-min(d); %setze auf null

plot(vAngle);
hold all
plot(d);
plot(Ephys(:,1),d)
vCalcium=Calcium(:,2);


polar(vAngle,Ephys(:,1))
polar (Ephys(:,1),vPhase)
plot(vAmp);
find(vPhase==0)

b=atan(tan(vPhase));