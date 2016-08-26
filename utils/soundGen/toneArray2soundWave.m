function y = toneArray2soundWave(toneArray,isi,sf)

% 1 isi baseline before first tone
y = zeros(1,isi.*sf);

isiTone = y;

for n = 1:numel(toneArray)
    if ~isempty(toneArray{n})
       tone = toneArray{n};
       dur = numel(tone)./sf;
       y = [y tone isiTone];
    else
        % omitted stimulus (assume previous stimulus duration)
        tone = zeros(1,dur.*sf);
        y = [y tone isiTone];
    end
end
