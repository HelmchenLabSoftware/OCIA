cd /fat/Ariel/matlab_analysis/vsdi/frodo/12_05_2010/a

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
            cd trials
            eval(['save power_cond',int2str(i),'_trial_',int2str(h),' power_cond',int2str(i),'_trial_',int2str(h),' pixels'])
            cd ..
            eval(['clear power_cond',int2str(i),'_trial_',int2str(h)])
        end;
end;



