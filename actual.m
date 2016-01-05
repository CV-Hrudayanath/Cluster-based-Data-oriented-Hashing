function act = actual(data, k, q)
    %------------------------------Summary-----------------------------------

       %this actually return the real k nearest points for a given data 

    %------------------------------Input-------------------------------------

    	%data   = data  all the dataset n x dimension 
        %k      =  the number of nearest points we need to output
        %q      = query point 1 x dimension 

    %-------------------------------Output------------------------------------

    	%we get the exact k nearest points we need to output 
      
    %------------------------------------------------------------------------ 

    idx = knnsearch(data, q, 'k', k);

    act = [];
    for i = 1:k
        id = idx(i);
        act = [act; data(id, :)];
    end
end

