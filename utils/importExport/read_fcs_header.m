function A = read_fcs_header(filename)
% decode the header of Focus2008 fcs-files
% decoder based on LabView program HeaderInverse.vi

% this file written by Henry Luetcke (hluetck@gmail.com)

fields = {'Version' 'Filename' 'User' 'Acquisition time at save' ...
    'Acquisition date at save' 'Time at start of grab (ms)' ...
    'Time at stop of grab (ms)' 'z starting position (nm)' 'header length' ...
    'x starting position (nm)' 'y starting position (nm)' 'last x position (nm)' ...
    'last y position (nm)' 'last z position (nm)' 'attenuation depth' ...
    'intensity device used' 'start intensity (% max)' 'pixel clock (MHz)' ...
    'X lead time (us)' 'Xpixels1' 'Ylines1' 'images' 'images averaged / step'...
    'Xpixels2' 'Ylines2' 'Line scan time (ms)' 'X retrace duration (ms)' ...
    'Z axis increment (nm)' 'X axis increment (nm)' 'Y axis increment (nm)' ...
    'X scan range (V*100)' 'Y scan range (V*100)' 'X offset (V*100)' ...
    'Y offset (V*100)' 'Angle (*100)' 'Zoom factor' 'Stack Number' ...
    'Time interval (s)' 'z rotation angle' 'XPixels FreeLine' 'YLines FreeLine'...
    'Amplitude Factor' 'Pixel Clock FreeLine (Hz)' 'Phase shift' 'Mode selector' ...
    'Cusp delay (pixels)' 'Fscope' 'Pixel Clock LS (Hz)' 'Scans to read LS' 'LS X/Y' ...
    'DataOffset' 'DataLength' 'ScanLineLength' 'ZSinlength'};
A(:,1) = fields';
n = 1;
fid = fopen(filename);
% version
A(n,2) = {fread(fid,2,'*char')}; n=n+1;
% filename
A(n,2) = {fread(fid,14,'*char')'}; n=n+1;
% username
A(n,2) = {fread(fid,16,'*char')'}; n=n+1;
% acq. time
A(n,2) = {fread(fid,5,'*char')'}; n=n+1;
% acq. date
A(n,2) = {fread(fid,10,'*char')'}; n=n+1;
% grab start
A(n,2) = {(fread(fid,1,'uint8=>uint32')')}; n=n+1;
% grab stop
A(n,2) = {(fread(fid,1,'uint8=>uint32')')}; n=n+1;
% start pos z
A(n,2) = {(fread(fid,1,'uint8=>int32')')}; n=n+1;
% header length
A(n,2) = {(fread(fid,1,'uint8=>uint32')')}; n=n+1;
% start pos x
A(n,2) = {fread(fid,1,'uint8=>int8')'}; n=n+1;
% start pos y
A(n,2) = {fread(fid,1,'uint8=>int8')'}; n=n+1;

fclose(fid);






