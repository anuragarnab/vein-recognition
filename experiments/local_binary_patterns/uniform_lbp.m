function [ uniform_code ] = uniform_lbp( code , number_bits )
%UNTITLED2 Maps a binary code to a uniform codeword
%Creates uniform local binary patterns for 8 bits
% The function assumes that number_bits is always constant. Ie, if you call
% it with number_bits = 8, and then with 16, things are going to go wrong

% The thing is, I want to be able to index 0 as well. So I map everything
% one up. Ie for 0, index table at 1. For 15, index table at 16

% Thanks to 

if (nargin < 2)
   number_bits = 8; 
end

persistent lutable
if isempty(lutable)
    % Generate the lookup table
    lutable = zeros(2^number_bits,1);
    next_label = 1;
    for k = 0:2^number_bits-1
       bits = bitand(k, 2.^(0:number_bits-1)) > 0;
       
       if isUniformLBP(bits)
          lutable(k+1) = next_label;
          next_label = next_label+1;
       else
          lutable(k+1) = 0;
       end
    end
end

uniform_code = lutable(code+1);

end

function b = isUniformLBP(bits)
    b = nnz(diff(bits([1:end, 1]))) <= 2;
end


