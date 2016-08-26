function [ Fx  f  mx  Fmx ] = mpi_BandPassFilterTimeSeries( x , TR , f_low , f_high )

% Author:      Dirk Voit
% Last Change: 17.04.2007
%
% Usage:  [ Fx  f  mx  Fmx ] = mpi_BandPassFilterTimeSeries( x , TR , f_low, f_high )
%
% INPUT
%   x      : time series data
%   TR     : sampling time in sec
%   f_low  : frequency threshold for high pass filter in Hz -> lower frequency
%   f_high : frequency threshold for low pass filter in Hz -> higher frequency
%
% OUTPUT
%   Fx     : filtered data
%   f      : frequency range in Hz
%   mx     : magnitude of frequency spectrum
%   Fmx    : filtered frequency spectrum
%
% HINT 
%   The DC signal is removed from the data before any processing.

% remove DC signal
x = x - mean(x);

% Sampling frequency 
Fs = 1 / TR ;  % in Hz


% check number of dimensions
t_dim = ndims(x);
if t_dim > 2
    error('ERROR: Data vector contains more than 2 dimensions! Abort.');
end


% check for largest dimension, which should be the time dimension
s = size(x);
if s(1) > s(2)
    x = x' ;
end
s = size(x); %refresh


% Number of sampling points, which should be the size of last dimension
TimePoints = s(end);


% Time vector 
t = 0 : TR : TR * TimePoints ;

% Use next highest power of 2 greater than or equal to length(x) to calculate FFT. 
nfft= 2^(nextpow2(TimePoints));


% Calculate the number of unique points 
NumUniquePts = ceil((nfft+1)/2);


% This is an evenly spaced frequency vector with NumUniquePts points. 
f = ( 0 : NumUniquePts-1 ) * Fs / nfft;


% Take fft, padding with zeros so that length(fftx) is equal to nfft 
offtx = fft(x,nfft,t_dim);

% Filter spectrum, get relevant indicees and set symmetric frequencies to
% zero
low  = find( f < f_low  );
high = find( f > f_high );
Fofftx = offtx;
Fofftx( low  )  = complex(0);
Fofftx( high )  = complex(0);
wol  = nfft-low+2;
hgih = nfft-high+2;
wol  = wol(2:end);
hgih = hgih(2:end);
Fofftx( wol  ) = complex(0);
Fofftx( hgih ) = complex(0);

% FFT is symmetric, throw away second half for plot
fftx   = offtx(1:NumUniquePts);
Ffftx = Fofftx(1:NumUniquePts);


% Take the magnitude of fft of x and scale the fft so that it is not a function of 
% the length of x 
mx  = abs(fftx)/length(x);
Fmx = abs(Ffftx)/length(x);


% Take the square of the magnitude of fft of x. 
mx  = mx.^2;
Fmx = Fmx.^2;


% Since we dropped half the FFT, we multiply mx by 2 to keep the same energy.  
% The DC component and Nyquist component, if it exists, are unique and should not 
% be mulitplied by 2. 
if rem(nfft, 2) % odd nfft excludes Nyquist point
  mx(2:end)  = mx(2:end)*2;
  Fmx(2:end) = Fmx(2:end)*2;
else
  mx(2:end -1) = mx(2:end -1)*2;
  Fmx(2:end -1) = Fmx(2:end -1)*2;
end


% Do the inverse fourier transform of the filtered frequency spectrum
Fx = real( ifft( Fofftx , nfft ));
Fx = Fx(1:TimePoints);

% Output:
[ Fx  f  mx  Fmx ];

% END




