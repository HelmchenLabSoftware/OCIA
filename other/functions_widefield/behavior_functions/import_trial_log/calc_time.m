function result = calc_time(final_time, initial_time);
    hr = final_time(1) - initial_time(1);
    if hr > 0
        min = 60 + final_time(2) - initial_time(2);
    else 
        min = final_time(2) - initial_time(2);
    end
    if min > 0
        sec = 60 + final_time(3) - initial_time(3);
    else
        sec = final_time(3) - initial_time(3);
    end
    result = 1000*sec;
end
