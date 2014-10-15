function [ skeleton, vein_branch ] = get_skeleton( image )
%get_skeleton Returns skeleton of the vein image
%   Detailed in Chapter 4.2
%   Makes use of MATLAB's mathematical morphology functions

skeleton = bwmorph (image, 'dilate');
skeleton = bwmorph (skeleton, 'thin', Inf);
skeleton = bwmorph (skeleton, 'fill');

vein_branch = bwmorph (skeleton, 'branchpoints');

end

