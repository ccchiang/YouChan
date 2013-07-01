function [n_frames tdata] = CollectData(dirname)
train_flist = dir(dirname);
no_of_tdata = length(train_flist);
tdata = [];
n_frames = [];
for i=1:no_of_tdata
    if train_flist(i).isdir==1
        continue;
    end
    frames = GetSequence([dirname '/' train_flist(i).name]);
    n = length(frames);
    tdata = [tdata; frames];
    n_frames = [n_frames; n];
end