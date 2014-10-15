function [ angle ] = angle_function( v1, v2 )
%angle_function Get angle between two vectors
% This works out the angle of the difference vector
% between two input vectors v1 and v2
% When defining the angle, we always take our difference vector b - a, such
% that b has the greater x value

if (v1 == v2)
   angle = 0;
   return
end

if ( v1(1) > v2(1) )
   b = v1;
   a = v2;
else
   a = v1;
   b = v2;
end

if (v1(1) == v2(1) )
   if (v1(2) > v2(2) )
      b = v1;
      a = v2;
   else
      b = v2;
      a = v1;
   end
end


difference = b - a;
angle = atan ( difference(2) / difference(1) );


end

