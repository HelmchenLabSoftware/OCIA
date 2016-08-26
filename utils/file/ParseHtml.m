function titles = ParseHtml(url)
% extract the titles from xml-formatted RSS website, like BBC news

% this file written by Henry Luetcke (hluetck@gmail.com)

% xml-feeds items structure: <item><title>Title</title> ...

try
    [s,status] = urlread(url);
    item_idx = strfind(s,'<item>');
    startTitle_idx = strfind(s,'<title>');
    stopTitle_idx = strfind(s,'</title>');
    
    for n = 1:length(item_idx)
        current_idx = item_idx(n);
        for m = 1:length(startTitle_idx)
            if startTitle_idx(m) > current_idx
                current_start = startTitle_idx(m);
                current_stop = stopTitle_idx(m);
                break
            end
        end
        titles{n} = s(current_start+7:current_stop-1);
    end
catch
    fprintf('Sorry, could not open this feed.');
    titles = [];
    return
end




