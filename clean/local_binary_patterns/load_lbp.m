% Loads Local Binary Pattern features
% In Figure 6.6 of the report, we showed that Fourier LBP features are computed from Uniform LBP which themselves are computed from Canonical LBP
% Hence, this script first calculates Canonical LBP, then Uniform LBP from this, and finally Fourier LBP

resize_factor = 1;
rows = 2;
cols = 16;

for i = 1:length(veins)
    
    lbp = local_binary_patterns(veins(i).vein);
    lbp = uint8(lbp);
    veins(i).lbp = lbp;
    
    veins(i).ulbp = uniform_lbp(veins(i).lbp, 8, 1);
    veins(i).ulbp_hist = grid_histogram(veins(i).ulbp, rows, cols); 
    veins(i).flbp = fourier_lbp(veins(i).ulbp_hist); 

end

for i = 1:length(veins_unreg)
    
    lbp = local_binary_patterns(veins_unreg(i).vein);
    lbp = uint8(lbp);
    veins_unreg(i).lbp = lbp;
    
    veins_unreg(i).ulbp = uniform_lbp(veins_unreg(i).lbp, 8, 1);
    veins_unreg(i).ulbp_hist = grid_histogram(veins_unreg(i).ulbp, rows, cols); 
    veins_unreg(i).flbp = fourier_lbp(veins_unreg(i).ulbp_hist); 

end
