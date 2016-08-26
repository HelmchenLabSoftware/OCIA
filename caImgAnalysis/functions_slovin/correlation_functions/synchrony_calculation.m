


circ=zeros(13,2);

circ(1,1)=mean(mean(co_1111c_1(roi_contour2,31:34)));
circ(1,2)=mean(mean(co_1111c_4(roi_contour2,31:34)));
circ(2,1)=mean(mean(co_1111c_2(roi_contour2,31:34)));
circ(2,2)=mean(mean(co_1111c_5(roi_contour2,31:34)));
circ(3,1)=mean(mean(co_1111d_1(roi_contour2,31:34)));
circ(3,2)=mean(mean(co_1111d_4(roi_contour2,31:34)));
circ(4,1)=mean(mean(co_1111d_2(roi_contour2,31:34)));
circ(4,2)=mean(mean(co_1111d_5(roi_contour2,31:34)));

circ(5,1)=mean(mean(co_1811c_1(roi_contour,31:34)));
circ(5,2)=mean(mean(co_1811c_5(roi_contour,31:34)));
circ(6,1)=mean(mean(co_1811d_1(roi_contour,31:34)));
circ(6,2)=mean(mean(co_1811d_5(roi_contour,31:34)));
circ(7,1)=mean(mean(co_1811e_1(roi_contour,31:34)));
circ(7,2)=mean(mean(co_1811e_5(roi_contour,31:34)));


circ(8,1)=mean(mean(co_2511d_1(roi_contour,31:34)));
circ(8,2)=mean(mean(co_2511d_5(roi_contour,31:34)));
circ(9,1)=mean(mean(co_2511e_1(roi_contour,31:34)));
circ(9,2)=mean(mean(co_2511e_5(roi_contour,31:34)));
circ(10,1)=mean(mean(co_2511f_1(roi_contour,31:34)));
circ(10,2)=mean(mean(co_2511f_5(roi_contour,31:34)));

circ(11,1)=mean(mean(co_1203d_1(roi_contour,31:34)));
circ(11,2)=mean(mean(co_1203d_5(roi_contour,31:34)));
circ(12,1)=mean(mean(co_1203e_1(roi_contour,31:34)));
circ(12,2)=mean(mean(co_1203e_5(roi_contour,31:34)));
circ(13,1)=mean(mean(co_1203f_1(roi_contour,31:34)));
circ(13,2)=mean(mean(co_1203f_5(roi_contour,31:34)));




%
back=zeros(13,2);

back(1,1)=mean(mean(bg_1111c_1(roi_maskin,31:34)));
back(1,2)=mean(mean(bg_1111c_4(roi_maskin,31:34)));
back(2,1)=mean(mean(bg_1111c_2(roi_maskin,31:34)));
back(2,2)=mean(mean(bg_1111c_5(roi_maskin,31:34)));
back(3,1)=mean(mean(bg_1111d_1(roi_maskin,31:34)));
back(3,2)=mean(mean(bg_1111d_4(roi_maskin,31:34)));
back(4,1)=mean(mean(bg_1111d_2(roi_maskin,31:34)));
back(4,2)=mean(mean(bg_1111d_5(roi_maskin,31:34)));

back(5,1)=mean(mean(bg_1811c_1(roi_bg_in,31:34)));
back(5,2)=mean(mean(bg_1811c_5(roi_bg_in,31:34)));
back(6,1)=mean(mean(bg_1811d_1(roi_bg_in,31:34)));
back(6,2)=mean(mean(bg_1811d_5(roi_bg_in,31:34)));
back(7,1)=mean(mean(bg_1811e_1(roi_bg_in,31:34)));
back(7,2)=mean(mean(bg_1811e_5(roi_bg_in,31:34)));


back(8,1)=mean(mean(bg_2511d_1(roi_bg_in,31:34)));
back(8,2)=mean(mean(bg_2511d_5(roi_bg_in,31:34)));
back(9,1)=mean(mean(bg_2511e_1(roi_bg_in,31:34)));
back(9,2)=mean(mean(bg_2511e_5(roi_bg_in,31:34)));
back(10,1)=mean(mean(bg_2511f_1(roi_bg_in,31:34)));
back(10,2)=mean(mean(bg_2511f_5(roi_bg_in,31:34)));

back(11,1)=mean(mean(bg_1203d_1(roi_bg_in,31:34)));
back(11,2)=mean(mean(bg_1203d_5(roi_bg_in,31:34)));
back(12,1)=mean(mean(bg_1203e_1(roi_bg_in,31:34)));
back(12,2)=mean(mean(bg_1203e_5(roi_bg_in,31:34)));
back(13,1)=mean(mean(bg_1203f_1(roi_bg_in,31:34)));
back(13,2)=mean(mean(bg_1203f_5(roi_bg_in,31:34)));





high=zeros(13,2);

high(1,1)=mean(mean(co_1111c_1(roi_V2,31:34)));
high(1,2)=mean(mean(co_1111c_4(roi_V2,31:34)));
high(2,1)=mean(mean(co_1111c_2(roi_V2,31:34)));
high(2,2)=mean(mean(co_1111c_5(roi_V2,31:34)));
high(3,1)=mean(mean(co_1111d_1(roi_V2,31:34)));
high(3,2)=mean(mean(co_1111d_4(roi_V2,31:34)));
high(4,1)=mean(mean(co_1111d_2(roi_V2,31:34)));
high(4,2)=mean(mean(co_1111d_5(roi_V2,31:34)));

high(5,1)=mean(mean(co_1811c_1(roi_V2,31:34)));
high(5,2)=mean(mean(co_1811c_5(roi_V2,31:34)));
high(6,1)=mean(mean(co_1811d_1(roi_V2,31:34)));
high(6,2)=mean(mean(co_1811d_5(roi_V2,31:34)));
high(7,1)=mean(mean(co_1811e_1(roi_V2,31:34)));
high(7,2)=mean(mean(co_1811e_5(roi_V2,31:34)));


high(8,1)=mean(mean(co_2511d_1(roi_V2,31:34)));
high(8,2)=mean(mean(co_2511d_5(roi_V2,31:34)));
high(9,1)=mean(mean(co_2511e_1(roi_V2,31:34)));
high(9,2)=mean(mean(co_2511e_5(roi_V2,31:34)));
high(10,1)=mean(mean(co_2511f_1(roi_V2,31:34)));
high(10,2)=mean(mean(co_2511f_5(roi_V2,31:34)));

high(11,1)=mean(mean(co_1203d_1(roi_V2,31:34)));
high(11,2)=mean(mean(co_1203d_5(roi_V2,31:34)));
high(12,1)=mean(mean(co_1203e_1(roi_V2,31:34)));
high(12,2)=mean(mean(co_1203e_5(roi_V2,31:34)));
high(13,1)=mean(mean(co_1203f_1(roi_V2,31:34)));
high(13,2)=mean(mean(co_1203f_5(roi_V2,31:34)));



diff1=circ(:,1)-circ(:,2);
diff2=back(:,1)-back(:,2);
diff3=high(:,1)-high(:,2);

diff=[diff1 diff2 diff3];


high2=zeros(13,2);

high2(1,1)=mean(mean(co_1111c_1(roi_V2,42:45)));
high2(1,2)=mean(mean(co_1111c_4(roi_V2,42:45)));
high2(2,1)=mean(mean(co_1111c_2(roi_V2,42:45)));
high2(2,2)=mean(mean(co_1111c_5(roi_V2,42:45)));
high2(3,1)=mean(mean(co_1111d_1(roi_V2,42:45)));
high2(3,2)=mean(mean(co_1111d_4(roi_V2,42:45)));
high2(4,1)=mean(mean(co_1111d_2(roi_V2,42:45)));
high2(4,2)=mean(mean(co_1111d_5(roi_V2,42:45)));

high2(5,1)=mean(mean(co_1811c_1(roi_V2,42:45)));
high2(5,2)=mean(mean(co_1811c_5(roi_V2,42:45)));
high2(6,1)=mean(mean(co_1811d_1(roi_V2,42:45)));
high2(6,2)=mean(mean(co_1811d_5(roi_V2,42:45)));
high2(7,1)=mean(mean(co_1811e_1(roi_V2,42:45)));
high2(7,2)=mean(mean(co_1811e_5(roi_V2,42:45)));


high2(8,1)=mean(mean(co_2511d_1(roi_V2,42:45)));
high2(8,2)=mean(mean(co_2511d_5(roi_V2,42:45)));
high2(9,1)=mean(mean(co_2511e_1(roi_V2,42:45)));
high2(9,2)=mean(mean(co_2511e_5(roi_V2,42:45)));
high2(10,1)=mean(mean(co_2511f_1(roi_V2,42:45)));
high2(10,2)=mean(mean(co_2511f_5(roi_V2,42:45)));

high2(11,1)=mean(mean(co_1203d_1(roi_V2,42:45)));
high2(11,2)=mean(mean(co_1203d_5(roi_V2,42:45)));
high2(12,1)=mean(mean(co_1203e_1(roi_V2,42:45)));
high2(12,2)=mean(mean(co_1203e_5(roi_V2,42:45)));
high2(13,1)=mean(mean(co_1203f_1(roi_V2,42:45)));
high2(13,2)=mean(mean(co_1203f_5(roi_V2,42:45)));


% bg cc in V2
high_bg=zeros(13,2);

high_bg(1,1)=mean(mean(bg_1111c_1(roi_V2,31:34)));
high_bg(1,2)=mean(mean(bg_1111c_4(roi_V2,31:34)));
high_bg(2,1)=mean(mean(bg_1111c_2(roi_V2,31:34)));
high_bg(2,2)=mean(mean(bg_1111c_5(roi_V2,31:34)));
high_bg(3,1)=mean(mean(bg_1111d_1(roi_V2,31:34)));
high_bg(3,2)=mean(mean(bg_1111d_4(roi_V2,31:34)));
high_bg(4,1)=mean(mean(bg_1111d_2(roi_V2,31:34)));
high_bg(4,2)=mean(mean(bg_1111d_5(roi_V2,31:34)));

high_bg(5,1)=mean(mean(bg_1811c_1(roi_V2,31:34)));
high_bg(5,2)=mean(mean(bg_1811c_5(roi_V2,31:34)));
high_bg(6,1)=mean(mean(bg_1811d_1(roi_V2,31:34)));
high_bg(6,2)=mean(mean(bg_1811d_5(roi_V2,31:34)));
high_bg(7,1)=mean(mean(bg_1811e_1(roi_V2,31:34)));
high_bg(7,2)=mean(mean(bg_1811e_5(roi_V2,31:34)));


high_bg(8,1)=mean(mean(bg_2511d_1(roi_V2,31:34)));
high_bg(8,2)=mean(mean(bg_2511d_5(roi_V2,31:34)));
high_bg(9,1)=mean(mean(bg_2511e_1(roi_V2,31:34)));
high_bg(9,2)=mean(mean(bg_2511e_5(roi_V2,31:34)));
high_bg(10,1)=mean(mean(bg_2511f_1(roi_V2,31:34)));
high_bg(10,2)=mean(mean(bg_2511f_5(roi_V2,31:34)));

high_bg(11,1)=mean(mean(bg_1203d_1(roi_V2,31:34)));
high_bg(11,2)=mean(mean(bg_1203d_5(roi_V2,31:34)));
high_bg(12,1)=mean(mean(bg_1203e_1(roi_V2,31:34)));
high_bg(12,2)=mean(mean(bg_1203e_5(roi_V2,31:34)));
high_bg(13,1)=mean(mean(bg_1203f_1(roi_V2,31:34)));
high_bg(13,2)=mean(mean(bg_1203f_5(roi_V2,31:34)));




high2_bg=zeros(13,2);

high2_bg(1,1)=mean(mean(bg_1111c_1(roi_V2,42:45)));
high2_bg(1,2)=mean(mean(bg_1111c_4(roi_V2,42:45)));
high2_bg(2,1)=mean(mean(bg_1111c_2(roi_V2,42:45)));
high2_bg(2,2)=mean(mean(bg_1111c_5(roi_V2,42:45)));
high2_bg(3,1)=mean(mean(bg_1111d_1(roi_V2,42:45)));
high2_bg(3,2)=mean(mean(bg_1111d_4(roi_V2,42:45)));
high2_bg(4,1)=mean(mean(bg_1111d_2(roi_V2,42:45)));
high2_bg(4,2)=mean(mean(bg_1111d_5(roi_V2,42:45)));

high2_bg(5,1)=mean(mean(bg_1811c_1(roi_V2,42:45)));
high2_bg(5,2)=mean(mean(bg_1811c_5(roi_V2,42:45)));
high2_bg(6,1)=mean(mean(bg_1811d_1(roi_V2,42:45)));
high2_bg(6,2)=mean(mean(bg_1811d_5(roi_V2,42:45)));
high2_bg(7,1)=mean(mean(bg_1811e_1(roi_V2,42:45)));
high2_bg(7,2)=mean(mean(bg_1811e_5(roi_V2,42:45)));


high2_bg(8,1)=mean(mean(bg_2511d_1(roi_V2,42:45)));
high2_bg(8,2)=mean(mean(bg_2511d_5(roi_V2,42:45)));
high2_bg(9,1)=mean(mean(bg_2511e_1(roi_V2,42:45)));
high2_bg(9,2)=mean(mean(bg_2511e_5(roi_V2,42:45)));
high2_bg(10,1)=mean(mean(bg_2511f_1(roi_V2,42:45)));
high2_bg(10,2)=mean(mean(bg_2511f_5(roi_V2,42:45)));

high2_bg(11,1)=mean(mean(bg_1203d_1(roi_V2,42:45)));
high2_bg(11,2)=mean(mean(bg_1203d_5(roi_V2,42:45)));
high2_bg(12,1)=mean(mean(bg_1203e_1(roi_V2,42:45)));
high2_bg(12,2)=mean(mean(bg_1203e_5(roi_V2,42:45)));
high2_bg(13,1)=mean(mean(bg_1203f_1(roi_V2,42:45)));
high2_bg(13,2)=mean(mean(bg_1203f_5(roi_V2,42:45)));



