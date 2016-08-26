function varargout = sort_cells2d(varargin)
% in1 ... region image produced during segmentation
% in2 ... number of segmented objects (as provided by gvf_seg2d)
% in3 ... reference timecourse image file (tif)
% in4 ... display image
% in5 ... max. size for regions
% out1 ... sorted region image in grayscale
% out2 ... edge image
% out3 ... reference image with edges overlayed
% out4 ... list of cells, sizes, COGs and associated timecourse

if nargin ~= 5
    error('Incorrect number of inputs specified.');
end

infile = varargin{1};
seg_objects = varargin{2};
ref_file = varargin{3};
disp_file = varargin{4};
max_size = varargin{5};
ref_img = tif2mat(ref_file,'nosave');
if isfield(ref_img,'data')
    ref_img = ref_img.data;
else
    error('Reference image must be grayscale');
end

disp_img = tif2mat(disp_file,'nosave');
disp_img = disp_img.data;
img = tif2mat(infile,'nosave');
if ~isfield(img,'red') || ~isfield(img,'green') || ~isfield(img,'blue')
   error('Region image must be RGB');
end
red = double(img.red); green = double(img.green);
blue = double(img.blue);
xsize = size(red,1);
ysize = size(red,2);
index_img = zeros(xsize,ysize);
% recode the RGB values into ascending integers (1 ... no. of elements)
elements = 1;
rgb_vector = 0;
current_rgb = zeros(1,3);
previous_rgb = 0;
for x = 1:xsize
    for y = 1:ysize
        if red(x,y) == 0 && green(x,y) == 0 && blue(x,y) == 0
            continue
        end
        current_rgb = [red(x,y) green(x,y) blue(x,y)];
        if rgb_vector == 0
            rgb_vector = current_rgb;
        end
        for n = 1:size(rgb_vector,1)
            if current_rgb == rgb_vector(n,:)
                index_img(x,y) = n;
                previous_rgb = 1;
                break
            end
        end
        if previous_rgb == 0
            elements = elements + 1;
            rgb_vector(size(rgb_vector,1)+1,:) = current_rgb;
            index_img(x,y) = elements;
        end
        previous_rgb = 0;
    end
end

img = index_img;
clear index_img red green blue 
clear rgb_vector current_rgb previous_rgb elements

% find the number of segmented nuclei (should be equal to number of nuclei
% furnished by CBI)
img_vect = reshape(img,1,xsize*ysize);
values = sort(img_vect);
freq = histc(img_vect,values);
values(freq==0) = [];
freq(freq==0) = [];
% freq(i) is the number of occurences of element values(i)

% discard zeros
freq(values==0) = [];
values(values==0) = [];
% sanity check
cell_no = length(values);
if cell_no ~= seg_objects
   error('Nuclei reported by CBI (%s) and this program (%s) differs!',...
       int2str(seg_objects),int2str(cell_no));
end

% sort according to size of nucleus (frequency of occurence)
[freq_sorted ix] = sort(freq);
values_sorted = zeros(1,cell_no);
for n = 1:length(ix)
    values_sorted(n) = values(ix(n));
end

values_sorted(freq_sorted>max_size) = [];
freq_sorted(freq_sorted>max_size) = [];
fprintf('\nExcluded %s clusters with %s pixels or more\n',...
    int2str(cell_no-numel(values_sorted)),int2str(max_size));
cell_no = numel(values_sorted);

% values_sorted now contains all required info --> relabel img with cell
% segments labelled in order of decreasing size (1 ... largest, cell_no ...
% smallest)
img_sorted = zeros(size(img));
for n = 1:cell_no
    img_sorted(img==values_sorted(n)) = cell_no - n + 1;
end

% list of cell nuclei with colums: index number, size (in pixel), COG x,
% COG y
cell_list = zeros(cell_no,4);
cell_id = 1;
for n = 1:cell_no
        cell_list(cell_id,1) = cell_id;
        cell_list(cell_id,2) = freq_sorted(cell_no - n + 1);
        [y_coords, x_coords] = ind2sub(size(img_sorted),find(img_sorted==n));
        cell_list(cell_id,3) = round(mean(x_coords));
        cell_list(cell_id,4) = round(mean(y_coords));
        clear x_coords y_coords
        cell_id = cell_id + 1;
end

% add mean timecourses to the list
cell_list(:,5:(size(ref_img,3))+4) = 0;
% width and height of img and ref_img must agree
if size(img,1) ~= size(ref_img,1) || size(img,2) ~= size(ref_img,2)
    error('Input and reference image width and height must be equal.');
end
for n = 1:cell_no
    ts_vect = zeros(1,size(ref_img,3));
    counter = 1;
    for x = 1:xsize
        for y = 1:ysize
            if img_sorted(x,y) == n
                ts_vect(counter,:) = ref_img(x,y,:);
                counter = counter + 1;
            end
        end
    end
    cell_list(n,5:(size(ref_img,3))+4) = mean(ts_vect);
end

% create binary and edge images
img_bin = img_sorted;
img_bin(img_bin~=0) = 1;
img_edge = edge(img_bin,'log',0);
% highlight edges on disp_img
% TODO: get gray 2 rgb conversion to work on all images
% (does not currently work with 2d set1)
% ref_img = mean(ref_img,3);
% 
% [ref_img_edge, map] = gray2ind(uint8(ref_img),150);
% ref_img_edge = ind2rgb(ref_img_edge,map);
% for x = 1:xsize
%     for y= 1:ysize
%         if img_edge(x,y) == 1
%            ref_img_edge(x,y,1) = 1;
%            ref_img_edge(x,y,2) = 0;
%            ref_img_edge(x,y,3) = 0;
%         end
%     end
% end

disp_img = mean(disp_img,3);
[disp_img_edge, map] = gray2ind(uint8(disp_img),150);
disp_img_edge = ind2rgb(disp_img_edge,map);
for x = 1:xsize
    for y= 1:ysize
        if img_edge(x,y) == 1
           disp_img_edge(x,y,1) = 1;
           disp_img_edge(x,y,2) = 0;
           disp_img_edge(x,y,3) = 0;
        end
    end
end

% save cell_list as .mat and text
outfile_mat = strrep(ref_file,'.tif','_list.mat');
outfile_txt = strrep(ref_file,'.tif','_list.txt');
save(outfile_mat,'cell_list');
fid = fopen(outfile_txt,'w');
for rows = 1:size(cell_list,1)
    for cols = 1:size(cell_list,2)
        if cols == size(cell_list,2)
            fprintf(fid,'%5.2f\n',cell_list(rows,cols));
        else
            fprintf(fid,'%5.2f\t',cell_list(rows,cols));
        end
    end
end
fclose(fid);
varargout{1} = img_sorted;
varargout{2} = img_edge;
% varargout{3} = ref_img_edge;
varargout{3} = disp_img_edge;
varargout{4} = cell_list;
% e.o.f.