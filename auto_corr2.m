function [table] = auto_corr2(temp,lags)
%auto_corr2 calculate the auto-correlation with lags
%   example: [temptable] = auto_corr2(temp,10)
table = zeros(lags,1);
[hang,~] =size(temp);
for i=1:lags
    temp1 = temp(1:hang-i,:);
    temp2 = temp(1+i:hang,:);
    [hang1,~] = size(temp1);
    [hang2,~] = size(temp2);
    if hang1==hang2
        ;
    else 
        disp('error!');
    end;
    table(i,1) = corr(temp1,temp2);
end;
end

