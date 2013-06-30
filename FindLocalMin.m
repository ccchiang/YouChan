function out = FindLocalMin(val)
    tmp = [val(1) val(1:end-1)];
    diff = val - tmp;
    tmp1 = [diff(1) diff(1:end-1)];
    tmp2 = [diff(2:end) diff(end)];
    flag = (diff<tmp1)&(diff<tmp2);
    out = find(flag==1);
    
    