function [ result ] = strategydemo_roc( futures_series_plus,para,rf )
%STRATEGYDEMO carry out the roc and ma(n) strategy
%   example: [ result ] = strategydemo( futures_series_plus,para,rf );
%% extract parameter
wmapara = para{1}; % ma(mapara)
emapara = para{1};
roc_n = para{2}; % short:1 only long:0
year = para{3};  % year:1   month:0
[num_f,~]=size(futures_series_plus);
%% roc strategy
roc_single=cell(num_f,2);
roctable=zeros(num_f,8);
roccum=cell(num_f,2);
for i=1:num_f
    %for i=1
    [ roc_single{i,1},roc_single{i,2}] = roc( futures_series_plus{i,1}, futures_series_plus{i,2},roc_n );
    if year ==1
    % in year term
    [ roctable(i,:),roccum{i,1},roccum{i,2}] = performanceanalysis(roc_single{i,1},roc_single{i,2},rf);
    else
    % in month term
    [ roctable(i,:),roccum{i,1},roccum{i,2}] = pfmanalysis(roc_single{i,1},roc_single{i,2},rf);
    end;
end;
%% wma strategy
wma_single=cell(num_f,2);
wmatable=zeros(num_f,8);
wmacum=cell(num_f,2);
for i=1:num_f
    %for i=1
    [ wma_single{i,1},wma_single{i,2}] = wma( futures_series_plus{i,1}, futures_series_plus{i,2},wmapara );
    if year ==1
    % in year term
    [ wmatable(i,:),wmacum{i,1},wmacum{i,2}] = performanceanalysis(wma_single{i,1},wma_single{i,2},rf);
    else
    % in month term
    [ wmatable(i,:),wmacum{i,1},wmacum{i,2}] = pfmanalysis(wma_single{i,1},wma_single{i,2},rf);
    end;
end;
%% ema strategy
ema_single=cell(num_f,2);
ematable=zeros(num_f,8);
emacum=cell(num_f,2);
for i=1:num_f
    %for i=1
    [ ema_single{i,1},ema_single{i,2}] = ema( futures_series_plus{i,1}, futures_series_plus{i,2},emapara );
    if year ==1
    % in year term
    [ ematable(i,:),emacum{i,1},emacum{i,2}] = performanceanalysis(ema_single{i,1},ema_single{i,2},rf);
    else
    % in month term
    [ ematable(i,:),emacum{i,1},emacum{i,2}] = pfmanalysis(ema_single{i,1},ema_single{i,2},rf);
    end;
end;
%% return the result 
result.wma.table = wmatable;
result.wma.cum = wmacum;
result.wma.info = wma_single;
result.roc.table = roctable;
result.roc.cum = roccum;
result.roc.info = roc_single;
result.ema.table = ematable;
result.ema.cum = emacum;
result.ema.info = ema_single;
end

