%BITCOUNT Count the number of set bits in each column of the input
%
%   B = bitcount(A)
%
% Count the number of set bits in each column of the input array,
% typecast as a bit vector.
%
%IN:
%   A - MxNx... input array.
%
%OUT:
%   B - 1xNx... output array of bit counts.

function A = bitcount(A)

persistent lutable
if isempty(lutable)
    % Generate the lookup table
    lutable = uint32(sum(dec2bin(0:255) - '0', 2));
end

% Convert to an index into the lookup table
sz = size(A);
sz(1) = 1;
A = reshape(uint16(typecast(A(:), 'uint8')) + uint16(1), [], prod(sz));

% Look up the number of set bits for each byte
A = lutable(A);

% Sum the number of set bits per column
A = reshape(sum(A, 1, 'native'), sz);
end
