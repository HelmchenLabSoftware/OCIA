function frame_mc = Moco2P(frame,refframe)
% performs motion correction of a frame scan (2D only) using an elastic
% model
% based on code from Dirk-Jan Kroon (demon_reg)
% refframe can be a number (which volume to register to) or a string (e.g.
% 'mean') if moco should be performed wrt mean frame

% this file written by Henry Luetcke (hluetck@gmail.com)

if ischar(refframe)
    switch refframe
        case 'mean'
            S = mean(frame,3);
        case 'median'
            S = median(frame,3);
        case 'max'
            S = max(frame,[],3);
    end
else
    S = frame(:,:,refframe);
end

frame_mc = zeros(size(frame));
t = zeros(1,size(frame,3));
% loop over frames to do registration (this can be parallelized, in
% principle)

for frame_no = 1:size(frame,3)
    tic;
    M=frame(:,:,frame_no);
    
    % Alpha (noise) constant
    alpha=2.5;
    
    % Velocity field smoothing kernel
    Hsmooth=fspecial('gaussian',[60 60],10);
    
    % The transformation fields
    Tx=zeros(size(M)); Ty=zeros(size(M));
    
    [Sy,Sx] = gradient(S);
    for itt=1:200
        % Difference image between moving and static image
        Idiff=M-S;
        
        % Default demon force, (Thirion 1998)
        %Ux = -(Idiff.*Sx)./((Sx.^2+Sy.^2)+Idiff.^2);
        %Uy = -(Idiff.*Sy)./((Sx.^2+Sy.^2)+Idiff.^2);
        
        % Extended demon force. With forces from the gradients from both
        % moving as static image. (Cachier 1999, He Wang 2005)
        [My,Mx] = gradient(M);
        Ux = -Idiff.*  ((Sx./((Sx.^2+Sy.^2)+alpha^2*Idiff.^2))+(Mx./((Mx.^2+My.^2)+alpha^2*Idiff.^2)));
        Uy = -Idiff.*  ((Sy./((Sx.^2+Sy.^2)+alpha^2*Idiff.^2))+(My./((Mx.^2+My.^2)+alpha^2*Idiff.^2)));
        
        % When divided by zero
        Ux(isnan(Ux))=0; Uy(isnan(Uy))=0;
        
        % Smooth the transformation field
        Uxs=3*imfilter(Ux,Hsmooth);
        Uys=3*imfilter(Uy,Hsmooth);
        
        % Add the new transformation field to the total transformation field.
        Tx=Tx+Uxs;
        Ty=Ty+Uys;
        M=movepixels(frame(:,:,frame_no),Tx,Ty);
    end
    frame_mc(:,:,frame_no) = M;
    t(frame_no) = toc;
    fprintf('Processed frame %1.0f in %2.2f s\n',frame_no,t(frame_no));
end





