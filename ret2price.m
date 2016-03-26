function [price] = ret2price(ret)
%RET2PRICE calculate price from return,p1=100
%   [new_dataset.vlm.rslt{i,1}(:,4)] = ret2price(sortresult.vlm.rslt{i,2}(mark,1));
[hang,~]=size(ret);
price = ones(hang,1)*100;
for i=1:hang-1
    price(i+1,1) = price(i)*(ret(i,1)+1);
end;
end

