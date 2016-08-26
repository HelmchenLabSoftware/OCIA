function dir_list = DirListRecursive(varargin)
% get all directories from the current directory downwards in recursive
% fashion
% optional input argument: start directory
% optional input argument: match string (e.g. 'test' means that only
% directories containing string 'test' will be included in output
% returns cell string dir_list which contains full paths to directories in
% column cell string
% the start directory is listed first in dir_list

% this file written by Henry Luetcke (hluetck@gmail.com)

if ~nargin
    start_dir = pwd;
else
    start_dir = varargin{1};
end
if isempty(start_dir)
    start_dir = pwd;
end
cd(start_dir);
dir_content = dir;
dir_list = [];
visited_dirs = [];
for n = 1:length(dir_content)
   if dir_content(n).isdir
      if strcmp(dir_content(n).name,'.') || ...
              strcmp(dir_content(n).name,'..')
          continue
      end
      if ~max(strcmp(dir_list,fullfile(pwd,dir_content(n).name)))
          dir_list{length(dir_list)+1,1} = ...
              fullfile(pwd,dir_content(n).name);
      end
   end
end
visited_dirs{length(visited_dirs)+1,1} = start_dir;
for n = 1:length(dir_list)
    if ~max(strcmp(visited_dirs,dir_list{n}))
        visited_dirs{length(visited_dirs)+1} = dir_list{n};
        current_dir_list = DirListRecursive(dir_list{n});
        dir_list = [dir_list;current_dir_list];
    end
end
cd(start_dir);
dir_list = [start_dir; dir_list];

dir_list_short = {};
pos = 0;
if nargin > 1
    for n = 1:length(dir_list)
        if ~isempty(strfind(dir_list{n},varargin{2}))
           pos = pos + 1;
           dir_list_short{pos} = dir_list{n};
        end
    end
    dir_list = dir_list_short';
end

