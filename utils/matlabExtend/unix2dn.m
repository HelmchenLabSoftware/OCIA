function dateNumTime = unix2dn(unixTime)
% Converts UNIX epoch time in milliseconds (1970-01-01@00:00) to matlab's datenum
    dateNumTime = unixTime/86400000 + 719529;         %# == datenum(1970,1,1)
end
