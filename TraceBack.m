function [intvs scores sc]= TraceBack(intv, V, D, S, Cnt, pred, alpha, beta)
n_frames = max(intv(:,2));
cand_end = find(intv(:,2)==n_frames);
%cand_end = cand_end(Cnt(cand_end)>1);
intvs = cell(length(cand_end), 1);
scores = zeros(length(cand_end), 1);
sc = zeros(length(cand_end), 1);
cnts = zeros(length(cand_end), 1);
for i=1:length(cand_end)
    fend = cand_end(i);
    cnts(i) = Cnt(fend);
    scores(i) = exp(alpha*V(fend)/cnts(i))*exp(-beta*D(fend)/cnts(i));
    sc(i) = S(fend);
    list = [fend];
    p = pred(fend);
    while ~(p==0)
        list = [p list];
        p = pred(p);
    end
    intvs{i} = list;
end
