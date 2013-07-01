function frames = GetSequence(fname)
skelton = load(fname);
n = length(skelton);
n_frames = n/60;
frames = reshape(n_frames, 20, 3); 