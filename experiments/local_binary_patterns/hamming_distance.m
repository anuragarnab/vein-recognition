function [ distance ] = hamming_distance( a, b )
%UNTITLED11 Summary of this function goes here
%   Assumes "a" and "b" are matrices of uint8's

    distance = bitcount ( bitxor (a(:), b(:) ));

end

% Counts the number of bits set in the binary string A
% Performs this by breaking down the input A, into 8-bit chunks
% The LUT stores the number of bits set per 8-bit chunk
% Once the LUT has been indexed, the answer is recombined
% Reference to Oliver Woodford, 18 November 2013, "Bitcount"
% Code available at 
% http://www.mathworks.com/matlabcentral/fileexchange/44371-bitcount---bitwise-hamming-distance/content//bitcount.m
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
