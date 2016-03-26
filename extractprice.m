function [ monfstprice ] = extractprice( information)
%function: change daily price to month price, the first price of every
%month 
%   [sortresult.vlm.monrslt] = extractprice( sortresult.vlm.rslt{1,1});
%% extract mon mark
[year,ia,~]=unique(information(:,1),'last');
[hang,~]=size(year);
yeardata = cell(hang,1);
monfstprice =[];
for i=1:hang
    if i==1
        temp = information(1:ia(i),:);
    else
        temp = information(ia(i-1)+1:ia(i),:);
    end;
    yeardata{i,1} = temp;
    [~,ia_tmp,~]=unique(temp(:,2),'first');
    temp = temp(ia_tmp,:);
    monfstprice = [monfstprice;temp];
end;
end

