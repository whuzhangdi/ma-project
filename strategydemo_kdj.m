function [ result ] = strategydemo_kdj( futures_series_plus,para,rf )
%STRATEGYDEMO carry out the k_d and ma(n) strategy
%   example: [ result ] = strategydemo( futures_series_plus,para,rf );
%% extract parameter
fmapara = para{1}; % ma(fast mapara)
smapara = para{2}; % ma(slow mapara)
year = para{3};  % year:1   month:0
[num_f,~]=size(futures_series_plus);
%% k_d strategy
k_d_single=cell(num_f,2);
k_dtable=zeros(num_f,8);
k_dcum=cell(num_f,2);
for i=1:num_f
    %for i=1
    [ k_d_single{i,1},k_d_single{i,2}] = k_d( futures_series_plus{i,1}, futures_series_plus{i,2},{fmapara,smapara} );
    if year ==1
    % in year term
    [ k_dtable(i,:),k_dcum{i,1},k_dcum{i,2}] = performanceanalysis(k_d_single{i,1},k_d_single{i,2},rf);
    else
    % in month term
    [ k_dtable(i,:),k_dcum{i,1},k_dcum{i,2}] = pfmanalysis(k_d_single{i,1},k_d_single{i,2},rf);
    end;
end;
%% obv strategy
obv_single=cell(num_f,2);
obvtable=zeros(num_f,8);
obvcum=cell(num_f,2);
for i=1:num_f
    %for i=1
    [ obv_single{i,1},obv_single{i,2}] = obv( futures_series_plus{i,1}, futures_series_plus{i,2},{fmapara,smapara} );
    if year ==1
    % in year term
    [ obvtable(i,:),obvcum{i,1},obvcum{i,2}] = performanceanalysis(obv_single{i,1},obv_single{i,2},rf);
    else
    % in month term
    [ obvtable(i,:),obvcum{i,1},obvcum{i,2}] = pfmanalysis(obv_single{i,1},obv_single{i,2},rf);
    end;
end;
%% return the result 
result.k_d.table = k_dtable;
result.k_d.cum = k_dcum;
result.k_d.info = k_d_single;
result.obv.table = obvtable;
result.obv.cum = obvcum;
result.obv.info = obv_single;
end

