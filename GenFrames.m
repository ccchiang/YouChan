function [frames cutpos]= GenFrames(n_frames, dim, noise_level);
frames = zeros(n_frames, dim);
scale = 30;
frames(1,:) = scale*rand(1, dim);
cutpos =[1];
for i=2:n_frames
    cut_prob = rand(1,1);
    if (cut_prob<=0.2) 
        frames(i,:) = length(cutpos)*scale*(rand(1, dim)+1);
        cutpos = [cutpos i];
    else
        frames(i,:) = frames(i-1,:)+noise_level*scale*randn(1,dim);
    end
end