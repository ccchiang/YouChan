function [out sorted_scores] = RemoveRedundant(len, scalefactor1, scalefactor2, endpoints, scores)
flag = endpoints(:,1)<endpoints(:,2);
endpoints = endpoints(flag,:);
scores = scores(flag);
len_cond = ((endpoints(:,2)-endpoints(:,1)+1)<=scalefactor1*len)& ...
    ((endpoints(:,2)-endpoints(:,1)+1)>scalefactor2*len);
endpoints = endpoints(len_cond,:);
scores = scores(len_cond);
[sorted_scores index] = sort(scores);
sorted_cands = endpoints(index,:);
stop = 0;
flag = ones(length(scores), 1);
condition = zeros(length(scores), 1);
k = 1;
while (stop~=1) 
    while (k<=length(scores)&&~flag(k))
        k = k + 1;
    end
    if (k>length(scores))
        break;
    elseif (k==length(scores))
        stop = 1;
    end
    intv = sorted_cands(k,:);
    bnd1 = min(sorted_cands(:,2),intv(2));
    bnd2 = max(sorted_cands(:,1),intv(1));
    cand_len = sorted_cands(:,2)-sorted_cands(:,1)+1;
    dur = bnd1-bnd2+1;
    len = (intv(2)-intv(1)+1);
    th = min(cand_len, len)*0.33;
    self = zeros(length(scores), 1);
    self(k) = 1;
    flag = (~(dur>th|dur==cand_len)&flag)|self;
    k = k + 1;
end
out = sorted_cands(flag,:);
sorted_scores = sorted_scores(flag);