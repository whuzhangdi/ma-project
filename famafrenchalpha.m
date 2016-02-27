function [ regtable ] = famafrenchalpha( sortresult,factors,rf )
%FAMAFRENCHALPHA compute the alpha in the form of SMB HML MKT
%  rf is real rf
[regtable(1,:)] = alphareg(sortresult.vltlt,factors,rf);
[regtable(2,:)] = alphareg(sortresult.vlm,factors,rf);
[regtable(3,:)] = alphareg(sortresult.openinst,factors,rf);
[regtable(4,:)] = alphareg(sortresult.lastmon,factors,rf);
[regtable(5,:)] = alphareg(sortresult.sixmonth,factors,rf);
[regtable(6,:)] = alphareg(sortresult.sixtymonth,factors,rf);
end

