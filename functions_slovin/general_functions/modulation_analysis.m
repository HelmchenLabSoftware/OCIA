


circ_mod_contour=[mean(mean(mod1111c1(roi_contour2,:))) mean(mean(mod1111c2(roi_contour2,:)))...
    mean(mean(mod1111d1(roi_contour2,:))) mean(mean(mod1111d2(roi_contour2,:)))];
circ_mod_noncontour=[mean(mean(mod1111c4(roi_contour2,:))) mean(mean(mod1111c5(roi_contour2,:)))...
    mean(mean(mod1111d4(roi_contour2,:))) mean(mean(mod1111d5(roi_contour2,:)))];

bg_mod_contour=[mean(mean(mod1111c1(roi_maskin,:))) mean(mean(mod1111c2(roi_maskin,:)))...
    mean(mean(mod1111d1(roi_maskin,:))) mean(mean(mod1111d2(roi_maskin,:)))];
bg_mod_noncontour=[mean(mean(mod1111c4(roi_maskin,:))) mean(mean(mod1111c5(roi_maskin,:)))...
    mean(mean(mod1111d4(roi_maskin,:))) mean(mean(mod1111d5(roi_maskin,:)))];


V2_mod_contour=[mean(mean(mod1111c1(roi_V21111,:))) mean(mean(mod1111c2(roi_V21111,:)))...
    mean(mean(mod1111d1(roi_V21111,:))) mean(mean(mod1111d2(roi_V21111,:)))];
V2_mod_noncontour=[mean(mean(mod1111c4(roi_V21111,:))) mean(mean(mod1111c5(roi_V21111,:)))...
    mean(mean(mod1111d4(roi_V21111,:))) mean(mean(mod1111d5(roi_V21111,:)))];



circ_mod_contour=[circ_mod_contour mean(mean(mod1203f1(roi_contour,:)))];
circ_mod_noncontour=[circ_mod_noncontour mean(mean(mod1203f5(roi_contour,:)))];

bg_mod_contour=[bg_mod_contour mean(mean(mod1203f1(roi_bg_in,:)))];
bg_mod_noncontour=[bg_mod_noncontour mean(mean(mod1203f5(roi_bg_in,:)))];

V2_mod_contour=[V2_mod_contour mean(mean(mod1203d1(roi_V21203,:))) mean(mean(mod1203e1(roi_V21203,:)))...
     mean(mean(mod1203f1(roi_V21203,:)))];
V2_mod_noncontour=[V2_mod_noncontour mean(mean(mod1203d5(roi_V21203,:))) mean(mean(mod1203e5(roi_V21203,:)))...
     mean(mean(mod1203f5(roi_V21203,:)))];

