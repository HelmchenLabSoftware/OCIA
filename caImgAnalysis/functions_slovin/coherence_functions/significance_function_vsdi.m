


up=mean(mean(der_cond2(:,3:15,:),3),2)+4*std(mean(der_cond2(:,3:15,:),3),0,2);
a=mean(der_cond2(:,:,:),3);
sig=zeros(10000,246);
for j=1:10000
    disp(j)
    for i=1:246
        if a(j,i)>up(j)
            if a(j,i+1)>up(j)
                if a(j,i+2)>up(j)
                    sig(j,i)=1;
                end
            end
        end
    end
end

%%
figure(100)
mimg(mean(sig(:,28:33),2),100,100,0,1)
z = choose_polygon(100);
[row,col,v] = find(mean(sig(z,28:32),2));
roi_V2=z(row);


