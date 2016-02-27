function [mon_ret] = extract1(sortresult)
%extract all the return series to a matrix
% if data is missing, nan
%   exapmle: [mon_ret] = extract1(sortresult);
mon_ret = zeros(144:81);
for i=1:3
    mon_ret(:,i*9-8)=sortresult.vltlt.table.bah.cum{i,1};
    mon_ret(:,i*9-7)=sortresult.vltlt.table.roc.cum{i,1};
    mon_ret(:,i*9-6)=sortresult.vltlt.table.wma.cum{i,1};
    mon_ret(:,i*9-5)=sortresult.vltlt.table.ema.cum{i,1};
    mon_ret(:,i*9-4)=sortresult.vltlt.table.macd.cum{i,1};
    mon_ret(:,i*9-3)=sortresult.vltlt.table.vma.cum{i,1};
    mon_ret(:,i*9-2)=sortresult.vltlt.table.s_r.cum{i,1};
    mon_ret(:,i*9-1)=sortresult.vltlt.table.k_d.cum{i,1};
    mon_ret(:,i*9)=sortresult.vltlt.table.obv.cum{i,1};
end;
for i=1:3
    mon_ret(:,(i+3)*9-8)=sortresult.vlm.table.bah.cum{i,1};
    mon_ret(:,(i+3)*9-7)=sortresult.vlm.table.roc.cum{i,1};
    mon_ret(:,(i+3)*9-6)=sortresult.vlm.table.wma.cum{i,1};
    mon_ret(:,(i+3)*9-5)=sortresult.vlm.table.ema.cum{i,1};
    mon_ret(:,(i+3)*9-4)=sortresult.vlm.table.macd.cum{i,1};
    mon_ret(:,(i+3)*9-3)=sortresult.vlm.table.vma.cum{i,1};
    mon_ret(:,(i+3)*9-2)=sortresult.vlm.table.s_r.cum{i,1};
    mon_ret(:,(i+3)*9-1)=sortresult.vlm.table.k_d.cum{i,1};
    mon_ret(:,(i+3)*9)=sortresult.vlm.table.obv.cum{i,1};
end;
for i=1:3
    mon_ret(:,(i+6)*9-8)=sortresult.openinst.table.bah.cum{i,1};
    mon_ret(:,(i+6)*9-7)=sortresult.openinst.table.roc.cum{i,1};
    mon_ret(:,(i+6)*9-6)=sortresult.openinst.table.wma.cum{i,1};
    mon_ret(:,(i+6)*9-5)=sortresult.openinst.table.ema.cum{i,1};
    mon_ret(:,(i+6)*9-4)=sortresult.openinst.table.macd.cum{i,1};
    mon_ret(:,(i+6)*9-3)=sortresult.openinst.table.vma.cum{i,1};
    mon_ret(:,(i+6)*9-2)=sortresult.openinst.table.s_r.cum{i,1};
    mon_ret(:,(i+6)*9-1)=sortresult.openinst.table.k_d.cum{i,1};
    mon_ret(:,(i+6)*9)=sortresult.openinst.table.obv.cum{i,1};
end;
end

