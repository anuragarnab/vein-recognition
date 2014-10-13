dm = zeros(100,1);

for i=1:600
    dm(i) = mhd_fast([veins(i).x veins(i).y], [veins(1).x veins(1).y], 1);
end