function pt = search( p, k, k_max, beta, tot, d, b, w, rad)
    %------------------------------Summary-----------------------------------

        %The nearest tot points is the output of this funtion
        %This function take a point and selects some clusters according to 
        % algo proposed in the paper then the point is hashed into one bucket
        %of each selected cluster and then the nearest tot points are stored 
        %into a MaxHeap and that heap is outputted accordingly to a file output.mat
        %the centres are selected in this way first if k < k_max then beta of each cluster is 
        %calculated and clusters who have beta less than a threshold are selected
        %if k > k_max then centers are hashed into buckets and point is hashed and the bucket in 
        %which the point goes is selected

    %------------------------------Input-------------------------------------

        %p    = query point size 1 x dimension
        %k    = number of clusters
        %k_max = max number of clusters allowed
        %beta = Threshold shown in paper
        %tot = total number of nearest tuples we need to output
        %d   = dimension  of tuples
        %b = hashing function constant
        %w = hashing func constant
        %rad = radius as given in paper

    %-------------------------------Output------------------------------------

      %output is a file output.mat which contains contains the nearest neighbours to the 
      %query point 

    %------------------------------------------------------------------------ 

pt = zeros(tot, d);
dis = zeros(tot, 1);
dist = [];
cntrs = [];
dtot = 0;

%fprintf('w val : %d\n', w);
%if clusters are less than k_max some clusters are selected at the end of this if statment
if k <= k_max
    ct = load('centers.mat');
    ct = ct.c;
    sz = size(ct);
    sz = sz(1);
    for i = 1:sz
        %dum = pdist2(p, ct{i});
        dum = pdist2(p,ct(i,:));
        dist = [dist, dum];
        dtot = dtot + dum;
    end
    for i = 1:sz
       %bet = dist{i}/dtot;
       bet = dist(i)/dtot;
       %disp(bet);
       if bet <= beta
           cntrs = [cntrs, i];
       end
    end
else

    %if clusters are greater than k_max  
  ce = load('cen.mat');
  ce = ce.a;
  sa = size(ce);
  sa = sa(1);
  d2 = 'wh';
  for bt = 1:sa
     d1 = floor((dot(ce(bt,:), p)+b)/w)+1;
     d3 = num2str(d1);
     d2 = strcat(d2, d3);
  end
  d2 = strcat(d2, '.mat');
  d2 = load(d2);
  d2 = d2.fi;
  sa1 = size(d2);
  sa1 = sa1(1);
  for bt = 1:sa1
      bk = d2(bt);
      cntrs = [cntrs, bk];
  end
end
  

sz = size(cntrs);
sz = sz(2);
fprintf('Clusters Selected are %d out of %d\n', sz, k);
%pause();
opt = [];
%fprintf('loop started\n');
%In each iteration one bucket is selected from one cluster and the near points are selected
for i = 1:sz
   % disp(b);
   ce = cntrs(i);
   st = strcat('a', num2str(ce));
   st = strcat(st, '.mat');
   aval = load(st);
   aval = aval.a;
   dp = size(aval);
   dp = dp(1);
   bnum = 'c';
   bnum = strcat(bnum, num2str(ce));
   bnum = strcat(bnum, 'h');
   for j = 1:dp
    dum = floor((dot(aval(j, :), p)+b)/w)+1;
    %disp(j);
    %dum = floor((dot(aval(j,:),p) + b) /10) +1;
    dum = num2str(dum);
    bnum = strcat(bnum, dum);
   end
   %disp(bnum);
   bnum = strcat(bnum, '.mat');
   try
       temp = load(bnum);
   catch
       disp('File not found');
      % disp(i);
       %disp(bnum);
       continue;
   end
   temp = temp.fi;
   sz = size(temp);
   sz = sz(1);
   for dt = 1:sz
       %disp(pdist2(p,temp(dt,:))); 
       if pdist2(p, temp(dt, :)) < rad
          opt = [opt; temp(dt, :)]; 
          
       end
   end
   fprintf('Cluster Number %d and Bucket name %s - Size %d\n', ce,bnum,sz);
end


heap = MaxHeap(tot);
cnt = 0;
sz = size(opt);
sz = sz(1);
fprintf('Number of selcted points i.e less than radius are %d\n',sz);
%pause();
%disp(sz);
%Top tot points are selected using a max heap
for dt = 1:sz
    ap = pdist2(p, opt(dt, :));
    %disp(ap);
   if cnt < tot
       %ap = pdist2(p, opt(dt, :));
       %disp(ap);
       heap.InsertKey([ap, dt]);
       cnt = cnt+1;
   else
       du = heap.ReturnMax();
       if du(1) > ap
          dk = heap.ExtractMax();
          heap.InsertKey([ap, dt]);
       end
   end
end
fprintf('Finally selected points %d\n', cnt);
%pause();
%disp(cnt);

%outputting the nearest points 
for dt = 1:cnt
    dum = heap.ExtractMax();
    %disp(dum(1));
    %fprintf('idx is %d \n distance is %f \n' , dum(2), dum(1));
    idx = dum(2);
    pt1 = opt(idx, :);
    %disp(idx);
    pt(cnt-dt+1, :)  = pt1;
end
%disp(pt);
save('output.mat', 'pt');
end

