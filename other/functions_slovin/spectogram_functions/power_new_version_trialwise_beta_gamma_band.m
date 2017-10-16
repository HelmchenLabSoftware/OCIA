cd F:\Data\VSDI\collinear\one_flanker\aragon\2007_11_20\no_stim

load pixels_to_remove
t=ones(10000,1);
t(pixels_to_remove)=0;
pixels=find(t);
clear t


NFFT =64;
win=16;
for i=[2 4] %condition count
    z=0;
    eval(['load cond',int2str(i),'n_dt_bl'])
    eval(['a=size(cond',int2str(i),'n_dt_bl,3);'])    
    eval(['b=size(cond',int2str(i),'n_dt_bl,2);'])
        for h=1:a  %trial count 
            z=z+1;
            disp(['condition #',int2str(i),' trial #',int2str(h),' transforming data'])
            eval(['load cond',int2str(i),'n_dt_bl'])
            eval(['cond',int2str(i),'n_dt_bl=cond',int2str(i),'n_dt_bl(:,2:end,h);'])
            Pxx=NaN*ones(NFFT/2,b-win,size(pixels,1));
            data_win=zeros(size(pixels,1),32);
                for j=1:(b-win) 
                    w=hamming(win).';
                    %w=hanning(win).';
                    eval(['data_win=w(ones(1,size(pixels,1)),:).*(cond',int2str(i),'n_dt_bl(pixels,j:j+win-1)-repmat(mean(cond',int2str(i),'n_dt_bl(pixels,j:j+win-1),2),[1,win]));'])
                    y=fft(data_win.',NFFT);
                    y=y./win;
                    y = y(2:NFFT/2+1,:);
                    Pxx(:,j,:)=abs(y).^2;                
                end;
            eval(['clear cond',int2str(i),'n_dt_bl'])
            l=0;
            eval(['power_cond',int2str(i),'_trial_',int2str(h),'=Pxx;'])   
            clear Pxx
            %cd win320
            cd trials
            eval(['power_beta_cond',int2str(i),'_trial_',int2str(h),'=squeeze(mean(power_cond',int2str(i),'_trial_',int2str(h),'(10:15,:,:),1));'])
            eval(['save power_beta_cond',int2str(i),'_trial_',int2str(h),' power_beta_cond',int2str(i),'_trial_',int2str(h),' pixels'])
            cd ..
            %cd ..
            eval(['clear power_cond',int2str(i),'_trial_',int2str(h)])
            eval(['clear power_beta_cond',int2str(i),'_trial_',int2str(h)])
        end;
end;

load pixels_to_remove
t=ones(10000,1);
t(pixels_to_remove)=0;
pixels=find(t);
clear t


NFFT =64;
win=16;
for i=[2 4] %condition count
    z=0;
    eval(['load cond',int2str(i),'n_dt_bl'])
    eval(['a=size(cond',int2str(i),'n_dt_bl,3);'])    
    eval(['b=size(cond',int2str(i),'n_dt_bl,2);'])
        for h=1:a  %trial count 
            z=z+1;
            disp(['condition #',int2str(i),' trial #',int2str(h),' transforming data'])
            eval(['load cond',int2str(i),'n_dt_bl'])
            eval(['cond',int2str(i),'n_dt_bl=cond',int2str(i),'n_dt_bl(:,2:end,h);'])
            Pxx=NaN*ones(NFFT/2,b-win,size(pixels,1));
            data_win=zeros(size(pixels,1),32);
                for j=1:(b-win) 
                    w=hamming(win).';
                    %w=hanning(win).';
                    eval(['data_win=w(ones(1,size(pixels,1)),:).*(cond',int2str(i),'n_dt_bl(pixels,j:j+win-1)-repmat(mean(cond',int2str(i),'n_dt_bl(pixels,j:j+win-1),2),[1,win]));'])
                    y=fft(data_win.',NFFT);
                    y=y./win;
                    y = y(2:NFFT/2+1,:);
                    Pxx(:,j,:)=abs(y).^2;                
                end;
            eval(['clear cond',int2str(i),'n_dt_bl'])
            l=0;
            eval(['power_cond',int2str(i),'_trial_',int2str(h),'=Pxx;'])   
            clear Pxx
            %cd win320
            cd trials
            eval(['power_gamma_cond',int2str(i),'_trial_',int2str(h),'=squeeze(mean(power_cond',int2str(i),'_trial_',int2str(h),'(16:32,:,:),1));'])
            eval(['save power_gamma_cond',int2str(i),'_trial_',int2str(h),' power_gamma_cond',int2str(i),'_trial_',int2str(h),' pixels'])
            cd ..
            %cd ..
            eval(['clear power_cond',int2str(i),'_trial_',int2str(h)])
            eval(['clear power_gamma_cond',int2str(i),'_trial_',int2str(h)])
        end;
end;


cd F:\Data\VSDI\collinear\one_flanker\legolas\2007_01_31\no_stim

load pixels_to_remove
t=ones(10000,1);
t(pixels_to_remove)=0;
pixels=find(t);
clear t


NFFT =64;
win=16;
for i=[2 4] %condition count
    z=0;
    eval(['load cond',int2str(i),'n_dt_bl'])
    eval(['a=size(cond',int2str(i),'n_dt_bl,3);'])    
    eval(['b=size(cond',int2str(i),'n_dt_bl,2);'])
        for h=1:a  %trial count 
            z=z+1;
            disp(['condition #',int2str(i),' trial #',int2str(h),' transforming data'])
            eval(['load cond',int2str(i),'n_dt_bl'])
            eval(['cond',int2str(i),'n_dt_bl=cond',int2str(i),'n_dt_bl(:,2:end,h);'])
            Pxx=NaN*ones(NFFT/2,b-win,size(pixels,1));
            data_win=zeros(size(pixels,1),32);
                for j=1:(b-win) 
                    w=hamming(win).';
                    %w=hanning(win).';
                    eval(['data_win=w(ones(1,size(pixels,1)),:).*(cond',int2str(i),'n_dt_bl(pixels,j:j+win-1)-repmat(mean(cond',int2str(i),'n_dt_bl(pixels,j:j+win-1),2),[1,win]));'])
                    y=fft(data_win.',NFFT);
                    y=y./win;
                    y = y(2:NFFT/2+1,:);
                    Pxx(:,j,:)=abs(y).^2;                
                end;
            eval(['clear cond',int2str(i),'n_dt_bl'])
            l=0;
            eval(['power_cond',int2str(i),'_trial_',int2str(h),'=Pxx;'])   
            clear Pxx
            %cd win320
            cd trials
            eval(['power_beta_cond',int2str(i),'_trial_',int2str(h),'=squeeze(mean(power_cond',int2str(i),'_trial_',int2str(h),'(10:15,:,:),1));'])
            eval(['save power_beta_cond',int2str(i),'_trial_',int2str(h),' power_beta_cond',int2str(i),'_trial_',int2str(h),' pixels'])
            cd ..
            %cd ..
            eval(['clear power_cond',int2str(i),'_trial_',int2str(h)])
            eval(['clear power_beta_cond',int2str(i),'_trial_',int2str(h)])
        end;
end;

load pixels_to_remove
t=ones(10000,1);
t(pixels_to_remove)=0;
pixels=find(t);
clear t


NFFT =64;
win=16;
for i=[2 4] %condition count
    z=0;
    eval(['load cond',int2str(i),'n_dt_bl'])
    eval(['a=size(cond',int2str(i),'n_dt_bl,3);'])    
    eval(['b=size(cond',int2str(i),'n_dt_bl,2);'])
        for h=1:a  %trial count 
            z=z+1;
            disp(['condition #',int2str(i),' trial #',int2str(h),' transforming data'])
            eval(['load cond',int2str(i),'n_dt_bl'])
            eval(['cond',int2str(i),'n_dt_bl=cond',int2str(i),'n_dt_bl(:,2:end,h);'])
            Pxx=NaN*ones(NFFT/2,b-win,size(pixels,1));
            data_win=zeros(size(pixels,1),32);
                for j=1:(b-win) 
                    w=hamming(win).';
                    %w=hanning(win).';
                    eval(['data_win=w(ones(1,size(pixels,1)),:).*(cond',int2str(i),'n_dt_bl(pixels,j:j+win-1)-repmat(mean(cond',int2str(i),'n_dt_bl(pixels,j:j+win-1),2),[1,win]));'])
                    y=fft(data_win.',NFFT);
                    y=y./win;
                    y = y(2:NFFT/2+1,:);
                    Pxx(:,j,:)=abs(y).^2;                
                end;
            eval(['clear cond',int2str(i),'n_dt_bl'])
            l=0;
            eval(['power_cond',int2str(i),'_trial_',int2str(h),'=Pxx;'])   
            clear Pxx
            %cd win320
            cd trials
            eval(['power_gamma_cond',int2str(i),'_trial_',int2str(h),'=squeeze(mean(power_cond',int2str(i),'_trial_',int2str(h),'(16:32,:,:),1));'])
            eval(['save power_gamma_cond',int2str(i),'_trial_',int2str(h),' power_gamma_cond',int2str(i),'_trial_',int2str(h),' pixels'])
            cd ..
            %cd ..
            eval(['clear power_cond',int2str(i),'_trial_',int2str(h)])
            eval(['clear power_gamma_cond',int2str(i),'_trial_',int2str(h)])
        end;
end;


cd F:\Data\VSDI\collinear\one_flanker\legolas\2007_02_07\no_stim

load pixels_to_remove
t=ones(10000,1);
t(pixels_to_remove)=0;
pixels=find(t);
clear t


NFFT =64;
win=16;
for i=[2 4] %condition count
    z=0;
    eval(['load cond',int2str(i),'n_dt_bl'])
    eval(['a=size(cond',int2str(i),'n_dt_bl,3);'])    
    eval(['b=size(cond',int2str(i),'n_dt_bl,2);'])
        for h=1:a  %trial count 
            z=z+1;
            disp(['condition #',int2str(i),' trial #',int2str(h),' transforming data'])
            eval(['load cond',int2str(i),'n_dt_bl'])
            eval(['cond',int2str(i),'n_dt_bl=cond',int2str(i),'n_dt_bl(:,2:end,h);'])
            Pxx=NaN*ones(NFFT/2,b-win,size(pixels,1));
            data_win=zeros(size(pixels,1),32);
                for j=1:(b-win) 
                    w=hamming(win).';
                    %w=hanning(win).';
                    eval(['data_win=w(ones(1,size(pixels,1)),:).*(cond',int2str(i),'n_dt_bl(pixels,j:j+win-1)-repmat(mean(cond',int2str(i),'n_dt_bl(pixels,j:j+win-1),2),[1,win]));'])
                    y=fft(data_win.',NFFT);
                    y=y./win;
                    y = y(2:NFFT/2+1,:);
                    Pxx(:,j,:)=abs(y).^2;                
                end;
            eval(['clear cond',int2str(i),'n_dt_bl'])
            l=0;
            eval(['power_cond',int2str(i),'_trial_',int2str(h),'=Pxx;'])   
            clear Pxx
            %cd win320
            cd trials
            eval(['power_beta_cond',int2str(i),'_trial_',int2str(h),'=squeeze(mean(power_cond',int2str(i),'_trial_',int2str(h),'(10:15,:,:),1));'])
            eval(['save power_beta_cond',int2str(i),'_trial_',int2str(h),' power_beta_cond',int2str(i),'_trial_',int2str(h),' pixels'])
            cd ..
            %cd ..
            eval(['clear power_cond',int2str(i),'_trial_',int2str(h)])
            eval(['clear power_beta_cond',int2str(i),'_trial_',int2str(h)])
        end;
end;

load pixels_to_remove
t=ones(10000,1);
t(pixels_to_remove)=0;
pixels=find(t);
clear t


NFFT =64;
win=16;
for i=[2 4] %condition count
    z=0;
    eval(['load cond',int2str(i),'n_dt_bl'])
    eval(['a=size(cond',int2str(i),'n_dt_bl,3);'])    
    eval(['b=size(cond',int2str(i),'n_dt_bl,2);'])
        for h=1:a  %trial count 
            z=z+1;
            disp(['condition #',int2str(i),' trial #',int2str(h),' transforming data'])
            eval(['load cond',int2str(i),'n_dt_bl'])
            eval(['cond',int2str(i),'n_dt_bl=cond',int2str(i),'n_dt_bl(:,2:end,h);'])
            Pxx=NaN*ones(NFFT/2,b-win,size(pixels,1));
            data_win=zeros(size(pixels,1),32);
                for j=1:(b-win) 
                    w=hamming(win).';
                    %w=hanning(win).';
                    eval(['data_win=w(ones(1,size(pixels,1)),:).*(cond',int2str(i),'n_dt_bl(pixels,j:j+win-1)-repmat(mean(cond',int2str(i),'n_dt_bl(pixels,j:j+win-1),2),[1,win]));'])
                    y=fft(data_win.',NFFT);
                    y=y./win;
                    y = y(2:NFFT/2+1,:);
                    Pxx(:,j,:)=abs(y).^2;                
                end;
            eval(['clear cond',int2str(i),'n_dt_bl'])
            l=0;
            eval(['power_cond',int2str(i),'_trial_',int2str(h),'=Pxx;'])   
            clear Pxx
            %cd win320
            cd trials
            eval(['power_gamma_cond',int2str(i),'_trial_',int2str(h),'=squeeze(mean(power_cond',int2str(i),'_trial_',int2str(h),'(16:32,:,:),1));'])
            eval(['save power_gamma_cond',int2str(i),'_trial_',int2str(h),' power_gamma_cond',int2str(i),'_trial_',int2str(h),' pixels'])
            cd ..
            %cd ..
            eval(['clear power_cond',int2str(i),'_trial_',int2str(h)])
            eval(['clear power_gamma_cond',int2str(i),'_trial_',int2str(h)])
        end;
end;


cd F:\Data\VSDI\collinear\three_flankers\legolas\2007_04_18\no_stim\way2

load pixels_to_remove
t=ones(10000,1);
t(pixels_to_remove)=0;
pixels=find(t);
clear t


NFFT =64;
win=16;
for i=[4 3] %condition count
    z=0;
    eval(['load cond',int2str(i),'n_dt_bl'])
    eval(['a=size(cond',int2str(i),'n_dt_bl,3);'])    
    eval(['b=size(cond',int2str(i),'n_dt_bl,2);'])
        for h=1:a  %trial count 
            z=z+1;
            disp(['condition #',int2str(i),' trial #',int2str(h),' transforming data'])
            eval(['load cond',int2str(i),'n_dt_bl'])
            eval(['cond',int2str(i),'n_dt_bl=cond',int2str(i),'n_dt_bl(:,2:end,h);'])
            Pxx=NaN*ones(NFFT/2,b-win,size(pixels,1));
            data_win=zeros(size(pixels,1),32);
                for j=1:(b-win) 
                    w=hamming(win).';
                    %w=hanning(win).';
                    eval(['data_win=w(ones(1,size(pixels,1)),:).*(cond',int2str(i),'n_dt_bl(pixels,j:j+win-1)-repmat(mean(cond',int2str(i),'n_dt_bl(pixels,j:j+win-1),2),[1,win]));'])
                    y=fft(data_win.',NFFT);
                    y=y./win;
                    y = y(2:NFFT/2+1,:);
                    Pxx(:,j,:)=abs(y).^2;                
                end;
            eval(['clear cond',int2str(i),'n_dt_bl'])
            l=0;
            eval(['power_cond',int2str(i),'_trial_',int2str(h),'=Pxx;'])   
            clear Pxx
            %cd win320
            cd trials
            eval(['power_beta_cond',int2str(i),'_trial_',int2str(h),'=squeeze(mean(power_cond',int2str(i),'_trial_',int2str(h),'(10:15,:,:),1));'])
            eval(['save power_beta_cond',int2str(i),'_trial_',int2str(h),' power_beta_cond',int2str(i),'_trial_',int2str(h),' pixels'])
            cd ..
            %cd ..
            eval(['clear power_cond',int2str(i),'_trial_',int2str(h)])
            eval(['clear power_beta_cond',int2str(i),'_trial_',int2str(h)])
        end;
end;

load pixels_to_remove
t=ones(10000,1);
t(pixels_to_remove)=0;
pixels=find(t);
clear t


NFFT =64;
win=16;
for i=[4 3] %condition count
    z=0;
    eval(['load cond',int2str(i),'n_dt_bl'])
    eval(['a=size(cond',int2str(i),'n_dt_bl,3);'])    
    eval(['b=size(cond',int2str(i),'n_dt_bl,2);'])
        for h=1:a  %trial count 
            z=z+1;
            disp(['condition #',int2str(i),' trial #',int2str(h),' transforming data'])
            eval(['load cond',int2str(i),'n_dt_bl'])
            eval(['cond',int2str(i),'n_dt_bl=cond',int2str(i),'n_dt_bl(:,2:end,h);'])
            Pxx=NaN*ones(NFFT/2,b-win,size(pixels,1));
            data_win=zeros(size(pixels,1),32);
                for j=1:(b-win) 
                    w=hamming(win).';
                    %w=hanning(win).';
                    eval(['data_win=w(ones(1,size(pixels,1)),:).*(cond',int2str(i),'n_dt_bl(pixels,j:j+win-1)-repmat(mean(cond',int2str(i),'n_dt_bl(pixels,j:j+win-1),2),[1,win]));'])
                    y=fft(data_win.',NFFT);
                    y=y./win;
                    y = y(2:NFFT/2+1,:);
                    Pxx(:,j,:)=abs(y).^2;                
                end;
            eval(['clear cond',int2str(i),'n_dt_bl'])
            l=0;
            eval(['power_cond',int2str(i),'_trial_',int2str(h),'=Pxx;'])   
            clear Pxx
            %cd win320
            cd trials
            eval(['power_gamma_cond',int2str(i),'_trial_',int2str(h),'=squeeze(mean(power_cond',int2str(i),'_trial_',int2str(h),'(16:32,:,:),1));'])
            eval(['save power_gamma_cond',int2str(i),'_trial_',int2str(h),' power_gamma_cond',int2str(i),'_trial_',int2str(h),' pixels'])
            cd ..
            %cd ..
            eval(['clear power_cond',int2str(i),'_trial_',int2str(h)])
            eval(['clear power_gamma_cond',int2str(i),'_trial_',int2str(h)])
        end;
end;


cd F:\Data\VSDI\collinear\three_flankers\legolas\2007_03_12\conds_ns

load pixels_to_remove
t=ones(10000,1);
t(pixels_to_remove)=0;
pixels=find(t);
clear t


NFFT =64;
win=16;
for i=[4 3] %condition count
    z=0;
    eval(['load cond',int2str(i),'n_dt_bl'])
    eval(['a=size(cond',int2str(i),'n_dt_bl,3);'])    
    eval(['b=size(cond',int2str(i),'n_dt_bl,2);'])
        for h=1:a  %trial count 
            z=z+1;
            disp(['condition #',int2str(i),' trial #',int2str(h),' transforming data'])
            eval(['load cond',int2str(i),'n_dt_bl'])
            eval(['cond',int2str(i),'n_dt_bl=cond',int2str(i),'n_dt_bl(:,2:end,h);'])
            Pxx=NaN*ones(NFFT/2,b-win,size(pixels,1));
            data_win=zeros(size(pixels,1),32);
                for j=1:(b-win) 
                    w=hamming(win).';
                    %w=hanning(win).';
                    eval(['data_win=w(ones(1,size(pixels,1)),:).*(cond',int2str(i),'n_dt_bl(pixels,j:j+win-1)-repmat(mean(cond',int2str(i),'n_dt_bl(pixels,j:j+win-1),2),[1,win]));'])
                    y=fft(data_win.',NFFT);
                    y=y./win;
                    y = y(2:NFFT/2+1,:);
                    Pxx(:,j,:)=abs(y).^2;                
                end;
            eval(['clear cond',int2str(i),'n_dt_bl'])
            l=0;
            eval(['power_cond',int2str(i),'_trial_',int2str(h),'=Pxx;'])   
            clear Pxx
            %cd win320
            cd trials
            eval(['power_beta_cond',int2str(i),'_trial_',int2str(h),'=squeeze(mean(power_cond',int2str(i),'_trial_',int2str(h),'(10:15,:,:),1));'])
            eval(['save power_beta_cond',int2str(i),'_trial_',int2str(h),' power_beta_cond',int2str(i),'_trial_',int2str(h),' pixels'])
            cd ..
            %cd ..
            eval(['clear power_cond',int2str(i),'_trial_',int2str(h)])
            eval(['clear power_beta_cond',int2str(i),'_trial_',int2str(h)])
        end;
end;

load pixels_to_remove
t=ones(10000,1);
t(pixels_to_remove)=0;
pixels=find(t);
clear t


NFFT =64;
win=16;
for i=[4 3] %condition count
    z=0;
    eval(['load cond',int2str(i),'n_dt_bl'])
    eval(['a=size(cond',int2str(i),'n_dt_bl,3);'])    
    eval(['b=size(cond',int2str(i),'n_dt_bl,2);'])
        for h=1:a  %trial count 
            z=z+1;
            disp(['condition #',int2str(i),' trial #',int2str(h),' transforming data'])
            eval(['load cond',int2str(i),'n_dt_bl'])
            eval(['cond',int2str(i),'n_dt_bl=cond',int2str(i),'n_dt_bl(:,2:end,h);'])
            Pxx=NaN*ones(NFFT/2,b-win,size(pixels,1));
            data_win=zeros(size(pixels,1),32);
                for j=1:(b-win) 
                    w=hamming(win).';
                    %w=hanning(win).';
                    eval(['data_win=w(ones(1,size(pixels,1)),:).*(cond',int2str(i),'n_dt_bl(pixels,j:j+win-1)-repmat(mean(cond',int2str(i),'n_dt_bl(pixels,j:j+win-1),2),[1,win]));'])
                    y=fft(data_win.',NFFT);
                    y=y./win;
                    y = y(2:NFFT/2+1,:);
                    Pxx(:,j,:)=abs(y).^2;                
                end;
            eval(['clear cond',int2str(i),'n_dt_bl'])
            l=0;
            eval(['power_cond',int2str(i),'_trial_',int2str(h),'=Pxx;'])   
            clear Pxx
            %cd win320
            cd trials
            eval(['power_gamma_cond',int2str(i),'_trial_',int2str(h),'=squeeze(mean(power_cond',int2str(i),'_trial_',int2str(h),'(16:32,:,:),1));'])
            eval(['save power_gamma_cond',int2str(i),'_trial_',int2str(h),' power_gamma_cond',int2str(i),'_trial_',int2str(h),' pixels'])
            cd ..
            %cd ..
            eval(['clear power_cond',int2str(i),'_trial_',int2str(h)])
            eval(['clear power_gamma_cond',int2str(i),'_trial_',int2str(h)])
        end;
end;


cd F:\Data\VSDI\collinear\three_flankers\aragon\2007_11_20\no_stim\way2

load pixels_to_remove
t=ones(10000,1);
t(pixels_to_remove)=0;
pixels=find(t);
clear t


NFFT =64;
win=16;
for i=[4 3] %condition count
    z=0;
    eval(['load cond',int2str(i),'n_dt_bl'])
    eval(['a=size(cond',int2str(i),'n_dt_bl,3);'])    
    eval(['b=size(cond',int2str(i),'n_dt_bl,2);'])
        for h=1:a  %trial count 
            z=z+1;
            disp(['condition #',int2str(i),' trial #',int2str(h),' transforming data'])
            eval(['load cond',int2str(i),'n_dt_bl'])
            eval(['cond',int2str(i),'n_dt_bl=cond',int2str(i),'n_dt_bl(:,2:end,h);'])
            Pxx=NaN*ones(NFFT/2,b-win,size(pixels,1));
            data_win=zeros(size(pixels,1),32);
                for j=1:(b-win) 
                    w=hamming(win).';
                    %w=hanning(win).';
                    eval(['data_win=w(ones(1,size(pixels,1)),:).*(cond',int2str(i),'n_dt_bl(pixels,j:j+win-1)-repmat(mean(cond',int2str(i),'n_dt_bl(pixels,j:j+win-1),2),[1,win]));'])
                    y=fft(data_win.',NFFT);
                    y=y./win;
                    y = y(2:NFFT/2+1,:);
                    Pxx(:,j,:)=abs(y).^2;                
                end;
            eval(['clear cond',int2str(i),'n_dt_bl'])
            l=0;
            eval(['power_cond',int2str(i),'_trial_',int2str(h),'=Pxx;'])   
            clear Pxx
            %cd win320
            cd trials
            eval(['power_beta_cond',int2str(i),'_trial_',int2str(h),'=squeeze(mean(power_cond',int2str(i),'_trial_',int2str(h),'(10:15,:,:),1));'])
            eval(['save power_beta_cond',int2str(i),'_trial_',int2str(h),' power_beta_cond',int2str(i),'_trial_',int2str(h),' pixels'])
            cd ..
            %cd ..
            eval(['clear power_cond',int2str(i),'_trial_',int2str(h)])
            eval(['clear power_beta_cond',int2str(i),'_trial_',int2str(h)])
        end;
end;

load pixels_to_remove
t=ones(10000,1);
t(pixels_to_remove)=0;
pixels=find(t);
clear t


NFFT =64;
win=16;
for i=[4 3] %condition count
    z=0;
    eval(['load cond',int2str(i),'n_dt_bl'])
    eval(['a=size(cond',int2str(i),'n_dt_bl,3);'])    
    eval(['b=size(cond',int2str(i),'n_dt_bl,2);'])
        for h=1:a  %trial count 
            z=z+1;
            disp(['condition #',int2str(i),' trial #',int2str(h),' transforming data'])
            eval(['load cond',int2str(i),'n_dt_bl'])
            eval(['cond',int2str(i),'n_dt_bl=cond',int2str(i),'n_dt_bl(:,2:end,h);'])
            Pxx=NaN*ones(NFFT/2,b-win,size(pixels,1));
            data_win=zeros(size(pixels,1),32);
                for j=1:(b-win) 
                    w=hamming(win).';
                    %w=hanning(win).';
                    eval(['data_win=w(ones(1,size(pixels,1)),:).*(cond',int2str(i),'n_dt_bl(pixels,j:j+win-1)-repmat(mean(cond',int2str(i),'n_dt_bl(pixels,j:j+win-1),2),[1,win]));'])
                    y=fft(data_win.',NFFT);
                    y=y./win;
                    y = y(2:NFFT/2+1,:);
                    Pxx(:,j,:)=abs(y).^2;                
                end;
            eval(['clear cond',int2str(i),'n_dt_bl'])
            l=0;
            eval(['power_cond',int2str(i),'_trial_',int2str(h),'=Pxx;'])   
            clear Pxx
            %cd win320
            cd trials
            eval(['power_gamma_cond',int2str(i),'_trial_',int2str(h),'=squeeze(mean(power_cond',int2str(i),'_trial_',int2str(h),'(16:32,:,:),1));'])
            eval(['save power_gamma_cond',int2str(i),'_trial_',int2str(h),' power_gamma_cond',int2str(i),'_trial_',int2str(h),' pixels'])
            cd ..
            %cd ..
            eval(['clear power_cond',int2str(i),'_trial_',int2str(h)])
            eval(['clear power_gamma_cond',int2str(i),'_trial_',int2str(h)])
        end;
end;


cd F:\Data\VSDI\collinear\three_flankers\legolas\2007_05_10\b\no_stim\way2

load pixels_to_remove
t=ones(10000,1);
t(pixels_to_remove)=0;
pixels=find(t);
clear t


NFFT =64;
win=16;
for i=[4 3] %condition count
    z=0;
    eval(['load cond',int2str(i),'n_dt_bl'])
    eval(['a=size(cond',int2str(i),'n_dt_bl,3);'])    
    eval(['b=size(cond',int2str(i),'n_dt_bl,2);'])
        for h=1:a  %trial count 
            z=z+1;
            disp(['condition #',int2str(i),' trial #',int2str(h),' transforming data'])
            eval(['load cond',int2str(i),'n_dt_bl'])
            eval(['cond',int2str(i),'n_dt_bl=cond',int2str(i),'n_dt_bl(:,2:end,h);'])
            Pxx=NaN*ones(NFFT/2,b-win,size(pixels,1));
            data_win=zeros(size(pixels,1),32);
                for j=1:(b-win) 
                    w=hamming(win).';
                    %w=hanning(win).';
                    eval(['data_win=w(ones(1,size(pixels,1)),:).*(cond',int2str(i),'n_dt_bl(pixels,j:j+win-1)-repmat(mean(cond',int2str(i),'n_dt_bl(pixels,j:j+win-1),2),[1,win]));'])
                    y=fft(data_win.',NFFT);
                    y=y./win;
                    y = y(2:NFFT/2+1,:);
                    Pxx(:,j,:)=abs(y).^2;                
                end;
            eval(['clear cond',int2str(i),'n_dt_bl'])
            l=0;
            eval(['power_cond',int2str(i),'_trial_',int2str(h),'=Pxx;'])   
            clear Pxx
            %cd win320
            cd trials
            eval(['power_beta_cond',int2str(i),'_trial_',int2str(h),'=squeeze(mean(power_cond',int2str(i),'_trial_',int2str(h),'(10:15,:,:),1));'])
            eval(['save power_beta_cond',int2str(i),'_trial_',int2str(h),' power_beta_cond',int2str(i),'_trial_',int2str(h),' pixels'])
            cd ..
            %cd ..
            eval(['clear power_cond',int2str(i),'_trial_',int2str(h)])
            eval(['clear power_beta_cond',int2str(i),'_trial_',int2str(h)])
        end;
end;

load pixels_to_remove
t=ones(10000,1);
t(pixels_to_remove)=0;
pixels=find(t);
clear t


NFFT =64;
win=16;
for i=[4 3] %condition count
    z=0;
    eval(['load cond',int2str(i),'n_dt_bl'])
    eval(['a=size(cond',int2str(i),'n_dt_bl,3);'])    
    eval(['b=size(cond',int2str(i),'n_dt_bl,2);'])
        for h=1:a  %trial count 
            z=z+1;
            disp(['condition #',int2str(i),' trial #',int2str(h),' transforming data'])
            eval(['load cond',int2str(i),'n_dt_bl'])
            eval(['cond',int2str(i),'n_dt_bl=cond',int2str(i),'n_dt_bl(:,2:end,h);'])
            Pxx=NaN*ones(NFFT/2,b-win,size(pixels,1));
            data_win=zeros(size(pixels,1),32);
                for j=1:(b-win) 
                    w=hamming(win).';
                    %w=hanning(win).';
                    eval(['data_win=w(ones(1,size(pixels,1)),:).*(cond',int2str(i),'n_dt_bl(pixels,j:j+win-1)-repmat(mean(cond',int2str(i),'n_dt_bl(pixels,j:j+win-1),2),[1,win]));'])
                    y=fft(data_win.',NFFT);
                    y=y./win;
                    y = y(2:NFFT/2+1,:);
                    Pxx(:,j,:)=abs(y).^2;                
                end;
            eval(['clear cond',int2str(i),'n_dt_bl'])
            l=0;
            eval(['power_cond',int2str(i),'_trial_',int2str(h),'=Pxx;'])   
            clear Pxx
            %cd win320
            cd trials
            eval(['power_gamma_cond',int2str(i),'_trial_',int2str(h),'=squeeze(mean(power_cond',int2str(i),'_trial_',int2str(h),'(16:32,:,:),1));'])
            eval(['save power_gamma_cond',int2str(i),'_trial_',int2str(h),' power_gamma_cond',int2str(i),'_trial_',int2str(h),' pixels'])
            cd ..
            %cd ..
            eval(['clear power_cond',int2str(i),'_trial_',int2str(h)])
            eval(['clear power_gamma_cond',int2str(i),'_trial_',int2str(h)])
        end;
end;


cd F:\Data\VSDI\collinear\three_flankers\legolas\2007_05_10\e\no_stim\way2
load pixels_to_remove
t=ones(10000,1);
t(pixels_to_remove)=0;
pixels=find(t);
clear t


NFFT =64;
win=16;
for i=[4 3] %condition count
    z=0;
    eval(['load cond',int2str(i),'n_dt_bl'])
    eval(['a=size(cond',int2str(i),'n_dt_bl,3);'])    
    eval(['b=size(cond',int2str(i),'n_dt_bl,2);'])
        for h=1:a  %trial count 
            z=z+1;
            disp(['condition #',int2str(i),' trial #',int2str(h),' transforming data'])
            eval(['load cond',int2str(i),'n_dt_bl'])
            eval(['cond',int2str(i),'n_dt_bl=cond',int2str(i),'n_dt_bl(:,2:end,h);'])
            Pxx=NaN*ones(NFFT/2,b-win,size(pixels,1));
            data_win=zeros(size(pixels,1),32);
                for j=1:(b-win) 
                    w=hamming(win).';
                    %w=hanning(win).';
                    eval(['data_win=w(ones(1,size(pixels,1)),:).*(cond',int2str(i),'n_dt_bl(pixels,j:j+win-1)-repmat(mean(cond',int2str(i),'n_dt_bl(pixels,j:j+win-1),2),[1,win]));'])
                    y=fft(data_win.',NFFT);
                    y=y./win;
                    y = y(2:NFFT/2+1,:);
                    Pxx(:,j,:)=abs(y).^2;                
                end;
            eval(['clear cond',int2str(i),'n_dt_bl'])
            l=0;
            eval(['power_cond',int2str(i),'_trial_',int2str(h),'=Pxx;'])   
            clear Pxx
            %cd win320
            cd trials
            eval(['power_beta_cond',int2str(i),'_trial_',int2str(h),'=squeeze(mean(power_cond',int2str(i),'_trial_',int2str(h),'(10:15,:,:),1));'])
            eval(['save power_beta_cond',int2str(i),'_trial_',int2str(h),' power_beta_cond',int2str(i),'_trial_',int2str(h),' pixels'])
            cd ..
            %cd ..
            eval(['clear power_cond',int2str(i),'_trial_',int2str(h)])
            eval(['clear power_beta_cond',int2str(i),'_trial_',int2str(h)])
        end;
end;

load pixels_to_remove
t=ones(10000,1);
t(pixels_to_remove)=0;
pixels=find(t);
clear t


NFFT =64;
win=16;
for i=[4 3] %condition count
    z=0;
    eval(['load cond',int2str(i),'n_dt_bl'])
    eval(['a=size(cond',int2str(i),'n_dt_bl,3);'])    
    eval(['b=size(cond',int2str(i),'n_dt_bl,2);'])
        for h=1:a  %trial count 
            z=z+1;
            disp(['condition #',int2str(i),' trial #',int2str(h),' transforming data'])
            eval(['load cond',int2str(i),'n_dt_bl'])
            eval(['cond',int2str(i),'n_dt_bl=cond',int2str(i),'n_dt_bl(:,2:end,h);'])
            Pxx=NaN*ones(NFFT/2,b-win,size(pixels,1));
            data_win=zeros(size(pixels,1),32);
                for j=1:(b-win) 
                    w=hamming(win).';
                    %w=hanning(win).';
                    eval(['data_win=w(ones(1,size(pixels,1)),:).*(cond',int2str(i),'n_dt_bl(pixels,j:j+win-1)-repmat(mean(cond',int2str(i),'n_dt_bl(pixels,j:j+win-1),2),[1,win]));'])
                    y=fft(data_win.',NFFT);
                    y=y./win;
                    y = y(2:NFFT/2+1,:);
                    Pxx(:,j,:)=abs(y).^2;                
                end;
            eval(['clear cond',int2str(i),'n_dt_bl'])
            l=0;
            eval(['power_cond',int2str(i),'_trial_',int2str(h),'=Pxx;'])   
            clear Pxx
            %cd win320
            cd trials
            eval(['power_gamma_cond',int2str(i),'_trial_',int2str(h),'=squeeze(mean(power_cond',int2str(i),'_trial_',int2str(h),'(16:32,:,:),1));'])
            eval(['save power_gamma_cond',int2str(i),'_trial_',int2str(h),' power_gamma_cond',int2str(i),'_trial_',int2str(h),' pixels'])
            cd ..
            %cd ..
            eval(['clear power_cond',int2str(i),'_trial_',int2str(h)])
            eval(['clear power_gamma_cond',int2str(i),'_trial_',int2str(h)])
        end;
end;
