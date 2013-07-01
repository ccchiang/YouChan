function out = GetSequence(fname)
skelton = load(fname);
n = length(skelton);
n_frames = n/60;
frames = reshape(skelton, 3, 20, n_frames); 
out_frames = zeros(n_frames, 60);
for i=1:n_frames
    frames(1,:,i) = frames(1,:,i) - frames(1,1,i);
    frames(2,:,i) = frames(2,:,i) - frames(2,1,i);
    frames(3,:,i) = frames(3,:,i) - frames(3,1,i);
    f = frames(:,:,i);
    len = norm(f(:,4));
    out_frames(i,:) = reshape(f, 1, 60)/len;
end
out = out_frames(:,4:end);