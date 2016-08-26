function unixTime = dn2unix(dateNumTime)
% Converts matlab's datenum to UNIX epoch time in milliseconds (1970-01-01@00:00)
    unixTime = (dateNumTime - 719529) * 86400000;
end
