function savelut_new(filename, map)

[fid, msg] = fopen(filename, 'w');
[fn, pp, ar] = fopen(fid);
mapi = round(map * 255);
mapi(:,4)=0;

% fwrite(fid, mapi', 'uint16');
fwrite(fid, mapi', 'ushort');
fclose(fid);