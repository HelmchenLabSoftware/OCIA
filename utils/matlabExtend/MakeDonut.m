function mat = MakeDonut(width,r1_in,r2_in,r1_out,r2_out,an_in,an_out,brightness)
% create a square 2D-matrix with size 'width' which contains a center
% circle of radius r1 and a surrounding rim with radius r2
% brightness is an optional vector containing intensity values for the 3
% components in the order inner disk, outer rim, background
% default if empty: [0,1,0]
% this file written by Henry Luetcke (hluetck@gmail.com)

if r1_in >= r1_out || r2_in >= r2_out
    mat = [];
    return
end

if isempty(brightness)
   brightness = [0,1,0];
end

init_val = rand;
mat = repmat(init_val,width,width);

% inner ellipse
seed_cog = [round(width/2)+1 round(width/2)+1];
[x_in,y_in] = ellipse(r1_in,r2_in,an_in,seed_cog,10000,0);
vert_in = [y_in' x_in'];

% outer ellipse
[x_out,y_out] = ellipse(r1_out,r2_out,an_out,seed_cog,10000,0);
vert_out = [y_out' x_out'];

% create inner disk
for n = 1:size(vert_in,1)
    row = vert_in(n,2); col = vert_in(n,1);
    row = seed_cog(1) + (row - seed_cog(1));
    if row < 1
       row = 1;
    end
    if row > size(mat,1)
       row = size(mat,1);
    end
    col = seed_cog(2) + (col - seed_cog(2));
    if col < 1
       col = 1;
    end
    if col > size(mat,2)
       col = size(mat,2);
    end
    mat(round(row),round(col)) = 2;
end
mat = imfill(mat,'holes');

% create outer disk
for n = 1:size(vert_out,1)
    row = vert_out(n,2); col = vert_out(n,1);
    row = seed_cog(1) + (row - seed_cog(1));
    if row < 1
       row = 1;
    end
    if row > size(mat,1)
       row = size(mat,1);
    end
    col = seed_cog(2) + (col - seed_cog(2));
    if col < 1
       col = 1;
    end
    if col > size(mat,2)
       col = size(mat,2);
    end
    mat(round(row),round(col)) = 1;
end
mat = imfill(mat,'holes');

% at this point, bg is coded 0, outer rim 1 and inner rim 2
mat(mat==2) = brightness(1);
mat(mat==1) = brightness(2);
mat(mat==init_val) = brightness(3);

% imshow(mat,[])


% e.o.f.

