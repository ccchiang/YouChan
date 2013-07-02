function [ref_seq test_seq start_pos end_pos] = GenSample(nsamples)
nsamples = 1000;
data = GenRand2D(nsamples);
close all;
n_seq = 50;
avg_seq_len = 100;
noise_scale = 0.03;
added_len = 3;
avg_test_len = 10;
min_test_len = 10;
remove_prob = 0;
seq = cell(n_seq, 1);
for n=1:50
    len = int8(avg_seq_len*rand(1,1))+25;
    seq{n} = max(int16(nsamples*rand(1, len)),1);
end
id = max(int16(n_seq * rand(1,1) ),1);
ref_seq = data(seq{id},:);
start_pos = int8(length(seq{id})*rand(1,1))+1;
end_pos = int8(min(start_pos + avg_test_len * rand(1,1) + min_test_len, length(seq{id}))); 
tmp_seq = ref_seq(start_pos:end_pos,:)
test_seq =Perturb(remove_prob, noise_scale, added_len, tmp_seq);