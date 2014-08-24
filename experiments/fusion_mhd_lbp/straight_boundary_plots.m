figure
mesh (mhd_threshes, lbp_threshes, corrects)
xlabel('mhd thresholds');
ylabel('lbp thresholds');
zlabel('corrects');

figure
mesh (mhd_threshes, lbp_threshes, correct_negs)
xlabel('mhd thresholds');
ylabel('lbp thresholds');
zlabel('correct negatives');

figure
mesh (mhd_threshes, lbp_threshes, total)
xlabel('mhd thresholds');
ylabel('lbp thresholds');
zlabel('total');

a = corrects(:);
eer = a ( corrects(:) == correct_negs(:) )