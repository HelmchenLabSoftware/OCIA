%% coherence simulation

t=10:10:2000;                       %samples
x=repmat(sin(30*t),100,1);          %signal 1
y=repmat(cos(10*t),100,1);          %signal 2
n1=randn(100,200)*0.1;              %noise 1
n2=randn(100,200)*0.1;              %noise 2
x=x+n1;
y=y+n2;
x=x-repmat(mean(x,2),1,200);        %DC off
y=y-repmat(mean(y,2),1,200);

x=x.*repmat(hamming(100),1,200);    % hamming window multiplication 
y=y.*repmat(hamming(100),1,200); 

fx=fft(x,[],2);                     % fft analysis
fy=fft(y,[],2);

Px=mean(abs(fx(:,2:101)).^2,1);     % Power calculation
Py=mean(abs(fy(:,2:101)).^2,1);

cs=mean(fx(:,2:101).*conj(fy(:,2:101)),1);

co=abs(cs).^2./(Px.*Py);            %coherence calculation


