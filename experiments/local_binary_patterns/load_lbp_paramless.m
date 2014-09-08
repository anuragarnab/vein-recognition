resize_factor = 1;
% rows = 2;
% cols = 16;
% rows and cols are now set by an external script! (yes this is very hacky)

for i = 1:length(veins)
    veins(i).lbp = get_lbp(veins(i).filename, resize_factor);
    veins(i).ulbp = uniform_lbp(veins(i).lbp);
    %veins(i).ulbp_hist = hist (veins(i).ulbp(:), [0:1:58]); % We know uniform lbp has 59 bins
    veins(i).ulbp_hist = grid_histogram(veins(i).ulbp, rows, cols); 
end

for i = 1:length(veins_unreg)
    veins_unreg(i).lbp = get_lbp(veins_unreg(i).filename, resize_factor);
    veins_unreg(i).ulbp = uniform_lbp(veins_unreg(i).lbp);
    %veins_unreg(i).ulbp_hist = hist (veins_unreg(i).ulbp(:), [0:1:58]); % We know uniform lbp has 59 bins
    veins_unreg(i).ulbp_hist = grid_histogram(veins_unreg(i).ulbp, rows, cols); 
end

save veins veins
save veins_unreg veins_unreg