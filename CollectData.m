function [n_frames tdata] = CollectData(listfilename, dirname)
fd = fopen(listfilename, 'r');
stop = 0;
tdata = [];
n_frames = [];
while (stop~=1) 
    d = fscanf(fd, '%d', 1);
    fname = fscanf(fd, '%s', 1);
    if (isempty(d))
        stop = 1;
    else
        frames = GetSequence([dirname '/' fname]);
        n = size(frames, 1);
        tdata = [tdata; frames];
        n_frames = [n_frames; n];        
    end
end
fclose(fd);