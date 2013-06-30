function out = Perturb(remove_prob, noise_level, added_len, seq)
len = length(seq);
out = [];% = zeros(len, size(seq,2));
for i=1:len
    prob = rand(1,1);
    if (prob<=remove_prob)
        continue;
    else
        noise = noise_level*rand(1, size(seq,2));
        out = [out; seq(i,:) + noise];
        added_cnt = int8(added_len*rand(1,1));
        for j=1:added_cnt
            noise = noise_level*rand(1, size(seq,2));
            out = [out; seq(i,:) + noise];
        end            
    end
end