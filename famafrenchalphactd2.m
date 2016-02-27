function [ regtable,timingtab] = famafrenchalphactd2( sortresult,factors,rf )
%FAMAFRENCHALPHACTD compute the alpha in the form of SMB HML MKT,and check
%the market timing  in daily term
%  rf is real rf
[regtable.a] = betareg2(sortresult.vltlt,factors,rf);
[regtable.b] = betareg2(sortresult.vlm,factors,rf);
[regtable.c] = betareg2(sortresult.openinst,factors,rf);
[regtable.d] = betareg2(sortresult.lastmon,factors,rf);
[regtable.e] = betareg2(sortresult.sixmonth,factors,rf);
[regtable.f] = betareg2(sortresult.sixtymonth,factors,rf);
[timingtab.a] = timingreg2(sortresult.vltlt,factors,[]);
[timingtab.b] = timingreg2(sortresult.vlm,factors,[]);
[timingtab.c] = timingreg2(sortresult.openinst,factors,[]);
[timingtab.d] = timingreg2(sortresult.lastmon,factors,[]);
[timingtab.e] = timingreg2(sortresult.sixmonth,factors,[]);
[timingtab.f] = timingreg2(sortresult.sixtymonth,factors,[]);
end

