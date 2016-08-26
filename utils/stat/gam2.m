function y = gam2(x,a1,b1,c1,d1,a2,b2,c2,d2)
% e.g. for spike:
% a1 = 2, b1 = 3, c1 = 0, a2 = 3, b2 = 3, c2 = 5, d = 1

y = (d1.*gampdf(x-c1,a1,b1)) - (d2.*gampdf(x-c2,a2,b2));
% plot(x,y)
% set(gca,'xlim',[min(x) max(x)])
