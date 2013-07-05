function [out d] = FindEnd(dist)
    tmp1 = zeros(1, length(dist));
    tmp2 = zeros(1, length(dist));
    tmp1(1:end-1) = dist(2:end);
    tmp1(end) = 999999.0;
    tmp2(2:end) = dist(1:end-1);
    tmp2(1) = 0;
    flag = ((dist<tmp1)&((dist<tmp2)|(abs(dist-tmp2)<=5.0e-4))|tmp1==999999.0);
    out = find(flag==1);
    %out = FindLocalMin(dist);
    %out = [out length(dist)] %Always add the last frame into the candidate
    d = dist(out)./out;
    %d = dist(out).*(abs(1-out/length(dist)));
    %d = dist(out);