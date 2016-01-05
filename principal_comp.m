function c = pri_comp (data , clu , n , d , b , w , no_of_pca, flg)
        
      %------------------------------Summary-----------------------------------

          %Each cluster comes into this function and hashed into buckets
          %Hashing is done using PCA hashing
          %Not only the clusters are hashed using this but the centers of clusters 
          %are hashed using this function
          %When you apply princomp(data) where data is n x d then output is a d x d matrix each 
          %column for each dimension. You choose any no_of_pca columns and hash it no_of_pca times
          %These selected columns re called hashing vectors
          %More precisely hashing vectors are bo_of_pca vectors selected from d x d matrix
          %hash funtion : (dot_product(a, p) + b)/w + 1;
          %a is one tuple in hashing vectors
          %when clusters are hashed flg = 1 when centers flg = 0;
          %even these hashing vectors are stored as a(number).mat where number = clu;

      %------------------------------Input-------------------------------------

          %data = vector contains tuples of a cluster
          %clu  = number of the cluster
          %d    = dimension of the tuples
          %b    = a constant used in hashing
          %w    = a constant used in hashing
          %no_of_pca  = number of hashing functions
          %flg = 1 or 0

      %------------------------------Output-------------------------------------

        %if for example  clu = 5 ; no_of_pca = 2 and values that came from
        %hash function gave 3 different values like 11, 22, 21 then files created are
        %         --->c5h11.mat
        %         --->c5h22.mat
        %         --->c5h21.mat
        % also a5.mat is formed
        %if ceneters are hashed then 
        %         --->wh11.mat
        %         --->wh22.mat
        %         --->wh21.mat
        % also cen.mat is formed which contains vectors selected for pca hashing

      %----------------------------------------------------------------------------
c = 1;
buk = [];
%Applying prinipal component on data    
[ coeff ] = princomp(data);

a = [];
%Storing vectors selected for hashing(hashing vectors) in variable a
for i = 1:no_of_pca
  dum = coeff(:, i);
  dum = dum';
  a  =[a; dum];
end


if flg == 1
st = 'a';
else
    st = 'cen';
end


if flg == 1
    st1 = num2str(clu);
    st = strcat(st, st1);
end


st = strcat(st, '.mat');
%Saving as a(number).mat or cen.mat
save(st, 'a');

h = [];
hs  ='';
%Every point is hashed and kept in its respective bucket Each iteration one tuple
for i = 1:n 
   val = data(i, :);
   hs = '';
   for j = 1:no_of_pca
       h{j} = floor((dot(a(j,:), val)+b)/w)+1;
   end
   for k = 1:no_of_pca
       hs = strcat(hs, num2str(h{k}));
   end
   hn = str2num(hs);
   %disp(hn);
   var = size(buk);
   var = var(2);
   if hn > var  
     buk{hn} = [];
   end
   if flg == 1
    buk{hn} = [buk{hn}; val];
   else
      buk{hn} = [buk{hn};i]; 
   end
end


sz = size(buk);
sz = sz(2);
%Each bucket created is stored in respective syntaxes
for i = 1:sz
    if flg == 1
    st = 'c';
    else
        st = 'w';
    end
    sk = size(buk{i});
    sk = sk(2);
    if sk ~= 0
        st1 = num2str(clu);
        if flg == 1
        st = strcat(st, st1);
        end
        st = strcat(st, 'h');
       st1 =  num2str(i);
       st = strcat(st, st1);
       st = strcat(st, '.mat');
       fi = buk{i};
       save(st, 'fi');
    end
end
end


    