function bin = Dec2SingPrec(dec)
% Author: Raymart Jay E. Canoy
% Date: 09 September 2020
if dec == 0
    bin = num2str(zeros(1, 32));
else
    %%%%%%%%%%%%%%%%%%%%%%%%%sign%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    if dec < 0 
        s = [1]; % s = 1 
    else
        s = [0]; % s = 0
    end
    
    dec = abs(dec); % the sign is ignored
    
    %%%%%%%%%%%%%%%%whole number%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    whole_number = floor(dec);
    
    
    w_n = whole_number;
    i = 1;
    while (1)
        w_n_2(i) = mod(w_n, 2);
        w_n = floor(w_n / 2);
        i = i + 1;
        if w_n == 0, ...
                break, end
    end
    w_n_2 = wrev(w_n_2); % whole number in binary
    l = size(w_n_2); % size of the whole num vect
    
    %%%%%%%%%%%%%%%%%fractional number%%%%%%%%%%%%%%%%%%%%%%%%
    frac_number = dec - whole_number;
    
    f_n = frac_number;
    for i = 1:100
        if (f_n - 2^-i) >= 0
            f_n_2(i) = 1;
            f_n = f_n - 2^(-i);
        else
            f_n_2(i) = 0;
            f_n = f_n;
        end
    end
    
    %%%%%%%%%%%%%%%%%%%%%exponent%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    if whole_number ~= 0
        e = l(2) - 1; % (true exp) going to the left: pos 
        k = e + 127; % biased exponent
        
        %%%%%%%%%%%%%%%%significand%%%%%%%%%%%%%%%%%%%%%%%%%%
        index = [2: l(2)];
        d = [w_n_2(index) f_n_2];
       
        %%%%%considers dec num whose whole num is zero%%%%%%%
    else
        %go through the values of f_n_2 to look for the 1st 1
        m = 1;
        while(1)
            if f_n_2(m) == 1, break, end
            m = m + 1;
        end
        %true exp = index of 1st 1
        e = -m; % (true exp) going to the right: neg
        k = e + 127; %biased expoenent
        
        %%%%%%%%%%%%%%%%significand%%%%%%%%%%%%%%%%%%%%%%%%%%
        
        len_f_n = size(f_n_2); % len of frac number in bin
        index_l_f_n = [m + 1: len_f_n(2)];%from num after 1
        f_n_2 = f_n_2(index_l_f_n);
        
        d = f_n_2; %significand contains bits from frac num
    end
    
    %%%%%%%%%%%%converts exp to bin%%%%%%%%%%%%%%%%%%%%%%%%%
    k_loop = k;
    k_2 = zeros(1, 8); % k_2 is set to contain 8 elements
    j = 1;
    while (1)
        k_2(j) = mod(k_loop, 2);
        k_loop = floor(k_loop / 2);
        j = j + 1;
        if k_loop == 0, break, end
    end
    
    k_2 = wrev(k_2); % biased exp in binary
   
    %%%%%%%%%%%IEEE 754 single precision%%%%%%%%%%%%%%%%%%%%%
    index_sig = [1 : 23];
    bin = num2str([s k_2 d(index_sig)]);
end
end