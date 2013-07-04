function [n_frames motion_frames] = ComputeMotion(fname)
skelton_frames = load(fname);
sz = size(skelton_frames, 1);
dim = size(skelton_frames, 2);
motion_frames = zeros(sz-1, 2);
tmp1 = skelton_frames(2:end,:);
tmp2 = skelton_frames(1:sz-1,:);
motion_frames = tmp2 - tmp1;
n_frames = load(['no_' fname]);
n_frames = n_frames - 1;
    