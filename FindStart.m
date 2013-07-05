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
        qlen = size(rev_test_seq,1);
        lendiff = abs(qlen-end_cand);
        lendiff = 1-exp(-2*lendiff/qlen);
        d = (1+lendiff).* d;
        if (length(end_cand)==0)
            out(i) = -1;
            outd(i) = 9999999;
        else
            tmp_d = [9999999 d 9999999]; 
            for k=2:length(tmp_d)-1
                if ((tmp_d(k)<tmp_d(k-1))&&((tmp_d(k)<tmp_d(k+1))||abs(tmp_d(k)-tmp_d(k+1))<1.0e-5))
                    out(i) = end_cand(k-1);
                    outd(i) = tmp_d(k);
                    break;
                end
            end
        end
    end