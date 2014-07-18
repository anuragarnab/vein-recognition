filename = 'p12.jpg';

vein = get_vein (filename);
vein = bwmorph (vein, 'thin', Inf);
vein = bwmorph (vein, 'fill');

% can do this a few times
% to do -> keep spurring until sum doesnt change anymore

vein = bwmorph (vein, 'spur');
vein = bwmorph (vein, 'spur');
vein = bwmorph (vein, 'spur');

vein_branch = bwmorph (vein, 'branchpoints');

sum ( sum (vein_branch) )

figure
imshow (superimpose_branch (vein, vein_branch));