function wave = ReadIgorDatFile(baseName)

% this file written by Henry Luetcke (hluetck@gmail.com)

% there should be a logfile with file information
logfile = [baseName '.log'];
fid = fopen(logfile);
while ~feof(fid)
    tline = fgetl(fid);
    numpoints = sscanf(tline,'NUMPNTS:%d',1);
end
fclose(fid);

datFile = [baseName '.dat'];
fid = fopen(datFile);
wave = fread(fid,numpoints,'float32');
fclose(fid);