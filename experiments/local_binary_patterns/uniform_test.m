values = cell(1,59);

for i = 0:255
    lbp = uniform_lbp(i);
    
    idx = lbp;
    if (lbp == 0)
       idx = 59; 
    end
   
    values{idx} = [values{idx} ; i];
end