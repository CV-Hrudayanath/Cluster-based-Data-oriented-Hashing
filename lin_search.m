function lin = lin_search(data, tot, p)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
pt = [];
heap = MaxHeap(tot);
cnt = 0;
sz = size(data);
sz = sz(1);
for dt = 1:sz
    ap = pdist2(p, data(dt, :));
    %fprintf('ap : %d idx : %d\n', ap, idx);
   if cnt < tot
       heap.InsertKey([ap, dt]);
       cnt = cnt+1;
   else
       du = heap.ReturnMax();
       if du(1) > ap
           %fprintf('%d\n', dt);
          dk = heap.ExtractMax();
          heap.InsertKey([ap, dt]);
       end
   end
end

for dt = 1:cnt
    dum = heap.ExtractMax();
    idx = dum(2);
    %pt1 = data(idx, :);
   % fprintf('%d\n', idx);
    pt(cnt-dt+1)  = idx;
end
lin = pt;
end

