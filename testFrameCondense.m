format long;
dim = 90;
[frames cutpos] = GenFrames(50, dim, 0.1);
%load('frames.txt');
%load('cutpos.txt');
for i=1:dim
    frames(:,i) = 50*(frames(:,i)-min(frames(:,i)))/(max(frames(:,i)-min(frames(:,i))));
end
alpha = 1;%0.001;
beta = 0.2;%0.5;%0.003;
[intv V D S stdv Cnt pred] = FrameCondense(size(frames,1), frames, alpha, beta, 1);
[intvs score sc] = TraceBack(intv, V, D, S, Cnt, pred, alpha, beta);
% norm_score = score./cnt;
intv_ids = intvs{score==min(score)}
ttt = [score sc]
I = intv(intv_ids,:)
frames;
save('frames.txt','-ascii','frames');
save('cutpos.txt','-ascii','cutpos');
