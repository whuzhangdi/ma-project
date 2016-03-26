function [ result,analysisresult,indicator,monthreturn,com_ret ] = longandshort( futures_series,monpara,rf )
% deplicate the strategy of long-and-short in paper
% Narayan P K, Ahmed H A, Narayan S. Do Momentum-Based Trading Strategies Work in the Commodity Futures Markets?
% step one: calculate the moving return of return in each individual future
% step two: rank the moving average indicator
% step three: long the highest futures and short the lowest futures
% monpara = [1/0]   monthdata/weekdata
% [ result ] = longandshort(futures_series,1);
%% preparation
[hang,~] = size(futures_series);
fma = 1;
sma = 12;
%% extract data
for i=1:hang% futures kind
    temp = futures_series{i,1};
    if monpara==1
        [ temp ] = extractprice( temp);
    else
        [hang_temp,~]=size(temp);
        temp_return =zeros(hang_temp,1);
        [ temp,~ ] = extractprice2( temp,temp_return);
    end;
    [hang_sub,~] = size(temp);
    temp_cr = zeros(hang_sub,1);
    temp_cr(1,1) = nan;
    for j=2:hang_sub
        temp_cr(j,1) = temp(j,4)/temp(j-1,4)*100;
    end;
    [temp_all] = zeros(hang_sub,9);%num_time year month day price cr fr sr ma_in
    temp_all(:,1)=temp(:,7);
    temp_all(:,2:5)=temp(:,1:4);
    temp_all(:,6)=temp_cr;
    [temp_all(:,7)] = indicatorcal(temp_cr,fma);
    [temp_all(:,8)] = indicatorcal(temp_cr,sma);
    if hang_sub>12||hang_sub==12
        for j=1:sma
            temp_all(j,7)=nan;
            temp_all(j,8)=nan;
        end;
    else 
        [hang_subs,~]=size(temp_all(:,7));
        for j=1:hang_subs
            temp_all(j,7)=nan;
            temp_all(j,8)=nan;
        end;
    end;
    temp_all(:,9)=temp_all(:,7)-temp_all(:,8);
    futures_series{i,3} = temp_all;
end;
%% extract the indicator
result=futures_series;
mon_mark = zeros(144,2);
n=0;
for i=2003:2014% creat the month mark
    for j=1:12
        n=n+1;
        mon_mark(n,1)=i;
        mon_mark(n,2)=j;
    end;
end;
clear i j k;
indicator = zeros(n,hang);
monthreturn = zeros(n,hang);
for i=1:hang% futures
    temp = futures_series{i,3};
    [hang_n,~] = size(temp);
    for j=1:n  % mon mark
        for k=1:hang_n % future neighbor
            if temp(k,2)==mon_mark(j,1) && temp(k,3)==mon_mark(j,2)
               indicator(j,i) =temp(k,9);
               monthreturn(j,i) =temp(k,6)/100-1;
            end;
        end;
    end;
end;
%% tansform zero to nan
[hang,lie] = size(indicator);
for i=1:hang
    for j=1:lie
        if isnan(monthreturn(i,j))
            monthreturn(i,j)=0;
        end;
        if indicator(i,j)==0
            indicator(i,j)=nan;
        end;
    end;
end;
%% find the monthly return
indicator = indicator(13:hang-1,:);
monthreturn = monthreturn(14:hang,:);
[~, max_mark]= max(indicator,[],2);
[~, min_mark]= min(indicator,[],2);
[hang1,~]=size(max_mark);
[hang2,~]=size(min_mark);
if hang1==hang2;
    ;
else 
    disp('wrong!');
    return;
end;
com_ret = zeros(hang1,1);
for i=1:hang1
    com_ret(i,1) = monthreturn(i,max_mark(i,1))-monthreturn(i,min_mark(i,1));
end;
%% performance analysis
temp=com_ret-rf((144-hang1+1):144,:);
[hang,~] = size(temp);
%stats = regstats2(temp,zeros(hang,1),'linear',{ 'hac'})
[beta, X2_NW, std_NW,t_NW] = nwtest(temp,ones(hang,1),2);
analysisresult(1,1)=mean(temp)*12;
analysisresult(1,2)=std(temp)*sqrt(12);
analysisresult(1,3)=mean(temp)/std(temp);
analysisresult(1,4)=skewness(temp);
analysisresult(1,5)=kurtosis(temp);
analysisresult(1,6)=t_NW;
analysisresult(1,7)=(1-cdf('t',abs(t_NW),hang-1))*2;
analysisresult(1,8)=mean(temp)*sqrt(hang)/std(temp);
disp(analysisresult');
end

