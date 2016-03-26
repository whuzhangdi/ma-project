function [ monfstprice,cum_ret ] = extractprice2( information,dailyreturn)
%function: change daily price to week price, the first price of every
%five sequent prices
%   [sortresult.vlm.monrslt] = extractprice2( sortresult.vlm.rslt{1,1});
%% extract week price
[hang,~]=size(information);
monfstprice = zeros(ceil(hang/5),5);
hang_mark = 5*[1:1:floor(hang/5)]';
hang_mark = [hang_mark;hang];
monfstprice = information(hang_mark,:);
%% extract week return
[hang_sub,~] = size(hang_mark);
cum_ret = [];
for i=1:hang_sub
    if i==1
        cum_ret(i,1)=prod(1+dailyreturn(1:hang_mark(i),:))-1;
    else
        cum_ret(i,1)=prod(1+dailyreturn(hang_mark(i-1)+1:hang_mark(i),:))-1;
    end;
end;
end

