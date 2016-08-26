% creating square gratings for color stimuli paradigms
% this is the default size: 4by4 degrees

%% 2 cycles per degree vertical
close all
stim=ones(144,18)*131;
stim(:,1:9)=132;
hor=repmat(stim,1,8);


figure('position',[100 100 186 176]);
for i=1:500
    j=ceil(i/3); % set the velocity
    h=imagesc(circshift(hor,[1 j]));colormap(gray)           
    axis off
    M(:,i)=getframe(1);
end;

           
for i=1:500
    c=find(M(1,i).cdata==204);
    M(1,i).cdata(c)=130;
    e=find(M(1,i).cdata==255);
    M(1,i).cdata(e)=132;
    f=find(M(1,i).cdata==0);
    M(1,i).cdata(f)=131;
end    

%buliding the colormap
cm=zeros(256,3); 
cm(130,:)=[0.5 0.5 0.5];
cm(131,:)=[1 1 1];  
cm(132,:)=[0 0 0];  

for i=1:500
    N(1,i).cdata=M(1,i).cdata(:,:,1);
    N(1,i).colormap=cm;
end    

movie2avi(N,'ver_2cyc','fps',100);    
            


%% 2 cycles per degree horizontal
close all
stim=ones(144,18)*131;
stim(:,1:9)=132;
hor=repmat(stim,1,8);


figure('position',[100 100 186 176]);
for i=1:500
    j=ceil(i/3);
    h=imagesc(circshift(hor',[j 1]));colormap(gray)           
    axis off
    M(:,i)=getframe(1);
end;

           
for i=1:500
    c=find(M(1,i).cdata==204);
    M(1,i).cdata(c)=130;
    e=find(M(1,i).cdata==255);
    M(1,i).cdata(e)=132;
    f=find(M(1,i).cdata==0);
    M(1,i).cdata(f)=131;
end    

%buliding the colormap
cm=zeros(256,3); 
cm(130,:)=[0.5 0.5 0.5];
cm(131,:)=[1 1 1];  
cm(132,:)=[0 0 0];  

for i=1:500
    N(1,i).cdata=M(1,i).cdata(:,:,1);
    N(1,i).colormap=cm;
end    

movie2avi(N,'hor_2cyc','fps',100);    
            





%% 1 cycles per degree vertical
close all
stim=ones(144,36)*131;
stim(:,1:18)=132;
hor=repmat(stim,1,4);


figure('position',[100 100 186 176]);
for i=1:500
    j=ceil(i/3);
    h=imagesc(circshift(hor,[1 j]));colormap(gray)           
    axis off
    M(:,i)=getframe(1);
end;

           
for i=1:500
    c=find(M(1,i).cdata==204);
    M(1,i).cdata(c)=130;
    e=find(M(1,i).cdata==255);
    M(1,i).cdata(e)=132;
    f=find(M(1,i).cdata==0);
    M(1,i).cdata(f)=131;
end    

%buliding the colormap
cm=zeros(256,3); 
cm(130,:)=[0.5 0.5 0.5];
cm(131,:)=[1 1 1];  
cm(132,:)=[0 0 0];  

for i=1:500
    N(1,i).cdata=M(1,i).cdata(:,:,1);
    N(1,i).colormap=cm;
end    

movie2avi(N,'ver_1cyc','fps',500);    
            


%% 1 cycles per degree horizontal
close all
stim=ones(144,36)*131;
stim(:,1:18)=132;
hor=repmat(stim,1,4);


figure('position',[100 100 186 176]);
for i=1:500
    j=ceil(i/3);
    h=imagesc(circshift(hor',[j 1]));colormap(gray)           
    axis off
    M(:,i)=getframe(1);
end;

           
for i=1:500
    c=find(M(1,i).cdata==204);
    M(1,i).cdata(c)=130;
    e=find(M(1,i).cdata==255);
    M(1,i).cdata(e)=132;
    f=find(M(1,i).cdata==0);
    M(1,i).cdata(f)=131;
end    

%buliding the colormap
cm=zeros(256,3); 
cm(130,:)=[0.5 0.5 0.5];
cm(131,:)=[1 1 1];  
cm(132,:)=[0 0 0];  

for i=1:500
    N(1,i).cdata=M(1,i).cdata(:,:,1);
    N(1,i).colormap=cm;
end    

movie2avi(N,'hor_1cyc','fps',500);    
            



