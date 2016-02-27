function [ result ] = strategydemo( futures_series_plus,para,rf )
%STRATEGYDEMO carry out the bah and ma(n) strategy
%   example: [ result ] = strategydemo( futures_series_plus,para,rf );
%% extract parameter
mapara = para{1}; % ma(mapara)
short = para{2}; % short:1 only long:0
year = para{3};  % year:1   month:0
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
%% ma(n)strategy
ma_single=cell(num_f,2);
matable=zeros(num_f,8);
macum=cell(num_f,2);
for i=1:num_f
    %for i=1
    [ ma_single{i,1},ma_single{i,2}] = ma( futures_series_plus{i,1}, futures_series_plus{i,2},mapara,short);
    if year==1
    % in year term
    [ matable(i,:),macum{i,1},macum{i,2}] = performanceanalysis(ma_single{i,1},ma_single{i,2},rf);
    else
    % in month term
    [ matable(i,:),macum{i,1},macum{i,2}] = pfmanalysis(ma_single{i,1},ma_single{i,2},rf);
    end;
end;
%% return the result 
result.ma.table = matable;
result.ma.cum = macum;
result.ma.info = ma_single;
result.bah.table = bahtable;
result.bah.cum = bahcum;
result.bah.info = bah_single;
end

