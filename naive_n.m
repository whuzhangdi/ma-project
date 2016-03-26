function [n_1]=naive_n(strategies,rf,year)
%ensample all the strategy with equally-weighted
%   example:[sortresult.vlm.table.n_1]=naive_n(sortresult.vlm.table);
%n_1=strategies.n_1;
for i=1:3
    n_1_single{i,1} = strategies.roc.info{i,1};
    n_1_single{i,2} = [strategies.roc.info{i,2},strategies.wma.info{i,2},strategies.ema.info{i,2},...
        strategies.macd.info{i,2},strategies.vma.info{i,2},strategies.obv.info{i,2}];
    n_1_single{i,2} = mean(n_1_single{i,2},2);
    if year ==1
    % in year term
    [ n_1table(i,:),n_1cum{i,1},n_1cum{i,2}] = performanceanalysis(n_1_single{i,1},n_1_single{i,2},rf);
    else
    % in month term
    [ n_1table(i,:),n_1cum{i,1},n_1cum{i,2}] = pfmanalysis(n_1_single{i,1},n_1_single{i,2},rf);
    end;
end;
n_1.table = n_1table;
n_1.cum = n_1cum;
n_1.info = n_1_single;
end

