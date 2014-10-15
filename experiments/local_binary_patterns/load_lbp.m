resize_factor = 1;
rows = 2;
cols = 16;

for i = 1:length(v1)
    
    lbp = local_binary_patterns(v1(i).vein);
    lbp = uint8(lbp);
    v1(i).lbp = lbp;
    
    %v1(i).lbp = get_lbp(v1(i).filename, resize_factor);
    v1(i).ulbp = uniform_lbp(v1(i).lbp);
    %veins(i).ulbp_hist = hist (veins(i).ulbp(:), [0:1:58]); % We know uniform lbp has 59 bins
    v1(i).ulbp_hist = grid_histogram(v1(i).ulbp, rows, cols); 
end

for i = 1:length(v1_unreg)
    
    lbp = local_binary_patterns(v1_unreg(i).vein);
    lbp = uint8(lbp);
    v1_unreg(i).lbp = lbp;
    
  %  v1_unreg(i).lbp = get_lbp(v1_unreg(i).filename, resize_factor);
    v1_unreg(i).ulbp = uniform_lbp(v1_unreg(i).lbp);
    %veins_unreg(i).ulbp_hist = hist (veins_unreg(i).ulbp(:), [0:1:58]); % We know uniform lbp has 59 bins
    v1_unreg(i).ulbp_hist = grid_histogram(v1_unreg(i).ulbp, rows, cols); 
end

save veins v1
save veins_unreg v1_unreg