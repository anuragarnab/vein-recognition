chosen = 4;

for j = 1:length (veins)
    [score, matches] = compare_distances (veins(chosen).distances, veins(j).distances, veins(chosen).angles, veins(j).angles, 1, 0.05);
[matches, score]
end