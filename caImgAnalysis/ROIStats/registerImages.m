function [in_reg,tform] = registerImages(in,ref)
% in ... the input image (will be registered to the reference image), 2D
% ref ... the reference image (usu. higher spatial resolution), 2D

% this file written by Henry Luetcke (hluetck@gmail.com)

% equilibrate brightness
in = linScale(in,0,255);
ref = linScale(ref,0,255);

% check aspect ratio
if (size(ref)./min(size(ref))) == (size(in)./min(size(in)))
   aspectEqual = 1;
else
    aspectEqual = 0;
end

if (size(ref) ~= size(in)) & aspectEqual
    in = imresize(in,[size(ref,1) size(ref,2)]); % imresize performs bicubic interpolation by default
    in_cc = in;
elseif aspectEqual
    in_cc = in;
else
    % different aspect ratios
    in_cc = padarray(in,[(size(ref,1)-size(in,1))./2 ...
        (size(ref,2)-size(in,2))./2],NaN);
end

% correlation between ref and in before any spatial transformation
r1 = corrNaNignore(ref,in_cc);
fprintf('Correlation before any transformations: %1.3f\n',r1)

% % display ref and in_reg
h1 = figure('Name','Image registration','NumberTitle','off');
subplot(1,2,1)
imshow(ref,[],'initialmagnification','fit')
title('Reference image')
subplot(1,2,2)
imshow(in_cc,[],'initialmagnification','fit')
title('Input image')

% ask for control points or continue
qstring = sprintf('Image correlation is %1.3f\nDo you wish to select control points for registration?',r1);
button = questdlg(qstring,'Select control points?','Skip','Select','Skip');
switch button
    case 'Select'
        inScaled = linScale(double(in));
        refScaled = linScale(double(ref));
        [cp_in,cp_ref] = cpselect(inScaled,refScaled,'Wait',true);
        cp_in = cpcorr(cp_in,cp_ref,inScaled,refScaled);
        tform = cp2tform(cp_in,cp_ref,'affine'); % affine transformation
        in_reg = imtransform(in,tform,'xdata',[1 size(in,2)],'ydata',[1 size(in,1)]);
    otherwise
        in_reg = in;
        tform = [];
end

% fully automatic image registration using imregister
% imregister does not return a tform
% from 2013a: call the function imregtform. The function imregtform returns 
% a geometric transformation object that can be applied to the moving image 
% using the new function imwarp.
% http://www.mathworks.com/help/images/ref/imregtform.html
% imregister calls imregtform to obtain the geometric transformation that 
% registers the moving image to the fixed image and then calls imwarp to 
% produce the returned output image
% also consider using FSL's FLIRT / FNIRT for doing fully automatic image
% registration for free

% configure
[optimizer,metric] = imregconfig('monomodal');
optimizer.MaximumIterations = 1000;
optimizer.MinimumStepLength = 1e-6;
optimizer.RelaxationFactor = 0.7;
in_reg = imregister(in_reg,ref,'affine',optimizer,metric);

r2 = corrNaNignore(ref,in_reg);
fprintf('Correlation after transformation: %1.3f\n',r2)


% display ref and in_reg
close(h1)
h1 = figure('Name','Image registration','NumberTitle','off');
subplot(1,3,1)
imshow(ref,[],'initialmagnification','fit')
title('Reference image')
subplot(1,3,2)
imshow(in,[],'initialmagnification','fit')
title('Input image')

subplot(1,3,3)
imshow(in_reg,[],'initialmagnification','fit')
title('Registered Input image')


figure('Name','Image registration - Overlay','NumberTitle','off');
imshowpair(ref,edge(in_reg,'prewitt'),'method','blend')




% qstring = sprintf('Image correlation is %1.3f\nAccept or start again?',r2);
% button = questdlg(qstring,'Accept registration?','Accept','Start again','Accept');
% close(h1)
% switch button
%     case 'Accept'
%         return
%     case 'Start again'
%         [in_reg,tform] = registerImages(in,ref);
% end




