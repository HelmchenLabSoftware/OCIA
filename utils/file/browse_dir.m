function [] = browse_dir

% browse through directories, finding directories with certain files
% in its current form, returns a file (temp2.txt) in the base directory
% which contains a list of valid feat directories for further analysis
% for this to work, base_dir must be set to Z:\siemens

% this file written by Henry Luetcke (hluetck@gmail.com)

global SERIES_DIR_COUNT BASE_DIR

cd('Z:\siemens');
fid_log = fopen('browse_dir_log.txt','w');

base_dir = cd;
% disp(base_dir);
fprintf(fid_log,'Opened base directory %s \n',base_dir);

base_content = dir(base_dir);
vol_dir_count = 0;
series_dir_count = 0;

fid = fopen('temp1.txt','w');
for n = 1:length(base_content)
    if base_content(n).isdir == 1
        check_string = strmatch('vol_37',base_content(n).name);
        if check_string == 1
            fprintf(fid,'%s \n',base_content(n).name);
%           disp(base_content(n).name);
            vol_dir_count = vol_dir_count + 1;
        end
    end
end

fclose(fid);

fid = fopen('temp2.txt','w');
fclose(fid);

for n = 1:vol_dir_count
    cd(base_dir);
    temp1_filename = [base_dir,'\temp1.txt'];
    [volunteer] = textread(temp1_filename,'%s',1,'headerlines',n-1);
    volunteer = char(volunteer);
    vol_dir = ['Z:\siemens\',volunteer];
    vol_dir_disp = ['Entering directory ',vol_dir];
    disp(vol_dir_disp);
    cd(vol_dir);
    fprintf(fid_log,'Opened volunteer directory %s \n',vol_dir);
    vol_dir_content = dir(vol_dir);
    for m = 1:length(vol_dir_content)
        if strcmpi('results',vol_dir_content(m).name) == 1
            dir_check = 1;
            results = vol_dir_content(m).name;
            break
        else
            dir_check = 0;
        end
    end
    if dir_check == 1
        results_dir = [vol_dir,'\',results];
        cd(results_dir);
        fprintf(fid_log,'Opened results directory %s \n',results_dir);
    else
        continue
    end
    results_dir_content = dir(results_dir);
    for o = 1:length(results_dir_content)
        if results_dir_content(o).isdir == 1
            if strcmpi('Analyze',results_dir_content(o).name) == 1
                dir_check = 1;
                analyze = results_dir_content(o).name;
                break
            else
                dir_check = 0;
            end
        else
            dir_check = 0;
        end
    end
    if dir_check == 1
        analyze_dir = [results_dir,'\',analyze];
        cd(analyze_dir);
        fprintf(fid_log,'Opened Analyze directory %s \n',analyze_dir);
    else
        continue
    end
    analyze_dir_content = dir(analyze_dir);
    temp2_filename = [base_dir,'\temp2.txt'];
    fid = fopen(temp2_filename,'a');
    ser_dir_count = 0;
    for p = 1:length(analyze_dir_content)
        if analyze_dir_content(p).isdir == 1
            check_string = strmatch('ser',analyze_dir_content(p).name);
            if check_string == 1
                series = analyze_dir_content(p).name;
                series_dir = [analyze_dir,'\',series];
                fprintf(fid,'%s \n',series_dir);
                fprintf(fid_log,'Wrote directory %s to file temp2.txt \n',series_dir);
                series_dir_count = series_dir_count + 1;
            end
        end
    end
    fclose(fid);
end
SERIES_DIR_COUNT = series_dir_count;
BASE_DIR = base_dir;
delete(temp1_filename);
cd(base_dir);
fclose(fid_log);