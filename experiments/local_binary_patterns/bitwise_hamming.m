%BITWISE_HAMMING Compute all hamming distances between two sets of bit vectors
%
%   C = bitwise_hamming(A, B)
%
% Given two sets of bit vectors (each column being a bit vector), compute
% the hamming distances between all pairs of vectors between the two sets.
%
%IN:
%   A - MxP matrix of bit vectors.
%   B - MxQ matrix of bit vectors.
%
%OUT:
%   C - PxQ matrix of bitwise hamming distances.

function C = bitwise_hamming(A, B)

% Get the input sizes
[a, a] = size(A);
[b, b] = size(B);

% Typecast to uint8
A = reshape(typecast(A(:), 'uint8'), [], a);
B = reshape(typecast(B(:), 'uint8'), [], b);
assert(size(A, 1) == size(B, 1), 'Input columns must be of the same bit-length');

% Initialize the output
C = zeros(a, b, 'uint32');

% Do the smallest for loop
if b > a
    I = ones(1, b);
    for i = 1:a
        C(i,:) = bitcount(bitxor(A(:,I), B));
        I = I + 1;
    end
else
    I = ones(1, a);
    for i = 1:b
        C(:,i) = bitcount(bitxor(B(:,I), A))';
        I = I + 1;
    end
end
end
