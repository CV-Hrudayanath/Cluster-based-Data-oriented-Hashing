function r = run_pca(no_of_clu , d , b , w , no_of_pca )
    %------------------------------Summary-----------------------------------

       %this funtion runs pca hashing to all clusters 

    %------------------------------Input-------------------------------------

    	%no_of_clu   = number of clusters our data was divided 
        %d 			 = dimension of the tuples
        %b      	 = hash function constant
        %w  		 = hash function constant
        %no_of_pca	 = number of hash functions used 

    %-------------------------------Output------------------------------------

    	%all the clusters are hashed their corresponding a(number).mat and buckt files re formed 
      
    %------------------------------------------------------------------------ 


%In each iteration one cluster is hashed
for i = 1:no_of_clu
     clu = 'cluster';
     st  = num2str(i);
     clu = strcat(clu, st);
     clu  = strcat(clu, '.mat');
     dat = load(clu);
     dat = dat.fi;
     sz = size(dat);
     sz =  sz(1);
     principal_comp(dat, i, sz, d, b, w, no_of_pca , 1);
end
r = no_of_clu;
end

