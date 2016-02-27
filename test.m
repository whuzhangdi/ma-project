function [ output_args ] = test( input_args )
%TEST Summary of this function goes here
%   Detailed explanation goes here
%% extract futures contract code
code = cell(num_f,1);
for i=1:num_f
    code{i,1}=futuremark{i,1}{1,1}(1,1:2);
end;
%% make table 1
tableone = ones(num_f,5);
for i=1:num_f
    temp = futures_series{i,1};
    [hang,lie] = size(temp);
    startdate=temp(1,7)-693960;
    initialprice = temp(1,4);
    enddate=temp(hang,7)-693960;
    endprice = temp(hang,4);
    cumret=endprice/initialprice-1;
    tableone(i,:)=[startdate,initialprice,enddate,endprice,cumret];
end;
%% tongjitianshu
[hang,~]=size(sortresult.information);
months = zeros(145,hang)
for i=1:hang
    temp=sortresult.information{i,4};
    [hang1,~]=size(temp);
    months(145-hang1+1:145,i)=temp;
end;
[hang,lie]=size(months);
cha=zeros(hang-1,lie);
for i=2:hang
    cha(i-1,:)=months(i,:)-months(i-1,:);
end;
ab=max(cha,[],2);
a=sum(max(cha,[],2));
%%  index the futures series:initial price is 100
%% pre-strategy index series:initial price is 100
futures_series_plus=futures_series;
for i=1:num_f
    futures_series_plus{i,1}(:,4) = futures_series{i,1}(:,4)/futures_series{i,1}(1,4)*100;
    %index is useless,but has no influence on the result, so I didn't change
    [futures_series_plus{i,1}] = nan2zero(futures_series_plus{i,1});
    [hang,~] = size(futures_series_plus{i,1});
    for j=1:hang-1
        futures_series_plus{i,2}(j,1)=futures_series_plus{i,1}(j+1,4)/futures_series_plus{i,1}(j,4)-1;
    end;
end;
clear hang i j;
%% make table 4
tablefour.a(1:3,:)=[sortresult.vltlt.table.bah.table,sortresult.vltlt.table.ma.table];
tablefour.b(1:3,:)=[sortresult.vlm.table.bah.table,sortresult.vlm.table.ma.table];
tablefour.c(1:3,:)=[sortresult.openinst.table.bah.table,sortresult.openinst.table.ma.table];
tablefour.d(1:3,:)=[sortresult.lastmon.table.bah.table,sortresult.lastmon.table.ma.table];
tablefour.e(1:3,:)=[sortresult.sixmonth.table.bah.table,sortresult.sixmonth.table.ma.table];
tablefour.f(1:3,:)=[sortresult.sixtymonth.table.bah.table,sortresult.sixtymonth.table.ma.table];
%% fama french alpha computation 
data = sortresult.lastmon.table.ma.cum{1,1}-rf;
[a]=regstats(data,factors(:,1:3),'',{'tstat','rsquare'});
%% numberize futures which have no trading volume
[hang,~]=size(cellwithfactor);
num = zeros(hang,3);% all trading day; no trading volume days; how many
for i=1:hang
    [num(i,1),~]=size(cellwithfactor{i,1});
    num_detail = cell(hang,1);
    for j=1:num(i,1)
        if cellwithfactor{i,1}(j,5)==0
            num(i,2)=num(i,2)+1;
        end;
    end;
    for j=2:num(i,1)
        if cellwithfactor{i,1}(j-1,5)~=0 && cellwithfactor{i,1}(j,5)==0
            num(i,3)=num(i,3)+1; 
        end;
    end;
end;
for i=1:hang
    num_detail{i,1}=zeros(num(i,3),3);
end;
maxlag=[];
for i=1:hang
    n_1=0;
    n_2=0;
    for j=2:num(i,1)
        if cellwithfactor{i,1}(j-1,5)~=0 && cellwithfactor{i,1}(j,5)==0
            n_1=n_1+1;
            num_detail{i,1}(n_1,1)=j;
            %disp(n_1);
        end;
        if cellwithfactor{i,1}(j-1,5)==0 && cellwithfactor{i,1}(j,5)~=0
            n_2=n_2+1;
            num_detail{i,1}(n_2,2)=j;
            %disp(n_2);
        end;
        num_detail{i,1}(:,3)=num_detail{i,1}(:,2)-num_detail{i,1}(:,1);
    end;
    disp(max(num_detail{i,1}(:,3)));
    maxlag = [maxlag;max(num_detail{i,1}(:,3))];
end;
%% write the individual contract result
filename = 'ma_result_indi_5_10_1_0.xls';
sheet = 'roc';
temp = eval(['result.',sheet]);
xlswrite(filename,temp.table,sheet,'J3');
xlswrite(filename,result.bah.table,sheet,'B3');
sheet = 'wma';
temp = eval(['result.',sheet]);
xlswrite(filename,temp.table,sheet,'J3');
xlswrite(filename,result.bah.table,sheet,'B3');
sheet = 'ema';
temp = eval(['result.',sheet]);
xlswrite(filename,temp.table,sheet,'J3');
xlswrite(filename,result.bah.table,sheet,'B3');
sheet = 'macd';
temp = eval(['result.',sheet]);
xlswrite(filename,temp.table,sheet,'J3');
xlswrite(filename,result.bah.table,sheet,'B3');
sheet = 'vma';
temp = eval(['result.',sheet]);
xlswrite(filename,temp.table,sheet,'J3');
xlswrite(filename,result.bah.table,sheet,'B3');
sheet = 's_r';
temp = eval(['result.',sheet]);
xlswrite(filename,temp.table,sheet,'J3');
xlswrite(filename,result.bah.table,sheet,'B3');
sheet = 'k_d';
temp = eval(['result.',sheet]);
xlswrite(filename,temp.table,sheet,'J3');
xlswrite(filename,result.bah.table,sheet,'B3');
sheet = 'obv';
temp = eval(['result.',sheet]);
xlswrite(filename,temp.table,sheet,'J3');
xlswrite(filename,result.bah.table,sheet,'B3');
%% 
%% strategy carried out
load factors.mat;
fma = 5; sma =10;year=1;short=0;
para ={fma, sma, year,short};% fma, sma, year,short
filename = 'ma_result_5_10_1_0_pre2008.xls';% write in xls
%[ result ] = strategydemo_tech( futures_series,para,rf ); %% individual
% on sorted portfolios
sortresult=sortresult1;
[ sortresult.vlm.table ] = strategydemo_tech( sortresult.vlm.rslt,para,rf );
[ sortresult.openinst.table ] = strategydemo_tech( sortresult.openinst.rslt,para,rf );
[ sortresult.vltlt.table ] = strategydemo_tech( sortresult.vltlt.rslt,para,rf );
[ sortresult.lastmon.table ] = strategydemo_tech( sortresult.lastmon.rslt,para,rf );
[ sortresult.sixmonth.table ] = strategydemo_tech( sortresult.sixmonth.rslt,para,rf );
sortresult.sixtymonth.table.roc.table=0;
sortresult.sixtymonth.table.ema.table=0;
sortresult.sixtymonth.table.wma.table=0;
sortresult.sixtymonth.table.s_r.table=0;
sortresult.sixtymonth.table.macd.table=0;
sortresult.sixtymonth.table.vma.table=0;
sortresult.sixtymonth.table.k_d.table=0;
sortresult.sixtymonth.table.obv.table=0;
sortresult.sixtymonth.table.bah.table=0;
%[ sortresult.sixtymonth.table ] = strategydemo_tech( sortresult.sixtymonth.rslt,para,rf );
[yes] = resultreport(sortresult,filename,'roc');
[yes] = resultreport(sortresult,filename,'ema');
[yes] = resultreport(sortresult,filename,'wma');
[yes] = resultreport(sortresult,filename,'s_r');
[yes] = resultreport(sortresult,filename,'macd');
[yes] = resultreport(sortresult,filename,'vma');
[yes] = resultreport(sortresult,filename,'k_d');
[yes] = resultreport(sortresult,filename,'obv');
filename = 'ma_result_5_10_1_0_aft2008.xls';% write in xls
%[ result ] = strategydemo_tech( futures_series,para,rf ); %% individual
% on sorted portfolios
sortresult=sortresult2;
[ sortresult.vlm.table ] = strategydemo_tech( sortresult.vlm.rslt,para,rf );
[ sortresult.openinst.table ] = strategydemo_tech( sortresult.openinst.rslt,para,rf );
[ sortresult.vltlt.table ] = strategydemo_tech( sortresult.vltlt.rslt,para,rf );
[ sortresult.lastmon.table ] = strategydemo_tech( sortresult.lastmon.rslt,para,rf );
[ sortresult.sixmonth.table ] = strategydemo_tech( sortresult.sixmonth.rslt,para,rf );
[ sortresult.sixtymonth.table ] = strategydemo_tech( sortresult.sixtymonth.rslt,para,rf );
[yes] = resultreport(sortresult,filename,'roc');
[yes] = resultreport(sortresult,filename,'ema');
[yes] = resultreport(sortresult,filename,'wma');
[yes] = resultreport(sortresult,filename,'s_r');
[yes] = resultreport(sortresult,filename,'macd');
[yes] = resultreport(sortresult,filename,'vma');
[yes] = resultreport(sortresult,filename,'k_d');
[yes] = resultreport(sortresult,filename,'obv');
%%
[ para ] = tubiao_boxplot1( sortresult,1,'roc' );
[ para ] = tubiao_boxplot2( sortresult,1,'roc' );
[ para ] = tubiao_boxplot3( sortresult,1,'roc' );
[ para ] = tubiao_boxplot1( sortresult,1,'wma' );
[ para ] = tubiao_boxplot2( sortresult,1,'wma' );
[ para ] = tubiao_boxplot3( sortresult,1,'wma' );
[ para ] = tubiao_boxplot1( sortresult,1,'ema' );
[ para ] = tubiao_boxplot2( sortresult,1,'ema' );
[ para ] = tubiao_boxplot3( sortresult,1,'ema' );
[ para ] = tubiao_boxplot1( sortresult,1,'macd' );
[ para ] = tubiao_boxplot2( sortresult,1,'macd' );
[ para ] = tubiao_boxplot3( sortresult,1,'macd' );
[ para ] = tubiao_boxplot1( sortresult,1,'vma' );
[ para ] = tubiao_boxplot2( sortresult,1,'vma' );
[ para ] = tubiao_boxplot3( sortresult,1,'vma' );
[ para ] = tubiao_boxplot1( sortresult,1,'s_r' );
[ para ] = tubiao_boxplot2( sortresult,1,'s_r' );
[ para ] = tubiao_boxplot3( sortresult,1,'s_r' );
[ para ] = tubiao_boxplot1( sortresult,1,'k_d' );
[ para ] = tubiao_boxplot2( sortresult,1,'k_d' );
[ para ] = tubiao_boxplot3( sortresult,1,'k_d' );
[ para ] = tubiao_boxplot1( sortresult,1,'obv' );
[ para ] = tubiao_boxplot2( sortresult,1,'obv' );
[ para ] = tubiao_boxplot3( sortresult,1,'obv' );
[ para ] = tubiao_boxplot1( sortresult,1,'bah' );
[ para ] = tubiao_boxplot2( sortresult,1,'bah' );
[ para ] = tubiao_boxplot3( sortresult,1,'bah' );

x=[sortresult.vlm.table.k_d.cum{1,1};sortresult.vlm.table.k_d.cum{2,1};sortresult.vlm.table.k_d.cum{3,1}];
y=[mktfactors;mktfactors;mktfactors];
scatter(x,y);


x=sortresult.vlm.table.wma.cum{1,1};
y=mktfactors;
scatter(x,y);


end


