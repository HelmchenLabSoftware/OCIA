function bindata=plotspconds2(xaxis,condstoplot,xs,ys,nsubplots)
%function plotsp6(condstoplot,xs,ys,nsubplots)
% plots the traces for all the conditions

[npix,nframes,nconds]=size(condstoplot);

if nargin < 5,
  nsubplots=4;
end
if nargin < 3,
  xs=sqrt(npix);
  ys=sqrt(npix);
end
pixperplot=floor(xs./nsubplots);

bindata(:,:,1)=plotsp2(xaxis,condstoplot(:,:,1),pixperplot,pixperplot,xs,ys);
for cond=2:nconds,
  bindata(:,:,cond)=plotsp2(xaxis,condstoplot(:,:,cond),pixperplot,pixperplot,xs,ys,1);
end
