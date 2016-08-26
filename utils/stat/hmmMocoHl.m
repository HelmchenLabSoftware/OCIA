function data_mc = hmmMocoHl(data,maxdx,maxdy)
%data is a cell array containing 1 or several 3D matrices (x*y*t)
%first matrix (data{1}) is always used for calculating the registration
%(this should be a static channel), the model is then applied to all
%matrices in data
%MAXDX is the maximum offset in pixels you estimate is observed in the X
%direction (across columns)
%MAXDY is the maximum offset in pixels you estimate is observed in the Y
%direction (across rows)
%these two parameters should be set high enough so that the maximal offset
%is never reached, but as small as possible as the running time increases and
%accuracy of placement decreases as these values get larger.

% this function written by Henry Luetcke (hluetck@gmail.com)
% based on HMM motion correction code by F. Collman and D. Tank
% Copyright Princeton University, 2007

%% initialize
frameRate = 9.16;
msecperframe = 1/frameRate*1000;
framesper30sec=floor(30000/msecperframe);

doPar = matlabpool('size');

Nx=2*maxdx+1;
Ny=2*maxdy+1;

h = waitbar(1,'please hold on');

% all matrices in data must be the same size
rows = size(data{1},1);
cols = size(data{1},2);
numframes = size(data{1},3);
for n = 1:numel(data)
    if ~isequal(size(data{n}),[rows cols numframes])
        error('All channels must have same size')
    end
end
N = cols;
% convert x*y*t matrix to t*x*y matrix
for n = 1:numel(data)
    currentMat = zeros(size(data{n},3),size(data{n},1),size(data{n},2));
    if doPar
        parfor t = 1:numframes
            currentMat(t,:,:) = data{n}(:,:,t);
        end
    else
        for t = 1:numframes
            currentMat(t,:,:) = data{n}(:,:,t);
        end
    end
    data{n} = currentMat;
end
clear currentMat

%% split_createPI
%find_gain takes a movie and calculates the gain by comparing the std and
%mean of pixels over a "stillest" section of movie
%in this case 50 frames as indicated by the second parameter passed.
%see find_gain for more details...
%if you have a manaul calibration you could substitute that here..
gain=find_gain(data{1},50);

%break the movie up into 30 second intervals
numstills=floor(numframes/framesper30sec)+1;

%stillimages are the reference frames which we will be aligning too
if doPar
    parfor i=1:numstills
        [minval,minimage]=min(mean(mean(abs(diff(data{1}(1+(i-1)*...
            framesper30sec:min(i*framesper30sec,numframes),:,:),1)),2),3));
        stillimages(i,:,:)=data{1}(minimage+(i-1)*framesper30sec,:,:);
    end
else
    for i=1:numstills
        [minval,minimage]=min(mean(mean(abs(diff(data{1}(1+(i-1)*...
            framesper30sec:min(i*framesper30sec,numframes),:,:),1)),2),3));
        stillimages(i,:,:)=data{1}(minimage+(i-1)*framesper30sec,:,:);
    end
end

edgebuffer=maxdy;

%this function aligns all the reference frames to another using maximal
%cross correlation looking over a range of offsets (in this case 5)
%hopefully these values should all be very small as the reference frames
%have basically the same overall shape.. we found this to be true in our
%data but it is not guaranteed.
waitbar(0.1,h,'Aligning Reference Images...');
stilloffsets=refs_align(stillimages,5)
frames=1:numframes;

%this is the total number of lines we will consider placing since we don't
%try to place the top/bottom maxdy lines
numlines=(N-2*edgebuffer+1)*numframes;

%this is the matrix for which we will store the fits for each offset.
PIsave=zeros(numlines,Ny,Nx);
%m is the index we will use to order the lines for which we have placed
m=0;
%this stores which line of the data is at which index
msave=zeros(numlines,2);
%this stores the times it took to do each frame for my crude progress bar
tocs=zeros(numframes,1);


waitbar(0.2,h,'Calculating PI...');
for i=frames
    %note the time at the start of the frame
    tic;
    %which reference frame are we aligning to
    stillindex=floor(i/framesper30sec)+1;
    %pull out that reference frame
    refimage=squeeze(stillimages(stillindex,:,:));
    
    %scan over all the lines in that frame that we are considering
    for j=1+edgebuffer:N-edgebuffer
        %increment our index
        m=m+1;
        %note which line it is
        msave(m,:)=[i j];
        
        %pull out the line we are placing
        lineextract=squeeze(data{1}(i,j,:));
        %this function takes the line we are trying to fit, the reference
        %image.. the maximum offsets, and the expected position of the line
        %and returns the log fit probabilities into the PIsave matrix
        %see create_fit_markov for more details
        PIsave(m,:,:)=create_PI_markov(lineextract,refimage,maxdx,maxdy,j);
        
        %this is if you wanted to visualize the fits as they are being made
        %useful for debugging, but slow.
        %       figure(1);
        %       imagesc(squeeze(PIsave(m,:,:)));
        %       %colorbar;
        %       pause(.05);
    end
    %note the time at the end of the frame
    tocs(i)=toc;
    
    %estimate the average time it took for frames to be processed
    delframes=mean(tocs(max(i-9,1):i));
    %use that to estimate the time remaining
    minremain=(numframes-i)*delframes/60;
    %show what frame you are on, how much time is remaining and how much
    %time that frame took
    waitbar(0.2+.7*(i/length(frames)),h,['Frame ' num2str(i) ', ETA ' num2str(minremain) ' min']);
    %disp([i minremain tocs(i)]);
end

waitbar(1,h,'Done!');
% if exist('h') delete(h); end

%find where in the fullfilename the filename is, and cut out the string of
%the filename without the .tif
%use that to save every variable into a _PI.mat file in one directory up,
%then down to matfiles.
filename = 'test/testShortMarkov.mat';

junk=strfind(filename,'/');
if ~isempty(junk)
    filebase=filename(junk(end)+1:end-4);
else
    filebase=filename(1:end-4);
end
disp('Saving results of PI calculation');
waitbar(0.9,h,'Saving results of PI');
save([filebase '_PI.mat']);
waitbar(1,h,'Done!');
if exist('h') delete(h); end

%% maxlambda
%powers of 10 to scan over for lambda
%sampling uniform in log space determines lambda to a uniform percentage
%precision, i have intentionally scanned over a larger range of lambda than
%is neccesary in order to illustrate what happens at small and large values of lambda.
h = waitbar(0.0,'Scanning Lambda Values...');
set(h,'Position',[50 0 360 72]);
set(h,'Name','Expectation Maximization');

n=-3:.1:.5;

%values of lambda to sample
lambdas=10.^n;

%initialize index for lambda values
jj=0;

%clear previous results if any
clear saveprobs

%loop over values of lambda
for lambda=lambdas
    %increment index
    jj=jj+1;
    dl=1/length(lambdas);
    waitbar((jj-1)/length(lambdas),h,['Lambda=' num2str(lambda)]);
    %run an abbreviated version of the HMM on the first 20 frames
    %totprob will be the overall probability for that run
    %offsets predicted for that value are plotted at the completion of each
    %iteration.
    
    %% short_markov
    %creates the basic exponential model for the transistion probabilities,
    %this in terms of relative change in offset, normalizing appropriately
    %we make sure its big enough so that it covers all possible differences in
    %offsets
    [xx,yy]=meshgrid(-2*maxdx:2*maxdx,-2*maxdy:2*maxdy);
    rr=sqrt(xx.^2+yy.^2);
    rel_trans_prob=exp(-(abs(rr)./lambda));
    rel_trans_prob=rel_trans_prob/(sum(sum(rel_trans_prob)));
    
    %now build up the entire transition probability matrix where you index a
    %pair of offsets as a single hashed value by making use of the reshape
    %function in matlab.  an offset pair will now be refered to a state.
    trans_prob=zeros(Nx*Ny,Nx*Ny);
    for i=-maxdx:maxdx
        for j=-maxdy:maxdy
            trans_prob((i+maxdx)*(maxdy*2+1)+j+maxdy+1,:)=reshape(rel_trans_prob((maxdy-j+1):(3*maxdy-j+1),(maxdx-i+1):(3*maxdx-i+1)),Nx*Ny,1);
        end
    end
    
    %translate it into a log probability
    trans_prob=log(trans_prob);
    
    frames=1:20;
    %this is going to be the matrix which keeps track of the transition which
    %was the most probable way to get to a particular state from the previous
    %state.. we will fill this matrix up, and the backtrack the most probable
    %path as is the standard way of the veterbi algorithm.
    savemax=zeros(Nx*Ny,length(frames)*N,'int16');
    
    %P is the probability vector which describes the maximal probability of
    %being in a particular state at the current time step as we march forward
    %we will start with a uniform distribution across offsets
    P=ones(1,Nx*Ny);
    
    %vector to save the time it took to process each frame
    tocs=zeros(numframes,1);
    
    %index which will march over lines considered
    m=0;
    
    %loop over all frames
    for i=frames
        %note the time
        tic
        %loop over all the lines considered in that frame
        for j=1+edgebuffer:N-edgebuffer
            
            %increment our index for lines considered
            m=m+1;
            
            %replicate the starting probabilities at the time step before for
            %all the possible offsets
            Prep=repmat(P,Nx*Ny,1);
            %calculate the matrix of probabilities of being in one state at
            %the previous time point and then transitioning to another
            Pnew=Prep+trans_prob;
            
            %this was my C implementation of the previous 2 lines.. it speeds
            %things up but i have disabled it here... if you want to compile
            %the C for your platform you can.. the file there.
            % Pnew = makepifast(trans_prob,P);
            
            %calculate the most probable way to wind up in a given state, and
            %what the probability is.. save which path you took to get that
            %value, and update P.
            [P,savemax(:,m)]= max(Pnew',[],1);
            
            %now add in the fit data to adjust the probability of being in a
            %given state.
            
            %pull out the relevant matrix of values
            PI=squeeze(PIsave(m,:,:));
            
            %reshape them into a vector
            PIvec=reshape(PI,Nx*Ny,1);
            
            %i shift all the probabilities by the mean just to keep things
            %from hitting round off errors.. this doesn't affect the
            %calculation, just keeps things reasonable.
            PIvec=PIvec/gain;
            PIvec=PIvec-mean(PIvec);
            
            %add on the fits to the probabilities
            
            P=P+PIvec';
        end
        
        %note the time
        tocs(i)=toc;
        
        %calculate the average time per frame so far
        delframes=mean(tocs(max(i-9,1):i));
        %use that to estimate the time remaining
        minremain=(length(frames)-i)*delframes/60;
        %display what frame you are on, how long it should take, and how long
        %the current frame took
        waitbar((jj-1)/length(lambdas)+dl*(i/length(frames)),h,['Lambda=' num2str(lambda) ' Frame ' num2str(i)]);
        %disp([i minremain tocs(i)]);
        
    end
    clear offsets;
    numlines=m;
    
    %find the state that was the most probable ending point
    %and what the total probablity was for this value of lambda
    [totprob,mprob]=max(P);
    
    %initialize the path of most probable states
    thepath=zeros(1,numlines);
    
    %for my interest i save the fits along the path
    PIpath=zeros(1,numlines);
    %calculate the total fit for this path without considering transition
    %probabilities.
    Ptot=0;
    
    %march backward from the last line considered to the first
    for k=numlines:-1:1
        %pull out the fits from the current line
        PI=squeeze(PIsave(k,:,:));
        %turn it into a vector
        PIvec=reshape(PI,Nx*Ny,1);
        
        %what is the fit for the most probable state at this timepoint
        PIpath(k)=PIvec(mprob);
        %add that to the total fit
        Ptot=Ptot+PIvec(mprob);
        
        %save that point along the path
        thepath(k)=mprob;
        %remember what was the most probable way was to get to that state.. update mprob
        mprob=savemax(mprob,k);
    end
    
    %unhash the path in terms of state index into a pair of offsets
    offsets(1,:)=mod(thepath,Ny);
    offsets(1,find(offsets(1,:)==0))=Ny;
    offsets(1,:)=offsets(1,:)-maxdy-1;;
    offsets(2,:)=((thepath-mod(thepath,Ny))/Ny)-maxdx;
    
    %adjust for the alignments between reference frames
    offsetfix=1:numlines;
    offsetfix=floor(offsetfix/(N-2*edgebuffer));
    offsetfix=floor(offsetfix/framesper30sec)+1;
    offsetfix=stilloffsets(offsetfix,:)';
    offsets=offsets-offsetfix;
    
    %plot out the offsets
    figure(2);
    set(gcf,'Position',[50 200 750 500]);
    plot(offsets');
    title(['\lambda' sprintf(' = %6.5f',lambda)]);
    xlabel('line number');
    ylabel('offset (relative pixels)');
    %save the total probablity for that value of lambda
    saveprobs(jj)=totprob;
end

%plot the curve of overall probabilities


%pick out the value of lambda which is the overall most probable
[maximumvalue,maximumindex]=max(saveprobs);
lambda=lambdas(maximumindex);

figure(99);
clf;
set(gcf,'Position',[800 200 1280-800 500]);
hold on;
plot(lambdas,saveprobs);
plot(lambda,maximumvalue,'rx');
xlabel('\lambda');
ylabel('total probability');


waitbar(0.0,h,['Run with Lambda=' num2str(lambda)]);
set(h,'Name',['HMM Lambda=' num2str(lambda)]);

%run the HMM algorithm, now that lambda is set to its most probable value,
%over all frames of the movie. this will result in a _L file containing the
%offsets
%% markov_on_PIsave

%creates the basic exponential model for the transistion probabilities,
%this in terms of relative change in offset.  We normalize appropriately
%and make sure its big enough so that it covers all possible differences in
%offsets
[xx,yy]=meshgrid(-2*maxdx:2*maxdx,-2*maxdy:2*maxdy);
rr=sqrt(xx.^2+yy.^2);
rel_trans_prob=exp(-(abs(rr)./lambda));
rel_trans_prob=rel_trans_prob/(sum(sum(rel_trans_prob)));

%now build up the entire transition probability matrix where you index a
%pair of offsets as a single hashed value by making use of the reshape
%function in matlab.  an offset pair will now be refered to a state.
trans_prob=zeros(Nx*Ny,Nx*Ny);
for i=-maxdx:maxdx
    for j=-maxdy:maxdy
        trans_prob((i+maxdx)*(maxdy*2+1)+j+maxdy+1,:)=...
            reshape(rel_trans_prob((maxdy-j+1):(3*maxdy-j+1),(maxdx-i+1):...
            (3*maxdx-i+1)),Nx*Ny,1);
    end
end

%translate it into a log probability
trans_prob=log(trans_prob);

frames=1:numframes;

%this is going to be the matrix which keeps track of the transition which
%was the most probable way to get to a particular state from the previous
%state.. we will fill this matrix up, and the backtrack the most probable
%path as is the standard way of the veterbi algorithm.
savemax=zeros(Nx*Ny,numframes*N,'int16');

%P is the probability vector which describes the maximal probability of
%being in a particular state at the current time step as we march forward
%we will start with a uniform distribution across offsets
P=ones(1,Nx*Ny);

%vector to save the time it took to process each frame
tocs=zeros(numframes,1);

%index which will march over lines considered
m=0;

%loop over all frames
for i=frames
    %note the time
    tic
    %loop over all the lines considered in that frame
    for j=1+edgebuffer:N-edgebuffer

        %increment our index for lines considered
        m=m+1;

        %replicate the starting probabilities at the time step before for
        %all the possible offsets
        Prep=repmat(P,Nx*Ny,1);
        %calculate the matrix of probabilities of being in one state at
        %the previous time point and then transitioning to another
        Pnew=Prep+trans_prob;

        %this was my C implementation of the previous 2 lines.. it speeds
        %things up but i have disabled it here... if you want to compile
        %the C for your platform you can.. the file there.
        %Pnew = makepifast(trans_prob,P);
        %Pnew = Pnew';

        %calculate the most probable way to wind up in a given state, and
        %what the probability is.. save which path you took to get that
        %value, and update P.
        [P,savemax(:,m)]= max(Pnew',[],1);

        %now add in the fit data to adjust the probability of being in a
        %given state.

        %pull out the relevant matrix of values
        PI=squeeze(PIsave(m,:,:));
        %reshape them into a vector
        PIvec=reshape(PI,Nx*Ny,1);

        %i shift all the probabilities by the mean just to keep things
        %from hitting round off errors.. this doesn't affect the
        %calculation, just keeps things reasonable.
        PIvec=PIvec/gain;
        PIvec=PIvec-mean(PIvec);
        
        %add on the fits to the probabilities

        P=P+PIvec';
    end

    %note the time
    tocs(i)=toc;

    %calculate the average time per frame so far
    delframes=mean(tocs(max(i-9,1):i));
    %use that to estimate the time remaining
    minremain=(numframes-i)*delframes/60;
    %display what frame you are on, how long it should take, and how long
    %the current frame took
    waitbar((i/length(frames)),h,['Running HMM.. Frame ' num2str(i) ' ETA:' num2str(minremain) ' min']);
    %disp([i minremain tocs(i)]);

end

clear offsets;
numlines=m;

%find the state that was the most probable ending point
%and what the total probablity was for this value of lambda
[totprob,mprob]=max(P);

%initialize the path of most probable states
thepath=zeros(1,numlines);

%for my interest i save the fits along the path
PIpath=zeros(1,numlines);
%calculate the total fit for this path without considering transition
%probabilities.
PItot=0;

%march backward from the last line considered to the first
for k=numlines:-1:1
    if(mod(k,N)==0)
    waitbar((k/numlines),h,['Backtracing path.. line ' num2str(k)]);
    end
    %pull out the fits from the current line
    PI=squeeze(PIsave(k,:,:));
    %turn it into a vector
    PIvec=reshape(PI,Nx*Ny,1);

    %what is the fit for the most probable state at this timepoint
    PIpath(k)=PIvec(mprob);
    %add that to the total fit
    PItot=PItot+PIvec(mprob);

    %save that point along the path
    thepath(k)=mprob;
    %remember what was the most probable way was to get to that state.. update mprob
    mprob=savemax(mprob,k);
end

%unhash the path in terms of state index into a pair of offsets
offsets(1,:)=mod(thepath,Ny);
offsets(1,find(offsets(1,:)==0))=Ny;
offsets(1,:)=offsets(1,:)-maxdy-1;
offsets(2,:)=((thepath-mod(thepath,Ny))/Ny)-maxdx;

%adjust for the alignments between reference frames
offsetfix=1:numlines;
offsetfix=floor(offsetfix/(N-2*edgebuffer));
offsetfix=floor(offsetfix/framesper30sec)+1;
offsetfix=stilloffsets(offsetfix,:)';
offsets=offsets-offsetfix;

%plot out the offsets
figure(2);
plot(offsets');
title(['\lambda' sprintf(' = %3.2f',lambda)]);
xlabel('line number');
ylabel('offset (relative pixels)');

%save the results to an F file which is named according to the value of
%lambda used.
pathname='../';
savename=sprintf('%s_L%3.2f.mat',filebase,lambda);
save(savename,'offsets','thepath','P','PItot','PIpath','totprob');

if exist('h') delete(h); end
%save the probabilities into the _PI file for posterity
save([filebase '_PI.mat'],'saveprobs','lambdas','-append');

%% playback_markov
[fixeddata,countdata]=playback_markov(data{1},offsets,edgebuffer,1);

% rearrange matrices
data_mc = cell(1,2);
for n = 1:numel(data)
   data_mc{n} = zeros(rows,cols,numframes);
end

for n = 1:numframes
   currentMat =  fixeddata(n,:,:);
   data_mc{1}(:,:,n) = currentMat;
   currentMat =  countdata(n,:,:);
   data_mc{2}(:,:,n) = currentMat;
end




















