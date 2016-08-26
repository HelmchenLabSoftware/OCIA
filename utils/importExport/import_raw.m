function varargout = import_raw(varargin)
% import raw 2PI files as written by Focus program (Werner)
% in1 ... input filename (string / cell array of strings)
% in2 ... width (pixels)
% in3 ... height (pixels)
% in4 ... offset to first image (bytes)
% in5 ... no. of images to read (default: all)
% in6 ... channel to read ('le' ... little-endian, 'be' ... big-endian,
% 'both' ... both channels, default: 'both')
% all inputs are optional --> if no inputs are provided, a user interface
% pops up to allow specification (multiple file select supported)
% if you decide to provide input args, you MUST specify in1 - in4, as they
% do not have default values
% in1 can be specified alone, GUI is called to specify parameters
% assigns struct variables in base workspace and returns them as well 

% this file written by Henry Luetcke (hluetck@gmail.com)

if nargin > 1
    if nargin < 4 || nargin > 6
        disp('Invalid number of input arguments.');
        help import_raw
        A = 0;
        return
    end
    file = varargin{1};
    if ~iscellstr(file)
        [PathName,Name,Extension] = fileparts(file);
        file = [Name Extension];
        file = {file};
    end
    dim1 = varargin{2};
    dim2 = varargin{3};
    hdr_size = varargin{4};
    images = [];
    channel = 'both';
    if nargin == 5
        images = varargin{5};
    elseif nargin == 6
        images = varargin{5};
        channel = varargin{6};
    end
elseif nargin == 1
    file = varargin{1};
    if ~iscellstr(file)
        [PathName,Name,Extension] = fileparts(file);
        file = [Name Extension];
        file = {fullfile(PathName,file)};
    end
    % try to guess file structure
    current_file = file{1};
    fid = fopen(current_file,'r','b');
    dim1 = fread(fid,2,'*uint16',278); dim1 = dim1(2);
    fclose(fid);
    fid = fopen(current_file,'r','b');
    dim2 = fread(fid,2,'*uint16',280); dim2 = dim2(2);
    fclose(fid);
    hdr_size = 768; images = []; channel = 'both';
else
    disp('No input arguments. Calling GUI.');
    [FileName, PathName] = uigetfile('*.*','Select file for reading',...
        'MultiSelect','on');
    file = FileName;
    if ~iscellstr(file)
        file = {file};
    end
    %     file = fullfile(PathName, FileName);
    [dim1,dim2,hdr_size,images,channel] = inputGUI;
end
for file_no = 1:numel(file)
    current_file = file{file_no};
    [cur_path,cur_name,cur_ext] = fileparts(current_file);
    if ~strcmp(channel,'be')
        % first read the red channel (little-endian)
        fid = fopen(current_file);
        hdr = fread(fid,hdr_size,'uint8');
        A.ch2 = fread(fid,'uint16','ieee-le');
        fclose(fid);
        slices = numel(A.ch2) / (double(dim1)*double(dim2));
        A.ch2 = reshape(A.ch2,dim1,dim2,slices);
        loaded_images = slices;
        if ~isempty(images) && images < slices
            A.ch2(:,:,images+1:slices) = [];
            loaded_images = images;
        end
        fprintf('\nLoaded %s of %s frames in channel 2\n',...
            num2str(loaded_images),num2str(slices));
        Atemp = zeros(size(A.ch2,2),size(A.ch2,1),size(A.ch2,3));
        for n = 1:size(A.ch2,3)
            Atemp(:,:,n) = rot90(A.ch2(:,:,n),3);
            Atemp(:,:,n) = fliplr(Atemp(:,:,n));
        end
        
        A.ch2 = Atemp;
        clear Atemp
        
        % display
        %     max_val = max(max(max(A.ch2)));
        %     h_ch2 = implay((A.ch2/max_val),5);
    end
    if ~strcmp(channel,'le')
        % then the green channel (big-endian)
        fid = fopen(current_file);
        hdr = fread(fid,hdr_size,'uint8');
        A.ch1 = fread(fid,'uint16','ieee-be');
        fclose(fid);
        slices = numel(A.ch1) / (double(dim1)*double(dim2));
        A.ch1 = reshape(A.ch1,dim1,dim2,slices);
        loaded_images = slices;
        if ~isempty(images) && images < slices
            A.ch1(:,:,images+1:slices) = [];
            loaded_images = images;
        end
        fprintf('\nLoaded %s of %s frames in channel 1\n',...
            num2str(loaded_images),num2str(slices));
        Atemp = zeros(size(A.ch1,2),size(A.ch1,1),size(A.ch1,3));
        for n = 1:size(A.ch1,3)
            Atemp(:,:,n) = rot90(A.ch1(:,:,n),3);
            Atemp(:,:,n) = fliplr(Atemp(:,:,n));
        end
        A.ch1 = Atemp;
        clear Atemp
        % display
        %     max_val = max(max(max(A.ch1)));
        %     h_ch1 = implay((A.ch1/max_val),5);
    end
    varargout{file_no} = A;
%     struct_name = genvarname(cur_name);
%     assignin('base',struct_name,A);
    clear A
end


    function [dim1,dim2,hdr_size,images,channel] = inputGUI
        % check if .import_raw exists
        config_path = fileparts(mfilename('fullpath'));
        config_file = fullfile(config_path,'.import_raw');
        % default settings based on .import_raw
        if exist(config_file,'file') == 2
            fid2 = fopen(config_file);
            C = textscan(fid2,'%s%s\n');
            fclose(fid2);
            pars = C{1}; vals = C{2};
            width_string = vals{strcmp(pars,'width')};
            height_string = vals{strcmp(pars,'height')};
            skip_string = vals{strcmp(pars,'skip')};
            frame_string = vals{strcmp(pars,'frames')};
            channel_string = vals{strcmp(pars,'channel')};
            def = {width_string,height_string,skip_string,...
                frame_string,channel_string};
        else
            def = {'128','128','768','','both'};
        end
        prompt = {'Width (pixels):','Height (pixels):','Bytes to skip:',...
            'Number of frames:','Channel (le,be,both):'};
        dlg_title = 'Import parameters';
        num_lines = 1;
        answer = inputdlg(prompt,dlg_title,num_lines,def);
        dim1 = str2double(answer{1});
        dim2 = str2double(answer{2});
        hdr_size = str2double(answer{3});
        if ~isempty(answer{4})
            images = str2double(answer{4});
        else
            images = [];
        end
        channel = answer{5};
        % write current settings as new defaults
        fid2 = fopen(config_file,'w');
        fprintf(fid2,'width %s\nheight %s\nskip %s\nframes %s\nchannel %s\n',...
            num2str(dim1),num2str(dim2),num2str(hdr_size),...
            num2str(images),channel);
        fclose(fid2);
    end

end



% e.o.f.

