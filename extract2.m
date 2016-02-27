function [mon_ret] = extract2(sortresult)
%extract all the return series to a matrix
% if data is missing, nan
%   exapmle: [mon_ret] = extract2(sortresult);
mon_ret = zeros(144:81);
for i=1:3
    mon_ret(1,i*9-8)=nan;
    mon_ret(2:144,i*9-8)=sortresult.lastmon.table.bah.cum{i,1};
    mon_ret(1,i*9-7)=nan;
    mon_ret(2:144,i*9-7)=sortresult.lastmon.table.roc.cum{i,1};
    mon_ret(1,i*9-6)=nan;
    mon_ret(2:144,i*9-6)=sortresult.lastmon.table.wma.cum{i,1};
    mon_ret(1,i*9-5)=nan;
    mon_ret(2:144,i*9-5)=sortresult.lastmon.table.ema.cum{i,1};
    mon_ret(1,i*9-4)=nan;
    mon_ret(2:144,i*9-4)=sortresult.lastmon.table.macd.cum{i,1};
    mon_ret(1,i*9-3)=nan;
    mon_ret(2:144,i*9-3)=sortresult.lastmon.table.vma.cum{i,1};
    mon_ret(1,i*9-2)=nan;
    mon_ret(2:144,i*9-2)=sortresult.lastmon.table.s_r.cum{i,1};
    mon_ret(1,i*9-1)=nan;
    mon_ret(2:144,i*9-1)=sortresult.lastmon.table.k_d.cum{i,1};
    mon_ret(1,i*9-0)=nan;
    mon_ret(2:144,i*9)=sortresult.lastmon.table.obv.cum{i,1};
end;
for i=1:3
    mon_ret(1:6,(i+3)*9-8)=nan;
    mon_ret(7:144,(i+3)*9-8)=sortresult.sixmonth.table.bah.cum{i,1};
    mon_ret(1:6,(i+3)*9-7)=nan;
    mon_ret(7:144,(i+3)*9-7)=sortresult.sixmonth.table.roc.cum{i,1};
    mon_ret(1:6,(i+3)*9-6)=nan;
    mon_ret(7:144,(i+3)*9-6)=sortresult.sixmonth.table.wma.cum{i,1};
    mon_ret(1:6,(i+3)*9-5)=nan;
    mon_ret(7:144,(i+3)*9-5)=sortresult.sixmonth.table.ema.cum{i,1};
    mon_ret(1:6,(i+3)*9-4)=nan;
    mon_ret(7:144,(i+3)*9-4)=sortresult.sixmonth.table.macd.cum{i,1};
    mon_ret(1:6,(i+3)*9-3)=nan;
    mon_ret(7:144,(i+3)*9-3)=sortresult.sixmonth.table.vma.cum{i,1};
    mon_ret(1:6,(i+3)*9-2)=nan;
    mon_ret(7:144,(i+3)*9-2)=sortresult.sixmonth.table.s_r.cum{i,1};
    mon_ret(1:6,(i+3)*9-1)=nan;
    mon_ret(7:144,(i+3)*9-1)=sortresult.sixmonth.table.k_d.cum{i,1};
    mon_ret(1:6,(i+3)*9-0)=nan;
    mon_ret(7:144,(i+3)*9)=sortresult.sixmonth.table.obv.cum{i,1};
end;
for i=1:3
    mon_ret(1:60,(i+6)*9-8)=nan;
    mon_ret(61:144,(i+6)*9-8)=sortresult.sixtymonth.table.bah.cum{i,1};
    mon_ret(1:60,(i+6)*9-7)=nan;
    mon_ret(61:144,(i+6)*9-7)=sortresult.sixtymonth.table.roc.cum{i,1};
    mon_ret(1:60,(i+6)*9-6)=nan;
    mon_ret(61:144,(i+6)*9-6)=sortresult.sixtymonth.table.wma.cum{i,1};
    mon_ret(1:60,(i+6)*9-5)=nan;
    mon_ret(61:144,(i+6)*9-5)=sortresult.sixtymonth.table.ema.cum{i,1};
    mon_ret(1:60,(i+6)*9-4)=nan;
    mon_ret(61:144,(i+6)*9-4)=sortresult.sixtymonth.table.macd.cum{i,1};
    mon_ret(1:60,(i+6)*9-3)=nan;
    mon_ret(61:144,(i+6)*9-3)=sortresult.sixtymonth.table.vma.cum{i,1};
    mon_ret(1:60,(i+6)*9-2)=nan;
    mon_ret(61:144,(i+6)*9-2)=sortresult.sixtymonth.table.s_r.cum{i,1};
    mon_ret(1:60,(i+6)*9-1)=nan;
    mon_ret(61:144,(i+6)*9-1)=sortresult.sixtymonth.table.k_d.cum{i,1};
    mon_ret(1:60,(i+6)*9-0)=nan;
    mon_ret(61:144,(i+6)*9)=sortresult.sixtymonth.table.obv.cum{i,1};
end;
end

