function array = populate(indices, size, veins)
    array = zeros(size(1), size(2));
    count = 1;
    for i=indices
        temp = veins(i).ulbp_hist;
        temp = temp';
        array(count,:) = temp(:)';
        count = count + 1;
    end
end