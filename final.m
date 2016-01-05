function f = final( no_of_qpts,tot,k_max, cl, beta, d, b, w, rad )
    %------------------------------Summary-----------------------------------

       %this function is for query searching multiple query points
       %and at the end it ouputs the mean over all ratio for those points 

    %------------------------------Input-------------------------------------

        %no_of_qpts = number of query points;
        %tot        = the number of nearest points that we need to output  
        %k_max      = maximum number of clusters allowed
        %cl         = number of clusters the data is clustered
        %beta       = beta threshold 
        %d          = dimensions of the data
        %b          = constant in hash function
        %w          = constant in hash function 
        %rad        = radius 

    %-------------------------------Output------------------------------------

        %we get the mean mor of all points
      
    %------------------------------------------------------------------------ 

    
    qur = load('querydat.mat');
    qur = qur.v;
    qur = qur';
    data = load('data.mat');
    data = data.v;
    data = data';
    f = 0;
    tavg = 0;
    %for each point the moris calculated
    for i = 1:no_of_qpts
       % fprintf('Searching for query point %d\n', i);
        qt = qur(i,:);
        %disp(qt);
        t = cputime;
        pt = search( qt , cl , k_max , beta , tot , d , b, w, rad);
        no_of_pts = size(pt);
        t1 = cputime - t;
        fprintf('Time taken for query %d is %f seconds\n', i, t1);
        tavg = tavg + t1;
        %fprintf('search Completed\n');
        act = actual(data , tot , qt );
        %fprintf('Got Actual points \n');
        mo = mor(act , pt , qt );
        f = f+mo;
        fprintf('MOR for query point %d is %d\n', i, mo);
        fprintf('\n\n');
        %disp(f);
    end
     
    f = f/no_of_qpts;
    tavg = tavg/no_of_qpts;
    fprintf('Average time for a query is %f seconds\n', tavg);
    %fprintf('mor after %d query points is %d\n', i, f);

end

