load myrois
load pixels_to_remove

mat=zeros(10000,1);
mat(roi_tar)=1;
mat(roi_f1late)=1;
mat(roi_f2)=1;
mat(roi_f3)=1;
mat(roi_f4)=1;
mat(roi_f5)=1;
mat(pixels_to_remove)=10;

%a=mean(cond1n_dt_bl,3);
%b=mean(cond4n_dt_bl,3);

load roi_for_continuity

diff=a-b;
diff=mean(diff(:,43:53),2);
mat2=reshape(diff,100,100);
mat_area=reshape(mat,100,100);


for i = 1:size(bar_circ,1)
    for j=1:5
        barline_circ(i,j) = mat2(bar_circ(i,1,j),bar_circ(i,2,j));
    end
    line_real_circ(i) = mat_area(bar_circ(i,1,3),bar_circ(i,2,3));
end

for i = 1:size(bar_bg,1)
    for j=1:5
        barline_bg(i,j) = mat2(bar_bg(i,1,j),bar_bg(i,2,j));
    end
    line_real_bg(i) = mat_area(bar_bg(i,1,3),bar_bg(i,2,3));
end


figure;plot(mean(barline_circ,2),'r')
%figure;plot(line_real_circ)
figure;plot(mean(barline_bg,2),'r')
%figure;plot(line_real_bg)




