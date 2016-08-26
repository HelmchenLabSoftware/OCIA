function varargout = sort_cells3d(varargin)
% in1 ... region image produced during segmentation
% in2 ... number of segmented objects (as provided by gvf_seg3d) as string
% out 1 ... sorted region image as grayscale
% out 2 ... list of cells, sizes, COGs

if nargin ~= 2
    error('Incorrect number of inputs specified.');
end

infile = varargin{1};
seg_objects = str2num(varargin{2});
% ref_img = tif2mat(ref_file,'nosave');
% if isfield(ref_img,'data')
%     ref_img = ref_img.data;
% else
%     error('Reference image must be grayscale');
% end

nii = load_nii(infile);
img = uint16(nii.img);
clear nii

xsize = size(img,1);
ysize = size(img,2);
zsize = size(img,3);
index_img = zeros(xsize,ysize,zsize);
% nii = load_nii(edges);
% img_edge = zeros(xsize,ysize,zsize);
% for n = 1:zsize
%     img_edge(:,:,n) = im2bw(nii.img(:,:,n));
% end
% clear nii

% recode the gray-values into ascending integers (1 ... no. of elements)
% (coding in the regions Analyze file is from 'top' to 'bottom' and not
% quite ascending)
elements = 1;
gray_vector = zeros(1,seg_objects);
previous_gray = 0;
for x = 1:xsize
    for y = 1:ysize
        for z = 1:zsize
            if img(x,y,z) == 0
                continue
            end
            current_gray = img(x,y,z);
            if isempty(gray_vector)
                gray_vector = current_gray;
            end
            if ~isempty(find(gray_vector==current_gray, 1))
                index_img(x,y,z) = elements;
                previous_gray = 1;
            end
            if previous_gray == 0
                elements = elements + 1;
                gray_vector(elements) = current_gray;
                index_img(x,y,z) = elements;
            end
            previous_gray = 0;
        end
    end
end

img = index_img;
clear index_img gray_vector current_gray previous_gray elements

% find the number of segmented nuclei (should be equal to number of nuclei
% furnished by CBI)
img_vect = reshape(img,1,xsize*ysize*zsize);
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

% values_sorted now contains all required info --> relabel img with cell
% segments labelled in order of decreasing size (1 ... largest, cell_no ...
% smallest)
img_sorted = img;
for n = 1:cell_no
    img_sorted(img==values_sorted(n)) = cell_no - n + 1;
end

% list of cell nuclei with colums: index number, size (in pixel), COG x,
% COG y, COG z
cell_list = zeros(cell_no,5);
for n = 1:cell_no
    cell_list(n,1) = n;
    cell_list(n,2) = freq_sorted(cell_no - n + 1);
    [y_coords, x_coords, z_coords] = ...
        ind2sub(size(img_sorted),find(img_sorted==n));
    cell_list(n,3) = round(mean(x_coords));
    cell_list(n,4) = round(mean(y_coords));
    cell_list(n,5) = round(mean(z_coords));
    clear x_coords y_coords z_coords
end

varargout{1} = img_sorted;
varargout{2} = cell_list;
% add mean timecourses to the list (would require a 4D file with multiple
% 3D timepoints)
% cell_list(:,5:(size(ref_img,3))+4) = 0;
% % width and height of img and ref_img must agree
% if size(img,1) ~= size(ref_img,1) || size(img,2) ~= size(ref_img,2)
%     error('Input and reference image width and height must be equal.');
% end
% for n = 1:cell_no
%     ts_vect = zeros(1,size(ref_img,3));
%     counter = 1;
%     for x = 1:xsize
%         for y = 1:ysize
%             if img_sorted(x,y) == n
%                 ts_vect(counter,:) = ref_img(x,y,:);
%                 counter = counter + 1;
%             end
%         end
%     end
%     cell_list(n,5:(size(ref_img,3))+4) = mean(ts_vect);
% end

% save cell_list as .mat and text
outfile_mat = strrep(infile,'.hdr','_list.mat');
outfile_txt = strrep(infile,'.hdr','_list.txt');
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
varargout{2} = cell_list;
% e.o.f.