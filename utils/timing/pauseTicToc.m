function dt = pauseTicToc(t)
% wait for specified number of seconds and returns
% more accurate then Matlabs pause command and etime because it uses tic
% and toc, which are not discretized

% this file written by Henry Luetcke (hluetck@gmail.com)

tic
while toc < t
    % do nothing
end
tElapse = toc;
dt = tElapse - t;