


fg1=c1_2912c_cccirc_circle-c1_2912c_ccbg_bg;
fg2=c2_2912c_cccirc_circle-c2_2912c_ccbg_bg;
fg4=c4_2912c_cccirc_circle-c4_2912c_ccbg_bg;
fg5=c5_2912c_cccirc_circle-c5_2912c_ccbg_bg;

fg1_2=c1_0501b_cccirc_circle-c1_0501b_ccbg_bg;
fg2_2=c2_0501b_cccirc_circle-c2_0501b_ccbg_bg;
fg4_2=c4_0501b_cccirc_circle-c4_0501b_ccbg_bg;
fg5_2=c5_0501b_cccirc_circle-c5_0501b_ccbg_bg;

fg1_3=c1_0501c_cccirc_circle-c1_0501c_ccbg_bg;
fg5_3=c5_0501c_cccirc_circle-c5_0501c_ccbg_bg;

fg1_4=c1_0501d_cccirc_circle-c1_0501d_ccbg_bg;
fg5_4=c5_0501d_cccirc_circle-c5_0501d_ccbg_bg;


fg_co=cat(2,fg1,fg2,fg1_2,fg2_2,fg1_3,fg1_4);
fg_no=cat(2,fg4,fg5,fg4_2,fg5_2,fg5_3,fg5_4);


x=(20:10:1130)-240;
figure;errorbar(x,mean(fg_co,2),std(fg_co,0,2)/sqrt(size(fg_co,2)))
hold on
errorbar(x,mean(fg_no,2),std(fg_no,0,2)/sqrt(size(fg_no,2)),'r')
xlim([-100 250])

figure;plot(x,mean(fg_co,2)-mean(fg_no,2))




%%





fgc1=c1_1111c_cccircdiff_circdiff-c1_1111c_ccbg_bg;
fgc2=c2_1111c_cccircdiff_circdiff-c2_1111c_ccbg_bg;
fgc4=c4_1111c_cccircdiff_circdiff-c4_1111c_ccbg_bg;
fgc5=c5_1111c_cccircdiff_circdiff-c5_1111c_ccbg_bg;

fgd1=c1_1111d_cccircdiff_circdiff-c1_1111d_ccbg_bg;
fgd2=c2_1111d_cccircdiff_circdiff-c2_1111d_ccbg_bg;
fgd4=c4_1111d_cccircdiff_circdiff-c4_1111d_ccbg_bg;
fgd5=c5_1111d_cccircdiff_circdiff-c5_1111d_ccbg_bg;

fgh1=c1_1111h_cccircdiff_circdiff-c1_1111h_ccbg_bg;
fgh2=c2_1111h_cccircdiff_circdiff-c2_1111h_ccbg_bg;
fgh4=c4_1111h_cccircdiff_circdiff-c4_1111h_ccbg_bg;
fgh5=c5_1111h_cccircdiff_circdiff-c5_1111h_ccbg_bg;


fg_co=cat(2,fgc1,fgc2,fgd1,fgd2,fgh1,fgh2);
fg_no=cat(2,fgc4,fgc5,fgd4,fgd5,fgh4,fgh5);


x=(20:10:1130)-240;
figure;errorbar(x,mean(fg_co,2),std(fg_co,0,2)/sqrt(size(fg_co,2)))
hold on
errorbar(x,mean(fg_no,2),std(fg_no,0,2)/sqrt(size(fg_no,2)),'r')
xlim([-100 250])

figure;plot(x,mean(fg_co,2)-mean(fg_no,2))
xlim([-100 250])







