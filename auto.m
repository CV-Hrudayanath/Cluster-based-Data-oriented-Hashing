function m = auto (filename, queryfile, n, di, k, b, w, no_of_pca, no_of_qpts, tot, k_max, beta, rad)
		%------------------------------Summary-----------------------------------
            
            %All components are runned automatically without any intervention 

        %------------------------------Input-------------------------------------

            %filename  = name of the data file
            %queryfile = name of the query file
            %n 		   = total number of data points
            %di		   = dimension of the data
            %k		   = The number of clusters the data must be clustered
            %b 		   = hash function constant
            %w 		   = hash function constant
            %no_of_pca = number of hash functions used
            %no_of_qpts= number ofquery points
            %tot 	   = total number of nearest points we must return
            %k_max	   = maximum clusters allowed
            %beta	   = beta threshold
            %rad 	   = radius 

        %-------------------------------Output-----------------------------------
        
            %It outputs the mean overall ratio

        %------------------------------------------------------------------------
tf = cputime;
%data reading 
v = read(filename, n, di, 1);
data = v';
fprintf('Done Reading\n');

%k_means for the data
h = k_means(data, k, di, n);
fprintf('Done k_means\n');

%hashing all clusters using PCA hashing
r = run_pca(k , di , b , w , no_of_pca);

fprintf('Done hashing\n');

%reading queries
q = read(queryfile, no_of_qpts, di, 0 );

fprintf('Search starts\n');

%query reading
m = final( no_of_qpts,tot,k_max, k, beta, di, b, w, rad );

final_ti = cputime - tf; 
fprintf('MOR is %d\n', m);
fprintf('Total run time is %f seconds\n', final_ti);
end