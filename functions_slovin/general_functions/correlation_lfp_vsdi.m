% correlation coefficient between lfp and vsdi frequencies

%time and frequency vectors

%x1=(20:10:1130)-200; %for collinear
f1=(1:32)*50/32;
%x1=(20:10:2010)-190; %for contour integration
x1=(20:10:1130)-190; %for faces

x2=(1:459)*4-(420); %for faces and contour integration
%x2=(1:459)*4-(420+25); %for collinear
f2=(1:64)*125/64;


v=squeeze(mean(a(roi_V1,:,:),1));
v=squeeze(mean(power_colin,3));
v=squeeze(mean(power_nocolin,3));
v=squeeze(mean(power_cond4,3));

l=mean(spect_colin(:,:,1:6),3);
l=mean(spect_cond4,3);

%downsample lfp time
x3 = resample(x2,4,10);
%downsample lfp frequency
l_ds = resample(l',4,10)';
% calculate for stimulus -50 to 200 ms - 38:63 for LFP and 13:38 for vsdi
cc=zeros(32,64);
for i=1:32
    for j=1:64
         c=corrcoef(l_ds(j,38:63),v(i,13:38));
         cc(i,j)=c(1,2);
    end
end

figure
imagesc(f2,f1,cc,[-1 1]);colormap(mapgeog)
ylim([5 50])
xlim([5 125])

%calculate for baseline
cc_b=zeros(32,64);
for i=1:32
    for j=1:64
         c=corrcoef(l_ds(j,28:36),v(i,3:11));
         cc_b(i,j)=c(1,2);
    end
end

figure
imagesc(f2,f1,cc_b,[-1 1]);colormap(mapgeog)
ylim([5 50])
xlim([5 125])

% cc=(ccco+ccci+ccf)/3;
% cc_b=(ccco_b+ccci_b+ccf_b)/3;
%normalize to maximum
v=v./repmat(max(v(:,1:50),[],2),1,200);
l_ds =l_ds./repmat(max(l_ds(:,1:60),[],2),1,184);

figure
imagesc(x1,f1,v,[0 1]);colormap(mapgeog)
xlim([-100 1000])
figure
imagesc(x3,f2,l_ds,[0 1]);colormap(mapgeog)
xlim([-100 1000])

figure
plot(x1,mean(v(18:22,:),1))
xlim([-100 200])
figure
plot(x1,mean(v(24:32,:),1))
xlim([-100 200])
figure
plot(x3,mean(l_ds(31:end,:),1))
xlim([-100 200])

figure
plot(x1,squeeze(mean(power_colin(16:22,:,:),1)))
xlim([-100 200])
figure
plot(x1,squeeze(mean(power_nocolin(16:22,:,:),1)))
xlim([-100 200])


figure
errorbar(x1,squeeze(mean(mean(power_colin(16:22,:,:),1),3)),squeeze(std(mean(power_colin(16:22,:,:),1),0,3))/sqrt(5))
hold on
errorbar(x1,squeeze(mean(mean(power_nocolin(16:22,:,:),1),3)),squeeze(std(mean(power_nocolin(16:22,:,:),1),0,3))/sqrt(5),'r')
xlim([-100 200])


% band correlation
ccb=zeros(4,3);

t=corrcoef(mean(l_ds(3:7,38:63),1),mean(v(4:9,13:38),1));
ccb(1,1)=t(1,2);
t=corrcoef(mean(l_ds(3:7,38:63),1),mean(v(10:15,13:38),1));
ccb(1,2)=t(1,2);
t=corrcoef(mean(l_ds(3:7,38:63),1),mean(v(16:32,13:38),1));
ccb(1,3)=t(1,2);
t=corrcoef(mean(l_ds(8:12,38:63),1),mean(v(4:9,13:38),1));
ccb(2,1)=t(1,2);
t=corrcoef(mean(l_ds(8:12,38:63),1),mean(v(10:15,13:38),1));
ccb(2,2)=t(1,2);
t=corrcoef(mean(l_ds(8:12,38:63),1),mean(v(16:32,13:38),1));
ccb(2,3)=t(1,2);
t=corrcoef(mean(l_ds(13:25,38:63),1),mean(v(4:9,13:38),1));
ccb(3,1)=t(1,2);
t=corrcoef(mean(l_ds(13:25,38:63),1),mean(v(10:15,13:38),1));
ccb(3,2)=t(1,2);
t=corrcoef(mean(l_ds(13:25,38:63),1),mean(v(16:32,13:38),1));
ccb(3,3)=t(1,2);
t=corrcoef(mean(l_ds(31:end,38:63),1),mean(v(4:9,13:38),1));
ccb(4,1)=t(1,2);
t=corrcoef(mean(l_ds(31:end,38:63),1),mean(v(10:15,13:38),1));
ccb(4,2)=t(1,2);
t=corrcoef(mean(l_ds(31:end,38:63),1),mean(v(16:32,13:38),1));
ccb(4,3)=t(1,2);

figure;imagesc(ccb,[0,1]);colormap(mapgeog)

ccb=(ccbco+ccbci+ccbf)/3;

ccbb=zeros(4,3);

t=corrcoef(mean(l_ds(3:7,28:38),1),mean(v(4:9,3:13),1));
ccbb(1,1)=t(1,2);
t=corrcoef(mean(l_ds(3:7,28:38),1),mean(v(10:15,3:13),1));
ccbb(1,2)=t(1,2);
t=corrcoef(mean(l_ds(3:7,28:38),1),mean(v(16:32,3:13),1));
ccbb(1,3)=t(1,2);
t=corrcoef(mean(l_ds(8:12,28:38),1),mean(v(4:9,3:13),1));
ccbb(2,1)=t(1,2);
t=corrcoef(mean(l_ds(8:12,28:38),1),mean(v(10:15,3:13),1));
ccbb(2,2)=t(1,2);
t=corrcoef(mean(l_ds(8:12,28:38),1),mean(v(16:32,3:13),1));
ccbb(2,3)=t(1,2);
t=corrcoef(mean(l_ds(13:25,28:38),1),mean(v(4:9,3:13),1));
ccbb(3,1)=t(1,2);
t=corrcoef(mean(l_ds(13:25,28:38),1),mean(v(10:15,3:13),1));
ccbb(3,2)=t(1,2);
t=corrcoef(mean(l_ds(13:25,28:38),1),mean(v(16:32,3:13),1));
ccbb(3,3)=t(1,2);
t=corrcoef(mean(l_ds(31:end,28:38),1),mean(v(4:9,3:13),1));
ccbb(4,1)=t(1,2);
t=corrcoef(mean(l_ds(31:end,28:38),1),mean(v(10:15,3:13),1));
ccbb(4,2)=t(1,2);
t=corrcoef(mean(l_ds(31:end,28:38),1),mean(v(16:32,3:13),1));
ccbb(4,3)=t(1,2);

figure;imagesc(ccbb,[0,1]);colormap(mapgeog)


% histograms vs baseline

n1=hist(reshape(cc(4:9,13:25),[1,78]),-1:0.1:1);
n2=hist(reshape(cc_b(4:9,13:25),[1,78]),-1:0.1:1);
figure
bar(-1:0.1:1,[n1;n2]')
ranksum(reshape(cc(4:9,13:25),[1,78]),reshape(cc_b(4:9,13:25),[1,78]))

n1=hist(reshape(cc(4:9,31:end),[1,204]),-1:0.1:1);
n2=hist(reshape(cc_b(4:9,31:end),[1,204]),-1:0.1:1);
figure
bar(-1:0.1:1,[n1;n2]')
ranksum(reshape(cc(4:9,31:end),[1,204]),reshape(cc_b(4:9,31:end),[1,204]))


n1=hist(reshape(cc(18:24,31:end),[1,238]),-1:0.1:1);
n2=hist(reshape(cc_b(18:24,31:end),[1,238]),-1:0.1:1);
figure
bar(-1:0.1:1,[n1;n2]')
ranksum(reshape(cc(18:24,31:end),[1,238]),reshape(cc_b(18:24,31:end),[1,238]))


n1=hist(reshape(cc(10:15,31:end),[1,204]),-1:0.1:1);
n2=hist(reshape(cc_b(10:15,31:end),[1,204]),-1:0.1:1);
figure
bar(-1:0.1:1,[n1;n2]')
ranksum(reshape(cc(10:15,31:end),[1,204]),reshape(cc_b(10:15,31:end),[1,204]))



%%

n1=hist(reshape(cc(4:9,13:25),[1,78]),-1:0.1:1);
n2=hist(reshape(cc_b(4:9,13:25),[1,78]),-1:0.1:1);
n3=hist(reshape(cc(10:15,13:25),[1,78]),-1:0.1:1);
n4=hist(reshape(cc_b(10:15,13:25),[1,78]),-1:0.1:1);
n5=hist(reshape(cc(18:24,13:25),[1,91]),-1:0.1:1);
n6=hist(reshape(cc_b(18:24,13:25),[1,91]),-1:0.1:1);
n7=hist(reshape(cc(25:32,13:25),[1,104]),-1:0.1:1);
n8=hist(reshape(cc_b(25:32,13:25),[1,104]),-1:0.1:1);


n9=hist(reshape(cc(4:9,31:end),[1,204]),-1:0.1:1);
n10=hist(reshape(cc_b(4:9,31:end),[1,204]),-1:0.1:1);
n11=hist(reshape(cc(10:15,31:end),[1,204]),-1:0.1:1);
n12=hist(reshape(cc_b(10:15,31:end),[1,204]),-1:0.1:1);
n13=hist(reshape(cc(18:24,31:end),[1,238]),-1:0.1:1);
n14=hist(reshape(cc_b(18:24,31:end),[1,238]),-1:0.1:1);
n15=hist(reshape(cc(25:32,31:end),[1,272]),-1:0.1:1);
n16=hist(reshape(cc_b(25:32,31:end),[1,272]),-1:0.1:1);


figure
subplot(4,2,1)
bar(-1:0.1:1,[n1;n2]');xlim([-1 1]);title('vsdi alpha - lfp low gamma')
subplot(4,2,3)
bar(-1:0.1:1,[n3;n4]');xlim([-1 1]);title('vsdi beta - lfp low gamma')
subplot(4,2,5)
bar(-1:0.1:1,[n5;n6]');xlim([-1 1]);title('vsdi 25-35 Hz - lfp low gamma')
subplot(4,2,7)
bar(-1:0.1:1,[n7;n8]');xlim([-1 1]);title('vsdi 38-50 Hz - lfp low gamma')
subplot(4,2,2)
bar(-1:0.1:1,[n9;n10]');xlim([-1 1]);title('vsdi alpha - lfp high gamma')
subplot(4,2,4)
bar(-1:0.1:1,[n11;n12]');xlim([-1 1]);title('vsdi beta - lfp high gamma')
subplot(4,2,6)
bar(-1:0.1:1,[n13;n14]');xlim([-1 1]);title('vsdi 25-35 Hz - lfp high gamma')
subplot(4,2,8)
bar(-1:0.1:1,[n15;n16]');xlim([-1 1]);title('vsdi 38-50 Hz - lfp high gamma')



ranksum(reshape(cc(18:24,13:25),[1,91]),reshape(cc_b(18:24,13:25),[1,91]))

figure
bar(-1:0.1:1,[n5;n13]');xlim([-1 1]);



m(1,1)=mean(mean(cc(4:9,13:25)));
m(2,1)=mean(mean(cc_b(4:9,13:25)));
m(1,2)=mean(mean(cc(10:15,13:25)));
m(2,2)=mean(mean(cc_b(10:15,13:25)));
m(1,3)=mean(mean(cc(18:22,13:25)));
m(2,3)=mean(mean(cc_b(18:22,13:25)));
m(1,4)=mean(mean(cc(25:32,13:25)));
m(2,4)=mean(mean(cc_b(25:32,13:25)));


m(1,5)=mean(mean(cc(4:9,31:end)));
m(2,5)=mean(mean(cc_b(4:9,31:end)));
m(1,6)=mean(mean(cc(10:15,31:end)));
m(2,6)=mean(mean(cc_b(10:15,31:end)));
m(1,7)=mean(mean(cc(18:22,31:end)));
m(2,7)=mean(mean(cc_b(18:22,31:end)));
m(1,8)=mean(mean(cc(25:32,31:end)));
m(2,8)=mean(mean(cc_b(25:32,31:end)));

figure;bar(m')

figure
subplot(3,2,1)
bar(m_face(:,1:4)')
xlim([0 5]);ylim([-1 1])
subplot(3,2,2)
bar(m_face(:,5:8)')
xlim([0 5]);ylim([-1 1])
subplot(3,2,3)
bar(m_ci(:,1:4)')
xlim([0 5]);ylim([-1 1])
subplot(3,2,4)
bar(m_ci(:,5:8)')
xlim([0 5]);ylim([-1 1])
subplot(3,2,5)
bar(m_colin(:,1:4)')
xlim([0 5]);ylim([-1 1])
subplot(3,2,6)
bar(m_colin(:,5:8)')
xlim([0 5]);ylim([-1 1])




%% calculate correlations for each session

vt=5;   %number of vsdi trials
lt=6;  %number of lfp trials
w=0;
cc_b=zeros(32,64,vt,lt);
cc=zeros(32,64,vt,lt);
for k=1:vt
    for m=1:lt
        w=w+1;
        v=power_colin(:,:,k);
        l=spect_colin(:,:,m);
        %downsample lfp time
        x3 = resample(x2,4,10);
        %downsample lfp frequency
        l_ds = resample(l',4,10)';
        % calculate for stimulus -50 to 200 ms - 38:63 for LFP and 13:38 for vsdi
        
        for i=1:32
            for j=1:64
                 c=corrcoef(l_ds(j,38:63),v(i,13:38));
                 cc(i,j,k,m)=c(1,2);
            end
        end
%         figure(11)
%         subplot(vt,lt,w);
%         imagesc(f2,f1,cc(:,:,k,m),[-1 1]);colormap(mapgeog)
%         ylim([5 50])
%         xlim([5 125])
        %calculate for baseline
        
        for i=1:32
            for j=1:64
                 c=corrcoef(l_ds(j,28:36),v(i,3:11));
                 cc_b(i,j,k,m)=c(1,2);
            end
        end

%         figure(22)
%         subplot(vt,lt,w);
%         imagesc(f2,f1,cc_b(:,:,k,m),[-1 1]);colormap(mapgeog)
%         ylim([5 50])
%         xlim([5 125])
    end
end


figure
imagesc(f2,f1,mean(mean(cc,3),4));colormap(mapgeog)
ylim([5 50])
xlim([5 125])

figure
imagesc(f2,f1,mean(mean(cc_b,3),4),[-1 1]);colormap(mapgeog)
ylim([5 50])
xlim([5 125])

for k=1:vt
    for m=1:lt     
        figure(k+30)
        subplot(4,5,m)
        imagesc(f2,f1,cc(:,:,k,m),[-1 1]);colormap(mapgeog)
        ylim([5 50])
        xlim([5 125])
        figure(k+60)
        subplot(4,5,m)
        imagesc(f2,f1,cc_b(:,:,k,m),[-1 1]);colormap(mapgeog)
        ylim([5 50])
        xlim([5 125])
    end
end



m(1,1)=mean(mean(mean(mean(cc(4:9,13:25,:,:)))));
m(2,1)=mean(mean(mean(mean(cc_b(4:9,13:25,:,:)))));
m(1,2)=mean(mean(mean(mean(cc(10:15,13:25,:,:)))));
m(2,2)=mean(mean(mean(mean(cc_b(10:15,13:25,:,:)))));
m(1,3)=mean(mean(mean(mean(cc(18:22,13:25,:,:)))));
m(2,3)=mean(mean(mean(mean(cc_b(18:22,13:25,:,:)))));
m(1,4)=mean(mean(mean(mean(cc(25:32,13:25,:,:)))));
m(2,4)=mean(mean(mean(mean(cc_b(25:32,13:25,:,:)))));


m(1,5)=mean(mean(mean(mean(cc(4:9,31:end,:,:)))));
m(2,5)=mean(mean(mean(mean(cc_b(4:9,31:end,:,:)))));
m(1,6)=mean(mean(mean(mean(cc(10:15,31:end,:,:)))));
m(2,6)=mean(mean(mean(mean(cc_b(10:15,31:end,:,:)))));
m(1,7)=mean(mean(mean(mean(cc(18:22,31:end,:,:)))));
m(2,7)=mean(mean(mean(mean(cc_b(18:22,31:end,:,:)))));
m(1,8)=mean(mean(mean(mean(cc(25:32,31:end,:,:)))));
m(2,8)=mean(mean(mean(mean(cc_b(25:32,31:end,:,:)))));

figure;bar(m')






m(1,1)=mean(mean(mean(mean(cc(4:9,13:25,:,:)))));
m(2,1)=mean(mean(mean(mean(cc_b(4:9,13:25,:,:)))));
m(1,2)=mean(mean(mean(mean(cc(10:15,13:25,:,:)))));
m(2,2)=mean(mean(mean(mean(cc_b(10:15,13:25,:,:)))));
m(1,3)=mean(mean(mean(mean(cc(16:32,13:25,:,:)))));
m(2,3)=mean(mean(mean(mean(cc_b(16:32,13:25,:,:)))));
m(1,4)=mean(mean(mean(cct(13:25,:,:))));
m(2,4)=mean(mean(mean(cct_b(13:25,:,:))));

m(1,5)=mean(mean(mean(mean(cc(4:9,31:end,:,:)))));
m(2,5)=mean(mean(mean(mean(cc_b(4:9,31:end,:,:)))));
m(1,6)=mean(mean(mean(mean(cc(10:15,31:end,:,:)))));
m(2,6)=mean(mean(mean(mean(cc_b(10:15,31:end,:,:)))));
m(1,7)=mean(mean(mean(mean(cc(16:32,31:end,:,:)))));
m(2,7)=mean(mean(mean(mean(cc_b(16:32,31:end,:,:)))));
m(1,8)=mean(mean(mean(cct(31:end,:,:))));
m(2,8)=mean(mean(mean(cct_b(31:end,:,:))));

figure;bar(m')

ccc=reshape(cc,[32,64,size(cc,3)*size(cc,4)]);
ccc_b=reshape(cc_b,[32,64,size(cc,3)*size(cc,4)]);
ccct=reshape(cct,[64,size(cct,2)*size(cct,3)]);
ccct_b=reshape(cct_b,[64,size(cct_b,2)*size(cct_b,3)]);

s(1,1)=mean(mean(std(ccc(4:9,13:25,:),0,3)));
s(2,1)=mean(mean(std(ccc_b(4:9,13:25,:),0,3)));
s(1,2)=mean(mean(std(ccc(10:15,13:25,:),0,3)));
s(2,2)=mean(mean(std(ccc_b(10:15,13:25,:),0,3)));
s(1,3)=mean(mean(std(ccc(16:32,13:25,:),0,3)));
s(2,3)=mean(mean(std(ccc_b(16:32,13:25,:),0,3)));
s(1,4)=mean(std(cct(13:25,:),0,2));
s(2,4)=mean(std(cct_b(13:25,:),0,2));

s(1,5)=mean(mean(std(ccc(4:9,31:end,:),0,3)));
s(2,5)=mean(mean(std(ccc_b(4:9,31:end,:),0,3)));
s(1,6)=mean(mean(std(ccc(10:15,31:end,:),0,3)));
s(2,6)=mean(mean(std(ccc_b(10:15,31:end,:),0,3)));
s(1,7)=mean(mean(std(ccc(16:32,31:end,:),0,3)));
s(2,7)=mean(mean(std(ccc_b(16:32,31:end,:),0,3)));
s(1,8)=mean(std(cct(31:end,:),0,2));
s(2,8)=mean(std(cct_b(31:end,:),0,2));

figure;bar(m(1,:)')
hold on
errorbar(m(1,:)',s(1,:)'/sqrt(size(cc,3)*size(cc,4)));

figure;bar(m(2,:)')
hold on
errorbar(m(2,:)',s(2,:)'/sqrt(size(cc,3)*size(cc,4)));


ranksum(squeeze(mean(mean(ccc(4:9,13:25,:),1),2)),squeeze(mean(mean(ccc_b(4:9,13:25,:),1),2)))

ranksum(squeeze(mean(mean(ccc(4:9,13:25,:),1),2)),squeeze(mean(mean(ccc(10:15,13:25,:),1),2)))




m(1,1)=mean(mean(mean(mean(cc(4:9,4:7,:,:)))));
m(1,2)=mean(mean(mean(mean(cc(4:9,8:12,:,:)))));
m(1,3)=mean(mean(mean(mean(cc(4:9,13:25,:,:)))));
m(1,4)=mean(mean(mean(mean(cc(4:9,31:64,:,:)))));
m(2,1)=mean(mean(mean(mean(cc(10:15,4:7,:,:)))));
m(2,2)=mean(mean(mean(mean(cc(10:15,8:12,:,:)))));
m(2,3)=mean(mean(mean(mean(cc(10:15,13:25,:,:)))));
m(2,4)=mean(mean(mean(mean(cc(10:15,31:64,:,:)))));
m(3,1)=mean(mean(mean(mean(cc(16:32,4:7,:,:)))));
m(3,2)=mean(mean(mean(mean(cc(16:32,8:12,:,:)))));
m(3,3)=mean(mean(mean(mean(cc(16:32,13:25,:,:)))));
m(3,4)=mean(mean(mean(mean(cc(16:32,31:64,:,:)))));
m(4,1)=mean(mean(mean(cct(4:7,:,:))));
m(4,2)=mean(mean(mean(cct(8:12,:,:))));
m(4,3)=mean(mean(mean(cct(13:25,:,:))));
m(4,4)=mean(mean(mean(cct(31:64,:,:))));



m_tot=mean(cat(3,m_face,m_ci,m_colin,m_frodo),3);

al1=cat(2,m_face(1,1),m_ci(1,1),m_colin(1,1),m_frodo(1,1),m_tot(1,1));
al2=cat(2,m_face(1,2),m_ci(1,2),m_colin(1,2),m_frodo(1,2),m_tot(1,2));
al3=cat(2,m_face(1,3),m_ci(1,3),m_colin(1,3),m_frodo(1,3),m_tot(1,3));
al4=cat(2,m_face(1,4),m_ci(1,4),m_colin(1,4),m_frodo(1,4),m_tot(1,4));

figure;bar(cat(1,al1,al2,al3,al4));
ylim([-1 1])


bet1=cat(2,m_face(2,1),m_ci(2,1),m_colin(2,1),m_frodo(2,1),m_tot(2,1));
bet2=cat(2,m_face(2,2),m_ci(2,2),m_colin(2,2),m_frodo(2,2),m_tot(2,2));
bet3=cat(2,m_face(2,3),m_ci(2,3),m_colin(2,3),m_frodo(2,3),m_tot(2,3));
bet4=cat(2,m_face(2,4),m_ci(2,4),m_colin(2,4),m_frodo(2,4),m_tot(2,4));

figure;bar(cat(1,bet1,bet2,bet3,bet4));
ylim([-1 1])


gam1=squeeze(cat(2,m_face(3,1),m_ci(3,1),m_colin(3,1),m_frodo(3,1),m_tot(3,1)));
gam2=squeeze(cat(2,m_face(3,2),m_ci(3,2),m_colin(3,2),m_frodo(3,2),m_tot(3,2)));
gam3=squeeze(cat(2,m_face(3,3),m_ci(3,3),m_colin(3,3),m_frodo(3,3),m_tot(3,3)));
gam4=squeeze(cat(2,m_face(3,4),m_ci(3,4),m_colin(3,4),m_frodo(3,4),m_tot(3,4)));

figure;bar(cat(1,gam1,gam2,gam3,gam4));
ylim([-1 1])



gam1=cat(2,m_face(4,1),m_ci(4,1),m_colin(4,1),m_frodo(4,1),m_tot(4,1));
gam2=cat(2,m_face(4,2),m_ci(4,2),m_colin(4,2),m_frodo(4,2),m_tot(4,2));
gam3=cat(2,m_face(4,3),m_ci(4,3),m_colin(4,3),m_frodo(4,3),m_tot(4,3));
gam4=cat(2,m_face(4,4),m_ci(4,4),m_colin(4,4),m_frodo(4,4),m_tot(4,4));

figure;bar(cat(1,gam1,gam2,gam3,gam4));
ylim([-1 1])




