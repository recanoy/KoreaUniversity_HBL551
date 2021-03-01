function dec = SingPrec2Dec(bin)
% Author: Raymart Jay E. Canoy
% Date: 09 September 2020
format long
bin = bin(~isspace(bin)); % remove spaces
bits = bin(:) - '0';
len = size(bits);

% This is done because zeros(1,32) won't give an accurate ans
zero = ['00000000000000000000000000000000'];
zer = zero(:) - '0';

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%32 bits%%%%%%%%%%%%%%%%%%%%%%%%%
if len(1) == 32
    if bits == zer % this guarantees ['000...0']_2 = (0)_10
        dec = 0;
        
    else
        s = bits(1);
        k = bits(2:9); % 8 bins are allocated for exp
        d = bits(10:32); % 23 bins for the significand
   
        %%%%%%%%%%%%%%%%%%%%%%%%%exponent%%%%%%%%%%%%%%%%%%%%%%%%
        for i = 1:8
            if (s == 1 | s == 0) & (k(i) == 1 | k(i) == 0)
                k_i(i) = k(i) * 2 ^ (8-i); 
            else
                error('a bit can only be 0 or 1')
            end
        end
    
        %%%%%%%%%%%%%%%%%%%%%%%%%significand%%%%%%%%%%%%%%%%%%%%%
        for i = 1:23
            if d(i) == 1 | d(i) == 0
                d_i(i) = d(i) * 2 ^ (-i);
            else
                error('a bit can only be 0 or 1')
            end 
        end
    
        %%%%%%%%%%%%%%%%%%%%%%%%%values in decimal%%%%%%%%%%%%%%%
        k_10 = sum(k_i);
        d_10 = sum(d_i);
    
        format long g
        %%%%%%%%%%%%%%%%%%%%%%%%converted value%%%%%%%%%%%%%%%%%%%%%%%
        dec = ((-1)^(s))*(1 + d_10)*2^(k_10 - 127);
    end
else
    error('Single Precision: bits = 32!')
end