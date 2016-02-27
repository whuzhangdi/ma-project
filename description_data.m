function [ analysisresult,daily_data  ] = description_data( a )
%load
%   [ table ] = description_data( a )
%[ analysisresult(1,:) ] = description_data( [2	4 7	8	9	10	11	13	20 21	22	25	26	27	30	33	34	44] );% CZCE
%[ analysisresult(2,:) ] = description_data( [1	3	12	15	16	18	19	29	31	32	36	37	38	43	45	46] );% DCE
%[ analysisresult(3,:) ] = description_data( [5	6	14	17	23	24	28	35 39	40	41	42	] );% SHFE
%[ analysisresult(4,:) ] = description_data( [1:1:46] );
load cellwithfactor.mat;
[hang,~]=size(a');
tradingnum =zeros(hang,1);
daily_data = [];
for i=1:hang
    temp1 = cellwithfactor{a(i),1}(:,5:6);% 交易量、持仓量
    temp2 = cellwithfactor{a(i),2};% 日收益
    [tradingnum(i,1),~]=size(temp1);
    temp = [temp1,temp2]; 
    daily_data = [daily_data;temp];
end;
disp(a);
temp=daily_data;
analysisresult(1,1)=mean(temp(:,3))*252;
analysisresult(1,2)=std(temp(:,3))*sqrt(252);
%analysisresult(1,3)=analysisresult(1,1)/analysisresult(1,2);
analysisresult(1,3)=skewness(temp(:,3));
analysisresult(1,4)=kurtosis(temp(:,3));
[analysisresult(1,5),~]=size(tradingnum);
analysisresult(1,6)=mean(temp(:,1));
analysisresult(1,7)=mean(temp(:,2));
[analysisresult(1,8),~] = size(find(tradingnum<1001));
[analysisresult(1,10),~] = size(find(tradingnum>2000));
[analysisresult(1,9),~] = size(find(tradingnum>1000));
analysisresult(1,9) = analysisresult(1,9)-analysisresult(1,10);
end

