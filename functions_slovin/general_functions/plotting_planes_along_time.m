
x=(10:10:2560)-280;
for i=28:58
    figure;plot(plane_c_dist_0501(:,i))
    hold on
    %plot(plane_non_c_dist_1111h5(:,i),'r')
    title(['time ',int2str(x(i)),' ms'])
    ylim([-1 1])
    xlim([1 12])
    plot(zeros(1,size(plane_b_dist_0501,1)),'k')
end




x=(10:10:2560)-280;
for i=28:58
    figure;plot(plane_b_dist_2212(:,i))
    hold on
    %plot(plane_non_b_dist_1111d4(:,i),'r')
    title(['time ',int2str(x(i)),' ms'])
    ylim([-1 1])
    plot(zeros(1,size(plane_b_dist_2212,1)),'k')
end






