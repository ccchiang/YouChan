format long e;
nsamples = 1000;
data = GenRand2D(nsamples);
[IDX,C] = kmeans(data,20);
color = 'rgby';
close all;
% hold on
% for i=1:3
%     plot(data([IDX==i],1), data([IDX==i], 2), [color(i) '.']);
% end
% hold off
n_seq = 50;
avg_seq_len = 100;
noise_scale = 0;
added_len = 0;
avg_test_len = 10;
min_test_len = 10;
seq = cell(n_seq, 1);
for n=1:50
    len = int8(avg_seq_len*rand(1,1))+25;
    seq{n} = int16(nsamples*rand(1, len))+1;
end
id = int16(n_seq * rand(1,1) );
ref_seq = data(seq{id},:);
start_pos = int8(length(seq{id})*rand(1,1))+1;
end_pos = int8(min(start_pos + avg_test_len * rand(1,1) + min_test_len, length(seq{id}))); 
tmp_seq = ref_seq(start_pos:end_pos,:)
test_seq =Perturb(0, noise_scale, added_len, tmp_seq);
LD = simmx(test_seq', ref_seq');
[p q D] = dp(LD);
[end_list d1] = FindEnd(D(end,:))
[start_list d2] = FindStart(test_seq, ref_seq, end_list);
start_list = end_list - start_list + 1;
cand_list = [start_list' end_list' (1000*(d1+d2))']
best = cand_list(find(cand_list(:,3)==min(cand_list(:,3))),:)