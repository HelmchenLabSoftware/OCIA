


load roi_for_continuity2

diff=cc_p_0501';
mat2=reshape(diff,100,100,112);
mat_area=reshape(mat,100,100);


for i = 1:size(bar_circ,1)
    for j=1:5
        for t=1:112
            barline_circ(i,j,t) = mat2(bar_circ(i,1,j),bar_circ(i,2,j),t);
        end
    end
    line_real_circ(i) = mat_area(bar_circ(i,1,1),bar_circ(i,2,1),1);
end

for i = 1:size(bar_bg,1)
    for j=1:5
        for t=1:112
            barline_bg(i,j,t) = mat2(bar_bg(i,1,j),bar_bg(i,2,j),t);
        end
    end
    line_real_bg(i) = mat_area(bar_bg(i,1,1),bar_bg(i,2,1),1);
end


%figure;plot(mean(barline_circ,2),'r')
%figure;plot(line_real_circ)
%figure;plot(mean(barline_bg,2),'r')
%figure;plot(line_real_bg)

