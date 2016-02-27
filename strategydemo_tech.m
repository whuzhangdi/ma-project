function [ result ] = strategydemo_tech( futures_series_plus,para,rf )
%STRATEGYDEMO carry out the roc and ma(n) strategy
%   example: [ result ] = strategydemo( futures_series_plus,para,rf );
%% extract parameter %% roc wma ema 
wmapara = para{1}; % ma(mapara)
emapara = para{1};
roc_n = para{1}; % short:1 only long:0
year = para{3};  % year:1   month:0
short = para{4};
%% extract parameter %% vma macd s_r
fmapara = para{1}; % ma(fast mapara)
smapara = para{2}; % ma(slow mapara)
%% extract parameter %% 
fmapara = para{1}; % ma(fast mapara)
smapara = para{2}; % ma(slow mapara)
[num_f,~]=size(futures_series_plus);
%% bah strategy
bah_single=cell(num_f,2);
bahtable=zeros(num_f,8);
bahcum=cell(num_f,2);
for i=1:num_f
    %for i=1
    [ bah_single{i,1},bah_single{i,2}] = bah( futures_series_plus{i,1}, futures_series_plus{i,2} );
    if year ==1
    % in year term
    [ bahtable(i,:),bahcum{i,1},bahcum{i,2}] = performanceanalysis(bah_single{i,1},bah_single{i,2},rf);
    else
    % in month term
    [ bahtable(i,:),bahcum{i,1},bahcum{i,2}] = pfmanalysis(bah_single{i,1},bah_single{i,2},rf);
    end;
end;
%% roc strategy
roc_single=cell(num_f,2);
roctable=zeros(num_f,8);
roccum=cell(num_f,2);
for i=1:num_f
    %for i=1
    [ roc_single{i,1},roc_single{i,2}] = roc( futures_series_plus{i,1}, futures_series_plus{i,2},roc_n,short);
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
    [ wma_single{i,1},wma_single{i,2}] = wma( futures_series_plus{i,1}, futures_series_plus{i,2},wmapara,short );
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
    [ ema_single{i,1},ema_single{i,2}] = ema( futures_series_plus{i,1}, futures_series_plus{i,2},emapara,short );
    if year ==1
    % in year term
    [ ematable(i,:),emacum{i,1},emacum{i,2}] = performanceanalysis(ema_single{i,1},ema_single{i,2},rf);
    else
    % in month term
    [ ematable(i,:),emacum{i,1},emacum{i,2}] = pfmanalysis(ema_single{i,1},ema_single{i,2},rf);
    end;
end;
%% vma strategy
vma_single=cell(num_f,2);
vmatable=zeros(num_f,8);
vmacum=cell(num_f,2);
for i=1:num_f
    %for i=1
    [ vma_single{i,1},vma_single{i,2}] = vma( futures_series_plus{i,1}, futures_series_plus{i,2},{fmapara,smapara},short );
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
    [ macd_single{i,1},macd_single{i,2}] = macd( futures_series_plus{i,1}, futures_series_plus{i,2},{fmapara,smapara},short );
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
    [ s_r_single{i,1},s_r_single{i,2}] = s_r( futures_series_plus{i,1}, futures_series_plus{i,2},{fmapara,smapara},short );
    if year ==1
    % in year term
    [ s_rtable(i,:),s_rcum{i,1},s_rcum{i,2}] = performanceanalysis(s_r_single{i,1},s_r_single{i,2},rf);
    else
    % in month term
    [ s_rtable(i,:),s_rcum{i,1},s_rcum{i,2}] = pfmanalysis(s_r_single{i,1},s_r_single{i,2},rf);
    end;
end;
%% k_d strategy
k_d_single=cell(num_f,2);
k_dtable=zeros(num_f,8);
k_dcum=cell(num_f,2);
for i=1:num_f
    %for i=1
    [ k_d_single{i,1},k_d_single{i,2}] = k_d( futures_series_plus{i,1}, futures_series_plus{i,2},{fmapara,3},short );
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
    [ obv_single{i,1},obv_single{i,2}] = obv( futures_series_plus{i,1}, futures_series_plus{i,2},{fmapara,smapara},short );
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
result.vma.table = vmatable;
result.vma.cum = vmacum;
result.vma.info = vma_single;
result.macd.table = macdtable;
result.macd.cum = macdcum;
result.macd.info = macd_single;
result.s_r.table = s_rtable;
result.s_r.cum = s_rcum;
result.s_r.info = s_r_single;
result.wma.table = wmatable;
result.wma.cum = wmacum;
result.wma.info = wma_single;
result.roc.table = roctable;
result.roc.cum = roccum;
result.roc.info = roc_single;
result.ema.table = ematable;
result.ema.cum = emacum;
result.ema.info = ema_single;
result.bah.table = bahtable;
result.bah.cum = bahcum;
result.bah.info = bah_single;
end

