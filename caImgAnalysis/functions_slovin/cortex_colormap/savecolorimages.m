image = G_rid(:,:,[1,1,1]);

ctx_path = 'F:\Paradigm\square\';
[imgInd,map] = rgb2ind(image,2);    %Index the image
orgmat = double(imgInd);
[x,y] = size(orgmat);
offset = 128;
dmns =  [8, y, x, 1];
notes = '0123456789';
savecx([ctx_path,'image1.ctx'], notes, dmns, orgmat,offset);
savelut_new([ctx_path,'image1.lut'], map);


