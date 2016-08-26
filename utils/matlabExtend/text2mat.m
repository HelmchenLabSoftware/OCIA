function mat = text2mat(textString,dims)

im = zeros(dims);
%% Create the text mask
% Make an image the same size and put text in it
hf = figure('color','white','units','normalized','position',[.1 .1 .8 .8]);
image(ones(size(im)));
set(gca,'units','pixels','position',[5 5 size(im,2)-1 size(im,1)-1],'visible','off')

% Text at arbitrary position
text('units','pixels','position',[10 round(size(im,1)/2)],...
    'fontsize',30,'string',textString)

% Capture the text image
% Note that the size will have changed by about 1 pixel
tim = getframe(gca);

close(hf)

mat = max(tim.cdata,[],3);