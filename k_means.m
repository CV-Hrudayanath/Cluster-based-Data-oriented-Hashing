function h = k_means(data, k, d, n)
        %------------------------------Summary-----------------------------------
            
            %The data read from the file (data.mat) is now clustered using K-means
            %in this function

        %------------------------------Input-------------------------------------

            %k = number of clusters the data must be divided
            %d = dimension of the tuples
            %n = number oftuples
            %data = vector of size n x d

        %-------------------------------Output-----------------------------------
        
            %This creates k files i format cluster(number).mat; number = [1, k];
            %Example :- if k = 3 then generated files are
            %           cluster1.mat
            %           cluster2.mat
            %           cluster3.mat

        %------------------------------------------------------------------------

%Clustering data and  c ->centres of k clusters
[idx c] = kmeans(data, k);

%saving cluster centers as centers.mat 
save('centers.mat','c');

clu = {};
for i = 1:k
    clu{i} = [];
end

%Storing the tuples as per clusters 
for i = 1:n
   po = idx(i);
   clu{po} = [clu{po}; data(i, :)];
end

%Saving each cluster as cluster(number).mat number = [1, k] 
fil = 'cluster';

%Each Iteration one cluster.mat is formed
for i = 1:k
    fi = clu{i};
    sz = size(clu{i});
    sz = sz(2);
    sz = sz/d;
    %fi = reshape(tem, [sz, d]);
    nm = strcat(fil, num2str(i));
    nm = strcat(nm, '.mat');
    save(nm, 'fi');
    
end
h = 1;
end

