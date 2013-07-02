function out = Perturb(remove_prob, noise_level, added_len, seq)
len = length(seq);
out = [];% = zeros(len, size(seq,2));
for c=1:len
    prob = rand(1,1);
    if (prob<=0.1)
        continue;
    elseif (prob<=0.85)
        noise = noise_level*randn(1, size(seq,2));
        out = [out; seq(c,:) + noise];
    else
        noise = noise_level*randn(1, size(seq,2));
        out = [out; seq(c,:) + noise];
        added_cnt = int8(added_len*rand(1,1));
        for j=1:added_cnt
            noise = noise_level*randn(1, size(seq,2));
            out = [out; seq(c,:) + noise];
        end            
    end
end