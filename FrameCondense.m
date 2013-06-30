function [intvals V D S stdv Cnt best_pred] = FrameCondense(nframes, frames, alpha, beta, opt)
intvals = [];
mu = [];
stdv = [];
for i=1:nframes
    for w = 0:int16(nframes)
        if (i+w)<=nframes
            intvals = [intvals; i i+w];
            var = trace(cov(frames(i:i+w,:)))/size(frames,2);
            var = var^0.5;
            mu = [mu; mean(frames(i:i+w,:),1)];
            %var = CalcVariance(frames, i, i+w);
            stdv = [stdv; var];
        end
    end
end
n_intvals = size(intvals,1);
pred = cell(n_intvals,2);
succ = cell(n_intvals,1);
best_pred = zeros(n_intvals,1);
%pred{:,2} = 0;%zeros(n_intvals,1);
V = 100000*ones(n_intvals,1);
S = 100000*ones(n_intvals,1);
D = zeros(n_intvals,1);
Cnt = zeros(n_intvals,1);
for i=1:n_intvals
    start = intvals(i,1);
    stop = intvals(i,2);
    pred{i,1} = find(intvals(:,2)==start-1)';
    succ{i} = find(intvals(:,1)==stop+1)';
end
for i=1:n_intvals
     if isempty(pred{i,1})==1
         V(i) = stdv(i);
         Cnt(i) = 1;
         D(i) = 0;
     end
end
stop = 0;
pass = 1;
finished = 0;
while stop==0
    for i=1:n_intvals
        if isempty(pred{i,1})==1 && isempty(pred{i,2})
            pred{i, 2} = 1;
            finished = finished + 1;
            for j=1:length(succ{i})
                tmpv = (V(i)+stdv(succ{i}(j)))/(Cnt(i)+1);
                v1 = mu(succ{i}(j),:);
                v2 = mu(i,:);
                %corr = v1*v2'/norm(v1)/norm(v2);
                if (opt==1)
                    dist = max(abs(v1-v2));
                    %dist = norm(v1-v2);
                    %dist = (1-corr)/2;
                else
                    dist = norm(v1-v2)/(stdv(i)+stdv(succ{i}(j))+0.01*mean(stdv));
                    %dist = (1-corr)/2/(stdv(i)+stdv(succ{i}(j))+1);
                end
                tmpd = (D(i)+dist)/(Cnt(i)+1);
                if (S(succ{i}(j))>exp(alpha*tmpv)*exp(-beta*tmpd))
                    S(succ{i}(j)) = exp(alpha*tmpv)*exp(-beta*tmpd);
                    V(succ{i}(j)) = V(i)+stdv(succ{i}(j));
                    D(succ{i}(j)) = D(i)+dist;
                    Cnt(succ{i}(j)) = Cnt(i) + 1;
                    best_pred(succ{i}(j)) = i;
                end
                pred{succ{i}(j),1}(pred{succ{i}(j),1}==i) = [];
            end
        end
    end
    if finished==n_intvals 
        stop = 1;
    end
    pass = pass + 1;
end
