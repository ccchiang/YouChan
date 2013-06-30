function [out outd] = FindStart(test_seq, ref_seq, end_list)
    rev_test_seq = flipud(test_seq);
    out = zeros(1, length(end_list));
    outd = zeros(1, length(end_list));
    for i=1:length(end_list)
        end_pos = end_list(i);
        if (end_pos<=2)
            out(i) = -1;
            outd(i) = 9999999;
            continue;
        end
        tmp1 = flipud(ref_seq(1:end_pos,:));
        LD = simmx(rev_test_seq', tmp1');
        [p q D] = dp(LD);
        [end_cand d]= FindEnd(D(end,:));
        if (length(end_cand)==0)
            out(i) = -1;
            outd(i) = 9999999;
        else
            out(i) = end_cand(find(d==min(d)));
            outd(i) = min(d);
        end
    end