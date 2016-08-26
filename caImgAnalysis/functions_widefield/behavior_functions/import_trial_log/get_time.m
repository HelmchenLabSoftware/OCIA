function return_time = get_time(timestamp)
        timestamp = char(timestamp);
        hr = timestamp(1:2);
        min = timestamp(4:5);
        sec = timestamp(7:13);
        hr = str2double(hr);
        min = str2double(min);
        sec = str2double(sec);
        return_time = [hr min sec];
end