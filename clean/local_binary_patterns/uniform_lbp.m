function [ uniform_code ] = uniform_lbp( code , number_bits, is_fourier )
%uniform_lbp Maps a binary code to a uniform codeword
%Creates uniform local binary patterns for 8 bits
% The function assumes that number_bits is always constant as the look-up 
% table is a persistent variable (it is computed once and then re-used, much 
% like a static variable in C). 
% So, if you call it with number_bits = 8, and then with 16, things 
% are going to go wrong

% The thing is, I want to be able to index 0 as well. So I map everything
% one up. Ie for 0, index table at 1. For 15, index table at 16

% Reference to
% http://stackoverflow.com/questions/7603608/how-to-implement-uniform-lbp?lq=1.
% The solution posted there had an error, so I commented about that as well
% on the site

% Default is to assume that we are working with 8 bit strings
if (nargin < 2)
   number_bits = 8; 
end

if (nargin < 3)
	is_fourier = 0;
end

persistent lutable
if isempty(lutable)
    % Generate the lookup table
     
     if (~is_fourier)

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

	% This is the look-up table created according to Appendix A.2
	% It is the codeword mapping needed for Fourier LBP
	% It does not make a difference to Uniform LBP - The only reason we make the distinction is that we used the previous code for other experiements
	% The look-up table was actually calculated with the Python script, uniform_lbp.py
	else (is_fourier)
    	lutable = [1, 2, 3, 10, 4, 0, 11, 18, 5, 0, 0, 0, 12, 0, 19, 26, 6, 0, 0, 0, 0, 0, 0, 0, 13, 0, 0, 0, 20, 0, 27, 34, 7, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 14, 0, 0, 0, 0, 0, 0, 0, 21, 0, 0, 0, 28, 0, 35, 42, 8, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 15, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 22, 0, 0, 0, 0, 0, 0, 0, 29, 0, 0, 0, 36, 0, 43, 50, 9, 17, 0, 25, 0, 0, 0, 33, 0, 0, 0, 0, 0, 0, 0, 41, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 49, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 57, 16, 24, 0, 32, 0, 0, 0, 40, 0, 0, 0, 0, 0, 0, 0, 48, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 56, 23, 31, 0, 39, 0, 0, 0, 47, 0, 0, 0, 0, 0, 0, 0, 55, 30, 38, 0, 46, 0, 0, 0, 54, 37, 45, 0, 53, 44, 52, 51, 58];
    end
end

uniform_code = lutable( uint16(code)+1 );

end

function b = isUniformLBP(bits)
    b = nnz(diff(bits([1:end, 1]))) <= 2;
end


