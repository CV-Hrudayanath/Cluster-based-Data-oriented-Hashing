function mo = mor(real, result , p)
    %------------------------------Summary-----------------------------------

       %the mean over all ratio is calculated here its formula is in the paper 

    %------------------------------Input-------------------------------------

    	%real   = the exact points for the query p 
        %result      =  the points we got for query p
        %q      = query point q

    %-------------------------------Output------------------------------------

    	%The mean overall ratio 
      
    %------------------------------------------------------------------------ 

sz = size(result);
%disp(sz);
dim = sz(2);
k = sz(1);
mo = 0;

for  i = 1:k
   ori = real(i, :);
   gt = result(i,:);
   d1 = pdist2(p, ori);
   gt = single(gt);
   d2 = pdist2(p, gt);
   if d1 == 0
       continue;
   end
   mo = mo + d2/d1;
end

mo = mo/k;
end

 