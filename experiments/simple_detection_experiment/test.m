v11 = get_vein('p11.jpg');
v12 = get_vein('p12.jpg');
v21 = get_vein('p21.jpg');
v22 = get_vein('p22.jpg');
v31 = get_vein('p31.jpg');
v32 = get_vein('p32.jpg');

chosen = v12;

cross_corr_normalised (chosen, v11)
cross_corr_normalised (chosen, v12)
cross_corr_normalised (chosen, v21)
cross_corr_normalised (chosen, v22)
cross_corr_normalised (chosen, v31)
cross_corr_normalised (chosen, v32)