function y = expRiseDecay(x,a,onset,tauOn,tauOff,c)

y = repmat(c,size(x));
for n = 1:length(x)
    if x(n) >= onset
        y(n) = (a * (1-exp(-(x(n)-onset)/tauOn)) * ...
            (a*exp(-(x(n)-onset)/tauOff))) + c;
    end
end