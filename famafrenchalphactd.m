function [ regtable,timingtab] = famafrenchalphactd( sortresult,factors,rf )
%FAMAFRENCHALPHACTD compute the alpha in the form of SMB HML MKT,and check
%the market timing in month term
%  rf is real rf
[regtable.a] = betareg(sortresult.vltlt,factors,rf);
[regtable.b] = betareg(sortresult.vlm,factors,rf);
[regtable.c] = betareg(sortresult.openinst,factors,rf);
[regtable.d] = betareg(sortresult.lastmon,factors,rf);
[regtable.e] = betareg(sortresult.sixmonth,factors,rf);
[regtable.f] = betareg(sortresult.sixtymonth,factors,rf);
[timingtab.a] = timingreg(sortresult.vltlt,factors,[]);
[timingtab.b] = timingreg(sortresult.vlm,factors,[]);
[timingtab.c] = timingreg(sortresult.openinst,factors,[]);
[timingtab.d] = timingreg(sortresult.lastmon,factors,[]);
[timingtab.e] = timingreg(sortresult.sixmonth,factors,[]);
[timingtab.f] = timingreg(sortresult.sixtymonth,factors,[]);
end

