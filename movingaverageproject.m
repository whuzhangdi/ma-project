function [ output_args ] = movingaverageproject( input_args )
% the main function to carry out the bah strtegy and the ma(n) strategy
%   change parameter can carry out robust test
%% data procession get the series data
[ data_allall, data_txtall,dataall] = dataread( );
[ futuresdata, ~ ] = futuressortbykind( data_allall, data_txtall,dataall);
%% parameter collection
%rf = 0.03;
load factors.mat;
lag = 0;
mapara = 5;
short = 0;% permit short:1, only long:0
year = 1;% year measure:1 month measure:0
%% protfolio construction individually
[num_f,~]=size(futuresdata);
[ futures_series,futuremark ] = portfolioconstruction( futuresdata, num_f,lag);%%  运行时间很长，30min
%% adjust the constructed portfolio
[ futures_series ] = adjustportfolio( futures_series );
%% carry out strategy: bah and ma(mapara)
%[ individualresult ] = strategydemo(futures_series,{mapara,short,year},rf);
%% compute daily volatility,daily trading volume,daily open interest,return,volatility,mom
[cellwithfactor]=factorcompute(futures_series,{6,60});
%% sort within month
sortresult.information=cellwithfactor;
[sortresult.vlm.vlm_mark]=sortportfolio1(cellwithfactor,5);%sort portfolio within month
[sortresult.openinst.openinst_mark]=sortportfolio1(cellwithfactor,6);
[sortresult.vltlt.vltlt_mark]=sortportfolio1(cellwithfactor,7);
%% sort over month
[ sortresult.lastmon.lastmon_mark ] = sortportfolio2( cellwithfactor,2);
[ sortresult.sixmonth.sixmonth_mark ] = sortportfolio2( cellwithfactor,3);
[ sortresult.sixtymonth.sixtymonth_mark ] = sortportfolio2( cellwithfactor,4);
%% construct portfolio with sort future contract
[sortresult.vlm.rslt]=reconstruction1(sortresult.information,sortresult.vlm.vlm_mark,3);
[sortresult.openinst.rslt]=reconstruction1(sortresult.information,sortresult.openinst.openinst_mark,3);
[sortresult.vltlt.rslt]=reconstruction1(sortresult.information,sortresult.vltlt.vltlt_mark,3);
[sortresult.lastmon.rslt]=reconstruction1(sortresult.information,sortresult.lastmon.lastmon_mark,3);
[sortresult.sixmonth.rslt]=reconstruction1(sortresult.information,sortresult.sixmonth.sixmonth_mark,3);
[sortresult.sixtymonth.rslt]=reconstruction1(sortresult.information,sortresult.sixtymonth.sixtymonth_mark,3);
%% carry out strategy on sorted portfolio  %% bah & ma(n)
[ sortresult.vlm.table ] = strategydemo(sortresult.vlm.rslt,{mapara,short,year},rf);
[ sortresult.openinst.table ] = strategydemo(sortresult.openinst.rslt,{mapara,short,year},rf);
[ sortresult.vltlt.table ] = strategydemo(sortresult.vltlt.rslt,{mapara,short,year},rf);
[ sortresult.lastmon.table ] = strategydemo(sortresult.lastmon.rslt,{mapara,short,year},rf);
[ sortresult.sixmonth.table ] = strategydemo(sortresult.sixmonth.rslt,{mapara,short,year},rf);
[ sortresult.sixtymonth.table ] = strategydemo(sortresult.sixtymonth.rslt,{mapara,short,year},rf);
%% fama-french alpha   % ma edition
%  attention the transaction of rf
[ regtable ] = famafrenchalpha( sortresult,factors,rf );
%% fama-french alpha on spread portfolio
[ regtablebeta,timingtab] = famafrenchalphactd2( sortresult,factors,rf );
%% average holding days,trading frenquency
%% construct portfolio with sort future contract %compute volume
[sortresult.vlm.rslt]=reconstruction2(sortresult.information,sortresult.vlm.vlm_mark,3,sortresult.vlm.rslt);
[sortresult.openinst.rslt]=reconstruction2(sortresult.information,sortresult.openinst.openinst_mark,3,sortresult.openinst.rslt);
[sortresult.vltlt.rslt]=reconstruction2(sortresult.information,sortresult.vltlt.vltlt_mark,3,sortresult.vltlt.rslt);
[sortresult.lastmon.rslt]=reconstruction2(sortresult.information,sortresult.lastmon.lastmon_mark,3,sortresult.lastmon.rslt);
[sortresult.sixmonth.rslt]=reconstruction2(sortresult.information,sortresult.sixmonth.sixmonth_mark,3,sortresult.sixmonth.rslt);
[sortresult.sixtymonth.rslt]=reconstruction2(sortresult.information,sortresult.sixtymonth.sixtymonth_mark,3,sortresult.sixtymonth.rslt);
%% carry out strategy on sorted portfolio %% roc wma ema vma macd s_r k_d obv 2 5  5 10  20 50  50 75
fma = 5; sma =10;year=1;short=0;
para ={fma, sma, year,short};% fma, sma, year,short
filename = 'ma_result_5_10_1_0.xls';% write in xls
%[ result ] = strategydemo_tech( futures_series,para,rf ); %% individual
% on sorted portfolios
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
%% futures market index construction  MKT is the market excess ruturn,saved in factors_new.mat
%[ marketindex,mktfactors,date_index ] = futuremarkrt_index(sortresult.information);
%% break the whole sample into two sub-period according to financial crisis
[sortresult1,sortresult2] = subperiod(sortresult);
%% extract all the month return series 
[mon_ret1] = extract1(sortresult);
[mon_ret2] = extract2(sortresult);
%% performance analysis
[alpha1,rsquare1,pvalue1,bta1,p_bta1] = capm_alpha(mon_ret1,mktfactors,rf);% capm
[alpha2,rsquare2,pvalue2,bta2,p_bta2] = capm_alpha(mon_ret2,mktfactors,rf);
[yes] = alphawrite([alpha1;alpha2],[rsquare1,rsquare2],[pvalue1,pvalue2],[bta1,bta2],[p_bta1,p_bta2],2);
[alpha1,rsquare1,pvalue1] = capm_alpha(mon_ret1,[mktfactors,],rf);% fama french 
[alpha2,rsquare2,pvalue2] = capm_alpha(mon_ret2,[mktfactors,],rf);
[yes] = alphawrite([alpha1;alpha2],[rsquare1,rsquare1],[pvalue1,pvalue1],3);
%% extract month data to mrslt
monpara = 5;  % [5/~5] [week/month]
[ sortresult.vlm.monrslt] = extractdata( sortresult.vlm.rslt,monpara);
[ sortresult.vltlt.monrslt] = extractdata( sortresult.vltlt.rslt,monpara);
[ sortresult.openinst.monrslt] = extractdata( sortresult.openinst.rslt,monpara);
[ sortresult.lastmon.monrslt] = extractdata( sortresult.lastmon.rslt,monpara);
[ sortresult.sixmonth.monrslt] = extractdata( sortresult.sixmonth.rslt,monpara);
[ sortresult.sixtymonth.monrslt] = extractdata( sortresult.sixtymonth.rslt,monpara);
%% carry out strategy on sorted portfolio by month frequency%% roc wma ema vma macd s_r k_d obv 2 5  5 10  20 50  50 75
fma = 2; sma =5;year=1;short=0;
para ={fma, sma, year,short};% fma, sma, year,short
filename = 'ma_result_5_10_1_1.xls';% write in xls
%[ result ] = strategydemo_tech( futures_series,para,rf ); %% individual
% on sorted portfolios
[ sortresult.vlm.table ] = strategydemo_tech( sortresult.vlm.monrslt,para,rf );
[ sortresult.openinst.table ] = strategydemo_tech( sortresult.openinst.monrslt,para,rf );
[ sortresult.vltlt.table ] = strategydemo_tech( sortresult.vltlt.monrslt,para,rf );
[ sortresult.lastmon.table ] = strategydemo_tech( sortresult.lastmon.monrslt,para,rf );
[ sortresult.sixmonth.table ] = strategydemo_tech( sortresult.sixmonth.monrslt,para,rf );
[ sortresult.sixtymonth.table ] = strategydemo_tech( sortresult.sixtymonth.monrslt,para,rf );
[yes] = resultreport(sortresult,filename,'roc');
[yes] = resultreport(sortresult,filename,'ema');
[yes] = resultreport(sortresult,filename,'wma');
[yes] = resultreport(sortresult,filename,'s_r');
[yes] = resultreport(sortresult,filename,'macd');
[yes] = resultreport(sortresult,filename,'vma');
[yes] = resultreport(sortresult,filename,'k_d');
[yes] = resultreport(sortresult,filename,'obv');
%% 1/n strategy
[sortresult.vlm.table.n_1]=naive_n(sortresult.vlm.table,rf,year);
[sortresult.vltlt.table.n_1]=naive_n(sortresult.vltlt.table,rf,year);
[sortresult.openinst.table.n_1]=naive_n(sortresult.openinst.table,rf,year);
[sortresult.lastmon.table.n_1]=naive_n(sortresult.lastmon.table,rf,year);
[sortresult.sixmonth.table.n_1]=naive_n(sortresult.sixmonth.table,rf,year);
[sortresult.sixtymonth.table.n_1]=naive_n(sortresult.sixtymonth.table,rf,year);
[yes] = resultreport(sortresult,filename,'n_1');
%% compare with the result with N A N(2014) paper
load 'beforestrategy_individual.mat';
load 'factors_new.mat';
[ result,analysisresult  ] = longandshort( futures_series,1,rf);
%% bootstraping 
[ bootstrap_result,mean,shpratio ] = bootstrap(sortresult,{5,10,1,0,1000});
[table,ptable] = auto_correlation(sortresult,10);
a.table=cell(1001,1);
a.ptable = cell(1001,1);
for i=1:1001
[a.table{i,1},a.ptable{i,1}] = auto_correlation(bootstrap_result{i,1},10);
end;

end

