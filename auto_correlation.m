function [table,ptable] = auto_correlation(result,lags)
%auto_correlation display the auto_correlation structure of the real data
% and simulation data
%   example:[table] = auto_correlation(result,10)
%% initailization
table = zeros(lags+2,18);
ptable = zeros(lags,18);
stragetyname= {'bah','roc','wma','ema','macd','vma','k_d','s_r','obv','n_1'};
sortedname = {'vltlt','vlm','openinst','lastmon','sixmonth','sixtymonth'};
[~,hang] = size(sortedname);
%% extract data
for i=1:hang
    tempdata=getfield(getfield(result,sortedname{1,i}),'rslt');
    for j=1:3
        temp = tempdata{j,2};
        [temptable,~,bounds] = autocorr(temp,10,[],3);
        [~,pValue,stat,~] = lbqtest(temp,'lags',lags);% the null hypothesis that:
        % a series of residuals exhibits no autocorrelation for a fixed number of lags L.
        %[temptable] = auto_corr2(temp,lags);
        table(1:lags,i*3-3+j)=temptable(2:lags+1,:);
        table(lags+1,i*3-3+j)=stat;
        table(lags+2,i*3-3+j)=pValue;
        for k=1:lags
            if abs(temptable(k,1))>abs(bounds(1,1))
                ptable(k,i*3-3+j) =1;
            end;
        end;
    end;
end;
xlswrite('D:\program files\matlab\bin\maproject_english\bootstrap.xls',[table;mean(table(1:lags,:))],'auto','B3:S15');
xlswrite('D:\program files\matlab\bin\maproject_english\bootstrap.xls',[ptable;sum(ptable)],'auto_p','B3:S13');
disp('complete!');
end

