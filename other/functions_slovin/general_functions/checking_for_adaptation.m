cd F:\Data\VSDI\Contour_integration\legolas\right_hemisphere
load('time_course_rois_all_Days_all_trials.mat')
amp2_start(1)=nanmean(nanmean(c4_1111c_bg_in(41:51,1:5)));
amp2_start(2)=nanmean(nanmean(c5_1111c_bg_in(41:51,1:5)));
amp2_start(3)=nanmean(nanmean(c4_1111d_bg_in(41:51,1:5)));
amp2_start(4)=nanmean(nanmean(c5_1111d_bg_in(41:51,1:5)));
amp2_start(5)=nanmean(nanmean(c5_1811c_bg_in(41:51,1:5)));
amp2_start(6)=nanmean(nanmean(c5_1811d_bg_in(41:51,1:5)));
amp2_start(7)=nanmean(nanmean(c5_1811e_bg_in(41:51,1:5)));
amp2_start(8)=nanmean(nanmean(c5_2511d_bg_in(41:51,1:5)));
amp2_start(9)=nanmean(nanmean(c5_2511e_bg_in(41:51,1:5)));
amp2_start(10)=nanmean(nanmean(c5_2511f_bg_in(41:51,1:5)));
amp2_start(11)=nanmean(nanmean(c5_1203d_bg_in(41:51,1:5)));
amp2_start(12)=nanmean(nanmean(c5_1203e_bg_in(41:51,1:5)));
amp2_start(13)=nanmean(nanmean(c5_1203f_bg_in(41:51,1:5)));
amp2_start(14)=nanmean(nanmean(c4_1111h_bg_in(41:51,1:5)));
amp2_start(15)=nanmean(nanmean(c5_1111h_bg_in(41:51,1:5)));
% amp2_start(16)=nanmean(nanmean(c4_0610e_bg_in(41:51,1:5)));
% amp2_start(17)=nanmean(nanmean(c5_0610e_bg_in(41:51,1:5)));
% amp2_start(18)=nanmean(nanmean(c4_0610f_bg_in(41:51,1:5)));
% amp2_start(19)=nanmean(nanmean(c5_0610f_bg_in(41:51,1:5)));
% amp2_start(20)=nanmean(nanmean(c4_2210d_bg_in(41:51,1:5)));
% amp2_start(21)=nanmean(nanmean(c5_2210d_bg_in(41:51,1:5)));
% amp2_start(22)=nanmean(nanmean(c4_2210e_bg_in(41:51,1:5)));
% amp2_start(23)=nanmean(nanmean(c5_2210e_bg_in(41:51,1:5)));


amp2_end(1)=nanmean(nanmean(c4_1111c_bg_in(41:51,end-5:end)));
amp2_end(2)=nanmean(nanmean(c5_1111c_bg_in(41:51,end-5:end)));
amp2_end(3)=nanmean(nanmean(c4_1111d_bg_in(41:51,end-5:end)));
amp2_end(4)=nanmean(nanmean(c5_1111d_bg_in(41:51,end-5:end)));
amp2_end(5)=nanmean(nanmean(c5_1811c_bg_in(41:51,end-5:end)));
amp2_end(6)=nanmean(nanmean(c5_1811d_bg_in(41:51,end-5:end)));
amp2_end(7)=nanmean(nanmean(c5_1811e_bg_in(41:51,end-5:end)));
amp2_end(8)=nanmean(nanmean(c5_2511d_bg_in(41:51,end-5:end)));
amp2_end(9)=nanmean(nanmean(c5_2511e_bg_in(41:51,end-5:end)));
amp2_end(10)=nanmean(nanmean(c5_2511f_bg_in(41:51,end-5:end)));
amp2_end(11)=nanmean(nanmean(c5_1203d_bg_in(41:51,end-5:end)));
amp2_end(12)=nanmean(nanmean(c5_1203e_bg_in(41:51,end-5:end)));
amp2_end(13)=nanmean(nanmean(c5_1203f_bg_in(41:51,end-5:end)));
amp2_end(14)=nanmean(nanmean(c4_1111h_bg_in(41:51,end-5:end)));
amp2_end(15)=nanmean(nanmean(c5_1111h_bg_in(41:51,end-5:end)));
% amp2_end(16)=nanmean(nanmean(c4_0610e_bg_in(41:51,end-5:end)));
% amp2_end(17)=nanmean(nanmean(c5_0610e_bg_in(41:51,end-5:end)));
% amp2_end(18)=nanmean(nanmean(c4_0610f_bg_in(41:51,end-5:end)));
% amp2_end(19)=nanmean(nanmean(c5_0610f_bg_in(41:51,end-5:end)));
% amp2_end(20)=nanmean(nanmean(c4_2210d_bg_in(41:51,end-5:end)));
% amp2_end(21)=nanmean(nanmean(c5_2210d_bg_in(41:51,end-5:end)));
% amp2_end(22)=nanmean(nanmean(c4_2210e_bg_in(41:51,end-5:end)));
% amp2_end(23)=nanmean(nanmean(c5_2210e_bg_in(41:51,end-5:end)));

amp_start(1)=nanmean(nanmean(c4_1111c_circle_diff(41:51,1:5)));
amp_start(2)=nanmean(nanmean(c5_1111c_circle_diff(41:51,1:5)));
amp_start(3)=nanmean(nanmean(c4_1111d_circle_diff(41:51,1:5)));
amp_start(4)=nanmean(nanmean(c5_1111d_circle_diff(41:51,1:5)));
amp_start(5)=nanmean(nanmean(c5_1811c_circle_diff(41:51,1:5)));
amp_start(6)=nanmean(nanmean(c5_1811d_circle_diff(41:51,1:5)));
amp_start(7)=nanmean(nanmean(c5_1811e_circle_diff(41:51,1:5)));
amp_start(8)=nanmean(nanmean(c5_2511d_circle_diff(41:51,1:5)));
amp_start(9)=nanmean(nanmean(c5_2511e_circle_diff(41:51,1:5)));
amp_start(10)=nanmean(nanmean(c5_2511f_circle_diff(41:51,1:5)));
amp_start(11)=nanmean(nanmean(c5_1203d_circle_diff(41:51,1:5)));
amp_start(12)=nanmean(nanmean(c5_1203e_circle_diff(41:51,1:5)));
amp_start(13)=nanmean(nanmean(c5_1203f_circle_diff(41:51,1:5)));
amp_start(14)=nanmean(nanmean(c4_1111h_circle_diff(41:51,1:5)));
amp_start(15)=nanmean(nanmean(c5_1111h_circle_diff(41:51,1:5)));
% amp_start(16)=nanmean(nanmean(c4_0610e_circle_diff(41:51,1:5)));
% amp_start(17)=nanmean(nanmean(c5_0610e_circle_diff(41:51,1:5)));
% amp_start(18)=nanmean(nanmean(c4_0610f_circle_diff(41:51,1:5)));
% amp_start(19)=nanmean(nanmean(c5_0610f_circle_diff(41:51,1:5)));
% amp_start(20)=nanmean(nanmean(c4_2210d_circle_diff(41:51,1:5)));
% amp_start(21)=nanmean(nanmean(c5_2210d_circle_diff(41:51,1:5)));
% amp_start(22)=nanmean(nanmean(c4_2210e_circle_diff(41:51,1:5)));
% amp_start(23)=nanmean(nanmean(c5_2210e_circle_diff(41:51,1:5)));


amp_end(1)=nanmean(nanmean(c4_1111c_circle_diff(41:51,end-5:end)));
amp_end(2)=nanmean(nanmean(c5_1111c_circle_diff(41:51,end-5:end)));
amp_end(3)=nanmean(nanmean(c4_1111d_circle_diff(41:51,end-5:end)));
amp_end(4)=nanmean(nanmean(c5_1111d_circle_diff(41:51,end-5:end)));
amp_end(5)=nanmean(nanmean(c5_1811c_circle_diff(41:51,end-5:end)));
amp_end(6)=nanmean(nanmean(c5_1811d_circle_diff(41:51,end-5:end)));
amp_end(7)=nanmean(nanmean(c5_1811e_circle_diff(41:51,end-5:end)));
amp_end(8)=nanmean(nanmean(c5_2511d_circle_diff(41:51,end-5:end)));
amp_end(9)=nanmean(nanmean(c5_2511e_circle_diff(41:51,end-5:end)));
amp_end(10)=nanmean(nanmean(c5_2511f_circle_diff(41:51,end-5:end)));
amp_end(11)=nanmean(nanmean(c5_1203d_circle_diff(41:51,end-5:end)));
amp_end(12)=nanmean(nanmean(c5_1203e_circle_diff(41:51,end-5:end)));
amp_end(13)=nanmean(nanmean(c5_1203f_circle_diff(41:51,end-5:end)));
amp_end(14)=nanmean(nanmean(c4_1111h_circle_diff(41:51,end-5:end)));
amp_end(15)=nanmean(nanmean(c5_1111h_circle_diff(41:51,end-5:end)));
% amp_end(16)=nanmean(nanmean(c4_0610e_circle_diff(41:51,end-5:end)));
% amp_end(17)=nanmean(nanmean(c5_0610e_circle_diff(41:51,end-5:end)));
% amp_end(18)=nanmean(nanmean(c4_0610f_circle_diff(41:51,end-5:end)));
% amp_end(19)=nanmean(nanmean(c5_0610f_circle_diff(41:51,end-5:end)));
% amp_end(20)=nanmean(nanmean(c4_2210d_circle_diff(41:51,end-5:end)));
% amp_end(21)=nanmean(nanmean(c5_2210d_circle_diff(41:51,end-5:end)));
% amp_end(22)=nanmean(nanmean(c4_2210e_circle_diff(41:51,end-5:end)));
% amp_end(23)=nanmean(nanmean(c5_2210e_circle_diff(41:51,end-5:end)));


a=(amp2_start+amp_start)/2;
b=(amp2_end+amp_end)/2;

ranksum(a,b)
signrank(a-b)


%%
clear all
cd F:\Data\VSDI\Contour_integration\Smeagol 
load('time_course_per_session_all_rois.mat')

amp2_start(1)=nanmean(nanmean(c4_2912c_bg_out(41:51,1:5)));
amp2_start(2)=nanmean(nanmean(c5_2912c_bg_out(41:51,1:5)));
amp2_start(3)=nanmean(nanmean(c4_2912e_bg_out(41:51,1:5)));
amp2_start(4)=nanmean(nanmean(c5_2912e_bg_out(41:51,1:5)));
amp2_start(5)=nanmean(nanmean(c4_2912k_bg_out(41:51,1:5)));
amp2_start(6)=nanmean(nanmean(c5_2912k_bg_out(41:51,1:5)));
amp2_start(7)=nanmean(nanmean(c4_0501b_bg_out(41:51,1:5)));
amp2_start(8)=nanmean(nanmean(c5_0501b_bg_out(41:51,1:5)));
amp2_start(9)=nanmean(nanmean(c5_0501c_bg_out(41:51,1:5)));
amp2_start(10)=nanmean(nanmean(c5_0501d_bg_out(41:51,1:5)));

amp2_end(1)=nanmean(nanmean(c4_2912c_bg_out(41:51,end-5:end)));
amp2_end(2)=nanmean(nanmean(c5_2912c_bg_out(41:51,end-5:end)));
amp2_end(3)=nanmean(nanmean(c4_2912e_bg_out(41:51,end-5:end)));
amp2_end(4)=nanmean(nanmean(c5_2912e_bg_out(41:51,end-5:end)));
amp2_end(5)=nanmean(nanmean(c4_2912k_bg_out(41:51,end-5:end)));
amp2_end(6)=nanmean(nanmean(c5_2912k_bg_out(41:51,end-5:end)));
amp2_end(7)=nanmean(nanmean(c4_0501b_bg_out(41:51,end-5:end)));
amp2_end(8)=nanmean(nanmean(c5_0501b_bg_out(41:51,end-5:end)));
amp2_end(9)=nanmean(nanmean(c5_0501c_bg_out(41:51,end-5:end)));
amp2_end(10)=nanmean(nanmean(c5_0501d_bg_out(41:51,end-5:end)));


amp_start(1)=nanmean(nanmean(c4_2912c_circle(41:51,1:5)));
amp_start(2)=nanmean(nanmean(c5_2912c_circle(41:51,1:5)));
amp_start(3)=nanmean(nanmean(c4_2912e_circle(41:51,1:5)));
amp_start(4)=nanmean(nanmean(c5_2912e_circle(41:51,1:5)));
amp_start(5)=nanmean(nanmean(c4_2912k_circle(41:51,1:5)));
amp_start(6)=nanmean(nanmean(c5_2912k_circle(41:51,1:5)));
amp_start(7)=nanmean(nanmean(c4_0501b_circle(41:51,1:5)));
amp_start(8)=nanmean(nanmean(c5_0501b_circle(41:51,1:5)));
amp_start(9)=nanmean(nanmean(c5_0501c_circle(41:51,1:5)));
amp_start(10)=nanmean(nanmean(c5_0501d_circle(41:51,1:5)));

amp_end(1)=nanmean(nanmean(c4_2912c_circle(41:51,end-5:end)));
amp_end(2)=nanmean(nanmean(c5_2912c_circle(41:51,end-5:end)));
amp_end(3)=nanmean(nanmean(c4_2912e_circle(41:51,end-5:end)));
amp_end(4)=nanmean(nanmean(c5_2912e_circle(41:51,end-5:end)));
amp_end(5)=nanmean(nanmean(c4_2912k_circle(41:51,end-5:end)));
amp_end(6)=nanmean(nanmean(c5_2912k_circle(41:51,end-5:end)));
amp_end(7)=nanmean(nanmean(c4_0501b_circle(41:51,end-5:end)));
amp_end(8)=nanmean(nanmean(c5_0501b_circle(41:51,end-5:end)));
amp_end(9)=nanmean(nanmean(c5_0501c_circle(41:51,end-5:end)));
amp_end(10)=nanmean(nanmean(c5_0501d_circle(41:51,end-5:end)));

a=(amp_start+amp_start)/2;
b=(amp_end+amp_end)/2;

ranksum(a,b)
signrank(a-b)
