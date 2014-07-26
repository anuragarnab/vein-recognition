filenames = ['fv/1/01.jpg' ; 'fv/1/02.jpg' ; 'fv/2/01.jpg' ; 'fv/2/02.jpg' ; 'fv/3/01.jpg' ; 'fv/3/02.jpg' ; 'fv/4/01.jpg' ; 'fv/4/02.jpg'];

veins = {}; % create a struct to store the vein data

for i = 1:size(filenames, 1)
   veins(i).vein = get_vein(filenames(i, :)); 
end

chosen = 3;

for j = 1:size(veins, 2)
    cross_corr_normalised (veins(chosen).vein, veins(j).vein)
end