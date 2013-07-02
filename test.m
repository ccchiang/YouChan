close all;
clear all;
format long;

%% Randomly generate sequences for testing. Comment out the following file
%% reading block if you want to use this block
[ref_seq test_seq start_pos end_pos] = GenSample(1);
true_answer = [start_pos end_pos];

%% Read ref sequence and test sequence from files. Comment out the above
%% random sample generation block if you want to use this block
ref_filename = {'K01test', 'D02test', 'F03test', 'K04test', 'K05test'};
tst_filename = {'K01train_cut69_83', 'D02test_cut19_29', 'C03test_05', 'K04train_cut12_31', 'K05train_cut07_60'};
ref_dir = 'train_data/'; %Use 'train_data1/' for key frames
tst_dir = 'test_data/'; %Use 'test_data1/' for key frames
data_id = 1;
ref_file = ref_filename{data_id};
tst_file = tst_filename{data_id};
ref_seq = load([ref_dir ref_file '.txt']);
test_seq = load([tst_dir tst_file '.txt']);
ref_seq = reshape(ref_seq,95, size(ref_seq,1)/95);
test_seq = reshape(test_seq, 95, size(test_seq,1)/95);
ref_seq = ref_seq'; % Remember to transpose to make each row a frame
test_seq = test_seq'; % Remember to transpose to make each row a frame

%% Start the key sequence spotting
LD = simmx(test_seq', ref_seq'); % Compute the local distance matrix 
[p q D] = dp(LD); % Perform the DTW matching. p and q gives the path and D gives the computed DTW distance
[end_list d1] = FindEnd(D(end,:)) % Find all possible end points. Candidate points are in end_list and d1 are the corresponding distances
[start_list d2] = FindStart(test_seq, ref_seq, end_list); % Reverse the sequences and find the end point for each candidate (found points are in start_list, d2 are the distances)
start_list = end_list - start_list + 1; % find the located start points in the non-reversed sequence
cand_list = [start_list' end_list'  min(d1',d2') d1' d2'] % Compose all candidates for spotted subsequences
best1 = cand_list(find(cand_list(:,4)==min(cand_list(:,4))),:) % Find the best one according to d1 distances
best2 = cand_list(find(cand_list(:,5)==min(cand_list(:,5))),:) % Find the best one according to d2 distances
best = cand_list(find(cand_list(:,3)==min(cand_list(:,3))),:) % Find the best one according to min(d1,d2)

% Draw the sequences with RGB color bars. 
% Comment out this block if you use the above file reading block 
% becaue this block is valid only for feature vectors with 3 features
% grid_size = 10;
% min_d = min(cand_list(:,3));
% max_d = max(cand_list(:,3));
% final_img = zeros(length(cand_list)*grid_size*2,1024,3);
% optimal_marker = zeros(grid_size, grid_size, 3);
% optimal_marker(1, 1:grid_size, 1) = 1.0;
% optimal_marker(grid_size, 1:grid_size, 1) = 1.0;
% optimal_marker(1:grid_size,1,1) = 1.0;
% optimal_marker(1:grid_size,grid_size,1) = 1.0;
% offset_x = 2*grid_size;
% for k =1:length(cand_list)
%     r_seq = ref_seq(cand_list(k,1):cand_list(k,2),:);
%     img = CreateImg(r_seq, test_seq, grid_size);
%     width = size(img,2);
%     final_img((k-1)*grid_size*2+1:k*grid_size*2,offset_x+(1:width),:) = img;
%     if (cand_list(k,1)==best(1)&&cand_list(k,2)==best(2))
%         final_img((k-1)*grid_size*2+1:(k-1)*grid_size*2+grid_size, offset_x+(width+grid_size+1:width+2*grid_size),:) = optimal_marker;
%     end
%     score = ((cand_list(k,3)-min_d)/(max_d-min_d))^(0.25);
%     final_img((k-1)*grid_size*2+1:(k-1)*grid_size*2+grid_size,1:grid_size,:) = score; % Draw a gray box indicating the score of each subsequence  
% end
% imshow(final_img);

%% Save the sequences and results
%pos = double([start_pos end_pos]);
%save( 'pos.txt', 'pos', '-ascii');
%save -ascii 'test_seq.txt' 'test_seq';
%save -ascii 'ref_seq.txt' 'ref_seq';