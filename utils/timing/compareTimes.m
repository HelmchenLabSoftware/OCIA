function stimIx = compareTimes(t1,stims)
t_diff = zeros(1,numel(stims));
for n = 1:numel(stims)
    t2 = stims{n}.stimTime;
    t1 = strrep(t1,'h','');
    t2 = strrep(t2,'h','');
    currentDate = t1(1:strfind(t1,'__')-1);
    current_t1 = t1(strfind(t1,'__')+2:end);
    current_t2 = t2(strfind(t2,'__')+2:end);
    datestr_t1 = strrep(current_t1,'_',':');
    datestr_t2 = strrep(current_t2,'_',':');
    t_diff(n) = etime(datevec(datestr_t1),datevec(datestr_t2));
end
[~,stimIx] = min(abs(t_diff));

