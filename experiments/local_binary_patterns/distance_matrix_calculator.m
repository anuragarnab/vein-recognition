for r = [1 2 4]
    for c = [1 2 4 8 12 16 32]
        
        fprintf('Row: %d Col: %d\n', r, c)
        
        rows = r;
        cols = c;
        load_lbp_paramless;
        distance_matrix;
        distance_matrix_imposters;
        
        fname = strcat('r',num2str(rows),'c',num2str(cols));
        save (fname, 'distances_ulbp_chi', 'imp_distances_ulbp_chi');
        
    end
end
