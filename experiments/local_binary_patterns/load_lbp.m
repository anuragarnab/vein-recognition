resize_factor = 0.5;

for i = 1:length(veins)
    veins(i).lbp = get_lbp(veins(i).filename, resize_factor);
end