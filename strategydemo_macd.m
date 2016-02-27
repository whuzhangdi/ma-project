function [ result ] = strategydemo_macd( futures_series_plus,para,rf )
%STRATEGYDEMO carry out the vma and ma(n) strategy
%   example: [ result ] = strategydemo( futures_series_plus,para,rf );
%% extract parameter
fmapara = para{1}; % ma(fast mapara)
smapara = para{2}; % ma(slow mapara)
year = para{3};  % year:1   month:0
[num_f,~]=size(futures_series_plus);
%% vma strategy
vma_single=cell(num_f,2);
vmatable=zeros(num_f,8);
vmacum=cell(num_f,2);
for i=1:num_f
    %for i=1
    [ vma_single{i,1},vma_single{i,2}] = vma( futures_series_plus{i,1}, futures_series_plus{i,2},{fmapara,smapara} );
    if year ==1
    % in year term
    [ vmatable(i,:),vmacum{i,1},vmacum{i,2}] = performanceanalysis(vma_single{i,1},vma_single{i,2},rf);
    else
    % in month term
    [ vmatable(i,:),vmacum{i,1},vmacum{i,2}] = pfmanalysis(vma_single{i,1},vma_single{i,2},rf);
    end;
end;
%% macd strategy
macd_single=cell(num_f,2);
macdtable=zeros(num_f,8);
macdcum=cell(num_f,2);
for i=1:num_f
    %for i=1
    [ macd_single{i,1},macd_single{i,2}] = macd( futures_series_plus{i,1}, futures_series_plus{i,2},{fmapara,smapara} );
    if year ==1
    % in year term
    [ macdtable(i,:),macdcum{i,1},macdcum{i,2}] = performanceanalysis(macd_single{i,1},macd_single{i,2},rf);
    else
    % in month term
    [ macdtable(i,:),macdcum{i,1},macdcum{i,2}] = pfmanalysis(macd_single{i,1},macd_single{i,2},rf);
    end;
end;
%% s_r strategy
s_r_single=cell(num_f,2);
s_rtable=zeros(num_f,8);
s_rcum=cell(num_f,2);
for i=1:num_f
    %for i=1
    [ s_r_single{i,1},s_r_single{i,2}] = s_r( futures_series_plus{i,1}, futures_series_plus{i,2},{fmapara,smapara} );
    if year ==1
    % in year term
    [ s_rtable(i,:),s_rcum{i,1},s_rcum{i,2}] = performanceanalysis(s_r_single{i,1},s_r_single{i,2},rf);
    else
    % in month term
    [ s_rtable(i,:),s_rcum{i,1},s_rcum{i,2}] = pfmanalysis(s_r_single{i,1},s_r_single{i,2},rf);
    end;
end;
%% return the result 
result.vma.table = vmatable;
result.vma.cum = vmacum;
result.vma.info = vma_single;
result.macd.table = macdtable;
result.macd.cum = macdcum;
result.macd.info = macd_single;
result.s_r.table = s_rtable;
result.s_r.cum = s_rcum;
result.s_r.info = s_r_single;
end

